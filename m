Return-Path: <netdev+bounces-284010-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qByPMxfr+Gmi3AIAu9opvQ
	(envelope-from <netdev+bounces-284010-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 20:53:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D574C2C50
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 20:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3E1C930098BE
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 18:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3FEA3E6DCD;
	Mon,  4 May 2026 18:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="aCRJhKy+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5D93E715F
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 18:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777920779; cv=none; b=dzSiBtU8tYVsrphb6Lb3rQJ/pla0/QdY7/u2TE5asYH2FQV9HoVYaFge8f8utZd/tZsfVXtVLDt5ow0w424LjhvHuV6feZFyb74mOK5SkkIhAQEBEhAqRm0ZIhGPKwbOSj0PBYQ9FUjTzOZfdTwxEribf0ZrvqJ1M0z24g2QncE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777920779; c=relaxed/simple;
	bh=i4xXZMJm5gtonsPNyiTiF+vbIUCtihFsQNjY5y8ABNw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kovaHw2t4QYyt/Y8xSfO0aCw5EDroq/qwI+PRuLFaKI0M0IfvItd4p2my+6N7/dUSgq16pPvrJNaCbzjBmtTn4UsRg/uYBGiRnm1wAaOvyoOlo3uwUhTjjV6zxQ30Vj5gvoTzSzDIT7ktcu1NCqps+xWBEvvpZ6+MuSJPRuc3gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=aCRJhKy+; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2f30a4601bbso1051574eec.1
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 11:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1777920778; x=1778525578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CRDFq6+wnqwL4rzX2eQ+sqeOoNETR1NbDfwQ41HTGJk=;
        b=aCRJhKy+Dwd30nqunYBjsTRbOhV41dWck7FnxNZfuEbq+jJ2Vw4poAS0+pbEIpW3VQ
         yiSWhdu9DoDskoar3eAphlHRs48j7UVDdanBHLjZ3tyatOoP68eH7rifmIGHME5sGJhS
         bFl8wQPJlH3A6sPGJ4JtSUF+ckzzHqKTq/oFj5oLQPmUOUVhym6yY1oXee2Lb0MNjrQy
         1rvZKwgLGrd7n2OZb7IC0vKgdFke/Y4qqxAAAKAUMYt52f3ILnYcwnOa3TbYvjc/RCv0
         hrWuarHgSWtHbJD0AHZumBtOBD5MawqY0fW7DX7epr4NtIIpAgZEJqdQosIzgqWaLaWc
         BiHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777920778; x=1778525578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CRDFq6+wnqwL4rzX2eQ+sqeOoNETR1NbDfwQ41HTGJk=;
        b=ntAjVgKgsasrCOCaAb/o+R0GonqZYM+oCfTLlyL2QMdAqjzydg09o/5nRKkQGPAyaF
         wX4rGCCabuM2KnHHwI0S4TjFS8H4RkSvNBzHBlMSZq4NAVngfsBA2KfcSNp9iaDmjCbw
         5xsxDGqn9lzZP1D9Vc7o0JWxZk4VlQIwouS509V26S+mSc977PfFYk5zeCNAh/NIl/EP
         Vs5ljo71GFG52zu5DWGyb4KfUnVMuyP6Q8VZQt8wbkjQ424eLBLyyT7yoEOIgR6lSoQn
         9LTUNvitEIcaho4o3JQwGFXOj6VVO9h1kECjgZUuAUhpIsX5uomRXRyR95b8xE0D0uYA
         meCA==
X-Forwarded-Encrypted: i=1; AFNElJ8CGmDaki5jfdeZapx6Pqdw1nmnkoqTFjL10zTI0JY5L43tQdJzO91wx27OiIkjIpgAFZzU5UY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1Y4Cl8TqPw1kSNNR2/JrS5aL5j38KmZ/KJySurUBjL51Xyqtc
	+xCEy3ibSrwDrbQKWnnmEOulln/OMnuMaA4jSGs9CqscJNrYdyMNSr+CCyvvSXehiQ==
X-Gm-Gg: AeBDietI8OPTKm5dxYWWqrkPiwkCoFXzyaEnGYEL+TaB5CToR4BlWE7GfFuixG6/7PL
	jv85trLJarbciaj8cVFW0bFa/iziVmUwldmMXQV+DXUJmYySkvsd6t4707S321bfePhXwUgcsdH
	SM0fe+k4xHiHDEkpn1ytl+s/c49iaX9nuPBhelMhLl+OzCZHlK+18L0GSr+CB901zehK+jUdFAd
	a3F+OQR+ruPQ3eS7Z03I5H2In6nLMu36X6RW5C6yKU3I6uiQE9FIjE8Xt34CX7pw0FbHOegCmq0
	mJe8SQ9S3NIEpkwQESu1EynCM+8RIHIlpQQ7aLP8thtr8NohEUA8PqLi1nxQJi4HIW8PCgysTBT
	UqAiVbveZ0Ea/yth68FdgBtV8pOrwp5yaYJZ3kOv7x4u68jvmDH/SDqR3za02QrEwd5GRdsYOO0
	abxbUMpiwqQRBbT8VRhv65natpVNHmugfuWStbEzN1ZApFe2mGtpVvJng5IhYpmvMF34rf+t7G
X-Received: by 2002:a05:7300:fd12:b0:2f3:a348:a2db with SMTP id 5a478bee46e88-2f3a348b6a3mr983895eec.10.1777920777489;
        Mon, 04 May 2026 11:52:57 -0700 (PDT)
Received: from pong.herbertland.com ([2601:646:8980:b330:8e62:719f:fc3d:b6ad])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee3889d657sm17186262eec.4.2026.05.04.11.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 11:52:57 -0700 (PDT)
From: Tom Herbert <tom@herbertland.com>
X-Google-Original-From: Tom Herbert <tom@xdpnet.ai>
To: davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	justin.iurman@uliege.be,
	willemdebruijn.kernel@gmail.com,
	pabeni@redhat.com,
	horms@kernel.org
Cc: Tom Herbert <tom@herbertland.com>,
	Justin Iurman <justin.iurman@gmail.com>
Subject: [PATCH net-next v10 05/10] ipv6: Document defaults for max_{dst|hbh}_opts_number sysctls
Date: Mon,  4 May 2026 11:51:17 -0700
Message-ID: <20260504185122.50642-6-tom@xdpnet.ai>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260504185122.50642-1-tom@xdpnet.ai>
References: <20260504185122.50642-1-tom@xdpnet.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 87D574C2C50
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[herbertland.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[herbertland.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-284010-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FREEMAIL_TO(0.00)[davemloft.net,kernel.org,vger.kernel.org,uliege.be,gmail.com,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[herbertland.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[tom@herbertland.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.998];
	DKIM_TRACE(0.00)[herbertland.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,xdpnet.ai:mid,herbertland.com:dkim,herbertland.com:email]

From: Tom Herbert <tom@herbertland.com>

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


