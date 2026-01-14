Return-Path: <netdev+bounces-249673-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D39BD1C19C
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 03:12:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2FC6230155CA
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 02:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45412E11A6;
	Wed, 14 Jan 2026 02:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I2q2HmOA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564592E401
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 02:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768356766; cv=none; b=mdy8IvTVmkD5Uy+57M4fuDGBupnGZgsWcr0JHdu2U7B89yT8dXigYwdZk7+zv4uKz2zrYNW0pEqzEqa9pa3CuGywnZMN7cCQOmUFqbipH4ExoqA0iL4j8ex0xRPW+VLsqvrLCv3BEKMBgk9jGbyEM5W5CbS6hiC7TtLKae4gWOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768356766; c=relaxed/simple;
	bh=vsIfd/EdjmKj6EtYM12h7Vo4cjTqhM3wHJIyoo62cEg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UV2s9Cq+DNDL07XGz9jUblnFAcDTbOzm2yZUXgMCP2N/t8OobMKtJhWdeaSuhj7MZAgR712eFtG4g6nCYATtLNG3bbnKjO1vF7GgVPZE8rMwZPb+jMEOHeM7f44eeWtvTOCbdapIEf33Wuo2FcI7e4WjRA3+6nzSNP1/IuDgHck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I2q2HmOA; arc=none smtp.client-ip=209.85.215.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f194.google.com with SMTP id 41be03b00d2f7-bc2abdcfc6fso3040313a12.2
        for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 18:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768356765; x=1768961565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ohesoiOsCmzODawjFtqVNvqZy+tsvtD532ScSAoTgDw=;
        b=I2q2HmOAEeZXnYnWMZhaD7bcrk/+hJgr7gZAExhKf21PIK9OL9UBz3uuEokLvELvQE
         +u1tJriJXEyr0aUm0LoITnln7uwKyfYZelCxjRUxfQ5YGUN71BHxjUjur8DfcoUu/iBN
         cTiV3A6dc8y+JtqGqzl6v5uTEiQ06zwC/OyEiT+xCUqRdwsAFyh1JGQWsSykMQ367OcR
         VQ0mWyOxTxx8Q6beccogS6IAD9mBTPOg2YuIfvvIsxPyCXgAPoissMwQPgIAt0SNiM2W
         M3HruzIswIbcC4+3mIOyyD+2wbXgrMuKGaH/U0i4OLghOa1+CjO+rjLGeIwMd6qVIqh8
         tFew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768356765; x=1768961565;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ohesoiOsCmzODawjFtqVNvqZy+tsvtD532ScSAoTgDw=;
        b=mrTFhWX9Zq6l+0/QC+k2jM46PUjjvw667qegKKStMINZmWl+nL/wvHyLElWyyKIW0c
         zqNC7OQuvRcd+z8F/Tk5Sp3yTXE2rQnMUTxzmcm0ptJ6xjV2nNg+IKTAahfoBrYXjt8L
         m87IvjqLp2FGXpvdWnw8yQ5g4lpRuhZLjlHzx1l6hm3QIp8L8IhA8micWQqIHpen43CY
         MnDgyepxVCPWp6nETixYMEuqUc1b4jlT3PABagwscK2xmE+1VJr9WbSR5EGUtg+vWv/x
         sJW0iuroeJxFIxUm6QNoeW83QOT0E3maH0VhxMmo5IrzUexrn+KE1kos9QmKQgaRsJLa
         EHBg==
X-Forwarded-Encrypted: i=1; AJvYcCXJ52/IHCVeSAxMihD/xuIUrKxH6Lz4AXizH7qST20ybKUTXw5Ux53cgL8oJBXlBHBmxcUYXmk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZoykNth+f5CuIOP8Ulv0Fqk+WWOapB6VTe+pZn6MTKpiddrxA
	KFzcXstqK4ZaDMXGQS3LD1FTwrJRMQu8wYucwJmYnQ7JCDrDyDGHHM7A
