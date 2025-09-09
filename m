Return-Path: <netdev+bounces-221353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 50855B503D7
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 19:05:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1D8474E3292
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 17:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04EA316900;
	Tue,  9 Sep 2025 17:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="2xT1kLZO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF8E393DC9
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 17:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757437243; cv=none; b=EPdmEZRGuYRzy6zDdgQM5WNbS3XGZqOyGXhfR0o4bKgpjrySfEIkC6a6NrlVF4/cXEDqToQy8B2gOQoW/yKq8vdKk7pZaDwa2GJLex3rBdGgSOgUMtd3AlkitSm6dNPrfYbx0caqQ+N2sitIOIrTO2fLKOHihC9PgVEeyBew1pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757437243; c=relaxed/simple;
	bh=l70Tt3FuZHgPclFIM+NfxP198WHw2epKUvxqXGbrz+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bXkb4SP0gqLkaqixwN2EHP1utNa6mGpJIL9uRez9VWfUR5kWeOfOQp0x3/f7HCFe3h91FZdQJ7gyc4Eue1FjnsmMKY51vzuFvqF0nvLKzgTcK1y7GOHs0tUNcjPukGMI9pbrUtS5RM3QTdq0zNMO080STke+uoC5sa+cHE45z/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=2xT1kLZO; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-32da2bd7044so147189a91.0
        for <netdev@vger.kernel.org>; Tue, 09 Sep 2025 10:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1757437242; x=1758042042; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gH5okahG80CFaiitNQPCJC0OENnKbKego7xVaG7PJGg=;
        b=2xT1kLZO0SoU7EoPSyPSjTEILC+3KbmAv7CyL+49X104TYQDpu1yMb3pe6fdZyrg03
         xsJHfIOaDNE/pDRiZ2MpHhfmL9ZYybZLE1dPF5F/1aRgP+9nHe/UayJeH8mqOt5ios5P
         Wx5JlBDQTQDjCtrYk4I6Rro8azn/S1rzWpEWQKXUmMFCZMlfBjqBNiUW3MIP02JyfRhK
         kkeen3RYClpMenogabM4ZEAoa2TZWuHfe3GZkwaFp9MqTltjkZcOHLesgaFexefMHvy3
         2xv2+K/khGriRpaUZYGBR4o23ofLgpM5Uwz0s5waHUc/jv6j/yjBYsJKZZUJ7R5oUaYX
         YK2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757437242; x=1758042042;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gH5okahG80CFaiitNQPCJC0OENnKbKego7xVaG7PJGg=;
        b=Ukwg426wGX4QzMZePmQ9btVmeSx1ZXZMA1luoNexL0EszUQiEBWbpgjBKS/G6ZFjns
         IekhzO6D4jug+YBAVUH65RTpg3I6rKKvuTFYG2PAhVMOg5BBBa/PtW53rIVAxPKDFeVo
         Q4b2t3rriElvAQ5el1ZXv08cdk3i1MAgmfRZ57PI/u+lYhZgcksi0ekY+5OqHu15BJnt
         XCpCtZobK8ObBp95o73+DaH9ZrgWH9+BBQ9YPuOVBGe9FB0OD3eYJHdbiANQMXLK1dzn
         nhIdpeFIayxPmq/uFz5j/CRQZiDZOyIDegwIbgxA/q9uj0Vx0xvZm/fiM1mDGLqmL1GZ
         ywzA==
X-Forwarded-Encrypted: i=1; AJvYcCUbDqr6et7607FTqY+O5L4MpM7TB/pe2ldPphGSAejfEr4a/A/4dhapFr0lg0Pd8J+SofCkNds=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz84aQ9gnIrwy7eTrEt/EZorYg/4gyRBrjjL5qIbPvdbZwV+QE+
	yVDj/3zWNrqeB3Nchka8N0DtvSLtnae0MCrRpz5K2dKXURaUxXtadSM70o/KLMpFkzo=
X-Gm-Gg: ASbGnctog+D19iye7eAkwkKiWGKoG3JMPF2Oz8bmPGPMcLgbflRFWF4rnQWMhrDGuzP
	kSlI8vrn7pOY2y+fD8+HWXUId/XZngZJ45mgoywdRpNA7pTgFV5YjWKiOV+O/e6GnO2cG413n9I
	iZbo2+sWXr0wfp6EBT2MM4v7DlIhm94C5ahoFJqG+x7H8/fSRC/cyQ+58ERsNCmNfKRqOWEwLeC
	wAWhe2/E8nDiZZAlPm3J2bquAFq0k9MNbb4GVOA15IhBQDGTR3vUz3cQ6fJoHiWwTtinIvnLREb
	RPnmjeOKwK+e3Zdt6bRwLCIuvOa0sL8XQ3lu4WfdhVF8jycmSZx+TmshXPGEwyWI4pf/S2Ha3dd
	VGeyQpBZYskht/6ciWiqBM21BVB7ncwyDPLOzyXokptW56w==
X-Google-Smtp-Source: AGHT+IE9t/bVVwp+x9aU6YApQEJhEPGf3ZFC2snlfCBL2peHMOS3ErwrvPCjskLHZK2jWDRAnLK5cg==
X-Received: by 2002:a17:90b:4ac9:b0:32b:9e6f:f36b with SMTP id 98e67ed59e1d1-32d43f65c55mr8635918a91.3.1757437241613;
        Tue, 09 Sep 2025 10:00:41 -0700 (PDT)
Received: from t14.. ([104.133.198.228])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b548a6a814esm251733a12.29.2025.09.09.10.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 10:00:41 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Aditi Ghag <aditi.ghag@isovalent.com>
Subject: [RFC PATCH bpf-next 12/14]  bpf: Allow bpf_sock_(map|hash)_update from BPF_SOCK_OPS_UDP_CONNECTED_CB
Date: Tue,  9 Sep 2025 10:00:06 -0700
Message-ID: <20250909170011.239356-13-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250909170011.239356-1-jordan@jrife.io>
References: <20250909170011.239356-1-jordan@jrife.io>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Finally, enable the use of bpf_sock_map_update and bpf_sock_hash_update
from the BPF_SOCK_OPS_UDP_CONNECTED_CB sockops hook to allow automatic
management of the contents of a socket hash.

Signed-off-by: Jordan Rife <jordan@jrife.io>
---
 net/core/sock_map.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index b0b428190561..08b6d647100c 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -522,7 +522,8 @@ static bool sock_map_op_okay(const struct bpf_sock_ops_kern *ops)
 {
 	return ops->op == BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB ||
 	       ops->op == BPF_SOCK_OPS_ACTIVE_ESTABLISHED_CB ||
-	       ops->op == BPF_SOCK_OPS_TCP_LISTEN_CB;
+	       ops->op == BPF_SOCK_OPS_TCP_LISTEN_CB ||
+	       ops->op == BPF_SOCK_OPS_UDP_CONNECTED_CB;
 }
 
 static bool sock_map_redirect_allowed(const struct sock *sk)
-- 
2.43.0


