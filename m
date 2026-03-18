Return-Path: <netdev+bounces-268872-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +LWYCUQfuml8RwIAu9opvQ
	(envelope-from <netdev+bounces-268872-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 04:43:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9CBC2B58F0
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 04:42:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E895304E30E
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 03:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3A9334C3B;
	Wed, 18 Mar 2026 03:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="S099G4Q9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC4925C80E
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 03:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773805371; cv=none; b=iyJEmuaTAz0WNjy0dpYtSbHeBVphEwAaUWvrNcxubQMw6Ny/9lSkHxVN+suyXcLF3YvTkFpPisUi7R0Q5SZAdpEDUy11xCF8m1N3HhGLbNXGyZo/wxz/D/7l3SljAgieMdZdk+yARUZlXwUx++GvrpMW4h9uG4OVU/pfen9254M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773805371; c=relaxed/simple;
	bh=xOOE7va9TffbAWN85eqBLYmwrHyH1fj7Va+S6RRhA64=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MqaihTVBrACzZ0fyc62hIeYRYd7BIrDmvnu7fbli5JCMQ/F+ur10GI8b4JakRoQNDePXKSmjfKtZ60Zf+NnXypBasFmpEcilOWttk9bYp+V7QLmg4/14BXkfE1XldtXXVGnmZmTmbA8sIwvcxqKLRm3fvPCro4roHs7y8KZHR4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=S099G4Q9; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2c0cf039a45so4080580eec.0
        for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 20:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1773805368; x=1774410168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hMND4iZBCjF3ZpZm5tJpOZ8N3/z6tWKz9s4tH24eRNc=;
        b=S099G4Q9qij/pcbO8AH4NXa6QZHgTXlmA2wzvfI4zdiIQLZqNvIuBXOpQqu8PChutz
         8/SzIezdc/Wj4s59C6ljcuPmvGCQG92EkzdmHaumvQA6l5YzYmW74z3AhJCGhyuzqMof
         KATjD60HKJrwbsn6JTbf1lIERQJftcwgctzCBUTI3OGFAD4Kvo8+aogZc8kDOx168dYb
         3CeqSpVhr6SBTLHIqZKlhQtMms0T3X6PNXWF+9i8gnfkVm4gV980Zvd0oXll/hZR7ZjJ
         /eDQOvKjcEPSZEg8dOPOse9z2WjHX6SpDcFgB9y6OSlxku3QsIlVibCPPZSHfhxXggLn
         BxZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773805368; x=1774410168;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hMND4iZBCjF3ZpZm5tJpOZ8N3/z6tWKz9s4tH24eRNc=;
        b=fe6RbFY032s1GGLzzwg/KKzekVubPn26HyrfeUZUWn0vyLtd1SRSdUl+ayNwW2Yqtc
         BFnPerU4ZX7bOw2YDUXv83DXHpf8GMcAAj6bcZF1R1daxLSnRRbWrHn196isBelqv4b+
         x+rVC7VTmnKasLkzIS6z2Cg6oUQ63Yeeluln1zG/xixXaZ9EeKlOcXEwESHGWorHqpAx
         qrs8iWk3jCTmjovwjQnKq3dX0LnufWYHCQ2OU04v4U7+FzUGCvi8+xEgLKz+15BsnBEk
         AE13348/HTFdf6jfcO0HRyB3GL99M3L01KgxmLj/tsOm4H1T1pKnyGRFMSxURdp+azCT
         U02w==
X-Gm-Message-State: AOJu0YzALyDh8o+6di9CO3kpTPqquvkfYm/ZZuznxuZUAcU20LFTS3uA
	72hjLlQKb+fzLvqkTq9P8a9sxedpC+HSYD7DJb1eAgrSU/g84LjlfibDUUcjrENpxQ==
X-Gm-Gg: ATEYQzww4m8pwT3sCrdM6xrA7SVI7BTOMrjXJoS97yL+NCN7SYFoerGcZWWUumw3E/V
	+xPxteYfUBvAEta2oL1uYPrIg+IhH80SctyTzxRj2BzxIbIqaYTduHjSOy4sGfcfdHK8WB9ZWJY
	pLsyIfnzVr91WCc8pBxj+6EqEp9E9r+d/6XBVXprwzAvPYA/jR2reM8WTD/JZiNwq90Id2csVue
	vNy3uxhCr3eol+JihAEaHe8z4gsrAdA2+lBn5yHVS6G3VYJNum4GN/hzWLY+2Bcy5ejCSEC/gJl
	SnlxlUYQAQ6rCSXh8Ja2hVXG3Ddwlx659KqCYdJI1J1F5v9vDi1hnzaN189XAbMtit8OPE+5/po
	ppLFAx2yL49d8s6OQRYupV3W6BLaD9W2LRVKoKJlBSFLDsq1R3G0psiWq9bgb3L5rIcPbldfPoz
	5ze/+P9luLhDLQnfRztWJC9FHQyD1U4z4JfQM/YPZW1PYfWZ6vtAKdrg==
X-Received: by 2002:a05:7300:a2ca:b0:2ba:a2fa:84a6 with SMTP id 5a478bee46e88-2c0e5101a34mr956014eec.24.1773805367538;
        Tue, 17 Mar 2026 20:42:47 -0700 (PDT)
Received: from p1.scai.dhcp.asu.edu (209-147-138-15.nat.asu.edu. [209.147.138.15])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c0e55a2be4sm2578693eec.22.2026.03.17.20.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 20:42:47 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: security@kernel.org
Cc: netdev@vger.kernel.org,
	johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org,
	bestswngs@gmail.com,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH net] wifi: mac80211: fix NULL deref in mesh_matches_local()
