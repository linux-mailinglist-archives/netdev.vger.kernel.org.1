Return-Path: <netdev+bounces-257816-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id dIbfMc9giGlcpAQAu9opvQ
	(envelope-from <netdev+bounces-257816-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 08 Feb 2026 11:09:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 421E510852E
	for <lists+netdev@lfdr.de>; Sun, 08 Feb 2026 11:09:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DFC713006B36
	for <lists+netdev@lfdr.de>; Sun,  8 Feb 2026 10:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4AB33D6FA;
	Sun,  8 Feb 2026 10:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L5JMmIIu";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZkLSGVm+"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C341C33BBC6
	for <netdev@vger.kernel.org>; Sun,  8 Feb 2026 10:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770545345; cv=none; b=MLlcW7V7/XpmUsT8MUSYboLZzIK4wqZdFsN3silB1KuG+dDo3OkzGCS2t+R5LGrGIwirU2XcYoMg81v80C9xjOGwFpNBlGyxHUO3JbVdb6vKvbnsoacam+DmtbNEbKwvwSIlg7bJngctx1qOw4PT+Iaku0vx8O57Ld51F23+nTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770545345; c=relaxed/simple;
	bh=24CNzPhFld1ZXJkgrJO/l4oQ/ugW1VWQRdsWzt3JY9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hRuThHaeReyULXy6nSEIUS0HHH0D5H8VtHM1CqE8ZOhFgC3sFF6xOkp/AlWrZGMNHVk+GS+Gt2wMeMHvLEYWFjx89qavPAGHMUZZVZQ5+5M9//GAgF9i+Tgv6bkM1xan/iJ9UywVCpspjgekzPUKIRNb8bpvKZEkRqy48rP7hEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L5JMmIIu; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZkLSGVm+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770545343;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rfuh2plodm8DQ54d7nVZcVI6X16Jjo175gNLcwSIUvA=;
	b=L5JMmIIuaPsSH9wBuyLEU+frrKwCME4f3dZFDfN1xT3pKUETkyn9HI3r1oa8sZ4Exf+3oF
	IIb4rczjyfGv/Msk9Pq79NK3H3xleOr1my+bMzOicPYAec+m1rpHkTpCcYkaumf52XQiBU
	oSznctRPTiGAa4GduhqovENDpS1AgQ4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-381-PHfyAWbqMGiMm9xPesBXSg-1; Sun, 08 Feb 2026 05:09:02 -0500
X-MC-Unique: PHfyAWbqMGiMm9xPesBXSg-1
X-Mimecast-MFC-AGG-ID: PHfyAWbqMGiMm9xPesBXSg_1770545341
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-4362197d1easo3487900f8f.2
        for <netdev@vger.kernel.org>; Sun, 08 Feb 2026 02:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770545341; x=1771150141; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rfuh2plodm8DQ54d7nVZcVI6X16Jjo175gNLcwSIUvA=;
        b=ZkLSGVm+cuwb6CglBWbaKXAzvMuwH3BewKYxyKIrKYZvhj2RAaAj10u3dxVyE4LiM1
         rMWXPaONrxC6L/LGvvbEFOvvnPzPUGpjgw/Fu/mPiNT18juoYdtsq+lUl+p8sFCyzmiA
         5bQLX8Mc5Z6nL/O88L9HCyom2EwWZejx4MTpR0yasCUWlXxBn5jxrgNOF//k5esvE1ht
         1qaDVI++7afQtWG1++ppIdB+ribcdzERjm1o9JWXXkMwK7FkD3+Kt4c4HwXZ2RqiaiRw
         7SJhLTSM3AF2A1ozDfA3qEb/alTvxQ9Fs16J5l6ibgNvBBzXHsJ0ZCGANm91S1ySOgbo
         Z9gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770545341; x=1771150141;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rfuh2plodm8DQ54d7nVZcVI6X16Jjo175gNLcwSIUvA=;
        b=kxO2neQJfhLvy5F2qFI3jyNjFBb4AFoXBJKoHjV0j0RuF+gdJ+L/hBHThN3sBUkz7M
         3NwqChQkbAxD/ug4Tm/7CumxIICdH1p0IggDAIsSOhaAEdUaggQ698OdD6BJbQzpy5TU
         rbC1hio7bBAJLS4y+mAnnr6qnIpayJ4tONiNBTyHi3YwmI8/1dFx64waTR6mBWZl0ZVU
         YEOoOeGD0hYfIG9TjswKcSrt6OECWkZIW1zn4zxiwu3f2P0Ar8BJAuGxmIL/2Ybo0Hps
         y1D0og6zRdIFwRqQfjNiG70SY7ljABE66NTXpSCN9qSNVuwWXkHgIVZhnynOv6EMZpNq
         VevQ==
X-Gm-Message-State: AOJu0Yw19RlCGYLunGNJA2x92fgwgtEZsNTguNRDzzDoR3qNM+lhXuDG
	XtCgVkF4VQQOO1DcLDKtsOpxz2IMZN88wmnv0XTyjhdDp5X76RuIvbOQ98x1hrbOgBktBS5e9gm
	z17XpzgMDbu4fzNP/OUsaKpskKPSZdGQxdaU8Gni7Q4E6pkMZzpXYsA+4oA==
X-Gm-Gg: AZuq6aKXGKCENsECxoTW+/Y258gk6pSrwKNVQffeYNl5cdbSfaXGmcRRCPDoq2xBMG4
	Pjok0VbqX2eaAjTk7Mu85DLguHBYumWZxFHnsAbGiHjCC3NgqQL14vRCV5iWaDZ2ZVMMY7+VWvh
	LbXIXcBjsKlD5LFY7UVylk3Lt1/b+W/UoZLsVH1DCCEj92SIxoHoGq+kpmSgZDkZrmCZGA0n1jn
	SIVtzlXXqWWRSFr7hi0ZDb2wKu8+kmpEbKygVg+GA6coFLRFYA5A8OP9l6PWs+wPiHtSVcghBZV
	EzebLFUQ7py8jVHSv/oA/ZpqLVrEVnJ73J4E5TUQaxu6ITOMCHWam3vLjn8gUV9mvt7231bYP67
	0kjj/3oQCty8zX1B4yiGWhAwCjM9GYy37rA==
X-Received: by 2002:a05:6000:2381:b0:436:233c:c7c1 with SMTP id ffacd0b85a97d-4362923780emr13486655f8f.23.1770545340927;
        Sun, 08 Feb 2026 02:09:00 -0800 (PST)
X-Received: by 2002:a05:6000:2381:b0:436:233c:c7c1 with SMTP id ffacd0b85a97d-4362923780emr13486609f8f.23.1770545340396;
        Sun, 08 Feb 2026 02:09:00 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4376806626fsm5151675f8f.37.2026.02.08.02.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 02:08:59 -0800 (PST)
Date: Sun, 8 Feb 2026 05:08:56 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
	kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v20 10/12] virtio_net: Add support for IPv6
 ethtool steering
