Return-Path: <netdev+bounces-273564-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4NT8Aoaky2kUJwYAu9opvQ
	(envelope-from <netdev+bounces-273564-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 12:40:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9139A368275
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 12:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D30893006693
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 10:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6692346FB5;
	Tue, 31 Mar 2026 10:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X/X5ldN8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35F93033E9
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 10:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774953218; cv=none; b=qyaj7ilFc8kaVOcMsDsv3db5ChwYOFov/5iC9QZ9HvSqPktXiQf7Z+DPMCT8GdMINeVtnQ4Kq48boAIttCNNYYSm0JJZZzCxTyAaSoTm9xGTnvJSv/ILAscmk116YAJweqC92JM1PL9ffG28hBRZKi7B4JckvchOZ9c9C2tA57w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774953218; c=relaxed/simple;
	bh=ESnoLg0mCBoQiyMnraEo+1VzlId+wu6hkJDsXCapeEE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=lKoxz9yNpDEpRD0Zprrl3acOLecdw9jU1wk8esTBtPXmF1BNUYNZmQ6v9KMckfzdVZVqxhDIWO3STiFkZfjt1QQ1W1SSNrV0E5Oqg5L2JESH6AHYtE5kejL7so0qSP3U/ogogcaKm0eZwZHzZrmzV5QKxGJMq/gJvBi7iJJ8du8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X/X5ldN8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F05C0C19423;
	Tue, 31 Mar 2026 10:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774953218;
	bh=ESnoLg0mCBoQiyMnraEo+1VzlId+wu6hkJDsXCapeEE=;
	h=From:Date:Subject:To:Cc:From;
	b=X/X5ldN8LCV12LwezC558JagYwFdXc/h5/lnI4nPz67+neLXhwoUnhuo/ial+zSPM
	 zev6zYZVnYvf6AFpfF02y/zzD9oGI2K8COdrvo4TnGD/UL9bzF0uV/KJ1EyzjGPy9e
	 WiMQzz3pX40GkDzXbFfyY9XfDyv4GU2b9xzunKgLyjdHq1nUXuLrcGEvKl95wWrX/h
	 cwazMM/YmMzJcU267LyHD5nXMUjhN/lnT4faDyZJ5gKqIy4jhAO4Rrsiz4+XhSraaM
	 JhS403JyqjHtIK+u4B3S3qSfApIiVIhv4yHX3RYq7b6C/jynwLwe4MZTScuvz4rNnK
	 M8Jl63lR9aJ2w==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Tue, 31 Mar 2026 12:33:24 +0200
Subject: [PATCH net-next] net: airoha: Set REG_RX_CPU_IDX() once in
 airoha_qdma_fill_rx_queue()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260331-airoha-cpu-idx-out-off-loop-v1-1-75c66b428f50@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQrDIBBA0auEWXdAjRTMVUIX1o7JQHFETRFC7
 l7J8vHhn1CpMFVYphMK/biypAH9mCDsPm2E/BkGo8xTzbNGz0V2jyEfo3SUo6HEiF+RjFaTt2/
 nrLIBxiEXitzv+wqJGibqDV7X9QfOVebedwAAAA==
X-Change-ID: 20260331-airoha-cpu-idx-out-off-loop-41ea4b99404c
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
X-Mailer: b4 0.14.2
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273564-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9139A368275
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

It is not necessary to update REG_RX_CPU_IDX register for each iteration
of the descriptor loop in airoha_qdma_fill_rx_queue routine.
Move REG_RX_CPU_IDX configuration out of the descriptor loop and rely on
the last queue head value updated in the descriptor loop.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 82e53c60f561f6314fbf201ba8bc8711e40edc68..e09442580f376b6810b6e4023794e93f63dac209 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -572,11 +572,12 @@ static int airoha_qdma_fill_rx_queue(struct airoha_queue *q)
 		WRITE_ONCE(desc->msg1, 0);
 		WRITE_ONCE(desc->msg2, 0);
 		WRITE_ONCE(desc->msg3, 0);
+	}
 
+	if (nframes)
 		airoha_qdma_rmw(qdma, REG_RX_CPU_IDX(qid),
 				RX_RING_CPU_IDX_MASK,
 				FIELD_PREP(RX_RING_CPU_IDX_MASK, q->head));
-	}
 
 	return nframes;
 }

---
base-commit: 93d04e76bcf1e81f36f5ea7ad620a07747f1527c
change-id: 20260331-airoha-cpu-idx-out-off-loop-41ea4b99404c

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


