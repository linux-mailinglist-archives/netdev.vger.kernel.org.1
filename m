Return-Path: <netdev+bounces-122388-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB8F5960ECA
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 16:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D564B236A8
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 14:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2301BFE06;
	Tue, 27 Aug 2024 14:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dyOObVee"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38C31C5781
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 14:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724770318; cv=none; b=Q0pMCnb2dh1z0tHWGYAJKm/5Gw46pvrPwwpOh7Q5eYVnHJRtSs1WkYAVLeadNrjjbrjgXCfVH1i5IDYkaA8iu+ukUZnUx7ghHSqwp5qnLa2xZzNYk3316LtNQyEvOpi7CIqayAzBahl58uwie41uo9cC7cLY+tDyo2hGh5JqTyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724770318; c=relaxed/simple;
	bh=oEmaKdDA0f1kPBEUawJwo+/C8xG853En1f0dUTIk/Lw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=INLFmx/Rieo3uGSjccFURKF5pKDfhVEklb5H3RdoWkdUMrkSRZCJf3JMXphIybL5xGUGl8PiyGnIoN8Jjspg1qITOg6gDCcog7yGg4t3EnowDnrGH1gs7SfRK2KT7+rwhiSXnKYzh6iE4Y13SMTVbXlON5YUS6jaGl9qYJ9sUko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dyOObVee; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724770315;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7axL6WwXjfqeItFfnW0Apw3Twvbt3qkjjPXlRSVYpCY=;
	b=dyOObVeeblHNdAW6U8cCyYFOkQB9a1Fyg+R9XlZdVwZWMqQ3XhN4EKtu3C3Mcy18Jjt6oj
	QKFJPVAc1nH8cH24357pGS3QOPXBoQCiAQfz13LBDgP80MZLK3/nxQNdprRu66oeMq49FI
	HzsKRfzm8Yh80fc2SV2W1EeLJbaGXZ8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-fFuk8EnYO9mDpWGXr_xCqg-1; Tue, 27 Aug 2024 10:51:53 -0400
X-MC-Unique: fFuk8EnYO9mDpWGXr_xCqg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42809eb7b99so29429955e9.0
        for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 07:51:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724770312; x=1725375112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7axL6WwXjfqeItFfnW0Apw3Twvbt3qkjjPXlRSVYpCY=;
        b=KJ3hIsZwXC3zTrQn4+hqamvohMWxc1L/+TPaKYGrnmm9lHaNJpBpNKqndn+h3az5F4
         Z6cEVSVjY4/X+CPfqsg7G9S2SwIjrjIKcq51Woorp3LFOikEyynBvC85HPojIgljxw47
         GPZUs3kfV7zN4feh8P1WW/MzgotEddVn3F7Tpx8eb3RpVoyeUS8Zhm30+FZbL8Q1ZFzH
         OL0PR+a+WF+wylsPmdVB3NQYvjAFx51lzVzgddOS4BLkW38H9of6h3QiEpkoqesKuktI
         sDMaAhpF1shBzgB/zxfJsMzLpm5/uA+hCpJ6eBQLFV4sCu1v9rGALa0qa5b85sqBU8W/
         1Jdg==
X-Gm-Message-State: AOJu0YyoPrDs0uw5UQN11rnGfWQSCVK4hgHRKNhqfIvtoctTL0+RtOQG
	u2cGN7hlGBWc3swQ8SV8I/eC+ciZ3FKs4G3jCOT2dEDCL66Yim/69bzWVcYY0OOxhalTGuKypiK
	WkqI2KF2t1mg22JwRE/X3Is7mcnTqidwczoA9awWxUCpFJ9MEbG3dZw==
X-Received: by 2002:a05:600c:2a93:b0:426:62a2:34fc with SMTP id 5b1f17b1804b1-42b9a4712c4mr19881325e9.11.1724770312191;
        Tue, 27 Aug 2024 07:51:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZZ74kly+gbSlYShXQj2yuPWS3lSuYHmjvhCf+TLC1w87JRikCELmk2jBrsrWcEKpPgeZS/Q==
X-Received: by 2002:a05:600c:2a93:b0:426:62a2:34fc with SMTP id 5b1f17b1804b1-42b9a4712c4mr19881125e9.11.1724770311473;
        Tue, 27 Aug 2024 07:51:51 -0700 (PDT)
Received: from debian (2a01cb058918ce0010ac548a3b270f8c.ipv6.abo.wanadoo.fr. [2a01:cb05:8918:ce00:10ac:548a:3b27:f8c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42b9d945144sm23064825e9.0.2024.08.27.07.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 07:51:51 -0700 (PDT)
Date: Tue, 27 Aug 2024 16:51:49 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
	ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
	john.fastabend@gmail.com, steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au, bpf@vger.kernel.org
Subject: Re: [PATCH net-next 06/12] ipv4: Unmask upper DSCP bits when
 building flow key
Message-ID: <Zs3oBWRQtDjl4JxV@debian>
References: <20240827111813.2115285-1-idosch@nvidia.com>
 <20240827111813.2115285-7-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827111813.2115285-7-idosch@nvidia.com>

On Tue, Aug 27, 2024 at 02:18:07PM +0300, Ido Schimmel wrote:
> build_sk_flow_key() and __build_flow_key() are used to build an IPv4
> flow key before calling one of the FIB lookup APIs.
> 
> Unmask the upper DSCP bits so that in the future the lookup could be
> performed according to the full DSCP value.
> 
> Remove IPTOS_RT_MASK since it is no longer used.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  include/net/route.h | 2 --
>  net/ipv4/route.c    | 4 ++--
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/include/net/route.h b/include/net/route.h
> index b896f086ec8e..1789f1e6640b 100644
> --- a/include/net/route.h
> +++ b/include/net/route.h
> @@ -266,8 +266,6 @@ static inline void ip_rt_put(struct rtable *rt)
>  	dst_release(&rt->dst);
>  }
>  
> -#define IPTOS_RT_MASK	(IPTOS_TOS_MASK & ~3)
> -

IPTOS_RT_MASK is still used by xfrm_get_tos() (net/xfrm/xfrm_policy.c).
To preserve bisectablility, this chunk should be moved to the next
patch. Or just swap patch 6 and 7, whatever you prefer :).