Message-ID: <20260207203120-mutt-send-email-mst@kernel.org>
References: <20260205224707.16995-1-danielj@nvidia.com>
 <20260205224707.16995-11-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205224707.16995-11-danielj@nvidia.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257816-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.972];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 421E510852E
X-Rspamd-Action: no action

> @@ -6111,20 +6176,38 @@ static int setup_ip_key_mask(struct virtio_net_ff_selector *selector,
>  			     u8 *key,
>  			     const struct ethtool_rx_flow_spec *fs)
>  {
> +	struct ipv6hdr *v6_m = (struct ipv6hdr *)&selector->mask;
>  	struct iphdr *v4_m = (struct iphdr *)&selector->mask;
> +	struct ipv6hdr *v6_k = (struct ipv6hdr *)key;
>  	struct iphdr *v4_k = (struct iphdr *)key;
>  
> -	selector->type = VIRTIO_NET_FF_MASK_TYPE_IPV4;
> -	selector->length = sizeof(struct iphdr);
> +	if (has_ipv6(fs->flow_type)) {
> +		selector->type = VIRTIO_NET_FF_MASK_TYPE_IPV6;
> +		selector->length = sizeof(struct ipv6hdr);
> +
> +		/* exclude tclass, it's not exposed properly struct ip6hdr */

do you mean:

+		/* exclude tclass, it's not exposed properly in struct ipv6hdr */

?

and maybe properly -> directly?

> +		if (fs->h_u.usr_ip6_spec.l4_4_bytes ||
> +		    fs->m_u.usr_ip6_spec.l4_4_bytes ||
> +		    fs->h_u.usr_ip6_spec.tclass ||
> +		    fs->m_u.usr_ip6_spec.tclass ||
> +		    fs->h_u.usr_ip6_spec.l4_proto ||
> +		    fs->m_u.usr_ip6_spec.l4_proto)
> +			return -EINVAL;
>  
> -	if (fs->h_u.usr_ip4_spec.l4_4_bytes ||
> -	    fs->h_u.usr_ip4_spec.ip_ver != ETH_RX_NFC_IP4 ||
> -	    fs->m_u.usr_ip4_spec.l4_4_bytes ||
> -	    fs->m_u.usr_ip4_spec.ip_ver ||
> -	    fs->m_u.usr_ip4_spec.proto)
> -		return -EINVAL;
> +		parse_ip6(v6_m, v6_k, fs);
> +	} else {
> +		selector->type = VIRTIO_NET_FF_MASK_TYPE_IPV4;
> +		selector->length = sizeof(struct iphdr);
> +
> +		if (fs->h_u.usr_ip4_spec.l4_4_bytes ||
> +		    fs->h_u.usr_ip4_spec.ip_ver != ETH_RX_NFC_IP4 ||
> +		    fs->m_u.usr_ip4_spec.l4_4_bytes ||
> +		    fs->m_u.usr_ip4_spec.ip_ver ||
> +		    fs->m_u.usr_ip4_spec.proto)
> +			return -EINVAL;
>  
> -	parse_ip4(v4_m, v4_k, fs);
> +		parse_ip4(v4_m, v4_k, fs);
> +	}
>  
>  	return 0;
>  }
> @@ -6194,7 +6277,7 @@ static int build_and_insert(struct virtnet_ff *ff,
>  
>  	setup_eth_hdr_key_mask(selector, key, fs, num_hdrs);
>  
> -	if (has_ipv4(fs->flow_type)) {
> +	if (has_ipv4(fs->flow_type) || has_ipv6(fs->flow_type)) {
>  		selector = next_selector(selector);
>  
>  		err = setup_ip_key_mask(selector, key + sizeof(struct ethhdr), fs);
> -- 
> 2.50.1


