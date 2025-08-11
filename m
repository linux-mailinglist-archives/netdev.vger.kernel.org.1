Return-Path: <netdev+bounces-212654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9746AB21967
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 01:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F25D9622C44
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 23:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484B7261574;
	Mon, 11 Aug 2025 23:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yvun5KS5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD344199FAC;
	Mon, 11 Aug 2025 23:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754954904; cv=none; b=uO6qL39MAWE0x0P4sx78SrvxDT+Kaks+iAvoQ3SNqS99WlvdnhbEtUGGugRQ3yCBwghvXUjmbPAgJz98xqDYsumGRWjJ76gsKtOpa6z18nYohv+4cEwWbTLar//S5RXxrF1AxQfXsalQRxoQFaCFfYR82jclx/GkOmTpD66G5QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754954904; c=relaxed/simple;
	bh=oKeVGy0RkekyqjulkjS05Gj0xAfuLQtvBA4WtI7tmEg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LAPvcHWcOA8w85Zkc/6hX99ztyfb4FjZnSZXU4oIYRtvaOMrEgU71ibrbfx//nmVTiN3y6hpWInOLOO2BdYpFOJYY3c8Vyuh8j4wD9tZqn6BIYFndZWdZL8iaUv2a0mppNLI3WRIT/j4nMIdeWoM//LYM0sp6RZ0V5aKdppwJUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yvun5KS5; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-76bdea88e12so4165586b3a.0;
        Mon, 11 Aug 2025 16:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754954902; x=1755559702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FStyCwDnIrIXDZFkRPm9oX9c2zmQ9q098S2nJmrXCl0=;
        b=Yvun5KS5cnO4oKWzpZYpz/G0DBHPwIuraV1PUQVOa6U7liSrlPU5WTUHiMs0c+MAyK
         YR8N7FZ04m17Q+WXCh0q4raSfNiH/gjWWUqFsR/pxTd+nEua4kJhLSW/8D6yX0TNq+NM
         ZjKs/xVLKmywfD+T5EpbclgP8VqevTpwELcSt1bNkJRYIPoOLVUCrLN9wCPj54ZZrcSy
         11r3ii9tJgkC5PawpF+bVbyoiGVaOxprEKj4F1HDzIml4KY0w2pTUY6GlXdwjhCaTzJ4
         5fni19HzGo1YW+XXON1WT6pVxK8GdrST4mZ7vr40LChkpvHUTMyP74vtR9iAeSBaY8DD
         hzpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754954902; x=1755559702;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FStyCwDnIrIXDZFkRPm9oX9c2zmQ9q098S2nJmrXCl0=;
        b=uVjW4kYdmSxT2CxkcX1tRlqisym4Y2+SzgE+gek//kjxZUy/cxTeRK0QrwiE3p8y5Q
         LGnu3FbISy1V96bPIuP0CN1LO8Mj0QdfQ5/M/jP9fXfrTD/G6eXgE1tHQcb/nPiM0NkH
         iATQc16uQrXokKt8AXotq02+Z6NdNwRMWlvHalVphg9oY499shfhQZEabEl7WliFDOvf
         WUZcCtjS0zzmgTaTYtU3nM/boTWDEUol8dbTHuWG+EC9zRmugX1suzZwswB1z+00rGGk
         7kK5C1g7QjAFgwv2XmZ6Eew+6JlUO8uhWGawG56kn6PSIpxrjmdozMrFw/qIGMqNXzog
         2NZg==
X-Forwarded-Encrypted: i=1; AJvYcCUNbAIdphiNjkTWif3e/IcLXg6tOhPW+9bIgbf+1Fy8kv/I5P+0s3Wr0vle+1zfyJwqmGe2kukvgSDwM+c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMuhqOvIrTR/2cx0rsYILhrJTiqQ+Ns1kdW6JT3nc7ud2U3wGh
	M3Cp67Rban8dxE12tXETITjOw16hq4aYk6yYGqYHTMNyDcYn/V2pi/o8
X-Gm-Gg: ASbGncuPktKnr5Y+67vaojsgnqEkiSOxtFG4LXYs9OGyOrPiWp+Ywu2kHCe9lyj95OC
	UVNf8MZBNYplC2MyoRRe8Z01RFkcOTjR0wMYrsrOdlUvhRav0h0/4qNxlsjUvUCZJ5qa0+rSG2H
	N7rrkIsjO/DMJDTeho6X28qU0rD2LPfbPo9oQE7qBEtPdx3UmnymhGQb5FnYriUgj3EsSdrlXsQ
	c3K/M5CkZv6GEG215NnWmAXNJYMn7OO8Vzf23aHnTUOHUpdY9ginmV8xwUrb1hIoJCktnDushbt
	PC4/0Jt5ErqW8C9xDqGN0ADfmcQDgSWem9fzqp4Hm/rbIlQ3Qv0PFLnjiVlyA4DNDGC5UhIxmdH
	8YDKySFfEVgMgjmFuuDRBRHH/K7N3acyl2ybSv08=
X-Google-Smtp-Source: AGHT+IE4kfXamRiRyEEN43mFIlbwEeZtHP9e229Wsgvo7YksfYZgqAu17lnNkvusRqsWAYLGm/cJlg==
X-Received: by 2002:a05:6a21:3384:b0:233:b51a:8597 with SMTP id adf61e73a8af0-2409a9b8011mr1967227637.35.1754954902049;
        Mon, 11 Aug 2025 16:28:22 -0700 (PDT)
Received: from C11-068.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccead450sm27878743b3a.54.2025.08.11.16.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 16:28:21 -0700 (PDT)
From: Pengtao He <hept.hept.hept@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Mina Almasry <almasrymina@google.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Michal Luczaj <mhal@rbox.co>,
	Eric Biggers <ebiggers@google.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pengtao He <hept.hept.hept@gmail.com>
Subject: [RESEND PATCH net-next v3] net/core: fix wrong return value in __splice_segment
Date: Tue, 12 Aug 2025 07:28:01 +0800
Message-ID: <20250811232801.28489-1-hept.hept.hept@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Return true immediately when the last segment is processed,
avoid to walking once more in the frags loop.

Signed-off-by: Pengtao He <hept.hept.hept@gmail.com>
---
v3->v2:
Reduce once condition evaluation.
v2->v1:
Correct the commit message and target tree.
v1:
https://lore.kernel.org/netdev/20250723063119.24059-1-hept.hept.hept@gmail.com/
---
 net/core/skbuff.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index ee0274417948..23b776cd9879 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -3112,7 +3112,9 @@ static bool __splice_segment(struct page *page, unsigned int poff,
 		poff += flen;
 		plen -= flen;
 		*len -= flen;
-	} while (*len && plen);
+		if (!*len)
+			return true;
+	} while (plen);
 
 	return false;
 }
-- 
2.49.0


