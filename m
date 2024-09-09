Return-Path: <netdev+bounces-126691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F6239723A3
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 22:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92D122836E2
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 20:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725CE18A954;
	Mon,  9 Sep 2024 20:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="bxEI4ire"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34C218A939
	for <netdev@vger.kernel.org>; Mon,  9 Sep 2024 20:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725913678; cv=none; b=PR9rIoOiq7YL6rvHDtwzxDVv6eTQZZ7dDaOlppjdMbFHua9SC/sEwR4p51W6tQh1O2PnAHfRSQar7WBszD0UWjEqeZFqGc5t9hvTps+ZxOkOnQ9xjyZiNKdiIqvgjGXr3Mhukm3+kuzsIEJzskhgMHSVVyyAltF7FbYp2UNj740=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725913678; c=relaxed/simple;
	bh=NfSezVbqpVPh3z734Wfe0yOT2S2BDv3q5d4evui9eHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rHKiU3A79bRa9u+Wq6oEUDFqixapXZGJkY5COTNX/yFo0vvl46wrA825KXu5TxORChvL+Q+vWtXCg0cXegxsn7Z5kZLvUX0MPVlLA6iUJDIq0kR0aBqH3S2X4Z3htfv33DrIatfMTAruwxhwbvU10Byebb5/+jU8qF80QtiE/w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=bxEI4ire; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3e04b7b3c6dso434366b6e.2
        for <netdev@vger.kernel.org>; Mon, 09 Sep 2024 13:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1725913676; x=1726518476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=00kPR+cauuf6XV+1sL3yq8G8B46prJwufLkaH1X+q4s=;
        b=bxEI4ire1dF2Q2VQyV0D/7MxQ8X92RHXGpItzzXhs/5cxXDE6CqecnTnbX3WldoUfK
         SDpBSJy3jZWfhK173NMGjXd2rz/x+LVNdmC+SL9SoEAmOtcIsBnDS8C11YOHQb/JOt19
         q7DIbYOl5uUojbcn6exkPEqeQenPqxBWbNa9Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725913676; x=1726518476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=00kPR+cauuf6XV+1sL3yq8G8B46prJwufLkaH1X+q4s=;
        b=XC9n24Vfpx6EDjz2GeW3s68mPE2gEdSLSh/YywrGLReNTxRujOH8bT/pEFqTYcTKUw
         kDJrTxI/mxBFKeBQgasI6DEKm9Ml6vQbAQSn2O7Ibr8mPNSUKVc5Xx4JjXbyVcWOw89S
         fPI8ARnKTBNife3OfYkS/c0WLtL6H5q051HNt4nZfSITfPHfYgoq+4ktRNFyjrfOPUmX
         Q2NA8ObbI/BLDZoLWNufF7hdbKco/1KpeQqfNsNqss6oQS6mS3cD+C4W7aAUSOOUOQx5
         BbtswDZpYvDN958ZsxFrAR9M0Orw9MpYQj5vGsChx6rGO8ATaDi2gQIXfrEO9qIXpZh6
         5Oww==
X-Gm-Message-State: AOJu0Ywiu9fMVmKaFv/FlWM1NzmTDogu9UA/MdOuMz23UYncExN+j4av
	2tnev4AKeFkHDXnx/T+AeKOj9TPzhMhsyIecq2n1E7rQ8R5f2iUbol5kvQUyLA==
X-Google-Smtp-Source: AGHT+IGSwqrqwJVSY+PDJ0na4ow1TTzjAvCAZM1R/eZsXXTzH+FsGUYcjZHR3uKx2LmnsgrMcaLVOw==
X-Received: by 2002:a05:6808:bd3:b0:3e0:473f:58bc with SMTP id 5614622812f47-3e0473f5e82mr3694549b6e.17.1725913675680;
        Mon, 09 Sep 2024 13:27:55 -0700 (PDT)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d8259bccbcsm4427640a12.79.2024.09.09.13.27.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Sep 2024 13:27:55 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	gospo@broadcom.com,
	selvin.xavier@broadcom.com,
	pavan.chebbi@broadcom.com
Subject: [PATCH net-next 3/3] bnxt_en: resize bnxt_irq name field to fit format string
Date: Mon,  9 Sep 2024 13:27:37 -0700
Message-ID: <20240909202737.93852-4-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20240909202737.93852-1-michael.chan@broadcom.com>
References: <20240909202737.93852-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Edwin Peer <edwin.peer@broadcom.com>

The name field of struct bnxt_irq is written using snprintf in
bnxt_setup_msix(). Make the field large enough to fit the maximal
formatted string to prevent truncation.  Truncated IRQ names are
less meaningful to the user.  For example, "enp4s0f0np0-TxRx-0"
gets truncated to "enp4s0f0np0-TxRx-" with the existing code.

Make sure we have space for the extra characters added to the IRQ
names:

  - the characters introduced by the static format string: hyphens
  - the maximal static substituted ring type string: "TxRx"
  - the maximum length of an integer formatted as a string, even
    though reasonable ring numbers would never be as long as this.

Signed-off-by: Edwin Peer <edwin.peer@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 3b805ed433ed..69231e85140b 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1217,12 +1217,15 @@ struct bnxt_napi {
 	bool			in_reset;
 };
 
+/* "TxRx", 2 hypens, plus maximum integer */
+#define BNXT_IRQ_NAME_EXTRA	17
+
 struct bnxt_irq {
 	irq_handler_t	handler;
 	unsigned int	vector;
 	u8		requested:1;
 	u8		have_cpumask:1;
-	char		name[IFNAMSIZ + 2];
+	char		name[IFNAMSIZ + BNXT_IRQ_NAME_EXTRA];
 	cpumask_var_t	cpu_mask;
 };
 
-- 
2.30.1


