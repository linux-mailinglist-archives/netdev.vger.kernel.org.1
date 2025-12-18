Return-Path: <netdev+bounces-245275-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8A6CCA1FE
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 04:01:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C60C3058869
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 02:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAEE82FB997;
	Thu, 18 Dec 2025 02:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bHoNMrAz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FF02E0400
	for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 02:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766026792; cv=none; b=DAYJOmwTpglodfc7TTKmWXJfMrIJbIbojiOtBRNQz9wRPjNs9Txn1M1ZlQ3hrLo5zoHpmAARvHM2uHnezBlK3//QCQaUwdG8vBePB0fapfLtPxNEjOuUlla5OTQ6tVpK61xcEctTHRc7PaRTSiohmtHJajKsDDBCKhFNANuTKKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766026792; c=relaxed/simple;
	bh=JMe1NKX9+LRlV6iB7gIIlQogjxDZeA3/lEGWMoqAGZE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UkSv+oT6ENPIXr+rbssrDshqb3v07WLsziH1Lhvf6LggFJVnXaSWEIljCmS4C+TopW6PcTksJ1rMSDQ+TMQp5HxQnG2X+0KKyENKU24YA9Mk7BZalmvdYZWRr06JQVzQv8MFeBbkBDkUS9PJnoEYRweyMaRmG2Vhb62ebBy5skw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bHoNMrAz; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-bc144564e07so3972a12.3
        for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 18:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766026790; x=1766631590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lhtvv/nnzcntvywC/tr4tbEvzKikdNZmh60gHEEDoPQ=;
        b=bHoNMrAzTAOPHm8y/yiVGYlGhAgePCkPtvKXARRfsg55uZFV/yJ6iHvQlqmc4z3uiB
         4Q0zZWiI/L4O5x+E2ufVlsBS64g3TKr6+1rxC+zODI4NbMhN5s1iQVgBkGZ2+cK8v0xH
         uXpMDBW9WFe6ARRo98aTlum5j9ofR4MzFOJ5TBcBFKzTsJdwi35d0AtRSBmjXuFxa0O8
         N0vDp6urArWyx/fuAWK6PW7BJft+5m4am3fWkY3BXzlfrylDMANesE2XLy8Gr6qPMqb3
         yp6zk1no+IcEBMhNIg+3JR28UJBeSZVzuRL9QGc6FgXoxzbtQyh/PODwr0h3VAblIiTM
         dDug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766026790; x=1766631590;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lhtvv/nnzcntvywC/tr4tbEvzKikdNZmh60gHEEDoPQ=;
        b=XJ2J33OqnOOrAS0qa6AGHtPvoePZH89mZWGUTHEmclEM8JDLJ6HzKUr9LYC29RQLh9
         TYRyqzRqsxvSbUn/amm3aAj+y+32bC+DzriGCCe813xKb0vxXnysMxdcV3YFwiisdTRT
         cOoqFYZK7HKjfiJXgFM+7BiJiIdo1EG2D/LFrY42dVqoxRNSJ5HdtY8S6Ne8lk9nXPiR
         i3YnuJ1W8gr2d7BEKxokWXy2yULfIvBqBsQVGa2eFfp4NLOfCMFW+nQC4MCU42REttP+
         iBYn4IKZTJ6irPlFfk7SBRDyDNY2mtqGiQCyh6um0j9ZIS1j5yq6xHs7gExQNMshuSRu
         BC3w==
X-Gm-Message-State: AOJu0YwWM08B5IQJhXeJ89tUGXcVioKo9aaMsAyjmlxfqqsusAgxV+o4
	+hPRYDQBO+LBHVYI9Bmz4P7hUw7UCeGXKjTmogUS5Xwk5rRZVj6CAoHoTGNjxMO4
X-Gm-Gg: AY/fxX6Xm847NrsBhqH9Wzpu7gYSeleAgcU1isXAIhDB5KCWETbaya6S7RKWcK2Qdzm
	f+UrA3CBBQaCYfLlHHu+bgZ3c0KiZu4r1HWV7J+/434JZCYpcRUtd4Vrqu2agPZOMNuPRPnDGAq
	T+TlS540N9k67ttpCpn+dSVUxmr9Z5Mkyp0gi0/iq6G83JHk30cPmMDgefZxIey9riix5vqqNk0
	fgi6/jEfbYgcdyphV3IcVrlH0lUWQyldePqNml5+WmNXmEwdqGM5l34yJmAS+CRanLb05jk751o
	D/9orw8Kdr4EQKCjWPGU2ch8BCP7VdM+agAZrqVgU9aH+t82CC4aoBQsFAuzUYj02L6JKVXgK46
	TdO80iEO9ryTA9TimjkLwqmSKEAeOfcWBSRQtNcluMfwR/Azx9t5vXbBsQJIqETkobGxHqiib5F
	t8unU1K2LIgbzPSN1RM5VPajQbM8gDk5WNbxEXo2TEUXTKBef1WB4n8giv8YZpWrFR8Hf6lf+B
X-Google-Smtp-Source: AGHT+IEXXsNXo4V+iPeVdeilF/ogXTHJKXHWyVHS1SyqG1zKI5aoRlu8AfsEk4yQBcYSiqZPunOd3A==
X-Received: by 2002:a05:6a00:2d8d:b0:7ab:9850:25fb with SMTP id d2e1a72fcca58-7fe5188753cmr535463b3a.2.1766026789805;
        Wed, 17 Dec 2025 18:59:49 -0800 (PST)
Received: from poi.localdomain (KD118158218050.ppp-bb.dion.ne.jp. [118.158.218.50])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7fe14a5727fsm800985b3a.69.2025.12.17.18.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 18:59:49 -0800 (PST)
From: Qianchang Zhao <pioooooooooip@gmail.com>
To: netdev@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Zhitong Liu <liuzhitong1993@gmail.com>,
	Qianchang Zhao <pioooooooooip@gmail.com>
Subject: [PATCH v3 2/2] nfc: llcp: stop processing on LLCP_CLOSED in nfc_llcp_recv_hdlc()
Date: Thu, 18 Dec 2025 11:59:23 +0900
Message-Id: <20251218025923.22101-3-pioooooooooip@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251218025923.22101-1-pioooooooooip@gmail.com>
References: <20251218025923.22101-1-pioooooooooip@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nfc_llcp_sock_get() takes a reference on the LLCP socket via sock_hold().

In nfc_llcp_recv_hdlc(), the LLCP_CLOSED branch releases the socket lock
and drops the reference, but the function continues to operate on
llcp_sock/sk and later runs release_sock() and nfc_llcp_sock_put() again
on the common exit path.	

Return immediately after the CLOSED cleanup to avoid refcount/lock 
imbalance and to avoid using the socket after dropping the reference.

Fixes: d646960f7986 ("NFC: Initial LLCP support")
Cc: stable@vger.kernel.org
Signed-off-by: Qianchang Zhao <pioooooooooip@gmail.com>
---
 net/nfc/llcp_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
index ed37604ed..f6c1d79f9 100644
--- a/net/nfc/llcp_core.c
+++ b/net/nfc/llcp_core.c
@@ -1089,6 +1089,7 @@ static void nfc_llcp_recv_hdlc(struct nfc_llcp_local *local,
 	if (sk->sk_state == LLCP_CLOSED) {
 		release_sock(sk);
 		nfc_llcp_sock_put(llcp_sock);
+		return;
 	}
 
 	/* Pass the payload upstream */
-- 
2.34.1


