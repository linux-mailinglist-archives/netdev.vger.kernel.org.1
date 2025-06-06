Return-Path: <netdev+bounces-195438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A66AD02CF
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 15:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2EAB3B0DF5
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 13:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E54288504;
	Fri,  6 Jun 2025 13:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DrUA2dvq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1045E28466F
	for <netdev@vger.kernel.org>; Fri,  6 Jun 2025 13:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749215284; cv=none; b=hafKLT0oUM+kGTT3IsdfigcX94yYNgr5dHtxb6vbHkAiDF2E2QJcpfvjdTYw3PvyQDEA4VkfhQzmpAor19dzyNRTctLW4ioOGJUuphEEw80bT+IIK1dVCME3u/qqAftYLuxfL/HfDfUS2DVPcpnMl6XcuWYENKKSzQYlmjqKB0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749215284; c=relaxed/simple;
	bh=EOWqdgIPqSpDLxMO8R/WdQnk5vy8hSN4spzqqLmFX90=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=dn5L66PaXFfrn1inl+a8GvK80woIIFM9Q1nKgJLnjAScZFdSF3rSX8DKwZOHTRscyZ0AO+uKleuoPab+I4miIvQDTQyOdNZ+0On12cpL7zQDj/6YzU4ULQJa8H9IRPwIXzun8QUEVnWeMgdNTHwkjr2p22Cel1yfMHMxbeiPTPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DrUA2dvq; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-450ccda1a6eso19537065e9.2
        for <netdev@vger.kernel.org>; Fri, 06 Jun 2025 06:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749215281; x=1749820081; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pDpGTeNHZVtFNFtv6rlpMvdaxxGb1RkmeQRZ+n70MEc=;
        b=DrUA2dvq2htJn4ZS9qPeahsUbPkpGXCm3Cc4HSFTSTfwkRLBA/P7ZTREgn/1zfUrMG
         skxi8GovvhbLc2Brbe1mI5LchlrAwSU1RW8tGwI2NBY7Km3Hcf7d2RDV6jaIqzr+4Xar
         nxIlmGHvE9+S5F32dd+MF9u3RdMJY2TBBO9G0CAotySIz0OwNxdyLnq2/gPak963LE13
         WfWg39m4LfdJ8jorA6RYzUuWMBlt146cvcYz47BxugSHDbEiAgEx9EGFXiirdPnEb/GG
         clkethy5oQPe4m3TBPNKBOGn5BSH1pDCipBeE8ZWSMv3V/N9eQD9lBhLPQU3MlpGYfIm
         NyMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749215281; x=1749820081;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pDpGTeNHZVtFNFtv6rlpMvdaxxGb1RkmeQRZ+n70MEc=;
        b=pSdbOjsGQnYizQBwwFo/6ZoI1V3a3hzxDEKrSPqvBttrUSBClQpRfHUTZEErPTcNRV
         T1lfmu84hwDMXI9HwEkSDCY2hxbb7qV/YvVzS5iUFWYGeuBUtUD6BCdqd05tYN8pReKN
         6CYpIXiMwYezpo9s6OFUp8ATRcHQTcbccjv9Y+BhD1jSe3oAS/noVAB6Ye4lVJZEkNZp
         MuTweWk+aSVP5sg9fj8E+MCQDAizBmb/1Nno+7QosvWaLs7SouvtmLLEfgiCJT4oVh2U
         icHxckwIo8+mKGgmeTBvvV5Ug9oCBRBXYssd0yzC5c9ObqRiQZRqjW53atXSX5zHc8yq
         uz/Q==
X-Gm-Message-State: AOJu0YyrXW3Sj+8U+GprxJCrT4KkmAriGFdaoe1kw6tFpIc+3m1akebl
	SDGFUVdMeclAKGruhUs6OChjXLV98mCzySRjqbxF52r73aYFT2zKo+OoqxDkaQ==
X-Gm-Gg: ASbGnctg/cCdqxwBigJOd3QOP5oB5VCIPnzE1IL4qdd+2IK9nj4yex4qY25DnLN9L5M
	llpvT7GJwm7odEyUAdkH2+Wy/a9vqy3onNY69Lkd60KFeGEic7KVAVzTSMV/Fw+OKwNXE/2XjJX
	tJ8ZCSTxoxVHo1FYdeQhEYHFaAk7hawkqFekA9VpGmdz2fUVW5r+afUSudW9+HEcMTCKfELfa7h
	cm8I+IcB/vkqSPvTqJpqciSX/mejsG31DLo9hb3573RoI7B6qzxuQXRYA+nItZsqRpbIgL5q14E
	TC+a+2egIBzzrgDmWpFhOG1S7L1MaiLAF4MveN2PF8j07V9Rlhvk/SehG+JMdjlZh0IPpPq9fi8
	=
X-Google-Smtp-Source: AGHT+IGWRq5xd+CoIYvzk/gLT/OIhZ31rTBGu2iA5dWsyBe5mttH5dyiO4a9ANsvgnzriInq90xgmQ==
X-Received: by 2002:a05:600c:8b6e:b0:450:d422:2092 with SMTP id 5b1f17b1804b1-452014557d1mr37247255e9.8.1749215280838;
        Fri, 06 Jun 2025 06:08:00 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:75ef:647b:5225:9c1c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a5323a8acasm1814662f8f.26.2025.06.06.06.07.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 06:07:58 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [ANN] pylint and shellcheck
In-Reply-To: <20250605072638.57c56f95@kernel.org>
Date: Fri, 06 Jun 2025 14:06:56 +0100
Message-ID: <m2tt4tt3wv.fsf@gmail.com>
References: <20250603120639.3587f469@kernel.org> <m2ldq7vo79.fsf@gmail.com>
	<20250604164343.0b71d1ed@kernel.org> <m24iwuv9wt.fsf@gmail.com>
	<20250605072638.57c56f95@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> On Thu, 05 Jun 2025 10:02:10 +0100 Donald Hunter wrote:
>> Jakub Kicinski <kuba@kernel.org> writes:
>> 
>> > On Wed, 04 Jun 2025 10:41:14 +0100 Donald Hunter wrote:  
>> >> This is a possible config for yamllint:
>> >> 
>> >> extends: default
>> >> rules:
>> >>   document-start: disable
>> >>   brackets:
>> >>     max-spaces-inside: 1
>> >>   comments:
>> >>     min-spaces-from-content: 1
>> >>   line-length:
>> >>     max: 96  
>> >
>> > This fits our current style pretty nicely!
>> >
>> > One concern I have is that yamllint walks down the filesystem
>> > CWD down to root or home dir. So if we put this in
>> > Documentation/netlink/.yamllint people running yamllint from main dir:
>> >
>> >  $ yamllint Documentation/netlink/specs/netdev.yaml
>> >
>> > will be given incorrect warnings, no? Is there a workaround?  
>> 
>> I don't see a workaround without some kind of wrapper.
>> 
>> Maybe just add a makefile? Looks like that was the approach taken for
>> Documentation/devicetree/bindings
>
> If we can live with the document-start annoyance I was wondering 
> if we can stick to the "default" as is? We can fix existing
> docs slowly, the patchwork script will ignore pre-existing warnings.

TBH I could go through and fix all the warnings, including adding the
document start markers. I can automate most of them with perl
one-liners. The rest would be a few minutes of editing.

I could have patches ready for the merge window opening. What's best, a
patch per type of error, or some other split?

