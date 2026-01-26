Return-Path: <netdev+bounces-253584-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qIh+Ho7Fd2nckgEAu9opvQ
	(envelope-from <netdev+bounces-253584-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 20:50:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 027038CC55
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 20:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 74E8230293C4
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 19:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749A32874E6;
	Mon, 26 Jan 2026 19:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="bWJxarP7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f68.google.com (mail-dl1-f68.google.com [74.125.82.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3CB285C8C
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 19:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769456938; cv=none; b=IrwIvvM+HsCWvn2tkdQ7HdgZBqTZtEXMAJPaXbF4tlyHyYWdq7VvrB2Mv0UhvkbAEBgWli++fbiPO7+hxYqGoAXddeohZlYCpifh2gqM0qDUuHTfAJ9PjecIvaQ358jdbsykMhFuD7xq8IYujFWu7mNmrdrS+Hrx2yGPI5GPlXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769456938; c=relaxed/simple;
	bh=08vChIE7oQ39NlP5CQQc/RYR8VlCKehllgRc3YDbM4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H3vvN7/Dlp2Tczotgxw2ABPQhQBAfv05hpAbhYd4S7xkRACPW/lHkZ/qnlBHNt6OB36K95cy9+IdxC8UpIGejPwIEOwISvNdVnAUK58Xd0DBrEDbgEnAkDhmzthB7jLuoN7U+kKRKFOBpd//hk6n7x+nd3nd5VrUuNUZaJoIaRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=bWJxarP7; arc=none smtp.client-ip=74.125.82.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-dl1-f68.google.com with SMTP id a92af1059eb24-11f36012fb2so6954466c88.1
        for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 11:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1769456936; x=1770061736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NXEoGYp3F5iHqELZ/pA8HwzVMLqN41yAQr8phhK7bCk=;
        b=bWJxarP73g85h8HkZvrluBcp5HatAGGw4O13k4i6/vTl5n3ZBrk0IA2f3c7NFXRCNd
         SDNFt/RAndr6yn1C1/oRmq5HY3s8w+BySRNKhzvn0q+4qUiVdnyjirF84T4Fo32deN4u
         Kam3F5J6mbeItwuGaaWeuqQL3lLXrUzJUqVHpOfZXyvCNRYfcw1mxl7LtUlWoIR7nbQU
         8CNZBRxkGaVRDo+lQ6/QRoJ5G5/yzSS2dwuBMCq4TaI0ouZgmymONuNPMUTA7Q6p8f4A
         iqEq4bOiNwNHwCzHiSqE8rbmfApPlsvAihIOnEKEWks+WN8CraIjtFayyjg6P8z+EOGW
         cjyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769456936; x=1770061736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NXEoGYp3F5iHqELZ/pA8HwzVMLqN41yAQr8phhK7bCk=;
        b=mkaXNehY+3UR8pU5gZ9eVH37FT9sfkbKow/6iMyuF5I+UsDHUweq/++EThLYFBFTBX
         Gsz+l81PjXifcGnTDCSIXUw8gajUvtBNakcK4t78dWrAYOj/dCxYUzltN71wpplOmJn6
         mRfLlWHDCWGuhp7eKN/ZRBmMywHJYkdRUI/JYidx6ypSXPuMywlyJMyp6d6o7VkoWGkd
         s151tdgnZyJ5XxlWOEEwfk/hWk04ok/qwGoJrPB3VwDOJhdaOfFoytt/q6kzLuFq45kl
         HoO8FmilxlGrNrZpfvMsnVMECGX2biEK7rNXLtsZffyJ63wnmcj6KzgIDss7Jl0fuBML
         FDsw==
X-Forwarded-Encrypted: i=1; AJvYcCVJzHtExEclNc8MQDXkc1SLqFhP0Lv0EqorVDQIOkQZ0F6637h6CK1zDzpKaIPSXS9b5eflowY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn7EGJTiBLUPTpj6iRZzBR/vpAAO93AVwoNAwxFnVTUfAWDowS
	gpKR6Pk4PHqf72c1Ofrv7a0TlRvvVJ1b7eOGaXO6yP3oqVJXIFB8QL9JVsjxu9BgQKYv2x4fs6G
	LEC3UVQ==
X-Gm-Gg: AZuq6aKkh6lRv29fWv0iMvwveA3TMCFSqmK/6hgH2nT445kZejKNxZnriZiOOjb4oLr
	fNH/8b5VHFRMlNHvh9T4MEr8a2AoeJr4wjtyqsNURBE4eTAMBhLM1b3+v6V/H1jiRFszdu3Ykhy
	sdyLXV3waqtx8VlKvTObNWIQm1NZlWnDViL+f1PW6xjxJSGpC99gZUOHiUAV5QkN0atdKzLa9kh
	XnAcFm5yvIKiTukGq0r8WAC9gYosmMAsr7m6DN51t17wF2wlDtVSF6afOyy9vqaN8y2rx2s+LOE
	/IMnj/Kwr+OKFL6E7z18tfQjAJgO2S2KjjKjnc51nlJwhc9r0p4OCh6yoIlm2m6/xyKVfi/FE9z
	EP8C++vvY3i+Gqx8uxo+ar2vuuHct5Bb4tMHx60FHOzQtCqSOU7WseaVf3X+gZss23cSvcf3DXT
	TgN1+XZolP4ii8PNnXHnqlbo2ZfVyNa5Kcx9QTXdXnAoKZlB5xYP4TerQ=
X-Received: by 2002:a05:7022:b83:b0:11b:923d:773f with SMTP id a92af1059eb24-1248ebd10e5mr2688298c88.5.1769456936107;
        Mon, 26 Jan 2026 11:48:56 -0800 (PST)
Received: from pong.herbertland.com ([2601:646:8980:b330:1485:5851:22a:4c2d])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1247d99804asm21121295c88.12.2026.01.26.11.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 11:48:55 -0800 (PST)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	justin.iurman@uliege.be
Cc: Tom Herbert <tom@herbertland.com>
Subject: [PATCH net-next v5 5/7] ipv6: Document defaults for max_{dst|hbh}_opts_number sysctls
Date: Mon, 26 Jan 2026 11:48:24 -0800
Message-ID: <20260126194826.236075-6-tom@herbertland.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260126194826.236075-1-tom@herbertland.com>
References: <20260126194826.236075-1-tom@herbertland.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[herbertland.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[herbertland.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253584-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tom@herbertland.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[herbertland.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[herbertland.com:email,herbertland.com:dkim,herbertland.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 027038CC55
X-Rspamd-Action: no action

In the descriptions of max_dst_opts_number and max_hbh_opts_number
sysctls add text about how a zero setting means that a packet with
any Destination or Hop-by-Hop options is dropped.

Report the defaults for max_dst_opts_number and max_hbh_opts_number
are 2 which means up to two options may be accepted.

Signed-off-by: Tom Herbert <tom@herbertland.com>
---
 Documentation/networking/ip-sysctl.rst | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index bc9a01606daf..4f568b0e39d2 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -2475,19 +2475,25 @@ mld_qrv - INTEGER
 
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
+        Default: 2
 
 max_hbh_opts_number - INTEGER
 	Maximum number of non-padding TLVs allowed in a Hop-by-Hop
-	options extension header. If this value is less than zero
-	then unknown options are disallowed and the number of known
-	TLVs allowed is the absolute value of this number.
-
-	Default: 8
+	options extension header. If this value is zero then receive
+	Hop-by-Hop Options processing is disabled in which case packets
+	with the Hop-by-Hop Options extension header are dropped.
+	If this value is less than zero then unknown options are disallowed
+	and the number of known TLVs allowed is the absolute value of this
+	number.
+
+        Default: 2
 
 max_dst_opts_length - INTEGER
 	Maximum length allowed for a Destination options extension
-- 
2.43.0


