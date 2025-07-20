Return-Path: <netdev+bounces-208437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D41BB0B69C
	for <lists+netdev@lfdr.de>; Sun, 20 Jul 2025 17:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0810C188F932
	for <lists+netdev@lfdr.de>; Sun, 20 Jul 2025 15:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2853A1B6;
	Sun, 20 Jul 2025 15:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="Gz79yDTQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE421798F
	for <netdev@vger.kernel.org>; Sun, 20 Jul 2025 15:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753024542; cv=none; b=Xh0mUJS2o5PJZ7vIgWfeiiJquksYQwQOgw8guDSeAUJQlG41UIrEApCBuSNkjz/+B/S/WmhXte2R+uyi+6i/SmoG8Gs+abOS9IIdeE8t0yj/p/DQlWNBGNgkuuPR3kiexapT16txFDrgD0s1SnwT37BAOHhSrTbbSi+dejSgJtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753024542; c=relaxed/simple;
	bh=7vl4d/lJiI9qpP4Nc/RdUlO0ZxiKBqMKdIghyFFo07I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZvzhfB6/v2g2nlvPT5xXB11JOrrzbVz7yisoGhnx38ozmwTyGAHiCDl2+5OAPB2d0cr5nV441C5D1XigsXpAHt5eT/3tW/lkmuVTGWVG8w0vSJfmtCk78bw7U54WT+EnpqFbqQIQ/HlyEBHk4khbkJ1a2/C1XJgAm4D2k4aWQX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=Gz79yDTQ; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7e344e0212eso330812585a.0
        for <netdev@vger.kernel.org>; Sun, 20 Jul 2025 08:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1753024540; x=1753629340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xPwOXugfVF05TRCMG1CAR+67JgAL7wdY3aId09fHpUQ=;
        b=Gz79yDTQMnY1+vCaOkxu3hKEtY9VkEHpgzswGXOGbdNniKtcr2v0vcrJGgS7hPdIok
         d5SgBNate8uvcU6BaQczu5Z8ac/5h3ccfSrZyBf5J+maTS+HAQ27Z3ZRHiUQ3ky0dd+e
         s5Jh+5WTptYX2VpG+3P+Vt6W9Vtdfrn4oyINZF5lFTnRLIFmbTp6Vm+neejO7VlJzGUH
         bdHSNyM3cT0DEI93XMS3KnOXTdSPvsl+r85Et+D4M3sKHjm0NmcHKW+ah1AsjAYV0GZy
         pfQ/NHuC7Lr53ncUz2vxnWN7V8ys/fBV6CFZ8zbhy6zTU1QA/ax5TIlrVKvdObgNUlRa
         M9Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753024540; x=1753629340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xPwOXugfVF05TRCMG1CAR+67JgAL7wdY3aId09fHpUQ=;
        b=mQ5DZBQxlQsf84JnchyCckZWMdC7ryCTI2cf95LNlKVhkr2yk8b6VMGtjnsXN3MRil
         gCVGvPw1AaHQ0lyZ/e68m6U4MyAGJ7rgKClBQNfkcTiM7M17EqZR2f73U+Tm2mOIOO5M
         GcobUQ2aJbF4vtepJttV5Q8OlmD8XNIR3okeQQkCtFRmtTDfs+SXrZ3ZMs3ttJKHmPl8
         LKl7f6cyZIeXk3UJ4qx01D8dNA1AiBcRdfeLJZbl9delHITC5ljv59uI5tcFVVt+X1ni
         IRHdx2cKcF7L8KHDaZS0oHtBYxK6kzxhRPJvLmMIda9W/RKsVuDPZyFGxSFemwGy0/O1
         +eJQ==
X-Gm-Message-State: AOJu0YyaHrHVKMKNM1IxZGSCD+qSqwGBcaU5i2kTLkFN3XEgTlfgtc6L
	8GinqR/9IZhPKpA86zTb92lJ2OmRDbOLsfDCsb3ybu83h5x1vxEo22txrrw4tl2wdPw=
X-Gm-Gg: ASbGncsp1EZR9G/Mv4Sdo7V3Otd0ymD+rGbNz5h9OOgwwHgTPg4Rd5LdxPy6XLIOEnB
	w9cjbi9QkfT8l+OEjKGDFgGEq6genR2cqEvv+ZiHbp05Rw5CQy3+vGyXpYIMJB12+Y9jrj/rDas
	TiMtVleHU3Hwu2ICOpMuN86hlKfEaQyhMje5hj98pMakR+7HJnXGrzflj5Q9jEhWK6EtmGx1Qtw
	8qt/SlBmO2FhGqYkOMQzz72nZtUFGylqVzHRU3X5MIOcgGjcnajPFoS4L24AG0wrFsMk+O4aY3m
	78kXErFVrWGj8CshpNjS+EN6ioowtEA7k1p+M1B9QexiJ9WIHbbFQZljviQQodydv6ytY6r4YIl
	8mq7vMVTNgzUnyYwVzOkjsjoJCEyy+5gHXtEwwxCgF9VevKdYTU9S9IBqdTVA2WJ/mKSaz6HGXM
	Y=
X-Google-Smtp-Source: AGHT+IFBKpsT53VQaPQLlc9oYuH/fiMHBKNeJXaYNpfuQjCshsIj3ors9CHsrLJnXqrdj0lO5QO8xg==
X-Received: by 2002:a05:620a:2546:b0:7e3:2e47:2315 with SMTP id af79cd13be357-7e355548e06mr1616018385a.2.1753024539674;
        Sun, 20 Jul 2025 08:15:39 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e356b4bd5esm308628085a.34.2025.07.20.08.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jul 2025 08:15:39 -0700 (PDT)
Date: Sun, 20 Jul 2025 08:15:37 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Anton Moryakov <ant.v.moryakov@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH iproute2-next] misc: ss.c: fix logical error in main
 function
Message-ID: <20250720081537.0c18194c@hermes.local>
In-Reply-To: <20250719163122.51904-1-ant.v.moryakov@gmail.com>
References: <20250719163122.51904-1-ant.v.moryakov@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 19 Jul 2025 19:31:22 +0300
Anton Moryakov <ant.v.moryakov@gmail.com> wrote:

> In the line if (!dump_tcpdiag) { there was a logical error 
> in checking the descriptor, which the static analyzer complained 
> about (this action is always false)
> 
> fixed by replacing !dump_tcpdiag with !dump_fp
> 
> Reported-by: SVACE static analyzer
> Signed-off-by: Anton Moryakov <ant.v.moryakov@gmail.com>

Acked-by: Stephen Hemminger <stephen@networkplumber.org>

