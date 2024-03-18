Return-Path: <netdev+bounces-80311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D1887E4CE
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 09:11:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4CE31C212CB
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 08:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710C624B29;
	Mon, 18 Mar 2024 08:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="elJf6qzf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C7224B26
	for <netdev@vger.kernel.org>; Mon, 18 Mar 2024 08:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710749498; cv=none; b=IXG5GWJFuYTIsqg9/dR604Epa5nGjcOqkrkVPf5ui9jJbTtF/6I0dKKRsOHb8UZWfI7IunUD1uWGSxhmg/Rs87Z6DcEh4HlnFUWeCR0hgZQRIXb2UqLP3sx+idr/rAfT4At3hIDRBXktTkQAMne7+W4gHsxqj/50tvkUOVDY9Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710749498; c=relaxed/simple;
	bh=V6znXjGGU3aPA57dEwTHJMwuGwRXM9LRRb2ZgBPhwS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TKuErq9fuDNbKFNz53N80pge5WYRZke4wIFkgnZ2oanL2Wzz0iMLxpyql0uIuhf2PYppW4dtz6RYcXGjnp8Pky8EHVw3fI1K33NCp+GZgqUy83AQKa3FvZLXDDN34gzET/YLHFVm3GBFtRkTSV/9Q/tlAOrVj38LTxZk8/2nhg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=elJf6qzf; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5687e7662a5so5451478a12.0
        for <netdev@vger.kernel.org>; Mon, 18 Mar 2024 01:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710749495; x=1711354295; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EgbdSr9trKys7K2fBJUdtpCVbBrhRbc/oyBwbkqocGU=;
        b=elJf6qzf49ZTc9Fft4MO6UfLcFsdwJBB7VUlD4bXUsbTkqMYJv7OyRK1HUQaYWhMhy
         odcqZK6X1ynIu4dfXYBvh1EVzs6HzWIvCF1jZ40t94sMQaN1EbOAPTmBLB4rCkGyH6t7
         jdDhrSzTwcWApEQ2WNWTwgVdgXP+LrytuY5J1jzttZznFj+o5OQj8Yc5P4tgSTd/x3qW
         f6vWDQdSxqgxpEYZPO1WuO/s7AmXyP5ScPItqMWeM7mC+JD5yKaPcSNEvnsEPJ+mRC5j
         uCJO7ys08wwBvnXkJRJp3zsc5Spkc1asbO2hgay9GzdmVwHokJK7SEb326Ca8X6bGC+p
         1pVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710749495; x=1711354295;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EgbdSr9trKys7K2fBJUdtpCVbBrhRbc/oyBwbkqocGU=;
        b=FIrp5GBWcA/EKB6kQ1y0BN01WPhQ5WFqctTxz9JCkr6B/k5uAO74yoJiTdzXv+y6cw
         n0zM40X3ndME4+qOAuD8m0YPeF6t05bhCYSAZ7k8kWhH3rCVDvzh36z7EpVjfvneB5ti
         /ydfsHg657UvSJYhFIPqJt9ES4/k2CZiE6WF9JBu3+h/o6UjGz50OKOkDPHogQGFY9uT
         69AK82ADwOi8RGLhD+3U62JNqzEI8BRM/kc3GWP4QJqMQ+qnly8436xYlQriMyCKfya2
         AmUa5x6DKnH5zF9al9ffw2JGbWY5AOl5RrsEVXUFzQm3qjhiUtNuXJzgusQ91NfG8CP3
         GaDg==
X-Forwarded-Encrypted: i=1; AJvYcCX7OfMmUBoiSMBQyae34Y3s0ErL4O6eRP4Y0u/CSz7+/GOMOuV9N6QvCr6499NPC0CX2ATycd1NdLxBpbGBRH/7HFK37sxx
X-Gm-Message-State: AOJu0YzeXmIej4MzzOeAEfwSe6w4lAR8aH3fy8yt1HlFaOQ8VuXAHU4J
	WeMsauTrGuJsALbodXQLjIKZP1zY8fWfJRsUGCmkMYaoGd0Diyf1DR3IkDxSCHw=
X-Google-Smtp-Source: AGHT+IGuDGy4t5OiJnBrpwrYM4srMjBbY92AEY8Y70IH4ld6vGw0bs5SmOoET7R+xihO3L1Kpj90ug==
X-Received: by 2002:a05:6402:2486:b0:566:4dc1:522c with SMTP id q6-20020a056402248600b005664dc1522cmr8574512eda.15.1710749494896;
        Mon, 18 Mar 2024 01:11:34 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id i33-20020a0564020f2100b005687bb9816csm4370279eda.69.2024.03.18.01.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 01:11:34 -0700 (PDT)
Date: Mon, 18 Mar 2024 11:11:31 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Ido Schimmel <idosch@nvidia.com>, David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Petr Machata <petrm@nvidia.com>, Kees Cook <keescook@chromium.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net] nexthop: fix uninitialized variable in
 nla_put_nh_group_stats()
Message-ID: <1e3c6bcb-a0af-4800-92e2-1cab10545572@moroto.mountain>
References: <b2578acd-9838-45b6-a50d-96a86171b20e@moroto.mountain>
 <Zff1Liloe7DwW7Fh@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zff1Liloe7DwW7Fh@nanopsycho>

On Mon, Mar 18, 2024 at 09:02:54AM +0100, Jiri Pirko wrote:
> Sat, Mar 16, 2024 at 10:46:03AM CET, dan.carpenter@linaro.org wrote:
> >The nh_grp_hw_stats_update() function doesn't always set "hw_stats_used"
> >so it could be used without being initialized.  Set it to false.
> >
> >Fixes: 5072ae00aea4 ("net: nexthop: Expose nexthop group HW stats to user space")
> >Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> >---
> > net/ipv4/nexthop.c | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> >
> >diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
> >index 74928a9d1aa4..c25bfdf4e25f 100644
> >--- a/net/ipv4/nexthop.c
> >+++ b/net/ipv4/nexthop.c
> >@@ -824,8 +824,8 @@ static int nla_put_nh_group_stats(struct sk_buff *skb, struct nexthop *nh,
> > 				  u32 op_flags)
> > {
> > 	struct nh_group *nhg = rtnl_dereference(nh->nh_grp);
> >+	bool hw_stats_used = false;
> > 	struct nlattr *nest;
> >-	bool hw_stats_used;
> 
> 
> Probably better to set this in one place and have:
>        if (nexthop_notifiers_is_empty(net)) {
> 	       *hw_stats_used = false;
>                return 0;
>        }
> in nh_grp_hw_stats_update().
> 

Sure.  Will do.

regards,
dan carpenter


