Return-Path: <netdev+bounces-277104-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6LZcBKjy12n6UwgAu9opvQ
	(envelope-from <netdev+bounces-277104-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 20:40:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D625E3CEC5A
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 20:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0A7D1302118A
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 18:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FAE3312825;
	Thu,  9 Apr 2026 18:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XvdCLdj/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D4C30F92E
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 18:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775760035; cv=none; b=qQZNdfOVH461IWZlEq3VP5Rp7hvM3fb78HoVBuxpdAcmx1PaveROmdVcZQLGv85GIK30YC2IpIsiqiITtjFHiquDJnbdzJwk7aBXLIx2Ftf+Coots7d7VAkuoBUIU9b/en5SnYz9fiICFCMXt/nwvwzC/BVv8ZrzObdOmpX35VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775760035; c=relaxed/simple;
	bh=QS69EOwbeilaE+gg/PyPbGlFPcxKmaTs+d+KkM8Dpr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ozIP19rzNYWyZDmGAtUrzkmYlYKpffPMtrajXd1aBPph1ReMEj9uO65V5k1CmGIbehBuMJcqzz/cvYPkMvjvbRa1NMsazSnG/HIy2MIuby2B+mURCjXFQs0/GjbiD4sh5XSDHWwVF9vzmjy55mOsKoh5+r6LuhnxWv7YK6blHEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XvdCLdj/; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43d5ec211abso570991f8f.0
        for <netdev@vger.kernel.org>; Thu, 09 Apr 2026 11:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775760032; x=1776364832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/oP20LkfN1ljFvhP3IKO8BTW+iHHIGJpKL/nZSlyxTA=;
        b=XvdCLdj/P+hdkNLwEc2YeM15ZIknZCcXZbd5As3Nno5y1SolDjb7RhRZcpfTehudL3
         LGFlanQvcoWcclICGcXJIVfVccGuJ3hKAY3EmjYYEz+P8qut7bMKood1hgHUiLQ33YX0
         7oTYIGeUpQrZ8aV8aZPCux2oSw4M25kZvxb+kzrywwd9QilYJZmWsXr1RRc4fiohqVg7
         5aDaG1Hw83RHDoKUQbqHHrmO080eR2TdYUryn4QpEzAWBkTtjs2cTGeDl3+I3H9qGd0U
         foedFIDfMNXepV76n5SobqRiPE9paET60SGMmLn/JkIJ70UkJlIThCNocqnFETZFqv8l
         KRtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775760032; x=1776364832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/oP20LkfN1ljFvhP3IKO8BTW+iHHIGJpKL/nZSlyxTA=;
        b=o/i0rYPAEd+NacRC0SgvSLYKhZhelrUuu7pk6JvEUBaQ6URg+bTQCYeCPfTiCEHnA3
         Ku/p5p8A6Ogy7mBs5vaCfqo2mh1q1HrolfLFHNi/La6DIMu2SQZ4srkDs7Wql1ilBiWA
         rYD3qGOddFNCF4o1fYcw5fJy92BRpZ4aLehRP3SuFDTZYUs4NioxiWCeyZS1MqCtlHjI
         laAYh1U00aSpdE122qOlcKveXag+TP7fRLrtEbyOEF0jOa+Ggeuf/yLJbKrSMRO/xtix
         KFcVzhOp5l/nFFRbR25qjZzGe+jzL2HzhOoCtq0N92c1zN/NnrRisUdoUSwBG1dabth0
         0paw==
X-Gm-Message-State: AOJu0YzB84Z/rAS3hC/xB3ljrPXyJBlAUsSCXqcqkgnqV1gTQF32CfMJ
	MtaJzD2kM48OvF4pX4sZJRiyEWaMsc7zvzd+xqkpWMPLM/ztywBY1SoC8b5u6hrozO8Gyw==
X-Gm-Gg: AeBDievsEhiHi62L8CwnYwpijtsz58KYSmlIjEJ7Pwf9HDlwR41LSOfdFqPJAcD8EIE
	c7yyYtv4Kh3JRb6BgKN3nNA95r4iyl8lUt9yyy0ssDkxYLK03hmacoYh/XlwwaYpg+78TTbJYnu
	s4SZrNEzsEqpE3Xjj8gI8Z0DrLqa6at/0oLWI7b9iwPwnNOJv0OdvBKANc8x224bhhO398Eq77/
	OYMkKjiWZpsp3KyAmUeJtKlxSLQN4hnbsh6VHkkbwfga2c+aRaI6beGlz5HxjksP2Lyw07RGgIm
	auw5jcpqFtTSUxOsijJ/60n7N0EbXxjWfO3V3xeaXjvSg/4uSR+TFXnWtIgj7q0Cq6r4ryMCcdb
	qcSB62eaSqtz/O/yMyiqxIpAI9lhGL4plCE2zZb6yiuwDq+Dwyw5Fpv8O/bHrnRO5/KhipHw5Wb
	WbVH6247VgzpsSopQSIx/D+/U/6U565TRsu9AJ1NtRvcOEMF4xcP4im8qWYjRD5H92i45k+o3GH
	VUsNHBnIjfc
X-Received: by 2002:a05:6000:4007:b0:43c:fbde:3101 with SMTP id ffacd0b85a97d-43d642e7cc5mr237497f8f.41.1775760031718;
        Thu, 09 Apr 2026 11:40:31 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e5d88bsm560563f8f.37.2026.04.09.11.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 11:40:31 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: netdev@vger.kernel.org
Cc: vburru@marvell.com,
	sedara@marvell.com,
	srasheed@marvell.com,
	sburla@marvell.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH net v2 1/2] octeon_ep_vf: introduce octep_vf_oq_next_idx() helper
