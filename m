Return-Path: <netdev+bounces-293302-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id hr6VBS1nGmqd4AgAu9opvQ
	(envelope-from <netdev+bounces-293302-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 06:27:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0F160B3F4
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 06:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 40B7530373F6
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 04:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E0B352027;
	Sat, 30 May 2026 04:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WhUHVFnl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BED33CEB0
	for <netdev@vger.kernel.org>; Sat, 30 May 2026 04:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780115242; cv=none; b=bDSoNyi2zAujRu3O/0WzEhlPUMAVz01oxN6IWuc/vssTdcf/YWxrUiP83nl8CwxAEAUjXV8cijzNguvVzs/9kOMY7XtcNtTeD9FW+bcQ4KsAVnxwZeDw2TbJ4nVIp3BsaSI7umsnFXBlLcr4SweWt8Da+ZcfU7ayOba7tOZ/W0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780115242; c=relaxed/simple;
	bh=A8ei1zfEh8HnY3n/gMP6Y+CHm+bE51ejJm5tn+ywBfM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hEyyT2HjinxzaRN1nI8HLUh/kmFICPJ2qQb32MWV8rXJn0CgvsAPtGK19/tPz3W5XzkYgfFWoAFP3V7ElYw6MGUKsO+afW/nDweIQlDtLEcBFAzQvzkqGpkpXUFc3bd5xcqFByuAgo1tllCQDPRY68io/GYaur2yvrm0mn3m7eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WhUHVFnl; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-36b95eb4bb4so1074959a91.3
        for <netdev@vger.kernel.org>; Fri, 29 May 2026 21:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780115240; x=1780720040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9ZFm47Cq6NfmQZ2ABkjht9LuROyFP5W08K9dHfNwh3A=;
        b=WhUHVFnlLmIwekm7VnkMlShpu31+/qKfefB4hUwj0MRaIS/v8WB1q9BAeHsx4thvp1
         Cg8E5CwylXc+PV2vNso0mprowTyV2RG9BxBbVuw8bztBxR99mRuFgcMtkaX9WLgl+WTV
         Abu69rRty479cJN6Y07znl/hCkR8y3eTxr0PCTqHVMb0IUOlsTSzVIvf/pTmZj2giYU8
         2TM4qhNqXYdbdVJmSDXDaHN+6/6x23a+VZXWV/W4tUhdDIPETsOC28wjN8OEkL9qNcg6
         4a4VeqdRlxZ1Ze8huqoWXLr3AzyKOlqqG0GG33Fk+QGX1gHv9bLIrsBaiDg/WExBRCKU
         OOCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780115240; x=1780720040;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ZFm47Cq6NfmQZ2ABkjht9LuROyFP5W08K9dHfNwh3A=;
        b=buHUjwea2yNyzlKPE/Gkk62LwobhmBpDR2x+TP1nFB/c5OmkX+U/fMwnhQrOPeZ/es
         U0ljUYj0uRQYDdqqulWBdGlFcLiMQOiFE4jmruv7Qx/dvUaRUIHueZ6RN2W8MwUoIaEa
         aBjRz0Rwh2YttGCO9jkXmuZ3u/bHnbKGr++53VoI6STKR3uOpi+FlIWYz+ld2/MGySgn
         Pi6XsIy5JGiLsAe8CIaZOKwbccjm+HQnhIHqOEo9Y0G2ST92HnLuENu/XzOpVy6GkWew
         PPCQSn8GMktT077LHlfXWGwc38CLtxiSjGwqiuc7110Ij3z8pX10WXClNtFINHqwaOJ2
         MMpg==
X-Forwarded-Encrypted: i=1; AFNElJ9sBBINovtsvhKpTi/TEx5PuOR5OGu3Kamn5YRKThsmFcdsytvaWx5/SH6xfVZFlxl8F7PoT5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaQPGpbmaWhfvPIh2UGQO+nz+xRjXy4zmmoFEGRyi2lPqSiFfc
	l3refuKakNs3omPHx1oZC6dOF721gUs+4RkHVSIul8hzvUg4hcpXmqJl
X-Gm-Gg: Acq92OEh/0J4RrM8lVhpKRDdtAy2u32xMMaK5onvNmJJQgBbPxp9RIWAmmpq974RasC
	MqmAI2IKkmWa5e13PH49lrzZpCerFI6l1dP9HnfKwKX4pdPriuh2ENINFJgzfhKJseUuIc6CJGC
	o5xYHQjb27Ap5uSAvvSP8sp5EsJbANXXiwSSZdgfTwRMr9/E7CpZEK6oZFNNtIUMv+zL2V+hc9I
	zLOxWMpjrNgT+hKk4ZjhoVmNoLZlSegHlWklQ/w/PNiJVYtG7CLVkTfHwMoSi4NzNw6HRmbcg+t
	vU9J9X7y8c7iPkG6DDInlzcFnuNu68pyTVNQC+r4y595mGkVq24TMqqWkZVCONlyFGdb3piSWIv
	0fKvO174wYzItoOH4qiKPs3+xLVDnip5wDb4Ye9PLcvJQR2/cXgvgVRCFDwqH6IPMwsPVOxz4rG
	ReZWjCWO9GZdoTNii8mnDBYVHoGjQL8TMq3/G+8cJDnRyK1TyLT2gd7kk5+vVBF5F4fbkM1adjH
	KKv2M9wxCzM2weQXZdNfjmwAH0xCnGwlK4PovxIcS5+u+nrajUn
X-Received: by 2002:a17:90b:3810:b0:36d:5d1c:c4ad with SMTP id 98e67ed59e1d1-36d5d1cc4famr1262089a91.9.1780115240224;
        Fri, 29 May 2026 21:27:20 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([2408:8207:1920:4670:1de3:85c9:62a7:fd40])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36bc0c1ab21sm3794353a91.14.2026.05.29.21.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 21:27:19 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net v5] xsk: cache csum_start/csum_offset to fix TOCTOU in xsk_skb_metadata()
