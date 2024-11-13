Return-Path: <netdev+bounces-144342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A68A09C6B5C
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 10:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B17028374F
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 09:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718541F77A9;
	Wed, 13 Nov 2024 09:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OA2VQCjj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120D217CA1F;
	Wed, 13 Nov 2024 09:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731489673; cv=none; b=V6+VLhhrgxvIHO14Mo4D1lxBnjpZlASxgb5s1a16qH9Q/Nk+OFdgxzCKcLBcZAmcdMqflH/YnhaMHw6LzrXyjFf4CD1KuZCT0S3iIFEZR4Kfx1yGavEofJX+syPzw/UwmcZMWycQwPDm3UyDri44w/ST2R7rfg6y6cRFXHLdMRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731489673; c=relaxed/simple;
	bh=kd6cUmSgHovKGouWyc3igOb4VMoAf/SWmP+8Z6FHGSE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PePKglDi0RE1zcipMSkTL3MeLikoRllyC/nDKabDwx5tRZfPTyuBcCP7FWzUQ0jx5ZEueodUvgoOSXYGi++7zsy9kou4YmpPeEo5UZW5QF5kMEqV9akR79WqClMd3Igv0U19s3IFth3TMbTv8+B4T/O0LvNZ0fEdaow5XG4Z0SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OA2VQCjj; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20ce65c8e13so73139505ad.1;
        Wed, 13 Nov 2024 01:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731489671; x=1732094471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iyQZaDirC21SZ19+YAJ+btxp+2HlaB1gmqYjgsi5eWg=;
        b=OA2VQCjjqZ2R8p+p3SwBGsvYe+FtQRB66f1nCB+m2IF+StZFvV49cCz9tnxIwVzpXg
         jhsQy+MCdFPTGkZFSQgMTZEJ+SE3IuBUS56aYtBpEY6uldF60tN2bM/QHctzMEFZFjjA
         /gpdngGeCzKmYi1PmB6txjw3zzb2IOLmyPypqQUCipzKErBk5vcYBIX9bUCfbL4ewgPc
         ZrDCj+S6xWOSIDJn+HsqBrSrNvdyEyUCiuDMoSlXn9Iaz/hKnxAbYS6QGKLEJHu1EqZJ
         7siYyKEkyb2mpOnLR45tHmke4vKuyc5p9IzlYXpHdYbz/D3nTOkdLcKtzKV0q1C9jNiH
         /sKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731489671; x=1732094471;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iyQZaDirC21SZ19+YAJ+btxp+2HlaB1gmqYjgsi5eWg=;
        b=MK4p8PT3J9IS3TRdrX7LO5ZrFo/MvIAYtKmmX8QmCF/NqFmnGEurhtsq3enLtvu/bj
         X4Yy3RgCzKwhR6s4IjD9ExYjlcB3S83cT2DVpXxYPbUkGdG+mQ7FI3W6J0HRBJVj8yh9
         vdjqYUxFEJUIhuE67DWqZ/Mg1EIoFI6IYKksfivu1GdQZ0nOZTzdUZBfFP750NYB3Bzh
         g+KkXKq6DckzeZTVOul61hWr7lAhWZkKCdF2liaxTAv85jEKT65Gd3qgKtjQ5kcRA5/U
         gN7zEEvO6SjwnaGJ2D2FC6UZOySYdUEhfBfqmtxeaWZ8coS5QqzVIqITcDNGuC+o1lT5
         jNsA==
X-Forwarded-Encrypted: i=1; AJvYcCWMtG5fBoz46D1yOOIolqeqluJ+sp2l9MsftkA/tm4cc+HPLKWSF7qfd0KG3wisaVW0RQEIQJeB@vger.kernel.org, AJvYcCXYOQMlMCO5UrqJw4nW//fhbGtUavIhJFwghDkWUPUWH7BPdAPLIrApSFsMumq7UErYM9cUrNcpiSUETHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLlgd+KF5ls/T2H7+OMBGCk9OCmSjrJB8zzut2VTiZj6iC10qI
	lFFZ3fyDGJktTLfJG8Cl5vT/XrMr9HHSWepd/d0xhMZxhBLPskJ3/Ptjak9P4UU=
X-Google-Smtp-Source: AGHT+IFv98fe36eOh/DTRZL2OjkVvujdEhF5WM8Dxk15ZxwgP/8k6u4PyVCrY2cJN6JhaiaZzT6UGw==
X-Received: by 2002:a17:902:d585:b0:20c:b700:6e10 with SMTP id d9443c01a7336-211b664da65mr25528535ad.34.1731489671170;
        Wed, 13 Nov 2024 01:21:11 -0800 (PST)
Received: from debian.resnet.ucla.edu (s-169-232-97-87.resnet.ucla.edu. [169.232.97.87])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-21177e49489sm105690065ad.136.2024.11.13.01.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 01:21:10 -0800 (PST)
From: Daniel Yang <danielyangkang@gmail.com>
To: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org (open list:NETWORKING [IPSEC]),
	linux-kernel@vger.kernel.org (open list)
Cc: Daniel Yang <danielyangkang@gmail.com>
Subject: [PATCH net] xfrm: replace deprecated strncpy with strscpy_pad
Date: Wed, 13 Nov 2024 01:20:58 -0800
Message-Id: <20241113092058.189142-1-danielyangkang@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function strncpy is deprecated since it does not guarantee the
destination buffer is NULL terminated. Recommended replacement is
strscpy. The padded version was used to remain consistent with the other
strscpy_pad usage in the modified function.

Signed-off-by: Daniel Yang <danielyangkang@gmail.com>
---
 net/xfrm/xfrm_user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index e3b8ce898..085f68e35 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -1089,7 +1089,7 @@ static int copy_to_user_auth(struct xfrm_algo_auth *auth, struct sk_buff *skb)
 	if (!nla)
 		return -EMSGSIZE;
 	algo = nla_data(nla);
-	strncpy(algo->alg_name, auth->alg_name, sizeof(algo->alg_name));
+	strscpy_pad(algo->alg_name, auth->alg_name, sizeof(algo->alg_name));
 
 	if (redact_secret && auth->alg_key_len)
 		memset(algo->alg_key, 0, (auth->alg_key_len + 7) / 8);
-- 
2.39.5


