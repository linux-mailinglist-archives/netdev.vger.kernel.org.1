Return-Path: <netdev+bounces-151567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CBBBB9F003A
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 00:34:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FD511889D2B
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 23:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7D31DF731;
	Thu, 12 Dec 2024 23:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tGxAbfoT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3752E1DF27B
	for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 23:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734046450; cv=none; b=j9dLe+KP5OetTGZe+7jHVyrX3QjxC8NKLSjJE3JIIRTHM8kSyt0td3lLZ/13xog3JYN6QtHkSgF1i5kUmX+SoA7cJhcE+XM++cTJeUHf6fUE5ZbaWYBg/Cmw2EP6CpzNF7jOuGo/XUP1GOXyJSypsbkYu4sLmNR0iy4SHsKqEIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734046450; c=relaxed/simple;
	bh=AoRYYxuyz7m5d82P6sXHJGPnueytngGYQ+K6deJQYew=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eFXy0G/YLkoCU95NsdRDyfz67Z9Xyk1ihr0zX3JwObTzU7HjacoQa39xxKThk05QEPeY6PekVPupW4EIdMl3zxX4F9HhGwSmax9hw6v2qh06QcF9T9Q0+Mj4LDKjo16g4j6+qamUM/b7ivOJht1nx+vjj1z13xwJfWn1Mg+7oLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--brianvv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tGxAbfoT; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--brianvv.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ef9204f898so1018180a91.2
        for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 15:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734046448; x=1734651248; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lVwHov0X10aPJDd/Xn/qoYct9Gn29vQtlHXe3AbUYiU=;
        b=tGxAbfoTjvERxPb/BpR68l8OIQO6kFlhcYZAZIPBXb7XUTF6EVV7+9B+yy3iKdq8vk
         B2HkaSoyx31ylSlVYxF/cnKG4TEsCKEEsnNc76tu0PYvFkSrfrIX/It5cSgAOen8W78A
         mfZRFgGatzCik4D3SxxUp7alsXTNj57hbfb8HDRPU62JgEE89oW46H1qXEw2S/SHjwjN
         nWe56WU3fK0W1PZ2rbe/wqg4ef2QRZzoOr6R5civjbGjU+KWYnLY/qeJuPALalSTJhU9
         rhtwueYhlQPSUhGcDovDNKCM6aIzkPJnRpEk4XL8ROZo3cHljMQFC0p2eG+Q5f7As/t6
         Gqbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734046448; x=1734651248;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lVwHov0X10aPJDd/Xn/qoYct9Gn29vQtlHXe3AbUYiU=;
        b=YhH9EjQ0hGH5m8TY+YJC8ctGIE/DS238tmOe8l9pCVKiRJIVWkkmOAtfcS8XDj/RL7
         PezfaH9M4AKmWc7KAT5/5VgrGfSqMZF5AMdM2bS39Htzg461gIo38ubvOn8sAA8BNxYo
         ZWkyY6OZWJoSUNu5MBprSaVo/pV2XJ6FX0K6+T0bp0zMuGFsN9FPjGQBg7UG0Ljh3Ehb
         SWEQu4+tg2xkgn1DVFOU/2PsCVy1xTkajzLOCKlP+Nm0J6ltf2TKBvU8jemLa8imJmQ4
         vGnJ/GHanPjXrNGvLGzlVxN+O+3NH7+PyCfEvVOFTJS+a7MpMXnE2rz9OWPpZIyoiySo
         9KEw==
X-Forwarded-Encrypted: i=1; AJvYcCVY1OAjhAuyio3dkhb/aTCVTLqN1Xx9C6S8uTJOBVFgN61pe0zU8wfz8cP5YyHIweXo11az4Ns=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgJYQsKOo/JECTArKPIZgva+jZdlC9g3KLMO/w/rl7yCDe19n1
	TYPwExkT9XyqyJ0A0/5lgR3WjL7eYSO5buJglGt5f2q/3RKF/HvQJ7cdd81IG2CakoEhZEITB9b
	oy+HoIw==
X-Google-Smtp-Source: AGHT+IGe7FiBmEImdX0XEsLZOBwrOk+VTTkGoZbu8+xZqBSfxUA2PcZQtkQcbVVi3V7YTKio7yX0EY8giLOl
X-Received: from pji5.prod.google.com ([2002:a17:90b:3fc5:b0:2ea:4139:e72d])
 (user=brianvv job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:53d0:b0:2ea:a9ac:eee1
 with SMTP id 98e67ed59e1d1-2f28fb5fd68mr962924a91.10.1734046448532; Thu, 12
 Dec 2024 15:34:08 -0800 (PST)
Date: Thu, 12 Dec 2024 23:33:33 +0000
In-Reply-To: <20241212233333.3743239-1-brianvv@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241212233333.3743239-1-brianvv@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241212233333.3743239-4-brianvv@google.com>
Subject: [iwl-next PATCH v3 3/3] idpf: add more info during virtchnl
 transaction time out
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

Add more information related to the transaction like cookie, vc_op,
salt when transaction times out and include similar information
when transaction salt does not match.

Info output for transaction timeout:
-------------------
(op:5015 cookie:45fe vc_op:5015 salt:45 timeout:60000ms)
-------------------

Signed-off-by: Manoj Vishwanathan <manojvishy@google.com>
Signed-off-by: Brian Vazquez <brianvv@google.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index 13274544f7f4..c7d82f142f4e 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -517,8 +516,10 @@ static ssize_t idpf_vc_xn_exec(struct idpf_adapter *adapter,
 		retval = -ENXIO;
 		goto only_unlock;
 	case IDPF_VC_XN_WAITING:
-		dev_notice_ratelimited(&adapter->pdev->dev, "Transaction timed-out (op %d, %dms)\n",
-				       params->vc_op, params->timeout_ms);
+		dev_notice_ratelimited(&adapter->pdev->dev,
+				       "Transaction timed-out (op:%d cookie:%04x vc_op:%d salt:%02x timeout:%dms)\n",
+				       params->vc_op, cookie, xn->vc_op,
+				       xn->salt, params->timeout_ms);
 		retval = -ETIME;
 		break;
 	case IDPF_VC_XN_COMPLETED_SUCCESS:
@@ -615,8 +613,9 @@ idpf_vc_xn_forward_reply(struct idpf_adapter *adapter,
 	idpf_vc_xn_lock(xn);
 	salt = FIELD_GET(IDPF_VC_XN_SALT_M, msg_info);
 	if (xn->salt != salt) {
-		dev_err_ratelimited(&adapter->pdev->dev, "Transaction salt does not match (%02x != %02x)\n",
-				    xn->salt, salt);
+		dev_err_ratelimited(&adapter->pdev->dev, "Transaction salt does not match (exp:%d@%02x(%d) != got:%d@%02x)\n",
+				    xn->vc_op, xn->salt, xn->state,
+				    ctlq_msg->cookie.mbx.chnl_opcode, salt);
 		idpf_vc_xn_unlock(xn);
 		return -EINVAL;
 	}
-- 
2.47.1.613.gc27f4b7a9f-goog


