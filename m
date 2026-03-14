Return-Path: <netdev+bounces-267806-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cDBjFXmgtWn42gAAu9opvQ
	(envelope-from <netdev+bounces-267806-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 18:52:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC4B28E3BE
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 18:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 037333012BD9
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 17:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED9832D0FC;
	Sat, 14 Mar 2026 17:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="hdIc7rvJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D0533987E
	for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 17:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773510712; cv=none; b=cUnnpp9fiFRoHt8DEBlRZPMQbLS/iexawQMuOQdWHTMWl6T6Gv1MQmAMsEG+2CUjnOVA3f2m63Bbxj/2A4U12EzSM1BFikcoBJEcDTx60Bhzmiv/BZUnkIwym3hz65TOxkku3s39QBinIZ30QmCCU6wDfDsZHCJ8f1CEQFiJjzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773510712; c=relaxed/simple;
	bh=uItdHPzM8/YhmEnZVDdGZfkeDxlbuzv/yCC5R1HveNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WruHcS/dxaXZlmCBccoT70uI0SuVu78RPhQrpI05CnkHLZai1ZLVxtYfh2KAXWEa176Srxfvp8K+nUQ89Zev6uInIZRir1FF1x726X0pPY9LBTlsBOKJlbBZOHw07BHlDrg/WNDLMtJbH/tQY93enFo5LlH7dyn1+o79dGwyWiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=hdIc7rvJ; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1273349c56bso4827482c88.0
        for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 10:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1773510710; x=1774115510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A6arbcjbT27jtKab9iAQCIQYW6MTuFeHR9L7LFxRYIY=;
        b=hdIc7rvJdGSMWdd4TmsVsxU+JfJDlTR6oEEyWq8z4S0k7H+LLqy+FtKL592a5MLBXi
         Eluscw6cRIBi8eWMhXwZX0is7v3Bh/3zZFx6rCmp8vvnF0ElpQ+VYeAv9czJDf01QOIw
         gXH6eBD9D9WcXrcfkp921xOuRKPWL4yT5wXY2EKMUKaWemoGHs7MiRNJgrI9Va5UjpQS
         HcNxQLpSfSv8xNERl10dFN2cWK5TZpr9YoaVJ3MIqwJjxx7xOcKqAqudrMnG7iYHP/sV
         DcOpiUoBKBmbfFGnCTagC3XNk9SJPA01SIfi1IHZ7xajAYImnGTZjeoyNCkOYCiwzgtI
         5Trw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773510710; x=1774115510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A6arbcjbT27jtKab9iAQCIQYW6MTuFeHR9L7LFxRYIY=;
        b=s4KiRpYtYDuV2IDNHE29aWSQXophZvAs66gCITefK8GOA3UzsB2wgzzqSrjVh4QCh2
         0LVRoTAgLv9iohOlTZ1o+YMbmhg8usfwabHb8HX0AHPrX4gY3cz3M1J1gjEKvYPpKNT0
         W/iekiCUou/pNUO841E6SPTuzKncMLYPdfgiuXODyvS73JtaTeNL39TJjq8J8qA0MccQ
         hXTd4jnNEv3dYBXlcDV3AliJmJu09ftVKAm+xJ0sWkCxppCLSAFq8QiquUv2HRU6r6Zf
         0qURucLdIpPNFdhAZavMAsFd00rOz/ESrVGVBmcO1+YU7WnGq9KkNNvmMfZO20Rl5o3c
         JDUg==
X-Forwarded-Encrypted: i=1; AJvYcCUejh8QOy9plwWceE5uH75Qdn/7mYnLa+Ds06xYNuvKnaIx2gDPOzvgN60C0XSzOxeGXzHXhiU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxB9jeGeT4irYdc7Lahf1n7vysOAgAibPOUn22TVMIVmADnMLTj
	sy7Fk9j9YGs+DTMIrbM//VFyjCH4b//VBWmRMqksPZFmegZK2MbXFB1W0TQfp0NlNQ==
X-Gm-Gg: ATEYQzyI3mRPUbSnMzma09jVT5enPYw4SSoV5Ge95N0vafRWgJE8Zo6cjirfpMtQgal
	XJhFHozJ+YQrwglQkbQi10miuZ6mN78CDBsZS1iauhlcuHD4jVNX5pDuWCLq1R/mYkj5Rzf6/N1
	Mhaq0nA6Ys/pPqDnVhenncKBzO2QVAO2AZxJ/Rm2fxFwj6DOPLI1dpssZCjm2E88d9Z6v1TCLza
	siNuATklLvABJawybIS3CyWNOGHErCyx3gURBgr+iyqRY5aPsy9Ql6NgvsxdJgcSDh6XgE/m6c7
	qIHoedtZ/P62CCcxAVGezelKqu3A1DyZwmjCM3AFzm4cyJrmHHe0lpc2UamPq5dqqqXC5glvzqP
	QflLhs/u4kBqN8icNd3jbF3pOxKiYFq446hEsIzCm8hiTNUY6Uc9DgMvrZTOeQTXqzVJHAMGqbc
	l7+wXnJddO7rqxtd65h0tcNHlpOizCn2Fq5evCqU7HPMESXisnQzz49UNM97OQOHfZt6xBmQ==
X-Received: by 2002:a05:7022:f97:b0:128:ce44:be8b with SMTP id a92af1059eb24-128f3dd1398mr3270442c88.25.1773510710284;
        Sat, 14 Mar 2026 10:51:50 -0700 (PDT)
Received: from pong.herbertland.com ([2601:646:8980:b330:eb38:94c4:209f:a764])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-128f6384f6csm5917206c88.9.2026.03.14.10.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 10:51:49 -0700 (PDT)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	justin.iurman@uliege.be,
	willemdebruijn.kernel@gmail.com,
	pabeni@redhat.com
Cc: Tom Herbert <tom@herbertland.com>,
	Justin Iurman <justin.iurman@gmail.com>
Subject: [PATCH net-next v9 05/10] ipv6: Document defaults for max_{dst|hbh}_opts_number sysctls
Date: Sat, 14 Mar 2026 10:51:19 -0700
Message-ID: <20260314175124.47010-6-tom@herbertland.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260314175124.47010-1-tom@herbertland.com>
References: <20260314175124.47010-1-tom@herbertland.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[herbertland.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[herbertland.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[herbertland.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[davemloft.net,kernel.org,vger.kernel.org,uliege.be,gmail.com,redhat.com];
	TAGGED_FROM(0.00)[bounces-267806-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[herbertland.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tom@herbertland.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,herbertland.com:dkim,herbertland.com:email,herbertland.com:mid]
X-Rspamd-Queue-Id: ECC4B28E3BE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In the descriptions of max_dst_opts_number and max_hbh_opts_number
sysctls add text about how a zero setting means that a packet with
any Destination or Hop-by-Hop options is dropped.

Report the defaults for max_dst_opts_number and max_hbh_opts_number
are 2 which means up to two options may be accepted.

Signed-off-by: Tom Herbert <tom@herbertland.com>
Reviewed-by: Justin Iurman <justin.iurman@gmail.com>
---
 Documentation/networking/ip-sysctl.rst | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index 2e3a746fcc6d..453643c70c8d 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -2511,19 +2511,25 @@ mld_qrv - INTEGER
 
 max_dst_opts_number - INTEGER
 	Maximum number of non-padding TLVs allowed in a Destination
-	options extension header. If this value is less than zero
-	then unknown options are disallowed and the number of known
-	TLVs allowed is the absolute value of this number.
+	options extension header. If this value is zero then receive
+	Destination Options processing is disabled in which case packets
+	with the Destination Options extension header are dropped. If
+	this value is less than zero then unknown options are disallowed
+	and the number of known TLVs allowed is the absolute value of
+	this number.
 
-	Default: 8
+	Default: 2
 
 max_hbh_opts_number - INTEGER
 	Maximum number of non-padding TLVs allowed in a Hop-by-Hop
-	options extension header. If this value is less than zero
-	then unknown options are disallowed and the number of known
-	TLVs allowed is the absolute value of this number.
+	options extension header. If this value is zero then receive
+	Hop-by-Hop Options processing is disabled in which case packets
+	with the Hop-by-Hop Options extension header are dropped.
+	If this value is less than zero then unknown options are disallowed
+	and the number of known TLVs allowed is the absolute value of this
+	number.
 
-	Default: 8
+	Default: 2
 
 max_dst_opts_length - INTEGER
 	Maximum length allowed for a Destination options extension
-- 
2.43.0


