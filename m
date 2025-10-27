Return-Path: <netdev+bounces-233075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C643EC0BCCA
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 06:09:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 522F63B33FF
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 05:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CDA123B632;
	Mon, 27 Oct 2025 05:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aleRRhcY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1501198A11
	for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 05:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761541755; cv=none; b=VUANAuVFhc0U0WITiDO0bfF40WBAiCbAoVreOsEMpuMwE6irMJTOBjrIXhIaehngQeGuRjClqhDqZXrY44K8JF6F62qyPLRhV51OL/0sg+3VkKcajvttOPsFMi6zYanuEpN/ycBe6dVu4um8co7aaJvk1GZCYYIfk1xaQtNbAvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761541755; c=relaxed/simple;
	bh=OUqLcKZeL7sNozc0Va2ked5/A40+JIYc+5qBszOKEbY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jBdgcAsqZIruIxrFRnywXCft64c2o7OUyCSqkfwkpuPP14ZliUXSyN4ih2ZQ/rlHTDMm1EXPKyctDop2tPGlbtpOAM2NLIhbGjJz4o8kWCbtcjNbVVP7f3MRXiaGedrlnzhvOwFU4qnV7KViRikgjlWpM54yl2du0Tz89vpe6Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aleRRhcY; arc=none smtp.client-ip=209.85.215.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-b556284db11so3548920a12.0
        for <netdev@vger.kernel.org>; Sun, 26 Oct 2025 22:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761541753; x=1762146553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o0q0YaFBfANSAS3+T3VacFx8v2x4tPgl7we+mN7jZKc=;
        b=aleRRhcYHxFy0BNMmRIImR8E5/NzHSjv3T8BkE4ybprCTJaraUgK0xyx3aAlI3e+8s
         nVu7CQZMXbY5Vy06sNOKSwpY0Dj05vxxGHvJy92ODQw3E8ephIx9eXp4iJ8NmfVqp+1e
         D4dIkTalQGNQI2kQOfsKgGZ/LMzFyCdjCmquep5LG4B8tLU/XHDPfMw7cbkuD9W6WHd9
         uS4KliCVQsd4keggHjINPHxu7WRBYM1i8lveCZJ5qrUetnU4KQmu4YJlxLRdif+75XwF
         6OSWIMBqBZnt+vL0nsYPvRAR+UDp2uWqyrZlFSynk/wIgTo4kY6bcyGdVBZqqiPqCUKw
         LjMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761541753; x=1762146553;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o0q0YaFBfANSAS3+T3VacFx8v2x4tPgl7we+mN7jZKc=;
        b=UscSWYVWNnVvGf29RIAI1l3F4EpuFAUW6+RNxkZayGze9Gucbei120syurZxa51FmY
         Fzag/ODjEImQTf6hHsbsBRpTKLrwhDp93wA2Q1F5VjPtvw3RDSvfLlNXcaTd73tRhncN
         89j2tPVwyDVz1XTXK5KdgyXJFzrmqMOiymXXaFbmK6ohYoEtmrbJOjy/nqXdEFiDvsQ6
         b6OIVu00hvXCcRa6jawMCgnEA9lP/JAB+VD9srYrYLKSKA2MWx7DGk8KgdPkTRLV6Mxd
         /fAxJbwr8VPypUVIhtqtHybbo+naifMn7DJihEAXZnsEs4JGVigrIvSDc/7VbI2MamnU
         Z5/Q==
X-Gm-Message-State: AOJu0YwACjIsOxnWAhtcc8eQHkADVfmezTFBtwEYs5kx6TnkJMDfcXrx
	ISqjCNBUkDvTfkiDa4ITVR9uLk1rD5/agPRe4OgDWPcJQtB4DHJYVuc+
