Return-Path: <netdev+bounces-259194-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJz4F7UZlWnnLAIAu9opvQ
	(envelope-from <netdev+bounces-259194-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 02:45:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C5531528FB
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 02:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 472C030117D4
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 01:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78FE2DB7B7;
	Wed, 18 Feb 2026 01:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iOn8/iSy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C96199230
	for <netdev@vger.kernel.org>; Wed, 18 Feb 2026 01:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771379119; cv=none; b=q+c/xYz292dAWpxECS/E12cxATwrDtEdCxPgM9PrSBUFpN5D2c1l4AMLpAyyEcwTQBDrHgiWMpxMpBOIa5ClEoo4DVvOl8bxr8ZXNCFA0a3ZiaTpW+ei0kqBYynxOAobGwY6dra3iNZ5uAsDDmM3mEhJlJ5RLhYxiV8wDqEYTTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771379119; c=relaxed/simple;
	bh=3AT9Jcju4MsV/M4OfDSUtW23PxNc6ImHVjzXYS6HH4U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=eMn9F0OKJgBDJnO7oYKOu2EmKdjrUXp/fP4l6FcfOtMnCqwTjeq8DB72upQ307tiJbf2WI0BWuTZj1N8oDIKArE+aJ578gndO6bi/aZrgOpbD5ZKqWuVGUxvAfFNFOKhmTipop9wmF9Or22ztGEP9j0CXERNmK0nkItfYswb6VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iOn8/iSy; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-794fe16d032so40106147b3.3
        for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 17:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771379116; x=1771983916; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NJw3RoD55rqXpHAojvOHyDwhmqotW0ZND3DwuoSWa18=;
        b=iOn8/iSyVCbgKzva3Z2w1//iMGcbnuC5yZ0qWt8X3winpZ9wvrFQn8qsjrpPLw29Eu
         aFL95n9ZVVGpKoeB3emUJMQ+tYuOGdsRnQgcxyNjIf1C53qL97inW8LziMlFrW0fv8Vz
         UeQZ0Ag0AznInCpSioNQ0NLBAumPFrpUnOZW2xgUu/NWIWGiN3JHAIQLGPVxQ2DqIVfq
         Z93ywxACQqphbySqRDBpCuE8QvL++Dr+xeeRW9UsQyzXgN0VxRJc5/F5293YwGAefhJn
         rY5U8QnikmdVfWcKiAGz6EEaKqmmQmYMuKbICi2WNPE1TMKXHgA3AuUnvaS3bGMSRByn
         EaoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771379116; x=1771983916;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NJw3RoD55rqXpHAojvOHyDwhmqotW0ZND3DwuoSWa18=;
        b=Tw8b/yAP09v9z2voOsiudlFtcTtxpvAufSEHYEJ/Wm3VFcH7c3oTJoRrA7vdpT67ga
         73bJPsu4MZYObCdWoFUy2Ep0kn0o3odn6CDOn4ZJ2BPd9wSu/lQND+fUtlEJpCkSi6rB
         KY/SpwVmfvIYPe8xQhv/TsNnQ9kahqtv9yo+J4YdF3JTIMCHTicwlUwRgrUh1oKkbBkt
         VHjvKWK6NXKFxLnt5uGxhrxpbA5sNq6BahT1rpN0q4RAYcIm9LeGNVw0Xhb/I0vw7iSj
         bEbuhDLnh7Xq8HzWU1txbpu6VS3nSs5dth+6HKThx1IN1gc0d2CrmyOO9oagJhD9ds04
         HMCw==
X-Forwarded-Encrypted: i=1; AJvYcCXINDTvugfOCMCvsJidNx4J6n2Yaf00epKR5iEO3M2z6X0EZF4IxDy7vlsG6wT7uMq2bUrVXcc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkEO9lvl2A1fAd28G8s2A2oav4Nfa9NQZtvOUfwHRhXt7nw8Wc
	l0zGhmt+q7J9rh+SQHk+3HofBtPIJrZSaBUdHJ/rgGWy91Jp9vEm8y8M
X-Gm-Gg: AZuq6aKpk2CD7LDiJsp+SriIAu9dkbmBhbtyTe0ql7RiGUU/+sk3Hb7p3lXXVWHHDNN
	0AyUnC8yqTermnVycEYECitvXMTt0StfLsD3xnlvxOXgQAjvDBToUsVWPkomXEiAunWcALOfLBs
	/tEyTaC4w3fToaHZzsbiqUu0jpCfdGKjzcA4ajqvHKpyUS9s0en8Mlo8cAMWvkWuuAHrtG5hmfT
	wey+ve16zSVqZD96mOSBYrfIaNJUw/8x872YSN8GZgr1hTF8KBPHQOpn94uuFGyJtqOSfxbwJ9X
	w2OFPcFlttQtAJnKFZqz/gIEYJy9a7h+TkrG9inL4sdZvK+3mmh0iZS/M9SBkzYJZmtUxxtsWna
	J5YIfF9Cgm9a8fKoY+zQtjO66oSH2ocGEv42429ZMXdiQI4Nja50SzAT5wkW+Js1bCdJILcedvi
	EdLQ/XW99/BfhkQY782fsXaw==
X-Received: by 2002:a05:690c:87:b0:792:7236:9708 with SMTP id 00721157ae682-797f71e85acmr2766167b3.20.1771379116125;
        Tue, 17 Feb 2026 17:45:16 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:71::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7966c18ffc5sm116481207b3.18.2026.02.17.17.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 17:45:15 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 17 Feb 2026 17:45:10 -0800
Subject: [PATCH net] vsock: lock down child_ns_mode as write-once
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260217-vsock-ns-write-once-v1-1-a1fb30f289a9@meta.com>
X-B4-Tracking: v=1; b=H4sIAKUZlWkC/x3MUQqDMAwG4KuE/9lA7cSVXmXsQWq2hUE6GtGBe
 HfB7wDfDpem4si0o8mqrtWQqe8I5TPZW1hnZEIMcQyxv/PqtXzZnLemi3C1IpzSbZjHNEiYIjr
 Cr8lL/9f6gMmC53Gcz98HGmoAAAA=
X-Change-ID: 20260217-vsock-ns-write-once-8834d684e0a2
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Daan De Meyer <daan.j.demeyer@gmail.com>
X-Mailer: b4 0.14.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259194-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,gmail.com];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:mid,meta.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0C5531528FB
X-Rspamd-Action: no action

