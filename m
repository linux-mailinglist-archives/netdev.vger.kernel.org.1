Return-Path: <netdev+bounces-297185-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YQGVH/1KKGrcBgMAu9opvQ
	(envelope-from <netdev+bounces-297185-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 19:18:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E961A662D94
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 19:18:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=L+5mIp4v;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297185-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297185-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6C7BB3014C59
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 17:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE414BCAC0;
	Tue,  9 Jun 2026 17:15:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE344BCABC
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 17:15:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781025349; cv=none; b=E0N6IxPbH14wO/rkC3D4i5HTAfMySfx4kTh2/OGOt1FMgvni/xbVQNvmnGZTYivACFr03x1/21PO02Zh7tG0Jh/tovRWTj2rtmRG1rIQGpMPjuQlsmT04AUyeu4zqfDveh5EXMCgfrWSjLbCY9SCHzvVQA/BxlzLWreq1mrq2jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781025349; c=relaxed/simple;
	bh=jqbcJhtgkoSzv8XIfg25Tyt5orxfJdO+IEM+q5Lyjt0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=LV9MUiqHjYRNk3epicTK2wd2ZLLGvLNjV8aXSElkXANMPKX2ohIXT51LwFAm11jwleACKgrui6GLaZ68XGEqF9V7wl1TfWkkrEGsg4+z3Nj66okUOIPXafmmTxZpPVJcR9mkK6DILA1f5o1E6YKeXAvynkBRIDd8X/YDL5S4i80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L+5mIp4v; arc=none smtp.client-ip=74.125.224.49
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-6603d8697d2so5833273d50.0
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 10:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781025347; x=1781630147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=8srGYATRAAKxjXB42YooJP0rF3U7oIz6k+vGSKsxIIs=;
        b=L+5mIp4vKZPtio7jV9c4jnsLFvTrehGEeF4uyu9uhSkjMlMVj0laUFbXVgIMon5PJ+
         8eUdMiP88bu9GoReSUMdOB9bC8xY/1GyO+Fmen8dNdqLssMHoNqtDwcrygMUwymb3nFJ
         V1CthOz5fC+DhokHhzeBKeAA9sIhTneTNKpjuEO3IKBtfyF8fQRIG8tlatkWc7nfuIXn
         DqFGvj7WILYa2tS4ThudwhmYlDrNbbAf6GPNJNYVH5r0t7LARqQeVwtlsNQm8SE2B5M9
         rSOzHftHqm2wpCWp96CTEnOkWrBrWcNwZ3GwBD3sgBu4zSl/szXOgVcDS51kCYqVtsNK
         JTQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781025347; x=1781630147;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8srGYATRAAKxjXB42YooJP0rF3U7oIz6k+vGSKsxIIs=;
        b=pkkOwKExa+pK9NaXuTVhwP6nhhInN84t4fCZReqBHxGv4QBGauCfaxp4A2sJ8R/FGz
         D/aZ7i5eGErKX0kbjHbelZIjrFZwujCEy6uiwlfDTQteElvFyFYZn/KVprIMneLUY0wa
         GEJUO7khK56v4iGsHLW48VWxCWzvt4dMahGtqWCjtETIEGxa3a9AsKB7QglOkftAUHhP
         rEJsyRkVWX0BYtUmftiMTV/2g2Ev2eIYcYc0Mp66Sxg/5RP9eYiq5FvqAjc7p8WRSor9
         9yYWTVFoN7ksWC6WMFaSj0t8Z4Z1RelEUjjTYjeAORVbnkB0iVhI0UY6z+6s8fCc1Qmm
         +A2A==
X-Forwarded-Encrypted: i=1; AFNElJ9dzZ7NWCUoAt49KN8eudIJmLAzPlh6ktXVkIhazf85YdIUuvnCmLwNKUnHI3DqwBJjXwbypH8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3k5520ivrcp1iclS7kyO+yPTVGBDw6YOLpaZN9MLyFSAuPTbw
	dfz04zsBJOWi679JZh+y/RpToMRVLSHoN0GDx36yKXvmfWunTh44RVa8
X-Gm-Gg: Acq92OELYdtuUGhVoXgzeX3CxNJ5AxLKjM2NcmOhrXA3z9LFQbgf98gvi94o4ZsLED6
	JFsJQfNM3qK1qa73PG4xPUxUXvcRzPo8Kas90I+biBdGE4pb/HjaEJj1Cw0Jig6tvM9C1z83vnJ
	iA8GGzS/MTl6RDQsTXxzsIKAZaST4uBGVf9cw3RGYkK8s7rNRadWy3acfOcJadnZNSwENOx6Pur
	kdKPy8Wl6RFQsBnEBPf2eyhcJ5h0tHHot15Xygpewc2Zk3DJowh2bzsZxXa00O2pwhd6veiciGl
	BYARs49Fe5ZGU3hPUgHxJOdHivBaFwLABTgIAdbtsUIEOnvC5V268zhcXJbhDkeJ/R5xm6IZHRG
	TK5F5q6uEX4vSxXAdgBAbzU7BXJkwH92toQw+DEBj8Omtkdbvy/d5gjeVMMS/hpBXkgTX0cM6zg
	EMky7vL1CL5YpRzpnMk5mvz1rrEvewf4othC8qjNfP5dwaW7CtE0nZgxAtPkxlbt7zmA==
X-Received: by 2002:a05:690e:13ce:b0:650:35b1:b16c with SMTP id 956f58d0204a3-6614f5b110bmr3139698d50.8.1781025347112;
        Tue, 09 Jun 2026 10:15:47 -0700 (PDT)
Received: from localhost (c-73-104-62-181.hsd1.fl.comcast.net. [73.104.62.181])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-660d5f86e2csm11127434d50.5.2026.06.09.10.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 10:15:46 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
X-Google-Original-From: Yury Norov <ynorov@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Felix Maurer <fmaurer@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Kexin Sun <kexinsun@smail.nju.edu.cn>,
	Yury Norov <ynorov@nvidia.com>,
	Quan Sun <2022090917019@std.uestc.edu.cn>,
	Luka Gejak <luka.gejak@linux.dev>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: hsr: simplify fill_last_seq_nrs()
Date: Tue,  9 Jun 2026 13:15:44 -0400
Message-ID: <20260609171545.1051322-1-ynorov@nvidia.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:fmaurer@redhat.com,m:bigeasy@linutronix.de,m:kexinsun@smail.nju.edu.cn,m:ynorov@nvidia.com,m:2022090917019@std.uestc.edu.cn,m:luka.gejak@linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-297185-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[yurynorov@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yurynorov@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nvidia.com:mid,nvidia.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E961A662D94

The function checks the HSR_PT_SLAVE_A and HSR_PT_SLAVE_B bitmaps
for emptiness right before calling find_last_bit().

This pass may be avoided, because if the bitmap is empty, the
find_last_bit() returns >= HSR_SEQ_BLOCK_SIZE

Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 net/hsr/hsr_framereg.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/net/hsr/hsr_framereg.c b/net/hsr/hsr_framereg.c
index 124619920d38..bf143b86999b 100644
--- a/net/hsr/hsr_framereg.c
+++ b/net/hsr/hsr_framereg.c
@@ -827,18 +827,14 @@ static void fill_last_seq_nrs(struct hsr_node *node, u16 *if1_seq, u16 *if2_seq)
 	block_sz = hsr_seq_block_size(node);
 	block = node->block_buf + block_off * block_sz;
 
-	if (!bitmap_empty(block->seq_nrs[HSR_PT_SLAVE_B - 1],
-			  HSR_SEQ_BLOCK_SIZE)) {
-		seq_bit = find_last_bit(block->seq_nrs[HSR_PT_SLAVE_B - 1],
-					HSR_SEQ_BLOCK_SIZE);
+	seq_bit = find_last_bit(block->seq_nrs[HSR_PT_SLAVE_B - 1], HSR_SEQ_BLOCK_SIZE);
+	if (seq_bit < HSR_SEQ_BLOCK_SIZE)
 		*if1_seq = (block->block_idx << HSR_SEQ_BLOCK_SHIFT) | seq_bit;
-	}
-	if (!bitmap_empty(block->seq_nrs[HSR_PT_SLAVE_A - 1],
-			  HSR_SEQ_BLOCK_SIZE)) {
-		seq_bit = find_last_bit(block->seq_nrs[HSR_PT_SLAVE_A - 1],
-					HSR_SEQ_BLOCK_SIZE);
+
+	seq_bit = find_last_bit(block->seq_nrs[HSR_PT_SLAVE_A - 1], HSR_SEQ_BLOCK_SIZE);
+	if (seq_bit < HSR_SEQ_BLOCK_SIZE)
 		*if2_seq = (block->block_idx << HSR_SEQ_BLOCK_SHIFT) | seq_bit;
-	}
+
 	spin_unlock_bh(&node->seq_out_lock);
 }
 
-- 
2.53.0


