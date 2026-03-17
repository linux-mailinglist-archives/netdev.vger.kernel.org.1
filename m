Return-Path: <netdev+bounces-268646-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MDRnArlvuWm8EgIAu9opvQ
	(envelope-from <netdev+bounces-268646-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 16:14:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 067252ACC36
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 16:13:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ECC2D30299F7
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 15:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E433EC2D8;
	Tue, 17 Mar 2026 15:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZsRMzGav"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DB73EB809;
	Tue, 17 Mar 2026 15:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773759889; cv=none; b=QuKeUj4ZS8Ev3SbFvktqrjmzHxPsV/5ehmXDAk+RVUR8jNaytke8L4zz3uNScQHCVzUk4IGfxGebIFA00QTYBESRNoAGa98T7n+1rzX6ojp4d+bSKJ4V8tYqXV1beZesL7lOpUTtdVue8uRiLu6Zh/PAtHMqOQRWy6g73Ad8jv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773759889; c=relaxed/simple;
	bh=0p7Kf+NV/n16MFyyoUjIUH7j7L4rTnj8MMcw4ZmNx8Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TZNEoHQ58gwvOpgdOoI3YzfmkNTx7/8jDe59mhOoixoeyyL9wsKvbmEH8ucrn9pvhHDRf72j7DPtbt+MBliGOhLr424dTMe17EFaapJYsIBuEQVTFiCCeqcZ2MTCE8/iC2IsRs3R9Iqo4P1h0n2NasZ/WQhnJ0Jj2BbgS4nwVY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZsRMzGav; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6605CC2BC86;
	Tue, 17 Mar 2026 15:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773759889;
	bh=0p7Kf+NV/n16MFyyoUjIUH7j7L4rTnj8MMcw4ZmNx8Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZsRMzGavOjTeP/1J6DptAkRydg73BrlIW8UXC85MYaQr3HhqL8ELSaMO/bP13bBR4
	 t4ijiHhrIytBpLp+yLTTsjR85AgpDdfrpoyZbUR35LX+He3ZHfDqne8Wm0KBVVOQEW
	 WhYU+Sgn7wWKz43up4n14WMozdJlZR9qZHZf8zFL6loKwxtG3GctDcoHyJHPXDIMiw
	 RtDcSroQdqnW+C6n4phT4YiijJ1ESBNyw9AQAAs8/RK67olU3zTWWnWbcnEwdv9wUf
	 Oz29uiBJF7BXbuUpugknhoJIOV+NMZElwc4ts/f6/P8GZVYX8b6PTEGr/V+RBevvrY
	 xkr/yH21kI4qA==
From: Chuck Lever <cel@kernel.org>
Date: Tue, 17 Mar 2026 11:04:19 -0400
Subject: [PATCH PATCH net-next v4 6/8] tls: Flush backlog before waiting
 for a new record
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260317-tls-read-sock-v4-6-ab1086ec600f@oracle.com>
References: <20260317-tls-read-sock-v4-0-ab1086ec600f@oracle.com>
In-Reply-To: <20260317-tls-read-sock-v4-0-ab1086ec600f@oracle.com>
To: john.fastabend@gmail.com, kuba@kernel.org, sd@queasysnail.net
Cc: netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev, 
 Chuck Lever <chuck.lever@oracle.com>, Hannes Reinecke <hare@suse.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1268;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=mv1RaBsEA73TTETa6Ymw/SWiDPjcBHDZ3YzFXbS8AMY=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBpuW2KtmXUBSEie0M4ulPxl5qQUS7Fctjwbg+Zv
 f412G7eKIWJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCabltigAKCRAzarMzb2Z/
 lwiOEACzhv1eDvaGlI0dYyyAXctEIq+VMPxohDrHVLuxOlzvDR22xmMeRFq3FD5/yM9RXCnKT8p
 J2xEZ+IpbFSTy8mh46QindAkAMXYWaiyjtQ0TZvocFd9d1b8gFwUTC4aebCozVc6mycqbeVppVl
 QnJIRDo5wYV0HrnCi81jDPjDx2rI5djxiqTtWK5RBX0r5OQNeUW3EtKs8lOOMs0FWd20gEPto/T
 TuYumuVD7xge0Q11eQWbduvbzMyYri+rzDr9zK4a71ze80oTjXeioGM4e22dv+g7GDb00r5w9qm
 /B0yej04DlJcazlqOE652OrUx4urzMibPrz6yWtpIHaD/JSgI+5n+LoIIRbQBZ01y0ALDSvB9HL
 BCzXYXR642R4cYpigi05MLqz+Onm4GV7AmlOSQDZsHNBH7VRNfNbWvOHpSxv1i5bGm0RCRosi8j
 UcjDZIpXL/7qkqdMhxcHr6+VDeidI6g4F/r2xMxULOBihUYI1yIgveKGvm0D8xVwbVMpmbJ67T7
 FMbtSFkJpLcx7B26WDFKV/crjyAm0d5gkARRjI+xTyx3Ps0THoF0nDsGbkqKY62vYKzo22bLmw7
 vFmlO8VfhBkLrAx1JQo3FBRQ+MFg8efah3x91uq+as+vPuxuFTV9JLHcLq4QhwLepvaUrz/D9vQ
 8fRFJo0H51kqgfA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268646-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,queasysnail.net];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[queasysnail.net:email,oracle.com:email,oracle.com:mid,suse.de:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 067252ACC36
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

While lock_sock is held, incoming TCP segments land on
sk->sk_backlog rather than sk->sk_receive_queue.
tls_rx_rec_wait() inspects only sk_receive_queue, so
backlog data remains invisible. For non-blocking callers
(read_sock, and recvmsg or splice_read with MSG_DONTWAIT)
this causes a spurious -EAGAIN. For blocking callers it
forces an unnecessary sleep/wakeup cycle.

Flush the backlog inside tls_rx_rec_wait() before checking
sk_receive_queue so the strparser can parse newly-arrived
segments immediately.

Suggested-by: Sabrina Dubroca <sd@queasysnail.net>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/tls/tls_sw.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 381a723b6cacc669e333752af34f051f296d6f52..5b154afbd7ac2ddd51b46d8d6bef0a7a41f0a841 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1383,6 +1383,7 @@ tls_rx_rec_wait(struct sock *sk, struct sk_psock *psock, bool nonblock,
 		if (ret < 0)
 			return ret;
 
+		sk_flush_backlog(sk);
 		if (!skb_queue_empty(&sk->sk_receive_queue)) {
 			/* tls_strp_check_rcv() is called at each receive
 			 * path's exit before the socket lock is released.

-- 
2.53.0