From: Bobby Eshleman <bobbyeshleman@meta.com>

To improve the security posture of vsock namespacing, this patch locks
down the vsock child_ns_mode sysctl setting with a write-once policy.
The user may write to child_ns_mode only once in each namespace, making
changes to either local or global mode be irreversible.

This avoids security breaches where a process in a local namespace may
attempt to jailbreak into the global vsock ns space by setting
child_ns_mode to "global", creating a new namespace, and accessing the
global space through the new namespace.

Additionally, fix the test functions that this change would otherwise
break by adding "global-parent" and "local-parent" namespaces and using
them as intermediaries to spawn namespaces in the given modes. This
avoids the need to change "child_ns_mode" in the init_ns. nsenter must
be used because ip netns unshares the mount namespace so nested "ip
netns add" breaks exec calls from the init ns.

Test run:

1..25
ok 1 vm_server_host_client
ok 2 vm_client_host_server
ok 3 vm_loopback
ok 4 ns_host_vsock_ns_mode_ok
ok 5 ns_host_vsock_child_ns_mode_ok
ok 6 ns_global_same_cid_fails
ok 7 ns_local_same_cid_ok
ok 8 ns_global_local_same_cid_ok
ok 9 ns_local_global_same_cid_ok
ok 10 ns_diff_global_host_connect_to_global_vm_ok
ok 11 ns_diff_global_host_connect_to_local_vm_fails
ok 12 ns_diff_global_vm_connect_to_global_host_ok
ok 13 ns_diff_global_vm_connect_to_local_host_fails
ok 14 ns_diff_local_host_connect_to_local_vm_fails
ok 15 ns_diff_local_vm_connect_to_local_host_fails
ok 16 ns_diff_global_to_local_loopback_local_fails
ok 17 ns_diff_local_to_global_loopback_fails
ok 18 ns_diff_local_to_local_loopback_fails
ok 19 ns_diff_global_to_global_loopback_ok
ok 20 ns_same_local_loopback_ok
ok 21 ns_same_local_host_connect_to_local_vm_ok
ok 22 ns_same_local_vm_connect_to_local_host_ok
ok 23 ns_delete_vm_ok
ok 24 ns_delete_host_ok
ok 25 ns_delete_both_ok
SUMMARY: PASS=25 SKIP=0 FAIL=0

