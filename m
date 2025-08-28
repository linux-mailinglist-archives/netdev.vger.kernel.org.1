Return-Path: <netdev+bounces-217708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 093D5B399DE
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 12:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B8049833CD
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 10:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B0930EF95;
	Thu, 28 Aug 2025 10:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yQP1fHXY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3612430EF7F
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 10:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756376862; cv=none; b=GOjXiysB4ADvPX5XINFGnE+cPLqyoLMyyuJ2lTi2HoMptuFEHZwCj/7q2U7o6/XEhIRSiRNBN54rN5/9NoKwMlkFXR95eXvxQlrNRQRfdIVsN8coJu4U8qidjg5YNO96OJib8xVR8jI6MsZbJKv3VKsKYWsF9EVGDqTahTvetuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756376862; c=relaxed/simple;
	bh=qw7oVEXaG0peMuAsAUx0nPiVAkHi+7mDTxOZz1gzais=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=hsMHKmS5MXr8Zr0nta9gW8yMbVqSXf4v1TMcHu/VO7UJTg23XNgepzDKV0jNCeDOD9/6BN8R/otf6VfJI0mKVwFm5SZzGDkPDhLtYXydpviD1vW2d+hR9y5yNHAsrT0m87tpIyHEoMlq8pw2bZq/WNAgB5p654eJNL1X5F+CYb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yQP1fHXY; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-7fa717ff667so86417185a.3
        for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 03:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756376860; x=1756981660; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+CKzWnNAC0sJ7SeMd6VEIS+IHM18XV9iR+N0FlmrcMY=;
        b=yQP1fHXYbL3kEQxE7BNZdA10X7SY2XzvbVXPcc+YEFTQpBS7LwN/XCYFl+eeYtQ3NN
         xe/S+7Iy5W4KQc2RYm8qhA0d1kmObhc8m7L9hD8zIVZ31k/N7xX9H4MdlsEP7nTL7Beb
         q1haSqsHmFp8Wb5NioDc7NHWxZpkSHvE9VAdy2s4m1wwe9R0K4RW1ulbXI6VrP9EYQYu
         0eID2sGr6aidw8VTbMMmDvJhvcLhlEsiiFB3Mc3Mi2jzcxOMVd2dizd6UtxGgFdRVoyo
         Jw+XnsB6xXC9VX1oM513VdggL3TOJOfkYzMRmTBJXc36piGhvOCqr6hZ4rJnbwnOUmt2
         cmEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756376860; x=1756981660;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+CKzWnNAC0sJ7SeMd6VEIS+IHM18XV9iR+N0FlmrcMY=;
        b=nJz+twQ4CPx5iWT3ht3J7O9ct5m9/aFz2qvHEcJ2A6GkaaJf61g3cOCS95mW4tluq4
         EuSFVU1xAZX6e6xrLF3I+qMBwUPIZwGUNRsVr/6CLeIICtVBTctR8yFULu/Z9BNtsgUk
         rY+FQnCfqimZG2Q9qvmpqYkJClh4jO+R9wyBafsn8xvsGGl6eKXVd6Xg64WlFcx1ZBde
         LGiW5dd4BNqsTqPAQudHJC+fLUtW8dqzrudgkwt43kPEzAKjO/pTa9STUhT89XhcWn0o
         i0eO6jkcJJOZMVz1oxWmkFmL36vs//eg2Y+dEKJL77URM0zZAVRIhr9j0GyBm182Tm5p
         QlCQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2rAGzUNE4S0bRHFCj/XtsLXF5aKydhm+EwKeo3/+vcfWzEbg0xOjHLCFXxAqvGkh8yE/Upzs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgAVAL6AB901q2+IcvRbqt2xQRh0QUHyX70tLrizX2XfXf8Ocd
	RCtUFJBtfmS4s7aYOfxRVWZ17DigcNpLWh/nHnkW6391Jm8bw8siw9uTAg9kKAY1UfO8IsR9Vyk
	TkoXpfUJhWrTASg==
X-Google-Smtp-Source: AGHT+IG0kQ8xQ+wxyIxQCZo0aEhgdEyHaHpOM9lxXDJpVydwlN3ak/h2G/E+zsCWuCGHdbQDKivS1ipZCxTKpA==
X-Received: from qknql9.prod.google.com ([2002:a05:620a:8909:b0:7f3:9214:4bf8])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:3906:b0:7fb:65d7:272f with SMTP id af79cd13be357-7fb65d7292cmr22781085a.61.1756376860081;
 Thu, 28 Aug 2025 03:27:40 -0700 (PDT)
Date: Thu, 28 Aug 2025 10:27:33 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.268.g9569e192d0-goog
Message-ID: <20250828102738.2065992-1-edumazet@google.com>
Subject: [PATCH net-next 0/5] inet_diag: make dumps faster with simple filters
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

inet_diag_bc_sk() pulls five cache lines per socket,
while most filters only need the two first ones.

We can change it to only pull needed cache lines,
to make things like "ss -temoi src :21456" much faster.

First patches (1-3) are annotating data-races as a first step.

Eric Dumazet (5):
  inet_diag: annotate data-races in inet_diag_msg_common_fill()
  tcp: annotate data-races in tcp_req_diag_fill()
  inet_diag: annotate data-races in inet_diag_bc_sk()
  inet_diag: change inet_diag_bc_sk() first argument
  inet_diag: avoid cache line misses in inet_diag_bc_sk()

 include/linux/inet_diag.h |  7 +++-
 net/ipv4/inet_diag.c      | 85 ++++++++++++++++++++++-----------------
 net/ipv4/raw_diag.c       | 10 ++---
 net/ipv4/tcp_diag.c       | 12 +++---
 net/ipv4/tcp_output.c     |  2 +-
 net/ipv4/udp_diag.c       | 10 ++---
 net/mptcp/mptcp_diag.c    | 15 ++-----
 7 files changed, 70 insertions(+), 71 deletions(-)

-- 
2.51.0.268.g9569e192d0-goog


