Return-Path: <netdev+bounces-253047-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sFLbNW5ldGnb5AAAu9opvQ
	(envelope-from <netdev+bounces-253047-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 07:23:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9BA7CAE4
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 07:23:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B3FC6300E6F4
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 06:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2497E2E06EA;
	Sat, 24 Jan 2026 06:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fNDI7oW6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC9C2D374F
	for <netdev@vger.kernel.org>; Sat, 24 Jan 2026 06:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769235741; cv=none; b=eoyD1u4SssTRYWPiyHYRMAwyF07vSC1oxGbAKkT8epXTXKJ1hfmlzV9f3WMArxWglzvlU/lwa5Fy4ysaklEL6k2Gk/hClZfBpP3TGm4Ot7aKtKPtZC3iimR9IOq8vhhw8NgnLUDPEEJQ9PJFQL5fn4HtOIkoXayAm3eTclTFtbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769235741; c=relaxed/simple;
	bh=mSDxwBVD18PlqYhebUKPcoi11BSc/00xy3TAGxUREuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QF9XWYPpUjPy0v59G8e1wZDrpeLWxEbs0mkSbXeuZhySRd5F937wFIJqqLrlOMWHELZ8tGqPENhB9TLZk4/c+aF5jU1D/HGTdMK+KFr6/nb2D4h4umLvT8t6iQB+beZIFBFzA2rk5vn1hLsSYX3u4YFQb0HFU9PahEpGfx5EAiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fNDI7oW6; arc=none smtp.client-ip=209.85.216.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-34e730f5fefso2030106a91.0
        for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 22:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769235739; x=1769840539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P6couASguPY6BXT1cGXkKjPK1OxE68MmNkjTJGExLgc=;
        b=fNDI7oW6EPwAxhle9ZKxHbH1rJD+lz+UF3NH3nFrSs7WjFMBY2iJJ4oAjlBG8HFKDj
         aB4qfOQPpF3u34T/RbZKgTDit723u/w4hG6B7iuY+3cWo026u3E5ToXv/myxFcpV3qm9
         ZdTEMCK3KH5RGaXoqTNw90BTjfjy4G5iyG0l2KFeOTrpcr7bOOCD7MMG8t2ozN6Rk04s
         o9vCsM2Oi9e3Y29+2DUCzY1xe5HQcQ95YQe8j1/FNfAl4SwqF/6aZ9/WkblVX0/6LWc2
         JPxpLMtud65Q1FVWlgCnFiEviMrI+wGkwj+hG3nwYJ4KyXXm2EuX8Qyj9gp08W0RlApc
         bRnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769235739; x=1769840539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P6couASguPY6BXT1cGXkKjPK1OxE68MmNkjTJGExLgc=;
        b=VZimV5EZZmRF/2Q+FNpj0nx1thv0iwyMU4MtbT7Nt7KZrH2IQmCg5WYvCVqB0tAezQ
         5pgbPcxOP9+fQaV8ZcP21Jp/x36BQBN4+pBDBtAyOX/XyEKXopTTvK+YyeIk2wku+yqb
         HoJTUQ57bn4p5Jzywbr3IR5YYWQwSjtg3YWYOtjHw07dHwC/GOL9ztDz6TQRBzN87BOq
         LOq2Bgl/v5uJ5lvpYReUFXE5NMEeMOcGDwynvR3bjwyDGgX/gFGqXuSlEmnFF0kbdYdh
         lP1yC739+bgvGJp7Dgtm+3T0xAdhyymxqaICYJCbY/Y3ERoNEiVYVsDgx81feKwUbkdK
         4o+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVmvMEXlgRvYwwRK6Kae0Q8TYSeXxVP/BiZQ2vP97JaoYgOQ7rJ9p81NFxIC14bwIJAOjStELQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhsDLtbwOt2M7hTAOt76sFabTsDL+yx1U8cLGiazVpEZUeOlkd
	xg+uXRFlP5H0HvnAdPj5YZmlSvB8sQ3WHVHSTGBrfOk9QapAYoDQwwmz
X-Gm-Gg: AZuq6aLUVG3ylVWWM2Yw52CrwuoJITLuOPyIHbt2tifOhQ+fmtO2944pFdnP3WVUB7A
	oNDHrP1lACwtItYzC47pRaLtwOnvxaXG2X2ZMhHaZaTHJ1pH+uOXYrvJ9d6ALbhuu9WkESBsxRH
	y5sHHJIx/OoMeO7XNuZYU4+2DzPODeM5XONy3k6+1bmqUqA/tm5YFjqF/sqiWBnINfF47WAzDO0
	9ixosxbx9JCnM6eFh73fqDu654KMWuG8jzKVr+06Li+mB0l2gAiUKlafnd7ZrQQ2pXzxRmjB+3p
	L0GyJWZgHRQRyQL6ICdLpxAsWtH9s5oND6BORCLkECvQBfRsI/L9yCQ+dUX9JmLUO2rRqhb8D52
	mOWV5xik6Yi4THOdjBBTybU0mRH+98aRMIjBg4RsKogAon50QQ4zgNwKzDZBoctHvvwOjuwhNmV
	KaBMOiHGOd/ABpK8Pca10=
X-Received: by 2002:a17:90b:3c05:b0:340:bde5:c9e8 with SMTP id 98e67ed59e1d1-3536894c35cmr3832652a91.22.1769235739094;
        Fri, 23 Jan 2026 22:22:19 -0800 (PST)
Received: from 7950hx ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-353354a6b5asm6496537a91.9.2026.01.23.22.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 22:22:18 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: andrii@kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
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
Subject: [PATCH bpf-next v13 13/13] selftests/bpf: test fsession mixed with fentry and fexit
Date: Sat, 24 Jan 2026 14:20:08 +0800
Message-ID: <20260124062008.8657-14-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260124062008.8657-1-dongml2@chinatelecom.cn>
References: <20260124062008.8657-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	SUSPICIOUS_URL_IN_SUSPICIOUS_MESSAGE(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	URIBL_RED(0.50)[chinatelecom.cn:mid,chinatelecom.cn:email];
	MAILLIST(-0.15)[generic];
	HAS_ANON_DOMAIN(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,google.com,davemloft.net,linutronix.de,redhat.com,alien8.de,linux.intel.com,zytor.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253047-lists,netdev=lfdr.de];
	R_DKIM_ALLOW(0.00)[gmail.com:s=20230601];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[menglong8dong@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	NEURAL_HAM(-0.00)[-0.794];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c09:e001:a7::/64:c];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,chinatelecom.cn:mid,chinatelecom.cn:email]
X-Rspamd-Queue-Id: AD9BA7CAE4
X-Rspamd-Action: no action

Test the fsession when it is used together with fentry, fexit.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 .../testing/selftests/bpf/progs/fsession_test.c  | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/fsession_test.c b/tools/testing/selftests/bpf/progs/fsession_test.c
index 211332bdcccb..86e8a2fe467e 100644
--- a/tools/testing/selftests/bpf/progs/fsession_test.c
+++ b/tools/testing/selftests/bpf/progs/fsession_test.c
@@ -161,3 +161,19 @@ int BPF_PROG(test9, int a, int ret)
 	test9_exit_result = a == 1 && ret == 2 && *cookie == 0x123456ULL;
 	return 0;
 }
+
+__u64 test10_result = 0;
+SEC("fexit/bpf_fentry_test1")
+int BPF_PROG(test10, int a, int ret)
+{
+	test10_result = a == 1 && ret == 2;
+	return 0;
+}
+
+__u64 test11_result = 0;
+SEC("fentry/bpf_fentry_test1")
+int BPF_PROG(test11, int a)
+{
+	test11_result = a == 1;
+	return 0;
+}
-- 
2.52.0


