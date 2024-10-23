Return-Path: <netdev+bounces-138343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E10789ACF79
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 17:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9756328251E
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 15:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C420D1C9DFE;
	Wed, 23 Oct 2024 15:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="IFy5RIRN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149F5211C
	for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 15:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729698741; cv=none; b=acrXlfYOyMktMzR2itTTA9RdCHEK90f9i6kmRbiWFt/3Nx+K/TuPG/nBkV1t+1x+QMz9vas6UJzNhFFJSz/ohj2qsSBhV2VaQfCmTPOsCsXkMIDv5R9FQY07vXpRDlWkX4CtkyldBCDCtpy2IgGSZijQ8qEMkbLCDLpVTqzXi+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729698741; c=relaxed/simple;
	bh=Q0HhChkuAOMiGqgLCi9k3qQRT4GVsbq/WrGe5iCLxYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lwYT+fpkyK0SazowkNsCgH9sle6Frx7Pq71v8UQanE+RE2Fwg9s04ljMrxaAAUtfNJCwwTgN9bKLiemMXTvJSnNj/DLRhQeAOJf2qtpNamUFd9LbJyjULGsxzaAu2mbrjzismjtQLEv2TcckQnA+gCeu5thXwRjpOXSdKY8JJKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=IFy5RIRN; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7eda47b7343so481926a12.0
        for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 08:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1729698739; x=1730303539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cGZRq6HNdePI3aKDMXBC35e4DvlTylB9a1aT7ju9Ds8=;
        b=IFy5RIRN0GmDl7EcoeJ/iMzku7P58tOP9FznSFQGCNouvHJEc/Zt77SU9sud0e19ZJ
         ZDGWiC/7srAgUr92ytElOTy5csZXAvvccRVT0hyXz01HVv6cp+/rCGLRZqQ5p6PuUwT7
         oWmZJ4lDidUdFrPSq3jxxZeXuavQD+Kg1ekKjP8HTP+/HCaPHuYQVp68bf9qbWNLnVj9
         0OJdajE+ioz6YnIF591JrJhWiTU1slzqtWT8Tau8fp7gKi+40bDEeWO8Yjir1IAjoGEr
         RkHG3jyzgTKTO+tYthRb7ceeO2WKMC/ipkNOf4ABmatFOF6i7gLQPlvodPgeDQAVoL+3
         EmQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729698739; x=1730303539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cGZRq6HNdePI3aKDMXBC35e4DvlTylB9a1aT7ju9Ds8=;
        b=MNqYPeZWlZmt1QwW66ocASUM/4+PpE4xkgU1xaiM3yN59TW6OPLALDn60fU4imQ256
         tUX6Darg6zKQ8r51g8yrF01iEZueRufrJ02zf1OnAMysXwKrNK0brT29cBljbfWCyEON
         608hXpx6V0sKp96Tcb/mjVkqBVu/zAYf7g28zeY8SOO7WXgDIjEozIOvAGBaU5o62PWm
         RIo5u9aijTuxzBO/yGKUq8xdu2XCw6s11LQ9I3h9wCe0/91yz2a9BH1Ixx3Cuo7mT+KO
         Y3yULg42Aa67lG30u4+RDTmwCHIuxoqwUai08DYpFaC+0uw/JePVdv25WpENJfT/vCIA
         JOHg==
X-Gm-Message-State: AOJu0Yw6PxuoIStW80Zyvq3XBMXR7lm8CaBCVqpUfiD1N90geHluJpv/
	Bz99eNGaRcbTCWpoEXcuRdMlk9rPxB6BxHjbjw/kK+gb+HAtP7brPeVzst8eBz0=
X-Google-Smtp-Source: AGHT+IG2E1iFIynQ1I/9rLqJ2VipTrcoQGOg1lDnBa++bxJWKSEWaR3OZDmNcVoB9V9klWC2BVmuDA==
X-Received: by 2002:a05:6a21:1191:b0:1d8:d3b4:7a73 with SMTP id adf61e73a8af0-1d978aebeacmr3511111637.4.1729698739276;
        Wed, 23 Oct 2024 08:52:19 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7eaeabbca78sm7047364a12.58.2024.10.23.08.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 08:52:19 -0700 (PDT)
Date: Wed, 23 Oct 2024 08:52:17 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: chia-yu.chang@nokia-bell-labs.com
Cc: netdev@vger.kernel.org, dsahern@gmail.com, davem@davemloft.net,
 jhs@mojatatu.com, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 dsahern@kernel.org, ij@kernel.org, ncardwell@google.com,
 koen.de_schepper@nokia-bell-labs.com, g.white@CableLabs.com,
 ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
 cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
 vidhi_goel@apple.com, Olga Albisser <olga@albisser.org>, Oliver Tilmans
 <olivier.tilmans@nokia.com>, Bob Briscoe <research@bobbriscoe.net>, Henrik
 Steen <henrist@henrist.net>
Subject: Re: [PATCH v2 iproute2-next 1/1] tc: add dualpi2 scheduler module
Message-ID: <20241023085217.5ae0ea40@hermes.local>
In-Reply-To: <20241023110434.65194-2-chia-yu.chang@nokia-bell-labs.com>
References: <20241023110434.65194-1-chia-yu.chang@nokia-bell-labs.com>
	<20241023110434.65194-2-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Oct 2024 13:04:34 +0200
chia-yu.chang@nokia-bell-labs.com wrote:

> + * DualPI Improved with a Square (dualpi2):
> + * - Supports congestion controls that comply with the Prague requirements
> + *   in RFC9331 (e.g. TCP-Prague)
> + * - Supports coupled dual-queue with PI2 as defined in RFC9332
> + * -

It is awkward that dualPI is referencing a variant of TCP congestion
control that is not supported by Linux. Why has Nokia not upstreamed
TCP Prague?

I would say if dualpi2 only makes sense with TCP Prague then the congestion
control must be upstreamed first?

