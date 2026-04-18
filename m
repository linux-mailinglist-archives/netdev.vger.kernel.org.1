Return-Path: <netdev+bounces-279474-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QNa/JO8X42n/BwEAu9opvQ
	(envelope-from <netdev+bounces-279474-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 07:34:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 415D142006E
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 07:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 32130300AB2F
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 05:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B39346FC8;
	Sat, 18 Apr 2026 05:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pqnlxoEZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA7C343D85
	for <netdev@vger.kernel.org>; Sat, 18 Apr 2026 05:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776490476; cv=none; b=mlMMf4v4pgSqdqcdVzKhhGKGeK0oadSArInZaThk1qBHFJC6oMmj95UkgimDLNcww3M0gTImJZBSqwwipdtI/O5veRjr6I6atVQR2cG83+IA660fLty6wQ3pumL3G7jzG/DlyZHJaW8b1XKYjBF/euVOJ+H7WIgo5RrQI4mnQaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776490476; c=relaxed/simple;
	bh=ZnOAyes5CApyxa4LVMptpnmk61/+ReVizQGGbcTr3UM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BwgZ964BYqHQmQLudMHNba07XkMmUG7h0x++fcKSvvMW4au32+QhTd8DFEgCneQro8zWrG1fL0VLuITxsfKf2SrBgCyrxJ5Db7uZGkWjob9RILB2IJfHwe/HfImH6c5YoZtodd/yIGplnx5yOydgz3pScFAtlYb3iJmu7NusQ98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pqnlxoEZ; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2aaed195901so6025195ad.0
        for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 22:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776490474; x=1777095274; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=moJK8j1PeysA2HLtwd4ur3AEjzXIvTcplo5qR2WzdzM=;
        b=pqnlxoEZJaI93YOA9MgOipcyRmPCLLH3Y05Mh8Hxwe6XQN/6xHeo3ltDgxU9G24KKZ
         QXy47f2bfq9+k6gg4jqYakaUWjT1XZ9Hbs4IO+mTwTt4DCDkYB3pVRpgulG45kp5HgP6
         tNPo0o3D5qSu8oZq5UJn6JlGpyfeAHzs0efB7uC9T2yz46KfvcRmoZ8w9CyAdshr92nb
         Ql8rw//OxcEhGwrfC2SMc6S18rfpBf0qP6siDND5cf17x2SyxdeI28VNidnwZagr1Xia
         SbDzd9qW0AtjL2fyY2svE62FSodhU9kRdoz8EcTIXwtIIsiP+UWoFSyxhNkkt+MofU6i
         TpRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776490474; x=1777095274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=moJK8j1PeysA2HLtwd4ur3AEjzXIvTcplo5qR2WzdzM=;
        b=Fa6h+hO0VuDRGH/O1LF9HZE7RANt6a84APn2R0BjCrC0TZVsbm/I7etDNh4WybA3Mc
         0Jko/Mh7aRMd5C8zBU2kXXQhbnmxZr39dmWOookv9lZ7ga4yMf4Bnxy+DKrVMFAL/cqC
         3QKBEF2uG/H4fwB1xa/NcfakxZms133M4io3payRKB9moSICuUwfLTsoOGsWJdoY3r5E
         XbBFzRiCmRvr3PM+IQ0zJnpz7m0dPtmPXLokglPptZ96BhUvjxLYXGZHOJcns84l7ght
         SrQEVOpwHrPjqCAD6slqjRLsGYn4h+TeYAkTwKOinzvDpBWttlWrKw/I8Lmd/aXdnKoM
         BLkw==
X-Forwarded-Encrypted: i=1; AFNElJ+M+e81cYSnhr3xfNGAFlqzSIo8yjp+5sR56XsnJdDBhW7AVmsT0G66T0w422VruF5nHqzkRDA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZQ76OBMbQ7xUlDsklBbSiqRkyAetqx59EUPtIjtOxEpv0uKiD
	dl+zZ/G8sVOdNX7w38UYqWgkdxsxVJvopge+OtZ62USH/ITfDR0o1KKx
X-Gm-Gg: AeBDietjB6JWicuPd5K9fl4th68X/IZ+RW9Hbj90EDDKfKXUXF8lF5xWpnEpSj0TURz
	dekfFSm+kCSqz0H33buX8rIgLVmN3qjlBxNpMS/E4jwUBZIbUEXHrmhg8wjSSQmYH2rpHYExGlT
	Vt5DaU3WCvyhFB66yuMhw1+qL7VNf0SSY5MlrauUtTloZHSJfgm8kFfL1xdpTNR4WQyD3us+HxK
	AzmLtWPNvPBZSGac/beMca0GVd+b+vjV3mZbIAC/nzGQ52BON+nTF8aMwjbfQKFjoWqeayoISkd
	vlUWh7xb3EVmkMCKBAZ7pG8jjEfmJNbwZkdTEjIlHcXC91rW818wiPp+1sA9C3H2MS1Wcg5Qqpl
	HAoBtcE2POVGTDOJDTU4j/t7kPqqaiKdPYa4RnJ1H+MyvVaSPGs0fl3FFYaRMBhy7bgjVsyIh0d
	ZMm3RrNy4pcurwsBMb5RTX6XTuJnVX9DGyUF1PgnQvsjlIAR+fa5fb9exAWg==
X-Received: by 2002:a17:903:890:b0:2b0:5968:a6d5 with SMTP id d9443c01a7336-2b5f9ef3e8fmr41044065ad.18.1776490474181;
        Fri, 17 Apr 2026 22:34:34 -0700 (PDT)
Received: from fedora ([61.74.238.173])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fa9ff3bfsm46251885ad.7.2026.04.17.22.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 22:34:33 -0700 (PDT)
From: SeungJu Cheon <suunj1331@gmail.com>
To: luiz.dentz@gmail.com,
	marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	me@brighamcampbell.com,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	SeungJu Cheon <suunj1331@gmail.com>
Subject: [PATCH 2/2] Bluetooth: ISO: Fix data-race on iso_pi(sk) in socket and HCI event paths
Date: Sat, 18 Apr 2026 14:34:01 +0900
Message-ID: <20260418053401.128483-3-suunj1331@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260418053401.128483-1-suunj1331@gmail.com>
References: <20260418053401.128483-1-suunj1331@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,brighamcampbell.com,linuxfoundation.org,lists.linux.dev,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-279474-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,holtmann.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[suunj1331@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 415D142006E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Several iso_pi(sk) fields (qos, qos_user_set, bc_sid, base, base_len,
sync_handle, bc_num_bis) are written under lock_sock in
iso_sock_setsockopt() and iso_sock_bind(), but read and written under
hci_dev_lock only in two other paths:

  - iso_connect_bis() / iso_connect_cis(), invoked from connect(2),
    read qos/base/bc_sid and reset qos to default_qos on the
    qos_user_set validation failure -- all without lock_sock.

  - iso_connect_ind(), invoked from hci_rx_work, writes sync_handle,
    bc_sid, qos.bcast.encryption, bc_num_bis, base and base_len on
    PA_SYNC_ESTABLISHED / PAST_RECEIVED / BIG_INFO_ADV_REPORT /
    PER_ADV_REPORT events. The BIG_INFO handler additionally passes
    &iso_pi(sk)->qos together with sync_handle / bc_num_bis / bc_bis
    to hci_conn_big_create_sync() while setsockopt may be mutating
    them.

Acquire lock_sock around the affected accesses in both paths.

The locking order hci_dev_lock -> lock_sock matches the existing
iso_conn_big_sync() precedent, whose comment documents the same
requirement for hci_conn_big_create_sync(). The HCI connect/bind
helpers do not wait for command completion -- they enqueue work via
hci_cmd_sync_queue{,_once}() / hci_le_create_cis_pending() and
return -- so the added hold time is comparable to iso_conn_big_sync().

KCSAN report:

BUG: KCSAN: data-race in iso_connect_cis / iso_sock_setsockopt

read to 0xffffa3ae8ce3cdc8 of 1 bytes by task 335 on cpu 0:
 iso_connect_cis+0x49f/0xa20
 iso_sock_connect+0x60e/0xb40
 __sys_connect_file+0xbd/0xe0
 __sys_connect+0xe0/0x110
 __x64_sys_connect+0x40/0x50
 x64_sys_call+0xcad/0x1c60
 do_syscall_64+0x133/0x590
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

write to 0xffffa3ae8ce3cdc8 of 60 bytes by task 334 on cpu 1:
 iso_sock_setsockopt+0x69a/0x930
 do_sock_setsockopt+0xc3/0x170
 __sys_setsockopt+0xd1/0x130
 __x64_sys_setsockopt+0x64/0x80
 x64_sys_call+0x1547/0x1c60
 do_syscall_64+0x133/0x590
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 UID: 0 PID: 334 Comm: iso_setup_race Not tainted 7.0.0-10949-g8541d8f725c6 #44 PREEMPT(lazy)

The iso_connect_ind() races were found by inspection.

Fixes: ccf74f2390d6 ("Bluetooth: Add BTPROTO_ISO socket type")
Signed-off-by: SeungJu Cheon <suunj1331@gmail.com>
---
 net/bluetooth/iso.c | 54 +++++++++++++++++++++++++--------------------
 1 file changed, 30 insertions(+), 24 deletions(-)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 14963ba68597..3ba13769be3a 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -347,6 +347,7 @@ static int iso_connect_bis(struct sock *sk)
 		return -EHOSTUNREACH;
 
 	hci_dev_lock(hdev);
+	lock_sock(sk);
 
 	if (!bis_capable(hdev)) {
 		err = -EOPNOTSUPP;
@@ -399,13 +400,9 @@ static int iso_connect_bis(struct sock *sk)
 		goto unlock;
 	}
 
-	lock_sock(sk);
-
 	err = iso_chan_add(conn, sk, NULL);
-	if (err) {
-		release_sock(sk);
+	if (err)
 		goto unlock;
-	}
 
 	/* Update source addr of the socket */
 	bacpy(&iso_pi(sk)->src, &hcon->src);
@@ -421,9 +418,8 @@ static int iso_connect_bis(struct sock *sk)
 		iso_sock_set_timer(sk, READ_ONCE(sk->sk_sndtimeo));
 	}
 
-	release_sock(sk);
-
 unlock:
+	release_sock(sk);
 	hci_dev_unlock(hdev);
 	hci_dev_put(hdev);
 	return err;
@@ -444,6 +440,7 @@ static int iso_connect_cis(struct sock *sk)
 		return -EHOSTUNREACH;
 
 	hci_dev_lock(hdev);
+	lock_sock(sk);
 
 	if (!cis_central_capable(hdev)) {
 		err = -EOPNOTSUPP;
@@ -498,13 +495,9 @@ static int iso_connect_cis(struct sock *sk)
 		goto unlock;
 	}
 
-	lock_sock(sk);
-
 	err = iso_chan_add(conn, sk, NULL);
-	if (err) {
-		release_sock(sk);
+	if (err)
 		goto unlock;
-	}
 
 	/* Update source addr of the socket */
 	bacpy(&iso_pi(sk)->src, &hcon->src);
@@ -520,9 +513,8 @@ static int iso_connect_cis(struct sock *sk)
 		iso_sock_set_timer(sk, READ_ONCE(sk->sk_sndtimeo));
 	}
 
