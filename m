Return-Path: <netdev+bounces-289156-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oOyWDiJcC2ppGAUAu9opvQ
	(envelope-from <netdev+bounces-289156-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 20:36:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF485725A5
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 20:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8762A30118CA
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 18:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3572E3397;
	Mon, 18 May 2026 18:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mz3q6FHk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660B434A76E
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 18:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779129305; cv=none; b=ZV6B3VtSTOO2tHmr9QiFUNVB0mq1PcgCEfywElSnuU3rtJOPISak74iH7EVYPE+RX07N1SqiXNcMpOxLyJlp+U5Uesrnp7zWT9WKiGPcxnC1J1hzRMZvPMfwCfLQ4QQ7b6m6VVsIo7SW9+G27DMkX5ExCWkNeOB1PPWQdY60tiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779129305; c=relaxed/simple;
	bh=LuRPaFKS8OgFMkLFrIeH1PJ5pkp7C5RsHRnqAViwGZU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H2nRz4ERmrg40/1PthDuU5ZbPflp+upwkRSJJWku/4tdiSWmptSez/LfJpLfEodvVH4AW9fxMZT+v3ZYGd0G9F/7CRaDzPI4DVPq4aRaCqFq2moiVLeaRa+r+axVdmUzVkXrWBsac9bn3OCzyDtpSVKic7aPKl9NOmxMWlpK1t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mz3q6FHk; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-50e5c7eb565so32992141cf.3
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 11:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779129303; x=1779734103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HefdEi5yJeys6v2Xvf3SK5unmpenCeIO1ZUw+aAUkeI=;
        b=mz3q6FHkhV0VIuGdMGfA1fLS36M+wV0pWJfFDSu1VTxkkoatTGh8wcvglwcjK9Qy1j
         buBZqnbXndE7qkM39RmqfoNAQ4tTIweTXxO6v1PyD0rv8aWuqnFBtztoe6slXZwq0UCo
         /yX4NfXa05AHCvQy69F2vMyaZn3tsIY8QcJw09uYEWf5gsfET8zmCQbzSaNmIyjmwyS4
         Z0XrugnDikHEUaZuBGRisre/WO0qQe6MeYVI5fhLAZ/ty2ILJ4+/yVmc6U/NYVfZebm1
         fXbD1jJp6sBMm5xEPzBl1P4rbCcyEsT3Z4GxetTGMGeMp/TNuLzfw2gPr/J2toUv4Ank
         JG8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779129303; x=1779734103;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HefdEi5yJeys6v2Xvf3SK5unmpenCeIO1ZUw+aAUkeI=;
        b=LGiogWiPfk8P6k1rrao3jvR481gnf/ofeeSDiTPsGI0GAvK7iDCfzTxb9ChgYhd3Mu
         /vhp59rI8a/CkT/8yoHU6i5kXx2DT12STCpbGr4hWZ1F3DoWszfGkKpXmcUByLRF9Ytv
         lAWyCMDZeeHIJO0ilvKLmRikUHeEdnmV7W4tdMUZu2MW2vm47KQJNLUwFhTAc9isej59
         Dyr4x1Yy8lI+QraRwxrJEMJAu6Z5UhySJzKmt27rNqSJdVIHf/gS4/iAnprxUMnbvH81
         PgNW52EVJSU1JlqiPb9YKwJyzgZMJMayqlRPrCbKxxkYbCs2B8XuZJUhhhz5sVC3FXVH
         nfSg==
X-Forwarded-Encrypted: i=1; AFNElJ/4hFxxBx7XTj1zXz93imkApCkoMfd9BHGnpGX6U4DLBppTp+p8upkkmiCMcyQAkevx0WTb0DM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpV5K5Fk6ZB5fh73Y06W7/mqNtfGiLpRoOlPOk3E8MI3W8yGog
	jW3kIuPA8+a2j/ygL4vtD9Mve5dPeZWBia2JmcrA47Pm5BWMPh6p9nDE
X-Gm-Gg: Acq92OGUbHPhgx3/AjVekWJ8Zx/rw0Dv8AFVgbpswYvNKj3JdNjnxHStmMi7aS1d5UO
	pQfQNJNpnEQVfU3qsHhHxiERK+LbkC/FKHG1gzgQ7CfWDTMTdqfQmenkBJTN9mjaIBn88dxvHjY
	D1tpqXR3cQOSEV/7iLqP2/MKCIo+41d4N5Ms+PMW2S8IU6cwfv6+t5ojLObyQRVqPGCz6/y0J4N
	TsLzQ9Vqjozqy2yWHtEa1AJV5EPPkT4VNLLk4S4CZO4V/5bDMmtfQXfOwMc44EkDuyBTXODtCeS
	eEfJPL57/WreJQ3L4cefEVhoO8rwXwR3iQLdAFHVThEPucyBfW2PwKG9eydyZ/SU0LmJuDqOp5S
	zrIVa0weDiea9S9lukeGGC4jAMRhR6qZPR+AGuwUC9uiyvNxHOZU7oetzv4qLc+3TWvqDcmjDQ0
	hvBoB8RvY3X/+qIJchfud0w/Ig9bieN/3lgLcRMI9XdJfrfE1w6qaSr5Ssbbw9StPnv0+GTPXPa
	gndlpN3Yh5//VIqauji
X-Received: by 2002:a05:622a:19a2:b0:50d:8080:2a7 with SMTP id d75a77b69052e-5165a0d1052mr213761201cf.21.1779129303092;
        Mon, 18 May 2026 11:35:03 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5168c968930sm50315401cf.0.2026.05.18.11.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 11:35:02 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: James Chapman <jchapman@katalix.com>,
	Tom Parkin <tparkin@katalix.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] l2tp: use list_del_rcu in l2tp_session_unhash
