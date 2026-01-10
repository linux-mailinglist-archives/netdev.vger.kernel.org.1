Return-Path: <netdev+bounces-248700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BA2BDD0D72F
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 15:16:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D6ACB301CCD9
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 14:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F7C346A1A;
	Sat, 10 Jan 2026 14:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KwTu+i8v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B013451AE
	for <netdev@vger.kernel.org>; Sat, 10 Jan 2026 14:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768054408; cv=none; b=om5KjCavC23XXir5llaAVCB0EY/xhrRMmd3LshSTLklncS/eIcND626WmF/ZHtAYAjhfhCRj44/p2QKX6pA6K/VNmcfNymXSchGRTvj/uJqF16AUjnaTnFAWZeuRIqFCITYpKBNkc8pkzefoWVYl/HV3r2DqZhTVJxwJUoj14tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768054408; c=relaxed/simple;
	bh=agW6uKNys5gOeoTrVORTjBOaAxozAsYVc4VUeEIRBqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YvJpsGFaDxc3zUjlNlzDtt3C3QIKzUERc/mjlICp3iaWenx+OYYWAfqeunx2O5u1TGpJOAK/21POVzvNPzKyRm66nGWhBpcmm3LG3LH/OeQyNfyijLqtp/IFSpxF2ikKeH+K9VjEqPWFWUaPiHNSSMnb0wZGafwI5/NsxvQHkHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KwTu+i8v; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-81df6a302b1so1540693b3a.2
        for <netdev@vger.kernel.org>; Sat, 10 Jan 2026 06:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768054407; x=1768659207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ft9yy1vLUwNJD7u+x5LfWhJWNGjlertbzF816wc1jaU=;
        b=KwTu+i8vVe4PjPzD2MKoi/yFtVnu3zAxaXFSXwm7eO8SoL0aSTamAdrmPLoPOMQ4K6
         0TEJ2F8hs0q9fvTBikL2RsWZwgrbr8ipb3hPfRZXeL7fzOZMMofCs9sswusdXD6d6pFk
         RtB5MACqzQt+/ewRh62x7dy0HDBPp+BlkQqvdJU40VOi7rpnzCZx5cTK7mka90xPylJD
         YDPxAIfoHElX6TUTETfYStS59e8VgRKW4QEveUhZFOv8DmFtoEOgtUKPf9oX0Z6jkRoh
         70kLf3LHLzW9zc9MHEuSumoas0OmuJjdUHzl5rZMaSntJJsQcW+2DMQ7pTrXLrdX1I74
         UjLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768054407; x=1768659207;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ft9yy1vLUwNJD7u+x5LfWhJWNGjlertbzF816wc1jaU=;
        b=Cx3rE1X5IDFPtZ7LyoODbbfcio5P/beRQrdqqejVpLQfMYZOfTgG22CRvzHqJnGUcP
         IaozHZvU1xig4e8zCrQzHOcp4MW5xnf5T5kyNPrfZgF48F/Xp6LR580KczVDfVEVS9Y4
         7IjYfTctgczJg5K7NauQOPb63GTdmIU+yHK8zzV/0AFaYl6eppQuyLrVzH2FNGEThJtl
         fXzMjsJYMfr1dkP94uRSc+O5NjyTGBv/yjLVm/qS6SKqbmQ85P+DGvIQ1LKK52Kl9N/W
         SPYJ6nG6s4PIvD3AapLpuxC0ga7RyDDKBq4GNC9SdFaIdfOgfi56w5Ye6bXIXXp0qgpk
         fxqw==
X-Forwarded-Encrypted: i=1; AJvYcCWKw1qQCUFyXdn5qwfyzQVmtGV0bOEaZRmm2oD02DnCLDl0GRP66WnU/0cDbsxOnuOgR1jUrlQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqV028J7IbjekzpD1IJScjfGc5FlJruDPbzHgIWGE4ps9pCz8Q
	qa7lQLmSx/es0vR6fZBfZy0fjI+kHsO9LVQoUv3weW4hh8d53ZtcqBAO
X-Gm-Gg: AY/fxX6NT5Ir9+CGifYPQPlCs5C3iSRx7wNkefYVZpLsGkccxxcqyi/s2ZZkGjMYYbK
	NwUj7bFxpjm8BfLnD89xBBWrc4+88y/cbAYzvAG9yX+LltEBDCWZIvMcA3JPJU5VAQWAZt+JlHt
	6wv1gvVhc4PaVwmnCDLt0mxMKtxr9JEwwgIXm3Zrx6mewsZmnGe9jEazLn5jdM+tIH/autl7G3I
	LkkhZ7wobxPnw6ZMncY0Akx9zOSly/2brabd9Xn2+QcSrttulPGglsXySmBOT4m2wacxgyKz1o7
	7bFtBVRdxOl4sK7hemp1Omfe/KipA0BVClzf+FEy2ZU0kf8L0DYmZw936khi6QkxP9d0Ao7smp8
	onAEyRz9dbBRkFc105V2ecQpB64QEtrEPOgZzgbJ1CDWkkOt3KIqPLtCG6vphV1PyVYQIkNNk36
	ZRB2vEq3E=
X-Google-Smtp-Source: AGHT+IGlvr7nkz2s+OAg6Cq422OLetEIPAeEPAoKEzaZnt/qGoDTuQsWGmx5xIko0mpEb8nDogHi4w==
X-Received: by 2002:a05:6a00:ab85:b0:81f:1a4b:bf55 with SMTP id d2e1a72fcca58-81f1a4bc2a9mr3208433b3a.39.1768054406977;
        Sat, 10 Jan 2026 06:13:26 -0800 (PST)
Received: from 7950hx ([160.187.0.149])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81f42658f03sm1481079b3a.20.2026.01.10.06.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 06:13:26 -0800 (PST)
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
Subject: [PATCH bpf-next v9 11/11] selftests/bpf: test fsession mixed with fentry and fexit
Date: Sat, 10 Jan 2026 22:11:15 +0800
Message-ID: <20260110141115.537055-12-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260110141115.537055-1-dongml2@chinatelecom.cn>
References: <20260110141115.537055-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test the fsession when it is used together with fentry, fexit.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 .../testing/selftests/bpf/progs/fsession_test.c  | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/fsession_test.c b/tools/testing/selftests/bpf/progs/fsession_test.c
index 85e89f7219a7..c14dc0ed28e9 100644
--- a/tools/testing/selftests/bpf/progs/fsession_test.c
+++ b/tools/testing/selftests/bpf/progs/fsession_test.c
@@ -180,3 +180,19 @@ int BPF_PROG(test11, int a, int ret)
 	*cookie = 0;
 	return 0;
 }
+
+__u64 test12_result = 0;
+SEC("fexit/bpf_fentry_test1")
+int BPF_PROG(test12, int a, int ret)
+{
+	test12_result = a == 1 && ret == 2;
+	return 0;
+}
+
+__u64 test13_result = 0;
+SEC("fentry/bpf_fentry_test1")
+int BPF_PROG(test13, int a)
+{
+	test13_result = a == 1;
+	return 0;
+}
-- 
2.52.0


