Return-Path: <netdev+bounces-272077-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mAcdB147xWn/8AQAu9opvQ
	(envelope-from <netdev+bounces-272077-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 14:57:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA0933667D
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 14:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C3DF3084ACD
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 13:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D991E308F38;
	Thu, 26 Mar 2026 13:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QqBt9+1y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B624D306B31;
	Thu, 26 Mar 2026 13:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774533067; cv=none; b=TM4KWbHsqidZiTIbl6TWxXB6Betic+xg1aUGMUiwO1UaPMehWpmk8OLtMbmc+WDIzLQp8WuLZadf/BMTGI51VVvsbMU0E2Bw2YBwWIwKrDkB7GSjfc5rQqF4sCufEDZvVDdzjm1ez82vqK397Nko/nRGS6u2nVg+eMzh2bMKB8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774533067; c=relaxed/simple;
	bh=XRcp5CqcavXkypO6W1a54aqoK0QKIg7PMkm0IjwEUc4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f5GaRczVxQSIseQ/IqXnK4TCmoi6iu2qg+F7vsSde/qm1nljI8Lv3hRl0tibxDf3x1qkap4sQgL6orUnf8ud2V/ecKIk7yAsrRQRwLQLFC/mO9krPG4smZq3cuwiUBkmy20YXUg3L6pscu6MIm+BlnaOg+m7Iz/37TEa4SReN9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QqBt9+1y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00EAAC19424;
	Thu, 26 Mar 2026 13:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774533067;
	bh=XRcp5CqcavXkypO6W1a54aqoK0QKIg7PMkm0IjwEUc4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QqBt9+1y+I9stsaP3IrJvAJLmfpRaZho1FOd0IC2hxkoDVenuE/RNFRj2YWyiRJI2
	 AkLvuXs4M8USy6Sv9PWS7ZlO9zDoGmZZMjVYLSiAAWYT8hylvys+hlfzeGluC3/rLw
	 ZZDdx1hyBnwxdDDzbyss8ocR6MMyTFD86tCkOR3MeIdZ1zVm/OHdezKjL8RxFl2EbU
	 KKJc0xuVuEAaNjt1JHprNojFAC6WjpxXoAXV4UQP/o6rHXBAidxVuV/UgsgXBLtY4p
	 BYoIYrcIr1K05BPfAb619lBYtMKsvQFZhCqagETdjVctZLLupGhm2qi2IgB3DleDuF
	 wuytsr4Rc31uA==
From: Chuck Lever <cel@kernel.org>
Date: Thu, 26 Mar 2026 09:50:46 -0400
Subject: [PATCH net-next v6 1/6] tls: Purge async_hold in
 tls_decrypt_async_wait()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260326-tls-read-sock-v6-1-fd887b9e7f06@oracle.com>
References: <20260326-tls-read-sock-v6-0-fd887b9e7f06@oracle.com>
In-Reply-To: <20260326-tls-read-sock-v6-0-fd887b9e7f06@oracle.com>
To: john.fastabend@gmail.com, kuba@kernel.org, sd@queasysnail.net
Cc: netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev, 
 Chuck Lever <chuck.lever@oracle.com>, Hannes Reinecke <hare@suse.de>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1615;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=xu58UA/lURyxQjkJP5uUa+sAXuRxEVniz6m85Q5Af+Y=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBpxTnJZYZDe6/ZoQz7NuaMUwv3roZ72EsPGQAHX
 kO6XvwogMGJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCacU5yQAKCRAzarMzb2Z/
 l0tVD/4hpygJHM6+GhRj//R2D5lfvbu0vM1hqXDHXaDjrUbvSVahYN6aaQIcMJY6+1Y1nUwbhX7
 LOGHkTe9cBxgJMGY4cpXfxz/BkF+hZusm70U+yd4ZNJQ1uEW0j3fPgZIX62DiHoH1nyksZIxZnA
 jE3EY+DvS/yi43rcwLV/mRzANHq6mFF+nU1dJO1V6sIAtSBc3wvv8QsyYs+pURdeAUrWdVQdt9c
 ++xURNJVpyS+ZCiL4vaVHYx32p6ZHIgr8ZYnI48gpYcwY+MpxeDow4Z83EevY9vALoLT+u3deS7
 HdMMklZrZ+Fr+SaWQHVanZvNrE4safkyKtrdmgDr+Ob5ab5u0zi8Vws2LOGgmuC8XHpixCcIEa7
 Jv+hvVCY5/jGHZsaeN6rQ1ZAalhLdWQe+/xliPSzjziti1HGw/8ELBrm7DopJUcR6pyUnSQv0aL
 8ifgJ22QXyXaIQApETIkky9ING9u1joZCVYkaH0/dG+QC6mWVEr5/lXQCFW0z/yR/Xze4Gy69fK
 t65dkzHQZkHGyD1YxNf7Zb4kL4BWicB5PFwIQPeKjAM4wJeRIjZQB98FV32gNgKeto6zQuNRW8U
 kprtMfFbzU0zatxUkBAVA7pJEQ27xe+LYNSpc061Kimk51rJ0COp57WEeZ9GPkSRDNGOn6pE2hs
 bWZIror66mLs3tg==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272077-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,queasysnail.net];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email,oracle.com:mid,suse.de:email]
X-Rspamd-Queue-Id: 6EA0933667D
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

Reviewed-by: Hannes Reinecke <hare@suse.de>
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


