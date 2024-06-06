Return-Path: <netdev+bounces-101307-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D450E8FE19B
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 10:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE00E1C20E81
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 08:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 444ED13D521;
	Thu,  6 Jun 2024 08:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BUpI2OBC"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CE613CA97
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 08:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717663869; cv=none; b=N/piyLMCA8nSBj0cjtDWbFEZICGSaFwkrUqTyd0hTxFMizFlMn1f0InG/PpS2o8/Ck2Lc7njVRiKL029yvK3D6C2Q7m7uRiw/x0qvgocPChWq0GuE6MuX9idQ6hLKx7Ln0zUtmlxnFEWszrmPZDNQrryMMjv2MjlFduUwjtfkB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717663869; c=relaxed/simple;
	bh=TFSbATPmebpuP2bR539uiM0+hjJ0146cll+cxhdq0hU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Pf0cLH4fbm9kRczk/jEEIObowA6a9U4aleQ8kAcG79UI+lGBOTA4Tm1wnBb7EKQQwqKaflmjO5407BkcrnbEz1VMoTrLMuc6ll/B75RudMkM82Lg/qrbFWmEurnrvx7plIVMIFOHDO+orWZplPKIEMQpFg+Fwg4r7W95uSF0zh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BUpI2OBC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717663866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=vdPrLiuvgF40hw2ph4ky+Dm5Z/cv/SLXir6p9KYzpaI=;
	b=BUpI2OBCxocCp4BPpo9HL13PkI0olqSHO70Dnw11xhspj7+3y4sgFbWzQxey0/cq4mQHJ8
	BMd+EIN3PWOvTnwGybz7f4DkPq2duRdLgsQnWtwzrzadp9PDfQ3hBDE/XeFaI30ClvH3mn
	EJxEKccKu102nvttCD7UugKrtZKDxwc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-mxOrz254M3KQNNJnmnpqxA-1; Thu, 06 Jun 2024 04:51:04 -0400
X-MC-Unique: mxOrz254M3KQNNJnmnpqxA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4215ee79896so196165e9.0
        for <netdev@vger.kernel.org>; Thu, 06 Jun 2024 01:51:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717663863; x=1718268663;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vdPrLiuvgF40hw2ph4ky+Dm5Z/cv/SLXir6p9KYzpaI=;
        b=iOsFhgXfzXOSA4nmsiX6jnFSXa9StF2bcRhKPfyGhvrVDtSgNPqtSOe2mWKkbu4FhW
         Zt93B54I2IRjHpInqh/RdxBJJKeNI0BIO9RNojV+1Tp+05uEsDjm+uE/r+A0zJ9HF90s
         hXJf0Bt85NzNup5Iy0qbt7RkigseZO9UwD+/WGzMNKBccKKzN7K5Ne0xkzzyYiyL9Hwh
         wPnO3GHvB+EhLD3eznJ/CMZwlVPPspiFtUfJq7A1v7pqw3m+Fow4iioTgjhUnBns61kM
         Sz/CCNPvoHCkdRt9rsaKAemhWZgmPlMrvpTCJ1WkFNkBAnSGZrLu/Pyqe7vcVTEtF+sw
         z5xg==
X-Forwarded-Encrypted: i=1; AJvYcCVYJuaZyqrFEhyQjNA22wZsimeGAe8ZonRnrH0m1mM2FsVG30qzKnxKFtgHmM7VdoPDO2t2K3y4dpSrU3CyfUvDas+oupnH
X-Gm-Message-State: AOJu0Yxom54BwIuLsFxOkyejrZlBPMy/V+OxHaajUrtT1AMFkqiCtM2G
	ywvwudZmUrljtePlyOrbZXPXINgXwrU7z7pLPMMf400k1l0mRkXcIiXFOaL0x6byTS2ArhoMol1
	b8TRgHsVAfyH933U42DojePDy9CAfbdEPf+afEXUVmPZyhlnVwKMksQ==
X-Received: by 2002:a05:600c:138c:b0:421:2aea:b479 with SMTP id 5b1f17b1804b1-4215635b96emr37911165e9.4.1717663863453;
        Thu, 06 Jun 2024 01:51:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8s8yZmXzKDQSPCBrtCVu/3/bL08d+OMP9LznsQgb/Zj0mLu7ZjOjLPan5c8CCbpBCqAjvHw==
X-Received: by 2002:a05:600c:138c:b0:421:2aea:b479 with SMTP id 5b1f17b1804b1-4215635b96emr37910875e9.4.1717663862478;
        Thu, 06 Jun 2024 01:51:02 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3344:1b74:3a10::f71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215c364bcdsm13731365e9.19.2024.06.06.01.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 01:51:02 -0700 (PDT)
Message-ID: <e962a2e2ba7856a6e5282238819637204feed2ba.camel@redhat.com>
Subject: Re: [PATCH v2 net-next] net: hsr: Send supervisory frames to HSR
 network with ProxyNodeTable data
