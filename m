Return-Path: <netdev+bounces-297918-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Auu0CL89KmpplAMAu9opvQ
	(envelope-from <netdev+bounces-297918-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 06:46:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AAD4966E482
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 06:46:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=blackwall.org header.s=google header.b=hOENDNdr;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297918-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-297918-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1B891301067F
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 04:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C201F3093D3;
	Thu, 11 Jun 2026 04:46:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D9D2E7623
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 04:46:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781153211; cv=none; b=fvAVPm83Km99/+SiCForzp2OcIzlfC/IKwPbEw0xByV2X8y0U5Emh/nO9qBybg+z/afB5XtpZ/3YaMjIH9Cjw96qtvMWSPMjsNbzFTZc5P1LWy3xIoxZF3Nxv68+kr16jznYRgeKyJb1XMj2UfK/5MeTC63IuZg0uWFlDY5kZxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781153211; c=relaxed/simple;
	bh=v6Tvsh4WYQfv31HxAc9Dde933o1JqCaSfCB4614y+tY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SY0A+3OKLiBwMlj2HRgKlJ02NvUdCq9COUD7/I9yxy1So4I3B3cPwRMv3pDlXyDNb1v3GBiOAjayYefG1n01YIqIjTmQyx+lCnNu0VhPVPJwFZlmMTGYymUONWnoPO9IzKRKI74iJRCOdrGp3mMMIUKZXZ4xSIn1zRyPsiJJk20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=hOENDNdr; arc=none smtp.client-ip=209.85.128.44
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-490b8ac62baso3438295e9.0
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 21:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1781153208; x=1781758008; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/k2kYVMaetFly35gQsfQES2TDyE0H4E8pL9hUBctpN4=;
        b=hOENDNdrwWyF+k5JFn6ajcOxapXN/asg9I5PkmuQ/5711PXvCp+7yujgOikHZVMmhq
         GhUSpIrzehEwWrAKdynDs8RqfoVyHmUZ+Zb4BChNCz5KRjClAklo1qmTPowK2Ru5YShS
         YLz7i6C28OgI5KpU9NeCBFUPT0mG9VpUUYytWXnpzl+Tw3aXyWOmUD/QW9tVUv/UZNuV
         HQ7UZaZWb3Y04tKGZtRRz2ARvSGvH4vGILJ24vjgcES/Xwnm3A3y9oMa8ohtPtGKZsaW
         3b7QcwfYq0W8lJhEhmWBJtXMXpOcbZahlqMNavIStF+tAgMpr+9y3g1ud5FnCuQlBs8H
         TfbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781153208; x=1781758008;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/k2kYVMaetFly35gQsfQES2TDyE0H4E8pL9hUBctpN4=;
        b=jDQ+E+KwD153UtBR3Lof4F7LfPtRdPHjocVk3qFQZ355RwSseA7zR0Fj6QoGrOadu+
         sZkdc6YQUvYaEXLROXkySQwbt8X5PZ/OJbMHRfj7QnlOzVsXAHl3J+9V7GTRY1qIxyu/
         LwxRtHUUUjbKzLHDF8JZ+sGfIq+yoAORiCGH7p5THOLJGHC1LtmB/S8QH2O12CW5AoTp
         6Zf0itnCD19nqrQIJQff/v8We9T8K8fRjQ4MMhkP9G3T/Ar2zEEo/R1fQMtGuvj+QbVd
         PxRe4BM8r6Eg5aAR8KrpV3xAOmujx2ePXTA1DjgnOb3K7NoPQD//R1ib6dRIO5XARogG
         Ai8A==
X-Forwarded-Encrypted: i=1; AFNElJ+sZp297JHHiYiGszhwv1DCzJlrN96WwyYcX6mBmDi7vnTZTAhO+5bOUAaXv8f+Ik01rCfs4iI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3k/jFpQWVhllpVCvULXlee7gnm9aWf8NQUj0q4gFT2JlWStwK
	Y9hhIQisxxHVke0TIqdJkyZtW65q32phUYTC3teB5tboTcxoebqivX2cYCpLk8pAVqA=
X-Gm-Gg: Acq92OG5MCkWUitOwz+DHmgrtBE5+Z+ULPdJwg7OoGq1T+uWPwIyXXDVz6vnzMc/Jh5
	x6iyCnJG2hd/bCxipXbL3YS7HvwrRWD1ChmNze/5SEzVu/IdsW/gPtW2DW6qjgLnF+7xyF8S9K3
	fFvOz7iwei6LPHCRDcWfFrdWtcii9Az5oyGTKI5vsZIjOVIGd3PVpQQJaEMKeO7+6Mu7DOnF3UW
	KMrCwP4bWRfnLAenxZHjDmtu7GoWc4Dx5SxZ4PJLVHTbC5RR948xrg/3gMht5VMPeX78IY/lhjv
	2ZP3CRc7YCCKn1QxzcFSbRjj8L3M9DUzkNY5FMWmnXCN8rHIZmShpHdKP0d2wwT7DxAJPmV3FjQ
	/4fD5muaa3VLJ9A03NGEv+pRl2EUNwxGtcpl/yhJbFRNRcvJq3Z+lsxcWfVIFkX4ohlqg3AJ5nl
	GLtiHmPmTbvavlHNDxBRo60rq/htP6er4n81rBV1dpVUrwrg6GERljLskZ8GJv5Ptj
X-Received: by 2002:a05:600c:b93:b0:490:ad1e:1846 with SMTP id 5b1f17b1804b1-490e52e5240mr9028395e9.9.1781153207928;
        Wed, 10 Jun 2026 21:46:47 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490e2d0fb23sm30509405e9.15.2026.06.10.21.46.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2026 21:46:47 -0700 (PDT)
Message-ID: <da4de983-99cc-435f-b00c-3321444626ea@blackwall.org>
Date: Thu, 11 Jun 2026 07:46:46 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 1/5] bridge: use atomic ops to read/change
 p->flags in sysfs
