Return-Path: <netdev+bounces-118153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E705B950C41
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 20:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24EE51C22368
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 18:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517B51A706E;
	Tue, 13 Aug 2024 18:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JtAT5yIh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85A61A4F26
	for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 18:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723573693; cv=none; b=MDfmjfFypMA5qNfg/Dmx73K/XICqJoyo3REnY4YNWZ+iFbAJ6EGeTMH/xfCXZ2pqmJSf8lejOokcxCY0hRjEzeohX24UR41ci4QZTZkAfUS/Ky2Dmgdlv4P49R1bbHXLor84yAt3RFJGaH60Cx4bMEtYjaDQnR9GCJGvWnBc+7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723573693; c=relaxed/simple;
	bh=mFkftTIu02mfcYwHXBEgJrzZ1AKjIW4aHcghMUbRkOw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UBFpwA/l1r+cXvI9pOpIFjmLS2l1LfyIJuesMRRUZrlWkl4obxEsPyWvrrVJmgX+PM5vidtbj+zZ2vjzm4dhUmCT3w+u+hHgBIna5EkdQ3UMgKeDeb7o32e03UDBn9aYzSHe6vFfEWyRw3PYZ0CKPMOFlEg4v0RISFCv1lCQifY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--manojvishy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JtAT5yIh; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--manojvishy.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-664aa55c690so131654647b3.2
        for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 11:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723573691; x=1724178491; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2l203xNbbDmQFlGySVGE48ihh5ns60KyrsTrGKa57JU=;
        b=JtAT5yIhxSVnFOVNQxpQtPI0Skwsvb0Z4tn/opjN3IbB4pfEXjfWCkrfslRjKnkViT
         3Db+DTf5TFRpfF+omJsZuI0PNLpgJFZhWKAgFCz9LU4FtMv6TBA9rrjhPLMeQMYsNuua
         BxAh01ncKAUFzFy1QgAS3dniFLNF1Go5vbvp3fC4hJAHnpgcRhoqmB5C3a+CxP8R8ajf
         8KquqEuZTqFcM/Q6MQQv6t/WzEl+sdEPkslNXxKh7GXfRxJ02fGarYUDV9l23mZTi6nf
         YBExgpH5YsHVzq1V7cnTeZ0iBiS1lBLhWzcjkjm00dxLwa4uxNkPGuAzfZm1RnnWx2jv
         LNTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723573691; x=1724178491;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2l203xNbbDmQFlGySVGE48ihh5ns60KyrsTrGKa57JU=;
        b=KMIosklOzT7dTWRerZlnPKOuTVX2OluPplbE4gu6FPRhhZVThf1Gq0bsohY+wsGNYh
         +aTOTlaLSh2E0qzOcTa34pyFygcGzdIA2cOJ3m+HUdxU7EPvYgYDjSTPBZQl57IfxMfE
         YjAgfSp4m/XrU+Dilh8lc6lhOGimRJFB1D+6hA4ZbWTxrITAabh56xxa86fyErerbk0k
         /rgz/Z90hzSkN09AGpivji31V7BlAZucmyj9TjepeSSW9hF8RugF2rCPeVYQTJUQQJFQ
         61Oe4FbjXLhl3UnglreQlZTb8ueLLqj+aOWacg3nRNWoqckUwIxmPpsXebZgnr+oHs02
         d+mA==
X-Gm-Message-State: AOJu0Yzp7NuaRvELwNcl6nxX1p2CLwIzwnYHs5XtolirQlbPVrC5iGB7
	YbN9rs/6nchfEDZ5/Z+fxw8zgSfPAUDMh1onEVSTgRLmzlomtKgcp0m19jKRniOwAeVD910y928
	tfzb0o9gyo6ZdXjb9CA==
X-Google-Smtp-Source: AGHT+IEjC2wQwCxOJBrBI4mvt/RtCshXJNtsKgTfCt4RfM09XRcGt/PRVIU4C6Llzti+4BVUOLQboVqmXWvBEOBm
X-Received: from manojvishy.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:413f])
 (user=manojvishy job=sendgmr) by 2002:a25:c5d1:0:b0:e0e:3f14:c29d with SMTP
 id 3f1490d57ef6-e1155a94bdbmr13662276.4.1723573690732; Tue, 13 Aug 2024
 11:28:10 -0700 (PDT)
Date: Tue, 13 Aug 2024 18:27:47 +0000
In-Reply-To: <20240813182747.1770032-1-manojvishy@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240813182747.1770032-1-manojvishy@google.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <20240813182747.1770032-6-manojvishy@google.com>
Subject: [PATCH v1 5/5] idpf: warn on possible ctlq overflow
From: Manoj Vishwanathan <manojvishy@google.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	google-lan-reviews@googlegroups.com, Willem de Bruijn <willemb@google.com>, 
	Manoj Vishwanathan <manojvishy@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Willem de Bruijn <willemb@google.com>

The virtchannel control queue is lossy to avoid deadlock. Ensure that
no losses occur in practice. Detect a full queue, when overflows may
have happened.

In practice, virtchnl is synchronous currenty and messages generally
take a single slot. Using up anywhere near the full ring is not
expected.

Tested: Running several traffic tests and no logs seen in the dmesg

Signed-off-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Manoj Vishwanathan <manojvishy@google.com>
---
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index 07239afb285e..1852836d81e4 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -218,6 +218,15 @@ static int idpf_mb_clean(struct idpf_adapter *adapter)
 	if (err)
 		goto err_kfree;
 
+	/* Warn if messages may have been dropped */
+	if (num_q_msg == IDPF_DFLT_MBX_Q_LEN) {
+		static atomic_t mbx_full = ATOMIC_INIT(0);
+		int cnt;
+
+		cnt = atomic_inc_return(&mbx_full);
+		net_warn_ratelimited("%s: ctlq full (%d)\n", __func__, cnt);
+	}
+
 	for (i = 0; i < num_q_msg; i++) {
 		if (!q_msg[i])
 			continue;
-- 
2.46.0.76.ge559c4bf1a-goog


