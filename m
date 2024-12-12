Return-Path: <netdev+bounces-151565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A25C9F0036
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 00:34:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B031516384D
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 23:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B52B1DEFE5;
	Thu, 12 Dec 2024 23:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fMmpPUqs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034AC1DEFD2
	for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 23:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734046443; cv=none; b=WYa0GJOeG4rMOFwyVYwHFRQmrfka9xV1KlhGFdapLsw3YZ5bauN+TuhcgDeBs+rQ8yk7sF+rs4JQQtNOdzZ4WDNmY9/zdUOhOXsf06ulhQs3sYxH0VvziVvf4CZ0rFm9GBon8JKFkt7cFBEeLaS+b1eNv3O/Mm7UBYBFoQB0UhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734046443; c=relaxed/simple;
	bh=HWXJI55Bbef5Ohuw0UPjmcWf0sUSE1PZpO0/NCDoUBg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VtpnQhO7YxP2dFsvxBoMzwYQPkyub0MZu3CDqHlctttV/QpMvz3zTWyuAJhyRErFnAtCIEqH9qYAJs4Nu+g2PkMhAfie2/LHi1+rE05C2WbC3L/6eJ9qvm8xUYfvMsgvaYbXexPwyOkC2bPke8TlZcLxQiy2blXh8ZwCMw13aKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--brianvv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fMmpPUqs; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--brianvv.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-21650d4612eso15790345ad.2
        for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 15:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734046441; x=1734651241; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OMUA0aQKK7WEbAxFgPhIKVdu3gMaz4/z872qXRxIgaM=;
        b=fMmpPUqsTOUHwUtCBz143lBisKzKKk/4U3Cc1toyNcErvtCd/pfv6d/UjFEBO9DmIl
         cGKlvxNTRcWiqIIbRpfOsDcbQ+gpMGuzDznP8YhCcUYAHSIYgFjb3rP1RsHrXqysrPQP
         TW0PkCYTRSCVb8LteDUAH+ruHOXMTrqvrq0aqJeQKsTKJ/3+vlKQ0z+YAPzaK1FwpJxo
         Kyiq6tgdwZ2iPPVmiVIQU7AbbQtNRCAEbDZaBQ1D2hj+1kTk3Aj4eoNN+QxoWTeMuYNt
         0UzJbD+poLFn8c/O+IKSxYaTFRmjYQW/7yACk6LXryckssiRQ6Y2PKw+jsy2KPWYIsMt
         Ha3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734046441; x=1734651241;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OMUA0aQKK7WEbAxFgPhIKVdu3gMaz4/z872qXRxIgaM=;
        b=f1QK9QsnmPya+E0S7+mDqXvSBlvv4VltvqKoRxUDtTYxD3gKgEA1ByfUCM59LgORD6
         BPsY8Autuw4yA22nHIMKZPyRNQEoCWfVfXeapfsWod2qp2Sbx3e4Wz21N8VX08oBlrN7
         WVKGOesQ4cp7oWnzxTewBLfkN6zkeWHgD1sFPdAL0BYq4JBhqL2GqWjYzXDzVmNEwPcm
         cHSDunzDTMu8mHp9u3qgn6DLeBuSQkfwB3V1rhEVp1zyTBBLboHjej9y1a+q5/oiu+KX
         VExRkSxBtJqqp6thIpNQ1BZmIVw85AhZ8jj/GzhmvDPzCQ+Z6M02jwgdsaPvJf6MYuKd
         sWoA==
X-Forwarded-Encrypted: i=1; AJvYcCWkgXTygOYmpW7D6B386u0FaIzAh522ocWbsvWF2vlmTPJFsKr9OvlGIcxz/lMkqMUjH28SuLo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjumWI17rGlH48zZPy38qeUo+P1zs//wq0nB3OBjw1V8Lu+Ate
	QHeWE4NKpU6mGiyXALVka5IOfrNBv4tZl6p1Wz0Avbopehu0IDfxBZ+zqxqwRPlaqxu5JsyHBtK
	ZFiPH0g==
X-Google-Smtp-Source: AGHT+IE6+YFyK2dOzazpuXzKcJ5JcNJCjFmXnz48CKNFl7+T+IEVuHoS2q1LN0WlazSasZY8hBgWv75KCl4D
X-Received: from pgbds10.prod.google.com ([2002:a05:6a02:430a:b0:7fd:483d:9d10])
 (user=brianvv job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:cf0a:b0:216:56c7:98a7
 with SMTP id d9443c01a7336-21892a53c03mr9937645ad.53.1734046441368; Thu, 12
 Dec 2024 15:34:01 -0800 (PST)
Date: Thu, 12 Dec 2024 23:33:31 +0000
In-Reply-To: <20241212233333.3743239-1-brianvv@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241212233333.3743239-1-brianvv@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241212233333.3743239-2-brianvv@google.com>
Subject: [iwl-next PATCH v3 1/3] idpf: Acquire the lock before accessing the xn->salt
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


