Return-Path: <netdev+bounces-291023-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8JWtEl4SEWrDgwYAu9opvQ
	(envelope-from <netdev+bounces-291023-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 04:35:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BDFFB5BCBEF
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 04:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EF71A3020FF5
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 02:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E775F33469C;
	Sat, 23 May 2026 02:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cIB65uF3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D49C33120A
	for <netdev@vger.kernel.org>; Sat, 23 May 2026 02:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779503684; cv=none; b=D6ly8nkWO+azuad8XO2PUeQeUx2/5gnfrfHDxGFR8i4dUgxw2/NAQjwwPXNQn32TaBL8/OCmAW38s4cT5lO70Oj0CYjqkyirH7EYHcssvdVybPtLInrfLWItCcpelmann4QJ8eUjc9cz0ai4S3Y3JPIL8pIT+tAm9RnJ+Z0rkiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779503684; c=relaxed/simple;
	bh=w62EixdXxW4lxN7YjkeQjbgrtjS8Wu59Jj7E2YpYpSg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YVLdokk9tkbPGuzTZbt3lKXeyeHX5Wgx2Z7ulSFPz77QF1YOjNJq7zuLEvdUx/wsrM3n2gvYxSczQcmzsgkD7Hvb3SUAhhqC8bjSGoqfwB6xHZA9uUg+JjWcrNFcBTFdAebTxp/6g5WlkJRClGNT8O6AV8E3UB/Yn1f54QwXSqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cIB65uF3; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8b74b460d77so108406416d6.3
        for <netdev@vger.kernel.org>; Fri, 22 May 2026 19:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779503682; x=1780108482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sK2eCVykGOBgCXXqQhMEZuidmUMZ94iDMgqX9P1DHWY=;
        b=cIB65uF35qSBBH97wlM+Y7NmRZ6BMJsvKhNP/9ZRu3HoaW/oXIY6Ov5/HyGuNUVAnh
         ZGvAJyZQFRzPRir4ZYMOn9Or8Tjlfu9m75WadLVsEZ3pR8/C3Bx8tq9W/e2+6v84cZoR
         mPrPQ7FPvshDTgQMtL3IKmCb+/mTYrEoZIjaJT0KO0VClncJasoNitwZ7+63DwwrzUtH
         j1EeC8/GmP3Anx8ZOI/NuZeokFhq5u8qiC1rPH09ofmMzjLH+fi6wm2ehXIgicmCkDFN
         FOh/sRX9GnDQQvzPtq6ax8Nk30bIZ+XLQM5QG3VGDsB3JF06kOtVgib6ww4oPFeRjoGX
         UnFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779503682; x=1780108482;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sK2eCVykGOBgCXXqQhMEZuidmUMZ94iDMgqX9P1DHWY=;
        b=SlK7/bLFHoNxB4R6nnk8T8whveRUPq4ccuZjROsG9khuRlGJLIk4X2JkBkUi4b3VGX
         LRw8vjJqlkkpMJDQ0XCm1Bd0LkvrYXeEpyeyVRprlY86Hb0AErwJLrBL+GPMhpwDUJeg
         xkfrWbvrTJDGz5JLajXQgu2BGi9Sp0DzxIHcT1birGljpVx3WFH9OHM+j+iWjHHIpT9p
         e8lKps6+n/USsM3Ukg1EaZzuDtN1lCX5ar1hPCjKCAXtphrRbVZTec8LERR7LN0a+cNN
         2nmsAjG89gFi0DMyTc4VYWtggBNAIGFM/Imc7v6BnzO6Qm5ZXnXDB2KoRjJjZlhbd5EC
         nkXg==
X-Forwarded-Encrypted: i=1; AFNElJ/JEsg17zNBQsxFsGL8fPEOzcfnPsO7Ji0LVDhU9Te2NzO5bnj+QrXVAnGaX0BYKhiRlIm7kfw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxApK+sJW7xC0WR8MeM8IcOD11+oQ7qUxwpNJRKHjUHFJF2scGv
	NkX6ylHW3mCg8qVlHE6IZg5dxwnyccqdbMEmAxTArZEHQ7IRMWTieZHy
X-Gm-Gg: Acq92OFpfOxEs+ExdM7w4hA0yxBXWEtXZFBGE7MfL2ebvnsncYMB2wAoWpHdmoJRZz7
	GUzn89ECZ8v7ie1DTvxbFpA1dIoHYBLwA6hIzBwBPspwbflfeiDuP9O0wY8CpkNo06KzLYcYP+p
	EjjjsbBeZQavoMT3HjUNPd0wVoxMlsKSQJiQ2fDPXIZJupXAnU2GJ8EZx8SqBbaxiZCLCbg+VL8
	Xs1BG/ieeGuu017e0Es4NJ0GMC13cI2pCBD67Q05Jf0XNNZK5Sl4mW3JL8cdVBzpsftrcLDnoO9
	qIE+KxUpyPy38nqiSrJEuBRplGUqt+TjRcb/VHhjJrVs55gOZXO791ng3ERtie7wCKOOBivRF+f
	zWkLWTX5nut4AE37A/uAPqYOE8g86K1FZXzRRaFIWHIPIW2bC2B78w390w12R93IS1cvlolEGZ7
	FjaDB8Cp/e0VJTyDQBEpG97qzzrfLbUBeN7VE+J7/QJLQgdPqug6EdNqEDU3mprrOETtnHcCEPf
	6RBtawtiSl7HYh0mJi2
X-Received: by 2002:a05:6214:5b85:b0:8ac:b677:c408 with SMTP id 6a1803df08f44-8cc7b5ebbfamr110690436d6.44.1779503682214;
        Fri, 22 May 2026 19:34:42 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc812e269csm35095256d6.25.2026.05.22.19.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 19:34:41 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: James Chapman <jchapman@katalix.com>,
	Tom Parkin <tparkin@katalix.com>,
	Guillaume Nault <gnault@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Kees Cook <kees@kernel.org>,
	netdev@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] l2tp: use refcount_inc_not_zero in l2tp_session_get_by_ifname
