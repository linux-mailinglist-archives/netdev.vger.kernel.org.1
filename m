Return-Path: <netdev+bounces-253019-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aCtIBqo+dGnp3gAAu9opvQ
	(envelope-from <netdev+bounces-253019-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 04:38:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE307C610
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 04:38:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 93F9D30946B4
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 03:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32FAD26B0B7;
	Sat, 24 Jan 2026 03:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GXqWxvSl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C8D26980F
	for <netdev@vger.kernel.org>; Sat, 24 Jan 2026 03:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769225609; cv=none; b=k3WZd+sGNSi26lFFIBRV52C6OUkKWo8ffZb8cVpqjjydmXzSh9ow8RlXHPc6Q8FqgDMW8veesNKp/mtuyqziXr75SJCb3AaqJ+x+RnSPGg68zXGxYDViNQ1WawInQ85ZDs2vAAK4ycE8qRaRB3afulY9SLwysRm2BWGGu8sBfgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769225609; c=relaxed/simple;
	bh=mSDxwBVD18PlqYhebUKPcoi11BSc/00xy3TAGxUREuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AUoCvE7YdFeZtyE9b0y+ZqQTnPrWkyP4NhDbJVsDJeYuyfi7c/pgbNYuY09bOpKlIQJgaso+VMvc+SRrhSK44Ae1jfIs1HTHJe30C2oUFpdr/hlECzi9h7GhwLhup5tqUWKS2tmqScwYA0l/nGRXeTAa33gKax21W8vv5kdUvd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GXqWxvSl; arc=none smtp.client-ip=209.85.215.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-c633984fbeeso933726a12.0
        for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 19:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769225607; x=1769830407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P6couASguPY6BXT1cGXkKjPK1OxE68MmNkjTJGExLgc=;
        b=GXqWxvSllPoUHku5fRetKn5YH8J2FiH6yyjYxkQXeL8E8gSQlfmRFIJqVAMdXyr99A
         gOSVXECcrsEB4IFRKXh2pRkBo/F7PRbdcqedpviG81S5U4qA8KB1G1ey8tinz6gLmMxV
         Uxzce1FTV6MRUi88xUCaangX8jr834zx0GxaEH0qJqwaXNH5ODwIoq6Ue+pvm2wch/QK
         6Tl1kqcBvun4xDj4Z/ooQvbe3DJMj/A+zCC5YqcDAcNLAoVM/nnK7neyuajW9gL4F5ws
         WAQf+1QZx+M+x1hm6qq2jp3xoxI9yt8vwQnySLFz33QI11te17STam5BHYDY7jgDktif
         98OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769225607; x=1769830407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P6couASguPY6BXT1cGXkKjPK1OxE68MmNkjTJGExLgc=;
        b=Z7t7hto8sd3Ssk2ZiVTXVHjOIF6DbDpfYmMjt8yywvoUhVwgj/9q6+6FkiI3OW3LKA
         xcVbdVzvpJZJvvFABo6XTy0se2W47lr6yr4A42+GJWvwIgDjUg39rgV7ug7InVpMy1+o
         76eO++k7tFM7o81P3GLb4XAAhjJE8nbTXK5cTyQUOtW5C/2fSRhNScq9fvPN66N7jS2h
         IRHmJRuygziIkx3bG5J2Z/UA+F2d+0H6tyVJihORfF5hIew5hDuev80jy+Vb5ssL9RvO
         AHIkPHuIp+Y0Zxs0uxKUdt/9HdO0QGyWvAHf7H7bq1e1pyX/3W35SQHE0EleZsZuPRla
         cPUQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0inZqH4CAHoaxl9lAicVyW29brOTi6duSwZDUQs74tcEs3VG0TGAuUjb7iLvLmEfR+s/+Nv8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yywio+u6uUAO8+jD9M3LwuqYPhhhHWpopDnMswhoTqP0nPwWKVN
	7nROOheXNs1cAgOGZVWoG82OyPv4BYS6mOqaH3bBivqiIqdS4eeF/Seb
X-Gm-Gg: AZuq6aI7/ak93/jTIjTMPtcNrtKd6Qnv9pRsTxCbWluseJ4mTuJcpbuZMr1JAxYTIWO
	nA+2DcrMWJE2PNME3Szyv+NHWUJIyYkFVT9KRkMsIL3/D2dyPhAjDYwudcMeuv4tLHSAh5IIgKz
	51vdiO1vHBS8x6FtL5gxJNCzPym+dOdmv1hGbTTuCxsIfoUG360bTZc63AojQ0IWumDj5LYonJB
	kJvJ8XlyxnwTF+QcleWVna6r6IaLXqi5r5pXdpkogSHy64wFZ1vIUK6X2d8dXY1a0G9MLgILoA1
	iVrLDMhVJToIz+RUcUTa5+R9zyoUcHY5dINlMr37mbCMa1G09OYWJ+f/3qvlPOVNo1fhcrdeEp8
	lOAw6XhtugGLlrgGes80a+MykGIQ/BzaF0uu6CcqkLXBBueZlLvRO1DyY0iZ7EiO4v5e6PrMbaQ
	woS8ACSV8R
X-Received: by 2002:a17:903:1b25:b0:298:45e5:54a4 with SMTP id d9443c01a7336-2a7fe73faafmr35282315ad.1.1769225607207;
        Fri, 23 Jan 2026 19:33:27 -0800 (PST)
Received: from 7950hx ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a802dcddb0sm32539805ad.38.2026.01.23.19.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 19:33:26 -0800 (PST)
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
Subject: [PATCH bpf-next v12 13/13] selftests/bpf: test fsession mixed with fentry and fexit
Date: Sat, 24 Jan 2026 11:31:19 +0800
Message-ID: <20260124033119.28682-14-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260124033119.28682-1-dongml2@chinatelecom.cn>
References: <20260124033119.28682-1-dongml2@chinatelecom.cn>
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
	TAGGED_FROM(0.00)[bounces-253019-lists,netdev=lfdr.de];
	R_DKIM_ALLOW(0.00)[gmail.com:s=20230601];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[menglong8dong@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	NEURAL_HAM(-0.00)[-0.840];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_SPF_ALLOW(0.00)[+ip4:172.105.105.114:c];
	DBL_BLOCKED_OPENRESOLVER(0.00)[chinatelecom.cn:mid,chinatelecom.cn:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8FE307C610
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


