Return-Path: <netdev+bounces-263282-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WI1AB1b+pmk7bgAAu9opvQ
	(envelope-from <netdev+bounces-263282-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 16:29:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE3441F29F4
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 16:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 81BF930574B6
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 15:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59CC348C8CD;
	Tue,  3 Mar 2026 15:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="emGIHAq0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498D248A2CE
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 15:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772551636; cv=none; b=SpYQw48C24AdH/ia7TNkN4Ea7oWcl1apAWcAB5vu4SurFIOfCmt/neih9sypqVK3/Hpcne8vZo63QANNer3Xp5jiWoEjRlnv81H5Zj8KW3DcZHpu1Y0s8YfNmxL/+VDlS4z7HdMRUYWJl2kg0jliNaAsjEAhkdtH5Iv6bWig9jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772551636; c=relaxed/simple;
	bh=zRyKIaYOOdvmG28P4Uh3RDwPd5dApfVwAmCouxPGbGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SkExbKLNZKRJwWN0ObJh7/IlkqcazuuPDKXO4XlKUWIPEzTd7S11efYWT/Xoyak/ZLlnRtHYk+RvOvylKv8G3r7H+BhQ+b7QVUIicCq369+cE2+v0fk1hJtJPHXEZ7pSCkykOL+ZBPTBbDNYLHI5/5d3zgPK84i1wJQWo7fcfU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=emGIHAq0; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-439b3ae4a8eso156104f8f.3
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 07:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772551633; x=1773156433; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=n6ot4uYhfVKWexRgfYoEfAn0O34sAB3ydUfOEIAivbI=;
        b=emGIHAq0/iRi186v0PF9FFK0oJJpq2b3T0X1vNiHxn4JYz//gwbpokNw1Vm9IN2ziT
         WANjhF4bzADdB/VzKpkp+LC0kpI3NdKpg2rL1k0h91Q0k6K2AHJVwlrd/xEGyoMGveZX
         qBIHmAyAKQKwt40Xm70b4L6jX5mSAnTCCdIG8JEifUnCzUue/TLXAJjVVBMhSIv8pSqa
         GcdYjFm9xDUdy/bIeu4RVy7RL/ugFp2N3Vd0eBNSivd1LAKhy1OYA2fZTndsHYMMLdwh
         AGH4ypcgb+DqiovTTvhuWOL715NVlYxEsIuoLjB9gl9xMkPlghGvlb1EBtXFJXibYK7p
         VZZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772551633; x=1773156433;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n6ot4uYhfVKWexRgfYoEfAn0O34sAB3ydUfOEIAivbI=;
        b=hFuKIUyxdXnx6lUBR+cX2IY3oWHEjlJJPxAZP3uLtKI3mxitK7cLJG9GSYmarwhVqM
         p7kXTjF7ClW+/nu5GpEz0OG/5DNkc6Gun3sk1IZ7QGv+XjAqtR6s2fmIJc7pxbUFaquE
         kGizYI8u9I9JvAu8BTy837jOaq/qyW8ZK9/D8YoJfk2M6P8wm+vR5QyElrpKBaax7g+u
         AnATjSZAIGZDnPwHxalaPlP0VBiFHfTzdRdb1TVU5iUMqrN/BYtzvtiDuW34iCtxnx7g
         taE7XD2LZGBH144qrU1f0Eu6/HoPZUgod4FlnEhvAlaDj3Ar4ayLmdrqxFmpW9EA8htM
         E2+A==
X-Forwarded-Encrypted: i=1; AJvYcCW5gov6yeXpZAvCcHcYxoB1SigU/mKMxJcF9S+EqxDUl3lYmoIa4kh/2drmlING0BOx6rV5D/A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6fkHc8FxhG/srdMgdN9zY62QcxnKqXJNQGIltZCmpNhK9Rr/2
	AWZe7wI8a9e04bQsoM4u7mT19F3ADY97ZuWmVKBNgTpFnndbs1SQGqaz
X-Gm-Gg: ATEYQzzakRhlb3tnWb+ImWYUiQRIwefvTXj8SPtjD8OBwRe1YURk0Cwn5q5oqWh6x3z
	ti374zg7r3OOtYt6Y/sX/gBsg23hJQkofc4gdgcb/4ilEB++X6XeZHh82MO9qynN7KdjFrJSMIj
	yU+wPwOwprSjVUvSn7VXPt6/GV/An0CdoO8KURLSA7w3hufh9S+KtR8COcAlxkrwsZQCu6i1WF5
	fN3IXjqnpJfKAtVgo3NwswdCn6oXuL62y/ZTNBtUs8vkFzabwAZCtYBn2yB6h4jonOjBgEu+pXF
	N6xWZuVI7IbR80baE651ETqK1kof+gnTb06H6m6A/NN+iuzaaeHIIs0TMnBayW6FuyNm2kGbaqA
	9v0VmjTL0mn8HW8kfLrfAkWh4t599B6t/TKP2YlBAKbuWK1BJg7wO1XVukFXvDPOjMrTIMk+HZP
	69LwOXxko4LfSU5E0=
X-Received: by 2002:a05:6000:2001:b0:439:b4c9:9065 with SMTP id ffacd0b85a97d-439b4c991bdmr9082442f8f.6.1772551632367;
        Tue, 03 Mar 2026 07:27:12 -0800 (PST)
Received: from skbuf ([2a02:2f04:d00e:3600:2472:8e4a:cf12:bb30])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439b503425asm17657092f8f.25.2026.03.03.07.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 07:27:11 -0800 (PST)
Date: Tue, 3 Mar 2026 17:27:09 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Jens Emil Schulz =?utf-8?Q?=C3=98stergaard?= <jensemil.schulzostergaard@microchip.com>
Cc: UNGLinuxDriver@microchip.com, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Woojung Huh <woojung.huh@microchip.com>,
	Russell King <linux@armlinux.org.uk>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 7/8] net: dsa: lan9645x: add mac table
 integration
