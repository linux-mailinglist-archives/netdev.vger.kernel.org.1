Return-Path: <netdev+bounces-252064-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QM36EOBMcWkahAAAu9opvQ
	(envelope-from <netdev+bounces-252064-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 23:02:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E09B35E6E6
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 23:02:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B1E49707166
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 21:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0D8426687;
	Wed, 21 Jan 2026 21:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="AYzdU3Ly"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f194.google.com (mail-dy1-f194.google.com [74.125.82.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB41241C301
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 21:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769032201; cv=none; b=TxRmDA5AduCGi38OqEwql5RSiBz4mi37vIPgEA9H30fY1B4FNqZZSgDneh+df23WAJPdHCjy1Hd+TdikAZnWtTYtlEK0Muhuo09+fw0DLM03O4EsgFywaUeBzCu/i3mowF/gNh+xsLj2O68dJvPNy67PAagj5KSdVURg0KWIkPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769032201; c=relaxed/simple;
	bh=aVCycgrrN/pMBa7j/V1XUjFE5vyf9msPfIlQTHiAIZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fTl7jqOPEabQDo1gLl22F9dUHnWQ2DcPQbx+jmddQaEBkTxGqEobd+mFQVdsWWvsANk8nL6//BrnlO6kc2RFlQmVedUZrT1pkVXCacUuJW+oXiZLodEw0/btXlQubQn9PHT/0+WzgrOfnckTu3dxD3YOwgT3iWGYxkPfa9bjjag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=AYzdU3Ly; arc=none smtp.client-ip=74.125.82.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-dy1-f194.google.com with SMTP id 5a478bee46e88-2b0ea1edf11so780995eec.0
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 13:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1769032199; x=1769636999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zFHrzVMQr6m0k+CuvTA33w8kuU0amqOxpW3rMFiQp14=;
        b=AYzdU3Ly7nwnHzX23BjA+N2wKuFGSJcFLhGRwFRpY6oEBDVDV8kCV/VXL5ZcBtD3kz
         DVJcKqQVDnIAta+B2ltyNpFpqJ6ErN2aauGmHLdWoVnkGCNCEUg5VhspLChmHxcaaCyt
         kM2Kk5ItUXbRIhBqjq+Eql8UfVf+NAeSn4fyuBcqZvk2vsqbggYcVaQjTHQJouy+OOBU
         JNuTMQv+3rNRNeHz1C0HbPcdBuQfRoVVkul/PSQxuzJimAOETmGUGV8ycLMl/l8KmVoD
         WvymSbHjD4hMVC5pRPd1SuuUMZy3AspyGfDi5TdYowdn0W5lZBCtwNTvzssjjgNBPKFv
         H3bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769032199; x=1769636999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zFHrzVMQr6m0k+CuvTA33w8kuU0amqOxpW3rMFiQp14=;
        b=J8vd4QNfaSzEz4M+PHtY9pxani/f5SERkwE6XTncNMeJsZbXEnwQJQytBQ8AI+98ll
         5MoaJ8xJDb/iDEWhUDykxWTxpsMtesQICCSAqlwcHDj/OdD0MveCbbPmkYtseircsrnK
         HeEtsZmq5G6V+J6xizgcqBJ8+A0LUhyqstXXqkdWrHMqlnVIqQj6xHqjn/VnGun+thwS
         ALWdoIKyavIJ/6nLv/SIDJYpekwUv1j4U5sNA6usPuGW8als8wAOj2yaN6KaMYwJHlpI
         YWHT3OMTh2pNXuGdjIw2rPk7EvyItfdq1maY0NFnFZEaYoCPUpF71kc067lInWuTVQ0K
         QBSA==
X-Forwarded-Encrypted: i=1; AJvYcCVFyHPnn8hTJQqO4ZFPghR/JJaPGw6Yp80+PpgWzDzK4JbTvck0O0A/qZFPjN2ddMtKi3IYY10=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBVAVNWd07TcDkU/rq/hpWfShNd/6vI+UVYzy0JSgfF3KuokXE
	Dgxmy/CybdClr/Rh4Kz/f/gE0Hs6aBZZcvrbcVRUZubD8vDYQzzNLIBWQNizzfnV+w==
X-Gm-Gg: AZuq6aITzwJNqDj0L60Ux23AwIAGT+9fX1Cdp6sAz6MZPdy6ZHHxhoIVOPqR5Y5KVZy
	qGJdZMahqgASDta05lT/Ymc1HeEw3AJIWw3W2rhKS72f8Th6dRgcopDaSVuVxaEMtjpmNXnPegb
	86Hb7uShIxda7+sSa0tph1xyczSX4u/fA/I/lfi33tM496PLtZGtYCqG56LYqkHtOteotVid9AH
	wrb/dT9hDH/pMGPorgB1c5BStQulnCT6v+TtdHUgvUOlml6pdlsuG/yk+yEwSbQgYtlm3jv4vIf
	wyJxvu12WTyukwdcA7UAuilC8QfofdmO4BL1Wz2RP+wlvbSmrzxZHfsvfFzg5LQpj8NMGodbBra
	Xn9Ob0FrFxi1lfalMjJ5tIOR046HTOglGuOv6/yVCwWD3T3j6g3W1c0r+WycejydvmieyVbt1tT
	ozxbbV5UUPKWxB3cveFoLQZzOsnUEgWmUo86Mamjn41XUzzFonxbkbH0+c
X-Received: by 2002:a05:7300:cc1b:b0:2b7:f12:9502 with SMTP id 5a478bee46e88-2b70f1295d8mr2726366eec.2.1769032198477;
        Wed, 21 Jan 2026 13:49:58 -0800 (PST)
Received: from pong.herbertland.com ([2601:646:8980:b330:30c4:fd82:1cb1:ed85])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b364579csm22774482eec.23.2026.01.21.13.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 13:49:58 -0800 (PST)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	justin.iurman@uliege.be
Cc: Tom Herbert <tom@herbertland.com>
Subject: [PATCH net-next v4 5/7] ipv6: Document defaults for max_{dst|hbh}_opts_number sysctls
Date: Wed, 21 Jan 2026 13:49:23 -0800
Message-ID: <20260121214925.112604-6-tom@herbertland.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260121214925.112604-1-tom@herbertland.com>
References: <20260121214925.112604-1-tom@herbertland.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[herbertland.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[herbertland.com,reject];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252064-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[herbertland.com:+];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tom@herbertland.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[herbertland.com:email,herbertland.com:dkim,herbertland.com:mid,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: E09B35E6E6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In the descriptions of max_dst_opts_number and max_hbh_opts_number
sysctls add text about how a zero setting means that a packet with
any Destination or Hop-by-Hop options is dropped.

Report the defaults for max_dst_opts_number and max_hbh_opts_number
are 2 which means up to two options may be accepted.

Signed-off-by: Tom Herbert <tom@herbertland.com>
---
 Documentation/networking/ip-sysctl.rst | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index bc9a01606daf..5051fe653c96 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -2474,20 +2474,26 @@ mld_qrv - INTEGER
 	Minimum: 1 (as specified by RFC6636 4.5)
 
 max_dst_opts_number - INTEGER
-	Maximum number of non-padding TLVs allowed in a Destination
-	options extension header. If this value is less than zero
-	then unknown options are disallowed and the number of known
-	TLVs allowed is the absolute value of this number.
+        Maximum number of non-padding TLVs allowed in a Destination
+        options extension header. If this value is zero then receive
+        Destination Options processing is disabled in which case packets
+        with the Destination Options extension header are dropped. If
+        this value is less than zero then unknown options are disallowed
+        and the number of known TLVs allowed is the absolute value of
+        this number.
 
-	Default: 8
+        Default: 2
 
 max_hbh_opts_number - INTEGER
 	Maximum number of non-padding TLVs allowed in a Hop-by-Hop
-	options extension header. If this value is less than zero
-	then unknown options are disallowed and the number of known
-	TLVs allowed is the absolute value of this number.
-
-	Default: 8
+	options extension header. If this value is zero then receive
+        Hop-by-Hop Options processing is disabled in which case packets
+        with the Hop-by-Hop Options extension header are dropped.
+        If this value is less than zero then unknown options are disallowed
+        and the number of known TLVs allowed is the absolute value of this
+        number.
+
+        Default: 2
 
 max_dst_opts_length - INTEGER
 	Maximum length allowed for a Destination options extension
-- 
2.43.0


