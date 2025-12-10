Return-Path: <netdev+bounces-244201-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB085CB25E3
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 09:13:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A7E1302C4E8
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 08:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36632FE079;
	Wed, 10 Dec 2025 08:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1ap1eOLn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839232E7BC2
	for <netdev@vger.kernel.org>; Wed, 10 Dec 2025 08:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765354332; cv=none; b=uOlwTDDfjjkD9hANzJP19xA8LnMrf+uQTW0t0UR7s7fIU2+U3VLzR/sTqNvc4pMd+AZ86CsOtQsWyzTkI54Zx93mRFoQwnDb8HHNy/yQP6zn+gidKg38CqEQN/TC/XX219Zz2mOy4nCB5NeOe915YEaWLNH0/T2+Vy2m39zwnPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765354332; c=relaxed/simple;
	bh=zkYwwnO+7cXKZcweWqFpkato3KlNNC21QTlOCxnRJT4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Ehrxd7Eevf1qG+5stQuL1xb7zEE29+mR4NEgmOBNW4MZqkAkINVYJEiYTAUNkjQOUqXaHllOPzJJE4GTC1tuZHgbKNOdeWzbCfsjNYpADo2NgHdxNvdgc5PmIhtDgeA79CptiCtc7+KTEcL9qswBJspKofWOuR4zL/rgPGyiioo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1ap1eOLn; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-34374bfbcccso5644209a91.0
        for <netdev@vger.kernel.org>; Wed, 10 Dec 2025 00:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765354331; x=1765959131; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AsDtsYq8bUtx92v4bel0qxLiksscz8X27Roskuj+FHE=;
        b=1ap1eOLnfnkf3GmTt3fmDcbNr93oT9/QuKw5MlhkXyjIWsbC/2aK1Edo5PPp6fV6U3
         3pA/6TEQii1Z+fHvpSgZS2zkcnZVz7k+NtTf99WpgA8XFMhvnWJiZrpHQ3Nzgh4n2XGb
         sLHC9MhK5WrVxDvo9d/zyQVu7TR5vu3WbQlSPI8ZwRjVH9KCtwKLXfd6HLaFpRAAFAeZ
         ym5KyMxs/V9AriORMnNO7hSrXklwaDBLI5r9sLQSY8WMw0QHdCTGzcU1gdP43ADOY5pI
         M3SUt1Bz5jIsqH8/4SNGVz1hIG9gSMxfs/NCNo3oBMj00GzydMruJ+xPH+orMjlB5yhq
         NjMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765354331; x=1765959131;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AsDtsYq8bUtx92v4bel0qxLiksscz8X27Roskuj+FHE=;
        b=IcfV+RItY/6Vpj/CdLpykxll+KG15XG2C8bjkVijfjyLK1umrrkgL2IhySM5dr7cqc
         stPoPTqZDFKOEZP6pfq3hErDqfjOQjlAlirN1vJadPoy4AXYP6wVsO9xydrpdPqmPMCm
         wI9MUya5KPJW09sdJ3Agt05xYhhTjAoSIhytmIgF41dG5VbDpF/Quh6oQH+t9bQDX0zQ
         eYRFSw0FCGfFAVC3e7Cgb4R5wml/BmCpK3huavgQgov2q661O80dusTpaZ2z43AmqApm
         /ekpOQwfUOy7sfl6WsYH/X8YQ3qZJ4/Wf1lDi1zFXBnAen8Uyg/fbpR4kROGeKJU+VvX
         gYKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcRy1yYd/ySvwJMUpQOggrQo5seBLht7nPx3rtJ8bH4A5CDwFeLprtKWXJ5kGd7WHijsGSams=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM/v9S97pti9mgYdHSkd1AUKFS6uT7v7FyScYp8agknDhgNZY2
	/mJ2PBqzxOC+nE5aZL1EMWqpBAgLman+xb4pETPaITklAcPnpZSB6/2STk4SrkvYvcyI91fXdEx
	twGCsAg==
X-Google-Smtp-Source: AGHT+IGJBOyt514lO+ckd7evCrEmAl2lrqnNRaWWuBi5s4sOT+i2pQJX22fn2/IrhOfNkKZiRNWK1pHn7Xk=
X-Received: from pjut15.prod.google.com ([2002:a17:90a:d50f:b0:343:6849:31ae])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1e51:b0:341:194:5e7d
 with SMTP id 98e67ed59e1d1-34a72879dcdmr1609543a91.24.1765354330821; Wed, 10
 Dec 2025 00:12:10 -0800 (PST)
Date: Wed, 10 Dec 2025 08:11:11 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.223.gf5cc29aaa4-goog
Message-ID: <20251210081206.1141086-1-kuniyu@google.com>
Subject: [PATCH v2 net 0/2] sctp: Fix two issues in sctp_clone_sock().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

syzbot reported two issues in sctp_clone_sock().

This series fixes the issues.


Changes:
  v2:
    Patch 2: Clear inet_opt instead of pktoptions and rxpmtu

  v1: https://lore.kernel.org/netdev/20251208133728.157648-1-kuniyu@google.com/


Kuniyuki Iwashima (2):
  sctp: Fetch inet6_sk() after setting ->pinet6 in sctp_clone_sock().
  sctp: Clear inet_opt in sctp_v6_copy_ip_options().

 net/sctp/ipv6.c   | 2 ++
 net/sctp/socket.c | 7 ++++---
 2 files changed, 6 insertions(+), 3 deletions(-)

-- 
2.52.0.223.gf5cc29aaa4-goog