Message-ID: <20260303152709.nospd2qq3dju2tev@skbuf>
References: <20260303-dsa_lan9645x_switch_driver_base-v1-0-bff8ca1396f5@microchip.com>
 <20260303-dsa_lan9645x_switch_driver_base-v1-0-bff8ca1396f5@microchip.com>
 <20260303-dsa_lan9645x_switch_driver_base-v1-7-bff8ca1396f5@microchip.com>
 <20260303-dsa_lan9645x_switch_driver_base-v1-7-bff8ca1396f5@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260303-dsa_lan9645x_switch_driver_base-v1-7-bff8ca1396f5@microchip.com>
 <20260303-dsa_lan9645x_switch_driver_base-v1-7-bff8ca1396f5@microchip.com>
X-Rspamd-Queue-Id: EE3441F29F4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263282-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[olteanv@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,microchip.com:email]
X-Rspamd-Action: no action

On Tue, Mar 03, 2026 at 01:22:33PM +0100, Jens Emil Schulz Østergaard wrote:
> Add MAC table support, and dsa fdb callback integration. The mactable is
> keyed on (vid,mac) and each bucket has 4 slots. A mac table entry
> typically points to a PGID index, the first 9 of which represent a front
> port.
> 
> Mac table entries for L2 multicast will use a PGID containing a group
> port mask. For IP multicast entries in the mac table a trick us used,
> where the group port mask is packed into the MAC data, exploiting the
> fact that the top bits are fixed, and that the number of switch ports is
> small enough to fit in the redundant bits.
> 
> Therefore, we can avoid using sparse PGID resources for IP multicast
> entries in the mac table.
> 
> Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
> Signed-off-by: Jens Emil Schulz Østergaard <jensemil.schulzostergaard@microchip.com>
> ---
>  drivers/net/dsa/microchip/lan9645x/Makefile        |   1 +
>  drivers/net/dsa/microchip/lan9645x/lan9645x_mac.c  | 413 +++++++++++++++++++++
>  drivers/net/dsa/microchip/lan9645x/lan9645x_main.c | 110 +++++-
>  drivers/net/dsa/microchip/lan9645x/lan9645x_main.h |  48 +++
>  4 files changed, 571 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/dsa/microchip/lan9645x/Makefile b/drivers/net/dsa/microchip/lan9645x/Makefile
> index bb5eec14d225..a90a46f81c72 100644
> --- a/drivers/net/dsa/microchip/lan9645x/Makefile
> +++ b/drivers/net/dsa/microchip/lan9645x/Makefile
> @@ -6,3 +6,4 @@ mchp-lan9645x-objs := lan9645x_main.o \
>  	lan9645x_port.o \
>  	lan9645x_phylink.o \
>  	lan9645x_vlan.o \
> +	lan9645x_mac.o \

