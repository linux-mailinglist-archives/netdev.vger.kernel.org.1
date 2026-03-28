Return-Path: <netdev+bounces-272780-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6EwqMmjxx2lMfQUAu9opvQ
	(envelope-from <netdev+bounces-272780-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 16:19:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF7334ED80
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 16:19:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B369B3052608
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 15:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE3234A3C5;
	Sat, 28 Mar 2026 15:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jwbkbQHL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD84033556E;
	Sat, 28 Mar 2026 15:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774711045; cv=none; b=IU2VpXR2r9DmzrmC4Or7romFhLOREZvDeRSLeiyXQ2ZCUlyzAd0tYelXR8G7BaSaWm317KVZNu4bKrgKRO4OE9aiGx8X8HSSYCwPr5Xpm1vlEWlvimUfATSSYWB923T9s3Iea52zytsd80577jUj5jJIfA9YjEGNQviiOpJdx+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774711045; c=relaxed/simple;
	bh=jiLVEzDzHDZPGnoP7mb55lkJ+Rbb62sBUfVjghFNLAI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c0iTd6y7pDkXsgF9nsBeVplf8LQaHGlJbT/B1S1FxnhS4WBPXZ8fgDV0Sda7AM87CZcoeO3GTJlWazpXRBH2zVbnb8P7dK9qIIahoR41gdG+2KJG8IiCSND/VpDWX2BNrauopukTFU1UxrlL8SCqoEMnU07Dl4RBEcYmASEF0KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jwbkbQHL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BDE2C2BC86;
	Sat, 28 Mar 2026 15:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774711045;
	bh=jiLVEzDzHDZPGnoP7mb55lkJ+Rbb62sBUfVjghFNLAI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jwbkbQHLG2zCOD9oVKv1dybwMzg5HORdk3d5SJpEHxmjst0fP8+hZXpc5Ij58/77Z
	 GjpK3vtyX6kgm/kJ6UVX8GqVstjSqRYVWQluCd1lRZJBhdV8XGwr24BD9Bg3Hdb0hV
	 3sNUJsVP3KXceCjQipI+MANGBqha3zyR7FUy1sVnFaeHIFVOifPGwQCdgGLqLpyQrp
	 C7VbQ+O2AcBIZ9QguQP9GXRuJuXkzG3kgyd2vFMysdcLwV+6aU76IJc7wp9oFJ7bry
	 PM+ta/KI4t5rgwfWTB6VqcGQUYTF3tnHFXFchJbzt7K3A7c+XqyYpg7VELfMqDrjEz
	 z8mfHbuKZS99w==
From: Chuck Lever <cel@kernel.org>
Date: Sat, 28 Mar 2026 11:17:12 -0400
Subject: [PATCH net-next v7 5/5] tls: Flush backlog before waiting for a
 new record
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260328-tls-read-sock-v7-5-15678415dfc1@oracle.com>
References: <20260328-tls-read-sock-v7-0-15678415dfc1@oracle.com>
In-Reply-To: <20260328-tls-read-sock-v7-0-15678415dfc1@oracle.com>
To: john.fastabend@gmail.com, kuba@kernel.org, sd@queasysnail.net
Cc: netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev, 
 Chuck Lever <chuck.lever@oracle.com>, Hannes Reinecke <hare@suse.de>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1346;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=zVo2aWZU16cWfzKR5efuUXrBNgjYfftgJHVqojqViVA=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBpx/EAv/cggZoCHhEPgArnxF4GpC6+wm32M1cng
 lhgmzTQMG2JAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCacfxAAAKCRAzarMzb2Z/
 l0ceD/wOrCxusF6VIV50QsnySaNSAQHrf3xKiygtiEV4BN1ufmzem7iTLvnhvLGFPqsL6sB4E75
 +SfRhdLCQvaXLsU93adk2jbhOVSvgsWm/TpeqcFL7xMGbJ3fbdRXKO8G6j02XxjDtjcN+pFcYkV
 XaYlPC+0RFpzxYt0dejM/OpRtFTEZP2xow1k3T/jGFS5tTsY+49i4VKRWBQonUWtCzE4OxJTG6n
 Kiq/Te32C+cBIEgSeYiubDkHxGT8FpxF2O7K/B/dljIFThVGptADCixKDOet30FRQbc5b6EoJ2D
 bqlHyB9WeoD17qwtojJcRZ+xCq6DamUVn8LtFuf/sUGBMpIXMGAbVM+qMo445BivfKd+2yiGmNE
 liobd+zov+KLskZ3wqqYN9MTbr5CpMqMN2kT9feC6AG53EYcaiUdYg6crDj9NDvAuPb0IAutRLF
 cS4rlyj6UsxtegVGZ3ROYaVAjiP6rTdN7tweHfzaZJiJDIZL9wQXi2HIqKBR13ZJOQlX7pgpBsr
 pZ27/qUduB8GaN6Tif7HNUhTfrtx3owCvfa8jK0fzj/DNlg9AXbzQcQvT/5J+uqQ/8LBbXW8Q+K
 HTBGcioL+pCjRw4arxnEw8xlwCKy9x7bqZyUMz2rwfskcTh7OH3PWEVSUIdbd4HEOmQhIzU53F6
 s0oCmhAes1cCnvA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272780-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,queasysnail.net];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,queasysnail.net:email,suse.de:email,oracle.com:email,oracle.com:mid]
X-Rspamd-Queue-Id: 2CF7334ED80
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
segments immediately. On the next loop iteration
tls_read_flush_backlog() may redundantly flush, but this
path is cold and the cost is negligible.

Suggested-by: Sabrina Dubroca <sd@queasysnail.net>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/tls/tls_sw.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 8fb2f2a93846..e15adf250d78 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1372,6 +1372,8 @@ tls_rx_rec_wait(struct sock *sk, struct sk_psock *psock, bool nonblock,
 		if (ret < 0)
 			return ret;
 
+		if (sk_flush_backlog(sk))
+			released = true;
 		if (!skb_queue_empty(&sk->sk_receive_queue)) {
 			/* Defer notification to the exit point;
 			 * this thread will consume the record

-- 
2.53.0


