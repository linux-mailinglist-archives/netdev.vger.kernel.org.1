Return-Path: <netdev+bounces-133091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 242CA99487A
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 14:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D74CB280C82
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 12:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711141DE885;
	Tue,  8 Oct 2024 12:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zlqT/fNT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDAE61DDC24
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 12:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728389592; cv=none; b=arZznbt1+Ko8HDGzepvbJW9bDlILet41LEZuugPXLB5NQBw85zou0gOitWWc2+5t2yD4rZcOofNdO5wspgN9wEdjXmlDCEtEXjf8I2iy5rQy4K5sAY1gAKCjfAjByOhxFo7/FyNbJqEQPMthuefeH0bjc2IYh9QFdrRQRUn4DKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728389592; c=relaxed/simple;
	bh=h/dhkhWcMDP1qSSfHaDJYKkylUwVqysFQ25AFYTvgNs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=BGvfnVl8D+Gy9fkWDCCZ1s9ZO+r6+Xg594tK3MLLY4CtaOAHoXu3RFnb9aO06+t7LrZ7wgaPKWqzlg+cAn9SiumOGF+4Ymf2vvHpipCZS5b+M0/5Idy/XIi52qvPdIM7fwv0+eKy8Utl9bDm6UfqBdYcaPmk8KLJA5VDtDNEH7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zlqT/fNT; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e2b049b64aso86814907b3.3
        for <netdev@vger.kernel.org>; Tue, 08 Oct 2024 05:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728389590; x=1728994390; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PLBsfuAY9vf+cZImRU4JjsCELL3cN6KdSnH3srJfcdg=;
        b=zlqT/fNTiGn+uWmxKFQ6arYlJeT+OM2e7aVmrgqkKkzBvBOLyQur/KJ8U1oL/EnIhi
         4sx+o042Dbmshz6SmHfEvgMr+BH96cO2qQWZk0C6jbihlikmWluFbirMJkY4DWGHMFTV
         FMwJV7ewN0kp6JJ2andCMMAKy0YaPhu/+tCcUbEDJrHiqLVNggRV97Gm89KRar9Np0+8
         I8d81PDrdl8FT/DX66SMRj3MT5TewSsfAYSTG8tdeBwDxOmh0dKtp+z3aiFgZ1VCmXP7
         Ke12WPibZuCYZBBq4FeCqM4deh+xPo9qS0GJDv9SjCPyHgzBeGEpdZAbxtA1QKnFg7XO
         d9BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728389590; x=1728994390;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PLBsfuAY9vf+cZImRU4JjsCELL3cN6KdSnH3srJfcdg=;
        b=Cv4bXAwGoQrCFanIxymBQQHwk1P0YtNBquP4lJG6vSGM7rkJVe3LWBaScE9Ner1eZN
         xB9eaxeHN9U9GSljBnxkEGxRO66NyKPvcVMzGQFDkB64MYnW0AgqXTtLAkMg7I7Dkd+s
         CYPM+Ck14fIkcIE/aznwcnhLMdgjvWl1nYG3LXRn5OHiTfOrs+ilnHKj5FaqFPrIhX3j
         PAFuRQhd7R8REt7tD0XMFpGrUG0mHrvyhlKestiz9scLhPlhDdn5drjB4EA+nCe8N3cf
         JbMORQzjGYB/967Eu0Nq3AIcg0KTHvlKHX3VRTaxh+iKizWEOqu2qsbYO9nm2F54+E7M
         rL6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXA2tcFTkUqSTtD2fH2wdnkPJWcQH//sWOwa96k4H086y+t9wThE9/azOZiajMDwxdrnKDuW6s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjEi111/ibuiXTZt5qYhFvACqUnfav7AKZoCR/zlHkQ+6CIQQY
	usAzJ076f3TM7ryYNdlY/pN3huf4WRmRhFGUt7LY+9DgLXGjtPRrBU540AbsX7YGnjKQgtgDQwL
	CrwHyzHkeuQ==
X-Google-Smtp-Source: AGHT+IGynlc+KxwbzuCLmA+DQs8MSWEALpuCoGnE2PBjSv8l6UJe+UE5tuEoane1RSEuQ65qtAVnhlZX8FSQVw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:f7:ea0b:ac12:11d6])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1342:b0:e28:f231:1aa8 with SMTP
 id 3f1490d57ef6-e28f2311bb5mr10423276.2.1728389589752; Tue, 08 Oct 2024
 05:13:09 -0700 (PDT)
Date: Tue,  8 Oct 2024 12:13:07 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241008121307.800040-1-edumazet@google.com>
Subject: [PATCH net-next] ipv6: switch inet6_acaddr_hash() to less predictable hash
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

commit 2384d02520ff ("net/ipv6: Add anycast addresses to a global hashtable")
added inet6_acaddr_hash(), using ipv6_addr_hash() and net_hash_mix()
to get hash spreading for typical users.

However ipv6_addr_hash() is highly predictable and a malicious user
could abuse a specific hash bucket.

Switch to __ipv6_addr_jhash(). We could use a dedicated
secret, or reuse net_hash_mix() as I did in this patch.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/anycast.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/anycast.c b/net/ipv6/anycast.c
index 0627c4c18d1a5067a668da778ad444855194cbeb..562cace50ca9ae635dd0762e147b452be44c729c 100644
--- a/net/ipv6/anycast.c
+++ b/net/ipv6/anycast.c
@@ -49,9 +49,10 @@ static DEFINE_SPINLOCK(acaddr_hash_lock);
 
 static int ipv6_dev_ac_dec(struct net_device *dev, const struct in6_addr *addr);
 
-static u32 inet6_acaddr_hash(struct net *net, const struct in6_addr *addr)
+static u32 inet6_acaddr_hash(const struct net *net,
+			     const struct in6_addr *addr)
 {
-	u32 val = ipv6_addr_hash(addr) ^ net_hash_mix(net);
+	u32 val = __ipv6_addr_jhash(addr, net_hash_mix(net));
 
 	return hash_32(val, IN6_ADDR_HSIZE_SHIFT);
 }
-- 
2.47.0.rc0.187.ge670bccf7e-goog


