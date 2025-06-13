Return-Path: <netdev+bounces-197562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5745AAD9318
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 18:47:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E65557A74D6
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 16:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11E6214223;
	Fri, 13 Jun 2025 16:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s3Lbu2ik"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A874211476
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 16:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749833194; cv=none; b=LlsoLm2cqHhJ6xBjqn+KRJBR9fslyMz30nuubqZNN+4bB2jCzkE2F0UmgHbogTVSlZM31m3M9tfOAl6z5ZlTPMgwAShrZfG8rxWiI7EnWNeP2rKvnjTXNflD8NMZwHNwjPZGctLGBj8BxsIHc8F5p0bDL7OfvHNzD5o8wuz0enM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749833194; c=relaxed/simple;
	bh=StmQkCuI6SfUwilKBkOOD7d/aICBUBU2iqJfFkDtLqo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=hUd7AF4HcCHJRbcgMFdQjYbeu2vROz2B17TPp/kt11nM1tBrtgQcMllTJTN3MZwEyV7fwnNhesm0H9riUqXqB6IPiqgf/WCwC0zaaLs0xGN/s7XNJ0FHdaCpYIxbH0c3uLvH7dCHPKZyDkVCe3L1z1Zj5vP0O3m90ruMNn+Chu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s3Lbu2ik; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8186BC4CEF4;
	Fri, 13 Jun 2025 16:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749833194;
	bh=StmQkCuI6SfUwilKBkOOD7d/aICBUBU2iqJfFkDtLqo=;
	h=From:Date:Subject:To:Cc:From;
	b=s3Lbu2ikQuiYkDI2Qc2f5arAs3uU2hcySqpK37N7ZrL9DquQD1KCECg+cfBG2KPhM
	 4ts0L2v8/+IZ8ID4Cp5kEbLDj/jrPAUPhmEZ5UuJq1KolU+jRoSlqlAXyx9sG3684/
	 FrmDlW5a0IaD+FTBFYlzuChihpdQ1KTtumRJBLdGu6W28XX71stMYO21L1Li/voJVF
	 gzrzChB+Fm7wwir9D6mv9/EMGsAxVwlHFS8Au2V/ASnwwtGaygWjnJwZ93M1SpvkIx
	 bjxnd//rxuhG3x6gu7vFVYmg9K3hS7EZ1v6lQ9A6EcYUpZV9DzFhs6rQvEKpHYIoZS
	 FEP1QOKNMz2DQ==
From: Simon Horman <horms@kernel.org>
Date: Fri, 13 Jun 2025 17:46:20 +0100
Subject: [PATCH net] pldmfw: Select CRC32 when PLDMFW is selected
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250613-pldmfw-crc32-v1-1-f3fad109eee6@kernel.org>
X-B4-Tracking: v=1; b=H4sIANtVTGgC/x3MSwqAIBRG4a3EHSeY9t5KNAj9qwtloVFBtPek4
 Tc456EAzwjUJg95nBx4cxFZmpCZBzdBsI0mJVUhy0yLfbHreAnjjVaiLisgl00FbSkmu8fI97/
 ryOGg/n0/Vkp4w2MAAAA=
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>, 
 Eric Biggers <ebiggers@google.com>, Simon Horman <horms@kernel.org>, 
 netdev@vger.kernel.org
X-Mailer: b4 0.14.0

pldmfw calls crc32 code and depends on it being enabled, else
there is a link error as follows. So PLDMFW should select CRC32.

  lib/pldmfw/pldmfw.o: In function `pldmfw_flash_image':
  pldmfw.c:(.text+0x70f): undefined reference to `crc32_le_base'

This problem was introduced by commit b8265621f488 ("Add pldmfw library
for PLDM firmware update").

It manifests as of commit d69ea414c9b4 ("ice: implement device flash
update via devlink").

And is more likely to occur as of commit 9ad19171b6d6 ("lib/crc: remove
unnecessary prompt for CONFIG_CRC32 and drop 'default y'").

Found by chance while exercising builds based on tinyconfig.

Fixes: b8265621f488 ("Add pldmfw library for PLDM firmware update")
Signed-off-by: Simon Horman <horms@kernel.org>
---
 lib/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/Kconfig b/lib/Kconfig
index 6c1b8f184267..37db228f70a9 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -716,6 +716,7 @@ config GENERIC_LIB_DEVMEM_IS_ALLOWED
 
 config PLDMFW
 	bool
+	select CRC32
 	default n
 
 config ASN1_ENCODER


