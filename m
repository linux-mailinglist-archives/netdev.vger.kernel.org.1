Return-Path: <netdev+bounces-145017-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6803F9C919D
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 19:24:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BAFE1F21E67
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 18:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B2218C91E;
	Thu, 14 Nov 2024 18:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ksVT/Ayc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C421CD02
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 18:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731608672; cv=none; b=K7ZNy1cTxFgs5LxWpktsOXWPZ6gNS0noyhvTzjwBO9rxQyevxA8qvlKjrzSyT53R7EP5Y3/NgSsHNCrUmVq8o9+r60YO9TGva0LMEOkuLDAvRhLgTD01tDm4rRLHrmKLyCIHNaliu7L8y3iTgp26aPYEGxUnAYOai2orDCFxQik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731608672; c=relaxed/simple;
	bh=iUE1rpvDx7hM8ZYWj9LdWAtG8kYLLNYxHpb7+L/hptw=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=C9Mn6QXsqvzaBD6dEHsRjSbtBDSlpCrvAnuJRr2apgN5DT2q8sWFve8nfW0D/+OgNVbmsa8CQyGxl9akdsA8uf8neu4XgZn8wyDeBTdiKwocKLv6dMqlQ0o3ObP6VqGffZ1F5hz2kPU5b4drd/ly2mghEcMnwwVec2v7o/cDTTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ksVT/Ayc; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5cb15b84544so1248538a12.2
        for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 10:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731608669; x=1732213469; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=iUE1rpvDx7hM8ZYWj9LdWAtG8kYLLNYxHpb7+L/hptw=;
        b=ksVT/AycBhlBwOCC8pMOjHV84BxeGEYFogvbZfjFx8JsZQKn+WxXFGWXiVAVAuYBDb
         1wCiEOBlg0PGEa/xBLqcwMA3vOoTqEJsOtnOyeo1+bKqNmIvvei9XhFQXrT6J4SRw+1h
         DhLkP6sVft8ofV+lHLQHUAblQJgXT5j0KBju+vVMR02sA+DZHKOrQDlfxqE/EUKnIsUv
         KbX+kgFKMzBuzD0HgUmotQvdF7twsPiirt2eXMN6xpQUO9fDpkRgrRNnpxqCLG6QiSUN
         psDhGv0W471Fuug3Voz+Ere4Zb4QtssfUaswxZaSIgSmhTj/BrVXp/JAToOAJJu1Vknl
         nV8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731608669; x=1732213469;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iUE1rpvDx7hM8ZYWj9LdWAtG8kYLLNYxHpb7+L/hptw=;
        b=PS4X1zXFKNY2Bs4Os9GjD7pCg9G/trNZ8hHlaoW6S5uJZe7mZnPkneaN/joGVXaJP9
         kK8/mxCmHnGtYE45/oW2pDLqvfiCnLPylVXjkiLmt2K2V4lalrWX/+Lf5q8KEO68cWAa
         ZEn1PxVDXqb6czpZI+4hDSjjOp5rnZ0FUI1p3SVlD4LSzJyiRsPzVOUj0HuQa1itDdLf
         bn4BeJqhMpp7c2K8Bv+bMrwalsixpTCsvi9mqaC/MKEPKjG8jlt2RUOetBBXvzG1Xt9e
         zjWNAuv0KKWhUvgLlHaL3mC/gMxBXDemA/ZkRh1FXd6rgpLWwNf12sNIlggrHYr2csjF
         h9AA==
X-Forwarded-Encrypted: i=1; AJvYcCVCiyYTw8WxPBoI6ynoDixR3nqfLlGEwUxZqy8WmFJeJA93x6HR3LcHgwf5j2BHitEI/vmdFmE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhsGP9DWO8xrvtUr0IVzWgScJRTVr8WDzIQyJTPXaA+ZtZqPNj
	bTT5hrsu61pGJ5vKD8QFOWqya59TdzWH4/+L+JSwOEAKncYdKh2i
X-Google-Smtp-Source: AGHT+IHN8kP9nsC2Kvf36RMc2YcWjEIcvkf62YQASEep2wwa6zsVW269oqYtZfFyVkiAl+pUsdv2eA==
X-Received: by 2002:a05:6402:3485:b0:5cb:6729:feaf with SMTP id 4fb4d7f45d1cf-5cf77eab525mr3041908a12.16.1731608668963;
        Thu, 14 Nov 2024 10:24:28 -0800 (PST)
Received: from [127.0.0.1] ([193.252.113.11])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20df268casm88912066b.1.2024.11.14.10.24.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 10:24:28 -0800 (PST)
From: Alexandre Ferrieux <alexandre.ferrieux@gmail.com>
X-Google-Original-From: Alexandre Ferrieux <alexandre.ferrieux@orange.com>
Message-ID: <40bb5d4c-e21d-4eac-aec0-25b2f722be6d@orange.com>
Date: Thu, 14 Nov 2024 19:24:27 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: RFC: chasing all idr_remove() misses
To: Jakub Kicinski <kuba@kernel.org>
Cc: edumazet@google.com, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, horms@kernel.org, netdev@vger.kernel.org
References: <20241110172836.331319-1-alexandre.ferrieux@orange.com>
 <173147403002.787328.3694466422358304986.git-patchwork-notify@kernel.org>
Content-Language: fr, en-US
Organization: Orange
In-Reply-To: <173147403002.787328.3694466422358304986.git-patchwork-notify@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

In the recent fix of u32's IDR leaks, one side remark is that the problem went
unnoticed for 7 years due to the NULL result from idr_remove() being ignored at
this call site.

Now, a cursory grep over the whole Linux tree shows 306 out of 386 call sites
(excluding those hidden in macros, if any) don't bother to extract the value
returned by idr_remove().

Indeed, a failed IDR removal is "mostly harmless" since IDs are not pointers so
the mismatch is detectable (and is detected, returning NULL). However, in racy
situations you may end up killing an innocent fresh entry, which may really
break things a bit later. And in all cases, a true bug is the root cause.

So, unless we have reasons to think cls_u32 was the only place where two ID
encodings might lend themselves to confusion, I'm wondering if it wouldn't make
sense to chase the issue more systematically:

 - either with WARN_ON[_ONCE](idr_remove()==NULL) on each call site individually
(a year-long endeavor implying tens of maintainers)

 - or with WARN_ON[_ONCE] just before returning NULL within idr_remove() itself,
or even radix_tree_delete_item().

Opinions ?