Fixes: eafb64f40ca4 ("vsock: add netns to vsock core")
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
Suggested-by: Daan De Meyer <daan.j.demeyer@gmail.com>
Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
---
 include/net/af_vsock.h                  |  6 +++++-
 include/net/netns/vsock.h               |  1 +
 net/vmw_vsock/af_vsock.c                | 10 ++++++----
 tools/testing/selftests/vsock/vmtest.sh | 35 +++++++++++++++------------------
 4 files changed, 28 insertions(+), 24 deletions(-)

diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index d3ff48a2fbe0..c7de33039907 100644
--- a/include/net/af_vsock.h
+++ b/include/net/af_vsock.h
@@ -276,10 +276,14 @@ static inline bool vsock_net_mode_global(struct vsock_sock *vsk)
 	return vsock_net_mode(sock_net(sk_vsock(vsk))) == VSOCK_NET_MODE_GLOBAL;
 }
 
-static inline void vsock_net_set_child_mode(struct net *net,
+static inline bool vsock_net_set_child_mode(struct net *net,
 					    enum vsock_net_mode mode)
 {
+	if (xchg(&net->vsock.child_ns_mode_locked, 1))
+		return false;
+
 	WRITE_ONCE(net->vsock.child_ns_mode, mode);
+	return true;
 }
 
 static inline enum vsock_net_mode vsock_net_child_mode(struct net *net)
diff --git a/include/net/netns/vsock.h b/include/net/netns/vsock.h
index b34d69a22fa8..8c855fff8039 100644
--- a/include/net/netns/vsock.h
+++ b/include/net/netns/vsock.h
@@ -17,5 +17,6 @@ struct netns_vsock {
 
 	enum vsock_net_mode mode;
 	enum vsock_net_mode child_ns_mode;
+	int child_ns_mode_locked;
 };
 #endif /* __NET_NET_NAMESPACE_VSOCK_H */
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 9880756d9eff..35e097f4fde8 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -90,14 +90,15 @@
  *
  *   - /proc/sys/net/vsock/ns_mode (read-only) reports the current namespace's
  *     mode, which is set at namespace creation and immutable thereafter.
- *   - /proc/sys/net/vsock/child_ns_mode (writable) controls what mode future
+ *   - /proc/sys/net/vsock/child_ns_mode (write-once) controls what mode future
  *     child namespaces will inherit when created. The initial value matches
  *     the namespace's own ns_mode.
  *
  *   Changing child_ns_mode only affects newly created namespaces, not the
  *   current namespace or existing children. A "local" namespace cannot set
- *   child_ns_mode to "global". At namespace creation, ns_mode is inherited
- *   from the parent's child_ns_mode.
+ *   child_ns_mode to "global". child_ns_mode is write-once, so that it may
+ *   be configured and locked down by a namespace manager. At namespace
+ *   creation, ns_mode is inherited from the parent's child_ns_mode.
  *
  *   The init_net mode is "global" and cannot be modified.
  *
@@ -2853,7 +2854,8 @@ static int vsock_net_child_mode_string(const struct ctl_table *table, int write,
 		    new_mode == VSOCK_NET_MODE_GLOBAL)
 			return -EPERM;
 
-		vsock_net_set_child_mode(net, new_mode);
+		if (!vsock_net_set_child_mode(net, new_mode))
+			return -EPERM;
 	}
 
 	return 0;
diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index dc8dbe74a6d0..e1e78b295e41 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -210,16 +210,17 @@ check_result() {
 }
 
 add_namespaces() {
-	local orig_mode
-	orig_mode=$(cat /proc/sys/net/vsock/child_ns_mode)
+	ip netns add "global-parent" 2>/dev/null
+	echo "global" | ip netns exec "global-parent" \
+		tee /proc/sys/net/vsock/child_ns_mode &>/dev/null
+	ip netns add "local-parent" 2>/dev/null
+	echo "local" | ip netns exec "local-parent" \
+		tee /proc/sys/net/vsock/child_ns_mode &>/dev/null
 
-	for mode in "${NS_MODES[@]}"; do
-		echo "${mode}" > /proc/sys/net/vsock/child_ns_mode
-		ip netns add "${mode}0" 2>/dev/null
-		ip netns add "${mode}1" 2>/dev/null
-	done
-
-	echo "${orig_mode}" > /proc/sys/net/vsock/child_ns_mode
+	nsenter --net=/var/run/netns/global-parent ip netns add "global0" 2>/dev/null
+	nsenter --net=/var/run/netns/global-parent ip netns add "global1" 2>/dev/null
+	nsenter --net=/var/run/netns/local-parent ip netns add "local0" 2>/dev/null
+	nsenter --net=/var/run/netns/local-parent ip netns add "local1" 2>/dev/null
 }
 
 init_namespaces() {
@@ -237,6 +238,8 @@ del_namespaces() {
 		log_host "removed ns ${mode}0"
 		log_host "removed ns ${mode}1"
 	done
+	ip netns del "global-parent" &>/dev/null
+	ip netns del "local-parent" &>/dev/null
 }
 
 vm_ssh() {
@@ -287,7 +290,7 @@ check_args() {
 }
 
 check_deps() {
-	for dep in vng ${QEMU} busybox pkill ssh ss socat; do
+	for dep in vng ${QEMU} busybox pkill ssh ss socat nsenter; do
 		if [[ ! -x $(command -v "${dep}") ]]; then
 			echo -e "skip:    dependency ${dep} not found!\n"
 			exit "${KSFT_SKIP}"
@@ -1231,12 +1234,8 @@ test_ns_local_same_cid_ok() {
 }
 
 test_ns_host_vsock_child_ns_mode_ok() {
-	local orig_mode
-	local rc
-
-	orig_mode=$(cat /proc/sys/net/vsock/child_ns_mode)
+	local rc="${KSFT_PASS}"
 
-	rc="${KSFT_PASS}"
 	for mode in "${NS_MODES[@]}"; do
 		local ns="${mode}0"
 
@@ -1246,15 +1245,13 @@ test_ns_host_vsock_child_ns_mode_ok() {
 			continue
 		fi
 
-		if ! echo "${mode}" > /proc/sys/net/vsock/child_ns_mode; then
-			log_host "child_ns_mode should be writable to ${mode}"
+		if ! echo "${mode}" | ip netns exec "${ns}" \
+			tee /proc/sys/net/vsock/child_ns_mode &>/dev/null; then
 			rc="${KSFT_FAIL}"
 			continue
 		fi
 	done
 
-	echo "${orig_mode}" > /proc/sys/net/vsock/child_ns_mode
-
 	return "${rc}"
 }
 

---
base-commit: 77c5e3fdd2793f478e6fdae55c9ea85b21d06f8f
change-id: 20260217-vsock-ns-write-once-8834d684e0a2

Best regards,
-- 
Bobby Eshleman <bobbyeshleman@meta.com>


