Return-Path: <netdev+bounces-80455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3E887EE19
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 17:55:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC4B6B21ED6
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 16:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B09D54BCB;
	Mon, 18 Mar 2024 16:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UrSn60LR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAEF54760
	for <netdev@vger.kernel.org>; Mon, 18 Mar 2024 16:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710780871; cv=none; b=ESi3RROjsfPHKMFH+M2zSVPWhqzZFcT4ZIaQbRI7PR7zxMPu/pLSO+eXpLEN6C0R3eVf7xyDwV500Pzou6wIn2eh9l/MGGCjSggx+xU1sGf8ek77wZQjxMxNMq+TnEsoBG9t5fAzZMPGEnONt2uYdwUUiCniB8fPKS+qUPA0xN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710780871; c=relaxed/simple;
	bh=00Wv3avjAWOsDU06a4tUr98A4JCYUumvlJi+zU/VyMo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=d45xiqMsHd/M4EhudkYWXNnPQa1A9YE4XyAnDojTPAF4tlNBZkakZpb/JDaTAagWdg80ZEcNjyHr9zuBU6jFe6rrefi0aGf1u1O/cZZ8eWZIYOhzOXYIY/xDXDLxjSUY8GJfBO/nfJohIdzGH+DV0Jfo+JsVprUtSoSA/vjuJO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UrSn60LR; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-5e4a072ce28so4135695a12.0
        for <netdev@vger.kernel.org>; Mon, 18 Mar 2024 09:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710780869; x=1711385669; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Gg1p1fjlUsRnpdAvGtFGuWSVLxFfgd5m7y7ro1XOikU=;
        b=UrSn60LRDHtas5oJlypIiZdPkY8u/O7SLxgDSe7i4VTFbRY9RkAPKP0bAFkYhcRBe6
         TuUsezIJpjbZAKXNFfbhpD7g7XwaIF7bAxS3uFiL0OdoLMYP20AfrPijLZA98pOft0GG
         Zqd6ou/5hcZWRKdpRxNMS9OPKBuvBNmlegUJNKIksrUzuqQ2lH/4Xr3g570y9CRLaTpG
         TAAADbOLjapS2EoWUmBP19ax+gOqTCbhAlgWp00gqgdjb5o6DWOn1a1yUzHa4vQiEpPn
         9Zu+pXpSiZ/8n1ji8gif0DdxDRymuGXBr3MyTk8tjUgCTNsXpl+G9w3r/TTyGDwoO4eB
         BD7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710780869; x=1711385669;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gg1p1fjlUsRnpdAvGtFGuWSVLxFfgd5m7y7ro1XOikU=;
        b=Pp8HsuZiH99ijM13NLWCOb9fX9rccdw31C340GqvnD/1JVHYm6K8dEBHdSAD9eLqHM
         1iAh7evC99gtNvEpeaCVDJJnH2udFgUYm+xeAGgoiHGAKp5ldbcFLe69jgUuNeXF2XwE
         GpAskqKdWG2op78fFuo5G3gAlTHy2KsSwxfwliS2uHklc1huvlsYbM1J35LXOCJLIPKx
         nZJmBvvLjUKQJhR/gijcKhVtdITak6OREhs9UMcEX8wqPVNBKISmXko5/yOs/ckeYxlB
         ksvQz3rVXwqMgMIa/4iLqShlu8oxwESnE28xrQRFTaz8Zzn+cBfJR/OmaTC6fTFrw6Jz
         8K9g==
X-Forwarded-Encrypted: i=1; AJvYcCX8IobkL8pTwmNKkn0tMUHvw4z1cwqUyTeyt7jxPYCrMeIUIDrgv3pQzHcuRpl6tLHD0y978tuKLA9n/szrFTcmyr6SIY+j
X-Gm-Message-State: AOJu0YwjWZn9HPSM7GbZWxA1ETvOjK+ljdF0y4g0+50rRytiyo+fF3K4
	8+5ZaXVvdc+/eIKG0CSzRFG0HnZ9RgGP1Ws2qimjVkUDW1g5XaDAGndXC2HhQBg1TA==
X-Google-Smtp-Source: AGHT+IF39rl0gzvD/fWI3Z4vwmpY+riysI2AVh3TNBokVg9Nuq/pc7ni7FRAkhYs9kFEFk+xTzsic7M=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a63:5812:0:b0:5dc:23a4:3a with SMTP id
 m18-20020a635812000000b005dc23a4003amr30317pgb.7.1710780869154; Mon, 18 Mar
 2024 09:54:29 -0700 (PDT)
Date: Mon, 18 Mar 2024 09:54:27 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
Message-ID: <20240318165427.1403313-1-sdf@google.com>
Subject: [PATCH bpf-next] xsk: Don't assume metadata is always requested in TX completion
From: Stanislav Fomichev <sdf@google.com>
To: bpf@vger.kernel.org, netdev@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	Daniele Salvatore Albano <d.albano@gmail.com>
Content-Type: text/plain; charset="UTF-8"

`compl->tx_timestam != NULL` means that the user has explicitly
requested the metadata via XDP_TX_METADATA+XDP_TX_METADATA_TIMESTAMP.

Fixes: 48eb03dd2630 ("xsk: Add TX timestamp and TX checksum offload support")
Reported-by: Daniele Salvatore Albano <d.albano@gmail.com>
Tested-by: Daniele Salvatore Albano <d.albano@gmail.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 include/net/xdp_sock.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
index 3cb4dc9bd70e..3d54de168a6d 100644
--- a/include/net/xdp_sock.h
+++ b/include/net/xdp_sock.h
@@ -188,6 +188,8 @@ static inline void xsk_tx_metadata_complete(struct xsk_tx_metadata_compl *compl,
 {
 	if (!compl)
 		return;
+	if (!compl->tx_timestamp)
+		return;
 
 	*compl->tx_timestamp = ops->tmo_fill_timestamp(priv);
 }
-- 
2.44.0.291.gc1ea87d7ee-goog


