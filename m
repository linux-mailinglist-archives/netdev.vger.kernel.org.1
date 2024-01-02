Return-Path: <netdev+bounces-61016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A14AF8222D1
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 22:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4262FB20E76
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 21:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C865716421;
	Tue,  2 Jan 2024 21:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yukWixft"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7730C168D0
	for <netdev@vger.kernel.org>; Tue,  2 Jan 2024 21:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dbe868fdc33so1567303276.0
        for <netdev@vger.kernel.org>; Tue, 02 Jan 2024 13:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704229202; x=1704834002; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ec50JyuVMq7UkJG1GcqjOw+1KiCHQWv6ykAZlZLXjLE=;
        b=yukWixft/gkFujUNF0xmBp23Th7d4rlqFaWCkVP8nBPNm1Md/GHTkIWieRI/7752f3
         KtT31mGgq27D7TPIRK4h3ZpY6UZD91uoOUAzaAKMr8b26IclephxMGo7B9pC3lFpYofO
         jfzENcP2K9zkFB73+6eBhsnmsXOcv0xX4BqJ1G1qzUspbD5i7jOSL5Kr2qy/rGaKeG6x
         PpV1UHKJS3yIQY6VHwiiO+3R61E+nD1+xdXX5cjfUL+zc4Hv7XQbS+Qc7PkDQhVfZthr
         PA/4YXL+kjyIcoFZ1Cftx51p92naNoKHKyoh1peHTH5SxIaTc8416f0Pkyr0QyShromI
         SkKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704229202; x=1704834002;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ec50JyuVMq7UkJG1GcqjOw+1KiCHQWv6ykAZlZLXjLE=;
        b=q222MUjbK0An/tWfk+xQTprtBUpI6/qFfL8KMes94DZv9aUvqihSB4Pn4Z6/d7qRC9
         VduZ6cXZ1bLGnsRj3tQnpRt5/HcO7ah5Fh9tSKO4jCQJTrf54kADhFFP2i6cjf6BSNZV
         vbxthYRI2rSLSZgF+v3dtZ5BATsAhN3aidffmXWjptVz5XGxm6CmzotYwwTt7x6zD+xs
         CbHawcHOrfre+hr/HFhCQPIdENKOi5BMHX29Iw48Zq/An16zUugRU6kXoL2phbG0fsRe
         Aoyw3sqgFe1vWCVMKbut3xmySTpED/Urgfvl6TyF49Oz/FnLzpD6F19IT3VKGSXzGxAI
         ivNQ==
X-Gm-Message-State: AOJu0YyMc2jxuCLhhZBipNn7pPYOs6ZLf/Rdm4vrMF5eSd8AHCbowiXj
	/4j0d0PTnDMFcGWSBJLsQt8g3nfiong7QXtVXeRyVNiuFvtgb2GKgLqpCwmhNCPXgEAggjChIbk
	jaU/jjhQkAx4jyV/gCmrExsxyR/QRxeq+hfzAVlXwQ7SEztxYT37TEnciRexHetYWZDNYJCcnC8
	5QPln/lw==
X-Google-Smtp-Source: AGHT+IHBlhrofrQJisx1jxu8EwoQTqKIT5C+y3q1aZb6bA92wFYfdZR+lW7AK2SK//4wwJbMdrPl4u+9rD2ENwZkyg==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:9a04:c262:c978:d762])
 (user=almasrymina job=sendgmr) by 2002:a05:6902:1369:b0:db5:4692:3ab7 with
 SMTP id bt9-20020a056902136900b00db546923ab7mr7174078ybb.8.1704229202435;
 Tue, 02 Jan 2024 13:00:02 -0800 (PST)
Date: Tue,  2 Jan 2024 12:59:58 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20240102205959.794513-1-almasrymina@google.com>
Subject: [PATCH net-next v3] net: kcm: fix direct access to bv_len
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Minor fix for kcm: code wanting to access the fields inside an skb
frag should use the skb_frag_*() helpers, instead of accessing the
fields directly.

Signed-off-by: Mina Almasry <almasrymina@google.com>

---
 net/kcm/kcmsock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/kcm/kcmsock.c b/net/kcm/kcmsock.c
index 65d1f6755f98..1184d40167b8 100644
--- a/net/kcm/kcmsock.c
+++ b/net/kcm/kcmsock.c
@@ -634,7 +634,7 @@ static int kcm_write_msgs(struct kcm_sock *kcm)
 
 		msize = 0;
 		for (i = 0; i < skb_shinfo(skb)->nr_frags; i++)
-			msize += skb_shinfo(skb)->frags[i].bv_len;
+			msize += skb_frag_size(&skb_shinfo(skb)->frags[i]);
 
 		iov_iter_bvec(&msg.msg_iter, ITER_SOURCE,
 			      skb_shinfo(skb)->frags, skb_shinfo(skb)->nr_frags,
-- 
2.43.0.472.g3155946c3a-goog