X-Gm-Gg: ASbGncslHGI3OPo4FXRCIko7DgDCEzhcmkhQo3JS9/k55vZ6kSv4KPt3qNyjuNuIBWq
	JHcx9pcU/bk/CPSkTZuR4pS3KXxg3F2pbcWJ7RBEyn75NlBMCVePk9+6lufLKafrYzDng9pUkae
	u5znwQEUv/zr5wIWnaEOhqlmQ89mpw4EXWH9De/ZRR0OHIExGF78D5VwylnY8nc+JT7bM7VlQc+
	ZhkRWHjGgWLR+HpACmDSZEt/ZcyXCLK2ms7JWi6QvQzak2LD0I7NMABCY4CxYgRf4MPBlH4Uyim
	g5E11Kep6/YwVU4wEjH7Uduag+rDRVHnictWA+ad3GtCT72U24iXUwLDR6K4ZGNtdp7I59oMH0l
	q1KBr2Vxyyr/nPIaLniuNVjpc42J+TYc7oDPwps9CvyfifdUy89WJtAiMVLOAwQ9GNIngTXS0kl
	oOXchiJ4kn+9y9wml55H8=
X-Google-Smtp-Source: AGHT+IGtH6XbDGJuGDFIuaox3wBmr6QQpVXy9N2GYRgtuZR8X9dTVLYjDB8WtOHQERgIjr6dDk9zog==
X-Received: by 2002:a17:902:ce8d:b0:272:a900:c42e with SMTP id d9443c01a7336-290caf850b1mr476300195ad.35.1761541752993;
        Sun, 26 Oct 2025 22:09:12 -0700 (PDT)
Received: from fedora ([103.120.31.122])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d23226sm67843525ad.49.2025.10.26.22.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 22:09:12 -0700 (PDT)
From: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
To: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Xing <kernelxing@tencent.com>
Cc: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
Subject: [PATCH] selftest: net: fix variable sized type not at the end of struct warnings
Date: Mon, 27 Oct 2025 10:38:56 +0530
Message-ID: <20251027050856.30270-1-ankitkhushwaha.linux@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some network selftests defined variable-sized types defined at the end of
struct causing -Wgnu-variable-sized-type-not-at-end warning.

warning:
timestamping.c:285:18: warning: field 'cm' with variable sized type 
'struct cmsghdr' not at the end of a struct or class is a GNU 
extension [-Wgnu-variable-sized-type-not-at-end]
  285 |                 struct cmsghdr cm;
      |                                ^

ipsec.c:835:5: warning: field 'u' with variable sized type 'union 
(unnamed union at ipsec.c:831:3)' not at the end of a struct or class 
is a GNU extension [-Wgnu-variable-sized-type-not-at-end]
  835 |                 } u;
      |                   ^

This patch move these field at the end of struct to fix these warnings.

Signed-off-by: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
---
 tools/testing/selftests/net/ipsec.c        | 2 +-
 tools/testing/selftests/net/timestamping.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/ipsec.c b/tools/testing/selftests/net/ipsec.c
index 0ccf484b1d9d..36083c8f884f 100644
--- a/tools/testing/selftests/net/ipsec.c
+++ b/tools/testing/selftests/net/ipsec.c
@@ -828,12 +828,12 @@ static int xfrm_state_pack_algo(struct nlmsghdr *nh, size_t req_sz,
 		struct xfrm_desc *desc)
 {
 	struct {
+		char buf[XFRM_ALGO_KEY_BUF_SIZE];
 		union {
 			struct xfrm_algo	alg;
 			struct xfrm_algo_aead	aead;
 			struct xfrm_algo_auth	auth;
 		} u;
-		char buf[XFRM_ALGO_KEY_BUF_SIZE];
 	} alg = {};
 	size_t alen, elen, clen, aelen;
 	unsigned short type;
diff --git a/tools/testing/selftests/net/timestamping.c b/tools/testing/selftests/net/timestamping.c
index 044bc0e9ed81..ad2be2143698 100644
--- a/tools/testing/selftests/net/timestamping.c
+++ b/tools/testing/selftests/net/timestamping.c
@@ -282,8 +282,8 @@ static void recvpacket(int sock, int recvmsg_flags,
 	struct iovec entry;
 	struct sockaddr_in from_addr;
 	struct {
-		struct cmsghdr cm;
 		char control[512];
+		struct cmsghdr cm;
 	} control;
 	int res;
 
-- 
2.51.0


