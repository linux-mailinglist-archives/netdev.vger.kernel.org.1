Return-Path: <netdev+bounces-252669-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MFSKHlomc2kAswAAu9opvQ
	(envelope-from <netdev+bounces-252669-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 08:42:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AB98271E90
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 08:42:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BE42B300BE04
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 07:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1364134A3DB;
	Fri, 23 Jan 2026 07:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l17vT96q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD0B346AE5
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 07:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769153848; cv=none; b=K2Dc5TmbVIC/QtZXombFOsojVg+Ybf5UYv6JuI4BYhPdjAljlnNZYxuDpMM24hzLSD/HgrmtYuXgIYeXbhhkdV/tQ1EBu9NT2TZNxdL5xjUGAxXnO2fFv4+rAdMUU3btrdmU2ZEUSuN8VHKOmdwc2Ss8neNKHPWLmENHTFRayLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769153848; c=relaxed/simple;
	bh=mSDxwBVD18PlqYhebUKPcoi11BSc/00xy3TAGxUREuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hq+TXU6IJy/I+PF4uHyYu+TjA6cpYIUDrlEWDgFzB2wOJGd9QUbUbqzLHMg1RE8df/Bor+qWHy/l4m/1+XYb16Y3JLYuO0HBT3gqvLbgNNHW7LPEt6hE3ATxgHHqmVNGYr9QzuAW8IeIL5oKriDcHpvQqHqNgBv/9OT1BUGfToQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l17vT96q; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-81dbc0a99d2so986090b3a.1
        for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 23:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769153846; x=1769758646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P6couASguPY6BXT1cGXkKjPK1OxE68MmNkjTJGExLgc=;
        b=l17vT96qqwHbs72Ym+kwBHiOjfu7n30Z2pRTgJUN2R33YQbfV5wTbn1GIrGad4KkRW
         Is38vaf7kOxzDUB/MwsT3BdICcxC+bfnDc43umjxIYjyc7PCy//+KB+mZrz7QbvyIKMw
         9MBT6LwEZlW/K7Mbk8fsgNJ9kjc5W4LTGRkTcfgXXENiLGm7XGrPydK7WpfL/GrsR7KU
         LQTjELHhp30SesMZFHiZBe0837JLvUSq/maAzThLG7ZbuA6FPk8lZewFIzHMJCno2h43
         RXDCVLRNZMWK9JMIlCG6NGJVcYAYC8pUVbFvSFzQtE+tuwPLN6kBlRgSEYkClHxDtARU
         kGpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769153846; x=1769758646;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P6couASguPY6BXT1cGXkKjPK1OxE68MmNkjTJGExLgc=;
        b=v70f7UW/nVj8eU07srVS1B2BktxVo0SRJwRD427WgqaunYLimy7q5KV3ewU5uiayCe
         nRE1Z23B6vH9kEruXl6lV2wSPOY7QwVLG3jB09+oNwFUB+IuX+jdCeQjdSZdjf7BIosz
         Df89IFcTUmpuR9ZYvNHZQywVd0tP7EuAXXBHE0FYZYjtqzqljh/RgHY61S/xf4jtZ56n
         JbDwpxq12VcfqyK+xA9H36YqSLvO04fcwC2QIvZS3YTWYFsjOUNdThSbHqRHzQIZVEeJ
         fN4rmgmAPXPC4zzq7jlLW5FnCI8DQ1xfc9C1xvueroRwsPCVaVwbccX2rmgDLouP7aZX
         121Q==
X-Forwarded-Encrypted: i=1; AJvYcCVP6E0zxqTmxAWyPvY574mmQacPuhIR47DEr488XbJszRs3r4omOI/M9feLBgHlPhiqG1ghsH4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxtl6vD1q1PCvOd6AW7ydPEWn7YwL/krn8fPEXp1eTMi837gnzR
	jbmQTGoxQIAEvp+BMjdwXgHipnoC9zWvYlXIYCAMzw2VlpihWJSqzdB+
X-Gm-Gg: AZuq6aIaueFZrF463Fo0iNnAgbADrL81bWoeYByDARkpKto1E1NlCTaep2P2BXkHAqc
	XUrH6QH/fUaC4tfexIVdRqqo+3L15apeEbQk+cmZnxUt++RfyayJxZQJwyYYIgpC7UtthQbug0C
	/R6QaPD6t6Zr4pC4VTqY/zi4nJQRW1GgQzO5wfuEd+RUoLvAsnAmKtaIQ0/pPJDrw6GBHxsd2Hv
	vviKl2Anjw6uwdX7ihKGaT5Qo9AYtt0GfqLdzYHlqO0KPtRq94E0nOT6qyNr4K8+mP+PXZ8hzu6
	XpOlERVIP2klmDmD/E13QYH6duZQCATSaMA5c3/2yL2qBVtXieOQ/9VuwqXpJrmqTMMGa+7cbzT
	Us1UZKcj+FowOhN4kN1Eutq/tqHUX/RRbB2KvGG+msNDpj/eVZ2ISn0Q+6YNtyuUSKrNXtLIOsz
	C7MYNFsM2d
X-Received: by 2002:a05:6a00:3ccd:b0:7f6:4922:89c4 with SMTP id d2e1a72fcca58-82317e4497fmr1780587b3a.55.1769153846166;
        Thu, 22 Jan 2026 23:37:26 -0800 (PST)
Received: from 7940hx ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8231876fd1fsm1334205b3a.69.2026.01.22.23.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 23:37:25 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: andrii@kernel.org
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
Subject: [PATCH bpf-next v11 12/12] selftests/bpf: test fsession mixed with fentry and fexit
Date: Fri, 23 Jan 2026 15:35:32 +0800
Message-ID: <20260123073532.238985-13-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260123073532.238985-1-dongml2@chinatelecom.cn>
References: <20260123073532.238985-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252669-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[iogearbox.net,linux.dev,gmail.com,kernel.org,fomichev.me,google.com,davemloft.net,linutronix.de,redhat.com,alien8.de,linux.intel.com,zytor.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	FROM_NEQ_ENVFROM(0.00)[menglong8dong@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[chinatelecom.cn:mid,chinatelecom.cn:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AB98271E90
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


