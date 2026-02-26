Return-Path: <netdev+bounces-261584-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WFgED6StoGnDlgQAu9opvQ
	(envelope-from <netdev+bounces-261584-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 21:31:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D8461AF2A2
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 21:31:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E58E830D4F8D
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 20:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2297F466B59;
	Thu, 26 Feb 2026 20:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c1Mxwomz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4F14657E8
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 20:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772137514; cv=none; b=sxzECAbsinH9Li2V5Q0grVQWXD1oapGKRczWZv2E5rsYMIHVvLcN3/cgn+JgsRGJVhx608Icd4fATOfKDJ7y/xE1on76uf3yo0Dw6KKZvKEYS9I9SXX7pH1ItKPnHrmM3Y9mWh5ZTgeVo4n6nL4UXTUJjpIFgT4zQbx/UbY4diA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772137514; c=relaxed/simple;
	bh=o27oXpvDYmo+Hd3Ij7Vp1JsD82MPOMW7K0izYU/HSb8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P3EZVimUw1QH1vtHQ0MMv+yCjNEZuVSwpSpv9UX2BOVZ3xxyktrDGu+2lOvcbXLZmmvoWg9IPTIPb19ioO7GusSc4yc+aHUkdcGZDF9t++orOKFkH29q9NduLkqXKiKNhUjy8+LW0AxZkYLYn/3FBgAWpnHyfYoicvqbdbUWzNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c1Mxwomz; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-65f89c40547so3155776a12.1
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 12:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772137510; x=1772742310; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r+mozqxx0sXudTCUTXzQUXfn4TfviDBKZn5vV62DKS8=;
        b=c1MxwomztfbVpqAjOlG0baLrdiIIBTcIRS6Z7eVI5XTNjbAaYYNfKhEuRCaYcoIehI
         E71OM+vHt7Faj810Gz/PUyaQziHPU2QBO0pu0BXkm8yVu0T36XW+WUQVq72+owRKwIcQ
         BiN3iP7nIMDlHtEv8VoVS2a93X5cyWe3BltrDkyoS0CnJUNLYGTjOE/MFiadqsKlD3QB
         JuAyftVZztqZcc7VgGc9JpUyObTSaru5x9FdWkQPQMSKXDfYNcyxxgHH/1IpOt3m9Q//
         lguRJaYIN7L/eMQ5VqZXw4tdL9EZe1r/eBm3upeFJUOkdCTUaeZCv+5jM+3GI8QBppE4
         49+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772137510; x=1772742310;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r+mozqxx0sXudTCUTXzQUXfn4TfviDBKZn5vV62DKS8=;
        b=gDegs1PsGmyLnZ+z7Ng1CekRkMDyYvJ7HqkusGd2l5ft6NiFJBwxRf92tlha79Vj0n
         a08KuqoWD/9L+0ynB4biUahXe74Suj4bhYFtDyzsQe1jU4LhxponwVK0ZGyKncG+1Nu0
         wH/O4Xyk0cdhFTsuMKl5XQ+Zm1A23YLeZUO5C0g/8Wv5m1hfmIWHERSGg/ljr3+7pzdL
         ju41EJOpbf2Qlbqu5+CnPhJbuX2xfe2jD/Rv+V7MKmE98DYARmjJuIL3ccpY8D5FgrB9
         ew1LJixuAjpCb0ERHWDQHKenPLvOBM//QkZx/ojMdUeIFBCYJJzQ/IHaKnfJczy2xslH
         YbOg==
X-Forwarded-Encrypted: i=1; AJvYcCXNoL5ivGWXcbq75KqYTRilW+GW7huU++ghFF7O8Hilmk40McKnTxZT6unTNol4sE/Sj4e2bCc=@vger.kernel.org
X-Gm-Message-State: AOJu0YylTAksrAAb/ivK4BkT1CJk6tB60gduMmDCOgXnJn5KoWtZx3Nl
	37JLUv2tyRHKtuxkgeEPf587OYNkz/MfyZsdJcsPkzZAEZNyTOHtPCj8
X-Gm-Gg: ATEYQzzm4Jj11apwk8V7UEu5wyST2d1zQgkGgSmj3u0ddHkXJje0HkiPloLcDmUV9cY
	c1vpXIdYPupcKUcGykOOCWUa1nnOIHJlORsmPjoWRDLfLbwOo3u4VwRHMu4i+TGBkxJQGrNjPtN
	NiHhKx+yvXL+G8Iqrebbays0Iw/eNMW5zIDwlnmIBGG6gDHqrsZs76b+tq579TWFkgJmPb8xAAW
	gZ+rvhBHdLIAKriN1gLMQ3Af5iQEck5a9S7JLuKOMwQdsM6gzVjb5TddDQhSUbGwiRlzC7wObks
	1omsbSjzA4izuQ1EpJ8ughQqyFhgMork3z3vdQmdXGyd9/vNOYWhfQCmXnfGlM781RXyIwej3E6
	YVUOS7zdmvVpIkm5Mv/rfGBDx0y1o3Tn+KUxmBA2c/Axaz/gCCOiNpEyuywqCg2gj0Om8nfz/2A
	xHLz9LiXV93xZAD/09S5gdpzNdC7CbzabIn1NTVzMOSLnRGwOBkuQ=
X-Received: by 2002:a17:907:78e:b0:b8f:dec3:6606 with SMTP id a640c23a62f3a-b937595fe4bmr20263766b.23.1772137510071;
        Thu, 26 Feb 2026 12:25:10 -0800 (PST)
Received: from [192.168.33.7] ([89.151.31.85])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-b935aedd746sm84219466b.59.2026.02.26.12.25.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Feb 2026 12:25:09 -0800 (PST)
Message-ID: <ce4d9b7b-aaf6-4796-94fb-8c3d6a1dcd4d@gmail.com>
Date: Thu, 26 Feb 2026 21:24:59 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: dsa: b53: prevent standalone from trying to
 forward to other ports
To: Jonas Gorski <jonas.gorski@gmail.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250508091424.26870-1-jonas.gorski@gmail.com>
Content-Language: en-US
From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
In-Reply-To: <20250508091424.26870-1-jonas.gorski@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.10 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.56)[subject];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-261584-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,broadcom.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[zajec5@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8D8461AF2A2
X-Rspamd-Action: no action

W dniu 8.05.2025 o 11:14, Jonas Gorski pisze:
> When bridged ports and standalone ports share a VLAN, e.g. via VLAN
> uppers, or untagged traffic with a vlan unaware bridge, the ASIC will
> still try to forward traffic to known FDB entries on standalone ports.
> But since the port VLAN masks prevent forwarding to bridged ports, this
> traffic will be dropped.
> 
> This e.g. can be observed in the bridge_vlan_unaware ping tests, where
> this breaks pinging with learning on.
> 
> Work around this by enabling the simplified EAP mode on switches
> supporting it for standalone ports, which causes the ASIC to redirect
> traffic of unknown source MAC addresses to the CPU port.
> 
> Since standalone ports do not learn, there are no known source MAC
> addresses, so effectively this redirects all incoming traffic to the CPU
> port.

This change broke standalone ports (those not being part of bridge) on Northstar (BCM5301X) devices. We got reports from users about WAN ports on routers not working anymore:
https://github.com/openwrt/openwrt/issues/21187
https://github.com/openwrt/openwrt/issues/21349

Can you take another look at those changes, see if something me be wrong / missing?


> Fixes: ff39c2d68679 ("net: dsa: b53: Add bridge support")
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
> ---
>   drivers/net/dsa/b53/b53_common.c | 33 ++++++++++++++++++++++++++++++++
>   drivers/net/dsa/b53/b53_regs.h   | 14 ++++++++++++++
>   2 files changed, 47 insertions(+)
> 
> diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
> index 9eb39cfa5fb2..7216eb8f9493 100644
> --- a/drivers/net/dsa/b53/b53_common.c
> +++ b/drivers/net/dsa/b53/b53_common.c
> @@ -326,6 +326,26 @@ static void b53_get_vlan_entry(struct b53_device *dev, u16 vid,
>   	}
>   }
>   
> +static void b53_set_eap_mode(struct b53_device *dev, int port, int mode)
> +{
> +	u64 eap_conf;
> +
> +	if (is5325(dev) || is5365(dev) || dev->chip_id == BCM5389_DEVICE_ID)
> +		return;
> +
> +	b53_read64(dev, B53_EAP_PAGE, B53_PORT_EAP_CONF(port), &eap_conf);
> +
> +	if (is63xx(dev)) {
> +		eap_conf &= ~EAP_MODE_MASK_63XX;
> +		eap_conf |= (u64)mode << EAP_MODE_SHIFT_63XX;
> +	} else {
> +		eap_conf &= ~EAP_MODE_MASK;
> +		eap_conf |= (u64)mode << EAP_MODE_SHIFT;
> +	}
> +
> +	b53_write64(dev, B53_EAP_PAGE, B53_PORT_EAP_CONF(port), eap_conf);
> +}
> +
>   static void b53_set_forwarding(struct b53_device *dev, int enable)
>   {
>   	u8 mgmt;
> @@ -586,6 +606,13 @@ int b53_setup_port(struct dsa_switch *ds, int port)
>   	b53_port_set_mcast_flood(dev, port, true);
>   	b53_port_set_learning(dev, port, false);
>   
> +	/* Force all traffic to go to the CPU port to prevent the ASIC from
> +	 * trying to forward to bridged ports on matching FDB entries, then
> +	 * dropping frames because it isn't allowed to forward there.
> +	 */
> +	if (dsa_is_user_port(ds, port))
> +		b53_set_eap_mode(dev, port, EAP_MODE_SIMPLIFIED);
> +
>   	return 0;
>   }
>   EXPORT_SYMBOL(b53_setup_port);
> @@ -2042,6 +2069,9 @@ int b53_br_join(struct dsa_switch *ds, int port, struct dsa_bridge bridge,
>   		pvlan |= BIT(i);
>   	}
>   
> +	/* Disable redirection of unknown SA to the CPU port */
> +	b53_set_eap_mode(dev, port, EAP_MODE_BASIC);
> +
>   	/* Configure the local port VLAN control membership to include
>   	 * remote ports and update the local port bitmask
>   	 */
> @@ -2077,6 +2107,9 @@ void b53_br_leave(struct dsa_switch *ds, int port, struct dsa_bridge bridge)
>   			pvlan &= ~BIT(i);
>   	}
>   
> +	/* Enable redirection of unknown SA to the CPU port */
> +	b53_set_eap_mode(dev, port, EAP_MODE_SIMPLIFIED);
> +
>   	b53_write16(dev, B53_PVLAN_PAGE, B53_PVLAN_PORT_MASK(port), pvlan);
>   	dev->ports[port].vlan_ctl_mask = pvlan;
>   
> diff --git a/drivers/net/dsa/b53/b53_regs.h b/drivers/net/dsa/b53/b53_regs.h
> index bfbcb66bef66..5f7a0e5c5709 100644
> --- a/drivers/net/dsa/b53/b53_regs.h
> +++ b/drivers/net/dsa/b53/b53_regs.h
> @@ -50,6 +50,9 @@
>   /* Jumbo Frame Registers */
>   #define B53_JUMBO_PAGE			0x40
>   
> +/* EAP Registers */
> +#define B53_EAP_PAGE			0x42
> +
>   /* EEE Control Registers Page */
>   #define B53_EEE_PAGE			0x92
>   
> @@ -480,6 +483,17 @@
>   #define   JMS_MIN_SIZE			1518
>   #define   JMS_MAX_SIZE			9724
>   
> +/*************************************************************************
> + * EAP Page Registers
> + *************************************************************************/
> +#define B53_PORT_EAP_CONF(i)		(0x20 + 8 * (i))
> +#define  EAP_MODE_SHIFT			51
> +#define  EAP_MODE_SHIFT_63XX		50
> +#define  EAP_MODE_MASK			(0x3ull << EAP_MODE_SHIFT)
> +#define  EAP_MODE_MASK_63XX		(0x3ull << EAP_MODE_SHIFT_63XX)
> +#define  EAP_MODE_BASIC			0
> +#define  EAP_MODE_SIMPLIFIED		3
> +
>   /*************************************************************************
>    * EEE Configuration Page Registers
>    *************************************************************************/


