Return-Path: <netdev+bounces-132393-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F9D991808
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 18:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA4E31C21123
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 16:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFAD115445E;
	Sat,  5 Oct 2024 16:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="dZz2Cgnc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A6314EC62
	for <netdev@vger.kernel.org>; Sat,  5 Oct 2024 16:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728144178; cv=none; b=emQ2PSx5FxbnbL8Dew0N69NG4mfvX0uTGOq6Uk+WLGcFi1BL/pXcRygbhYkaAZRsioDBKHGtDAsC1yFCmnwPXrocifyQnDr18CrAmvT98Ixxhhbq1tRknLPufRTvw3MQ0FS8S/2FknEBrdkt0UKoW6f1MZXFPVeZjSjP63uLPtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728144178; c=relaxed/simple;
	bh=P96NNNXTpeZp+/TvYSSSMShLVn2wSDJIGBC9JsBXQaU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IyxJw+U5dazqiSjaPkyij9f6JJvrXVNGjpCI+A05EIoh2TeUGXlSGgEEQxObOAtu6+DBAA8RrsQ/DY2YlgQ98KCcZmPfDkUqmimGTNL5vZNwMIae00NU1AsoE2ETOpSby447ie4f86aMjKZdBT/vT/t6fxJMnYOAGl2rUutwBEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=dZz2Cgnc; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-71dfccba177so54608b3a.0
        for <netdev@vger.kernel.org>; Sat, 05 Oct 2024 09:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1728144176; x=1728748976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lLU03qWsoTGbgLowENUQTK9xntnjk1tBjyUQ2TfFmuM=;
        b=dZz2CgncGjOJmMpDN8ljjdl6e6p6tWCL89mEO9l1qPHheJab+Ms0SqokI64GuvNds6
         GxaUuH9EbN4F/z8QkOzfgIXlTINUbKffyaOTCIEAOuV3079SyghhpSmskOl1i++58h5w
         MLVkCpT0JW9LgN6+SP51xOGF1yNflowWwy4ZqC2y290w66qbMAueOCFTVwlN4eSvZRSH
         HvEbKvT9g1qVoPxavSxunCubng/eDDDcvkoZiwS/2Klranc8+aN/u1WjonUiJ72M/NRA
         /pBfaiqYdqyaGEx9H12RZ5tW2wm1BN9Fqm7sEY2Y9FhuZvGqMeXdzWx3TYlpJpBREejC
         vwOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728144176; x=1728748976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lLU03qWsoTGbgLowENUQTK9xntnjk1tBjyUQ2TfFmuM=;
        b=wQRAse3drfgtoA+uSoOw5cmoRMQB8UaULTjh1G4Ss33NwHayF8QDoNhZxGStsQwl4S
         Aih3IC+WwdV/XvHYom0uSr81KPwnx5wvo1uGQX5IsCO5vZX2whudd+K2cJclCmgIzbul
         t2I3H2obsgticM28VZQH0EOAFc0AOOAU8LbpXQ13hBl8pGSLvzCjTy3RmFrfA9kFOclU
         JZ9aWT2LKowuFTww9r8HkiwdGwxxAWGFZTPABsdk8hleL5IovtR2iyOsgK0j4FQ3LL6/
         wzisgO6ZVWjgttYntWaxun+pbtRSIz5X+ySabeusU9xa3zuot0i+21gbn8Pe1ETHLqZt
         h1nQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOxzNjU8bCbZRusij0YcL6t/0kJS5zezs5DzA5OooiOuCuXnk32QLkLoHIEoOp1cUAQWJSw90=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWh7Q4J0ypWPmcuW6ByPlbeJiWTeErJx5sWpaLND7Vru2kb08j
	3LHHjyCU1da41H+L1+fc3ArmraFdTv/zz2i0Zi0UAy1buDU+n3wjF+wTDGtC7vM=
X-Google-Smtp-Source: AGHT+IHLG1HZ+xjOKr/HI1dY3x26Hi/gIgjhVbKySgj3xyKKq/K+KzAFkE53nmeerzLzcxWvx4mUBg==
X-Received: by 2002:a05:6a20:7f95:b0:1d4:fb97:41b9 with SMTP id adf61e73a8af0-1d6d3b01314mr15366179637.22.1728144176258;
        Sat, 05 Oct 2024 09:02:56 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e9f683eddasm1635619a12.56.2024.10.05.09.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 09:02:56 -0700 (PDT)
Date: Sat, 5 Oct 2024 09:02:54 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: martin.lau@linux.dev, razor@blackwall.org, kuba@kernel.org,
 jrife@google.com, tangchen.1@bytedance.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 4/5] tools: Sync if_link.h uapi tooling
 header
Message-ID: <20241005090254.061c1317@hermes.local>
In-Reply-To: <20241004101335.117711-4-daniel@iogearbox.net>
References: <20241004101335.117711-1-daniel@iogearbox.net>
	<20241004101335.117711-4-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  4 Oct 2024 12:13:34 +0200
Daniel Borkmann <daniel@iogearbox.net> wrote:

> Sync if_link uapi header to the latest version as we need the refresher
> in tooling for netkit device. Given it's been a while since the last sync
> and the diff is fairly big, it has been done as its own commit.
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>

It would be good to have a script to do this automatically, similar
to the 'make headers_install'. I use one for iproute and do it every kernel rc.

