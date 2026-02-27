Return-Path: <netdev+bounces-261980-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHjPIZsAoml4yAQAu9opvQ
	(envelope-from <netdev+bounces-261980-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 21:37:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F03551BDBD9
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 21:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 66667315F66C
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 20:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04888477E3D;
	Fri, 27 Feb 2026 20:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="buaT/Zd6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5FD34B1A2
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 20:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772224542; cv=none; b=YoMJmRsOHjWXjhI2Sb1xzkh+LdkdEGmnKdS7zkF8AyclHMLx21ZahSWp8ysBfRceuX7WijoH4oATbOVDe6F68kXE2ZU0Nn/vDsQ8i+Tt7YVMJQvOvR/KPzcMaSS/ZEuPOluEgZMXbk+NVahnmaHgfBDiZuXX8Eflm8CrShHr0n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772224542; c=relaxed/simple;
	bh=8K0QwXam/iW69cfggpb5/Uon8UQmkG8ThPmq64TvNL8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=V0vu0fbnOS3PntBT0uUGxbrfMV/4PlHjiFmuVb6eb/ZQTJTQkGZVVK4UWKiJC9fnzZhHAvHPVdlBRJevlSjjvLFA7AT2dbDfATxGFrep6VqWZGI2K7Uhs42d0cdIdQUMJQ+KZCTBjgiNyPD8TRctHSowZDuYuLnLyz7OFWIt1BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--srutherford.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=buaT/Zd6; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--srutherford.bounces.google.com
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2bdc0bb5ea0so2068408eec.1
        for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 12:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772224539; x=1772829339; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Tc/Ht2b5cgI4g8P5Sjsh2iQU8CklCHOBQlWuRX9SNTQ=;
        b=buaT/Zd6bCwgjVVYqC5eAUFtVjCf1VfB6QFOXUMgYgHLMi3K+vs0EfbpgD0dvSopLP
         x6RAFHZHOSI95dq/sgBkW7k2QS8n4KE8GPLf8bHhomTUMG1vIdIQu/l5EGK8yi+wWTDY
         Tt72GCPxIalYW3J4fyEsWMY3uNeyVg7VgQM9/OciVptouYJ7kJv5yqq69a5tWnQ2zaws
         M0hUj5p9QLZEcetQ6b3hiQll1p6V4sHyWo8u9IvPcew1D7nAi7vw0XbglDF5tUVMXofz
         40bUZhzBDKHtwxYK3l1hh9PoVIdg3vIBoaWnXBjjaPYWJZ8doLUhHFfbUr/bxMJBTxhI
         BniA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772224539; x=1772829339;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tc/Ht2b5cgI4g8P5Sjsh2iQU8CklCHOBQlWuRX9SNTQ=;
        b=F+ozEvMQkse5pyDL2k/fCb2Wt+mvg4juoidRER1mS6ZHpB4/5Wr2eSR59JZKpRT4tj
         RKMjIF3eqvfGnZ0WUbEDRYyWgHJlNCRaDmsqDS6pO/RONumWmgbSdh4Cy8ZDtLgAIfUB
         LbQ0/x6BnDqgjZmbpIOWBl1y6Ev+3ExwaqLvij659BkXNPklL1KP4ivQOp3ardRTvUQM
         pUFJDin8ni5yj6KC+y3CqYk4CVxWVd5ilG2v1F5nTalJNLqNb/pz1a3U3tXWAxtvZD/3
         Pw0PXBAjiFQMIXNHCOJVoxz2qRx56oEIBKebPGAWvX+zraD8OUIpiDq1oEYzMoJ9HquL
         90Qw==
X-Gm-Message-State: AOJu0YyQeZYtJja5rfZT+RgJPtWS7Dg2hkkIZX2QFnNyWxBcZtMRqfaE
	4Wacyb7mSsOKiYhP4ICFJV06shwNwxSX/8Aq4vjqslAED3SvSBvxuDpTqrMvYuS5YLwasM0rjnx
	SP65xaoo3DFAOA6jgrHj3H+8wNA==
X-Received: from dycmf14.prod.google.com ([2002:a05:693c:248e:b0:2ba:9d01:ecf2])
 (user=srutherford job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7300:d506:b0:2bd:cebf:e48e with SMTP id 5a478bee46e88-2bde1c3f057mr1355544eec.7.1772224539217;
 Fri, 27 Feb 2026 12:35:39 -0800 (PST)
Date: Fri, 27 Feb 2026 20:34:57 +0000
In-Reply-To: <20260227203457.558196-1-srutherford@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260227203457.558196-1-srutherford@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260227203457.558196-2-srutherford@google.com>
Subject: [RFC PATCHv2 1/1] idpf: Fix header clobber in IDPF with SWIOTLB enabled
From: Steve Rutherford <srutherford@google.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, aleksander.lobakin@intel.com, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Decotigny <decot@google.com>, Anjali Singhai <anjali.singhai@intel.com>, 
	Sridhar Samudrala <sridhar.samudrala@intel.com>, Brian Vazquez <brianvv@google.com>, 
	Li Li <boolli@google.com>, emil.s.tantilov@intel.com, 
	Steve Rutherford <srutherford@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261980-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[srutherford@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F03551BDBD9
X-Rspamd-Action: no action

When SWIOTLB and header split are enabled, IDPF sees empty packets in the
rx queue.

This is caused by libeth_rx_sync_for_cpu clobbering the synthesized header
in the workaround (i.e. overflow) path. After the header is synthesized by
idpf_rx_hsplit_wa, the sync call pulls from the empty SWIOTLB buffer,
effectively zeroing out the buffer.

This skips the extra sync in the workaround path in most cases. The one
exception is that it calls sync to trigger a recycle the header buffer when
it fails to find a header in the payload.

Fixes: 90912f9f4f2d1 ("idpf: convert header split mode to libeth + napi_build_skb()")
Signed-off-by: Steve Rutherford <srutherford@google.com>
---
 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 3ddf7b1e85ef..946203a6bd86 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -3007,9 +3007,14 @@ static int idpf_rx_splitq_clean(struct idpf_rx_queue *rxq, int budget)
 			u64_stats_update_begin(&rxq->stats_sync);
 			u64_stats_inc(&rxq->q_stats.hsplit_buf_ovf);
 			u64_stats_update_end(&rxq->stats_sync);
-		}
 
-		if (libeth_rx_sync_for_cpu(hdr, hdr_len)) {
+			/* Recycle the hdr buffer if unused.*/
+			if (!hdr_len)
+				libeth_rx_sync_for_cpu(hdr, 0);
+		} else if (!libeth_rx_sync_for_cpu(hdr, hdr_len))
+			hdr_len = 0;
+
+		if (hdr_len) {
 			skb = idpf_rx_build_skb(hdr, hdr_len);
 			if (!skb)
 				break;
-- 
2.53.0.473.g4a7958ca14-goog


