Return-Path: <netdev+bounces-204854-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF37AFC472
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 09:46:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F19201897206
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 07:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE111E04AC;
	Tue,  8 Jul 2025 07:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KmBIT9GV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5C6D517;
	Tue,  8 Jul 2025 07:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751960775; cv=none; b=nia5HpNR3li5dwQ4oebti4Y37FIW/W10o9TpZxhVlJOtiTfqcnP4uWze5L0PpVjF+tkpvMfUg/tSJhzKqF1BL1Cz5uWdsasgnQ9I7XVY4sllNLYhCtPdSSVH+MaXnrk0H+SYeDc8SfE7mcukaTjfssPqinPcCh1hbx2rDYcYBNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751960775; c=relaxed/simple;
	bh=SsJLEZUK5l4Kdov3Q7zzxDX+VX8QlmSpDy1dNsg5p6M=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=GDtqHczpn8FAjybdbhuphiIHMiLOjSzYLZ8Oab/2wGcLKWjLpCg2KcjT3v/W3/I+o+L8e2SsOILd7hA4tHyQgD49y7XKJ7/v06aDyhlT7w7MOFi24Ccq9AcXo0NfU9J1SMULUMjCnakoiYkbjCFY/Za25QTEbzXLXiEUMLoU9YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KmBIT9GV; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-32b7f41d3e6so48305471fa.1;
        Tue, 08 Jul 2025 00:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751960772; x=1752565572; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SsJLEZUK5l4Kdov3Q7zzxDX+VX8QlmSpDy1dNsg5p6M=;
        b=KmBIT9GVhFdUXXyFL61rKqQeACdV2q6OkH2STJK6Ih5mG8sGBEGDsasOEipu3AJvap
         RK1xUwfuHnDXXLzTv6zAXeb6OPmTc2BxisRC3acKgLaQgZztb+sDIT+Vh867yaIYe1ER
         8NhtINM7kuw2WrSNqkH2thWdKv625NGsraFk2xYBTJ6wXftPgkKfs9bpxzjYjiIpg+m4
         HDujVPrs/bPfVnOrHoTjJEWyv92rTGZARB6Q6IUbwU6ajxIO48SWuxkbV7mVdnjpDHPh
         GW/Q+IC4060+xFAmEOiTt56Cjm3hP5tykOl0TUYlDrOFDPjGtmlDTZVYwBExJP9g8zRZ
         oH7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751960772; x=1752565572;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SsJLEZUK5l4Kdov3Q7zzxDX+VX8QlmSpDy1dNsg5p6M=;
        b=gFdKj9lB8U9XjksItk5NjPIpLE//WAwTdVo7y3nN2vpR6pw2K8PWk+1u5vp/zN0lSo
         pra080gYu7LbxtNmIu3Oj9qgU6jm0k3R0KzOzInEwvO2h4XZYx1usWXhtM0cFGkRHlwl
         60q256WzvwYBIz5NG/x6VmlCL2tUCwK6yQzAmdnFCl355bSvSU5/7jTr7kwnmKKNBu0n
         h4ezsz0dUITmM8SivSwlLXBaWFLUHq0zOrZS3BGwwOMUDi1NndUF9Np2tUzWpX+rcS+L
         0KYe85i8jyLdrbPt+VqTChVlm4I7Y2GX5f31vlEWtWfGyZBR7CLPxVDhyE0Re+ONbFwt
         s4eA==
X-Forwarded-Encrypted: i=1; AJvYcCU8sgtNVgx/pocCN5wUSqJdrWftSBt7du5NSQicFFDKnBg7yJRkySzukb1tVTNVxH+r8oqwIjJ7@vger.kernel.org, AJvYcCUccyEZTGZOAZ15EINBouJgcypJ/Rp9e6C4iwTBEqq7rPXnjTEOO18q3Bc3IWW8tKYTL4BZoJ6oOX6PU+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvvXL0r/qHqnWl0GhCX0I/KMRRWPPB1aWM2ONEelLlCqYhD1MV
	WHf4IbSodedU+CAkf0VVyjksBteX9VxN6F7J5g/9VmHWkHhekhd0VGJishben0lSFLT+74arSwV
	ZwydkWu7XZCLOXE3amNnbKevqP9wmgRY=
X-Gm-Gg: ASbGncsMixpfCur+Lg94V6tLhvaYDAZbFl+IodrtqZlIpS5oOV27ucHPJ5yDXr7tyOI
	A7+j9A5mJcyVkz0iOACdfhWMdr7i31HjH0pX7KzguuPfrJjm8WJYyYfSTaBuGpxvwL0SSsZVY2N
	QRLMjtHVNT6GATLydEfy+rS2CAQRV1tcbuIKCu+ZxHBK1D2mvwXZb6JXAKKkfyKNH8Lw==
X-Google-Smtp-Source: AGHT+IGEd9Kz/5zhw01cj60Fqqv/m+I4Sm8jcaPps9mJ+ttQL5ZKCItccPpmMz/tXTWNQssl2xCYHuM/okPzQAf3cRs=
X-Received: by 2002:a05:651c:2220:b0:32b:7614:5722 with SMTP id
 38308e7fff4ca-32f3a095ccbmr4741481fa.13.1751960771442; Tue, 08 Jul 2025
 00:46:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Luka <luka.2016.cs@gmail.com>
Date: Tue, 8 Jul 2025 15:45:59 +0800
X-Gm-Features: Ac12FXyHNuVMuBc-KoksuHFizmYOY9_ntXLtiAiYsEQj7DrJSbrTPi-bbh2XYO0
Message-ID: <CALm_T+2yh+PoxuCmSch8rgaZud6N4DBmA8OG9BdLvVu_F-EJ9A@mail.gmail.com>
Subject: [Bug] soft lockup in packet_rcv in Linux kernel v6.15
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Dear Linux Kernel Maintainers,

I hope this message finds you well.

I am writing to report a potential vulnerability I encountered during
testing of the Linux Kernel version v6.15.

Git Commit: 0ff41df1cb268fc69e703a08a57ee14ae967d0ca (tag: v6.15)

Bug Location: packet_rcv+0x3d1/0x1590 net/packet/af_packet.c:2208

Bug report: https://pastebin.com/vLWYxByZ

Entire kernel config: https://pastebin.com/jQ30sdLk

Root Cause Analysis:

The packet_rcv() function causes a soft lockup due to prolonged
execution of BPF filter evaluation in the packet receive path,
potentially resulting in unbounded CPU consumption under specific
traffic or filter configurations without yielding.

At present, I have not yet obtained a minimal reproducer for this
issue. However, I am actively working on reproducing it, and I will
promptly share any additional findings or a working reproducer as soon
as it becomes available.

Thank you very much for your time and attention to this matter. I
truly appreciate the efforts of the Linux kernel community.

Best regards,
Luka

