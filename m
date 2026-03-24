Return-Path: <netdev+bounces-271056-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gLjMJ4+MwmlvewQAu9opvQ
	(envelope-from <netdev+bounces-271056-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 14:07:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id ED525308EC4
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 14:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 99025301C58A
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 12:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701783F9F20;
	Tue, 24 Mar 2026 12:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OaXb7oZd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF9A3F99FD;
	Tue, 24 Mar 2026 12:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774356841; cv=none; b=kDkXKiPBXZpNth6WrVpNsgOK7uBuemfcuFEBsTrhH+jmWImYqQiCCNpGNcg36LJ/2r5Rzc5j+rtnCz6TmHXFZd5xkdj1eWUo/PRepxqMVAJVo884CwtlOSb81DcwrNeKMD6QX7x/ZlArw6jXwdrM8RI3dfFIu8Jsyi8Aw2fhFAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774356841; c=relaxed/simple;
	bh=Yz6xojwsT7762OAOS0I6TPnqnVlgRkjNDlAjqN1w6IA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dcLMoUZQj0q8NLzWnQaL3XlbQQNBZdU6SbU5ZGklff/al617TBaekKx7BsDKNZzbE3Yfs6TBPOF62XJMig0g3bW4NLDoXmu9lHbM9lrdAUx1zrDtfpGPKwwnLAjFZNruLQiY8N48A7D23hD7s4Bg8oluez0LUhd/ueMeNzR3cvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OaXb7oZd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0D9CC2BCB2;
	Tue, 24 Mar 2026 12:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774356841;
	bh=Yz6xojwsT7762OAOS0I6TPnqnVlgRkjNDlAjqN1w6IA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OaXb7oZdB+Ke9jmGfQZvIFhNoMiZnoqDObH7OiqV16XFnviS25ciPLyJVNvR0LcY4
	 cdR5W7HdlcC/easZomtYG2cT5sD4/cwWoVarEgYzPsMdakXQ3GeW2RDDYS387MlwEQ
	 APO7wcLgoS1qfDUa41zKSA6W2TT41S4A9d5i4il0BQMWuteLygxOnGxh0vvJrrujSr
	 9FXA06WzMR+jwjtECeAvkkTechk0WdxAGWD4u3YjLwpuz4I+HuU1YKGFQ4vZsZyXKH
	 utNtJ9xXz210C2hFG+Z6bnAmYJe9d1ihhtj+9cC3pNvXIfju4MMB3mhapCqSh7OhNQ
	 Gb4SQd/wKRoFw==
From: Chuck Lever <cel@kernel.org>
Date: Tue, 24 Mar 2026 08:53:23 -0400
Subject: [PATCH net-next v5 1/6] tls: Purge async_hold in
 tls_decrypt_async_wait()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260324-tls-read-sock-v5-1-5408befe5774@oracle.com>
References: <20260324-tls-read-sock-v5-0-5408befe5774@oracle.com>
In-Reply-To: <20260324-tls-read-sock-v5-0-5408befe5774@oracle.com>
To: john.fastabend@gmail.com, kuba@kernel.org, sd@queasysnail.net
Cc: netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev, 
 Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1570;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=HaVcCSsGpRoxWGxuztDuAGxd2M3ADb2mQyaeUkczq8s=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBpwolnvqTkH3bjRBseeWAkkdbuGBxzVCRPdbtYX
 81iWdLuprqJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCacKJZwAKCRAzarMzb2Z/
 lw1+D/9/LiJO2ui6h0NTDXbyISC2iYLf/3vBs+f+G0RmstLkdmJXiHmnKQLFbj2Qp+Ohu3+Yl5d
 hVsnIU81rOxBozYWj5XOe3PWQvrFsJMvXPX9PnAr16dJowtACFKIMxWC85UpgsZLoejRw0IViC/
 zMJYi9CF90hCBphZIcKr7BJErp/VYaX64Sjxi3Co6IzouxCMK4tDvXbw7vCyXJ2xocFZ0xhenZD
 alUCOe3CwqZjBdmKVmGOIyufcU+su11MUcrzgrmV6d3NwXZZzN0/HnClrUCbcIjQeYyHbQo9QnD
 dx1BVzB/AIOV+1BvlZQPn40eaKqTkAdXl1yEkHSPNfd6IOPY+8lXLewXugTjaXBpjZa8+DH1LsD
 fQ2/xMAUn8blmvEJXL1jisrNHDyc8oSr3omz2GYy3lszx+vkS8G8GIE6p1kjVPoTy2kvrWYSXkO
 zsqI6hhbtjzZdkkPDsPkpPS3V9EqowEfVYPohnBonpjTmQEDAqSFe6/ZptXyG+pOuYwqVm4irus
 xY4qTHeVgbhnlB6nuf0Z6c3L1XGDxs11B2Et8M+wYJPp0huT+B4KE8cvfDhdIMuWlwiW6cWde19
 wn3SyBNivn/YsR95QeiSJD2SmLk7yTowiJvgRCGR2ae409oa0J/Sp+aUhpccVj/6bGkTCluVwJ7
 mJ38Z7MyQjTCwsw==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271056-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,queasysnail.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oracle.com:email,oracle.com:mid]
X-Rspamd-Queue-Id: ED525308EC4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

The async_hold queue pins encrypted input skbs while
the AEAD engine references their scatterlist data. Once
tls_decrypt_async_wait() returns, every AEAD operation
has completed and the engine no longer references those
skbs, so they can be freed unconditionally.

A subsequent patch adds batch async decryption to
tls_sw_read_sock(), introducing a new call site that
must drain pending AEAD operations and release held
skbs. Move __skb_queue_purge(&ctx->async_hold) into
tls_decrypt_async_wait() so the purge is centralized
and every caller -- recvmsg's drain path, the -EBUSY
fallback in tls_do_decryption(), and the new read_sock
batch path -- releases held skbs on synchronization
without each site managing the purge independently.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/tls/tls_sw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index a656ce235758..20f8fc84c5f5 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -246,6 +246,7 @@ static int tls_decrypt_async_wait(struct tls_sw_context_rx *ctx)
 		crypto_wait_req(-EINPROGRESS, &ctx->async_wait);
 	atomic_inc(&ctx->decrypt_pending);
 
+	__skb_queue_purge(&ctx->async_hold);
 	return ctx->async_wait.err;
 }
 
@@ -2224,7 +2225,6 @@ int tls_sw_recvmsg(struct sock *sk,
 
 		/* Wait for all previously submitted records to be decrypted */
 		ret = tls_decrypt_async_wait(ctx);
-		__skb_queue_purge(&ctx->async_hold);
 
 		if (ret) {
 			if (err >= 0 || err == -EINPROGRESS)

-- 
2.53.0


