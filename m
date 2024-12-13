Return-Path: <netdev+bounces-151768-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB8879F0CED
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 14:06:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC0AD28313D
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 13:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE981DEFDD;
	Fri, 13 Dec 2024 13:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Oe3jm4pf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F05D1A8F85
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 13:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734095212; cv=none; b=InS7HPBpX06i7lkpQkOrJgvKlZi/aNP2449otmzajlrjd7AE/hy3nQBGC756kzk1d4V+91hOmUcfAejMGq3J/8wUXbzCTmvl2nBdcLGZHqr/XLE28lrN7xombj7EZBBs2UTa4HaFN0Ax5Z2/cn1w2j6YJQIUfA6rbUKOgX+whm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734095212; c=relaxed/simple;
	bh=ks9DxICgxlU/gCz85Nt643+qsojkXRxw0Z3p4r21hzo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=r6xqVJApeMiQILlhR/P9joYRVd/ScXMKsGD/lwTgaMTzUmDnkHi9RZ2NySLcTVvJLOkamWuVxrQYRDIDjta+OHMlbaxRdy1jlk81QGRs5lYZBYli3ooguj8w82xZ4Ejor/z81uHsD5s4kxCa1eBclm6LgnFvzpntQ8Je32i5ntM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Oe3jm4pf; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5d3e8f64d5dso3087769a12.3
        for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 05:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1734095208; x=1734700008; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ks9DxICgxlU/gCz85Nt643+qsojkXRxw0Z3p4r21hzo=;
        b=Oe3jm4pfsa4rasaSL6ES7p5HrHxEN6/SaWKZOKG3mYyyXeq9SNcOG+8eilqxGO7OZk
         UaId2xXnPB/x3uxJ4Ikw+MlIrDJArA6Q5J4LuRTCFGRpOHD+rFlGgBy/m54vsYR624Hy
         cuhr4XDfVtlKZ7VgWlu0olGuLTjc4Cvk9YoCdRNtF7uPgno3WuQMX4bLRArYsolphbZc
         1YZ4Lne9YrPwjTGnVjZEn/euKk5+rgl9batyB/g3QARNVU/QNp+QsjHslTw85pTepwAQ
         ODrdPudYMM/FdT4UeR0x3Bk8vkqAQXIKgnO3/yJ6lSy+MotDpv02wKxaaf4eHd7Lu255
         SvJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734095208; x=1734700008;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ks9DxICgxlU/gCz85Nt643+qsojkXRxw0Z3p4r21hzo=;
        b=WFC6ZL5DooWEbdoeM+naDK6t4jCzdGpHQkNdpNuu55/JFtNiQL9epmJqd0X2v3H0Nw
         UIGUFLfpLnkyv+mD39zvJlkSEX8eNO08Z9L4UIN5xtV48zxcDXfvG1tSVYhb0l7XhMba
         FmYD3d1v2oJb0VFsyUVGZqNWfxuVWkK191w1CetGBNj0R8Bt42LfAMtJZ4fmXw2i/cJp
         F5Q09zZEicGfkflhFTXWlPRyCUYLzKQ9nQro75gKIJX/FUOEHX0wKLzD5cdaGhjFYi5N
         mxS3nQw+7iy21A3Q+ZlhoZkERlUAjmf5BYKMjSqoJF8LOX4qbah5G74wjAXFoSXKJuLM
         vLnw==
X-Gm-Message-State: AOJu0YyWhx4KTwMFNiKCQlg4mJk2Fg2HMkhB8YYpXg1In59lVx/30PGp
	6NFtqUwn3HZX6V2xoZVAWN0Qoe+yjQ1/VKrRbad0NcsDO01VEnxr31Zp3wp83NYArX7ZKW1T/g7
	isqo=
X-Gm-Gg: ASbGncvlkNGvyhj2sYwDVnHkZNoIbuousfOVDTYPmPRE7hXaDLV9sQSdtmFUkwGzWVW
	6vA9k5exvG1wVkvigxTjmg/u1V1eFasuGuLAdOHeKJT/iQZsJgcXg2zAFA0DJ0iXfs0rOCjV1Vi
	wnRNb/kADSvgvyM2kkkDTbQMSRG2XTZsP+1OI7IzXV+CRsr/WCzwd1jRAHZ9oZuxwzWHS32h2H6
	kXYmNMtxBTsPuFvD1Tx7CjWCV+doiJtbFh35hcZK2JdUnSiag==
X-Google-Smtp-Source: AGHT+IGi0Ivecp5KJPLbfmwXXpWyVpr874E4nNajYZGt+2C76HKEnAVjhEX898dWwyAVYJQyWqD1VA==
X-Received: by 2002:a17:907:780a:b0:aa6:8520:7187 with SMTP id a640c23a62f3a-aab779c1398mr275210166b.36.1734095208211;
        Fri, 13 Dec 2024 05:06:48 -0800 (PST)
Received: from cloudflare.com ([2a09:bac5:506b:2387::38a:31])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa66fd738d4sm837423466b.177.2024.12.13.05.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 05:06:47 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,  Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni
 <pabeni@redhat.com>,  Jason Xing <kerneljasonxing@gmail.com>,  Adrien
 Vasseur <avasseur@cloudflare.com>,  Lee Valentine
 <lvalentine@cloudflare.com>,  kernel-team@cloudflare.com
Subject: Re: [PATCH net-next v2 0/2] Make TIME-WAIT reuse delay
 deterministic and configurable
In-Reply-To: <20241209-jakub-krn-909-poc-msec-tw-tstamp-v2-0-66aca0eed03e@cloudflare.com>
	(Jakub Sitnicki's message of "Mon, 09 Dec 2024 20:38:02 +0100")
References: <20241209-jakub-krn-909-poc-msec-tw-tstamp-v2-0-66aca0eed03e@cloudflare.com>
Date: Fri, 13 Dec 2024 14:06:46 +0100
Message-ID: <87ed2bu3yx.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Dec 09, 2024 at 08:38 PM +01, Jakub Sitnicki wrote:
> Packetdrill tests
> -----------------
>
> The packetdrill tests for TIME-WAIT reuse [3] did not change since v1.
> Although we are not touching PAWS code any more, I would still like to add
> tests to cover PAWS reject after TW reuse. This, however, requires patching
> packetdrill as I mentioned in the last cover letter [2].

Thank you for the prompt reviews. Happy to hear there are other users
looking to adopt these.

Since patches are now in net-next, I have moved the accompanying
packetdrill PR from Draft to Open, if you want to follow that work:

https://github.com/google/packetdrill/pull/90

