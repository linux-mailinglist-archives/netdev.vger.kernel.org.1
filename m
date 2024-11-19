Return-Path: <netdev+bounces-146364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A2279D30FB
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 00:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FABB283E4C
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 23:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 944DC1C4A3F;
	Tue, 19 Nov 2024 23:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="tq6dnEF+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489131C1F3E
	for <netdev@vger.kernel.org>; Tue, 19 Nov 2024 23:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732059428; cv=none; b=C+6CDHjkKDc1dmEzPC1Y+csHWWMRC/dBp4SZ/7+0Le7UQ40AZbV4PZPogkPUq/LPjPqE+M27GL53zrT/fevEy8CYy2iYqcpd78mkbbm8va/4fP8cnHqH7aY3r/2sNcVVMynNZe6vysfK+2YuI2s4RwGlY7YIpEIVYOhOiyQi2uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732059428; c=relaxed/simple;
	bh=/swf9q8NqGzV7B25Ud3BkoIkR9ditRL6tHChJjVFoMI=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=WiMvRGzmr66iW708d/Xixs2oc1yryJRsjmoHz3TtuIXN5gE86OVNh1uY2GFmPHdWRWWtyw7ENVnDt8kObRsMw0I/WOGAa9mJRc1VOcr3Zoe3DxC2q1sSeDMSkuyLUfgbdY5nlE6HkKm6oxdZ2IXhnM+qy8FJiKRSkNeyQIjsEM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=tq6dnEF+; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2120f9ec28eso2250575ad.1
        for <netdev@vger.kernel.org>; Tue, 19 Nov 2024 15:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1732059425; x=1732664225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lflGtFBZOncIuPvyuFUckj2pqdTcL3PV1J2DgX4SNKE=;
        b=tq6dnEF+w2fhhiSK/3Rau60USzjhg8788dmRHRRsUyiENrwTjAM4w3mgzDNvIn5Wc5
         wOlxSAOiAtQIzlug377o42Zf8TWUsi9Lur/kwD2Ml2FH+T1fDGXHqFKvkNxLVmPVDGT5
         PGa27aoKrsyfD0xzRqk6AEPouyEL6ehYSqUBuDOslAwPJqNog0Rj94hn0IfIJpnvxu1+
         /zdmIIF9JevQz9RXrGQDc9UQzpTlhhziNhC60M8w+CH8ug2qlJqCvxxvdFu5Epnr1+BZ
         RkRQVsy8HYuUSR+PaCYRZZ0iJ6JC/hdmvUIPDsZ3MwFG7g0s9hfJkHzBxaG9vEPGEpBX
         3tNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732059425; x=1732664225;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lflGtFBZOncIuPvyuFUckj2pqdTcL3PV1J2DgX4SNKE=;
        b=tFCKyiebF4wy1A2rJjSCpPIyA1AHqMZC6gxhiT4r4Gae1YafcbyFJ+DuJA4tPytIPG
         gTshSjdTyK8vN3Frdcc521RDvnYK62d+iRUUn2GYa3lnB9BxuPWM4QcxpPWqrup4lR9p
         x9cqutm7GnElb1Hk416sw63sp59zOky+MYx6A6mc0BRDyeaLL6fOszZE6gYzj0PXPFUv
         Xy9zljPccIA7T7UNh6lF1nLdbRO8quqoaXIj0Wv6+x3j9Weqjsp8ENvqhifQFgOF7n0c
         dC6JqZTSYEs02GpVZnJbIeTZwwu/zmKbqKerh6FfVcxxfXt4jBo/noxhqypeh6T92ROv
         3XAw==
X-Gm-Message-State: AOJu0YybZ6Yj6sXMBX0SMFHT/Pv0LEaSAJm6XOTZlFk8tHygu6fHDZ1i
	Fajvdchecjh4u0S0EwNdDvjCGngaFfkcUBGXzPfsP+FhOEopkhknqP8jMrCbCZzIqGFpVkgfTO5
	7pyI=
X-Google-Smtp-Source: AGHT+IG/LIJx5ycFaaKD2/9r1zOXsYmAz0tqld1yu63CwbF97j4o7Ig/q4aK3AtmPbc51kajVBh4Mg==
X-Received: by 2002:a17:903:298f:b0:20c:72e8:4eb7 with SMTP id d9443c01a7336-2124d0f2b92mr76912605ad.25.1732059425611;
        Tue, 19 Nov 2024 15:37:05 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0dc3109sm80338115ad.52.2024.11.19.15.37.05
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 15:37:05 -0800 (PST)
Date: Tue, 19 Nov 2024 15:37:03 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Subject: netdev: operstate UNKNOWN for loopback and other devices?
Message-ID: <20241119153703.71f97b76@hermes.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

It looks like loopback and other software devices never get the operstate
set correctly. Not a serious problem, but it is incorrect.

For example:
$ ip -br link
lo               UNKNOWN        00:00:00:00:00:00 <LOOPBACK,UP,LOWER_UP> 

tap0             UNKNOWN        ca:ff:ed:bf:96:a0 <BROADCAST,PROMISC,UP,LOWER_UP> 
tap1             UNKNOWN        36:f5:16:d1:4c:15 <BROADCAST,PROMISC,UP,LOWER_UP> 

For wireless and ethernet devices kernel reports UP and DOWN correctly.

Looks like some missing bits in dev_open but not sure exactly where.

