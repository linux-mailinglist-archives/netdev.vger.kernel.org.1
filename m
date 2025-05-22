Return-Path: <netdev+bounces-192727-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0497AC0EAE
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 16:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 768E1175990
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 14:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1171728C86E;
	Thu, 22 May 2025 14:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cBuI+Adq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C8B1F94C;
	Thu, 22 May 2025 14:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747925380; cv=none; b=YvZ9BS/jBVA2JW0MNCypTkL0pCRWyKrivfzkAQNsTThi/ht3rxesWaS85ztso2roa/0h/Po076P0aFVXyPaYz9lQKFkn3jPFOm+D4F/zm8z9Kj+8VTdBIQ0mkDgRct4xwcFJFVi+y713UKNX80vJyaKiUbGrGC/a9lDZfC7KSSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747925380; c=relaxed/simple;
	bh=5xFRYu8saRURqkeR91Qr7F10t/LrKfwTcamrb9Wnv6I=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=YXcI0NGuRdGfKkhJN1pCxCx+wwMpi87CzxeiK7blwexkw+wTjrotn9c9FCCFwYE99KtMzOQhJvftcI3NpYAD1xGPmENnbVAtzm1HemyooXhRTxsrnAdVrpCf2yBCgF727okSC9rVyLiAHJO7QnhQAvyU76eYnyrzAJEYZ4+Zqqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cBuI+Adq; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-328114b26e1so40652301fa.1;
        Thu, 22 May 2025 07:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747925376; x=1748530176; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5xFRYu8saRURqkeR91Qr7F10t/LrKfwTcamrb9Wnv6I=;
        b=cBuI+Adq0MXWzK9nu4dip5wBcS4N30uX8MBd6Hot856WlvSMRdCZlRTfF0HH0s3vP2
         1UiSn9t0CEAyPUD4JNgnxb/ojC9cls94aD9G7/kLPykiIgAaAdWH6A1vQgb0wo7i8nwc
         ZjlKqaduEe/9gKAJnBqz2veKCO0nJxvwHgHfUNyaTi5zxU89tZPYv7v/P+bqaCUgmyAC
         SSZ44NtR4amDNRYBWNXcLC/ecNvqjgGriadvS3ky+G7as/7Uz8FHP+MEcSE7yG8qPxSs
         Iy1Z0jPcwQdxk9b/itxP/wOdSo9S80d6ZCD9/Jslrqd1D5dRleXGE4c+g1CBbMAkdHsq
         vekg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747925376; x=1748530176;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5xFRYu8saRURqkeR91Qr7F10t/LrKfwTcamrb9Wnv6I=;
        b=SzAsHzZLH1GGkTcx+ysR529f1EexfRZbFQ66EKM4GMh8TkyVsHQYT+NeVZQX5Np6Cz
         7py7Q7G00ERYxfSbV+NMxjgmC/jlk/CS5xsee+n/kybYWeIQYLrQn3q+DtuKsV5xTLpY
         9hq8fpmtyddmYpn18trf3VoQQvTcfk+d+LcdF7BXe/QabytP5QsIuguUoF6pqCrtXdX6
         llfuSYkRg4KeVjTG+d/JtK2rUSatH1Ucrkcuh+z5r8459YnQneUKSpDxJXs5fnhJrhov
         qGXdsKOiM+ls0t23n7hhuT0jB7xaYaeUi9lgiU6K/9W+BVGIjOeNVZhfr30Z3t9qItKR
         aMVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHCYfA0rzL/u1+gApsmETjNkofBmNkml7jJZboJWfi+ScwBVkwCOF1KkrxdcLPE/VsXk7NNeyXNjFoupo=@vger.kernel.org, AJvYcCVUAgkOfcVJM7BUC0jJHPkJkmcsZPlg+RoojEWTl7H52rD6ryhVJP4Y81aN7fWhaJBHeJPaMg7R@vger.kernel.org
X-Gm-Message-State: AOJu0YySvHfI/X9tP7LgGdKfPkil9n9044fqbdIA0S9n2CuUgy235e5d
	kd+e4BvE6qnzrXcbPSV1h0x2QEjsvHip6kIPMjOkcuRQwYjrcVPyMSCQPwIePAf2JyLcRX8mUsw
	L5M3s3JQlWKDDvq1QLGHwcr5RgY3vzQ==
X-Gm-Gg: ASbGncvVCToCHF/WvE09sh1T/s5ObHtphmvBPsyOKVR0F3A4ioZFIk0C3jDTywbwS9X
	IvLex8dIPgFdzeL2SnTHfKquk/UiQH0d9Pjdo/KCRgZ2/sBz+vJzd5FC0jmLr/Hwa0ENsmrbu8h
	C7xxRlpe3+dqcoPWiVAqjafjMavE5Uh6AeCQQbXbZKujhB0nu3NiqpiA==
X-Google-Smtp-Source: AGHT+IFmr+8sDXj2m7NCl684M1gLo8vZLIu6awrbVaWEyAubfIakjPN43K8ooayoq0VM8HgksbBzaeAwWltyPSDv88c=
X-Received: by 2002:a05:651c:3129:b0:30b:c569:4689 with SMTP id
 38308e7fff4ca-3280974b10emr82804661fa.27.1747925376031; Thu, 22 May 2025
 07:49:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: John <john.cs.hey@gmail.com>
Date: Thu, 22 May 2025 22:49:00 +0800
X-Gm-Features: AX0GCFsc-ML8nllEHQfL0fdO8QULOtfO21Xil3vsaxaxGYT3WvGudNkN2K6eJII
Message-ID: <CAP=Rh=Pi1UcML+85_V6tvhG8oVm6LVc0LoudTyA5_E0ryHcGNA@mail.gmail.com>
Subject: [Bug] "general protection fault in txopt_get" in Linux kernel v6.12
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Dear Linux Kernel Maintainers,

I hope this message finds you well.

I am writing to report a potential vulnerability I encountered during
testing of the Linux Kernel version v6.12.

Git Commit: adc218676eef25575469234709c2d87185ca223a (tag: v6.12)

Bug Location: 0010:txopt_get+0xbc/0x440 include/net/ipv6.h:390

Bug report: https://hastebin.com/share/ruwexefulo.yaml

Complete log: https://hastebin.com/share/inequmeyef.perl

Entire kernel config: https://hastebin.com/share/agatonohuy.ini

Root Cause Analysis:
A malformed netlink message with invalid CALIPSO attributes triggered
a general protection fault via a NULL pointer dereference in the
txopt_get() function (include/net/ipv6.h:390).
The fault occurs because the socket passed into calipso_sock_setattr()
is not guaranteed to be a valid IPv6 socket with properly initialized
transmit options.
The bug demonstrates missing validation of socket type and per-socket
IPv6 metadata in the NetLabel CALIPSO code path. Fixing this requires
enforcing socket type checks and guarding against null dereference in
txopt_get() and its callers.

At present, I have not yet obtained a minimal reproducer for this
issue. However, I am actively working on reproducing it, and I will
promptly share any additional findings or a working reproducer as soon
as it becomes available.

Thank you very much for your time and attention to this matter. I
truly appreciate the efforts of the Linux kernel community.

Best regards,
John

