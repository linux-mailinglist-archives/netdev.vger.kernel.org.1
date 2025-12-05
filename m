Return-Path: <netdev+bounces-243823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 69643CA80EC
	for <lists+netdev@lfdr.de>; Fri, 05 Dec 2025 16:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6F4AA302CC35
	for <lists+netdev@lfdr.de>; Fri,  5 Dec 2025 14:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA4933A032;
	Fri,  5 Dec 2025 14:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vqc62u/b"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1A530AAD7
	for <netdev@vger.kernel.org>; Fri,  5 Dec 2025 14:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764945491; cv=none; b=HFDbH+Ct80f6kvmzfTz0Cgtjej605XLR/HsIaW45rixL33Dj12Oh+y/3cH98sQrzfzdCmXfGpJRXeY/a6d8dzTvAOcNNJc33M17UnV2Uow9XCeOOJdiX+eavxvdETwmJvTh4ffIfg1sgNIRKkZXcXhafKp4KWZ8vNj/tVSJLB98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764945491; c=relaxed/simple;
	bh=tn+3B6R/RgOoCp4dm+NVRcArD/KACN8EfOP1kLRRy64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EA3dEoqdrjJCC2rekQWcFkQQ4wHm2heMwg8p35AlAjg0oEomsG/QJUL+Q6RDI36v6rngM4Vtgo2+ci8FKsk/n/ZrrPzzWAVBil/V5P6bgyCd/7tuC9wJwkJJd8g6bCsIpxFtqhLiMSiO1sLugCqhab5fzEpuAm6BrGV5JrD1jAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vqc62u/b; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-640e065991dso1638852d50.3
        for <netdev@vger.kernel.org>; Fri, 05 Dec 2025 06:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764945485; x=1765550285; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rZeX/t9XBIstd9pSBZ5++UMA+6ZEbyBEMYNpSCQ2HHE=;
        b=Vqc62u/bDEjcS+dAYdKP8nOg1c5jcic0EOqiQmX2dm2zZCR/tFQlCBQtj5qyzyJqvV
         dgi5ZieEqPZEM6SrzYWjY5dLEIv42E1+PWDxeKJxZvsPkBpUSZQFR6cPuCt2v4mAuJxW
         8axMqUhLfXNwip3DMeEkKRs2siLif6uHYE0+oH+gvyh8waYGHoINpYiFko4e6gB7fl5K
         roGREroimV4LXBXswH+stzkepiRUZUa4WSlCyA0zEs8vTsY5Fm8eQcFao54UDlhfPS94
         wjmBZ8fzIKGLApitfI3YxZdkS3KHIiyTndBUAY6Ps/MQ2zgOrNGRE1fw0/GkWBS+6n/d
         QB5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764945485; x=1765550285;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rZeX/t9XBIstd9pSBZ5++UMA+6ZEbyBEMYNpSCQ2HHE=;
        b=eVLJY2VYdGtGP0bWu9pY5hp8LJ1xQMCC+EzzfVLfm7STQ37K/7ZYHJ6ubMrZ3EsZEF
         YtcGDadtlxpi+pIhLWL4mub/lYF95DGpVDUw1eT8XwYYtf+M1sOz9rv3MVgJmqCNtxSr
         l3zhvCMfgUie/yBuHjgfYiIm/OtCjlr6gLVZzVGXbw9cIs48L7aCvbrAUIfPEhVRAis0
         A7C6CF3YyTSUCt9SiFvUKApXGt9ibbR5cv8NV/RSwUqIKdHtsHxLQYeCINjGoureNDlX
         Q3lfqnFWevcFsJV8mEQsx+3yuUKDeP+m77OcjiA8YM6vILJr8i2FapzKyOAUYBJ7VcMa
         Lnbw==
X-Forwarded-Encrypted: i=1; AJvYcCUjCz3JQM/kv/yQCC5XVANFxKDHMrAinG+l6NGkhY7L/OWCkfmYhMCoSLPahFYRHaK6DZ3BNkI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqpbklP4LlS1S9dgXCa15g9EEGYcFI1TByh/oYJSFUbE2tMNsR
	bG5+ITcSXTFoVRpRE2e7C2KLJWKHaTCJO6tfcSGU6EomqVaWBCfTewjw
X-Gm-Gg: ASbGncuGYopt10qk0atijWi7UyOYnPaSL44edMnZEw/p5K/7Hh1s3kh71ncJEQvsh6o
	kuggViRtAchH/fudiLdxAo7VGAdeEIAzc1KCwkgWkdOJeEE9lQydQ6YWvu8t6M6HpvFtw2lRLpU
	W5EDXC+17D13LFYm02ksLn6R3QnKZlPZ9cpIYYZqqiVpGTmpHIOf6+/zy/9asjon/QPS/KS44Db
	Ze4DFIZMAcIj7fEOIvqYYcFjCvAYkQTBoZn7FlJhzLpmGdVFrJsJa7txzbqyGaYB4z/VDvE0M2f
	BB+Y+5pnyfPcLnYkIQKG4Ck+c1WoVUM2wzMCSFPcFQvVQSv1MISq5AroPXXgjwLkiidIm7URzX+
	S0/OZsyfa0qmMkd9fbB1oOxQiKeMTYkpwGxh+sAMUwAFalFtwmsx7jFDMk3kNCD21ioFvZPcRRd
	9MWpZ91uzMN3Qu719qvLpimn1EMZzLuA==
X-Google-Smtp-Source: AGHT+IHZolp98udP+u1AjHHX7nPNhJRkfNJpkP0YtwmKdcia0YfdLvMiUF1UHkN2//HLsO8YP+Ij8g==
X-Received: by 2002:a05:690e:12ca:b0:640:d038:faf9 with SMTP id 956f58d0204a3-64436fab5f7mr7781946d50.25.1764945484906;
        Fri, 05 Dec 2025 06:38:04 -0800 (PST)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78c1b4ae638sm17499737b3.4.2025.12.05.06.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 06:38:04 -0800 (PST)
Date: Fri, 5 Dec 2025 06:38:01 -0800
From: Richard Cochran <richardcochran@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Paolo Abeni <pabeni@redhat.com>,
	Rohan G Thomas <rohan.g.thomas@altera.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	Fugang Duan <fugang.duan@nxp.com>,
	Kurt Kanzenbach <kurt@linutronix.de>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: stmmac: Fix E2E delay mechanism
Message-ID: <aTLuSZugpZDNCRzf@hoboy.vegasvil.org>
References: <20251129-ext-ptp-2v-v2-1-d23aca3e694f@altera.com>
 <26656845-d9d6-4fd2-bfff-99996cf03741@redhat.com>
 <aTFuJUiLMnHrnpW5@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTFuJUiLMnHrnpW5@shell.armlinux.org.uk>

On Thu, Dec 04, 2025 at 11:19:01AM +0000, Russell King (Oracle) wrote:

> Basically, the conclusion I am coming to is that Synopsys's idea
> of "lets tell the hardware what _kind_ of PTP clock we want to be,
> whether we're master, etc" is subject to multiple revisions in
> terms of which messages each mode selects, and it would have been
> _far_ simpler and easier to understand had they just provided a
> 16-bit bitfield of message types to accept.

Encoding the PTP role in the hardware is a fundamentally stupid idea,
because it makes changing roles (which is a normal and expected)
impossible without losing time stamps during the transition.  Some
early PTP hardware designs had this defect, but vendors figured it out
in the second generation of cards.

Thanks,
Richard

