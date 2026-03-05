Return-Path: <netdev+bounces-264241-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aAnhJdVLqWk14AAAu9opvQ
	(envelope-from <netdev+bounces-264241-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 10:24:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BCBCA20E525
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 10:24:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 19E2D303E314
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 09:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5B0378812;
	Thu,  5 Mar 2026 09:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PwemhpW0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96672378815
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 09:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772702554; cv=none; b=TGwpjuYHbACaorx5LXaXZ0+JNH6Uvuw+DuGkTATl+PyJQSe2D1XZXZeBUdKJhmYjH+tuEJkZFX1+JJKe4BcY8ENc3pUhVm0lcmejOFKE9TRO03+IE/pTZFFie4E/SWn38X0B0QDQZHdlpKNjpL7s6N/SCs854+KpVmN320Cb00I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772702554; c=relaxed/simple;
	bh=dYZDEIYcGDDCKCSK5WQGTMeJS/coZs66ym1GE96/J5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EGdXPwSdIEzWm2Owoc9FYvCFGnhpX+QhlPCJTRuF4PqEd1dsu22mbp3BZ1zR7k0fkpZnu2pXledXfu8w2dQ3qlsHAEZclBTDEv/QwAmumXpya1Zmrh/wHKcTAruECJkGa8N4wQDsnQXFUjurKM0cElbL9V0rwQ73zAbdmHQJr7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PwemhpW0; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-82987437624so269231b3a.1
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 01:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772702553; x=1773307353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2uyvuUTwLbkE6jxPZnMZ5J4m41aIY7BYEiJ0R23tsYQ=;
        b=PwemhpW0R83JAmXmTaWfZ9ywyil7JFxC5A76ERZU66OEWxvNExbE3eIvOtcM0wNyMR
         W08M11fZcPMnqgtccC5cl6Kvw34wwleNIkyJwyP5ir1CNYcCJrd87UZMIYIeaeTYmLlc
         WS56szCdxbE33mzeaOn43NB5XhpkAp3uhF7Zu+bhShvsxNvB8gUzR7XLhP3l1aqdtOuS
         rPaOmn7roLkJ83eFVBUUhIDke7GiHkc3CwKA/vmsLVyb1SkgLFJI2/Pu85VQzPX/c4ad
         7+bKOCb83dq2kwqw6pf2mHPvGTGcLXn9AMC7tqXz/cjn3a1/ru+wopxJ7l+P2fnPU8HH
         dCRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772702553; x=1773307353;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2uyvuUTwLbkE6jxPZnMZ5J4m41aIY7BYEiJ0R23tsYQ=;
        b=ZzHmzCRIa7mxOzoa6xgVb15RdKfQZq+X1WeH4UXbyloMmCl4RWrGHcG/SafsDqjICE
         6i/G8eDTMoXHP20b9i6QvqJYHZW0yXzvZVG68swy4Gk4MSQw3amdio1oO9Rn7JRgeVlB
         cPvecWqpn8+c4wDCGGxTSaOVgk+zeVC7VOjmKjK8gDLix6z7+S3CAokb17Y5IgVEP4iR
         nJaYti1GUPMRv/P8ImNZz4OsPZcsU/NzerT9ddTa9WTQ7QvlAz+zPzxRcpDv9z8VgWWJ
         g+OqT+XKBh1GnMAw2wUNGoOSuxbkHQt8qiWfULqZ5oxzHxDrmw0kjiyGIA9M7lFm1w8J
         F/Eg==
X-Forwarded-Encrypted: i=1; AJvYcCWbSNSwY5jLuEAJODN+tS9yB1DsS9+ZLt8JpKbm6RNDQu97DzWwTOegGQIIXjDM8HiplzqOUzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+P4QUtSZDJ04qnYyEKCVdeZsLJTcO7B0amDQ1NBCVUTnEfIlR
	/av+Ly3MpaPT9+n23jwz6N5OpkjKYEekiL3lr5tIChlC4VTXxFi8rUdp
X-Gm-Gg: ATEYQzxivOCpR2MhTCIqPsJya8lo+XmUu5WceoF6hTH9f9XbVZkgEBvX1n0qwCo3U+j
	/jmlK/myX9Ftg6vZqhmCETzL+QAeURK/V2mL/H1gllterbp3If445fIHycQGd2X49vzA2GE38p4
	gyTfBuqyg26fMdnx7t/EUfCAnwTd+gp3aMaQpK53eDdNwcMX7RN6isFXkDXrbRsM476yJg1AeVq
	G61mpjmYzvyzp2ng2F2L8H4Y3MiFnrxYDn/cnpL51132HIzyrYenv3gnLhLzr6+Fqf5225qE0BD
	qoeLuvYpVi5Fd7t0sAx2/Xbz9VDH956kEU/aHvvJ8SN20ho+pgD7TmsQLhMFB/n+7rCYjweK93w
	mZLI2+rLZB8hUG56Xoi8fEZEl2QckuSt9dVOwQYH9MIHNZIUsAvU9GpMrSjctb+YMN4OpYW2TDR
	oWpkmX/7nYRqqn8ixgNR/98EZr+U1kIZ3qcUr2ghozzeYl87q0wTX+huAtOlDK
X-Received: by 2002:a05:6a00:1415:b0:81d:9862:a140 with SMTP id d2e1a72fcca58-829855dde46mr1547767b3a.3.1772702552996;
        Thu, 05 Mar 2026 01:22:32 -0800 (PST)
Received: from ubuntu24-04.. (120-51-71-230.tokyo.ap.gmo-isp.jp. [120.51.71.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739ff34fesm19718200b3a.42.2026.03.05.01.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 01:22:32 -0800 (PST)
From: sawara04.o@gmail.com
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org
Cc: Kyoji Ogasawara <sawara04.o@gmail.com>,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH net-next 2/2] net/smc: Add documentation for limit_smc_hs and hs_ctrl
Date: Thu,  5 Mar 2026 18:22:24 +0900
Message-ID: <20260305092226.27379-3-sawara04.o@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260305092226.27379-1-sawara04.o@gmail.com>
References: <20260305092226.27379-1-sawara04.o@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BCBCA20E525
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-264241-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sawara04o@gmail.com,netdev@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Kyoji Ogasawara <sawara04.o@gmail.com>

Document missing SMC sysctl parameters limit_smc_hs and hs_ctrl

Signed-off-by: Kyoji Ogasawara <sawara04.o@gmail.com>
---
 Documentation/networking/smc-sysctl.rst | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/Documentation/networking/smc-sysctl.rst b/Documentation/networking/smc-sysctl.rst
index 17b8314c0e5e..67c2bdc533d7 100644
--- a/Documentation/networking/smc-sysctl.rst
+++ b/Documentation/networking/smc-sysctl.rst
@@ -111,3 +111,27 @@ smcr_max_recv_wr - INTEGER
 	like before having this control.
 
 	Default: 48
+
+limit_smc_hs - INTEGER
+	Whether to limit SMC handshake for newly created sockets.
+
+	When enabled, SMC listen path applies handshake limitation based on
+	handshake worker congestion and queued SMC handshake load.
+
+	Possible values:
+
+	- 0 - Disable handshake limitation
+	- 1 - Enable handshake limitation
+
+	Default: 0 (disable)
+
+hs_ctrl - STRING
+	Select the SMC handshake control profile by name.
+
+	The selected profile controls whether SMC options are advertised
+	during TCP SYN/SYN-ACK handshake.
+
+	Only available when CONFIG_SMC_HS_CTRL_BPF is enabled.
+	Write an empty string to clear the current profile.
+
+	Default: empty string
\ No newline at end of file
-- 
2.43.0


