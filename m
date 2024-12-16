Return-Path: <netdev+bounces-152312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA0F9F3611
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 17:32:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FB591882658
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 16:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE7C20626B;
	Mon, 16 Dec 2024 16:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1Ar3B0fP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3864F205E25
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 16:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734366485; cv=none; b=VF0/fa4YRA1LNMktbH4alwEWEHloBPaCgVQ3E9bPAiw3qCcu4ID0Vhi/YwlST+0tZGGfqNos4vwidv1v0lXD/1M3QAe+RPC6MASMpzAYQMJGF70vRzZJaYyPunBIRj6Lg17Vir0XPEDn/fCRsbl9PQyDMwB7FIsToUNkVKWVKAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734366485; c=relaxed/simple;
	bh=j0fOud+pKWNySf5tJsuS0Rbl3bELlcUImPLFG76r6Ds=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Y0WABCB0tPxi1VGCohCNHsd40vJpXqtOYx6lC+LfLq37CMehg3PPtqX4pRu2XHrOU9SQpJXuhxKerpGuMvexI8CzJ1wzxn1NZAi6WBk1V9Usn+mfHFBZZlohJLM1IuF2A/uzobm2DpgiYTVFRDG0EBH9uhM0IlEfTeSr5wpaCyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--brianvv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1Ar3B0fP; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--brianvv.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2efa74481fdso4054381a91.1
        for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 08:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734366483; x=1734971283; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OYgWfITDnmpKZmhpOQV+m1eaKNnm6ygQzblURMa5/eo=;
        b=1Ar3B0fPqRGn0PGsLIokqF83tbv6FRm3IfirViKGSnksIsuDxSgyo3j4QnQjLmHa4s
         uoyOgKvoNxmtrdA5yBCv2voQIG7TlXx9ye3BC/n7650xwF6AHnzBLwPQeSqtyEdqoPw5
         BIOLUZmjsDRajMVsg7pLPSzZsbBrH/ZsY5xfqekS8lSt8fJBVUHrCAR8Ibmwo0r7XpPX
         8VieNmsCdvJPjwbT6R5tp8uRwoSqZ+r1eIvuQEWoMXWlH6wZYYwq/Fodd4ZBZ4nea9zR
         C8puAt+MsVUx7EHk88FgMD00nLlw0njmh0UiBGxs1PS5zg9YpX0hno8uP/4PaARDlu0J
         GILA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734366483; x=1734971283;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OYgWfITDnmpKZmhpOQV+m1eaKNnm6ygQzblURMa5/eo=;
        b=oiRqjUWXtQWqOPbKRYwq6LCr8XLKgmzeDjdN6cJ/YQvqk6ajdXE4uPa8RA6GW4r1eI
         AHLwedc1BpWp2pYfjJsGBZ24JMS7uNjZWwbWMd1nr/9xHp/R5RWAxeEAlqKemdDdIrqC
         JLQ34Q5fku/JW0U/W4i53R9UQOGdYuKxAtdxX+UZ6203DBSHt9dsKKuImtYmZECVqsrH
         KQ3k1yJs5o4eHKGME482emFk88ggMKK2jHsAjBXiW008nWScXooONksFhAxqVtwEymu/
         UKIW9iNvGvHc2tgskOZiSW8o06osncEbM83T8c8Sjx8kPFVSWtK4XJO6aips9XXW7A28
         5IRQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0JN2LnFU4M25DjD3zgVlHgvrOmJf4D1JsfJ131MbDlJkBqa5qAveEYS9817WN3p34fbHkz1E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy//9W7AFhu6KPWsunxWYc779BOQqyeSMH3NurqQ3iJInOoQqDV
	QjahCzMtTPNqW1wBbTUNP4zRtahIm7TqNFoogHkxyxT/MQfyG63BUdwtcmQFCaDEtEi1+n2qhZQ
	Swkxvhg==
X-Google-Smtp-Source: AGHT+IEDjElQVhdH295OadBi+xKcuOeHva8D7aDmG71K5yuV+Yg3mIJZGFiTDFqecjMyexx8SrTcYIANX3dQ
X-Received: from pjvb16.prod.google.com ([2002:a17:90a:d890:b0:2ea:5613:4d5d])
 (user=brianvv job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4a50:b0:2ee:d35c:39ab
 with SMTP id 98e67ed59e1d1-2f28fd6b60cmr16772482a91.22.1734366483591; Mon, 16
 Dec 2024 08:28:03 -0800 (PST)
Date: Mon, 16 Dec 2024 16:27:35 +0000
In-Reply-To: <20241216162735.2047544-1-brianvv@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241216162735.2047544-1-brianvv@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241216162735.2047544-4-brianvv@google.com>
Subject: [iwl-next PATCH v4 3/3] idpf: add more info during virtchnl
 transaction timeout/salt mismatch
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
	Pavan Kumar Linga <pavan.kumar.linga@intel.com>, Paul Menzel <pmenzel@molgen.mpg.de>
Content-Type: text/plain; charset="UTF-8"

From: Manoj Vishwanathan <manojvishy@google.com>

Add more information related to the transaction like cookie, vc_op,
salt when transaction times out and include similar information
when transaction salt does not match.

Info output for transaction timeout:
-------------------
(op:5015 cookie:45fe vc_op:5015 salt:45 timeout:60000ms)
-------------------

before it was:

-------------------
(op 5015, 60000ms)
-------------------

Signed-off-by: Manoj Vishwanathan <manojvishy@google.com>
Signed-off-by: Brian Vazquez <brianvv@google.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index 13274544f7f4..fe5468f226f7 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -517,8 +517,10 @@ static ssize_t idpf_vc_xn_exec(struct idpf_adapter *adapter,
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
@@ -615,8 +617,9 @@ idpf_vc_xn_forward_reply(struct idpf_adapter *adapter,
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


