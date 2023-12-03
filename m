Return-Path: <netdev+bounces-53349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2F1802703
	for <lists+netdev@lfdr.de>; Sun,  3 Dec 2023 20:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCCC4280D52
	for <lists+netdev@lfdr.de>; Sun,  3 Dec 2023 19:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145EF182A1;
	Sun,  3 Dec 2023 19:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ikQOY9tw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 341ED2107;
	Sun,  3 Dec 2023 11:34:04 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5d77a1163faso7155697b3.0;
        Sun, 03 Dec 2023 11:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701632042; x=1702236842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lLIpPFsand/i1xzhRvuWZWdTEGryuaeNcdCEZ2uAMCg=;
        b=ikQOY9twYk8DY0FzEdHM4506y+8fZlMZyC1Ldaqqq+OsuSQAmVYtUEoNxWmX2UXLHo
         iipYoEzTvjMmaeHKonchgcfqdvdDcODXjou//SrvCiqS4Vmk6xjPXycUOmPX60H9laJH
         yRGs/qcycmPdHvHmVSeUPFyW8Dtrl5jHuOXa28xcNR5S9NtDx070z75wX4nqcNA6kVLP
         X1WzRUFvB8OKkO6UvFM13L11I/6cFHMadx6XnCVEL1je1PzEs2+UxT7qYEP42Ii+HLTD
         f7MP6YLlLM5y6d0GfqqmB49uEV/54aX02fXlUM4rvc2q4Q0PchPWF1xzXNJeu3O1L5K7
         ooLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701632042; x=1702236842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lLIpPFsand/i1xzhRvuWZWdTEGryuaeNcdCEZ2uAMCg=;
        b=Ei5Huy7+YVSf5u8ZuegITtmd7xSctsmYSKCUftgR0WS9jZRFzRsopnLjBEo1hPTNli
         zheWjAJx6j6S10C8bp0W6+zI3YSyJEMSo8IYYV66hdH45lg0abRZszt3U9k/B8IrbSUs
         ZsLY6yDU1xoeV7C53jd0lBYYpuZXFWp873Ae1LCmUgnE0FGh5AQ4GpKDFsHrLxjXvud4
         +rm2WyNAtgTIDZa21mavUih9p2fGJWgJXhR/wwPIrNtVoPGIxQFBOxbqNlEOd0GNv72A
         9fgGNtKpYFyyD9n/UpA/+L15x7XvOLNBVQyARq2/GPiVyHX7bpmr7Ga6Az1sGNKw0imP
         NWyQ==
X-Gm-Message-State: AOJu0YwP8kzIy48FyeBQumiNDqe3jM6gEFSjQfXaU5m7wsL50BpWDRvJ
	S0ON3FxW3Dr+/1RMpQY7NTmVNU2opZiZdQ==
X-Google-Smtp-Source: AGHT+IF7TlbMvqX4zBK0qN69lty4JT5J+hOZOMnrAIhG2aaSguNl8zsIA2Kc3TBbQ2Xbvw2rXB+lGQ==
X-Received: by 2002:a81:4320:0:b0:5d6:d420:cb29 with SMTP id q32-20020a814320000000b005d6d420cb29mr1604031ywa.14.1701632042389;
        Sun, 03 Dec 2023 11:34:02 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:cb98:c3e:57c:8191])
        by smtp.gmail.com with ESMTPSA id c68-20020a0dc147000000b005d6f34893dfsm1612853ywd.135.2023.12.03.11.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 11:34:02 -0800 (PST)
From: Yury Norov <yury.norov@gmail.com>
To: linux-kernel@vger.kernel.org,
	Karsten Keil <isdn@linux-pingi.de>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Yury Norov <yury.norov@gmail.com>,
	netdev@vger.kernel.org,
	linux-bluetooth@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>,
	Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
	Matthew Wilcox <willy@infradead.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
	Alexey Klimov <klimov.linux@gmail.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH v2 30/35] bluetooth: optimize cmtp_alloc_block_id()
Date: Sun,  3 Dec 2023 11:33:02 -0800
Message-Id: <20231203193307.542794-29-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231203193307.542794-1-yury.norov@gmail.com>
References: <20231203192422.539300-1-yury.norov@gmail.com>
 <20231203193307.542794-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of polling every bit in blockids, switch it to using a
dedicated find_and_set_bit(), and make the function a simple one-liner.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 net/bluetooth/cmtp/core.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/net/bluetooth/cmtp/core.c b/net/bluetooth/cmtp/core.c
index 90d130588a3e..b1330acbbff3 100644
--- a/net/bluetooth/cmtp/core.c
+++ b/net/bluetooth/cmtp/core.c
@@ -88,15 +88,9 @@ static void __cmtp_copy_session(struct cmtp_session *session, struct cmtp_connin
 
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
2.40.1


