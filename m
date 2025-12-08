Return-Path: <netdev+bounces-244010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 19473CAD499
	for <lists+netdev@lfdr.de>; Mon, 08 Dec 2025 14:37:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB4243010CFB
	for <lists+netdev@lfdr.de>; Mon,  8 Dec 2025 13:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF3E2D7DC1;
	Mon,  8 Dec 2025 13:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qBtW4zEE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D272D238F
	for <netdev@vger.kernel.org>; Mon,  8 Dec 2025 13:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765201053; cv=none; b=e0w0IZgUStaleMiZ7TTKoESt//UBhgRWZCS0CZLTUMndaIr61CoxHO5gX/ePbMxFhy83EjeDS+PS/lQUc2nvZgXEK3ooUMoFG2s/xPzOa3/JlxlHMuNd3ogheKa6Ri2EgmOdxFDMFPaQG/RjxEAZZV8YFOCY6Txldok6AU9V+Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765201053; c=relaxed/simple;
	bh=ED8iL11TjB7xed8rNK6isMpTsgBOjiesAFWtsv/apYg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=HsZMTq3VxIqi6UFBN3uLPD9ZpAlXCOjiaWrRb2ErlvSebI/SIJNAev6RRw+ca+qAVC3pLFQatTvvjlfbH772J0t8X2KoQ2Uv9W1qNOKjRQH/jAixEhp27v+BWUFkuR2Bgo9gPVJ2O8XpwjjJ3z3vk5V7A7816OHSJaqFex7031E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qBtW4zEE; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-343e262230eso5082480a91.2
        for <netdev@vger.kernel.org>; Mon, 08 Dec 2025 05:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765201051; x=1765805851; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zN69B+gDTj+LF+DnCB/WV4BtrDPAzp7Dhp2nj8JoWiA=;
        b=qBtW4zEE+OVslWhJ3IPSLwjzKO+JgPQjQQijdzfuZ7ay+/K4nVNOu4aPS8vN9DVWA0
         eLktzoWz5RPRQzPVw9bJwQwof0Ng5Uc00fSsz66HrWznfC1Nhc07QkcKn+Kr7SwDyp1n
         jzPwKHXEpYRKbJv+CN61aV6LtL8bI7iC+i8I6nOkDoqprruJXWdjPZrFIAAxa/EmxQzq
         LD5QAPf+yDfEl2tzzeuqY+dSLI0Ir2cglSyoRvzOxQptKpBM+kAvRDdvLnQLILdcgLIj
         qJsQpTNgN8d62plKdpDkR1DswUL+PTNwhmAv4pYXq+DJM4nVdDHdt2Zs7LUVgpo0sYfz
         FQpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765201051; x=1765805851;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zN69B+gDTj+LF+DnCB/WV4BtrDPAzp7Dhp2nj8JoWiA=;
        b=tJIEIZIz1i7J6p9WyXUS8FNtccigtxx3cyodhLwWAAycpzk6HuT6dEbqNXUxeBtriC
         NCAu/UpUIBcY02A5s7cBOIE1OKX53ECa7FE4S+XM+KROLb+qDWsaJEwJ6rfhcF/OACBt
         XFpgJZXSfxSpQegd2oLj4Z4RcIUyu0FMqvIUBQENUxzO8mgJb8cBJk2mo6lw48rsmnid
         RXoXt5gZuS8D86+qvTmkP//sg1cWjKiDJeNnznTfBBZ/nJaMU6FIrh2MXE10lid53q9B
         j2RfEPQjGe2dmIFuflLXgclj38p1wiK6GoiUMb0H7TM4rULdB5cf5O+MKzbvL4iS/kN6
         r45w==
X-Forwarded-Encrypted: i=1; AJvYcCU+LLpWLk710u+jS6bZVc1BM7hFnwqQUV7+/zHo4AhaE6TQXWni9MyPWTK3bZcZ4kKPhSzsNLU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKF3dAL4A4A3ITA/hDrgdJ//Qtljx8z1KWsLmje8IdFqd/7pWn
	ncWsuM6iA+rvY0TObkpsJd7GE3WlMK74FnLO8fBhPz6EFJhOgXCWM+jjVncsvck92VNZ4x84qZM
	PYp0rew==
X-Google-Smtp-Source: AGHT+IH0EK01cBVi4bjmwRVtLcSxvbd1tCE8xxGQgm6L2/PbNOAhi49up7T3B4sG0jTfmcL/ZO1y26m9pkQ=
X-Received: from pjbsv13.prod.google.com ([2002:a17:90b:538d:b0:33b:ba58:40a6])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:35cb:b0:340:7b2e:64cc
 with SMTP id 98e67ed59e1d1-349a250ee48mr6754838a91.15.1765201051075; Mon, 08
 Dec 2025 05:37:31 -0800 (PST)
Date: Mon,  8 Dec 2025 13:36:55 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.223.gf5cc29aaa4-goog
Message-ID: <20251208133728.157648-1-kuniyu@google.com>
Subject: [PATCH v1 net 0/2] sctp: Fix two issues in sctp_clone_sock().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

syzbot reported two issues in sctp_clone_sock().

This series fixes the issues.


Kuniyuki Iwashima (2):
  sctp: Fetch inet6_sk() after setting ->pinet6 in sctp_clone_sock().
  sctp: Clear pktoptions and rxpmtu in sctp_v6_copy_ip_options().

 net/sctp/ipv6.c   | 2 ++
 net/sctp/socket.c | 7 ++++---
 2 files changed, 6 insertions(+), 3 deletions(-)

-- 
2.52.0.223.gf5cc29aaa4-goog


