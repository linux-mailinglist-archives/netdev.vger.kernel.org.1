Return-Path: <netdev+bounces-178447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59557A770E6
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 00:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DA873A82E0
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 22:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CBCD218E97;
	Mon, 31 Mar 2025 22:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="M7b6tEPX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8141DE3BE
	for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 22:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743460335; cv=none; b=UAtOlrxguKcx52EmYAUSfS4+RDCYlJM7KwUwj9LE4DsrykrkKPc0p4/0vwtP4TVpkAXabLXIdagf77Yv8zKePGAocrOZxE2PUwRvLtHjkxVSvkW7x1YaNXEm/V5Bp85AiLT4qK2euUJTNZc7yUe5uPBhUuGP6kBM/H/43/WtVJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743460335; c=relaxed/simple;
	bh=duYComVcSrZm1zivb0WaYUxmTcBo+rXMqqI6zBYJuSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RrLsz6AWRrm9DHPdlE5kvdP8jZU9Fu0sj7rmaqSXSQ3AX0irQDN3FZXt5cFGsBCw3p4KVteDnkl4ouJ7dyfAvOn5YteNocyVWJbADnt3c5Kkl1VHriiXFRIKHuol+sMcabVfDLwvseDHxhHeJwAqHqmOsi90SU5+zgcf5CViR6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=M7b6tEPX; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-224171d6826so66944995ad.3
        for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 15:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1743460333; x=1744065133; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=42+7vZzvv2CakOTy9WwTzv8BPs/2UH1AMqRL6fkeS9E=;
        b=M7b6tEPXIsr38AcJXY3EZWX6gL1xHlmkAJK1MJTejdlfRGgaC+iybsV8KLQRfP5W1r
         qj/zpkbjHqhs/NpjMfUuWZ2LCIHm6NPkga8jFbjn1w5lHrVODzPn/bmTiQB67N4jLmQA
         XXc/YGSDjoV1oi3KMQisSkibJcdKyKqhdY/Kk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743460333; x=1744065133;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=42+7vZzvv2CakOTy9WwTzv8BPs/2UH1AMqRL6fkeS9E=;
        b=mW7ZAIiIgWPJ/xshTLAxEktaYou+6Cvw7kxlz033G6owlZUbrbxW/GCJIrhh08XWOl
         rNSdnEOE5MH7HDHNwYe/00+1k+z0tMHLaeTHOasrKIEiU/NXyKHoT/0eZVdyFXvP9hQk
         626koN38ME5GCNoGIkjXFTAeXqNBCAYd0ChkCXV1LuiOw8Ju+oXscGHupIXCwK27E8Xh
         gHdu+jmb1wVfMWITTEG41OhFQvo/uUog9cu9ra6O6mTN0yrYgne2nOPEBnRBX7qLZ09o
         g9lfYKVDe8PDDlvFS0/4SYvvTASKotZ09lPHWARqqCuAG1o8Nxwkgjgw/1QsM4jFR4h3
         evQA==
X-Gm-Message-State: AOJu0Yxc9hi5ll/HLtCcrAL8DgkeBDf54AyvpsGeiDPEggIq3ejtqdCl
	LcWS9u9ZL5Rd0JDsXCjIhpyHWav9/UJK9mTmksPk2JXHJ3A2eI50E7sDzq+emy5bDp14CqUS5ci
	+
X-Gm-Gg: ASbGncuMcOBokMhsAulH2bjfednaUJss1rq1BUJdyN8n0J8eEr4VxzFf7K7TvHYUngN
	hJmUKlh248roBgjxwVrqf/0XPztbzkDa2yVOPKALMm17HeQIGiB+VI/oIDkcJqttmY24eR2LTMf
	tUQrVaGU/Lucw92p3yInXYQkBjHvGaJI1C+NKCSKiCfeSQpFmWlZ93gRcyNabhrAzEUrUorYpFu
	Oh46MuXhlOMlyEtOyGzyrlcl7YaZ25MZsZvJmKGQHGf11TWRpQkZ+Pf0ON4a9aFRlcBAh1ILXdz
	p9FUteGQnltJOzPUfjqS/GJbfWqjEJ8knGKb+6xLhQGEnbqBTQF9rKFXkJUzWSDh4P+ROhDE/Gt
	D9xUb/JYy7QGbV91j
X-Google-Smtp-Source: AGHT+IGNbfbH3q4AAENJHHgORst/ra/i/SeRQsORO8675vroqpkxmTpWUqZCdVNz26ksHRE6FCMRSw==
X-Received: by 2002:a05:6a00:170c:b0:730:8a0a:9f09 with SMTP id d2e1a72fcca58-7398041c86amr15268867b3a.18.1743460333136;
        Mon, 31 Mar 2025 15:32:13 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739710dccbdsm7765619b3a.179.2025.03.31.15.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 15:32:12 -0700 (PDT)
Date: Mon, 31 Mar 2025 15:32:09 -0700
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, David Wei <dw@davidwei.uk>,
	Eric Dumazet <edumazet@google.com>,
	open list <linux-kernel@vger.kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [RFC net 0/1] Fix netdevim to correctly mark NAPI IDs
Message-ID: <Z-sX6cNBb-mFMhBx@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, David Wei <dw@davidwei.uk>,
	Eric Dumazet <edumazet@google.com>,
	open list <linux-kernel@vger.kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
References: <20250329000030.39543-1-jdamato@fastly.com>
 <20250331133615.32bd59b8@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250331133615.32bd59b8@kernel.org>

On Mon, Mar 31, 2025 at 01:36:15PM -0700, Jakub Kicinski wrote:
> On Sat, 29 Mar 2025 00:00:28 +0000 Joe Damato wrote:
> > If this net-next material: I'll wait until it reopens and send this
> > patch + an update to busy_poller.c as described above.
> 
> Let's stick to net-next. 

Sure, sounds good. I'll drop the fixes tag when I resend when
net-next is open, of course.

> Would it be possible / make sense to convert the test to Python
> and move it to drivers/net ?

Hmm. We could; I think originally the busy_poller.c test was added
because it was requested by Paolo for IRQ suspension and netdevsim
was the only option that I could find that supported NAPI IDs at the
time.

busy_poller.c itself seems more like a selftests/net thing since
it's testing some functionality of the core networking code.

Maybe mixing the napi_id != 0 test into busy_poller.c is the wrong
way to go at a higher level. Maybe there should be a test for
netdevsim itself that checks napi_id != 0 and that test would make
more sense under drivers/net vs mixing a check into busy_poller.c?