X-Gm-Gg: AY/fxX4SxHY+TTfdeisy6DhQ78M8oBlgwZggTNe0RrVcuXn0dE4/7FsXIVGT33XZJtQ
	iLlHpVQSOQj40fezuuE1QBUzoRqCUCoAx4+9xecLizcV67manQu6IVlZBeKLqIKTgU5TLtxhecE
	PQU8mUmYA9SZ5CikPHHxx/PFPR7UUZKntrp0fjJcI9owAM9rdxB+hvTVLC+sAvmYeltI1JQSSi6
	hZvOp4Kgzw0XOwzYYA+UGLCIiqcuU2eo7rBNcBzuqXKDFPcufB0tdy5WxsYfog4vDND1zCyB801
	M9oYQKIfvAasA5oFarkFPe8hlfBzpiOyOdcLU9joYKOJ+i+pTGjWulD2YF5S9JFEQ3n/h8EO+0r
	AACYKMSLzUcN2yETBTPWf/CWAiuOLw2gOdT0B1hwyQ++pTRoa9ciDvt4CtnbsOVdQtr9Nfh1LcU
	t61qoSK5a0n2LMPcLwr/mmORLtNUibE8z0MeK0N0ESEm/SaGguJDM=
X-Received: by 2002:a05:6a20:918a:b0:35d:492e:2ed0 with SMTP id adf61e73a8af0-38bed1c45a4mr1025142637.52.1768356764609;
        Tue, 13 Jan 2026 18:12:44 -0800 (PST)
Received: from fedora (softbank036243121217.bbtec.net. [36.243.121.217])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81f8082aef9sm626827b3a.7.2026.01.13.18.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 18:12:44 -0800 (PST)
From: saiaunghlyanhtet <saiaunghlyanhtet2003@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	netdev@vger.kernel.org,
	saiaunghlyanhtet <saiaunghlyanhtet2003@gmail.com>
Subject: [PATCH] bpf: cpumap: report queue_index to xdp_rxq_info
Date: Wed, 14 Jan 2026 11:12:02 +0900
Message-ID: <20260114021202.1272096-1-saiaunghlyanhtet2003@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When packets are redirected via cpumap, the original queue_index
information from xdp_rxq_info was lost. This is because the
xdp_frame structure did not include a queue_index field.

This patch adds a queue_index field to struct xdp_frame and ensures
it is properly preserved during the xdp_buff to xdp_frame conversion.
Now the queue_index is reported to the xdp_rxq_info.

Resolves the TODO comment in cpu_map_bpf_prog_run_xdp().

Signed-off-by: saiaunghlyanhtet <saiaunghlyanhtet2003@gmail.com>
---
 include/net/xdp.h   | 2 ++
 kernel/bpf/cpumap.c | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/net/xdp.h b/include/net/xdp.h
index aa742f413c35..feafeed327a2 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -303,6 +303,7 @@ struct xdp_frame {
 	struct net_device *dev_rx; /* used by cpumap */
 	u32 frame_sz;
 	u32 flags; /* supported values defined in xdp_buff_flags */
+	u32 queue_index;
 };
 
 static __always_inline bool xdp_frame_has_frags(const struct xdp_frame *frame)
@@ -421,6 +422,7 @@ int xdp_update_frame_from_buff(const struct xdp_buff *xdp,
 	xdp_frame->metasize = metasize;
 	xdp_frame->frame_sz = xdp->frame_sz;
 	xdp_frame->flags = xdp->flags;
+	xdp_frame->queue_index = xdp->rxq->queue_index;
 
 	return 0;
 }
diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index 04171fbc39cb..f5b2ff17e328 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -195,7 +195,7 @@ static int cpu_map_bpf_prog_run_xdp(struct bpf_cpu_map_entry *rcpu,
 
 		rxq.dev = xdpf->dev_rx;
 		rxq.mem.type = xdpf->mem_type;
-		/* TODO: report queue_index to xdp_rxq_info */
+		rxq.queue_index = xdpf->queue_index;
 
 		xdp_convert_frame_to_buff(xdpf, &xdp);
 
-- 
2.52.0