Content-Language: en-US, bg
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20260610161836.1275531-1-edumazet@google.com>
 <20260610161836.1275531-2-edumazet@google.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260610161836.1275531-2-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[blackwall.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297918-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:idosch@nvidia.com,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[blackwall.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,vger.kernel.org,gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[razor@blackwall.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[blackwall.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[razor@blackwall.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,blackwall.org:dkim,blackwall.org:email,blackwall.org:mid,blackwall.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AAD4966E482

On 10/06/2026 19:18, Eric Dumazet wrote:
> Change net/bridge/br_sysfs_if.c to use atomic operations
> to read/change bits n p->flags.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>   net/bridge/br_sysfs_if.c | 61 ++++++++++++++++++++++------------------
>   1 file changed, 33 insertions(+), 28 deletions(-)
> 

One minor nit below if there's another version, otherwise:
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

> diff --git a/net/bridge/br_sysfs_if.c b/net/bridge/br_sysfs_if.c
> index 1923c004f0d2b746902f5b6de1bbb72f7f824125..738544901563f570355554f49b2b80cf962f8e71 100644
> --- a/net/bridge/br_sysfs_if.c
> +++ b/net/bridge/br_sysfs_if.c
> @@ -44,40 +44,45 @@ const struct brport_attribute brport_attr_##_name = { 	        \
>   	.store	= _store,					\
>   };
>   
> -#define BRPORT_ATTR_FLAG(_name, _mask)				\
> +#define BRPORT_ATTR_FLAG(_name, _bitnr)				\
>   static ssize_t show_##_name(struct net_bridge_port *p, char *buf) \
>   {								\
> -	return sysfs_emit(buf, "%d\n", !!(p->flags & _mask));	\
> +	return sysfs_emit(buf, "%d\n", test_bit(_bitnr, &p->flags));	\
>   }								\
>   static int store_##_name(struct net_bridge_port *p, unsigned long v) \
>   {								\
> -	return store_flag(p, v, _mask);				\
> +	return store_flag(p, v, _bitnr);				\
>   }								\
>   static BRPORT_ATTR(_name, 0644,					\
>   		   show_##_name, store_##_name)
>   
>   static int store_flag(struct net_bridge_port *p, unsigned long v,
> -		      unsigned long mask)
> +		      unsigned long bitnr)
>   {
> +	unsigned long oflags, flags = READ_ONCE(p->flags);
>   	struct netlink_ext_ack extack = {0};
> -	unsigned long flags = p->flags;
>   	int err;
>   
> +

this extra new line seems unnecessary, there's already one

> +	oflags = flags;
>   	if (v)
> -		flags |= mask;
> +		__set_bit(bitnr, &flags);
>   	else
> -		flags &= ~mask;
> +		__clear_bit(bitnr, &flags);
>   
> -	if (flags != p->flags) {
> -		err = br_switchdev_set_port_flag(p, flags, mask, &extack);
> -		if (err) {
> -			netdev_err(p->dev, "%s\n", extack._msg);
> -			return err;
> -		}
> +	if (flags == oflags)
> +		return 0;
>   
> -		p->flags = flags;
> -		br_port_flags_change(p, mask);
> +	err = br_switchdev_set_port_flag(p, flags, BIT(bitnr), &extack);
> +	if (err) {
> +		netdev_err(p->dev, "%s\n", extack._msg);
> +		return err;
>   	}
> +	if (v)
> +		set_bit(bitnr, &p->flags);
> +	else
> +		clear_bit(bitnr, &p->flags);
> +	br_port_flags_change(p, BIT(bitnr));
>   	return 0;
>   }
>   
> @@ -247,17 +252,17 @@ static int store_backup_port(struct net_bridge_port *p, char *buf)
>   }
>   static BRPORT_ATTR_RAW(backup_port, 0644, show_backup_port, store_backup_port);
>   
> -BRPORT_ATTR_FLAG(hairpin_mode, BR_HAIRPIN_MODE);
> -BRPORT_ATTR_FLAG(bpdu_guard, BR_BPDU_GUARD);
> -BRPORT_ATTR_FLAG(root_block, BR_ROOT_BLOCK);
> -BRPORT_ATTR_FLAG(learning, BR_LEARNING);
> -BRPORT_ATTR_FLAG(unicast_flood, BR_FLOOD);
> -BRPORT_ATTR_FLAG(proxyarp, BR_PROXYARP);
> -BRPORT_ATTR_FLAG(proxyarp_wifi, BR_PROXYARP_WIFI);
> -BRPORT_ATTR_FLAG(multicast_flood, BR_MCAST_FLOOD);
> -BRPORT_ATTR_FLAG(broadcast_flood, BR_BCAST_FLOOD);
> -BRPORT_ATTR_FLAG(neigh_suppress, BR_NEIGH_SUPPRESS);
> -BRPORT_ATTR_FLAG(isolated, BR_ISOLATED);
> +BRPORT_ATTR_FLAG(hairpin_mode, BR_HAIRPIN_MODE_BIT);
> +BRPORT_ATTR_FLAG(bpdu_guard, BR_BPDU_GUARD_BIT);
> +BRPORT_ATTR_FLAG(root_block, BR_ROOT_BLOCK_BIT);
> +BRPORT_ATTR_FLAG(learning, BR_LEARNING_BIT);
> +BRPORT_ATTR_FLAG(unicast_flood, BR_FLOOD_BIT);
> +BRPORT_ATTR_FLAG(proxyarp, BR_PROXYARP_BIT);
> +BRPORT_ATTR_FLAG(proxyarp_wifi, BR_PROXYARP_WIFI_BIT);
> +BRPORT_ATTR_FLAG(multicast_flood, BR_MCAST_FLOOD_BIT);
> +BRPORT_ATTR_FLAG(broadcast_flood, BR_BCAST_FLOOD_BIT);
> +BRPORT_ATTR_FLAG(neigh_suppress, BR_NEIGH_SUPPRESS_BIT);
> +BRPORT_ATTR_FLAG(isolated, BR_ISOLATED_BIT);
>   
>   #ifdef CONFIG_BRIDGE_IGMP_SNOOPING
>   static ssize_t show_multicast_router(struct net_bridge_port *p, char *buf)
> @@ -273,8 +278,8 @@ static int store_multicast_router(struct net_bridge_port *p,
>   static BRPORT_ATTR(multicast_router, 0644, show_multicast_router,
>   		   store_multicast_router);
>   
> -BRPORT_ATTR_FLAG(multicast_fast_leave, BR_MULTICAST_FAST_LEAVE);
> -BRPORT_ATTR_FLAG(multicast_to_unicast, BR_MULTICAST_TO_UNICAST);
> +BRPORT_ATTR_FLAG(multicast_fast_leave, BR_MULTICAST_FAST_LEAVE_BIT);
> +BRPORT_ATTR_FLAG(multicast_to_unicast, BR_MULTICAST_TO_UNICAST_BIT);
>   #endif
>   
>   static const struct brport_attribute *brport_attrs[] = {


