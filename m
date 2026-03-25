Return-Path: <netdev+bounces-271544-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oHKrAD7hw2kgugQAu9opvQ
	(envelope-from <netdev+bounces-271544-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 14:21:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CC3C43259D1
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 14:21:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8B911309E427
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 13:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 207FA3D9DDF;
	Wed, 25 Mar 2026 13:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CpukFqKS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B453D9DB7
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 13:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774444165; cv=none; b=T3Xlv0s2fBKYS4s4nu9T7LofsBtf94woVXv3eDYy+IClKVGOtO7jfqXojfKqT4BsN4uNVdwMBdu0Ma3HmC3AnaDvjjoJdCL1EZ9QlIp4vmnWIkd+uZ39QdJmQvq4Ff29HLuCsm7fRFeFUsJ/1mB1YqEgaG8pUeP2mE0hs7IGUg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774444165; c=relaxed/simple;
	bh=myU71HvPlH+tua7C7irZrMYkDHJZVMRXKhIgm4Zf60w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sT3dnuvOEmu1iZhVNBR/imPLHy7e3eQqyFMvDMaMYoQvhJWgJhToXXTHX7kkwVvrk1d07ujKo55sU/WrBQB4xk28PsJ5a9FKDgbSsohsxvBJNxAXUXryN2D04hON9FyvG/kj7Ujb4Wp8sotOgKqb/W+8WaiijejUnmnbgPAXPMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CpukFqKS; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4852b81c73aso46042805e9.3
        for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 06:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774444162; x=1775048962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lhJtq23YXlExKR4zSWdcdWFcbRO5WZ5uUMn9Pgs/3DA=;
        b=CpukFqKS7+5DJeXI1x1q0sV5WDl9yYoLB7SGNSumeapT33WnrmcCzEyF2wkJ/CpwLP
         lofbq5AlPaXSt65pzEH2Mc2klNAiJm6JeQxsgV5vQMX0Fgz5eE6Vf66kKx3M8pXmF0tc
         9WH3rFg6cRtoE0WnqlfmpgyH4Pg0G4wkQDE+olZDEqENDsKK6tJ2hWq18XOIATXbL0GX
         SXHnXvA80JfJYO5MtfvwooOljK9zBTmYn32TuqpjcbrzIG+KEuazPUMbPAaQ8Mb3gvN4
         BG5mHpfEUbuaS+/CSOjn1wsU8FUwKPMTumT/qfHIF0qKdL/jOgLX0EeebR55i+y4qOvl
         CL1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774444162; x=1775048962;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lhJtq23YXlExKR4zSWdcdWFcbRO5WZ5uUMn9Pgs/3DA=;
        b=OgtgewzAwCclfi7cPobNNDwtg1uZmn8YyG5Kvsaojc7ahkGh9nI0WfZDWwQLGhfg9t
         YaproCKEDPy9Kyf5aCl+qaXQKM91ERUsrPYos7ixbC9LahWyVnPExGfVohwTjmAYPW2I
         0F+bYfrIWp0X0niK48HGM+irg4vRUAkXkW+3Yz2jvalNm6KuQBfQHkrP61ElZW2uSstR
         akS9l7DF98N4sgnUe8kCLpjRqRfsv9LjUx1m2UTwR0zht/Ro47G8enb36BOkRqxM4dGV
         VSlH9l/a0jnOKHaaSWL1LWcAerB3NCK/dsBtlQ+jBXj5AEVo/WsVy7Juy1yizSJtrP55
         chfw==
X-Forwarded-Encrypted: i=1; AJvYcCU4LmU2x21q3MeuRUOe/eMEYuMaqCfWXLHW2NMquPSKpCSPKuwtB9P1K9+3eBeDTI4l9snFFUY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRBLIXx3phR7Ce2tO/o06mGGEtwqnmaN8eyoj6j22EkaQuMIkQ
	ko1hWFJLYSpnYHgBegsUf5xcn80JyB1BbAgVXHgT2TP3Qriwb/0A4NRJ
X-Gm-Gg: ATEYQzw6V0IvQw7Ei306yw6gVhAuVhtfMP7pLlzUDXXP2qDspugEuTBxoGo55mUQVGg
	cyCYP2X9nxJZsaMn58UaqO6ge4vElRuJ8+lvod14SAesi2CSUednCtHZ/6/jmVXYaIRnPSJpIWW
	htkcISGQ5Qkn2U0LnDf6zoAGfhW5y0gv8+8hv/ZTj2YELs16z4Vw4OqKUGoa0es0qOLWcDxRfqO
	Zzoboy+7ZwJqpKNhyjIFsb9GoZk6B4dzXroAtUyL54AmBatm/jCuELbcwn9cyfzuOXZxkRNHwCD
	JJ1q3+xT4azhRu2babWR8Mkcwmtuv/P4ZxjzWd8f2ssguxYNgTz5DcUU0sVil4r+Xz+m5D8N8c5
	O4lQ3f0xg8YtW/tSZgNoaBA+nYFaanJ/p9dj6D5lsK1XvYo1o1G0esaMHxYGWFCq7D82Y/OPQPB
	yiomDQBE9jtTYV9OYwT16BalNHt4NxBFxN0O/dSxS2fatKAJAjKAucA5Mr3eZXU3tnEwIrhMMlk
	yeOhYc52w==
X-Received: by 2002:a05:600c:3516:b0:485:3bc7:a231 with SMTP id 5b1f17b1804b1-48716084829mr54679745e9.29.1774444161726;
        Wed, 25 Mar 2026 06:09:21 -0700 (PDT)
Received: from 127.com ([2620:10d:c092:600::1:8126])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644bd923sm54062611f8f.12.2026.03.25.06.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 06:09:21 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	axboe@kernel.dk,
	netdev@vger.kernel.org
Subject: [PATCH io_uring-7.1 v2 4/5] io_uring/zcrx: use dma_len for chunk size calculation
Date: Wed, 25 Mar 2026 13:09:21 +0000
Message-ID: <fa3e05e80b41664c5cf0af5e1658bc761dda59be.1774444007.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1774444007.git.asml.silence@gmail.com>
References: <cover.1774444007.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-271544-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.dk,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[asmlsilence@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CC3C43259D1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Buffers are now dma-mapped earlier and we can sg_dma_len(), otherwise,
since it's walking with for_each_sgtable_dma_sg(), it might wrongfully
reject some configurations. As a bonus, it'd now be able to use larger
chunks if dma addresses are coalesced e.g by iommu.

Fixes: 8c0cab0b7bf76 ("always dma map in advance")
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/zcrx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index d9174cb31a44..e1d2e1f1b766 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -63,7 +63,7 @@ static int io_area_max_shift(struct io_zcrx_mem *mem)
 	unsigned i;
 
 	for_each_sgtable_dma_sg(sgt, sg, i)
-		shift = min(shift, __ffs(sg->length));
+		shift = min(shift, __ffs(sg_dma_len(sg)));
 	return shift;
 }
 
-- 
2.53.0