-	release_sock(sk);
-
 unlock:
+	release_sock(sk);
 	hci_dev_unlock(hdev);
 	hci_dev_put(hdev);
 	return err;
@@ -2259,8 +2251,10 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 		sk = iso_get_sock(hdev, &hdev->bdaddr, bdaddr, BT_LISTEN,
 				  iso_match_sid, ev1);
 		if (sk && !ev1->status) {
+			lock_sock(sk);
 			iso_pi(sk)->sync_handle = le16_to_cpu(ev1->handle);
 			iso_pi(sk)->bc_sid = ev1->sid;
+			release_sock(sk);
 		}
 
 		goto done;
@@ -2271,8 +2265,10 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 		sk = iso_get_sock(hdev, &hdev->bdaddr, bdaddr, BT_LISTEN,
 				  iso_match_sid_past, ev1a);
 		if (sk && !ev1a->status) {
+			lock_sock(sk);
 			iso_pi(sk)->sync_handle = le16_to_cpu(ev1a->sync_handle);
 			iso_pi(sk)->bc_sid = ev1a->sid;
+			release_sock(sk);
 		}
 
 		goto done;
@@ -2299,27 +2295,35 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 					  ev2);
 
 		if (sk) {
-			int err;
-			struct hci_conn	*hcon = iso_pi(sk)->conn->hcon;
+			int err = 0;
+			bool big_sync;
+			struct hci_conn *hcon;
 
+			lock_sock(sk);
+
+			hcon = iso_pi(sk)->conn->hcon;
 			iso_pi(sk)->qos.bcast.encryption = ev2->encryption;
 
 			if (ev2->num_bis < iso_pi(sk)->bc_num_bis)
 				iso_pi(sk)->bc_num_bis = ev2->num_bis;
 
-			if (!test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags) &&
-			    !test_and_set_bit(BT_SK_BIG_SYNC, &iso_pi(sk)->flags)) {
+			big_sync = !test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags) &&
+				   !test_and_set_bit(BT_SK_BIG_SYNC, &iso_pi(sk)->flags);
+
+			if (big_sync)
 				err = hci_conn_big_create_sync(hdev, hcon,
 							       &iso_pi(sk)->qos,
 							       iso_pi(sk)->sync_handle,
 							       iso_pi(sk)->bc_num_bis,
 							       iso_pi(sk)->bc_bis);
-				if (err) {
-					bt_dev_err(hdev, "hci_le_big_create_sync: %d",
-						   err);
-					sock_put(sk);
-					sk = NULL;
-				}
+
+			release_sock(sk);
+
+			if (big_sync && err) {
+				bt_dev_err(hdev, "hci_le_big_create_sync: %d",
+					   err);
+				sock_put(sk);
+				sk = NULL;
 			}
 		}
 
@@ -2373,8 +2377,10 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 			if (!base || base_len > BASE_MAX_LENGTH)
 				goto done;
 
+			lock_sock(sk);
 			memcpy(iso_pi(sk)->base, base, base_len);
 			iso_pi(sk)->base_len = base_len;
+			release_sock(sk);
 		} else {
 			/* This is a PA data fragment. Keep pa_data_len set to 0
 			 * until all data has been reassembled.
-- 
2.52.0


