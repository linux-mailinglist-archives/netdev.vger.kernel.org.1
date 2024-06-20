Return-Path: <netdev+bounces-105410-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 009D491101B
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 20:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AE401F22A22
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 18:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F6F1CD5BC;
	Thu, 20 Jun 2024 17:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lBuUtVI0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683BF1CD5AB;
	Thu, 20 Jun 2024 17:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718906310; cv=none; b=KqHRuaU1nwYh8+A8Rt0o37bqbzskEn20uE0Ox5LGQrLmWTel59q+Cqx9mTKUe+0NXZj1uHwzHx78BYWpymeBmEVpFyPndnHi8AEEplL65gZxG7O55qZB1Sfl5+7gK0mjX3Tx+LyPWCWzandpX/hirR+xq78akI6bx+Mv7idoAjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718906310; c=relaxed/simple;
	bh=xIXzaqvD3dZKkTf9zQCESfh4yAmpcoxDwwO6XLudC9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NL5rZ8HMrGHBHcIuUzTVyS/X73grcO/7ZMha832cf8tlwyXGzkm+39Enojm+MSy8klm7COro0cmyzQEBzoyl4FT/7PeDeuDmpIWmpQO0io36mdDwmwt8yoZmlBsRcwhWbMIr+a/VXhXuR/XsbtlDCkgx8+RxHFanN3xLTYGmEgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lBuUtVI0; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-70627716174so1068189b3a.3;
        Thu, 20 Jun 2024 10:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718906309; x=1719511109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jPbSDSWVNJkYRt5U6fddE9YLEW5XzX+KySLxZvUgJ0U=;
        b=lBuUtVI0R1aOZIO+NIJGFrtPwPg26jCxUpklMMfcJ7v/8GsydH3SPCXvAnmRDI+gfv
         yJN4UvI33PSF2EtyqPfRs/EYajsKVmjckOKDxvpd+HknyF/dCvEIXLcRUPeFDw4PXCsY
         +MGmrU1OUo6W9DmTQOea3clbuNWB1OwVkRAOirLppuDUgWNjQrzf1ixQkeNSIEl4p6RR
         ix7EKFe+d/aJnJwMMZgtNQSHrlgZPj4Gr4ta79WirtW1hYbGBAR6SkHtDdNwak/Y35HR
         NxhqYRKflWJqBEbQ++fcFtMZt+LX3Sztr54YMRmo0Tx4VWvaZV8bP//+s1SE7MZ7tFne
         Tf5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718906309; x=1719511109;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jPbSDSWVNJkYRt5U6fddE9YLEW5XzX+KySLxZvUgJ0U=;
        b=cimvZZB5ZvcoeSGtLgv7vOZJSw38F7VfmI4Ku1O8Be2Ce3SR6DjMh/h8U1+pMOTGa+
         n97dAXcCezCePb8/n+w0I18R666JnHEV8BtquwW0Pvl5TKwSvS+6A3vqT5hl/iqDStqC
         RqrXGmnZrbfGVaRUXeusnD4eX1+jPtehjeNmO1gaDe/AHU11wf4Ekrhal/fhoLC0Ju4o
         ZfSIrFBLgKO419nmuRMDPdQPGF1/481nri/hCxNM6exLU1GQQORxBhFDb8Pv8TX7pOq0
         58XpzhZ5THrqcoqXqBvTKyrZQywIAz/ZhmyAaBNV/QefMNn+nGAyAui1jL4+3V3xN3vn
         +l7w==
X-Forwarded-Encrypted: i=1; AJvYcCW+ZcQdIFQLFMZnyf+ZAkEC2NOptANNRDGhbc3LkQNmastnF7AXjTzMZsEnfsKkT4G7CeKuFQDVy/+QkOT8pZpvag/WeYj592+fXIdlbni6yU1moRcG2R/hSRmbZ5FNHL/ujYzP7twr
X-Gm-Message-State: AOJu0Yw0z4JtyblKBeNDPxtUyQNuNc+Ivx4LQv4jqwWTAUdg0ioVc9g2
	FPmBtZsNX5A3Rsfq9Y8wiaO+z2xEJCKWaSQHzHs7yXZcwkvVMcRFBWXDGYoP/mg=
X-Google-Smtp-Source: AGHT+IHvf0bW8VCqpbS7PR3F8xoHNnAblcUThJfvAknOeOXH59R5Hyux42nvZ1qRNcQS9/OO7fDUNA==
X-Received: by 2002:a05:6a21:78a3:b0:1b8:6ed5:a89 with SMTP id adf61e73a8af0-1bcbb640cb4mr7628578637.46.1718906308833;
        Thu, 20 Jun 2024 10:58:28 -0700 (PDT)
Received: from localhost ([216.228.127.128])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6fedf2a74dcsm11326669a12.46.2024.06.20.10.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 10:58:28 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
To: linux-kernel@vger.kernel.org,
	Karsten Keil <isdn@linux-pingi.de>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Yury Norov <yury.norov@gmail.com>,
	netdev@vger.kernel.org,
	linux-bluetooth@vger.kernel.org
Cc: Alexey Klimov <alexey.klimov@linaro.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH v4 28/40] bluetooth: optimize cmtp_alloc_block_id()
Date: Thu, 20 Jun 2024 10:56:51 -0700
Message-ID: <20240620175703.605111-29-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240620175703.605111-1-yury.norov@gmail.com>
References: <20240620175703.605111-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of polling every bit in blockids, use a dedicated
find_and_set_bit(), and make the function a simple one-liner.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 net/bluetooth/cmtp/core.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/net/bluetooth/cmtp/core.c b/net/bluetooth/cmtp/core.c
index 90d130588a3e..06732cf2661b 100644
--- a/net/bluetooth/cmtp/core.c
+++ b/net/bluetooth/cmtp/core.c
@@ -22,6 +22,7 @@
 
 #include <linux/module.h>
 
+#include <linux/find_atomic.h>
 #include <linux/types.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>
@@ -88,15 +89,9 @@ static void __cmtp_copy_session(struct cmtp_session *session, struct cmtp_connin
 
 static inline int cmtp_alloc_block_id(struct cmtp_session *session)
 {
-	int i, id = -1;
+	int id = find_and_set_bit(&session->blockids, 16);
 
-	for (i = 0; i < 16; i++)
-		if (!test_and_set_bit(i, &session->blockids)) {
-			id = i;
-			break;
-		}
-
-	return id;
+	return id < 16 ? id : -1;
 }
 
 static inline void cmtp_free_block_id(struct cmtp_session *session, int id)
-- 
2.43.0


