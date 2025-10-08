Return-Path: <netdev+bounces-228278-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A53D4BC625B
	for <lists+netdev@lfdr.de>; Wed, 08 Oct 2025 19:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 478CF1896CBA
	for <lists+netdev@lfdr.de>; Wed,  8 Oct 2025 17:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83DDE2BD036;
	Wed,  8 Oct 2025 17:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ui4fiZw/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A13214801
	for <netdev@vger.kernel.org>; Wed,  8 Oct 2025 17:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759944731; cv=none; b=HBlBJED29uJ3+mOZr2SSLZVx8NFQ1Y7RUk0tWYrie+78IexY//yUxYgjW05IvHIBI/CU66mDijUUdxN3/cf+hsrN7FojbSgNdzKet9FyjRpHvWlIOCMri9aA9vNVSy2dRP/jzOUKz0rwu5NsJ3kALdaCK20+Ge3nsFX6BAtlMpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759944731; c=relaxed/simple;
	bh=R6F57YDITyqieFRSeJYftHE+oqSvEakx9pph8j301Tc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UV7FB9hUIBfWHPRykTaaECIf5xI6DozByTxpd3SBibxuDjUf0TJ30k3gVvuaGgpwkLlAz315uX1JEaSzxGu6ST8/kiuhZVAx5ADW+64c+5QFR3BfGd0blmu+8pp2NzxV0vmSD3M5bPFq+fDi8QUzcob4FZLxGQqzf7L8ZE/werw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ui4fiZw/; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-887764c2868so3427939f.1
        for <netdev@vger.kernel.org>; Wed, 08 Oct 2025 10:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1759944723; x=1760549523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s07bq3yefwfB+/Gr+LJUgvY+fKCLyAq4B8pbnxhVLw0=;
        b=ui4fiZw/rGVErBEQRgobDqtWl8vWgZ+tQLOUBlxmj01ZYuUCIUd7SePdzBV6ZSDVoy
         unr+a0tIsuecdeSdcX5MYc6LZ/YS6iIU6zCY3xyfnSMrEWcu1tdKSxQuZOy2GX+y21sz
         JE0CybEsgihe46JB4KleWdXgza5y3KsaYQPFHj8ScXaHG1JgOsRMqbHnN6GcjbUDlpau
         /QChKsSXNomrzyCPX7Gupj2QCTPGMlDM8OYMskJ4ezUQKWWh5o5dBri8pYCizCdLjp2f
         X95G7RelTxsORt8RqZtPbgGTS2kOvZ89cQNfTj7i+mvrWQAu538TgdLWLm49+BsbzIrC
         OUxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759944723; x=1760549523;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s07bq3yefwfB+/Gr+LJUgvY+fKCLyAq4B8pbnxhVLw0=;
        b=OtHvr7qrJBOGxjA8biYfEE6lwl/lkvARC/94IZfrtcL/dB/ljI6/7z1JD2RfL7Efnx
         xmWcZR42k+x6BkpDrmOhQAavrSgByhI1/B68nJM47ypWu6sY6AurDnGQucQdt6g9Ahc+
         /2eTY9j1JiXh5fmjGJrmWEstQNYL+zu7CliIyoy59cXsOlRSqluXMahri9VxHAj7i1Ri
         0ibHZbZThKVYFGbuM0qLFaqzDI6Sr7pyw1LyLZdz5km8WcIrO3uWDNWbgYczHWCRakHm
         Nutnhv8l3oZ5m6FoxdGwmuJXETvHBAm8tb6DTKytFZgZ0S5YhkPhww0qqfF5a3zfAwyB
         6Wvw==
X-Gm-Message-State: AOJu0YzzAAHnRSoNS7JZ49dBy7REZkfZ+Egj8T8cLWGtT5D7vVMJVDNW
	9Q5m+zOMtJnnxVPKcjmVSrT9iTzUFNS/AycXEVG/Bf39wB6Y9jvYZ8lmOr/ObVUtRgCRcPDCxat
	JJ0Q53bw=
X-Gm-Gg: ASbGncuhG8qshtySH+MEpEHRXaNoMj/RRVLpMB8uWUIm5pb+dubnk+asRM5UWRF4F52
	qKxriveq/LigbqNPDgnEPg/xOJ+xmCoaFBkgogqjoLYycWJnEZQ7D5tfIzSYr5oeGVL5v6lrx7y
	TH2KmTVtOx7Cz2+htSm4UrcNASIrNip1hhE2wjoRp8BJdzW53bFs0acRcRdKCGyV2UqWgZZvZYd
	qfVYeOihjeP+VY0WFsLfktzfQIKZzR+o1B51qnqYiSNY/rjrgoHNc12eUsyfGVCwEZ/wLnzjgxa
	J9vu6hc0Q71eJAKjySJypw0unodiVG4l142lyctnJC6yPOUPoDoIFNgh6HnOCRyrIuOKOK6u+HL
	kNhYHNX/pR5iDR7yiX6jzsnsf1alFudSdoqRxQw==
X-Google-Smtp-Source: AGHT+IHKT/Ts5Q1f0eBOyGJ/SqRQvtvv14mZDbGopPP+3ngExKSfBHL0g1I+xOXweyXm4CrMKSFCpA==
X-Received: by 2002:a05:6e02:1806:b0:42f:8633:bfd3 with SMTP id e9e14a558f8ab-42f873fe7aemr41500515ab.25.1759944723118;
        Wed, 08 Oct 2025 10:32:03 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-42f9027872csm1366205ab.10.2025.10.08.10.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 10:32:02 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>
Cc: netdev@vger.kernel.org, Matthias Jasny <matthiasjasny@gmail.com>
In-Reply-To: <b0441e746c0a840908ec3e3881f782b5e84aa6d3.1759914280.git.asml.silence@gmail.com>
References: <b0441e746c0a840908ec3e3881f782b5e84aa6d3.1759914280.git.asml.silence@gmail.com>
Subject: Re: [PATCH 1/1] io_uring/zcrx: fix overshooting recv limit
Message-Id: <175994472198.2061199.6935762244237340434.b4-ty@kernel.dk>
Date: Wed, 08 Oct 2025 11:32:01 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Wed, 08 Oct 2025 13:38:06 +0100, Pavel Begunkov wrote:
> It's reported that sometimes a zcrx request can receive more than was
> requested. It's caused by io_zcrx_recv_skb() adjusting desc->count for
> all received buffers including frag lists, but then doing recursive
> calls to process frag list skbs, which leads to desc->count double
> accounting and underflow.
> 
> 
> [...]

Applied, thanks!

[1/1] io_uring/zcrx: fix overshooting recv limit
      commit: 09cfd3c52ea76f43b3cb15e570aeddf633d65e80

Best regards,
-- 
Jens Axboe