Is there some particular ordering here? Because it's surely not
alphabetical.

> diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_mac.c b/drivers/net/dsa/microchip/lan9645x/lan9645x_mac.c
> new file mode 100644
> index 000000000000..3226cff16e8c
> --- /dev/null
> +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_mac.c
> @@ -0,0 +1,413 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/* Copyright (C) 2026 Microchip Technology Inc.
> + */
> +
> +#include "lan9645x_main.h"
> +
> +#define LAN9645X_MAC_COLUMNS	4

Doesn't appear used.

> +
> +#define CMD_IDLE		0
> +#define CMD_LEARN		1
> +#define CMD_FORGET		2
> +#define CMD_AGE			3
> +#define CMD_GET_NEXT		4
> +#define CMD_INIT		5
> +#define CMD_READ		6
> +#define CMD_WRITE		7
> +#define CMD_SYNC_GET_NEXT	8
> +
> +#define LAN9645X_INVALID_ROW	(-1)
> +
> +static bool lan9645x_mact_entry_equal(struct lan9645x_mact_entry *entry,
> +				      const unsigned char *mac, u16 vid)
> +{
> +	/* The hardware table is keyed on (vid,mac) */
> +	return entry->common.key.vid == vid &&
> +		ether_addr_equal(mac, entry->common.key.mac);

Can you please align the "entry" with "ether_addr_equal".
I think there's more coding style inconsistencies of the same type in
the submission that I went over and omitted to comment on.

> +}
> +
> +static struct lan9645x_mact_entry *
> +lan9645x_mact_entry_find(struct lan9645x *lan9645x, const unsigned char *mac,
> +			 u16 vid)
> +{
> +	struct lan9645x_mact_entry *entry;
> +
> +	lockdep_assert_held(&lan9645x->mac_entry_lock);
> +
> +	list_for_each_entry(entry, &lan9645x->mac_entries, list)
> +		if (lan9645x_mact_entry_equal(entry, mac, vid))
> +			return entry;
> +
> +	return NULL;
> +}
> +
> +static struct lan9645x_mact_entry *
> +lan9645x_mact_entry_alloc(struct lan9645x *lan9645x, const unsigned char *mac,
> +			  u16 vid, u8 pgid, enum macaccess_entry_type type)
> +{
> +	struct lan9645x_mact_entry *entry;
> +
> +	entry = kzalloc_obj(*entry);
> +	if (!entry)
> +		return NULL;
> +
> +	INIT_LIST_HEAD(&entry->list);

This isn't needed on individual list elements, only on the head.

> +	ether_addr_copy(entry->common.key.mac, mac);
> +	entry->common.key.vid = vid;
> +	entry->common.pgid = pgid;
> +	entry->common.row = LAN9645X_INVALID_ROW;

Do you use the row for anything?

> +	entry->common.type = type;
> +
> +	dev_dbg(lan9645x->dev,
> +		"mact_entry_alloc mac=%pM vid=%u pgid=%u type=%d",
> +		entry->common.key.mac, entry->common.key.vid,
> +		entry->common.pgid, entry->common.type);
> +	return entry;
> +}
> +
> +static void lan9645x_mact_entry_dealloc(struct lan9645x *lan9645x,
> +					struct lan9645x_mact_entry *entry)
> +{
> +	if (!entry)
> +		return;
> +
> +	dev_dbg(lan9645x->dev,
> +		"mact_entry_dealloc mac=%pM vid=%u pgid=%u type=%d",
> +		entry->common.key.mac, entry->common.key.vid,
> +		entry->common.pgid, entry->common.type);
> +
> +	list_del(&entry->list);
> +	kfree(entry);
> +}
> +
> +static int lan9645x_mac_wait_for_completion(struct lan9645x *lan9645x,
> +					    u32 *maca)
> +{
> +	u32 val = 0;
> +	int err;
> +
> +	lockdep_assert_held(&lan9645x->mact_lock);
> +
> +	err = lan9645x_rd_poll_timeout(lan9645x, ANA_MACACCESS, val,
> +				       ANA_MACACCESS_MAC_TABLE_CMD_GET(val) ==
> +				       CMD_IDLE);
> +	if (err)
> +		return err;
> +
> +	if (maca)
> +		*maca = val;
> +
> +	return 0;
> +}
> +
> +static void lan9645x_mact_parse(u32 machi, u32 maclo, u32 maca,
> +				struct lan9645x_mact_common *rentry)
> +{
> +	u64 addr = ANA_MACHDATA_MACHDATA_GET(machi);
> +
> +	addr = addr << 32 | maclo;
> +	u64_to_ether_addr(addr, rentry->key.mac);
> +	rentry->key.vid = ANA_MACHDATA_VID_GET(machi);
> +	rentry->pgid = ANA_MACACCESS_DEST_IDX_GET(maca);
> +	rentry->type = ANA_MACACCESS_ENTRYTYPE_GET(maca);
> +}
> +
> +static void lan9645x_mac_select(struct lan9645x *lan9645x,
> +				const unsigned char *addr, u16 vid)
> +{
> +	u64 maddr = ether_addr_to_u64(addr);
> +
> +	lockdep_assert_held(&lan9645x->mact_lock);
> +
> +	lan_wr(ANA_MACHDATA_VID_SET(vid) |
> +	       ANA_MACHDATA_MACHDATA_SET(maddr >> 32),
> +	       lan9645x,
> +	       ANA_MACHDATA);
> +
> +	lan_wr(maddr & GENMASK(31, 0),
> +	       lan9645x,
> +	       ANA_MACLDATA);
> +}
> +
> +static int __lan9645x_mact_forget(struct lan9645x *lan9645x,
> +				  const unsigned char mac[ETH_ALEN],
> +				  unsigned int vid,
> +				  enum macaccess_entry_type type)
> +{
> +	lockdep_assert_held(&lan9645x->mact_lock);
> +
> +	lan9645x_mac_select(lan9645x, mac, vid);
> +
> +	lan_wr(ANA_MACACCESS_ENTRYTYPE_SET(type) |
> +	       ANA_MACACCESS_MAC_TABLE_CMD_SET(CMD_FORGET),
> +	       lan9645x,
> +	       ANA_MACACCESS);
> +
> +	return lan9645x_mac_wait_for_completion(lan9645x, NULL);
> +}
> +
> +int lan9645x_mact_forget(struct lan9645x *lan9645x,
> +			 const unsigned char mac[ETH_ALEN], unsigned int vid,
> +			 enum macaccess_entry_type type)
> +{
> +	int ret;

Inconsistent use of "err" and "ret" throughout the driver.
Pick one and stick to it.

> +
> +	mutex_lock(&lan9645x->mact_lock);
> +	ret = __lan9645x_mact_forget(lan9645x, mac, vid, type);
> +	mutex_unlock(&lan9645x->mact_lock);
> +
> +	return ret;
> +}
> +
> +static bool lan9645x_mac_ports_use_cpu(const unsigned char *mac,
> +				       enum macaccess_entry_type type)
> +{
> +	u32 mc_ports;
> +
> +	switch (type) {
> +	case ENTRYTYPE_MACV4:
> +		mc_ports = (mac[1] << 8) | mac[2];
> +		break;
> +	case ENTRYTYPE_MACV6:
> +		mc_ports = (mac[0] << 8) | mac[1];
> +		break;
> +	default:
> +		return false;
> +	}
> +
> +	return !!(mc_ports & BIT(CPU_PORT));
> +}
> +
> +static int __lan9645x_mact_learn_cpu_copy(struct lan9645x *lan9645x, int port,
> +					  const unsigned char *addr, u16 vid,
> +					  enum macaccess_entry_type type,
> +					  bool cpu_copy)
> +{
> +	lockdep_assert_held(&lan9645x->mact_lock);
> +
> +	lan9645x_mac_select(lan9645x, addr, vid);
> +
> +	lan_wr(ANA_MACACCESS_VALID_SET(1) |
> +	       ANA_MACACCESS_DEST_IDX_SET(port) |
> +	       ANA_MACACCESS_MAC_CPU_COPY_SET(cpu_copy) |
> +	       ANA_MACACCESS_ENTRYTYPE_SET(type) |
> +	       ANA_MACACCESS_MAC_TABLE_CMD_SET(CMD_LEARN),
> +	       lan9645x, ANA_MACACCESS);
> +
> +	return lan9645x_mac_wait_for_completion(lan9645x, NULL);
> +}
> +
> +static int __lan9645x_mact_learn(struct lan9645x *lan9645x, int port,
> +				 const unsigned char *addr, u16 vid,
> +				 enum macaccess_entry_type type)
> +{
> +	bool cpu_copy = lan9645x_mac_ports_use_cpu(addr, type);
> +
> +	return __lan9645x_mact_learn_cpu_copy(lan9645x, port, addr, vid, type,
> +					      cpu_copy);
> +}
> +
> +int lan9645x_mact_learn(struct lan9645x *lan9645x, int port,
> +			const unsigned char *addr, u16 vid,
> +			enum macaccess_entry_type type)
> +{
> +	int ret;
> +
> +	mutex_lock(&lan9645x->mact_lock);
> +	ret = __lan9645x_mact_learn(lan9645x, port, addr, vid, type);
> +	mutex_unlock(&lan9645x->mact_lock);
> +
> +	return ret;
> +}
> +
> +int lan9645x_mact_flush(struct lan9645x *lan9645x, int port)
> +{
> +	int err = 0;

This is overwritten with the lan9645x_mac_wait_for_completion() result
and never read. You don't need to zero-initialize it.

> +
> +	mutex_lock(&lan9645x->mact_lock);
> +	/* MAC table entries with dst index matching port are aged on scan. */
> +	lan_wr(ANA_ANAGEFIL_PID_EN_SET(1) |
> +	       ANA_ANAGEFIL_PID_VAL_SET(port),
> +	       lan9645x, ANA_ANAGEFIL);
> +
> +	/* Flushing requires two scans. First sets AGE_FLAG=1, second removes
> +	 * entries with AGE_FLAG=1.
> +	 */
> +	lan_wr(ANA_MACACCESS_MAC_TABLE_CMD_SET(CMD_AGE),
> +	       lan9645x,
> +	       ANA_MACACCESS);
> +
> +	err = lan9645x_mac_wait_for_completion(lan9645x, NULL);
> +	if (err)
> +		goto mact_unlock;
> +
> +	lan_wr(ANA_MACACCESS_MAC_TABLE_CMD_SET(CMD_AGE),
> +	       lan9645x,
> +	       ANA_MACACCESS);
> +
> +	err = lan9645x_mac_wait_for_completion(lan9645x, NULL);
> +
> +mact_unlock:
> +	lan_wr(0, lan9645x, ANA_ANAGEFIL);
> +	mutex_unlock(&lan9645x->mact_lock);
> +	return err;
> +}
> +
> +int lan9645x_mact_entry_add(struct lan9645x *lan9645x, int pgid,
> +			    const unsigned char *mac, u16 vid)
> +{
> +	struct lan9645x_mact_entry *entry;
> +	int ret = 0;
> +
> +	/* Users can not move (vid,mac) to a different port, without removing
> +	 * the original entry first. But we overwrite entry in HW, and update
> +	 * software pgid for good measure.
> +	 */
> +	mutex_lock(&lan9645x->mac_entry_lock);
> +	entry = lan9645x_mact_entry_find(lan9645x, mac, vid);
> +	if (entry) {
> +		entry->common.pgid = pgid;
> +		mutex_unlock(&lan9645x->mac_entry_lock);
> +		goto mac_learn;
> +	}
> +
> +	entry = lan9645x_mact_entry_alloc(lan9645x, mac, vid, pgid,
> +					  ENTRYTYPE_LOCKED);
> +	if (!entry) {
> +		mutex_unlock(&lan9645x->mac_entry_lock);
> +		return -ENOMEM;
> +	}
> +
> +	list_add_tail(&entry->list, &lan9645x->mac_entries);
> +	mutex_unlock(&lan9645x->mac_entry_lock);
> +
> +mac_learn:
> +	WARN_ON(entry->common.pgid != pgid);
> +	ret = lan9645x_mact_learn(lan9645x, pgid, mac, vid, ENTRYTYPE_LOCKED);

Same comment about multiple critical sections getting opened and closed.
It makes you wonder what can happen in between them. Any reason why you
don't call __lan9645x_mact_learn()?

> +	if (ret) {
> +		mutex_lock(&lan9645x->mac_entry_lock);
> +		lan9645x_mact_entry_dealloc(lan9645x, entry);
> +		mutex_unlock(&lan9645x->mac_entry_lock);
> +	}
> +	return ret;
> +}
> +
> +int lan9645x_mact_entry_del(struct lan9645x *lan9645x, int pgid,
> +			    const unsigned char *mac, u16 vid)
> +{
> +	struct lan9645x_mact_entry *entry;
> +
> +	mutex_lock(&lan9645x->mac_entry_lock);
> +	entry = lan9645x_mact_entry_find(lan9645x, mac, vid);
> +	if (entry) {
> +		WARN_ON(entry->common.pgid != pgid);
> +		lan9645x_mact_entry_dealloc(lan9645x, entry);
> +		mutex_unlock(&lan9645x->mac_entry_lock);
> +		goto forget;
> +	}
> +	mutex_unlock(&lan9645x->mac_entry_lock);
> +	return -ENOENT;
> +
> +forget:
> +	return lan9645x_mact_forget(lan9645x, mac, vid, ENTRYTYPE_LOCKED);

I don't understand why you release the mac_entry_lock just for
lan9645x_mact_forget() to acquire it again. Can't stuff happen in the
split second where the MAC table is unlocked? It seems at least more
straightforward to call __lan9645x_mact_forget() under the locked
section rather than do the jump.

And it also seems more straightforward to invert the branch where the
entry is found in the MAC table with the one where it isn't. This allows
the more complex code to be less indented.

> +}
> +
> +void lan9645x_mac_init(struct lan9645x *lan9645x)
> +{
> +	mutex_init(&lan9645x->mac_entry_lock);
> +	mutex_init(&lan9645x->mact_lock);
> +	mutex_init(&lan9645x->fwd_domain_lock);
> +	INIT_LIST_HEAD(&lan9645x->mac_entries);
> +
> +	/* Clear the MAC table */
> +	mutex_lock(&lan9645x->mact_lock);
> +	lan_wr(CMD_INIT, lan9645x, ANA_MACACCESS);
> +	lan9645x_mac_wait_for_completion(lan9645x, NULL);
> +	mutex_unlock(&lan9645x->mact_lock);

mutex_init() immediately followed by mutex_lock() is an antipattern.
mutex_init() is run from a context with no concurrent threads that can
acquire the lock.
mutex_lock() is run from a context where concurrent threads are possible.
The two put together are a logical inconsistency, it means acquiring the
lock is unnecessary.

> +}
> +
> +void lan9645x_mac_deinit(struct lan9645x *lan9645x)
> +{
> +	mutex_destroy(&lan9645x->mac_entry_lock);
> +	mutex_destroy(&lan9645x->mact_lock);
> +	mutex_destroy(&lan9645x->fwd_domain_lock);
> +}
> +
> +int lan9645x_mact_dsa_dump(struct lan9645x *lan9645x, int port,
> +			   dsa_fdb_dump_cb_t *cb, void *data)
> +{
> +	struct lan9645x_mact_entry entry = { 0 };

Just {}.
https://lore.kernel.org/netdev/20210810091238.GB1343@shell.armlinux.org.uk/

> +	u32 mach, macl, maca;
> +	int err = 0;
> +	u32 autoage;
> +
> +	mach = 0;
> +	macl = 0;

You have two choices.

You can fold these into their declaration: "u32 mach = 0, macl = 0, maca;",
_if_ you're going to write them as variables:
	lan_wr(mach, lan9645x, ANA_MACHDATA);
	lan_wr(macl, lan9645x, ANA_MACLDATA);

Or you can remove the initializer, which is overwritten by the first
variable assignment in the while (1) loop, without the variables ever
being read in the meantime.

> +	entry.common.type = ENTRYTYPE_NORMAL;
> +
> +	mutex_lock(&lan9645x->mact_lock);
> +
> +	/* The aging filter works both for aging scans and GET_NEXT table scans.
> +	 * With it, the HW table iteration only stops at entries matching our
> +	 * filter. Since DSA calls us for each port on a table dump, this helps
> +	 * avoid unnecessary work.

Nice. I think this is the first driver I see which doesn't do duplicated
work here. I vaguely remember testing this feature on Ocelot too, but it
didn't work.

> +	 *
> +	 * Disable automatic aging temporarily. First save current state.
> +	 */
> +	autoage = lan_rd(lan9645x, ANA_AUTOAGE);
> +
> +	/* Disable aging */
> +	lan_rmw(ANA_AUTOAGE_AGE_PERIOD_SET(0),
> +		ANA_AUTOAGE_AGE_PERIOD,
> +		lan9645x, ANA_AUTOAGE);
> +
> +	/* Setup filter on our port */
> +	lan_wr(ANA_ANAGEFIL_PID_EN_SET(1) |
> +	       ANA_ANAGEFIL_PID_VAL_SET(port),
> +	       lan9645x, ANA_ANAGEFIL);
> +
> +	lan_wr(0, lan9645x, ANA_MACHDATA);
> +	lan_wr(0, lan9645x, ANA_MACLDATA);
> +
> +	while (1) {
> +		/* NOTE: we rely on mach, macl and type being set correctly in
> +		 * the registers from previous round, vis a vis the GET_NEXT
> +		 * semantics, so locking entire loop is important.
> +		 */
> +		lan_wr(ANA_MACACCESS_MAC_TABLE_CMD_SET(CMD_GET_NEXT) |
> +		       ANA_MACACCESS_ENTRYTYPE_SET(entry.common.type),
> +		       lan9645x, ANA_MACACCESS);
> +
> +		if (lan9645x_mac_wait_for_completion(lan9645x, &maca))
> +			break;
> +
> +		if (ANA_MACACCESS_VALID_GET(maca) == 0)
> +			break;
> +
> +		mach = lan_rd(lan9645x, ANA_MACHDATA);
> +		macl = lan_rd(lan9645x, ANA_MACLDATA);
> +
> +		lan9645x_mact_parse(mach, macl, maca, &entry.common);
> +
> +		if (ANA_MACACCESS_DEST_IDX_GET(maca) == port &&
> +		    entry.common.type == ENTRYTYPE_NORMAL) {
> +			if (entry.common.key.vid > VLAN_MAX)
> +				entry.common.key.vid = 0;
> +
> +			err = cb(entry.common.key.mac, entry.common.key.vid,
> +				 false, data);
> +			if (err)
> +				break;
> +		}
> +	}
> +
> +	/* Remove aging filters and restore aging */
> +	lan_wr(0, lan9645x, ANA_ANAGEFIL);
> +	lan_rmw(ANA_AUTOAGE_AGE_PERIOD_SET(ANA_AUTOAGE_AGE_PERIOD_GET(autoage)),
> +		ANA_AUTOAGE_AGE_PERIOD,
> +		lan9645x, ANA_AUTOAGE);
> +
> +	mutex_unlock(&lan9645x->mact_lock);
> +
> +	return err;
> +}
> diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
> index 1c8f20452487..ba76279b4414 100644
> --- a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
> +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
> @@ -78,6 +78,7 @@ static void lan9645x_teardown(struct dsa_switch *ds)
>  
>  	debugfs_remove_recursive(lan9645x->debugfs_root);
>  	lan9645x_npi_port_deinit(lan9645x, lan9645x->npi);
> +	lan9645x_mac_deinit(lan9645x);
>  }
>  
>  static int lan9645x_change_mtu(struct dsa_switch *ds, int port, int new_mtu)
> @@ -171,8 +172,8 @@ static int lan9645x_setup(struct dsa_switch *ds)
>  		return err;
>  	}
>  
> -	mutex_init(&lan9645x->fwd_domain_lock);

Why did you have to move this to lan9645x_mac_init()? It has changed
position since the beginning of the series. Also, it isn't related to
the MAC table.

>  	lan9645x_vlan_init(lan9645x);
> +	lan9645x_mac_init(lan9645x);
>  
>  	/* Link Aggregation Mode: NETDEV_LAG_HASH_L2 */
>  	lan_wr(ANA_AGGR_CFG_AC_SMAC_ENA |

