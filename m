Return-Path: <netdev+bounces-229969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D7260BE2BA0
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 12:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 359B3503A8F
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 10:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CCDF27A461;
	Thu, 16 Oct 2025 10:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zetn1/Qv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ASGcX4mx";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zetn1/Qv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ASGcX4mx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FD52D061B
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 10:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760609769; cv=none; b=T/w1Q1FUP6Es5yZAM0b88/Kai2E6x/T0BLh95cGSFo+MiL1w4NgYSUWOz1oWHH26Qx8cM2frzbhnCrnxuc4+cmUqZUAWAnP/QNgTAiD5AdIBDyE1iHGD9CxjkVW3rtha5+d3KCfH4ZGd1ZrGuePqiArZ3gLnJYzqSqCgMcwv/3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760609769; c=relaxed/simple;
	bh=TZamH4bOnQ54pzht4K/rRs4eGIdE04QjzGKBWpVNsvM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jD3Wi4UG0zSFsdvlggw4JcpUEwAfeFGHLiLNK3/rsfz9ApGK9QYUsfLoOFV33n3ZhcQz8CPkeJ5cL4MI/QGLXmn+fC+Q0CQmN/MSihDLI/S6Ug0Xsg8D8u+Me6KkoT//Jvt7h6XnCLZPHHHrMzF3ky5vjeA92TBflZ2H01FqNfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zetn1/Qv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ASGcX4mx; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zetn1/Qv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ASGcX4mx; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 29B0D1F399;
	Thu, 16 Oct 2025 10:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760609766; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=uxrIU0TzjlP7S5ryJQV1KkSdUjIrVkLiLjT2How3fyc=;
	b=zetn1/Qv4gAbw7FUurun1NGsgMhfEmqJhWcoVXLoagNg4lR8vCGSuOc0XzwDaUUT90axw9
	hmGHM5GKcSbRRrYamtXvyvhDp1iHfN8e+qEAq4qYGI9+UTQZloP+TPcqMN/DypjT/c4QKJ
	FsObyfrlXzLEkLi99GtMFV0zvrFgYjA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760609766;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=uxrIU0TzjlP7S5ryJQV1KkSdUjIrVkLiLjT2How3fyc=;
	b=ASGcX4mx0MSIlMSArC1T6+1YB/Uk/RLigYR5lQ8N8+tM5LgLaODIcp28mvFOqGre2U0gLK
	B2dlmzMYKCqDp/BA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760609766; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=uxrIU0TzjlP7S5ryJQV1KkSdUjIrVkLiLjT2How3fyc=;
	b=zetn1/Qv4gAbw7FUurun1NGsgMhfEmqJhWcoVXLoagNg4lR8vCGSuOc0XzwDaUUT90axw9
	hmGHM5GKcSbRRrYamtXvyvhDp1iHfN8e+qEAq4qYGI9+UTQZloP+TPcqMN/DypjT/c4QKJ
	FsObyfrlXzLEkLi99GtMFV0zvrFgYjA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760609766;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=uxrIU0TzjlP7S5ryJQV1KkSdUjIrVkLiLjT2How3fyc=;
	b=ASGcX4mx0MSIlMSArC1T6+1YB/Uk/RLigYR5lQ8N8+tM5LgLaODIcp28mvFOqGre2U0gLK
	B2dlmzMYKCqDp/BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 690681376E;
	Thu, 16 Oct 2025 10:16:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /o1TFuXF8GjmAgAAD6G6ig
	(envelope-from <fmancera@suse.de>); Thu, 16 Oct 2025 10:16:05 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	kuba@kernel.org
Cc: cynthia@kosmx.dev,
	rafael@kernel.org,
	dakr@kernel.org,
	christian.brauner@ubuntu.com,
	edumazet@google.com,
	pabeni@redhat.com,
	davem@davemloft.net,
	horms@kernel.org,
	Fernando Fernandez Mancera <fmancera@suse.de>
Subject: [PATCH] sysfs: check visibility before changing group attribute ownership
Date: Thu, 16 Oct 2025 12:14:56 +0200
Message-ID: <20251016101456.4087-1-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_TWELVE(0.00)[13];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

