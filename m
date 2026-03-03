Return-Path: <netdev+bounces-262996-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDGUF4tKpmleNgAAu9opvQ
	(envelope-from <netdev+bounces-262996-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 03:42:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0051E8237
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 03:42:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EF8DF302DE17
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 02:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9413C3750D4;
	Tue,  3 Mar 2026 02:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="Np2dVMar"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CD22F851
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 02:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772505735; cv=none; b=BQngB6IHDZsYKDJcGTXZ6B6hREjT51RcFd/bJF/9prcWmaN5a2W3kRQCGa3+92/1kTuYsC45v81CueKZtlcHi+KU6uvp+5giI+6lNf9xvVmm8xRw2jMuYs2XoD7fiJTb1kQ+Gz/RkQ3amdNYj/iVzCX4duUe+TXDlNu2TwbS/QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772505735; c=relaxed/simple;
	bh=nPHvYWIyTpes84UYMM9k1Pnv8YqRO4x+er3yMBzuJUw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RgmAzAGEZHpt2R3jsZ/HWoJJIUcyC0Wm3mj2fgTR/0GVR5Po0fgr+2mEaTtwcKkJjPM88ouqHNaLtmdEiRug/+ciPigqM6z9xAX/SydlX3HcJPvBaslUnoZwjfHtv1LMZuk/sUloqtbiWsz4RGlhPcFELJpSCd+QrE9oUeGVtsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=Np2dVMar; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-823c56765fdso2509608b3a.1
        for <netdev@vger.kernel.org>; Mon, 02 Mar 2026 18:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1772505733; x=1773110533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qoKys6T11lMf1hgDGtK7vu1+Ox23J7OSlzLZflNqFkg=;
        b=Np2dVMargdb+PJOwcJE3P1v35uAdoi/jJZdGkU6iE/+E/QrC/XbZcZZVWfc3TaODDr
         13cZXuJintJYmiONtqtXqxSgjz7jGLYaKkwiaUi394FM1Dd8tje41UMRsLB81d2sUo5I
         8BRl/GTdYZPLwteQo2uYPLpkibTO0wiVrXHoh8eAR4GpqTMug96W2V2dtn7TSki+Qz39
         uW/JYyn8kgtFS830Sg0oJMLpquDNYNnkZqfp3sDri05xwLjnSb26kJMeJmm6E2j9zuQo
         +zcV5+dm/kiVBRS5nxCMRUtZ6Q9Kom1Otso2PrG3G2mzdmsLi9BROK830PAakqfv8tmV
         5NZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772505733; x=1773110533;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qoKys6T11lMf1hgDGtK7vu1+Ox23J7OSlzLZflNqFkg=;
        b=mQ67SQR/GfRyM0piXhaL6mQc8f29odBT0DaFXD+McBnIzg7fYYDy+f5cO4MyxqmOnC
         9TCGl/jauTgK5ovSuCp9b9HzG8ujlNVDQUSN8WiFhXrH6orGaAkP1f8iUXg70d4Ep+Jn
         oSdpCDGbC9huz8Va7EQAAyR/ZmZsynXPXyXRGFXqp8J746K+RlJusDcbXO53mDQW4fJj
         u/Aw9JmgSTEl1oLWEozGPmIOXsVqoGUwlYxmxBkn2IPjcfKZ77EZ6VGSDwyJ5KnITn0J
         XwgM6D+Ehk2ekxrlFKHZl3TDcYqg9QK6TmqXyKiDan0HKv8HvKhgMQG/RHOGDgY4b+fR
         w4/g==
X-Gm-Message-State: AOJu0Yy193TS+5GRrsVfAEY7jM/zBS4VkbqZFT9sq1pxZgldW8EoB69o
	lfD99zoezWsUrddj/ypHDFN2quoGjEn64y+hr5LGQiPhTeSAvGPJohjk3RwSkQbsrDnEsNB+SE4
	+EW47
X-Gm-Gg: ATEYQzwkplm6FkBV8NyBeysB1YBYsmdjEXWTdMpdZ2MPwQdzPs1Hpgpr1BG4s3TUl2M
	aKSeEpQfQ2VMLBsu0ZaRzlFLKc9xU5rSZXIqDMphsPySIu5wgURdAtW73ebDfBXkINpfvOdjiQA
	P59gMw3C7N9xJOiuKu39Y7RbUIeO1qNjxS1JefjBkjCDrX+vEBg3uYTGu1OxbRm6XKECCsOvihj
	l16EverEpsWs1132tfZT5Ohn/mFhZmAwbI92IbPMMdLfMvNSv3BwwhmnRJ+eJiAki6iHT6IKTVj
	Xile7ZKEy7q8j1AottdL5e31TttTFGNVdimHQg1zC3ITVvXi1T/fZ5pgFpRw3LUNpkN1TjghdPQ
	RSoBpDVl/F64GASF3KXN2Irmv4AR9c0JmkDMIEhtRIWWDVC24lysv8Jhs6O9rnRJzpFP6rrs4mL
	chi3c=
X-Received: by 2002:a05:6a00:9518:b0:81a:b602:daf6 with SMTP id d2e1a72fcca58-8274da04c23mr10808437b3a.48.1772505733570;
        Mon, 02 Mar 2026 18:42:13 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:7::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739d8c7aesm18082418b3a.21.2026.03.02.18.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 18:42:13 -0800 (PST)
From: Joe Damato <joe@dama.to>
To: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org,
	kuba@kernel.org,
	Joe Damato <joe@dama.to>
Subject: [PATCH] mailmap: Add entry for Joe Damato
Date: Mon,  2 Mar 2026 18:42:01 -0800
Message-ID: <20260303024202.2526604-1-joe@dama.to>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8F0051E8237
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	URIBL_MULTI_FAIL(0.00)[dama.to:server fail,marvell.com:server fail,dama-to.20230601.gappssmtp.com:server fail,muni.cz:server fail,hovoldconsulting.com:server fail,tor.lore.kernel.org:server fail,samsung.com:server fail,fastly.com:server fail,quicinc.com:server fail,codeaurora.org:server fail,synaptics.com:server fail];
	TAGGED_FROM(0.00)[bounces-262996-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DMARC_NA(0.00)[dama.to];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

My Fastly email address is no longer used. Add a mailmap entry to
reflect that.

Signed-off-by: Joe Damato <joe@dama.to>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index e1cf6bb85d33..a02e9aa9aed4 100644
--- a/.mailmap
+++ b/.mailmap
@@ -396,6 +396,7 @@ Jiri Slaby <jirislaby@kernel.org> <xslaby@fi.muni.cz>
 Jisheng Zhang <jszhang@kernel.org> <jszhang@marvell.com>
 Jisheng Zhang <jszhang@kernel.org> <Jisheng.Zhang@synaptics.com>
 Jishnu Prakash <quic_jprakash@quicinc.com> <jprakash@codeaurora.org>
+Joe Damato <joe@dama.to> <jdamato@fastly.com>
 Joel Granados <joel.granados@kernel.org> <j.granados@samsung.com>
 Johan Hovold <johan@kernel.org> <jhovold@gmail.com>
 Johan Hovold <johan@kernel.org> <johan@hovoldconsulting.com>
-- 
2.47.3


