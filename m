Return-Path: <netdev+bounces-205291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30887AFE106
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 09:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DA63188EA1A
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 07:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F6D26CE21;
	Wed,  9 Jul 2025 07:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EV7njd2/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B8526B2C5;
	Wed,  9 Jul 2025 07:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752045211; cv=none; b=r66L3+G9rVDnCu1vGclo+LvaGS/tJMTuhScJNhdbJDeHdMzEQvEniMZwkFqlKYCXdLFcuM1iE1fP0hDg5R0YvAIE6QEBii6IhvF+V10+GQdH/zJuTqEmYMyFvZVYK6J8aadSuR0Q34SMjuIeDgLj50535O+lFIyOR8CBH3I3HB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752045211; c=relaxed/simple;
	bh=3osnXgMgN4w/yYrJq+7RqfbP4IpmVhNsPMG9PZRUfxI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LaCF6F6uwVdmYG6HdHqPsQocsWG3AykJIANERxS5ArD2DwU2I+/CT4ujnKINudSFRVAJ+EPNLjz27BtwuxpEWKYP7HAJTM+1PVF2UeDd+Ocq4YeIBzw5JOyFzooP7IDVzlwhKUuPb1a6paygIBTGwlKXbm1wHNrTLwOsZoOLRwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EV7njd2/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7D11C4CEF0;
	Wed,  9 Jul 2025 07:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752045210;
	bh=3osnXgMgN4w/yYrJq+7RqfbP4IpmVhNsPMG9PZRUfxI=;
	h=From:To:Cc:Subject:Date:From;
	b=EV7njd2/g+DpHisyfHyFmUfvThN+qs6OFQEziryn6gOZAbOSU2t/uTAFo8ugwJIS4
	 JupHpzZOTURPdW+2VOq1i5lFXeXNm2HA6uT2YOUMoqqhEKNExkgTEfjj9nAG14xQix
	 2tyrrotI2MfWKoZ76+lNVJijVRsh9KbSMR/+a0FqFqdfmW0g8XerRoG4Us6U19Kieh
	 eXbqi6cq6F1Q+sldu9HRnm+WJH3+9TlnPDaSYkoXlZMyuvr7xmmTu1kiz5Ioj6fVAL
	 GHlxjcRpfz2HsObQeXWWIDUUzHpiglnxeL6XXU66eWI7Xo8eBCzAkwYuJCnqQDXhFw
	 hdtff1Kmzk7rA==
From: Eric Biggers <ebiggers@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: linux-crypto@vger.kernel.org,
	netdev@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH] crypto/krb5: Fix memory leak in krb5_test_one_prf()
Date: Wed,  9 Jul 2025 00:11:40 -0700
Message-ID: <20250709071140.99461-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a leak reported by kmemleak:

    unreferenced object 0xffff8880093bf7a0 (size 32):
      comm "swapper/0", pid 1, jiffies 4294877529
      hex dump (first 32 bytes):
        9d 18 86 16 f6 38 52 fe 86 91 5b b8 40 b4 a8 86  .....8R...[.@...
        ff 3e 6b b0 f8 19 b4 9b 89 33 93 d3 93 85 42 95  .>k......3....B.
      backtrace (crc 8ba12f3b):
        kmemleak_alloc+0x8d/0xa0
        __kmalloc_noprof+0x3cd/0x4d0
        prep_buf+0x36/0x70
        load_buf+0x10d/0x1c0
        krb5_test_one_prf+0x1e1/0x3c0
        krb5_selftest.cold+0x7c/0x54c
        crypto_krb5_init+0xd/0x20
        do_one_initcall+0xa5/0x230
        do_initcalls+0x213/0x250
        kernel_init_freeable+0x220/0x260
        kernel_init+0x1d/0x170
        ret_from_fork+0x301/0x410
        ret_from_fork_asm+0x1a/0x30

Fixes: fc0cf10c04f4 ("crypto/krb5: Implement crypto self-testing")
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 crypto/krb5/selftest.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/crypto/krb5/selftest.c b/crypto/krb5/selftest.c
index 2a81a6315a0d0..4519c572d37ef 100644
--- a/crypto/krb5/selftest.c
+++ b/crypto/krb5/selftest.c
@@ -150,10 +150,11 @@ static int krb5_test_one_prf(const struct krb5_prf_test *test)
 
 	ret = 0;
 
 out:
 	clear_buf(&result);
+	clear_buf(&prf);
 	clear_buf(&octet);
 	clear_buf(&key);
 	return ret;
 }
 

base-commit: 733923397fd95405a48f165c9b1fbc8c4b0a4681
-- 
2.50.1


