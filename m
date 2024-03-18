Return-Path: <netdev+bounces-80308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE27C87E4A7
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 09:03:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEAD41C2134B
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 08:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B98A425570;
	Mon, 18 Mar 2024 08:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="t0Et7gEh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9A222EF0
	for <netdev@vger.kernel.org>; Mon, 18 Mar 2024 08:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710748982; cv=none; b=ssnkFjAJvHYyMoXJwxHBWOXS93IJMoqp08z6dyfG88mTR9XhCw2QdJumZBPeeHRkPXTTmLXZdZC1MvGC34zqdMox3L+nRw6bSs7i7J/zVub/GBFYlrBhGsM0ev6MkRD7A21HDQoHFYj7cmlVvMhBOKDUqcEvzYNEHsZEjK9TXSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710748982; c=relaxed/simple;
	bh=XqaEr8+5PbPTo9cFExJMuDm6EYQQTHY+jja90dnLCDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DYaCQAaMmVtiLy/pqshqiiV6VPk9lnP9tEHC2YKGZBv4hVd+is0YzFj+quwTPhrKpq5L48S+HmhjEGX4lRDe30R5VDFZ4TND3FgRfjC6qUC2gmxgA6PPiPOvztTNtx8gBw9zCB0huTPv0NX542srz/cUtYUdmLOwa+hwuOwNX6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=t0Et7gEh; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4140a259a54so8780545e9.0
        for <netdev@vger.kernel.org>; Mon, 18 Mar 2024 01:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1710748978; x=1711353778; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xWOqW0YebhNynLRnswRT+iDOKo43sLSNLgQuiEyKwZk=;
        b=t0Et7gEhTCw5IKP6p97Ixw9v2Voosz/NUSTnlffg8a4R+3Ju6HQTzjHY48mEu6Tm29
         xQrfTGimSNdBN02F9rQpNzuACS7w3RnQ5SQdZxI0EpqRQ+dKS69trtHMwTk0w987blie
         7oL6FEXIWbER93zVucakITLIYgz4WnnI8Yn8SHFd5uY9v6IkhtMzJqlhXaiYlXbNXGCk
         SdJW9WNrSXKwrKNgAjGwhpsZaMXZDc6Z48+r5LeQBZo0zOyWMmYDKiFZ4TnI3O6wR1Bf
         KKXFO6YTtbQDzdWj+yoXuq4R3XsbMnb0MKNq/nQtZ44PJp8Utyu453hz9LPjFD/ZXCR7
         0VIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710748978; x=1711353778;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xWOqW0YebhNynLRnswRT+iDOKo43sLSNLgQuiEyKwZk=;
        b=ZfJeu3/k1XMUQ3oY49rXIYkCu7L+MtZZUnbpm6q3IbQiz8OiiG1h/DFyLZ7HpIVUp6
         YO/EeT7BzwUJNGuj49nBPUvT49aqyVVDA2N5zSLbyY2i8GLViCgkzKQRx53iWs4UjeSz
         fjy90jZKxSauMsqLaluS9SNB820mBRxmcFQKcDMJcXboKUJJJGJ1L+r8Ef5vuk5pa1yP
         F5w67ejGiIvCMZubuVOb3oIBDywBUhNCeVN5FeaRdG4u2BnGC/cQSYlrGXFwr5UHXen7
         EohA3ktZ2lo0UVkbrjMHiEUyFAt41INK6G7Z4joWyEw4gEx3S1bUC4fGj0FFyixI2hUX
         U8zw==
X-Forwarded-Encrypted: i=1; AJvYcCXF9rmgie5YW0/5qq1Z976QEa4sopX5o5d8kYM9SBHZkae0Oq05nDKnHa6MKZxeqkfXnZvqVbSEe2njy2LaMlxQ7sN4fXbG
X-Gm-Message-State: AOJu0YxeL+sG0/ajx1U7RvNkXJyIedZLtEBIHPkOzW7YbN7nhWal41pk
	sCoWvOsLBb9YWUEFya2ND5pbVrG1gdmrSZXpZf+Ict290y6jkBm5wTGdhxqeHyQ=
X-Google-Smtp-Source: AGHT+IELaoCPUiTYZCUp5adT9hoE5Zvai+v/TXPvdYYIzf6YUyfkJyj5svseORCTf+1fmlB5N5IEiA==
X-Received: by 2002:a05:600c:1c84:b0:412:e70a:ab8a with SMTP id k4-20020a05600c1c8400b00412e70aab8amr8103345wms.25.1710748977943;
        Mon, 18 Mar 2024 01:02:57 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id by1-20020a056000098100b0033e18421618sm5582669wrb.17.2024.03.18.01.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 01:02:57 -0700 (PDT)
Date: Mon, 18 Mar 2024 09:02:54 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Ido Schimmel <idosch@nvidia.com>, David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Petr Machata <petrm@nvidia.com>, Kees Cook <keescook@chromium.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net] nexthop: fix uninitialized variable in
 nla_put_nh_group_stats()
Message-ID: <Zff1Liloe7DwW7Fh@nanopsycho>
References: <b2578acd-9838-45b6-a50d-96a86171b20e@moroto.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2578acd-9838-45b6-a50d-96a86171b20e@moroto.mountain>

Sat, Mar 16, 2024 at 10:46:03AM CET, dan.carpenter@linaro.org wrote:
>The nh_grp_hw_stats_update() function doesn't always set "hw_stats_used"
>so it could be used without being initialized.  Set it to false.
>
>Fixes: 5072ae00aea4 ("net: nexthop: Expose nexthop group HW stats to user space")
>Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
>---
> net/ipv4/nexthop.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
>index 74928a9d1aa4..c25bfdf4e25f 100644
>--- a/net/ipv4/nexthop.c
>+++ b/net/ipv4/nexthop.c
>@@ -824,8 +824,8 @@ static int nla_put_nh_group_stats(struct sk_buff *skb, struct nexthop *nh,
> 				  u32 op_flags)
> {
> 	struct nh_group *nhg = rtnl_dereference(nh->nh_grp);
>+	bool hw_stats_used = false;
> 	struct nlattr *nest;
>-	bool hw_stats_used;


Probably better to set this in one place and have:
       if (nexthop_notifiers_is_empty(net)) {
	       *hw_stats_used = false;
               return 0;
       }
in nh_grp_hw_stats_update().




> 	int err;
> 	int i;
> 
>-- 
>2.43.0
>
>

