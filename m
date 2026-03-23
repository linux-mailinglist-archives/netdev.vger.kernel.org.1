Return-Path: <netdev+bounces-270533-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8PjbEiA2wWm7RQQAu9opvQ
	(envelope-from <netdev+bounces-270533-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 13:46:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 018822F228E
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 13:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0D585302050B
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 12:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6723AC0E8;
	Mon, 23 Mar 2026 12:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GHAHMo8T"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5C53AC0DC
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 12:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774269863; cv=none; b=JybaF6Qbo717QAb4A/xkJn0k/DZgs33kEZljLBztvhH6X4Su1amdrDNpZFliYzXOz9poAhC49OwrN/yC72PXvx6MDrRo/517GbTgREwAgBi5828FCE/svzzqeWfsdtsqpYPxsPpzMZgAJJQzn7/Hrve2YKaAGXEmGmON+vjkA/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774269863; c=relaxed/simple;
	bh=6Bc6cKgO/2CXMucSxQTnwkEyi7Rt4xkq/7FhXfOzrWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ca8P8wLsO0zif3akX4PefdLioqAuIF/EiVm2pNx26IIxkVg2x5J5TUOkzt9bhBMrNXu+tydHPDfGcM6dZgxP7ypz0JxgUSjpxgmYCx6G5XvHMw0prVOIW1vXX/2oer+YybJX88GJUNYY1VfA6MNpX0gqFNaFFeHbnQjrxP4Ofkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GHAHMo8T; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-439b9b1900bso1959684f8f.1
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 05:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774269860; x=1774874660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vuf43jNWxSVPbNjOcURurdJPUaOrCnD61oUU8FfllWQ=;
        b=GHAHMo8TIRqkGhbsaXA5btiV5T8uJaFEWL+EtyKL5FNOSlqq1uR7RCtm4elUBI7shS
         GQhKWSHCy+t/HUII9MNaOm9xH/XDptOAxzPaoZgEX6rEtfjmMoxnNUq/Cs18V0FTDW5B
         9QPWo6sIrYTURjQxwPpqfYN+pcwXihx7PFRyedHjNUM1KxcS2BteL+n3bPlAsfIlMRjd
         XC1uDOFf2uIi6vS51oPQ/5C++jcJoFp+oxWjPp+AAPkDEizU8OHUu/CxWBe43y3jka5O
         RJ04JLf69FiduzuHoLkG1PeSf9Fdo0VI84yFyiw/Q/A06tLM8/J8p1o5ZsRFLLicpTco
         zrAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774269860; x=1774874660;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Vuf43jNWxSVPbNjOcURurdJPUaOrCnD61oUU8FfllWQ=;
        b=ZWNZrd94bmLnZRSFVUeKDJG76oq80b5wVkN/l+6mviQ7yyQ9z+/6aJU+m3mIUBYbUf
         FVz3QfZ/6/y96uHLNdi+CywIiZoqgrQ6yat8iQ8FvH8HXdQJmwBLx5xrUJeoDDcEoDwe
         bWXe6E1xipXMhjRuaklkbRF3rvP1f2GNtfgkolC2sKr8TOi+gpVaxqEPnkMFe0M/EWYc
         ckvchaTzPHXJHBlQrhwY18NvzbSvmqNTy8i5GnIhnwq5tAgoVEar/Wjtt2dLFzVs2eG5
         RlN1Jg05YHpjOv2Xnm1R15bIRr2PI91j2LTW5jqp8qGu1ndcFDvv9k421c+C957wkn9B
         oQXw==
X-Forwarded-Encrypted: i=1; AJvYcCXkTx13sVLjYL9oTCd9e0l0Fx4VHQfNUVys5w5CwKjjCiJJCqdk2xvY00pSyxe8XeifpXoFgfw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy6yCk4Rb1HBRpGXec15siduA/IPyofjUWdlmBG5i1xkvy6Ejj
	yRWS+wdvDqg4HQsjkCLbwlKzXaraRbQwu2+g6w2PrK0R2tMA2WUVHMOa
X-Gm-Gg: ATEYQzygKsrZtD2G92x4QLEot9S+jTy5hhSA4u9RTcBUJLf3FYJB5fUwX2hudR+f48k
	z1FaaQ3F+bw2PL9S0hH0cYFWb54y+bhkdStIhN7otEfmyZpmtvC9Ec0nU0Z45S41ZxenxQgz31g
	m4eXytiKNf5FmZH5QhrznWUG2+lCkdWWQ4pMdic/fVXZAEuRhyXE1RDqhSsPDWSRYYwi6Rmvkn+
	pfJDAtLDfXoPd1Xrz6NZxXm4OpbNcycbDR/E2aVT7pIGxoFseNWmiI9JgBufsg+JtduGWDh2dMD
	M2GVQe3AJJ2KCehf5lB14UdwdoyMGjTOVqRr+U29t1xvzHizgqncLpDRFq7FuZd/a0/BK8ACUQd
	/pTKIBUn/0HT4GBVGcYrQoCZydjZIgt79xYBeUU4DDQITWsWeUHj4u/u4eAbFgThXF+mMUGz4nn
	+Nb8rz15PLE9qz76xhsJ6JzCyIJzMrNB+lIHP30Fau38yKgGQGUDmdp0UUdA1q2ftEr/7Zujeyy
	VdUEnSPwA==
X-Received: by 2002:a05:6000:601:b0:43b:634d:1a9e with SMTP id ffacd0b85a97d-43b64244c2amr18949459f8f.15.1774269860229;
        Mon, 23 Mar 2026 05:44:20 -0700 (PDT)
Received: from 127.com ([2620:10d:c092:600::1:6969])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b6425eeb4sm25520861f8f.0.2026.03.23.05.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 05:44:19 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	axboe@kernel.dk,
	netdev@vger.kernel.org
Subject: [PATCH io_uring-7.1 15/16] io_uring/zcrx: check ctrl op payload struct sizes
Date: Mon, 23 Mar 2026 12:44:04 +0000
Message-ID: <af66caf9776d18e9ff880ab828eb159a6a03caf5.1774261953.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1774261953.git.asml.silence@gmail.com>
References: <cover.1774261953.git.asml.silence@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-270533-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 018822F228E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a build check that ctrl payloads are of the same size and don't grow
struct zcrx_ctrl.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/zcrx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index d6475f95b815..620482cdb083 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -1251,6 +1251,8 @@ int io_zcrx_ctrl(struct io_ring_ctx *ctx, void __user *arg, unsigned nr_args)
 	struct zcrx_ctrl ctrl;
 	struct io_zcrx_ifq *zcrx;
 
+	BUILD_BUG_ON(sizeof(ctrl.zc_export) != sizeof(ctrl.zc_flush));
+
 	if (nr_args)
 		return -EINVAL;
 	if (copy_from_user(&ctrl, arg, sizeof(ctrl)))
-- 
2.53.0


