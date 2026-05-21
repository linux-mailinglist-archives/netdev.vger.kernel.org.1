Return-Path: <netdev+bounces-290564-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AETiEEpAD2qcIQYAu9opvQ
	(envelope-from <netdev+bounces-290564-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 19:26:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A3BB85AA336
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 19:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE8523045DD8
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 16:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52967385D6B;
	Thu, 21 May 2026 16:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FAaxIeCY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5CA384CED
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 16:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779382448; cv=none; b=SUnoZaz3dh9toANiVpiiWCyWjePTXLAEk3VKqsu9KLVXpInEaL1l5h9n5gK5lNzyR+RpFo/Z3mffxHrOqnHymDx4GOfNU2LX+8sDuCBIeja56655oIZ/CMVmU5KSqjoTf6rD2qBpNFQdF65mQngqnM3mzaMcpW6K6BewOM2zHMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779382448; c=relaxed/simple;
	bh=jepHYHDTa1oN1HMbzfjCFYecBgYw0CAbnE+uP9SC7wQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dvBme7Q7Prh4dQhCFM5VSUOJ0VjvdhzYKW1MK/Vxio5Cbxj7jWgRK6RWG9UQAkKUM5UIPFAKHhBUUyKYwmyDBCbLKE1N65uZw1wyk+Ca7t01CEHNtEZm2hIF0CAqQPdvPQpE8QUGEOFzUtmzeeJFlKbW5EszftkJ3PREPc2N0P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FAaxIeCY; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3684a6f3b0bso3220618a91.1
        for <netdev@vger.kernel.org>; Thu, 21 May 2026 09:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779382446; x=1779987246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TZ3hB279QEnpQbR0KFTvz97dZDE5pAQRU4AviwCKwk8=;
        b=FAaxIeCYupyrzk95ZLGtkoFnGrKNyKkU1ZQj52wFlciQ6rMgrso8dHO/vMrxEV6fk/
         /eW3wwQTMrUtydKY2SVHIX2P6vyu55gKCLbBpjW+oR/c5+nBWJhwN0/gqamRZhUNG/Ad
         +P+XvVKd8XcT44tLDId5tDl1JMmiSK3uANkqyTXNRzJ39yPila5ilxbs+h+2SmHcfz21
         cC1pcTZ93dgzE/cxzPGAE6syC9dl2+x6ly1/X8NEm1a8FNDwKpf2S2B12lu3QeZBldUI
         MlA9QNUhk+cgJllTSwzXYdMNlsf3Spcg3QKgStf5WI3+uXqCckozyGgZQ54t+xgEwRmm
         mbEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779382446; x=1779987246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TZ3hB279QEnpQbR0KFTvz97dZDE5pAQRU4AviwCKwk8=;
        b=ETTeXkBe23rxHFbRya5rUvuIjkE60qO51jGgvf7SHP18bXKr5zSwLmZctX+ENx+8RU
         wlhocW1irSh0nmj7u4dWTvOOCH0Nd8JJQbnAwPX0ZEHxrU1wRWcZMiymPaXTGNm8jFKV
         YvtEEB46rVKz8jtI70XH7lCY9ngM1o5LY1QKhHM6zU2GUM91ZkHzhYrOhBFWRPwyJmGg
         K83ghHTyExpsdX4It+6mfxLrGvgjKVaWsGaEH8dbYhO/vRZZFVQoJJHJK4NfrNBgL+EH
         42uHQluvKDNjc4JEbz1mZ98Ggh5Mgi92RXXOGAhw9U5x4AFIwwCw7NPc79bb9D4EH8OZ
         PQyw==
X-Gm-Message-State: AOJu0Ywu0EJzxiFO7BcKoarylZKOWOPPGGkRg+67OQ0ziqsbLWV9yvVZ
	72pEGhiiTowwYGsD+JNRO1eyGyEzukkT37HkSIP6VLT6QgmkLUJNjaOy7bXN/Gij
X-Gm-Gg: Acq92OFCrR07gyhCwqRZJ0k/cDoke6EO0CUYhl9IO15lc/8cJffNiF6ntPbK6t0QwAZ
	A8nVua3AeBO1ySBwqOnWKDBc8esfyAXSc4dd/pm53WaFGvZ0vzovd97CZ5ewXDgHN2+sjfwyxv6
	Z2q74o9nZSTeHvJG5gD8In+r7iHrrHIQSU60YCAAHW3DhBFE7kWsvqrRLXQFe2OEOPpcuPITZki
	SHpQt2u+fvMnGY7jr7LqliivZ4EO3YFHPzrzCu9cQoqpb/OJEaY74+BJ5IOuNJEFSl6h7RcTgcU
	IMqIKTUdPnyFNABJiAAfMkRqK1QNL1QXKDIU+RdbMsbvKHw1djoPHrBt5EqCiHlT5aMJOGN9mqn
	ZIigYwJ4L3YjVyjGPKOZFe0e3lyB9T7oc5k6o4w6SBFpvYP/SIOZuL5RCpJnu4uL8UxJvgyAGNw
	y4XS3IqvYKwpO3dumM/6ANIcow
X-Received: by 2002:a17:90b:2fc6:b0:35b:d795:cf5d with SMTP id 98e67ed59e1d1-36a49029ebamr2766601a91.5.1779382446154;
        Thu, 21 May 2026 09:54:06 -0700 (PDT)
Received: from paeyz.Davolink ([49.172.60.165])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a3d2079bbsm2955723a91.15.2026.05.21.09.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 09:54:05 -0700 (PDT)
From: Yeonju Bae <iwasbaeyz@gmail.com>
To: netdev@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	security@kernel.org,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	sd@queasysnail.net,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	Yeonju Bae <iwasbaeyz@gmail.com>
Subject: [PATCH net] tls: avoid zc receive for file-backed pages
Date: Fri, 22 May 2026 01:53:28 +0900
Message-ID: <20260521165328.16112-1-iwasbaeyz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026052150-stylus-germicide-780e@gregkh>
References: <2026052150-stylus-germicide-780e@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,gmail.com,queasysnail.net,davemloft.net,google.com,redhat.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-290564-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[iwasbaeyz@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A3BB85AA336
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

kTLS RX zc decrypt writes unauthenticated AEAD output directly into
pages pinned from the recvmsg iterator via tls_setup_from_iter().
For MAP_SHARED, PROT_WRITE file-backed destinations, those pages are
live page-cache pages rather than anonymous copies: MAP_SHARED does not
trigger copy-on-write, so FOLL_WRITE returns the actual page-cache page.

crypto_aead_decrypt() writes CTR-mode decryption output into the
scatter-gather list before the authentication tag is verified.  If the
tag check fails (-EBADMSG), the plaintext-like output is already
resident in the page-cache page.  exit_free_pages() calls put_page()
without any content cleanup, so the modification persists through the
backing file.  An independent open(O_RDONLY)/read() of the same file
returns different content and its SHA-256 changes.  MAP_PRIVATE is safe
via COW; PROT_READ-only destinations fail at iov_iter_get_pages2()
before any decryption occurs.

Avoid zc receive for file-backed destination pages.  In
tls_setup_from_iter(), after iov_iter_get_pages2() pins pages, check
each page with folio_mapping(page_folio(page)).  If any pinned page is
file-backed (mapping != NULL), release the pinned pages and return
-EOPNOTSUPP.  Handle -EOPNOTSUPP in tls_decrypt_sw() by clearing
darg->zc and retrying, which causes tls_decrypt_sg() to allocate a
kernel bounce buffer instead.  Decryption output never reaches the
file-backed page; on tag failure the bounce buffer is discarded.

This follows the existing opportunistic zc retry pattern already used
for TLS 1.3 record type mismatches in tls_decrypt_sw().

Verified on linux-7.0-rc3 QEMU (x86-64), four destination types:
  MAP_SHARED+RW:   file_changed=0  (was 4077/4096 bytes before patch)
  MAP_PRIVATE+RW:  file_changed=0  (COW isolation; unchanged)
  anonymous heap:  no file backing  (unchanged)
  PROT_READ only:  file_changed=0  (EFAULT before decrypt; unchanged)

Signed-off-by: Yeonju Bae <iwasbaeyz@gmail.com>
---
 net/tls/tls_sw.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index a977b0434..c312a83b4 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -36,6 +36,7 @@
  */
 
 #include <linux/bug.h>
+#include <linux/pagemap.h>
 #include <linux/sched/signal.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
@@ -1443,6 +1444,34 @@ static int tls_setup_from_iter(struct iov_iter *from,
 
 		length -= copied;
 		size += copied;
+		/* Reject file-backed destination pages.  Writing unauthenticated
+		 * AEAD output into a page-cache page before tag verification
+		 * leaves the backing file modified even when recvmsg() returns
+		 * -EBADMSG.  Return -EOPNOTSUPP so the caller retries via the
+		 * non-ZC bounce-buffer path.
+		 */
+		{
+			ssize_t remain = copied;
+			size_t  off    = offset;
+			int     np = 0, j;
+
+			while (remain > 0) {
+				remain -= min_t(ssize_t, remain,
+						(ssize_t)(PAGE_SIZE - off));
+				off = 0;
+				np++;
+			}
+			for (j = 0; j < np; j++) {
+				if (folio_mapping(page_folio(pages[j]))) {
+					int k;
+
+					for (k = 0; k < np; k++)
+						put_page(pages[k]);
+					rc = -EOPNOTSUPP;
+					goto out;
+				}
+			}
+		}
 		while (copied) {
 			use = min_t(int, copied, PAGE_SIZE - offset);
 
@@ -1699,6 +1728,14 @@ tls_decrypt_sw(struct sock *sk, struct tls_context *tls_ctx,
 	if (err < 0) {
 		if (err == -EBADMSG)
 			TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSDECRYPTERROR);
+		if (err == -EOPNOTSUPP && darg->zc) {
+			/* tls_setup_from_iter detected file-backed destination
+			 * pages; retry without ZC via the bounce-buffer path.
+			 */
+			darg->zc = false;
+			TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSDECRYPTRETRY);
+			return tls_decrypt_sw(sk, tls_ctx, msg, darg);
+		}
 		return err;
 	}
 	/* keep going even for ->async, the code below is TLS 1.3 */
-- 
2.43.0


