Return-Path: <netdev+bounces-214846-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37863B2B6DA
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 04:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9D571960F56
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 02:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B5F20B7FE;
	Tue, 19 Aug 2025 02:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D2o4F2W7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7471DF75D;
	Tue, 19 Aug 2025 02:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755569859; cv=none; b=kHNMfyAq1GQf978fiWjV5xDB9CnhiFPkI7HLkLKF+OZM7iljvfk2FYYb4/rTCG4YdJ2F/Sj0qDPzCR8jnC3OEnc6KkqL3pzEZ2SvTnEcyLQGzZIvFd6gwYJPoT6dBLZ9VzJTfDRHq2NI7+W1HpB5gcZrdbvodS8COWiRmgleRLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755569859; c=relaxed/simple;
	bh=O9RNrF8SEJm4ca/Z01lu9b8tdh7d+MfsU4Kts0wpoRg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lyiH4sj8/xAHbz8ih8phd2zU6T80rGB9xerGeFuQtqTBYdthU57QHRksDUjAq7mpYdsn/W7uru26RhyUe2Fz2mr1t4rAG7PIgckZ4jYWKBTlcmE5E9ZmSbacDudy+QNcQZ/BcmxGIGD/vlMBLPkEmpfN7rSmQdulyJqIJ+L1EAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D2o4F2W7; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-32326789e06so3879815a91.1;
        Mon, 18 Aug 2025 19:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755569857; x=1756174657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QW0+zmgokdGMJQrw7uqaJY0AJyJi8JzEFzanmMPUYX0=;
        b=D2o4F2W7EbPj5v1/APaFW7GAjEf/jCYjMvJwC36ocOobR30DeMB9L464Z6kNIHzCl3
         8/kMXPz9rANkgPhR48LMOAyantPg6nV6TYu8Vo/aufMhct/ufyjds2ERJpcPsxOVHgom
         6s4oQTdKP62AAVhggz+j+DQ/nocLu7BXbpaWBQ3n+gs7vF6N4uSN5WYG6JiZKgJhr9xH
         fTCBGbTwPO3FUClDbp4HTzK/1hvboQhuc6goKoi7ZnCf6XOUuViSwlbV4kKgvcpVMl4b
         hyUUffJ3p7l0gDbkJEs9N1dBbcOymCYQbJcXWM5OUqfDHQb78Xikv+nWzEOAV17izC4n
         JlUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755569857; x=1756174657;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QW0+zmgokdGMJQrw7uqaJY0AJyJi8JzEFzanmMPUYX0=;
        b=mX0G/rHrrvldjsf4Xki0z84XMA7ChXKL3zY/Sxb+hubBOgjdA96k1rvSr3FONru6F5
         VObQGJUwwWVkN9IReUNqvHQVJb1LnzL7Y984SyZdFINGzygd/6vXUs4cMvYEd7dZP5Hj
         VMzjvXyxJ/pVQnElgZogzu173oQxo2OIO0bXTWNw/MZ89C6Cz8rHmyCOJXhu6nmKLWUW
         7nhB3fixEIoov0mM8BGkU1IZ4gwoiTCMU+ZcoRF4oosd3FBnjvk3AoiWB9HGcmA1bA3C
         wa9WKcpWi+9w8WmqfVaqxNYasJCLTkTn2bUQrdQsAk+5N1Wl305ZK9qbLigrbqrywiht
         xyxw==
X-Forwarded-Encrypted: i=1; AJvYcCWL2hVOSi9QIWJohG2614MjgoUVCfVW6TJ4sbcfNUS+6DR7mCL4UsOsdbdd02bUKRIoR1hOmImnBkg1wqY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzgt44Rn0k1kMfh7qif6Rb9wZuJX1J5Ss9Tbqa6gUv9g3UfsRK4
	sV62hMuPzbbc0EO1txqkA2S4/iWgQkexagkWMqZHPKo8H2iYzWG1kEWE
X-Gm-Gg: ASbGnctoGjF61CCj2Biq9rAd/H/IegGFDL0pIMP0mBb9L+wGnL/tEWEjwmBtKpywa4N
	OBZ/fv0fx4ecx7BtY3hQt+My7LnjWKSE4jEZ/buwsIWOIEDwPdOe7tYKgF0rxhhY6dERUhY7O38
	w/mP2sspofpxLL3/YZ6J7cjiTUtzSL423NFq8+uGsZERXBZrDn5M0cLcPvhStOWCJKqwkon4l/P
	i9jKTVYnImaikmtLcB5Lw5Clob5CEbmhOiSGooMxfCJl5UakQhHAnCtun0p0TwYLEt0KnqMRkFs
	97x0PalKr9vRVOnFMlHV3WXRZEYHHKyU3wIdppF0v29jfRZvnNZ/xFxSpc3sJj3SG2kIXsfBlfP
	z08mqRrSB7J5ZCda/jDE65ibpWDD0GVTRo7ue/Wc=
X-Google-Smtp-Source: AGHT+IG0SJ7/3cQs4jx0w3qEcg0f3kr4Mp5Ya9KE1ew3HqPQ+GDnQVf6KtK0iW4s3a4fMUIKRO9WDA==
X-Received: by 2002:a17:90b:57cf:b0:312:e6f1:c05d with SMTP id 98e67ed59e1d1-3245e568141mr1234288a91.2.1755569856981;
        Mon, 18 Aug 2025 19:17:36 -0700 (PDT)
Received: from C11-068.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3237e3ed89fsm1265485a91.17.2025.08.18.19.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 19:17:36 -0700 (PDT)
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
Subject: [PATCH net-next v5] net: avoid one loop iteration in __skb_splice_bits
Date: Tue, 19 Aug 2025 10:15:51 +0800
Message-ID: <20250819021551.8361-1-hept.hept.hept@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If *len is equal to 0 at the beginning of __splice_segment
it returns true directly. But when decreasing *len from
a positive number to 0 in __splice_segment, it returns false.
The __skb_splice_bits needs to call __splice_segment again.

Recheck *len if it changes, return true in time.
Reduce unnecessary calls to __splice_segment.

Signed-off-by: Pengtao He <hept.hept.hept@gmail.com>
---
v5:
Correct the summary phrase.
v4:
Correct the commit message.
v3:
Reduce once condition evaluation.
v2:
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


