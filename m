Return-Path: <netdev+bounces-80813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0485D88126C
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 14:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2C16285C2B
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 13:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D1541233;
	Wed, 20 Mar 2024 13:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="oXDEydtP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31EA4086D
	for <netdev@vger.kernel.org>; Wed, 20 Mar 2024 13:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710941893; cv=none; b=aoBPuExcjUsiZrHYMKQzV2y19JFlLYkyrV8aJx+JIqlqB/HpVPJOJJnpJLfRAJHkSpFmZFcEpsiiYNTYZsQCBA3u/8f1+opOXazmN5OmNzQoJxo3MsNifaxYXAOGQhpTF+BZdmPggT6MvnA+Vf0tBiK7OOFyFPU94Ge7rpEomxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710941893; c=relaxed/simple;
	bh=RI5KZMx81gg+b8/ajk+DICM5zDgR1lxlWcKqY/8HJ7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pn9dm1UzcfAmP3qqnLgTZKo3J9ownN7Ve185w+E7EwqQDvxZuy3ih1UjxciMwzBBMjAIfbqFT0UOJLey2dULFHKSdFtLYSsJ4c3Z2aiGVC33ZLFo4Ul2SCGciUaYmuYl3WLstAOXw64od6Bf7PyeKIwuAy67Xh82ZlwC5IpHPfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=oXDEydtP; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-56b8e4f38a2so2969106a12.3
        for <netdev@vger.kernel.org>; Wed, 20 Mar 2024 06:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1710941890; x=1711546690; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YxVMLy0rFd456KQx8TF/3jyxQy3CEg3Punv2dpTMXs4=;
        b=oXDEydtPG7rHsdXp2fHzSxbgUsw+KGseiyURXvhCEDNXv0AC9N+FR6JpfWSFNlEcMU
         jNcQtjq23ZHahzwO3liZBcLFcWZaqPmLOXwOvu5EFncmA37HUQkFy8bZ8/P+9qT+hZFd
         aS7aPuqqSUAILnA36Ot2TmmjO+Ki0wvF393la8l+tqhCz0by4Cc8JzD+eUJAQYxsdWfL
         kKJlp4GANL1Oy1aQ1WWoh2P66HYGzB4lmC03ukvqNUsYEcPLWu3FP7ngf6JmVMk5Ijev
         y3bm0HMNDQtgWmOIDI/y04PgGxC+eewfFPAv9NcYc8lqeYp//8CvHEZUsHwhD44RTGkU
         gETw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710941890; x=1711546690;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YxVMLy0rFd456KQx8TF/3jyxQy3CEg3Punv2dpTMXs4=;
        b=V4HhQmuVGby8Cb+GyLvN8VYwpWUuvQTxz4Qecs/TLKSPKEdapJxP7Dk1o0RVVS0n1u
         sflKDnWMbLscSLLv/0uHQx0V/yPwr+YB+0VPNA7h4N46dpkmYKIi2WtDyFpgyC3sCarn
         SHFeEQSP4jQqrw1e/arBd/vHB/5wOrEWVbl2osg6/bntNdUT/BEf0yiFuBDlsR8KSHub
         4KnZfwletaaxD+hRq6mwwjI+NcxgXuFI5lGxR73wCn/7ZGy4VVdkJ+IZEI9LPyR4etcH
         mlZ2uEA1GDH74clkw1OHJm45/iOg5wJVDMhRxHLaXXgsbVkkwGI7LFW0pwdN7GB1KXNs
         g01A==
X-Forwarded-Encrypted: i=1; AJvYcCWJ5gbLV0iBVVmgFCnCdesTSgVEEILAubr2P5DKl96C/wd6VdgUt6bwTiirw+3yINjXm0exyb0rz6tEZqp4vj1EGstBbEhe
X-Gm-Message-State: AOJu0YySoU4Tx/7Yh/WOlEqlCCMxcw5n0SlaV6m4OIx0oRVNERoXGRZb
	yb7QA5K++vt2ypy/iOrHtgQ4Spn2IrydVswtEB1H3sQkUYOg2yH6WUEm2F7VQrM=
X-Google-Smtp-Source: AGHT+IHx8FRiWQLj1a9vman+PrWsMTEKIuVYmf3W6M9VFNgezYb6jHEVh9SMi0qq+OaS6+t7ZPwqvw==
X-Received: by 2002:a05:6402:3706:b0:56a:2b6b:42cd with SMTP id ek6-20020a056402370600b0056a2b6b42cdmr6063484edb.3.1710941889727;
        Wed, 20 Mar 2024 06:38:09 -0700 (PDT)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id h3-20020a0564020e8300b0056b8dcdaca5sm2340236eda.73.2024.03.20.06.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 06:38:08 -0700 (PDT)
Date: Wed, 20 Mar 2024 14:38:07 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Anastasia Belova <abelova@astralinux.ru>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH] flow_dissector: prevent NULL pointer dereference in
 __skb_flow_dissect
Message-ID: <Zfrmv4u0tVcYGS5n@nanopsycho>
References: <20240320125635.1444-1-abelova@astralinux.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320125635.1444-1-abelova@astralinux.ru>

Wed, Mar 20, 2024 at 01:56:35PM CET, abelova@astralinux.ru wrote:
>skb is an optional parameter, so it may be NULL.
>Add check defore dereference in eth_hdr.
>
>Found by Linux Verification Center (linuxtesting.org) with SVACE.

Either drop this line which provides no value, or attach a link to the
actual report.


>
>Fixes: 67a900cc0436 ("flow_dissector: introduce support for Ethernet addresses")

This looks incorrect. I believe that this is the offending commit:
commit 690e36e726d00d2528bc569809048adf61550d80
Author: David S. Miller <davem@davemloft.net>
Date:   Sat Aug 23 12:13:41 2014 -0700

    net: Allow raw buffers to be passed into the flow dissector.



>Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
>---
> net/core/flow_dissector.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
>index 272f09251343..05db3a8aa771 100644
>--- a/net/core/flow_dissector.c
>+++ b/net/core/flow_dissector.c
>@@ -1137,7 +1137,7 @@ bool __skb_flow_dissect(const struct net *net,
> 		rcu_read_unlock();
> 	}
> 
>-	if (dissector_uses_key(flow_dissector,
>+	if (skb && dissector_uses_key(flow_dissector,
> 			       FLOW_DISSECTOR_KEY_ETH_ADDRS)) {
> 		struct ethhdr *eth = eth_hdr(skb);
> 		struct flow_dissector_key_eth_addrs *key_eth_addrs;

Looks like FLOW_DISSECT_RET_OUT_BAD should be returned in case the
FLOW_DISSECTOR_KEY_ETH_ADDRS are selected and there is no skb, no?


pw-bot: cr

>-- 
>2.30.2
>

