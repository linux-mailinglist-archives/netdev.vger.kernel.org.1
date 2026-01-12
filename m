Return-Path: <netdev+bounces-249157-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB221D1526A
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 21:07:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1DEFC301897F
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 20:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE343246F9;
	Mon, 12 Jan 2026 20:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nMi/y03C"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E041205E3B
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 20:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768248461; cv=none; b=gIF3Ya5bEOoCsBxuxVBbJJPujrSBcgriRf7mm/5CyrXbm9Ndri2RDsmB6Cq5j0q9jE8cLkkUYCLQbnO4NwGmZWfen7CS/4ff1cWN4cuGztXu4HI3LC3ubhldlA9TwDHx5EE2GUZCdipO8gSkeie4h6/K2HYjGUZBcF3UxoUzaTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768248461; c=relaxed/simple;
	bh=NWw5sgxzbYS8qrDP1dPKkPjsEqGnqFkvF/qF51QDZBo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=drP4riS0nbctP5PdXBLgMH6i9GsVixHq5ml+IPkHtLsOtYEUOErmSw1z83ekyzK9ZTx4X+2KmdMFojlajh7zfzRt/QMh1TDTMUwqQ+QdpsYVgeTbbn9fVvl5x2PL8NnUYManrAhLpGR1wRmXRJ9VS2un+yFKfIBMVWVVIzNSxrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nMi/y03C; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c52ab75d57cso2805604a12.1
        for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 12:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768248459; x=1768853259; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UUwzUKpmK9+5i4fmwqBAuA6TcWG30FG9tFvRECL63Yw=;
        b=nMi/y03CXNYhgFWdaixMGM3RYAS8QaMlLOtcbT+9FTk82O9Kgd4F+3akaxyN6RUxg8
         fy3L0aN7Gu7+qUTCXzVi1AAN5n0ybTQXv7AbNEc/XgLVYsBpelbQrxV/LSj5nmXTVUNv
         +G0N28ThYJAceICxbvKCw1EfpMc+b2h43O9JBjNYo2OaJ7zm1DkKdcETuxhDOlBTjPJA
         OwunL0VLCyWt00IVgIfnNB2iJccRxeFcFxsk3bPZ6cOfkYhDQUVxRNZ0z/NCj8C0oBRB
         R8BVWF61b0clE1oMzS+NyVxYhWVC6AP6pCmrlt1ivllWhaojZmealQFN4QXYhuWH5au2
         AFMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768248459; x=1768853259;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UUwzUKpmK9+5i4fmwqBAuA6TcWG30FG9tFvRECL63Yw=;
        b=NLW4rXQin2389W2SizOS0Qpa0t9o/wNtp71EMPFqWie5fGuw1HO1gOugTT2KGnjolf
         Mk5ziQmtjkRcNTNY1UBx4pEC1jHpN/ebulaTCZbBjNwUiHACAOIjwuDjC8+X2fhylsrh
         cGWpLK05NqYjMQydYmfurCtvUl7QPsuwD3mmjjhYq3yIJgVtSjmb/I7eBKJjVfEnFhVq
         lwZ9toLjlefmhsdICxkc18prTNfeOFKYp5Lw5L8SOAuy9c7Y6F+RofxfApLHkWDrVZ+A
         7rD6RkT2SP4mqUK+NQ6N67JPmOV4bSjmtpRdyPyV/B6uP41RnP7Xe1Bms9eFd/Huesk/
         Tj1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVTkuVyDGIAstOCy52uNUJl7S5HaqBaoqLCjjMswxLZJuugsVnfHqzYRlrB2hleT4wASqyMy9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+tweby+fvFJjANJ2khc01u2Sk8sI93RHvnjdgczthY5g40GNW
	4kW9Rx+WhaN9VNWAwV02dfXp6Agk6pI4adFp97CmWEtGkSoZvDQcAMvxFLrz1qWwbt7lNTaDE72
	Ox7m87Q==
X-Google-Smtp-Source: AGHT+IFZiy4K/hH+l5vzqXQosN9iv6RgAnVldwdFCc46MVt9CnThkRvMrVaZCWx5GUYaMrUchuFh7J9Z2Wo=
X-Received: from pjbqx3.prod.google.com ([2002:a17:90b:3e43:b0:34a:b487:7aec])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5846:b0:32e:a8b7:e9c
 with SMTP id 98e67ed59e1d1-34f68c28180mr14202995a91.29.1768248459588; Mon, 12
 Jan 2026 12:07:39 -0800 (PST)
Date: Mon, 12 Jan 2026 20:06:34 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260112200736.1884171-1-kuniyu@google.com>
Subject: [PATCH v1 net 0/2] fou/gue: Fix skb memleak with inner protocol 0.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Tom Herbert <therbert@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

syzbot reported memleak for a GUE packet with its inner
protocol number 0.

Patch 1 fixes the issue, and patch 2 fixes the same issue
in FOU.


Kuniyuki Iwashima (2):
  gue: Fix skb memleak with inner IP protocol 0.
  fou: Don't allow 0 for FOU_ATTR_IPPROTO.

 net/ipv4/fou_core.c | 3 +++
 net/ipv4/fou_nl.c   | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

-- 
2.52.0.457.g6b5491de43-goog


