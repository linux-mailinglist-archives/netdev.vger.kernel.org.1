Return-Path: <netdev+bounces-152310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F29D9F3601
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 17:29:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5945B1666BB
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 16:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A53D205ADD;
	Mon, 16 Dec 2024 16:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YEXKbdiG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F81206F12
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 16:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734366469; cv=none; b=s+dozbcQZbDpiKxk+4mekjQbmXXwlNv7qsrwvacq7pNzLlTnuzgxtfcGcnasVT9+yGFx9L+H2TXoqrnmlGhDO8ALmx26yo0utCZY9pMHce6bYJJYOT0sPj1RLTyn/z43ny8NsAHp9V4liu1oWUugiqPaiKCuH+G7EhQ4LE5uLXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734366469; c=relaxed/simple;
	bh=HWXJI55Bbef5Ohuw0UPjmcWf0sUSE1PZpO0/NCDoUBg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=h5hhiUwjU/31yyaNvzjfGxVIZ3qkc2+Mr894seXY6rul0t4ZPhuMrPGLHPwfC9/N5WXI2G523KPY93nWaUFa9vGmo1V0BGIgQ6oiFhz+aQbD4eptoSq09da4fHk50rqaxSCjYHaowWzQCHVj78Cu6UPOw2pyRs4RjwaszusRawU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--brianvv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YEXKbdiG; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--brianvv.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ef91d5c863so4047859a91.2
        for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 08:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734366467; x=1734971267; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OMUA0aQKK7WEbAxFgPhIKVdu3gMaz4/z872qXRxIgaM=;
        b=YEXKbdiGLG7vtwUi8FH/vfQeC4QPTgYyHLgPoexplvjBxvRzlzDCNCqBzmDPDCpN/m
         AkLNcqpqJKL054iUGRLzjR4SxC0VNGArhopjDTXgs+F7MMLtNJDmT9pnRPG0ArRZA96k
         9EFwRFw8ZkWjOT7uBY3zXM5bX3clJrAsuKJLMwtnhI9nXqaFW7GxNL0ADqWj6sjIBHNZ
         ftDoWNjkY5xckfkRxpV6ziYP6wcRmShSPnQNjpCKdUkz0qmTEhGi8HK116vhagzWte9h
         FTYMEkTYWznTG2kjzW6+0SmJLJ8hvl2q2QXUmrI4YRm/Z02hH7kwPrrMOvslKX6j+qUp
         XASw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734366467; x=1734971267;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OMUA0aQKK7WEbAxFgPhIKVdu3gMaz4/z872qXRxIgaM=;
        b=Sxd53wKuNe9a7rbE8dE59ZXHlYLwG2NiX5nssS/YBsdA0QbAxTnE60/C5t86wIqn+z
         wetzoRCejIhkMrU2yAm0p5B27ZdfvzEMhNSsw8w3sdvEexYo3/Mqhf2ym8lKEd2/bOKu
         RLsHC+PKG8lQk8yTi/zfRj5mz034NBsiJDp3WBJB4lMzTeqsE+CeonsZ3P2+9b2Tx7o7
         NABbahSnQuVxMtZ+0wtJH1cry9Hr/Oi2bg6Gbn05T0NzO00AIhN250uVKYq7+4an6HlC
         QEYsMJ4BjXCfx/zknFh2fpSh1iWKhW3Tt2XPmOSpqKGSXrLsqqWapCJYIWM+4uDQ9wY9
         GJxg==
X-Forwarded-Encrypted: i=1; AJvYcCX+2Q2LA874Vwg1CqY2Y+E23UMF624uZNNQkibrpVRzYCY+5qDFAkjpiwOWWkHsSbLNpEn1KFo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNZ6210qo2PXolBCzMg/FS90cefyh+i76o5kaclQZ5hyog1U28
	IG5GQ3D9U5nGQNTUIVF+YxLeAM1HSTQTnEXppkMp1tmwFDdZN35AbWumoCKP71vbswL/uxNbJMF
	o3T1WZA==
X-Google-Smtp-Source: AGHT+IH29wLjTLhFYC5SnJVDS+4WNLF1Yk10O+SW6jqm4mnWBwmXUCgH4x75maTCI76khncZvMc7FTYlHAjY
X-Received: from pjtd4.prod.google.com ([2002:a17:90b:44:b0:2ef:95f4:4619])
 (user=brianvv job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1b47:b0:2ee:c797:e276
 with SMTP id 98e67ed59e1d1-2f28f864a29mr21028983a91.0.1734366467107; Mon, 16
 Dec 2024 08:27:47 -0800 (PST)
Date: Mon, 16 Dec 2024 16:27:33 +0000
In-Reply-To: <20241216162735.2047544-1-brianvv@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241216162735.2047544-1-brianvv@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241216162735.2047544-2-brianvv@google.com>
Subject: [iwl-next PATCH v4 1/3] idpf: Acquire the lock before accessing the xn->salt
From: Brian Vazquez <brianvv@google.com>
To: Brian Vazquez <brianvv.kernel@gmail.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	intel-wired-lan@lists.osuosl.org
Cc: David Decotigny <decot@google.com>, Vivek Kumar <vivekmr@google.com>, 
	Anjali Singhai <anjali.singhai@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	emil.s.tantilov@intel.com, Manoj Vishwanathan <manojvishy@google.com>, 
	Brian Vazquez <brianvv@google.com>, Jacob Keller <jacob.e.keller@intel.com>, 
	Pavan Kumar Linga <pavan.kumar.linga@intel.com>
Content-Type: text/plain; charset="UTF-8"

From: Manoj Vishwanathan <manojvishy@google.com>

The transaction salt was being accessed before acquiring the
idpf_vc_xn_lock when idpf has to forward the virtchnl reply.

Fixes: 34c21fa894a1 ("idpf: implement virtchnl transaction manager")
Signed-off-by: Manoj Vishwanathan <manojvishy@google.com>
Signed-off-by: David Decotigny <decot@google.com>
Signed-off-by: Brian Vazquez <brianvv@google.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index d46c95f91b0d..13274544f7f4 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -612,14 +612,15 @@ idpf_vc_xn_forward_reply(struct idpf_adapter *adapter,
 		return -EINVAL;
 	}
 	xn = &adapter->vcxn_mngr->ring[xn_idx];
+	idpf_vc_xn_lock(xn);
 	salt = FIELD_GET(IDPF_VC_XN_SALT_M, msg_info);
 	if (xn->salt != salt) {
 		dev_err_ratelimited(&adapter->pdev->dev, "Transaction salt does not match (%02x != %02x)\n",
 				    xn->salt, salt);
+		idpf_vc_xn_unlock(xn);
 		return -EINVAL;
 	}
 
-	idpf_vc_xn_lock(xn);
 	switch (xn->state) {
 	case IDPF_VC_XN_WAITING:
 		/* success */
-- 
2.47.1.613.gc27f4b7a9f-goog


