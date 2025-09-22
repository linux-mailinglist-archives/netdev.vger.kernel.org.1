Return-Path: <netdev+bounces-225189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC162B8FDF5
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 11:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B20F3B10AA
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 09:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97372FCBFD;
	Mon, 22 Sep 2025 09:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cSjQRYgR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EE92F5306
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 09:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758535041; cv=none; b=Qd5VYO7dJ4l4zGSEm1fjQVIAcOshLiSzaTrxFR7JM3Ggi514B81zEaCxoMpgb+2+0CWwi57MwRP3ZBn2NOsHUsfzYMtQ3cPNgc/aQgQ49uCDlxdNPEQgOXVLpLORbjzlmaGMNyrMLChcQvgShMNzEsSs2zPcwOdtbZLI6wmdSLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758535041; c=relaxed/simple;
	bh=S+Q0UlqD/yOrRSJIGfb5u6uGZIqc3pdLh2BJ3iR7hxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AgQmntNeAXU7Z8pIuVPG8D67qf1eXHb2ldVKQtK1DhxcjjZQEEkIWVuoj/LMWQwedPMM4bPEEcHxtld0OjB2BVrgQ9uiZ3jDU8Wogm6yRhHq6qbwjQFTkEbf2HSlB7xfeRA19KJiNjAB+nxUaagRFiQKagDqv4TaLvPNZ8GJu6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cSjQRYgR; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-77f32d99a97so725741b3a.1
        for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 02:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758535040; x=1759139840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aYcexrjT9oMNQ2zTTba9iviJV+dM9Fm3AQ2HPGb9wg4=;
        b=cSjQRYgRizXbzLyuXqAl3VBXHACBcG86ASnw0cvEtbNOa4x0hurPkWHo1XHx8DN+x4
         reeCf534XNSEzAbstpOjqkCsYQOpWMvc7TOE46N5FTlr4mMNci4c6Hi7QrVS/ClHo9lt
         gE9l0/ERvIo1839scbOhfBWfug9T/5eOriY/pOMl/Y7jw+hMRCPEaEpnIDoBn1gS/CLJ
         T6+6zbNlZO8gDFepTPQmdDeMbwt8F66lSlSYI3Pmt0aujNiZoURYPY477jBEZVFbk2QW
         QHj2mGd07YboFRWA5HtWxh7ahb7dLfHKmoJEXwL05gXmGv+9qPDDbzkaqH6ZbBf8ocpL
         lX8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758535040; x=1759139840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aYcexrjT9oMNQ2zTTba9iviJV+dM9Fm3AQ2HPGb9wg4=;
        b=gM8nbfkrb/GOBtVIAMMhZdcWv5sOsgPXI1U+y54HTvgbpXZ7I8pi/2YKjgUFMx4KcA
         qK4aGN74e2dblVGGaOEo4rwE1mCgTecRG256fZ4yH5cmFrpLuiXtOXb3QB0lCBoqcKou
         PrPDHuWL2PzYtwVTEremIrb1iP+URuCnJTbbdltFfo3VxpP63ldFSdbYyRYqmqMnSC+l
         W+uAOO+FqG91AZi8+xfcfX3dVcqCNR/3IAQA6ralqObTyAkkTvSOT6NLtSYslakV4ewf
         lYhlYQXCH7aDYOhGsLVXd2ojzBV704OQhmj264Jz5+MgcA2pCRWGZJMkZhzG4AFNmIQp
         j5mg==
X-Forwarded-Encrypted: i=1; AJvYcCUTQ2RXVBc8jIN0MpNxhi+fw5xm925lH+Cm8GiqEQaSJ+6o7NifAQW8Orf5LmeTp+hBDoPbLAU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJQQrE2eeb9uIB+CtPDdGD1rxWMDdBatA3o2d+v1O7qdyGyALm
	AKLn8+f+AEnx+AtNvTfWKcLv6HjvJqbNZ7Kx0CpIjaef56iCYwHlI3L1
X-Gm-Gg: ASbGncvKdo9z4qxzpfByr6eT9hz4zc/fuehoxqbzF/oF7mqyn7hIX4GmOlnLQ/puaVH
	7+nHgjmUOajwFk/QOgemLx4bvwq3IRbcgxEubrh0/VrFNErKVQCMhaU0gs2uCTpGybokR5Cq70F
	mz53emIfKSPtUS1Nxu60Z6a/b1L6v33EGe9dXhF82vbZrq1CEESWJL9QeRmqzjAyyurAjQ3cvyZ
	o7pYvwvBhyN3b8FQBR6Dy93no7jWqxFC0wfqTXMiZPswY/AyZ4BR6hNn4kiiFfAm7j+bqb2OsLI
	6WL85mrMCJ1+6d1i+5W7jT+6PL/4j6sL28boyFtYPWJtD6rNKe+GL7tZ39vMF0rlDGEPurUKw/t
	4MxQj+3vDVSM8gHGhvmNwrA==
X-Google-Smtp-Source: AGHT+IGt6VdD/zJs3dt3onXnNRO7yJcnwYHosBGX9WJgGC7ll5N69AWCopn4UpTK3hDtx6RI9iclCw==
X-Received: by 2002:a05:6a00:1797:b0:77f:4a83:8fe with SMTP id d2e1a72fcca58-77f4a8310dfmr249943b3a.13.1758535039573;
        Mon, 22 Sep 2025 02:57:19 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77f097b60e7sm7961552b3a.1.2025.09.22.02.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 02:57:18 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id ECA2841A2EE0; Mon, 22 Sep 2025 16:57:15 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH net-next 3/3] net: dns_resolver: Fix request-key cross-reference
Date: Mon, 22 Sep 2025 16:56:48 +0700
Message-ID: <20250922095647.38390-5-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250922095647.38390-2-bagasdotme@gmail.com>
References: <20250922095647.38390-2-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1097; i=bagasdotme@gmail.com; h=from:subject; bh=S+Q0UlqD/yOrRSJIGfb5u6uGZIqc3pdLh2BJ3iR7hxU=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBkXZbZeXsnslR+33fJX9cebXYVqiotOqD5alrU3TOfN0 UnPtT9odpSyMIhxMciKKbJMSuRrOr3LSORC+1pHmDmsTCBDGLg4BWAi61wYGW4k89W1Sx6rb1qb /1bN/VPei3PPZX+5hqzOvm7cUh2oeZeRYUXD4/onB5trd/ZE8+idU3+bffDL3xnKTHtNLi5nDVp bygsA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Link to "Key Request Service" docs uses file:// scheme instead due to
angled brackets markup. Fix it to proper cross-reference.

Fixes: 3db38ed76890 ("doc: ReSTify keys-request-key.txt")
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/networking/dns_resolver.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/networking/dns_resolver.rst b/Documentation/networking/dns_resolver.rst
index 329fb21d005ccd..18c2af83d5129c 100644
--- a/Documentation/networking/dns_resolver.rst
+++ b/Documentation/networking/dns_resolver.rst
@@ -141,8 +141,8 @@ the key will be discarded and recreated when the data it holds has expired.
 dns_query() returns a copy of the value attached to the key, or an error if
 that is indicated instead.
 
-See <file:Documentation/security/keys/request-key.rst> for further
-information about request-key function.
+See Documentation/security/keys/request-key.rst for further information about
+request-key function.
 
 
 Debugging
-- 
An old man doll... just what I always wanted! - Clara