From: Paolo Abeni <pabeni@redhat.com>
To: Lukasz Majewski <lukma@denx.de>, Jakub Kicinski <kuba@kernel.org>, 
	netdev@vger.kernel.org, Wojciech Drewek <wojciech.drewek@intel.com>
Cc: Eric Dumazet <edumazet@google.com>, Vladimir Oltean <olteanv@gmail.com>,
  "David S. Miller" <davem@davemloft.net>, Oleksij Rempel
 <o.rempel@pengutronix.de>, Tristram.Ha@microchip.com,  Sebastian Andrzej
 Siewior <bigeasy@linutronix.de>, Ravi Gunasekaran <r-gunasekaran@ti.com>,
 Simon Horman <horms@kernel.org>, Nikita Zhandarovich
 <n.zhandarovich@fintech.ru>, Murali Karicheri <m-karicheri2@ti.com>, Arvid
 Brodin <Arvid.Brodin@xdin.com>, Dan Carpenter <dan.carpenter@linaro.org>,
 "Ricardo B. Marliere" <ricardo@marliere.net>,  Casper Andersson
 <casper.casan@gmail.com>, linux-kernel@vger.kernel.org, Hangbin Liu
 <liuhangbin@gmail.com>,  Geliang Tang <tanggeliang@kylinos.cn>, Shuah Khan
 <shuah@kernel.org>, Shigeru Yoshida <syoshida@redhat.com>
Date: Thu, 06 Jun 2024 10:51:00 +0200
In-Reply-To: <20240604084348.3259917-1-lukma@denx.de>
References: <20240604084348.3259917-1-lukma@denx.de>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-06-04 at 10:43 +0200, Lukasz Majewski wrote:
> This patch provides support for sending supervision HSR frames with
> MAC addresses stored in ProxyNodeTable when RedBox (i.e. HSR-SAN) is
> enabled.
>=20
> Supervision frames with RedBox MAC address (appended as second TLV)
> are only send for ProxyNodeTable nodes.
>=20
> This patch series shall be tested with hsr_redbox.sh script.

I don't see any specific check for mac addresses in hsr_redbox.sh, am I
missing something? Otherwise please update the self-tests, too.

>=20
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> ---
>=20
> Changes for v2:
> - Fix the Reverse Christmas Tree formatting
> - Return directly values from hsr_is_node_in_db() and ether_addr_equal()
> - Change the internal variable check
> ---
>  net/hsr/hsr_device.c   | 63 ++++++++++++++++++++++++++++++++++--------
>  net/hsr/hsr_forward.c  | 37 +++++++++++++++++++++++--
>  net/hsr/hsr_framereg.c | 12 ++++++++
>  net/hsr/hsr_framereg.h |  2 ++
>  net/hsr/hsr_main.h     |  4 ++-
>  net/hsr/hsr_netlink.c  |  1 +
>  6 files changed, 105 insertions(+), 14 deletions(-)
>=20
> diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
> index e6904288d40d..ad7cb9b29273 100644
> --- a/net/hsr/hsr_device.c
> +++ b/net/hsr/hsr_device.c
> @@ -73,9 +73,15 @@ static void hsr_check_announce(struct net_device *hsr_=
dev)
>  			mod_timer(&hsr->announce_timer, jiffies +
>  				  msecs_to_jiffies(HSR_ANNOUNCE_INTERVAL));
>  		}
> +
> +		if (hsr->redbox && !timer_pending(&hsr->announce_proxy_timer))
> +			mod_timer(&hsr->announce_proxy_timer, jiffies +
> +				  msecs_to_jiffies(HSR_ANNOUNCE_INTERVAL) / 2);
>  	} else {
>  		/* Deactivate the announce timer  */
>  		timer_delete(&hsr->announce_timer);
> +		if (hsr->redbox)
> +			timer_delete(&hsr->announce_proxy_timer);
>  	}
>  }
> =20
> @@ -279,10 +285,11 @@ static struct sk_buff *hsr_init_skb(struct hsr_port=
 *master)
>  	return NULL;
>  }
> =20
> -static void send_hsr_supervision_frame(struct hsr_port *master,
> -				       unsigned long *interval)
> +static void send_hsr_supervision_frame(struct hsr_port *port,
> +				       unsigned long *interval,
> +				       const unsigned char addr[ETH_ALEN])

please use 'const unsigned char *addr' instead. The above syntax is
misleading

>  {
> -	struct hsr_priv *hsr =3D master->hsr;
> +	struct hsr_priv *hsr =3D port->hsr;
>  	__u8 type =3D HSR_TLV_LIFE_CHECK;
>  	struct hsr_sup_payload *hsr_sp;
>  	struct hsr_sup_tlv *hsr_stlv;

[...]

> @@ -340,13 +348,14 @@ static void send_hsr_supervision_frame(struct hsr_p=
ort *master,
>  		return;
>  	}
> =20
> -	hsr_forward_skb(skb, master);
> +	hsr_forward_skb(skb, port);
>  	spin_unlock_bh(&hsr->seqnr_lock);
>  	return;
>  }
> =20
>  static void send_prp_supervision_frame(struct hsr_port *master,
> -				       unsigned long *interval)
> +				       unsigned long *interval,
> +				       const unsigned char addr[ETH_ALEN])

