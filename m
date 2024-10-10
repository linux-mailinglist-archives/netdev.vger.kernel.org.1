Return-Path: <netdev+bounces-134418-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9564E9994EC
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 00:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38C541F23FC0
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 22:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807C41E47BB;
	Thu, 10 Oct 2024 22:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="LrQAoVY0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA141E47A3
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 22:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728598055; cv=none; b=LUnsshdIze/uFZobWTKeZRvZTGorhK2pKL8CDnFhWhUVKyDQ2hhA2mQOrUv4UYi+6WJ44dl9VhTnYFhKobFzquOppMbSgZanmSWVw3UbIjzmY2pknaMXR8qPdl7p0PcoA4QQPBCYRAcw2vOX32AX3OT9E/esnO4xOdwNPMzfueY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728598055; c=relaxed/simple;
	bh=IXWBrb1+4puUbFIrvJvIwqmype/XxNMz1z02jxp5N00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JAWtrb/IwgIhoLe9ohFXjh1YAyzdTdKNxy3rEM4X++5He7kGr3K7nJnmh0obaLewPNEReEy2LAMax9SFKj7LyKrl80QcEvePYRdsobrnW52W9XKXcCJsUNFwX2e4DqUz7bvipceSL/JBvhntykYAomyCSDXeaYFOn8Jf3tSR+v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=LrQAoVY0; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-71e038f3835so1376000b3a.0
        for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 15:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1728598053; x=1729202853; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3yo7xWDDeFDaCm97O1zcq6LH8U4VFuAQ+/J8LotlATE=;
        b=LrQAoVY0kBfYuVLR3P3sTr1m7GpTfUqsiUqB6GSTx/Rss3Wdv7jsecil0+9CBJGF0m
         ip3ib+BQL/dLCNOAF2KTh7OIkfLh47d/9cDxRzRPOVTG7AMZ+OvldMwZlsn1suMMC3g4
         mG5AEBt18KfXkisLkfMgJGRHLPFQROaMyTozg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728598053; x=1729202853;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3yo7xWDDeFDaCm97O1zcq6LH8U4VFuAQ+/J8LotlATE=;
        b=dMdQnmNN1k1GmZsswZf8htZAS1djkvga94XngYytfjEorWCoVU56J6qc2b8LKoQaSx
         MY6LVTUeOr9GAViieByHU7RamnpF8boc1dcp27yB/EvpNS0dzetCnbG/Kx0GUN69VL73
         A+Rcpz57QLGngdpyV4CFLl9SLEf44d62ZagTq4TfwnRMCxtzBSgD/pXBK/BslMDdykUa
         5U9Xt2VJYht4QP/RLC5T6Se2BZeXkfgqWfbWuEs3jITR+Gr0zw9nSqw3Ok7IvC029qTk
         2P0vQ1INMrfiqJVzlg0QuKty2QvVwTOjarr6dXk/mIQW7ttpb3hKlSXhnkMwevHb0sdJ
         wwHA==
X-Forwarded-Encrypted: i=1; AJvYcCWXOsC3BjoKwuDhvvPr8N3YZyZJ+MDgPDl/2bebOX1YvrErY8zmFsEQSxTX9PgqX8jdqO6EfvE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDM/u8FGYqqSMfTHw6Fy1Jp3ytvZsh/5wJGWFm+xjsLcZKaZDB
	dBoXpdVUV37nt/Uo5cfotYiAsCkFEhfFxC3zmmLRdxvkHadJr8x//8xiaGeo/ZU=
X-Google-Smtp-Source: AGHT+IHg2zizMgNilSTsoaMSaNju+zKzOxffudg65+pCc7GVqnBSAFewHnqlEuq3Lxq8TICEWC/tqQ==
X-Received: by 2002:a05:6a00:2ea2:b0:71e:209:512a with SMTP id d2e1a72fcca58-71e37f56a04mr759824b3a.18.1728598053058;
        Thu, 10 Oct 2024 15:07:33 -0700 (PDT)
Received: from cache-sql13432 ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e2ab0b5dfsm1500337b3a.199.2024.10.10.15.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 15:07:32 -0700 (PDT)
Date: Thu, 10 Oct 2024 22:07:30 +0000
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com
Subject: Re: [PATCH net-next] tools: ynl-gen: use names of constants in
 generated limits
Message-ID: <20241010220730.GA260524@cache-sql13432>
References: <20241010151248.2049755-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010151248.2049755-1-kuba@kernel.org>

On Thu, Oct 10, 2024 at 08:12:48AM -0700, Jakub Kicinski wrote:
> YNL specs can use string expressions for limits, like s32-min
> or u16-max. We convert all of those into their numeric values
> when generating the code, which isn't always helpful. Try to
> retain the string representations in the output. Any sort of
> calculations still need the integers.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  net/core/netdev-genl-gen.c |  4 ++--
>  tools/net/ynl/ynl-gen-c.py | 36 +++++++++++++++++++++++-------------
>  2 files changed, 25 insertions(+), 15 deletions(-)

I rebased my per-NAPI changes on top of this commit and gave it a test
run and it generated this diff:

diff --git a/net/core/netdev-genl-gen.c b/net/core/netdev-genl-gen.c
index 3692c8270c6b..21de7e10be16 100644
--- a/net/core/netdev-genl-gen.c
+++ b/net/core/netdev-genl-gen.c
@@ -23,7 +23,7 @@ static const struct netlink_range_validation netdev_a_page_pool_ifindex_range =
 };

 static const struct netlink_range_validation netdev_a_napi_defer_hard_irqs_range = {
-       .max    = 2147483647ULL,
+       .max    = S32_MAX,
 };

 /* Common nested types */
---

which is much nicer! I am not a python expert, but the code seems
reasonable to me and the generated output is a huge improvement (IMO).

Thanks for doing this.

Reviewed-by: Joe Damato <jdamato@fastly.com>

