Return-Path: <netdev+bounces-298457-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YdBvBxCSK2qG/wMAu9opvQ
	(envelope-from <netdev+bounces-298457-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 06:58:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 79406676AEB
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 06:58:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=qMU2SiHu;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298457-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298457-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 54D873078E95
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 04:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3BF23998B7;
	Fri, 12 Jun 2026 04:58:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB4538E113
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 04:58:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781240333; cv=none; b=QBePB0H2RmF9UNwcLIx4K7VBGbaZqktscmCw9jSZMS4pwRTYwJb+E+C7u+aRP+cOFgO8qxgzFuhiO0wh3dyg0OHqvbflSBvMd7O/M0cUaQcGLDnBdm4ThHfUoxeZ/pD3+HZQmx3LSI6OSqItRsarX1eilWzx5S+t3LCfrEDkESQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781240333; c=relaxed/simple;
	bh=7CDc1VC0CSAebI99AQNCddLZByGdXXRGb5+F59BiEOM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hi3fSEW4ICGiisgF9yGsBX8s0pfHSZxGItZ7xMUXZHg6Hopx3Io+3NiKMzxrvnWHxZqa2eD2dJOXnQ4uUg/os4kVygaRFthYPpCWdiBv6hPkWDlcLEgI0kGGZbg+WdLHH/1aWZYAXRunbno1ehMRDzLyl7jNKCo+iFLtQkfNzbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qMU2SiHu; arc=none smtp.client-ip=209.85.215.172
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c8588ec1b44so395036a12.1
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 21:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781240332; x=1781845132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zVPVrX1hyAux39TAWqdA/40QGd90IV9ztdQhv1wsAhk=;
        b=qMU2SiHuZqqvTBjJbGiMIz3QK0WhcPktIfqjGppTovJBc1hhiqHStBIA20fK8Yb5XG
         KXq/sqSiemcPDY4k3RKPib01Hv0GraoS3t5M8PsObFFm+ASyjY2ZjDtHuhR8AcREH/+Y
         mlmqE62JYZciTj9YaYiVRZHMeH1wlgRZE5vLPpoN45OqmWWFRpwl/gNkI2u/XBcJxbc9
         f1NHhwhK5sWi5KCCdXDafotRwzE7b6j1Np4vOS6wja4TtgPvFpN3T3AV6qRflMo3APEW
         yLKst1ffOiMOpNKcVN7wEooKaogPwjbyMjp5nS8+IyBlMg/iZze+dX09ESpvdnmHJtR1
         DuBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781240332; x=1781845132;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zVPVrX1hyAux39TAWqdA/40QGd90IV9ztdQhv1wsAhk=;
        b=nk1bn+0Tb/nZGPSltgTQ/yxcThh6zZgRtztT5zNj6TbiEEcezdSmbzyDiNNWJHWR2+
         BUQCGT5jwmictf/ZL3pP2PVDOOhIDhiicQxpUGnQk8gszKer6QL9p3U7V9RoHmKZLK3l
         s6Z6dTk+zLVApMPautI9ZU2+1k5BtRxlWuPsr2WXqZYQKoTEuY5X9NfQJ/4zHxZ+XINC
         h8sS6tOIoXbTNQ5gyYubMADAPMyr7ppgPrpl9MCsJXp9PvMjHvEcCa/SdX9/dD0Ma40d
         gb8QG2ahMlrZEoLaGZKG06ZVhvj4eZQSNW2raf2XQkR5mtqazD+ggQciTVsZvzqfBP/x
         L1pg==
X-Gm-Message-State: AOJu0YzIHqc4w4RnGY63Xe+o79ao/SPpHQM+47dJzsDdjSxZYeOetaU9
	RHLLLR4Pe9aaCo/R39mTOCiqkx5UPl6B2LChHAGAy9jm0zbSWk4qes5hqYQGsaxyEQ==
X-Gm-Gg: Acq92OFXfvpk9Fg3bCTP7BNY0EZxax5NpGz0GEGIo7L4aeH3CqCyf2Qeq0+pDuJeBoH
	/Rgqcrh/6R6kkenQgrk9Nxo8A6e8xUxnAmhNIDKMIbNv0jnKZyqKmJjNLtxGiAOKBFDzwwvBVq8
	iHtLNBiCVeK9rRpiURHoEg7QcBWpixT8A6c/pljIEj2FiecrrIjEeNL7912uz47CsR/4jfLAWTJ
	NxC8xlqCkrbYFWGKxOgcIiAILdM1H6V+0X9FJR1SLMZISAPjFt+dpSTctq5tqZva0CTzrhHtdPN
	W8lx2Oqb9hVWvjws4NwN1k+7yDrumNHrByygdCfYyXW1qZaPU9xPzxz5iKXD9j5q+uCl3KbMaUK
	3fpuwDeaKvdmYjR/A6merwgWGwfDLMuwhstTf2kp2Avm91pAwFQlSrjHtqM1fgsYswrkvhF5qyK
	WpT6c/3WBNaEAM6BCDk22iBi1yY8W4V59I6e0dSgHqWRAvdflW/l5IQuatVRjsFPBisSc=
X-Received: by 2002:a05:6300:670a:b0:398:8870:b58f with SMTP id adf61e73a8af0-3b783eed793mr1561419637.14.1781240331842;
        Thu, 11 Jun 2026 21:58:51 -0700 (PDT)
Received: from raf.tailb4a862.ts.net ([153.124.163.116])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8665186aefsm817838a12.15.2026.06.11.21.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 21:58:51 -0700 (PDT)
From: Raf Dickson <rafdog35@gmail.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: pabeni@redhat.com,
	sgarzare@redhat.com,
	stefanha@redhat.com,
	bryan-bt.tan@broadcom.com,
	vishnu.dasa@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	leonardi@redhat.com,
	horms@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	Raf Dickson <rafdog35@gmail.com>
Subject: [PATCH net-next v2] vsock/vmci: use sk_acceptq_is_full() helper
Date: Fri, 12 Jun 2026 04:58:42 +0000
Message-ID: <20260612045842.122207-1-rafdog35@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,broadcom.com,kernel.org,google.com,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-298457-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:virtualization@lists.linux.dev,m:pabeni@redhat.com,m:sgarzare@redhat.com,m:stefanha@redhat.com,m:bryan-bt.tan@broadcom.com,m:vishnu.dasa@broadcom.com,m:bcm-kernel-feedback-list@broadcom.com,m:leonardi@redhat.com,m:horms@kernel.org,m:edumazet@google.com,m:kuba@kernel.org,m:rafdog35@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[rafdog35@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafdog35@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 79406676AEB

Replace the open-coded backlog check with sk_acceptq_is_full().
The helper uses > instead of >=, which is the correct comparison
per commit 64a146513f8f ("[NET]: Revert incorrect accept queue
backlog changes."), and adds READ_ONCE() for proper memory ordering.

Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Raf Dickson <rafdog35@gmail.com>
---
 net/vmw_vsock/hyperv_transport.c | 2 +-
 net/vmw_vsock/vmci_transport.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
index b3394946b2..e6adbc4701 100644
--- a/net/vmw_vsock/hyperv_transport.c
+++ b/net/vmw_vsock/hyperv_transport.c
@@ -323,7 +323,7 @@ static void hvs_open_connection(struct vmbus_channel *chan)
 		goto out;
 
 	if (conn_from_host) {
-		if (sk->sk_ack_backlog >= sk->sk_max_ack_backlog)
+		if (sk_acceptq_is_full(sk))
 			goto out;
 
 		new = vsock_create_connected(sk);
diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
index 91516488a7..56503bee31 100644
--- a/net/vmw_vsock/vmci_transport.c
+++ b/net/vmw_vsock/vmci_transport.c
@@ -1010,7 +1010,7 @@ static int vmci_transport_recv_listen(struct sock *sk,
 	 * reset.  Otherwise we create and initialize a child socket and reply
 	 * with a connection negotiation.
 	 */
-	if (sk->sk_ack_backlog >= sk->sk_max_ack_backlog) {
+	if (sk_acceptq_is_full(sk)) {
 		vmci_transport_reply_reset(pkt);
 		return -ECONNREFUSED;
 	}
-- 
2.54.0


