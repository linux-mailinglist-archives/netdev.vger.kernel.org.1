Return-Path: <netdev+bounces-250119-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 75BC2D242BE
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 12:28:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 48CFE302FC5C
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 11:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46ED63793C6;
	Thu, 15 Jan 2026 11:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VquaUTE4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8EBD376BF3
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 11:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768476268; cv=none; b=RO/p1GlBpnc7ikqy7dAeH7bnprGn90BH+IRG7LJJ+neyHalt7/gP8Go1eBoUcenIe6NLsqR1Gu4vo+7fkM85qkAL3Xp0dAIw6LydTF4ot+ixDj2Ac08gRJt/ztPT+wRjwrIhhmAfQW3Ek1++u49AoQ1ZGqPZVzIgIJoK+ECyOlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768476268; c=relaxed/simple;
	bh=pPH6IGYSvT73W3XnsSk5F+V+bv692q4Zq0EDWpqk/mQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R7x/PQyFzGpYXA3qMPvzfLEWacCGP2Tdl60G/eqa8/VKG8zbY9ZQ1oXGzjAmObDZKHQfcuyBdujRFG1ezVYQ7qp3hwqvWuSAbXCFHVZ4tXSppTGaZccg+hfPupDRsVcaEYE8bv6JiyeDrVnbF/wVe6Jbm1r+Xy8XlrB4lyI7ctg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VquaUTE4; arc=none smtp.client-ip=209.85.215.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f196.google.com with SMTP id 41be03b00d2f7-c075ec1a58aso310206a12.0
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 03:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768476266; x=1769081066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BGHQu6mG6lMqPEadRM+ZfBOS3CsIq7QGGssQ90tpvv4=;
        b=VquaUTE47cNMtH4R99nUyNiRvm8ZKI7W4drvLXdZFG1L/XDQlnBCg0qvO7a2TkECck
         yyiA45+r1PBV5xDBt7YeSrMkItoYG9h3MnD5gLsmAeHsnPeWA86Zu+r8d19CECgfWPX4
         1PPISCtSNMTFT+qgixpiEYCFD5tlWA0l+3QVPjdplGV8nyxZxZzxB1kJr4wP16vptClt
         /0N0dikQp438pYIsrDvYXpRfNlltek2QNilk3ecn4QAiA4f40CYJ4amotlr4CFAcZ4nd
         xyQexb8MAWb7tCUCm7+twFzmpgI0osN6iRTz5ec1xuB4iekjbNGj8VLh0jB8hFLhr1j5
         ACBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768476266; x=1769081066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BGHQu6mG6lMqPEadRM+ZfBOS3CsIq7QGGssQ90tpvv4=;
        b=fv6olEqoBULk3U8DI4gfpYChPg10XXG9qPx+3JWWXmijHKAD1EHcSltUnhoHxKBmyP
         8+2dC1UWnJmfw1EsddG0pjcofWJRBGtggc2e6KuvTrk8MKExmoRsAczxj8d2FQg9sIOC
         +2tt6FF4EpO84TQ0bEteG10WAXIoRz8+6/uDacAfd5kdzNr7pMbdviQw5z2bR9Xzf+LK
         rybH6V93BgDKMA8U57v/g33rvGDMiutDQUAM1zxq7WgMrOp5pjSL9TaOBX+047pmoJBe
         O97ErSj/uV0A8CVSPRUoPwywvu7JjSseojGSbGOyvf/ogmxLvaXfRlF8slYPhAYvTb/Z
         11RA==
X-Forwarded-Encrypted: i=1; AJvYcCWK0WJ4mIztEvDL9t46brr0Rz6dP/zAmDSieAUT1HVG7MScvalIkm4xNXkD9vhTADMp2oK5AOA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQopEwHWKXJOYjGE5SistvO3bMz9mx+wOkAu5QFaDEs6fSKW7f
	1otXV1MI3ZQilfdB48grzWul2LvzILfnskUeDHhr7I7V/ou1GUvVJ/J/
X-Gm-Gg: AY/fxX5hrTgvPifH8M8jAoFv0dU2aAmMM11j996JqNAxRT7eGKHMU6FdE13ZTBWi2ZV
	YXPxECyEbKosMeUs2hrBvh1xar2uAIEKY2EYwdQgFYrESIxyRy9BLK82m2R1RQhw9QLWsLNA0Iq
	1k2eNAAcataBuxNYZ/yzeFdd9D1S80IlfmSYOwkTznYGs6M8d2V0C9UTgCKM4JlqOlPNH1WxJtE
	G8vM6QbVdxUUmLU1rbhpR0Q58RLpHx61FMqk1KgJLAoTFQZb3LVomEQnRuNT5hWBYamAbexPEaF
	nI2suj0/UKPUtXZrvOfaj/qPiRD3+VYwtWXkpOOiszyt0QTHFt2gePLhFaZmDsePFUSSBPpXW+P
	pgJ8ikIc9cwtpM9i6YYhppg9tBT18jsgS4jRWxyM1tF5RKw/XbaLwaPqBRUn7C5Hk1AVjhj5xQl
	7DPP+cKSM=
X-Received: by 2002:a17:903:1585:b0:2a0:9b4f:5ebd with SMTP id d9443c01a7336-2a599da5d92mr57640525ad.15.1768476266136;
        Thu, 15 Jan 2026 03:24:26 -0800 (PST)
Received: from 7940hx ([160.187.0.149])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3ba03f9sm248523225ad.0.2026.01.15.03.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 03:24:25 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	davem@davemloft.net,
	dsahern@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	jiang.biao@linux.dev,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v10 09/12] bpftool: add fsession support
Date: Thu, 15 Jan 2026 19:22:43 +0800
Message-ID: <20260115112246.221082-10-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260115112246.221082-1-dongml2@chinatelecom.cn>
References: <20260115112246.221082-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add BPF_TRACE_FSESSION to bpftool.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 tools/bpf/bpftool/common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
index e8daf963ecef..8bfcff9e2f63 100644
--- a/tools/bpf/bpftool/common.c
+++ b/tools/bpf/bpftool/common.c
@@ -1191,6 +1191,7 @@ const char *bpf_attach_type_input_str(enum bpf_attach_type t)
 	case BPF_TRACE_FENTRY:			return "fentry";
 	case BPF_TRACE_FEXIT:			return "fexit";
 	case BPF_MODIFY_RETURN:			return "mod_ret";
+	case BPF_TRACE_FSESSION:		return "fsession";
 	case BPF_SK_REUSEPORT_SELECT:		return "sk_skb_reuseport_select";
 	case BPF_SK_REUSEPORT_SELECT_OR_MIGRATE:	return "sk_skb_reuseport_select_or_migrate";
 	default:	return libbpf_bpf_attach_type_str(t);
-- 
2.52.0


