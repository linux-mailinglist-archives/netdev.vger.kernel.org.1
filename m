Return-Path: <netdev+bounces-82612-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 606B288EB7F
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 17:43:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91D4B1C2D0A3
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 16:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E45E14C5A5;
	Wed, 27 Mar 2024 16:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KsYhzRtb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7675013CA9F;
	Wed, 27 Mar 2024 16:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711557804; cv=none; b=ZxUmQGJ/2EaUjG6IAXImLV63Og0TyE+O2k1VARKzw6l3ImZu8mO77RpXQx7NhGI48ICnduU5SRSw2w7ERzq81dM4035dKQByVY2G+yaYEhiFovx8315YXxce4hRPjVRQwW8sFXX/x9FLGlF6hPtVNIbXifW1ZLxWWYVJCZ4x5lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711557804; c=relaxed/simple;
	bh=kkpBgw+PGeHvzK4ajtdUqeLrFRz34j8tMZSdLL0WpaE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=K9uVWMLBegyVTgBxk/BBX6RlKP6BFnjygese9WMfrHI0qQX7QyfwA3YGvpu7aYcHiB0L+fGhiicZABilX6I90DMHuzEqM15/Ui5IpbJjk/QBDCDxp2D2eh5zGw3rPKbSmFwcXdDC7LAylPx9CtdimUcAQWPlJ0q83F1ABHbQt9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KsYhzRtb; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-34175878e30so5002721f8f.3;
        Wed, 27 Mar 2024 09:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711557800; x=1712162600; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=T5mirojkTcTgwKJGaOK9ct/ombmL5I/keJNO+8NwWkI=;
        b=KsYhzRtb0KBfge5N4nWK9P5ak+r6N7RAlGjxrnW3YX4JpwBNGoL1zxf/9cLnmYEKZZ
         CpT98ds//LfmQRF8WjDJfoKatg5DArJCsQjyjorNPqQKhDEs6LJW3nI5P9ULBFFAoq5W
         3UBEcgDI/OHNswiQXVF4QcTMEioVWR4NKiRtlD+O3DOEDPAKS+QEv64MwUiEKuIeq4Df
         0aILa89+6Jh7vWs1VJjolFF/DOMNaocjfF/htp/gkEy6rxe3/tMi3HE9VF6qONKr0MCS
         w+6dDC8RWi04N3lMEnPCyjJeZEyY96IRRstK9lqZCE83eN1sD6yJ2NnLjzGHtQ8UF9qx
         qQig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711557800; x=1712162600;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T5mirojkTcTgwKJGaOK9ct/ombmL5I/keJNO+8NwWkI=;
        b=GAF4UICj+uqym+iSlCUhUynjiKSfh4Ocp0njPby6vNKdy8iMHHbU81wd88eSs8Ko07
         B7VJRU+q6jRjWfNnJft24sMXo8G1zGVigNapUWsMRCo7ZxsyrNxw7oVbAsaW3iiWCFSh
         xCB56iNna5639QPSsEHn12WbBfuLCrb05AxpBF5Ym6LBp3KTdrBD04zn6ZACMtUdFUiq
         4koNEIQuP6cDR+dHfRRXyJu/deoQO9tMLL5r+wHHZQRw185WCdAEOrS4XvGjnsG56eAc
         UGoL5MsxbN5UMAIaJWLgzff7m+oQvl83XWsmZP1BJlAmPfelUcH32BWVA+LC1t7vHmdI
         P3RA==
X-Forwarded-Encrypted: i=1; AJvYcCUrISGK4En0dgh9YTtXOXo7Ee7a7okWfjdCjsYP0uVIiCBXs9nyNA8Hzrm/bbci47B0xsH9JMn8GNxiLO2uZU7RAsvo
X-Gm-Message-State: AOJu0YydXqen3l1sCWxztnyFX72TrpCHDVSyTdBvBX/Abvls/e7JX1Si
	Ll5ePPVYdtFD2bRd4Q+oUts0l7uxru0w0VwH7p+OcsG+YrJWCdsVRgHeBQndJ2Ng9aYCiUpqZ3r
	hA/MmZwMl7bJO8DmdkFMrtQ1uDrB2k7e4hlg=
X-Google-Smtp-Source: AGHT+IHVecMMxxyWKllSyg1xDrzwb4l3tuFzZkiYkH4yDk9nzjGsfF6UoY2RMii5YdK8jHC6tH/MsLSHAWsjicQLHKQ=
X-Received: by 2002:a05:6000:361:b0:33e:7a71:1a34 with SMTP id
 f1-20020a056000036100b0033e7a711a34mr326173wrf.57.1711557800288; Wed, 27 Mar
 2024 09:43:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 27 Mar 2024 09:43:09 -0700
Message-ID: <CAADnVQKCxxETthqDpcE1xMGwa5au8JuLr_49QuwemL7uBKfiVg@mail.gmail.com>
Subject: mptcp splat
To: Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	MPTCP Upstream <mptcp@lists.linux.dev>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi,

I ffwded bpf tree with the recent net fixes and caught this:

[   48.386337] WARNING: CPU: 32 PID: 3276 at net/mptcp/subflow.c:1430
subflow_data_ready+0x147/0x1c0
[   48.392012] Modules linked in: dummy bpf_testmod(O) [last unloaded:
bpf_test_no_cfi(O)]
[   48.396609] CPU: 32 PID: 3276 Comm: test_progs Tainted: G
O       6.8.0-12873-g2c43c33bfd23 #1014
#[   48.467143] Call Trace:
[   48.469094]  <TASK>
[   48.472159]  ? __warn+0x80/0x180
[   48.475019]  ? subflow_data_ready+0x147/0x1c0
[   48.478068]  ? report_bug+0x189/0x1c0
[   48.480725]  ? handle_bug+0x36/0x70
[   48.483061]  ? exc_invalid_op+0x13/0x60
[   48.485809]  ? asm_exc_invalid_op+0x16/0x20
[   48.488754]  ? subflow_data_ready+0x147/0x1c0
[   48.492159]  mptcp_set_rcvlowat+0x79/0x1d0
[   48.495026]  sk_setsockopt+0x6c0/0x1540

It doesn't reproduce all the time though.
Some race?
Known issue?