Date: Thu,  9 Apr 2026 19:40:08 +0100
Message-ID: <20260409184009.930359-2-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260409184009.930359-1-devnexen@gmail.com>
References: <20260409184009.930359-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[marvell.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-277104-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D625E3CEC5A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Introduce octep_vf_oq_next_idx() to consolidate the repeated
ring index advance and wraparound pattern in __octep_vf_oq_process_rx().

No functional change intended.

Signed-off-by: David Carlier <devnexen@gmail.com>
---
 .../ethernet/marvell/octeon_ep_vf/octep_vf_rx.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c
index b579d5b545c4..7bd1b9b8d7f5 100644
--- a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c
+++ b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c
@@ -352,6 +352,11 @@ static int octep_vf_oq_check_hw_for_pkts(struct octep_vf_device *oct,
 	return new_pkts;
 }
 
+static inline u32 octep_vf_oq_next_idx(struct octep_vf_oq *oq, u32 idx)
+{
+	return (idx + 1 == oq->max_count) ? 0 : idx + 1;
+}
+
 /**
  * __octep_vf_oq_process_rx() - Process hardware Rx queue and push to stack.
  *
@@ -415,10 +420,8 @@ static int __octep_vf_oq_process_rx(struct octep_vf_device *oct,
 			skb = napi_build_skb((void *)resp_hw, PAGE_SIZE);
 			skb_reserve(skb, data_offset);
 			skb_put(skb, buff_info->len);
-			read_idx++;
 			desc_used++;
-			if (read_idx == oq->max_count)
-				read_idx = 0;
+			read_idx = octep_vf_oq_next_idx(oq, read_idx);
 		} else {
 			struct skb_shared_info *shinfo;
 			u16 data_len;
@@ -429,10 +432,8 @@ static int __octep_vf_oq_process_rx(struct octep_vf_device *oct,
 			 * subsequent fragments contains only data.
 			 */
 			skb_put(skb, oq->max_single_buffer_size);
-			read_idx++;
 			desc_used++;
-			if (read_idx == oq->max_count)
-				read_idx = 0;
+			read_idx = octep_vf_oq_next_idx(oq, read_idx);
 
 			shinfo = skb_shinfo(skb);
 			data_len = buff_info->len - oq->max_single_buffer_size;
@@ -454,10 +455,8 @@ static int __octep_vf_oq_process_rx(struct octep_vf_device *oct,
 						buff_info->len,
 						buff_info->len);
 				buff_info->page = NULL;
-				read_idx++;
 				desc_used++;
-				if (read_idx == oq->max_count)
-					read_idx = 0;
+				read_idx = octep_vf_oq_next_idx(oq, read_idx);
 			}
 		}
 
-- 
2.53.0


