Return-Path: <netdev+bounces-39336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F5F7BED87
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 23:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 062601C20B18
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 21:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B1A42C03;
	Mon,  9 Oct 2023 21:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DbzY3biD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA11D42BF5;
	Mon,  9 Oct 2023 21:46:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 416FBC433C8;
	Mon,  9 Oct 2023 21:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696887983;
	bh=hOV1TPaxRK6lKBeU8FkupnPDNPfBklnFK2iqPujS67E=;
	h=Date:From:To:Cc:Subject:From;
	b=DbzY3biDgO4mfCIA4qPzupLl+uX9GQuhb11X3aVuywb+Bl5IiANsNQ87Dq6LSmK2G
	 N+NCZxZ6Io0Elk4NgT8Tu4MX/Wbc/Zlyh+3yaAk2picUd7NwkzG2epTTBf92SeO7Zn
	 H+iQ5RERpBZ9vTb3eOW5ELre2i0mPtM7mA2AkKXShWbogN5G9ftpllRSnRVZDjiX+u
	 Z6gHzuzsir9EofnMs4F0iGxxpYt+rRTCLF4k2fA0rHNG8r99DhPaFICqWsqKebAfxR
	 EltoEEpdN8DY7vzaPZL+x8Im429T6LSYjnYmhGiioMo6fjMsYsbjcQft4CvhkJ7dap
	 wytsDX0E0V9tg==
Date: Mon, 9 Oct 2023 15:46:18 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>,
	Intel Corporation <linuxwwan@intel.com>,
	Chiranjeevi Rapolu <chiranjeevi.rapolu@linux.intel.com>,
	Liu Haijun <haijun.liu@mediatek.com>,
	M Chetan Kumar <m.chetan.kumar@linux.intel.com>,
	Ricardo Martinez <ricardo.martinez@linux.intel.com>,
	Loic Poulain <loic.poulain@linaro.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] net: wwan: t7xx: Add __counted_by for struct
 t7xx_fsm_event and use struct_size()
Message-ID: <ZSR0qh5dEV5qoBW4@work>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

While there, use struct_size() helper, instead of the open-coded
version, to calculate the size for the allocation of the whole
flexible structure, including of course, the flexible-array member.

This code was found with the help of Coccinelle, and audited and
fixed manually.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/net/wwan/t7xx/t7xx_state_monitor.c | 3 ++-
 drivers/net/wwan/t7xx/t7xx_state_monitor.h | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wwan/t7xx/t7xx_state_monitor.c b/drivers/net/wwan/t7xx/t7xx_state_monitor.c
index 80edb8e75a6a..0bc97430211b 100644
--- a/drivers/net/wwan/t7xx/t7xx_state_monitor.c
+++ b/drivers/net/wwan/t7xx/t7xx_state_monitor.c
@@ -445,7 +445,8 @@ int t7xx_fsm_append_event(struct t7xx_fsm_ctl *ctl, enum t7xx_fsm_event_state ev
 		return -EINVAL;
 	}
 
-	event = kmalloc(sizeof(*event) + length, in_interrupt() ? GFP_ATOMIC : GFP_KERNEL);
+	event = kmalloc(struct_size(event, data, length),
+			in_interrupt() ? GFP_ATOMIC : GFP_KERNEL);
 	if (!event)
 		return -ENOMEM;
 
diff --git a/drivers/net/wwan/t7xx/t7xx_state_monitor.h b/drivers/net/wwan/t7xx/t7xx_state_monitor.h
index b6e76f3903c8..b0b3662ae6d7 100644
--- a/drivers/net/wwan/t7xx/t7xx_state_monitor.h
+++ b/drivers/net/wwan/t7xx/t7xx_state_monitor.h
@@ -102,7 +102,7 @@ struct t7xx_fsm_event {
 	struct list_head	entry;
 	enum t7xx_fsm_event_state event_id;
 	unsigned int		length;
-	unsigned char		data[];
+	unsigned char		data[] __counted_by(length);
 };
 
 struct t7xx_fsm_command {
-- 
2.34.1