Date: Tue, 17 Mar 2026 20:42:44 -0700
Message-ID: <20260318034244.2595020-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,sipsolutions.net,gmail.com,asu.edu];
	TAGGED_FROM(0.00)[bounces-268872-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[asu.edu:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,asu.edu:dkim,asu.edu:email,asu.edu:mid]
X-Rspamd-Queue-Id: B9CBC2B58F0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

mesh_matches_local() unconditionally dereferences ie->mesh_config to
compare mesh configuration parameters. When called from
mesh_rx_csa_frame(), the parsed action-frame elements may not contain a
Mesh Configuration IE, leaving ie->mesh_config NULL and triggering a
kernel NULL pointer dereference.

The other two callers are already safe:
  - ieee80211_mesh_rx_bcn_presp() checks !elems->mesh_config before
    calling mesh_matches_local()
  - mesh_plink_get_event() is only reached through
    mesh_process_plink_frame(), which checks !elems->mesh_config, too

mesh_rx_csa_frame() is the only caller that passes raw parsed elements
to mesh_matches_local() without guarding mesh_config. An adjacent
attacker can exploit this by sending a crafted CSA action frame that
includes a valid Mesh ID IE but omits the Mesh Configuration IE,
crashing the kernel.

The captured crash log:

Oops: general protection fault, probably for non-canonical address ...
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
Workqueue: events_unbound cfg80211_wiphy_work
[...]
Call Trace:
 <TASK>
 ? __pfx_mesh_matches_local (net/mac80211/mesh.c:65)
 ieee80211_mesh_rx_queued_mgmt (net/mac80211/mesh.c:1686)
 [...]
 ieee80211_iface_work (net/mac80211/iface.c:1754 net/mac80211/iface.c:1802)
 [...]
 cfg80211_wiphy_work (net/wireless/core.c:426)
 process_one_work (net/kernel/workqueue.c:3280)
 ? assign_work (net/kernel/workqueue.c:1219)
 worker_thread (net/kernel/workqueue.c:3352)
 ? __pfx_worker_thread (net/kernel/workqueue.c:3385)
 kthread (net/kernel/kthread.c:436)
 [...]
 ret_from_fork_asm (net/arch/x86/entry/entry_64.S:255)
 </TASK>

This patch adds a NULL check for ie->mesh_config at the top of
mesh_matches_local() to return false early when the Mesh Configuration
IE is absent.

Fixes: 2e3c8736820b ("mac80211: support functions for mesh")
Reported-by: Weiming Shi <bestswngs@gmail.com>
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
 net/mac80211/mesh.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mac80211/mesh.c b/net/mac80211/mesh.c
index 28624e57aa499..8fdbdf9ba2a9e 100644
--- a/net/mac80211/mesh.c
+++ b/net/mac80211/mesh.c
@@ -79,6 +79,9 @@ bool mesh_matches_local(struct ieee80211_sub_if_data *sdata,
 	 *   - MDA enabled
 	 * - Power management control on fc
 	 */
+	if (!ie->mesh_config)
+		return false;
+
 	if (!(ifmsh->mesh_id_len == ie->mesh_id_len &&
 	     memcmp(ifmsh->mesh_id, ie->mesh_id, ie->mesh_id_len) == 0 &&
 	     (ifmsh->mesh_pp_id == ie->mesh_config->meshconf_psel) &&
-- 
2.43.0


