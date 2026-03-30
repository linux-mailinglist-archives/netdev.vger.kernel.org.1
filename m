Return-Path: <netdev+bounces-273107-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eMgnJIBJymkQ7QUAu9opvQ
	(envelope-from <netdev+bounces-273107-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 11:59:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F2C358BBA
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 11:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7FA7A300E60F
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 09:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AECE838838D;
	Mon, 30 Mar 2026 09:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AWaU5ozS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CE73B5852
	for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 09:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774864459; cv=none; b=owKuReSrjkDjsSjSd+wlvd5TFt9iofoomim7HBIigPmMIktqVO0B67VTKJERe7jpf4KKn3SynOaJDwARW8AEdeCAoOIsNkWvUXhuOjDdAvR1XWM/AOZlijF+l74frjpZnwaSSyw7QH0pPeV1npRU4xFbiFVdtbvIUNiDXXy+H7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774864459; c=relaxed/simple;
	bh=lzvGmzRrIIZY/AbGI0dmcSlJ5nsg8dSnwM1BR/NWcts=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tCS2SXjIsl+fhJCugbFPvifyvgc4GrXN918A5JlWgW9R+20YZzbyr1pTUWHyzSNnuqukoJ1/HsyBL/WBDCGvaHlRDG1lpum8m13bvycH+jTxQr2IKye1DWjQ5+u3X5rXMOXkBbNcJfzCLzZxyu7xKXtIBlwaq7sPX3kiutN4AWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AWaU5ozS; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43cf5ad500fso1379337f8f.0
        for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 02:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1774864455; x=1775469255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J8UtOL9VcBGypFwilfKxX/vYGnfnSJYDS2k1Ifp5VRU=;
        b=AWaU5ozSFT0EZWRJNJNv2UE9K19oC48Sw5kD0LVuaNv7iBgeb2P56ilk1Jmpkm26J3
         9JrWgI8FyXeChusQ6muVjPvm2U0zSJ+zPv3wtibCMyetEcjGzEC5yFPuOG08IZgUYznV
         xefvfJCYRzWJ7ot7pHwFO55QTNeC8I9ikBpLJ3vICWZz402bTt4eqHel14VteVRaF9Am
         WQUHcSR4tQ5MEw6vHh4pnGB+pV5Gs0w4kjJKJA2Y/KodqMDkGnID9TVZ5h4bUFN7UHTA
         BXkCNe2E33tQtb4gxVKMYJfPHi7Te8zshKLNs0nVWasymEEuZ3/pv3GMrCI8gnc76992
         GPmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774864455; x=1775469255;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J8UtOL9VcBGypFwilfKxX/vYGnfnSJYDS2k1Ifp5VRU=;
        b=sLST3bgFI/Ub/TnS63Q0F03IOWGtYc9a+Rgl7YISFWT6dqFWiMVzi0hBIH3OUxYn96
         AFcaI7Rn7cOtA74xUmQihSGRoJnifTz1sRFIR8l29DXFpXVxzMxgkilP1AJPU62KXGSn
         OOZPFJaUNLKifty9SETCMMisj8Gu7QvdGUo3/GptEzqDSt4Vc5p5YKuIf4ZSfSKl3h8a
         xKVl7w5aJKtIkbAnxZ5gDP7dieNzzuR7VRq/HLJLd3LGG14OqM0V/WL5NV6X5Ig3J8+w
         gUjzbTIKFHVOzhpftwtLwXmKX4VsyTScDy4JYfiIuufEflZQOXJ975+YOkQklnvLvWEj
         szbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNe6ss8xSXlvGxLZXUktXdu1NTTq/DuTyKeKWMEbcQA7uKXmrURmGUIxUMQdknJnMEovjc7Nc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwWraIFIdS/QweTjjX3poJN2chZJo3tNcemBTuUOB2PSfurAq/
	Un6dY2wXU+R/X0Rtu8IYwSGbYmzWmFmO1ABKD2M7YxbOuoecf0nE3AsXVJUTZQWJQEc=
X-Gm-Gg: ATEYQzyjnOMXgMJ7sJFbuN5JGSjm+O6DGOdG8amuvQ70N8mQjufyaIoBW/ld6Rc5xBr
	wJGdpLFhBPurIHBKC6RCWy98EhkaKaEYfm2B3qPde8r4VUOxf3ap5GGs8vK9meWtZivHPvI0HEl
	29Y25J9dGE7aeotTGPryiSyYfAEGqJL+EF9u+3HcQkd3HfzpigU1RBHK1Ieeq0xf47rGhyBFoYG
	OCyvsvVAWm/jZnG3mS1sRH/PcF9Gq0mOKLVc8HWvjmEYj2auE93SfFGK6e+fIYmxi3u6Q/93DFQ
	owL42IHtsU4B6ZTVRQcVaXPxFwM//vVM4RotfCpw4ey4cqDquccWZ/hMUTF3+crikikRqlAD+ZG
	YNZo7ERNniZ3A1+nNMbKk99DhQHvy3ZQGXBdbBN5xrMX7T88fO8dclSrMjDocqGhegaSswcwe+E
	q9AQgHJUrMNXBHlPHAnkIWDWPsSA==
X-Received: by 2002:a5d:5f45:0:b0:439:b3c5:ea1f with SMTP id ffacd0b85a97d-43b9e997916mr19351985f8f.16.1774864455006;
        Mon, 30 Mar 2026 02:54:15 -0700 (PDT)
Received: from linux ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf330872asm16011452f8f.17.2026.03.30.02.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 02:54:14 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Sunil Goutham <sgoutham@marvell.com>,
	Linu Cherian <lcherian@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Jerin Jacob <jerinj@marvell.com>,
	hariprasad <hkelam@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next] Octeontx2-af: add WQ_PERCPU to alloc_workqueue users
Date: Mon, 30 Mar 2026 11:54:05 +0200
Message-ID: <20260330095405.116990-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linutronix.de,suse.com,marvell.com,lunn.ch,davemloft.net,google.com,redhat.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-273107-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marco.crivellari@suse.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email,suse.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 06F2C358BBA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This continues the effort to refactor workqueue APIs, which began with
the introduction of new workqueues and a new alloc_workqueue flag in:

   commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
   commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

The refactoring is going to alter the default behavior of
alloc_workqueue() to be unbound by default.

With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
any alloc_workqueue() caller that doesn’t explicitly specify WQ_UNBOUND
must now use WQ_PERCPU. For more details see the Link tag below.

In order to keep alloc_workqueue() behavior identical, explicitly request
WQ_PERCPU.

Link: https://lore.kernel.org/all/20250221112003.1dSuoGyc@linutronix.de/
Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
index 5b1129558e8b..1a1a863199ee 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
@@ -2576,7 +2576,7 @@ static int rvu_mbox_init(struct rvu *rvu, struct mbox_wq_info *mw,
 	}
 
 	mw->mbox_wq = alloc_workqueue("%s",
-				      WQ_HIGHPRI | WQ_MEM_RECLAIM,
+				      WQ_HIGHPRI | WQ_MEM_RECLAIM | WQ_PERCPU,
 				      num, name);
 	if (!mw->mbox_wq) {
 		err = -ENOMEM;
-- 
2.53.0