Date: Sat, 30 May 2026 12:26:30 +0800
Message-Id: <20260530042630.80626-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-293302-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com,fomichev.me,iogearbox.net,lunn.ch];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 9F0F160B3F4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jason Xing <kernelxing@tencent.com>

The TX metadata area resides in the UMEM buffer which is memory-mapped
and concurrently writable by userspace. In xsk_skb_metadata(),
csum_start and csum_offset are read from shared memory for bounds
validation, then read again for skb assignment. A malicious userspace
application can race to overwrite these values between the two reads,
bypassing the bounds check and causing out-of-bounds memory access
during checksum computation in the transmit path.

Fix this by reading csum_start and csum_offset into local variables
once, then using the local copies for both validation and assignment.

Note that other metadata fields (flags, launch_time) and the cached
csum fields may be mutually inconsistent due to concurrent userspace
writes, but this is benign: the only security-critical invariant is
that each field's validated value is the same one used, which local
caching guarantees.

Closes: https://lore.kernel.org/all/20260503200927.73EA1C2BCB4@smtp.kernel.org/
Fixes: 48eb03dd2630 ("xsk: Add TX timestamp and TX checksum offload support")
Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
V5
Link: https://lore.kernel.org/all/20260520004244.55663-1-kerneljasonxing@gmail.com/
1. send this patch only and wait for Maciej to come up with a solution
   to adjust the selftests. I believe he will send it out along with the
   rest of patches.
2. add reviewed-by tag.

V4
Link: https://lore.kernel.org/all/20260517063311.28921-1-kerneljasonxing@gmail.com/
1. correct the description of xmit path in patch 3 (sashiko)
2. move set logic into xmit path in patch 3 (Stan)

V3
Link: https://lore.kernel.org/all/20260515123018.80147-1-kerneljasonxing@gmail.com/
1. avoid breaking previous usage of sendto, and siliently handle
overflow case (Stan, sashiko)
2. add one particular exception process in patch 4 (sashiko)
3. adjust the selftest to make sure it passes in either virutal or
physical machines, which includes add usleep to support physical machine.

V2
Link: https://lore.kernel.org/all/20260510012310.88570-1-kerneljasonxing@gmail.com/
1. adjust selftests (Jakub)
2. add READ_ONCE in patch 1 (Stan)
---
 net/xdp/xsk.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 5e5786cd9af5..f8c8a8c9dfba 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -802,6 +802,7 @@ static int xsk_skb_metadata(struct sk_buff *skb, void *buffer,
 			    u32 hr)
 {
 	struct xsk_tx_metadata *meta = NULL;
+	u16 csum_start, csum_offset;
 
 	if (unlikely(pool->tx_metadata_len == 0))
 		return -EINVAL;
@@ -811,13 +812,15 @@ static int xsk_skb_metadata(struct sk_buff *skb, void *buffer,
 		return -EINVAL;
 
 	if (meta->flags & XDP_TXMD_FLAGS_CHECKSUM) {
-		if (unlikely(meta->request.csum_start +
-			     meta->request.csum_offset +
+		csum_start = READ_ONCE(meta->request.csum_start);
+		csum_offset = READ_ONCE(meta->request.csum_offset);
+
+		if (unlikely(csum_start + csum_offset +
 			     sizeof(__sum16) > desc->len))
 			return -EINVAL;
 
-		skb->csum_start = hr + meta->request.csum_start;
-		skb->csum_offset = meta->request.csum_offset;
+		skb->csum_start = hr + csum_start;
+		skb->csum_offset = csum_offset;
 		skb->ip_summed = CHECKSUM_PARTIAL;
 
 		if (unlikely(pool->tx_sw_csum)) {
-- 
2.43.7


