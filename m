Return-Path: <netdev+bounces-220897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E90B49627
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 18:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 393171892F14
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 16:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E2EC30E0D6;
	Mon,  8 Sep 2025 16:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="E5DUSMpC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0C82E2DCD;
	Mon,  8 Sep 2025 16:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757350273; cv=none; b=a8TbWVmFLm+04ChUDfGepbWFhN/YBiZFjY/CB06k7yIyAlpfLswcn9pzTH23xUSfIvVsK8FbFwVugnhXvhFCLrzahWoJhHu6P2+zKYSg+qLP0sJ77yQYmM/EO/pEvcOJ7BYjN8aCxqr4oHFzHg+WA2iNrU3ZId4zJ7jcyZTbK2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757350273; c=relaxed/simple;
	bh=xXWDvVymMYA7ZAFzTiDQlRoZve3ci2e7tM+VCb2yFjc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u+7KDBli5eXmfIplShO5/6UNGrD3KnHDw/OOFQhCLFfbULQZwweJMMfSj/qhXSHZdS9BRAXjOpD0CcjB5nUQKN/ro88o77D3KlfkUskt7bSITjE5Wx2ZMDc8wXgxP/Dpcs9bbFc+Ra+PMtSCLAZ/q+jMGvUrcAQSMmSxdBwabRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=E5DUSMpC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A027C4CEF7;
	Mon,  8 Sep 2025 16:51:13 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="E5DUSMpC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1757350272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xXWDvVymMYA7ZAFzTiDQlRoZve3ci2e7tM+VCb2yFjc=;
	b=E5DUSMpC23neEz88FYltMObzZtXzfFF2SsHWsLiyL7Ar4XXUZWrZdQAKWyK4Dua0sCyzW8
	oDPcxCvCoZz9fQTBl4QCz73BFXLBgvfsB7Br6GabOtvLVo8hEE8bRPhp9dJVJNzb8ENqdX
	iJWxcoVULw7LLSmmYrrzrdmYFppNHx4=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id cb730d4c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Sep 2025 16:51:11 +0000 (UTC)
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-61ea79c1e91so1129734eaf.3;
        Mon, 08 Sep 2025 09:51:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU7LVN/0yfLQ5/S8Bpe6n5ROd1JX6DPJjwTK9jijnzJBKJn+n0A/X0p23GZecsWJktkD4tzGQqp+SRCttc=@vger.kernel.org, AJvYcCVLEzhk0j7Oun0BX6l4uunAdKb7Qtdxl2zwlAovJpsCckKC8J2rlLCWjo97BeEfoYjnMnJz6XOZ@vger.kernel.org
X-Gm-Message-State: AOJu0YxmUel6397DiPNuhaXlOBfjjE2RDVq08J0B15/MgAmbNTetAGFq
	zFg8ysTh47OptXhps3J5fjiGrvO9knHs5yPRcBkAT+lhyOA0bhenqaHkTKtIaZ+e8r7FU7T1oDm
	NNfWRjq3VlrYyDQs4zptbmcRnd7o7hBA=
X-Google-Smtp-Source: AGHT+IEIXB3taFnFRE1X8N/g/4h28EKNkcp5HSevCEifdzaf2Qt7TRstBZ6TcHCiXUIqym/JQbhnieXyX3EHlM10G54=
X-Received: by 2002:a05:6808:6a8c:b0:438:2767:6941 with SMTP id
 5614622812f47-43b29ac5a1emr3505387b6e.25.1757350270805; Mon, 08 Sep 2025
 09:51:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250719224444.411074-1-yury.norov@gmail.com> <aJdL-5t9va5Ln0xv@yury>
In-Reply-To: <aJdL-5t9va5Ln0xv@yury>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Mon, 8 Sep 2025 18:50:59 +0200
X-Gmail-Original-Message-ID: <CAHmME9p6VBKr67UyP+qkazUg3+zoX9Aj+_42BGuAprBewOgr9A@mail.gmail.com>
X-Gm-Features: AS18NWBTIimdNnwY7GG9qQ7DBuoAex7c3in2WUQB_jza-ecUhou3mlzuDbzD5Zw
Message-ID: <CAHmME9p6VBKr67UyP+qkazUg3+zoX9Aj+_42BGuAprBewOgr9A@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] rework wg_cpumask_next_online()
To: Yury Norov <yury.norov@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, wireguard@lists.zx2c4.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Applied this series, thanks.

