Return-Path: <netdev+bounces-15145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7772A745EE2
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 16:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CACA4280DCF
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 14:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CAC5EAFC;
	Mon,  3 Jul 2023 14:44:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2136DE55D
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 14:44:52 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57120171B;
	Mon,  3 Jul 2023 07:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=pteZzJsj4EYRrxGttSfyJ3QdTS0O5i9iUaaO/p8LKvQ=; b=VoZUdS8+3fD1nzIi+CDFXQNRUR
	ZyXLatUtPhLQQyPCUWnRDCVI85u+/ljrMWFNcVgGpu1eW1h1pmhLfz6Mc3kpoauCQxYmFSWGJa74J
	Bdtbd/riCPQ9ibHOcdVbeDqs2ljQAYfI87HrCgXUOVPQsbPeDrfwCdl70WeiAC2E1AL4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qGKmJ-000U8I-46; Mon, 03 Jul 2023 16:43:47 +0200
Date: Mon, 3 Jul 2023 16:43:47 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Matt Johnston <matt@codeconstruct.com.au>
Cc: linux-i3c@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jeremy Kerr <jk@codeconstruct.com.au>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH 3/3] mctp i3c: MCTP I3C driver
Message-ID: <8321002c-9b75-44da-9200-23d951148ae9@lunn.ch>
References: <20230703053048.275709-1-matt@codeconstruct.com.au>
 <20230703053048.275709-4-matt@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230703053048.275709-4-matt@codeconstruct.com.au>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> +#define MCTP_I3C_MAXBUF 65536
> +/* 48 bit Provisioned Id */
> +#define PID_SIZE 6
> +
> +/* 64 byte payload, 4 byte MCTP header */
> +static const int MCTP_I3C_MINMTU = 64 + 4;
> +/* One byte less to allow for the PEC */
> +static const int MCTP_I3C_MAXMTU = MCTP_I3C_MAXBUF - 1;
> +/* 4 byte MCTP header, no data, 1 byte PEC */
> +static const int MCTP_I3C_MINLEN = 4 + 1;

Why static const and not #define? It would also be normal for
variables to be lower case, to make it clear they are in fact
variables, not #defines.

> +struct mctp_i3c_bus {
> +	struct net_device *ndev;
> +
> +	struct task_struct *tx_thread;
> +	wait_queue_head_t tx_wq;
> +	/* tx_lock protects tx_skb and devs */
> +	spinlock_t tx_lock;
> +	/* Next skb to transmit */
> +	struct sk_buff *tx_skb;
> +	/* Scratch buffer for xmit */
> +	u8 tx_scratch[MCTP_I3C_MAXBUF];
> +
> +	/* Element of busdevs */
> +	struct list_head list;
> +
> +	/* Provisioned ID of our controller */
> +	u64 pid;
> +
> +	struct i3c_bus *bus;
> +	/* Head of mctp_i3c_device.list. Protected by busdevs_lock */
> +	struct list_head devs;
> +};
> +
> +struct mctp_i3c_device {
> +	struct i3c_device *i3c;
> +	struct mctp_i3c_bus *mbus;
> +	struct list_head list; /* Element of mctp_i3c_bus.devs */
> +
> +	/* Held while tx_thread is using this device */
> +	struct mutex lock;
> +
> +	/* Whether BCR indicates MDB is present in IBI */
> +	bool have_mdb;
> +	/* I3C dynamic address */
> +	u8 addr;
> +	/* Maximum read length */
> +	u16 mrl;
> +	/* Maximum write length */
> +	u16 mwl;
> +	/* Provisioned ID */
> +	u64 pid;
> +};

Since you have commented about most of the members of these
structures, you could use kerneldoc.

> +/* We synthesise a mac header using the Provisioned ID.
> + * Used to pass dest to mctp_i3c_start_xmit.
> + */
> +struct mctp_i3c_internal_hdr {
> +	u8 dest[PID_SIZE];
> +	u8 source[PID_SIZE];
> +} __packed;
> +
> +/* Returns the 48 bit Provisioned Id from an i3c_device_info.pid */
> +static void pid_to_addr(u64 pid, u8 addr[PID_SIZE])
> +{
> +	pid = cpu_to_be64(pid);
> +	memcpy(addr, ((u8 *)&pid) + 2, PID_SIZE);
> +}
> +
> +static u64 addr_to_pid(u8 addr[PID_SIZE])
> +{
> +	u64 pid = 0;
> +
> +	memcpy(((u8 *)&pid) + 2, addr, PID_SIZE);
> +	return be64_to_cpu(pid);
> +}

I don't know anything about MCTP. But Ethernet MAC addresses are also
48 bits. Could you make use of u64_to_ether_addr() and ether_addr_to_u64()?

> +static int mctp_i3c_setup(struct mctp_i3c_device *mi)
> +{
> +	const struct i3c_ibi_setup ibi = {
> +		.max_payload_len = 1,
> +		.num_slots = MCTP_I3C_IBI_SLOTS,
> +		.handler = mctp_i3c_ibi_handler,
> +	};
> +	bool ibi_set = false, ibi_enabled = false;
> +	struct i3c_device_info info;
> +	int rc;
> +
> +	i3c_device_get_info(mi->i3c, &info);
> +	mi->have_mdb = info.bcr & BIT(2);
> +	mi->addr = info.dyn_addr;
> +	mi->mwl = info.max_write_len;
> +	mi->mrl = info.max_read_len;
> +	mi->pid = info.pid;
> +
> +	rc = i3c_device_request_ibi(mi->i3c, &ibi);
> +	if (rc == 0) {
> +		ibi_set = true;
> +	} else if (rc == -ENOTSUPP) {

In networking, we try to avoid ENOTSUPP and use EOPNOTSUPP:

https://lore.kernel.org/netdev/20200511165319.2251678-1-kuba@kernel.org/


> +static int mctp_i3c_header_create(struct sk_buff *skb, struct net_device *dev,
> +				  unsigned short type, const void *daddr,
> +	   const void *saddr, unsigned int len)
> +{
> +	struct mctp_i3c_internal_hdr *ihdr;
> +
> +	skb_push(skb, sizeof(struct mctp_i3c_internal_hdr));
> +	skb_reset_mac_header(skb);
> +	ihdr = (void *)skb_mac_header(skb);
> +	memcpy(ihdr->dest, daddr, PID_SIZE);
> +	memcpy(ihdr->source, saddr, PID_SIZE);

ether_addr_copy() ?

> +/* Returns an ERR_PTR on failure */
> +static struct mctp_i3c_bus *mctp_i3c_bus_add(struct i3c_bus *bus)
> +__must_hold(&busdevs_lock)
> +{
> +	struct mctp_i3c_bus *mbus = NULL;
> +	struct net_device *ndev = NULL;
> +	u8 addr[PID_SIZE];
> +	char namebuf[IFNAMSIZ];
> +	int rc;
> +
> +	if (!mctp_i3c_is_mctp_controller(bus))
> +		return ERR_PTR(-ENOENT);
> +
> +	snprintf(namebuf, sizeof(namebuf), "mctpi3c%d", bus->id);
> +	ndev = alloc_netdev(sizeof(*mbus), namebuf, NET_NAME_ENUM, mctp_i3c_net_setup);
> +	if (!ndev) {
> +		pr_warn("No memory for %s\n", namebuf);

pr_ functions are not liked too much. Is there a struct device you can
use with dev_warn()?

    Andrew

