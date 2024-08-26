Return-Path: <netdev+bounces-122008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 776B395F8D3
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 20:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA6611C217CB
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 18:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4434199FD0;
	Mon, 26 Aug 2024 18:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rz3j1+uq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A581199EAB
	for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 18:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724695847; cv=none; b=V15ut+/hNIXIqLCOyEQiwTPLzj/arr1pprPjt32hmKOIpkqqykkbMuevwMxNA+L8GudsrE2nyz0UbZCn0fupAwkyxV56w3x7iDVbCYHTvRWT1Z7ZoFMGcQYdyJ1Mlhpsm1LS23ls2UMEMCnKjI8t58BxVbV6S2xA9bFH9X+3Hv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724695847; c=relaxed/simple;
	bh=JrQE7ukktaa5BDLBoKiOsnJovijkjtIWFE5krqqkKVE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Tgiujx3gpLoIPqP900AqICumFgPpt6uSk5Zq5mfErwm8uEpEfM1r6DJmvcNfLC6n7sM/NUD1fMMtpqMqKgFZA1V9QRopnxmu1/XtAQCOL21AxDhjhgIDfrLAdNNE58nThc+2fCzZCe6j4Vf3+U5fZ/60vvWim2sqnlSO89JVOUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--manojvishy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Rz3j1+uq; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--manojvishy.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6b38bd44424so83090367b3.0
        for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 11:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724695845; x=1725300645; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+2F7nz3UMUAFR15Vkm7j1Cul/J99ot3Q3o9XowrrRt8=;
        b=Rz3j1+uqPMoFRq4sk43F4vFZbCegQmFAX0wYQhsUBPfmquNb9KItrZW2jqiiB3mHiC
         vDHWDL8PLthkRHJamvWPoxDyQKmKz2j1TUBxdYYiUWE5ZYg1VK4HxK9hDArSXyLeVwx+
         FeYh7CRdLisAoesJhissb9PJiomdAYuY5KuM79HFlExtlR9H2+MURBJDCTc0y2AMJW+s
         EebAulaWyUft7PjXDehzFGNtCjcnSI0axQiDx2TFqKOlJwFnYuYWUFYOT7CsSSIXc86f
         F5fkL5vTADWR/3Cm+o8DC05IriOE5f/pgiMO1XtcJh6/FnE/+OTjUz63tryz9xYl3xW+
         07Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724695845; x=1725300645;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+2F7nz3UMUAFR15Vkm7j1Cul/J99ot3Q3o9XowrrRt8=;
        b=mxKMpxvObZJnGHdY1LLpNvbVoZtF63a1jdthDR/HPYSn2mxo817NvDYPcsUuw1aQHi
         L9jDUAeshT6drCSwoo9wOf4EFNFfbb9kQZwCCy7sXuOSTgyFFslTL6tiBLQDOyacJveU
         JR11Fl1LW0KqN8y86Rv5+j9CDjyDy/1XPp6Pi/jVYIRE0z1IvcO4GenELr6fPFSofLjK
         1YLiMbo0cR+oM9MIJUh1eOwL34XtgkS7rq0+eHu9BGTObSEzVuk/EguON/sMQswa0DZZ
         Kh9Dt7ALRK3VPsaT6fCx3grwUie0XZZ0K5dDaVBd5uyMO7Xe6iS02/bXbYQp1itrPp5B
         uSig==
X-Gm-Message-State: AOJu0Yz2MTmaU0mnqBxproqvELuHZ99+H6Z2KxkhQLfpEcvNJy7gEX39
	GqLyOtzgeiy533I6Hy/XEZQEPkMowEG9Xw9CavJn/ElDeeNZWZTuCZD9BbPvBKXtVHMXnczYTzk
	miyGJ1aJ9Xfw4X+D/Uw==
X-Google-Smtp-Source: AGHT+IH1ALkhd6H0T9zDYc5JDKk/4XNxqMfJlwCfIvNtsnq/kvN4ZDenJppUZ+Y9eW49jxiGQRirEW+rHE7gLg3t
X-Received: from manojvishy.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:413f])
 (user=manojvishy job=sendgmr) by 2002:a05:690c:6e09:b0:6b2:7ff8:ca3 with SMTP
 id 00721157ae682-6cfbaf3a1c9mr97067b3.4.1724695845308; Mon, 26 Aug 2024
 11:10:45 -0700 (PDT)
Date: Mon, 26 Aug 2024 18:10:32 +0000
In-Reply-To: <20240826181032.3042222-1-manojvishy@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240826181032.3042222-1-manojvishy@google.com>
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Message-ID: <20240826181032.3042222-5-manojvishy@google.com>
Subject: [[PATCH v2 iwl-next] v2 4/4] idpf: add more info during virtchnl
 transaction time out
From: Manoj Vishwanathan <manojvishy@google.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	google-lan-reviews@googlegroups.com, 
	Manoj Vishwanathan <manojvishy@google.com>
Content-Type: text/plain; charset="UTF-8"

Add more information related to the transaction like cookie, vc_op,
salt when transaction times out and include similar information
when transaction salt does not match.

Info output for transaction timeout:
-------------------
(op:5015 cookie:45fe vc_op:5015 salt:45 timeout:60000ms)
-------------------

Signed-off-by: Manoj Vishwanathan <manojvishy@google.com>
---
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index 30eec674d594..d8294f31fdf9 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -517,8 +517,9 @@ static ssize_t idpf_vc_xn_exec(struct idpf_adapter *adapter,
 		retval = -ENXIO;
 		goto only_unlock;
 	case IDPF_VC_XN_WAITING:
-		dev_notice_ratelimited(&adapter->pdev->dev, "Transaction timed-out (op %d, %dms)\n",
-				       params->vc_op, params->timeout_ms);
+		dev_notice_ratelimited(&adapter->pdev->dev,
+				"Transaction timed-out (op:%d cookie:%04x vc_op:%d salt:%02x timeout:%dms)\n",
+				params->vc_op, cookie, xn->vc_op, xn->salt, params->timeout_ms);
 		retval = -ETIME;
 		break;
 	case IDPF_VC_XN_COMPLETED_SUCCESS:
@@ -615,8 +616,8 @@ idpf_vc_xn_forward_reply(struct idpf_adapter *adapter,
 	idpf_vc_xn_lock(xn);
 	salt = FIELD_GET(IDPF_VC_XN_SALT_M, msg_info);
 	if (xn->salt != salt) {
-		dev_err_ratelimited(&adapter->pdev->dev, "Transaction salt does not match (%02x != %02x)\n",
-				    xn->salt, salt);
+		dev_err_ratelimited(&adapter->pdev->dev, "Transaction salt does not match (exp:%d@%02x(%d) != got:%d@%02x)\n",
+				xn->vc_op, xn->salt, xn->state, ctlq_msg->cookie.mbx.chnl_opcode, salt);
 		idpf_vc_xn_unlock(xn);
 		return -EINVAL;
 	}
-- 
2.46.0.295.g3b9ea8a38a-goog