Since commit 0c17270f9b92 ("net: sysfs: Implement is_visible for
phys_(port_id, port_name, switch_id)"), __dev_change_net_namespace() can
hit WARN_ON() when trying to change owner of a file that isn't visible.
See the trace below:

 WARNING: CPU: 6 PID: 2938 at net/core/dev.c:12410 __dev_change_net_namespace+0xb89/0xc30
 CPU: 6 UID: 0 PID: 2938 Comm: incusd Not tainted 6.17.1-1-mainline #1 PREEMPT(full)  4b783b4a638669fb644857f484487d17cb45ed1f
 Hardware name: Framework Laptop 13 (AMD Ryzen 7040Series)/FRANMDCP07, BIOS 03.07 02/19/2025
 RIP: 0010:__dev_change_net_namespace+0xb89/0xc30
 [...]
 Call Trace:
  <TASK>
  ? if6_seq_show+0x30/0x50
  do_setlink.isra.0+0xc7/0x1270
  ? __nla_validate_parse+0x5c/0xcc0
  ? security_capable+0x94/0x1a0
  rtnl_newlink+0x858/0xc20
  ? update_curr+0x8e/0x1c0
  ? update_entity_lag+0x71/0x80
  ? sched_balance_newidle+0x358/0x450
  ? psi_task_switch+0x113/0x2a0
  ? __pfx_rtnl_newlink+0x10/0x10
  rtnetlink_rcv_msg+0x346/0x3e0
  ? sched_clock+0x10/0x30
  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
  netlink_rcv_skb+0x59/0x110
  netlink_unicast+0x285/0x3c0
  ? __alloc_skb+0xdb/0x1a0
  netlink_sendmsg+0x20d/0x430
  ____sys_sendmsg+0x39f/0x3d0
  ? import_iovec+0x2f/0x40
  ___sys_sendmsg+0x99/0xe0
  __sys_sendmsg+0x8a/0xf0
  do_syscall_64+0x81/0x970
  ? __sys_bind+0xe3/0x110
  ? syscall_exit_work+0x143/0x1b0
  ? do_syscall_64+0x244/0x970
  ? sock_alloc_file+0x63/0xc0
  ? syscall_exit_work+0x143/0x1b0
  ? do_syscall_64+0x244/0x970
  ? alloc_fd+0x12e/0x190
  ? put_unused_fd+0x2a/0x70
  ? do_sys_openat2+0xa2/0xe0
  ? syscall_exit_work+0x143/0x1b0
  ? do_syscall_64+0x244/0x970
  ? exc_page_fault+0x7e/0x1a0
  entry_SYSCALL_64_after_hwframe+0x76/0x7e
 [...]
  </TASK>

Fix this by checking is_visible() before trying to touch the attribute.

Fixes: 303a42769c4c ("sysfs: add sysfs_group{s}_change_owner()")
Reported-by: Cynthia <cynthia@kosmx.dev>
Closes: https://lore.kernel.org/netdev/01070199e22de7f8-28f711ab-d3f1-46d9-b9a0-048ab05eb09b-000000@eu-central-1.amazonses.com/
Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
 fs/sysfs/group.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/fs/sysfs/group.c b/fs/sysfs/group.c
index 2d78e94072a0..e142bac4f9f8 100644
--- a/fs/sysfs/group.c
+++ b/fs/sysfs/group.c
@@ -498,17 +498,26 @@ int compat_only_sysfs_link_entry_to_kobj(struct kobject *kobj,
 }
 EXPORT_SYMBOL_GPL(compat_only_sysfs_link_entry_to_kobj);
 
-static int sysfs_group_attrs_change_owner(struct kernfs_node *grp_kn,
+static int sysfs_group_attrs_change_owner(struct kobject *kobj,
+					  struct kernfs_node *grp_kn,
 					  const struct attribute_group *grp,
 					  struct iattr *newattrs)
 {
 	struct kernfs_node *kn;
-	int error;
+	int error, i;
+	umode_t mode;
 
 	if (grp->attrs) {
 		struct attribute *const *attr;
 
-		for (attr = grp->attrs; *attr; attr++) {
+		for (i = 0, attr = grp->attrs; *attr; i++, attr++) {
+			if (grp->is_visible) {
+				mode = grp->is_visible(kobj, *attr, i);
+				if (mode & SYSFS_GROUP_INVISIBLE)
+					break;
+				if (!mode)
+					continue;
+			}
 			kn = kernfs_find_and_get(grp_kn, (*attr)->name);
 			if (!kn)
 				return -ENOENT;
@@ -523,7 +532,14 @@ static int sysfs_group_attrs_change_owner(struct kernfs_node *grp_kn,
 	if (grp->bin_attrs) {
 		const struct bin_attribute *const *bin_attr;
 
-		for (bin_attr = grp->bin_attrs; *bin_attr; bin_attr++) {
+		for (i = 0, bin_attr = grp->bin_attrs; *bin_attr; i++, bin_attr++) {
+			if (grp->is_bin_visible) {
+				mode = grp->is_bin_visible(kobj, *bin_attr, i);
+				if (mode & SYSFS_GROUP_INVISIBLE)
+					break;
+				if (!mode)
+					continue;
+			}
 			kn = kernfs_find_and_get(grp_kn, (*bin_attr)->attr.name);
 			if (!kn)
 				return -ENOENT;
@@ -573,7 +589,7 @@ int sysfs_group_change_owner(struct kobject *kobj,
 
 	error = kernfs_setattr(grp_kn, &newattrs);
 	if (!error)
-		error = sysfs_group_attrs_change_owner(grp_kn, grp, &newattrs);
+		error = sysfs_group_attrs_change_owner(kobj, grp_kn, grp, &newattrs);
 
 	kernfs_put(grp_kn);
 
-- 
2.51.0


