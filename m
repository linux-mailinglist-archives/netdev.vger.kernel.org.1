Return-Path: <netdev+bounces-203971-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1328AF86CB
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 06:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 740F23A3F0B
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 04:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD944CB5B;
	Fri,  4 Jul 2025 04:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OgnJGGW1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7545C1853;
	Fri,  4 Jul 2025 04:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751603481; cv=none; b=h2gmPKF14Am3s+fpkGBApnFNLhe71PSe533uJ7KkqmrIBa+5A4mVaELjXj2BgFiq5eMV8pC8VqtTBxrfI+GR05X0L2a/O8yUCkRw3hDwG5IfHjWLhk/7I4FYpRKVtk2Y+pAISFpfFfLVNycaUrxw4e3/FzEoR0gCV3OC3Pdx500=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751603481; c=relaxed/simple;
	bh=13qGOsCJDg5W7qhM9k4Cp9R4/kOgj/YISD399woMggk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=amKlUtIZVyFT0GU9uvXeXm0zCa/t8iyLiozMottMvns5+10skcvPLoAVVWN7seGxQZv0zoaCUrYuaamMSqqVqk0xGcgam/D7osZP+RhNnd3t+QS5MRpnR+Uhy4/BDr1YY/V5KO9z9ZqFKsdrDDnHFrDlLIY00Ft/JIn3JdNYuDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OgnJGGW1; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7fd35b301bdso559895a12.2;
        Thu, 03 Jul 2025 21:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751603480; x=1752208280; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fxALKIjMO7YvRd1pEEIdH4CeFOM7Eh9lzExephTx580=;
        b=OgnJGGW1wFD1BI56EGdTdCTXPm75Wa2reYtkw442Q+S5g67b5kFgEdeK4T7KXtfgvU
         4/H2zvYqF5dXrgwZniWFFeAOQ0a9klT8sb/tbltQq2pWpLh+XmcQLomxpiLCoNpwocxi
         SZvdw+uNCKnf4c5xu3b/Ovt4/3G/cC7ONW2lj4iYaJ9nny5JeooniumiaeBhTAGlaxH2
         tfV2tpm5jqoXrU2/CJXl7QdA+tnHP9Q4iXvj9BIBQv6Or0FERSefHlj1vYRvd9vCqqBd
         oRMmG6mAsqY+nPJtO/JEEmHbRZLwi8S6pYLefL3+c6DWdjVnsBwLFZqJXeumyJjvl8qJ
         GdFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751603480; x=1752208280;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fxALKIjMO7YvRd1pEEIdH4CeFOM7Eh9lzExephTx580=;
        b=Y0raDFoF2vNzUtuK/l/V92eoIcUYyav+NfWcwPpuNROJX2KQBjv/VknkEvpNsu+cGh
         fTyButJ0o+PGt+lda+CsyZuDVAgwxYHsjO3TtzQyUJF3UOaQdwg+J8vXqUNfZUahz4WP
         x8i5bAmsCtdvT0hoQsZzCTW3Uoei9GNf/QYXowgG6rmIPi3fI0ugL+MycmvfnpbnJyQF
         btOM+rOXS4tkw8yQE9Km0nubknry2rnpEnTiGxy3h0vwX2ZP0K5EJQliVvHoP3I9bwua
         J0vY/T6/eGQfKjfMOPAwB1yh/oTRfzuo4i+L+fewYuyNIH4KIbxVHfosfCSrBI4y/L9L
         xPEg==
X-Forwarded-Encrypted: i=1; AJvYcCVjl6k9Ro2K8z3X9a31m66najNJXpz8dkcCDmgTslCL/UAdEDMOWB9K0owQYS67iE9GmGnxyH5k297fuPs=@vger.kernel.org, AJvYcCWB50UJ8h0y0YmZKoAMqeH2CCa7Hlj8+zj/fuCOdyQESgtj9IyVKoPiiBley+BFz4tFC5p0Mm4v@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj8wh/g3H+CWg96fK0Xq1rKP0aJzqaejEB/adrj5txrPR1NdpZ
	qNuOZ2Of+0GO/zThgr3y/SB/ASEwrac09sj+xf0LNCLxhBDPQOA0VpT0
X-Gm-Gg: ASbGncuzZ8ZxxhR/xBgKPtDGlgG1TVpbR7iDnyB2LIId9q9EEg1RseSn8KTD4cYkkt0
	Z7+tJt93UYhmyF6b+PL0fXgBasDFqZVdJnnl6Hrt8ZfzeH3sfH/J73tHqCRNTNT6q//VP6pAZ28
	8Fe5RQonUymK+7c7QFBRw5xzpvbIkhxDhNF3Ftaj8IIEDJbrnNouc3TJB6Bg8j+i+xLocTJ/s/U
	PMAtf5IyE27epMclZjFYJoF4VJJTSO6yT0WFWWDtcKLi/zBfEohyJvrCBRaHq61lGEAynSHUZHo
	JbkUZmgGRBODH683MlHEiAI0/B8sG+1KPQ+aQ4XLC/nam3wyUyQuuS5nTq3Uo8QY23rboTef29i
	grjE=
X-Google-Smtp-Source: AGHT+IHkvlcewWbWz3RLsWy6U2O5nxq2HueWe9yVOwfG6KNgonIBzAzpwgDA+2exlfrQ3C/FYpx7rg==
X-Received: by 2002:a05:6a21:a8e:b0:220:a3de:a083 with SMTP id adf61e73a8af0-225b85f3eafmr2173223637.10.1751603479663;
        Thu, 03 Jul 2025 21:31:19 -0700 (PDT)
Received: from localhost ([2601:647:6881:9060:1aeb:7d0c:33d1:51f4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce35cc72dsm1023375b3a.42.2025.07.03.21.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 21:31:19 -0700 (PDT)
Date: Thu, 3 Jul 2025 21:31:18 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Fengyuan Gong <gfengyuan@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, toke@toke.dk, edumazet@google.com,
	"David S . Miller" <davem@davemloft.net>,
	Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	cake@lists.bufferbloat.net, willemb@google.com
Subject: Re: [PATCH net-next] net: account for encap headers in qdisc pkt len
Message-ID: <aGdZFhGu40UD6UDU@pop-os.localdomain>
References: <20250702160741.1204919-1-gfengyuan@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702160741.1204919-1-gfengyuan@google.com>

On Wed, Jul 02, 2025 at 04:07:41PM +0000, Fengyuan Gong wrote:
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 11da1e272ec20..dfec541f68e3a 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -3944,7 +3944,10 @@ static void qdisc_pkt_len_init(struct sk_buff *skb)
>  		unsigned int hdr_len;
>  
>  		/* mac layer + network layer */
> -		hdr_len = skb_transport_offset(skb);
> +		if (!skb->encapsulation)
> +			hdr_len = skb_transport_offset(skb);
> +		else
> +			hdr_len = skb_inner_transport_offset(skb);

This pattern seems repeated in a few places, other than the two you are
patching, I saw another one:

2465 static netdev_features_t hns3_features_check(struct sk_buff *skb,
2466                                              struct net_device *dev,
2467                                              netdev_features_t features)
2468 {
2469 #define HNS3_MAX_HDR_LEN        480U
2470 #define HNS3_MAX_L4_HDR_LEN     60U
2471 
2472         size_t len;
2473 
2474         if (skb->ip_summed != CHECKSUM_PARTIAL)
2475                 return features;
2476 
2477         if (skb->encapsulation)
2478                 len = skb_inner_transport_offset(skb);
2479         else
2480                 len = skb_transport_offset(skb);


Maybe worth a helper now?

Thanks!

