Return-Path: <netdev+bounces-170955-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 696CFA4AD7D
	for <lists+netdev@lfdr.de>; Sat,  1 Mar 2025 20:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58D001706F6
	for <lists+netdev@lfdr.de>; Sat,  1 Mar 2025 19:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF611E5B7A;
	Sat,  1 Mar 2025 19:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bd5uztdZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f74.google.com (mail-ua1-f74.google.com [209.85.222.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD2E1D63D9
	for <netdev@vger.kernel.org>; Sat,  1 Mar 2025 19:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740856404; cv=none; b=O+kUUjdl1YME6TKnZ15AwZsp89QFG2MYFIfZhaKhi8LhmfN2qjBfVECIkiFr3HbyB+npM6AMEbMQ8RoGHGu6RcEe/vYmEo6nnlF7Vz8xAl029AxsIBJIG/X4/iHJrk7vuzKeyR7MV7YWx/H/NvGk2TCh0lMTNvCuFh5HjDDqino=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740856404; c=relaxed/simple;
	bh=Im/2Im03GoGhqx+/PqYukGkdBPKW+8GScD1PdDoOg4c=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Yzhw9KlJbPphRw/DKN74Jk7H8b2473+/nnKskxmBn6iGJNkGnjV9kM7UDZu4odGypIP4G2HjT+vrKOxTpU2xUk364HKOvpa5WBj2vCW11FFqLK0RUkfg2wTDQz8dEzLRMcqQ78NA4CXWYj0/oNcs2cXTa9LVO83UGxJCV3LYx3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bd5uztdZ; arc=none smtp.client-ip=209.85.222.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-ua1-f74.google.com with SMTP id a1e0cc1a2514c-86b34e92716so5766936241.1
        for <netdev@vger.kernel.org>; Sat, 01 Mar 2025 11:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740856401; x=1741461201; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9ywVjhY6fzV+QfKdVlcvS+RJwruHcsdpVLrrrMqKp3I=;
        b=Bd5uztdZjScOoRWA9E/KgIi3FjaKTRaCIOVSWCLR5V5teCk86vAW3Kr0EKHrJj+RGF
         yrc2fZvTmgqw8mRb5Ve5lyYpXh6odM4/v6pmbobCQaUXzYX6sVPBZPXEylovIpjG0BRh
         IHCQuolwFDjKPc0whkoH2N13yCmxXyHCc95KxoKELV8c7174t2a4cpVurPOZVrIB+Yc1
         1anAQ4AcZB3xRHBEaMvw0e7lM58Sv2ncOALGnGV/2A6j7vp5Z7LSMYJsH6/xNe4JEN56
         uKtwRPsJxW9gh3aztFjW7lff5912d2sHJWN5AqhlQXydgIpzWqJPw8BpMY6O1PkUozKa
         wZMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740856401; x=1741461201;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9ywVjhY6fzV+QfKdVlcvS+RJwruHcsdpVLrrrMqKp3I=;
        b=qWs7Ock8EbpOPzcsXRbjGAJIEVWtTHT3Xz2S8oLWUdbLWhVSJGokDCm6ym+s7yKqpd
         0U8TQcdXvVeNwX3fP3GgM/wR0C/bm2h7aDnOkjZ9MDOFsNqXJ0UO4hS3IfO5ZTRElDEt
         mvUh8+AtyO2ze5tngPImlXmLgKEsPRcpF3sxg6yyZYdVf+iYyTHgkY26uchfwKQgq41W
         jitxcNicgXPPVY0xSe9fuPggfKUPSbLGRQmNaw8m+CYKwsy4Pk58ItWgquyfDnD3GdLg
         eQ0IoP7O+rRflchQb7sWy4EWgQci46FNGrqJvlw7ic96xBeD2d/hZQ+FCpYXgWfOdRg0
         mbiA==
X-Forwarded-Encrypted: i=1; AJvYcCU9//OPsdHF8GVBmpwTS0RH0ConrmUZIlIq8cp8iAGCHFibnuKLd3/1awd1Dikg8X0cXNQFoko=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTbeI9GPhg3cvWlSIsF2c6hSR+nHkFu7nRm3TD+gfrHAW0LVZf
	c0AUsNrmGKSbaW5IHsq5yxhKJp2FkI7KRpqrufBeD5ThHtmqSMC+DFL4cZhZe/isnSRaKs3Pzmv
	siomK8b2kZg==
X-Google-Smtp-Source: AGHT+IHlEDY1w99nPU00fv2hKwIDN+zsB15ccWmux6lcYZLwxn41ycgj1n8xqVL27f9ejrkUf8ENXcghURVc0Q==
X-Received: from vsbjj2.prod.google.com ([2002:a05:6102:18c2:b0:4c1:6c89:f6c8])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6102:292b:b0:4bb:e8c5:b157 with SMTP id ada2fe7eead31-4c044ef98d0mr5666933137.25.1740856401483;
 Sat, 01 Mar 2025 11:13:21 -0800 (PST)
Date: Sat,  1 Mar 2025 19:13:15 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250301191315.1532629-1-edumazet@google.com>
Subject: [PATCH bpf-next] bpf: no longer acquire map_idr_lock in bpf_map_inc_not_zero()
From: Eric Dumazet <edumazet@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>, 
	Kui-Feng Lee <kuifeng@meta.com>, Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"

bpf_sk_storage_clone() is the only caller of bpf_map_inc_not_zero()
and is holding rcu_read_lock().

map_idr_lock does not add any protection, just remove the cost
for passive TCP flows.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Kui-Feng Lee <kuifeng@meta.com>
Cc: Martin KaFai Lau <martin.lau@kernel.org>
---
 kernel/bpf/syscall.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index e1e42e918ba7f682223e9a78028bb0cc360c01ce..d68c8d61f7ceddb732a5646c00b8f0c71fdc2d71 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1593,11 +1593,8 @@ struct bpf_map *__bpf_map_inc_not_zero(struct bpf_map *map, bool uref)
 
 struct bpf_map *bpf_map_inc_not_zero(struct bpf_map *map)
 {
-	spin_lock_bh(&map_idr_lock);
-	map = __bpf_map_inc_not_zero(map, false);
-	spin_unlock_bh(&map_idr_lock);
-
-	return map;
+	lockdep_assert(rcu_read_lock_held());
+	return __bpf_map_inc_not_zero(map, false);
 }
 EXPORT_SYMBOL_GPL(bpf_map_inc_not_zero);
 
-- 
2.48.1.711.g2feabab25a-goog


