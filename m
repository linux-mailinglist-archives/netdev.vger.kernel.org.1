Return-Path: <netdev+bounces-250573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 782C8D3390B
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 17:46:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 045403097C04
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 16:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C04D2DF12F;
	Fri, 16 Jan 2026 16:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O3EUtoxp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B2F23ABA7
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 16:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768581846; cv=none; b=nHBbIZSh5nuxh6PoXU2u/Sc0owy2Xf2hVNrHWjkiWNRyKtyrwoIHEJ+En8PrMkWun5sOcfWWdJKMe8N6lj4Z+sezCiP8VPc8Dspq6WuOLiLOWQqis47iDEfu0aeXwJKtNQjKsX7UPFFbG4zUIhea4/tOP46zBF7rdQSn580Sz7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768581846; c=relaxed/simple;
	bh=2FEiuPbN6AexVwKojY3ywpxgCTV3jTb/pQ86uiMLBeg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=OFb8M1htHqq5kLDrkfbVnveP2K/+SOe4o2yfPs0k8VHUufhRDeWNKp65jFTjj2/EYppimcNYtmV3K+YNFxh/UVtV7egvfkQgHCENYB5DxVxra+iPkFDsVfxU2hikV7eog8XYqqGaSwc5yfFoehkkm9ZtAB+4qXpTByQ5CFt6c/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O3EUtoxp; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-88a2ea47fa5so50193346d6.0
        for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 08:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768581844; x=1769186644; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Zd/lWDMX64fyWgmne+W4U+SV0ORL1xmKRoGtBKDypN8=;
        b=O3EUtoxpu6u1OV4kE7NYcvVP0/2k00WulmFbx3pJHm4oXvWVpRo1c1n1r9ef/nL7Ub
         ZU+BErFSWJ1MzQ4aoH43wG7UUv0stsNWyPirsgxra2zoC41yxu3Lg2VYr1kxkdAnJOAO
         fp//nSMuQr56/v7kbIDZK2MbuGaxfFDcdIwU6JoIsonjOCMqUZeweqZGLaUEQNM8ceUp
         rmcsEzhSOpCSdLwzPzzo/3PTTYZjoLFy599WQE5p+bZBGLjpZYdI/0fs51rEgkdTI6xN
         7KPkRinW16jxZfjAmVHifaCcSRNSkTKtk9pn6PbGttQ1YefIVJfK1OZc/YsfhCUIPqqW
         rE4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768581844; x=1769186644;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zd/lWDMX64fyWgmne+W4U+SV0ORL1xmKRoGtBKDypN8=;
        b=TBlfou6BTmgrNdBkvVrdwPX5JdLS/eeZvHJyWxrXBUe3YeQa2rwL0ip9gUZ1I66nIG
         uce0YCHuA+/5Ma1PKYvo9YU7hLxqFGHjbqwBJoCAGvSpFP2e3kXZvewIiIxfp6QjYlLp
         SErsadtiMq0TdmeTif0Z6K5KkEQUNZMqZvO6FD+78a6BKU3L9Z3384p9S4Gxc/d3rA5J
         +xuGhmNU/sEdbxMtsEql0STz90Ie/R9Q6zNX4Sv/TY6aCUiEK2bfZSqr/l6HQmzOohBl
         Y9VWt0VBo/lMJXZOFRE45GlUahGA5nSJ0h+9whyFXgx1p5I+N1N1s1GSdn8OzZxkjwZI
         K23g==
X-Forwarded-Encrypted: i=1; AJvYcCVhr9NW00Ejq+DlT4crjJswo1IlEFllmvWyNtvfT1Dy3Z3bHQgtCSVx11g6VlvGc6GZ9iY3S8k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/CHbozF3XdgkxmHZHodCqR+l0YCDDUryT1Et4iPEybCNQczT0
	mbxmPHAiXPkVJB7+mqZJul2lHcZ9WoqTcec83iojk6TUHAuwGFTEb+5PmTgbm4SZWmX9XVq+dwd
	WdASoiN28KDnQPw==
X-Received: from qvbon15.prod.google.com ([2002:a05:6214:448f:b0:892:7301:3559])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:262d:b0:70f:b03d:2e85 with SMTP id 6a1803df08f44-8942d7be817mr46917086d6.24.1768581844012;
 Fri, 16 Jan 2026 08:44:04 -0800 (PST)
Date: Fri, 16 Jan 2026 16:44:02 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260116164402.1872649-1-edumazet@google.com>
Subject: [PATCH net-next] net: fclone allocation small optimization
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

After skb allocation, initial skb->fclone value is 0 (SKB_FCLONE_UNAVAILABLE)

We can replace one RMW sequence with a single OR instruction.

	movzbl 0x7e(%r13),%eax // skb->fclone = SKB_FCLONE_ORIG;
	and    $0xf3,%al
	or     $0x4,%al
	mov    %al,0x7e(%r13)
->
	or     $0x4,0x7e(%r13) // skb->fclone |= SKB_FCLONE_ORIG;

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/skbuff.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index f2367818c130bcd3095e9bd78fbc9f9a0ac83d4b..1c2b9ae7bce6457395a82d5bd577a9e125eceb95 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -723,7 +723,14 @@ struct sk_buff *__alloc_skb(unsigned int size, gfp_t gfp_mask,
 
 		fclones = container_of(skb, struct sk_buff_fclones, skb1);
 
-		skb->fclone = SKB_FCLONE_ORIG;
+		/* skb->fclone is a 2bits field.
+		 * Replace expensive RMW (skb->fclone = SKB_FCLONE_ORIG)
+		 * with a single OR.
+		 */
+		BUILD_BUG_ON(SKB_FCLONE_UNAVAILABLE != 0);
+		DEBUG_NET_WARN_ON_ONCE(skb->fclone != SKB_FCLONE_UNAVAILABLE);
+		skb->fclone |= SKB_FCLONE_ORIG;
+
 		refcount_set(&fclones->fclone_ref, 1);
 	}
 
-- 
2.52.0.457.g6b5491de43-goog