Date: Mon, 18 May 2026 14:34:47 -0400
Message-ID: <20260518183447.64078-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-289156-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 2DF485725A5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

An unprivileged local user can pin a host CPU indefinitely in
l2tp_session_get_by_ifname() by issuing L2TP_CMD_SESSION_GET on
L2TP_ATTR_IFNAME concurrently with L2TP_CMD_SESSION_CREATE and
L2TP_CMD_SESSION_DELETE on the same tunnel. All three commands take
GENL_UNS_ADMIN_PERM, so CAP_NET_ADMIN in the netns user namespace
suffices; on any host that has l2tp_core loaded the trigger is
reachable from a standard `unshare -Urn` sandbox.

l2tp_session_unhash() removes a session from tunnel->session_list
with list_del_init(), but that list is walked by
l2tp_session_get_by_ifname() with list_for_each_entry_rcu() under
rcu_read_lock_bh(). list_del_init() leaves the deleted entry's
next/prev self-pointing; a reader that has loaded the entry and
then advances pos->list.next reads &session->list, container_of()s
back to the same session, and list_for_each_entry_rcu() never
reaches the list head. The CPU stays in strcmp() inside the
walker, with BH and preemption disabled, so RCU grace periods on
the host stall behind it and the wedged thread cannot be killed
(SIGKILL is delivered on syscall return).

Use list_del_rcu() to match the existing list_add_rcu() in
l2tp_session_register(); the deleted session remains visible to
in-flight walkers with consistent next/prev pointers until
kfree_rcu() in l2tp_session_free() releases it. tunnel->session_list
has exactly one list_del_init() call site; the list_del_init
(&session->clist) at l2tp_core.c:533 operates on the per-collision
list, which is not walked under RCU. list_empty(&session->list) is
not used anywhere in net/l2tp/ after the unhash point, so dropping
the post-delete self-init is safe; the fix has no userspace-visible
behavior change.

Fixes: 89b768ec2dfef ("l2tp: use rcu list add/del when updating lists")
Cc: stable@vger.kernel.org # 6.11+
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
Distro reachability:

l2tp_core / l2tp_netlink autoload via the genl family alias
net-pf-16-proto-16-family-l2tp on first AF_NETLINK CTRL_CMD_GETFAMILY
lookup; this autoload does not require CAP_NET_ADMIN. Verified on
Ubuntu 26.04 dev as uid 1000 with no capabilities: `ip l2tp show
tunnel` triggers the load.

The userns CAP_NET_ADMIN gate is open to a standard unprivileged user
on Debian 11/12, Ubuntu 22.04 LTS, Arch, Alpine, and (via
snap / podman / firejail with a userns-permitting AppArmor profile)
Ubuntu 23.10+ / 24.04+. RHEL 8/9 and Fedora 31+ blacklist
l2tp_netlink in /etc/modprobe.d/ by default, so those distros require
admin enablement before the surface is reachable; once the module is
loaded (e.g. on a host running xl2tpd, NetworkManager-l2tp, or any
L2TPv3 VPN endpoint), the gate is open there too.

Reproduced on QEMU/x86_64 (KASAN + LOCKDEP + PROVE_RCU + PREEMPT
(full), SMP=4) and on bare-metal Ubuntu 7.0.0-14-generic with a
small create / delete + ifname-get harness. Stock kernel: first
rcu_preempt self-detected stall at 27 s, recurring every ~80 s,
8 stalls in a 600 s run; bare metal produced softlockup BUG: CPU
stuck for 26 s with RIP at l2tp_session_get_by_ifname+0x90 within
30 s of harness start, and the CPU remained pinned after harness
exit. Patched kernel under the same harness for 600 s: 282943
create/delete pairs plus 15381066 getter calls completed with zero
anomalies. The kernel ships no tools/testing/selftests/net/l2tp/
binaries and no l2tp KUnit module. Harness source available on
request.

 net/l2tp/l2tp_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
index 157fc23ce4e14..1455f67e01ddb 100644
--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -1360,7 +1360,7 @@ static void l2tp_session_unhash(struct l2tp_session *session)
 		spin_lock_bh(&pn->l2tp_session_idr_lock);

 		/* Remove from the per-tunnel list */
-		list_del_init(&session->list);
+		list_del_rcu(&session->list);

 		/* Remove from per-net IDR */
 		if (tunnel->version == L2TP_HDR_VER_3) {
--
2.46.0


