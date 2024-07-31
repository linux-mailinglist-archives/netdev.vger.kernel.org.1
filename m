Return-Path: <netdev+bounces-114553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 224F5942DD7
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 14:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBDBA1F2335C
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 12:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17DA61AE877;
	Wed, 31 Jul 2024 12:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LZ8fjFRq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A791E18DF93
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 12:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722427825; cv=none; b=nfbsUmQgQmLSEcApKI4Eic6S1LqHOSAE+yx1oqSWj3KvGquwoK/CTxbQEVbVoNv8RepNKcQEG300xb/NXIvizxrq3OiOlWe1ztAd+o/wkkgwubmfIjtZkhlvvmjF5ibPRazkHF4EWSRf5lpo7YR0LeV2iEUuL1deT9mvvSBu/cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722427825; c=relaxed/simple;
	bh=TJhLBE/1dDFmQcXMCrFDSflxqCoEQKoFBZolCz3PYeQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dhxUYOskMBuhKCQVOJTSaELCWy3rTQ0c12slTd+ZDfsiP6ESK98nytfhfoQLt8Eh188dkJ4Stiq2wAAXTHPwvGy/uCGrXftpxoYspObW/0pWrms9nqbLhSbnwlPysWMC34L8Gz/7ejClWa/5VRkQTITugvbLFG8AYKwTlprEZ/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LZ8fjFRq; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-710439ad77dso1289079b3a.2
        for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 05:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722427823; x=1723032623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2lFhtVGvFg8VrMx6un0IDEAfYudNTjtIlz6cdmYL4D8=;
        b=LZ8fjFRq+I33T/+Ei9/Cgp3cn1xSlPhUcq+3LdX8Y7PPsb0mLCkjzv7ZggKrzc6idn
         wtz+QVSByrSvDyiYo+MVdV9SiTbwMwnjcpfVCMpHKjQIzh8Ig5f/1bD2WV/75Sp7/eZ6
         dNiIP+j7gCsYM4VoRL5tx7X7vYfVqPkke6gjOS+pTbhLxy3v2+fKtfP5uYkK0yBov55g
         vVoRDCgN757GfkmscXdDt8Lm4lv4lBgR3z0TbpoDT0YuEXnXPpwxgMCoxfFm0YLihc2F
         AxOE7hAblOW1gQkyNay/AD3Cna67Np2kYokf3o13tYEjKL7wHW8HQE4HKOMOLPuGdhxG
         aG5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722427823; x=1723032623;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2lFhtVGvFg8VrMx6un0IDEAfYudNTjtIlz6cdmYL4D8=;
        b=EzMWAm27jafaEzMBHTaZnQTwtNK9udJdmh9VSDP8GYMFWCaIUcsPUwDKh4JgTwszIv
         qtTrHVVhRribafMygDHw8uoQZ2lIXwpdMQIToyEyIcnC7ZYWVMcrhVHDpstZQetzASZz
         E3JqgFQ1BoL63yeXUWZFatT3aO8eDG1KOEKrykpNs5WczCtyoM7UgSP5Vtxe7gsy8ErR
         dFbonrs5AzRGnb/nqk6fQ/1L+ocfHRZ63SZqsAe5do9YkMnM+RWLospcuJO5aBI3E3b4
         Hp6h3O9jQyZaNcRGoQOyPsSXcmfqGNJaXWbbSk0PdKmZCum1sCvPbcbbMjrz6AASzy9u
         2iOQ==
X-Gm-Message-State: AOJu0YwCRVoVX2JPquwrvNlzHfEE3keQYBSgddIZH8j4EaTfrguGNvcZ
	KIR+/l0vtCH5Jg2QEBriMMA0aXBniq90u/cA1Ebe3noESFqxTQkX
X-Google-Smtp-Source: AGHT+IGQaywvE1iA11+NI4+EcMilLqjJlf+shDA/Yxd3AHA1kNL9vUXpdjAwM0mEJYKTyePEooGK7w==
X-Received: by 2002:a05:6a21:107:b0:1c4:d540:46c with SMTP id adf61e73a8af0-1c4d5400798mr8499463637.47.1722427822880;
        Wed, 31 Jul 2024 05:10:22 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70eca8af213sm7488545b3a.180.2024.07.31.05.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 05:10:22 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	kuniyu@amazon.com
Cc: netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v2 6/6] tcp: rstreason: let it work finally in tcp_send_active_reset()
Date: Wed, 31 Jul 2024 20:09:55 +0800
Message-Id: <20240731120955.23542-7-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240731120955.23542-1-kerneljasonxing@gmail.com>
References: <20240731120955.23542-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Now it's time to let it work by using the 'reason' parameter in
the trace world :)

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/ipv4/tcp_output.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 16c48df8df4c..cdd0def14427 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3649,7 +3649,7 @@ void tcp_send_active_reset(struct sock *sk, gfp_t priority,
 	/* skb of trace_tcp_send_reset() keeps the skb that caused RST,
 	 * skb here is different to the troublesome skb, so use NULL
 	 */
-	trace_tcp_send_reset(sk, NULL, SK_RST_REASON_NOT_SPECIFIED);
+	trace_tcp_send_reset(sk, NULL, reason);
 }
 
 /* Send a crossed SYN-ACK during socket establishment.
-- 
2.37.3