Same here.

>  {
>  	struct hsr_priv *hsr =3D master->hsr;
>  	struct hsr_sup_payload *hsr_sp;
> @@ -396,7 +405,7 @@ static void hsr_announce(struct timer_list *t)
> =20
>  	rcu_read_lock();
>  	master =3D hsr_port_get_hsr(hsr, HSR_PT_MASTER);
> -	hsr->proto_ops->send_sv_frame(master, &interval);
> +	hsr->proto_ops->send_sv_frame(master, &interval, master->dev->dev_addr)=
;
> =20
>  	if (is_admin_up(master->dev))
>  		mod_timer(&hsr->announce_timer, jiffies + interval);
> @@ -404,6 +413,37 @@ static void hsr_announce(struct timer_list *t)
>  	rcu_read_unlock();
>  }
> =20
> +/* Announce (supervision frame) timer function for RedBox
> + */
> +static void hsr_proxy_announce(struct timer_list *t)
> +{
> +	struct hsr_priv *hsr =3D from_timer(hsr, t, announce_proxy_timer);
> +	struct hsr_port *interlink;
> +	unsigned long interval =3D 0;
> +	struct hsr_node *node;
> +
> +	rcu_read_lock();
> +	/* RedBOX sends supervisory frames to HSR network with MAC addresses
> +	 * of SAN nodes stored in ProxyNodeTable.
> +	 */
> +	interlink =3D hsr_port_get_hsr(hsr, HSR_PT_INTERLINK);
> +	list_for_each_entry_rcu(node, &hsr->proxy_node_db, mac_list) {
> +		if (hsr_addr_is_redbox(hsr, node->macaddress_A))
> +			continue;
> +		hsr->proto_ops->send_sv_frame(interlink, &interval,
> +					      node->macaddress_A);
> +	}
> +
> +	if (is_admin_up(interlink->dev)) {
> +		if (!interval)
> +			interval =3D msecs_to_jiffies(HSR_ANNOUNCE_INTERVAL);
> +
> +		mod_timer(&hsr->announce_proxy_timer, jiffies + interval);
> +	}
> +
> +	rcu_read_unlock();
> +}
> +
>  void hsr_del_ports(struct hsr_priv *hsr)
>  {
>  	struct hsr_port *port;
> @@ -590,6 +630,7 @@ int hsr_dev_finalize(struct net_device *hsr_dev, stru=
ct net_device *slave[2],
>  	timer_setup(&hsr->announce_timer, hsr_announce, 0);
>  	timer_setup(&hsr->prune_timer, hsr_prune_nodes, 0);
>  	timer_setup(&hsr->prune_proxy_timer, hsr_prune_proxy_nodes, 0);
> +	timer_setup(&hsr->announce_proxy_timer, hsr_proxy_announce, 0);
> =20
>  	ether_addr_copy(hsr->sup_multicast_addr, def_multicast_addr);
>  	hsr->sup_multicast_addr[ETH_ALEN - 1] =3D multicast_spec;
> diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
> index 05a61b8286ec..003070dbfcb4 100644
> --- a/net/hsr/hsr_forward.c
> +++ b/net/hsr/hsr_forward.c
> @@ -117,6 +117,35 @@ static bool is_supervision_frame(struct hsr_priv *hs=
r, struct sk_buff *skb)
>  	return true;
>  }
> =20
> +static bool is_proxy_supervision_frame(struct hsr_priv *hsr,
> +				       struct sk_buff *skb)
> +{
> +	struct hsr_sup_payload *payload;
> +	struct ethhdr *eth_hdr;
> +	u16 total_length =3D 0;
> +
> +	eth_hdr =3D (struct ethhdr *)skb_mac_header(skb);
> +
> +	/* Get the HSR protocol revision. */
> +	if (eth_hdr->h_proto =3D=3D htons(ETH_P_HSR))
> +		total_length =3D sizeof(struct hsrv1_ethhdr_sp);
> +	else
> +		total_length =3D sizeof(struct hsrv0_ethhdr_sp);
> +
> +	if (!pskb_may_pull(skb, total_length))

It looks like 'total_length' does not include 'sizeof hsr_sup_payload'?

> +		return false;
> +
> +	skb_pull(skb, total_length);
> +	payload =3D (struct hsr_sup_payload *)skb->data;
> +	skb_push(skb, total_length);

No need to actually pull the data, you could do directly:

	payload =3D (struct hsr_sup_payload *)skb->data[total_length];



Thanks,

Paolo