Date: Fri, 22 May 2026 22:34:23 -0400
Message-ID: <20260523023423.2568972-1-michael.bommarito@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-291023-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: BDFFB5BCBEF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

A reader in l2tp_session_get_by_ifname() can return a pointer to a
session whose refcount has reached zero. The getter takes its
reference with plain refcount_inc(), but every other session getter
in the same file (l2tp_v2_session_get, l2tp_v3_session_get, and the
corresponding _get_next variants) uses refcount_inc_not_zero()
because the IDR/RCU lookup can race with refcount_dec_and_test() ->
l2tp_session_free() -> kfree_rcu(). The ifname getter is the only
outlier; the inconsistency was raised on-list after 979c017803c4
("l2tp: use list_del_rcu in l2tp_session_unhash").

A reader inside rcu_read_lock_bh() that matches session->ifname can
be preempted between the strcmp() and the refcount_inc(). If the
last reference drops on another CPU in that window, the reader's
refcount_inc() runs on a counter that has reached zero. refcount_t
catches the addition-on-zero, prints "refcount_t: addition on 0;
use-after-free", saturates the counter, and returns the saturated
pointer to the caller. Session memory is held live by the in-flight
RCU read section, but the kfree_rcu() callback queued from
l2tp_session_free() will free it once the grace period closes; a
caller that dereferences the returned session past that point hits
a slab-use-after-free. On PREEMPT_RT local_bh_disable() is a per-CPU
sleeping lock and the preemption window is real; on stock PREEMPT
kernels local_bh_disable() is a preempt_count increment that closes
the cross-CPU race in practice (see below).

Use refcount_inc_not_zero() and continue the list walk on failure,
matching the other session getters in the file. The ifname getter
is the only session getter in net/l2tp/ that still uses the bare
refcount_inc() pattern; this change restores file-internal
consistency. The success path is unchanged.

Fixes: abe7a1a7d0b6 ("l2tp: improve tunnel/session refcount helpers")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
Distro reachability:

l2tp_core and l2tp_netlink autoload via the genl family alias
net-pf-16-proto-16-family-l2tp on first AF_NETLINK CTRL_CMD_GETFAMILY
lookup; pppol2tp autoloads on demand via net-l2tp-type-7 from
L2TP_CMD_SESSION_CREATE with pw_type=L2TP_PWTYPE_PPP. Neither
autoload requires CAP_SYS_MODULE. SESSION_GET / SESSION_CREATE /
SESSION_DELETE are GENL_UNS_ADMIN_PERM, so CAP_NET_ADMIN in the
netns user namespace suffices and is reachable from `unshare -Urn`
on Debian 11/12, Ubuntu 22.04 LTS / 23.10+ / 24.04+, Arch, Alpine;
RHEL/Fedora blacklist l2tp_netlink by default but on hosts running
NetworkManager-l2tp, xl2tpd, or any L2TPv3 endpoint the gate is open
there too. PREEMPT_RT ships on Ubuntu Pro Realtime, RHEL 9 RT, SUSE
RT, and Yocto-RT.

Reproduced on x86_64 QEMU/KVM. Under tracefs-kprobe widening at the
refcount-inc instruction, a PREEMPT_RT build hits "refcount_t:
addition on 0; use-after-free" through l2tp_session_get_by_ifname at
533 s; patched runs 1800 s clean. A stock PREEMPT (non-RT) build
with the same widening ran 1800 s without firing: local_bh_disable()
on non-RT prevents preemption inside the RCU section so the
cross-CPU window does not open at observable rates.

 net/l2tp/l2tp_core.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
index 1455f67e01ddb..0000000000000 100644
--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -441,12 +441,13 @@ struct l2tp_session *l2tp_session_get_by_ifname(const struct net *net,
 	idr_for_each_entry_ul(&pn->l2tp_tunnel_idr, tunnel, tmp, tunnel_id) {
 		if (tunnel) {
 			list_for_each_entry_rcu(session, &tunnel->session_list, list) {
-				if (!strcmp(session->ifname, ifname)) {
-					refcount_inc(&session->ref_count);
-					rcu_read_unlock_bh();
+				if (strcmp(session->ifname, ifname))
+					continue;
+				if (!refcount_inc_not_zero(&session->ref_count))
+					continue;
+				rcu_read_unlock_bh();

-					return session;
-				}
+				return session;
 			}
 		}
 	}
--
2.46.0

