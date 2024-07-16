Return-Path: <netdev+bounces-111638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69697931E94
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 03:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D2DD1C213EB
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 01:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 733B64405;
	Tue, 16 Jul 2024 01:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yX6/uUIa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F010C17F7
	for <netdev@vger.kernel.org>; Tue, 16 Jul 2024 01:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721094846; cv=none; b=WE6asrLGxFjp/AFQ7nPkZlK2b+esw0d2i/qATTAhEj4SbKldf1rIhLSPZCvIqg+vCTZm3PLk4yXeXTIgvlhwuBofGs+9SdDLzvUznPUjatrUGqH0NJqDEVyYbha9/X0Urv4vI8dWd2uzULrlYR4EbAMrj2TnaAWFbzgpaNmBziI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721094846; c=relaxed/simple;
	bh=SncrzRZjPZCZ9x/5XFL1S1uqt60ntRdt5c2cNIchP+4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=jyF0LgE/60xM902rlVxPp3XZMORtJ8JQgWI/Lg48in8rYibPdNDHGZW2kHZAc60JaslMTksCDx9yQ1pHLe5ZXKQJYeIocOj3Ud68a0N1EB2FJpxxWKoTZtBvcsOQureup9cUb8kfNa8jPkEWBS574USHmAqk4Hx01tzyeUKAg1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yX6/uUIa; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e03654427f6so8963067276.0
        for <netdev@vger.kernel.org>; Mon, 15 Jul 2024 18:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721094844; x=1721699644; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4Te/n5It39XLqm9k5ldwUJRy74Mz2CXcdjzZuskMlAA=;
        b=yX6/uUIaLM1wnyAqH7yMCvGkOiDIgDKYCOOdWNzoMYgHPZzprxIFoJRzZ5mBfvhWEr
         0uMyVVRYMFb7j/C2rvqDdCXcXk1ig/vMdJ4xql8EeYHIRrqeW6cwFo+pJxLau841FNA5
         LQR4ufTZCT/g9qlwfZvlFkbhzdbBp34FVeL/j+HPR/ZLitmDKL7ngktPib1qqQMla3C+
         bDpyl4re56/nBiQQ4D01lJVjKoZ/ON9OW/EsjP8GpsM7jPNT8dU9yL9+zYjdaKuNGVTH
         HtH+DkjXshcNF9FEVnGnCzyIgKrwpjVTAWYD8pgFvp5QSUF22EJBBsAvBRw21VzCHzaA
         oyFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721094844; x=1721699644;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4Te/n5It39XLqm9k5ldwUJRy74Mz2CXcdjzZuskMlAA=;
        b=ppVK4HR5GUbEZtkzyJ/nKuqTbq+UckKaYuftuCGJoiZCZv2EkKy7tN5ycv296Rjgm3
         749QEVCm3IpsZu8g1d5cmma6ZMEJJJANToK2YPEuJw1xm26UAdxaMB8zEMCXVmdS28zP
         qgvHXcrYY9j0IUFQwx0x8euRAjzQsB+hbPOMCD4Z+r+zwRtVcsRKFl2GPUASchJMNwoL
         9Eh7u2DpTh6YxoiB3HwqIZHGi3h4vc/Cxi/3h96UYOQ7WggOQ3lq5fcw6bG+2FqAVt47
         2nlZM8Od9TsrwOGizR1FU71qHDZ0GUpX0nn5fC1iEDnS+p5Q/ZKRnMYhk7DjT17KCbQF
         0mQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfj/GQiqBBQ9WdQDXuTQX8ynItURNw5HID87Z1p5bPvFneoYq92Xvv5XSzlLWsy/ImbH/tKYXue/IP5J+gGdVVVkhtw6A2
X-Gm-Message-State: AOJu0YxXEJ2SBWjkn4TfolbrzzsUdxOSBLNGtru88mNnbOHx6sRfUghn
	/VD56H+wxvBsF0q4FgmwmAw9Fu2YnQd0iB/O3pnGSNFVwWNMLBVMgTw9YR1bVKB6E+G6NUD8f5r
	2nhPbW0PCDw==
X-Google-Smtp-Source: AGHT+IHQVIFw7C1m8aigxPJMX6NDr4lTG27kubZY5BLuKyFmwWgOqOS2mqIRXrSK/k81s2Db7pG1BbW+ofOOuA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:e0a:b0:e03:554e:f396 with SMTP
 id 3f1490d57ef6-e05d568836amr52365276.6.1721094843640; Mon, 15 Jul 2024
 18:54:03 -0700 (PDT)
Date: Tue, 16 Jul 2024 01:53:56 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Message-ID: <20240716015401.2365503-1-edumazet@google.com>
Subject: [PATCH stable-5.4 0/4] tcp: stable backports for CVE-2024-41007
From: Eric Dumazet <edumazet@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Neal Cardwell <ncardwell@google.com>, Jason Xing <kerneljasonxing@gmail.com>, 
	Jon Maxwell <jmaxwell37@gmail.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

For linux-5.4 stable, we have to bring four patches.

(Compared to linux-5.10 where only the last two patches are needed.)

Eric Dumazet (3):
  tcp: refactor tcp_retransmit_timer()
  tcp: use signed arithmetic in tcp_rtx_probe0_timed_out()
  tcp: avoid too many retransmit packets

Menglong Dong (1):
  net: tcp: fix unexcepted socket die when snd_wnd is 0

 net/ipv4/tcp_timer.c | 45 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 42 insertions(+), 3 deletions(-)

-- 
2.45.2.993.g49e7a77208-goog


