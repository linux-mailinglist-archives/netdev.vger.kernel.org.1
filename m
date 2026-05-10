Return-Path: <netdev+bounces-286227-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8I73Mzfe/2lP/gAAu9opvQ
	(envelope-from <netdev+bounces-286227-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 03:24:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D2D5021D3
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 03:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B1183002A16
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 01:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE631E1A17;
	Sun, 10 May 2026 01:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S8UOGroE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8DF54768
	for <netdev@vger.kernel.org>; Sun, 10 May 2026 01:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778376212; cv=none; b=mFYEo66Mipn8WEOMiWVhm88L16Xq1edOlQErTHYKrJ/BGfGllzlFv4iRNMA4fPYVr1SDMbwbJ1w68SHTdmd49aNll9ahFMhYdkopoWyflB631gga96k+eXlnYFyjHEdgHZU/bK43vO/51IUItDJZYkSh1szAzDKIaAD98P+qEcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778376212; c=relaxed/simple;
	bh=z9QwWWIDiLxB2T0rvDMh+jEdiTP7o1Ato9sgX5hf3Vk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aIza3ak4uhnToB7qkxTXKjhawHMyRDk0TrfEMYGpmNy0VfXHgjCEhyuwgpQQwZsiNT1ppsVIDHeHzo4C53c1RJTKhL/YTysWjug9IxnEFvK0AOyN1u8GpJIe8JsI4epQxH+97Opsohes3U2MI776xMWE1N9SSytZ30L0FtL7PGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S8UOGroE; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2bc78d56d3aso5774925ad.2
        for <netdev@vger.kernel.org>; Sat, 09 May 2026 18:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778376210; x=1778981010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SLOba0oX+kZuNGN/4ZG77UAy2VIRDoJalOqo5SU9QxI=;
        b=S8UOGroEl/l4iU9CzKibinAZFAbodfiBQuPbCekcB1IfeMg+csx7OamMxhPDf9KkTs
         SPkbGcRPde9/kkW7I2h5rKVL0Wcepj+4J6DJJjWZnN68apoe2qqTDilOsC9U/tH3sp3T
         DOgX/3zF8RyKeLl2H14+9HKHp73dGrVM3ScFWvJJb9IPJRXw/e2puZGyMo9Nl7goFqER
         1cFlmyI3vh4fB6cRYiJmhNCn2KIic9KxzQPWAcjQtKBd4FLlr9TBCOQKnQXDHLsjfeRm
         pAc61IzC5HXBte1P5UidlDukYPXJaW3jGkH/E7/1k3DzK1s/kaADOPXG2tHB2qvV/9uH
         gqKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778376210; x=1778981010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SLOba0oX+kZuNGN/4ZG77UAy2VIRDoJalOqo5SU9QxI=;
        b=Tk/mtZlAWXtrCbuy8nxyrdvkWFhCuOrXijFRB7e/nafyFdNa5ST2X/Sg9wEo2W89nC
         aHnWo3UTJW2XS/5VjMijVfNqACDbUswl5LfTYaT96et027fdsw5XrF2n/PjKByGhiDp2
         d3T7aLiZeJMSQjxiOXmByVfINhVPjpsxb9j9v9XbybdnKQnIz4wxF43Z9RxUOnpLYY02
         HpblkV1wrpxqhTPsGuEtyt4UL//u9ZbZ2Vsx3LC8PDOnEg2quuo+7xFyfvok0/R38Mv1
         4wPuhaAsFP70wxR6XaeqrjOkOA1IP4zLbPMqx8cIXzSL5az6/vbX2dRW+hFJPrploIJ5
         E2Jw==
X-Forwarded-Encrypted: i=1; AFNElJ8zj/Iu6fDWBRNcPw14Ov/oGBeCYMU7XGg3e0HTbq3s27ZKt/+5RAp2qI0lGFbuVPK3Tr8bwco=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrrmOS9u6+AMF0I3Hyp3027mrzFaTO5uZ5A5asYaukLRm5K+f9
	uO6Rw6OdEGmyAJHg/mx6w7M3idVnQwp/PyCyxJPDqmf8nLMmJlyowTpI
X-Gm-Gg: Acq92OHS9jJ8YIc4W2Pz7wm0fjPd1RraM2uluZ+5LN4z2mh2+07/5NV/5IslkULiIsQ
	HzoQ4v6idlI2O/6gmVjzgwC1xDsIWdyPXoLXjppLUpzx8Z6oPB6CxSxLd0SCAJaMqNEBylF2SQZ
	enWQyYW0v80TeRz3YZTZ61neKab2JmXYRt7rjMNCAHv6WzIOMsR7DkpwpuE5vU5vMx3J4IrlXT1
	UeiSuT9pihj4X8JGl3sBmbGI/RxnXqjaaswEBQ/7mpkNxZuh7EOHJN0cW8UyRAuqGUdJa62zjAP
	naW3hg1FPC2KugJCcnhvxsNUTDOGo13k77WrW7HS9WNCVqyKmODsHI8r/bj3q5wvRxtHYIkvQak
	38TzMStwA9ZEnE6PGB2RCQC3Bnwiw+4li+ednNgqdQryyv0COmbY2rAvIQtxJ6yA+aZMzsq6Cf0
	agXBUXFG82GMNOchewnUloqqmmWPgDtumXxELP2LYUwfPBehB++T8ym4TxjsmjkEJdPJLo/kr6n
	5vMzm3H4DHWJ/lkKiQnCA83GgC7vOk=
X-Received: by 2002:a17:902:bd87:b0:2b0:ac1e:9720 with SMTP id d9443c01a7336-2ba79c22193mr138820185ad.23.1778376210427;
        Sat, 09 May 2026 18:23:30 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([2408:8207:1923:2c20:1949:c5e0:289c:ab19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d269fcsm64648875ad.15.2026.05.09.18.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 18:23:29 -0700 (PDT)
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
Subject: [PATCH net 1/4] xsk: cache csum_start/csum_offset to fix TOCTOU in xsk_skb_metadata()
Date: Sun, 10 May 2026 09:23:07 +0800
Message-Id: <20260510012310.88570-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260510012310.88570-1-kerneljasonxing@gmail.com>
References: <20260510012310.88570-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 30D2D5021D3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-286227-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.886];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tencent.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

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
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/xdp/xsk.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 6bcd77068e52..cd039e397018 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -722,6 +722,7 @@ static int xsk_skb_metadata(struct sk_buff *skb, void *buffer,
 			    u32 hr)
 {
 	struct xsk_tx_metadata *meta = NULL;
+	u16 csum_start, csum_offset;
 
 	if (unlikely(pool->tx_metadata_len == 0))
 		return -EINVAL;
@@ -731,13 +732,15 @@ static int xsk_skb_metadata(struct sk_buff *skb, void *buffer,
 		return -EINVAL;
 
 	if (meta->flags & XDP_TXMD_FLAGS_CHECKSUM) {
-		if (unlikely(meta->request.csum_start +
-			     meta->request.csum_offset +
+		csum_start = meta->request.csum_start;
+		csum_offset = meta->request.csum_offset;
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
2.41.3


