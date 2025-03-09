Return-Path: <netdev+bounces-173345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C15A58645
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 18:32:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCCB416ABF5
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 17:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB09A13B2A4;
	Sun,  9 Mar 2025 17:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oQ0vAdAR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0480D1DED60
	for <netdev@vger.kernel.org>; Sun,  9 Mar 2025 17:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741541516; cv=none; b=nkiLUDkmdrfKNVSS3NURBqjrCoUqlqwnzcySKEH7rBlhohiALuukAN8N/iPnO4sRuDAluHNVXbu/gJLxrI10mK6TiwhH5wXUMDFxM2i+DIO60JQsHMBnMFI1OzYzlC/AqWtWYVdDrBhXA/ots3B7BJFcZTi758EP/w2nR4+gC50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741541516; c=relaxed/simple;
	bh=wxaQX/HuZ5aSXW4GGbRWHfyKNyfKTQaC/JX9xbzPMr8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=PJVOswgpfIhOPlTRTQHXrC5GG2tUzyCN7xTrOAxBR2TkiCseYP6C+dtNuIKB/nAcrlxGMXU/noJrl7tAQD/8+sxa4loYpEXhCSMs+tBAluO0LAWTCLMLPDjiNQ+tBk0v9X0uFMj24g8Ge2/6fxEjsSvX3CiCQohLC94bFbAL5I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oQ0vAdAR; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-6e900f6dcadso64898246d6.3
        for <netdev@vger.kernel.org>; Sun, 09 Mar 2025 10:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741541514; x=1742146314; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZPR7FhM+GP0xBTzGnVmQXFLLBlX3L1BksyNfv4ybbdU=;
        b=oQ0vAdARspsh3X2BsIMib25WpVfIIf1VD+DsHtsnTaHfcPndTVU0buWnqa7ZdAh9Td
         XtMZMC4J+beBWyw4GKSJkm+20eColgCa3LQykP1oB7MsaTqkUcLAmileI24y1gsfl0bV
         f7dRAITJxgthGbo3SVYY0CopVRNpbQVDgLGFbwpCJqk29/Nyiamgwg6IFNZ+1O6L4u5D
         t6PNm0EGlowIb6B5xVSg8kqzoWxcanc3RQvEsipUELFKTl/ufxec3l7571tzvBMWXFMi
         Jv4vHPXffOvtH8jO5Axyst596nqwLPb/1OBO0fQqdklvOx9IJw9abTyiBrfH8AKD9L4/
         2Erw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741541514; x=1742146314;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZPR7FhM+GP0xBTzGnVmQXFLLBlX3L1BksyNfv4ybbdU=;
        b=Xc/zNyb1FVvvXdvt2cR+63Dhc6MqccMzv8G/AtVW0m5nc+Sacy7FRSc+bKmDWcIfWT
         2iJpUUar3F/uYcmVBm0MEaB4TUusu86HtJlEiiEjVO+/mkta4rUlexr5ij7WxcxqYoBI
         FvdFjxCdXMtJEeDW8Zl66Q0s+t/N0FQMcQJyDjD0TkoyAZRY/nPGumzADD6uNyCpUmZW
         AVRsk5EqLovN0A2sHMRxE+98WorPXquy4Xz1/Wv78r1p6BeQX+oPgE+25/hYlXBj54Eq
         6n0Wwgf7p1kLpupY6jUYL+Is/BwJIxThFnPfV1vHbzUfJoeObp/WTiz16Iok/7vBR6co
         vlTQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0sBAFFBMvSziHKgRkW40kq2RrUQapJQKILpeKPuGxInMfsg4ogTxwErgbKvUcC3CJ/o5I61g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxkdxh3t3Ech4emUJWqAYT0jDJaQNM5n52cvzmvY6rIYwCfS6dR
	kL1Mp909uWjRFwtuSRKnLaytvofkzl0rgYyaH+ieLA7DhCviDAvh1WVgHmLIHMyXF/V7tMUnIJa
	l3mtqmaT9HQ==
X-Google-Smtp-Source: AGHT+IEel511SLAEs0f/bmPMyxWIrcJkM1u1oJU23parfwSZIDsyOC3zmKxVESzHedtdtcAX1swsyhYh+QxfOA==
X-Received: from qkod9.prod.google.com ([2002:a05:620a:1669:b0:7c5:3d32:f6f8])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:6884:b0:7c0:b336:572e with SMTP id af79cd13be357-7c4e619fdecmr1414420785a.38.1741541513877;
 Sun, 09 Mar 2025 10:31:53 -0700 (PDT)
Date: Sun,  9 Mar 2025 17:31:47 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Message-ID: <20250309173151.2863314-1-edumazet@google.com>
Subject: [PATCH net-next 0/4] inet: frags: fully use RCU
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

While inet reassembly uses RCU, it is acquiring/releasing
a refcount on struct inet_frag_queue in fast path,
for no good reason.

This series is removing these refcount changes, by extending
RCU sections.

Eric Dumazet (4):
  inet: frags: add inet_frag_putn() helper
  ipv4: frags: remove ipq_put()
  inet: frags: change inet_frag_kill() to defer refcount updates
  inet: frags: save a pair of atomic operations in reassembly

 include/net/inet_frag.h                 |  6 ++--
 include/net/ipv6_frag.h                 |  5 +--
 net/ieee802154/6lowpan/reassembly.c     | 25 ++++++++-----
 net/ipv4/inet_fragment.c                | 31 ++++++++--------
 net/ipv4/ip_fragment.c                  | 48 ++++++++++---------------
 net/ipv6/netfilter/nf_conntrack_reasm.c | 27 ++++++++------
 net/ipv6/reassembly.c                   | 29 +++++++--------
 7 files changed, 88 insertions(+), 83 deletions(-)

-- 
2.49.0.rc0.332.g42c0ae87b1-goog


