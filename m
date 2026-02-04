Return-Path: <netdev+bounces-256863-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MMmkDGrOg2kFugMAu9opvQ
	(envelope-from <netdev+bounces-256863-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 23:55:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 889E2ED1E4
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 23:55:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C00C2303E2D4
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 22:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE7F396B66;
	Wed,  4 Feb 2026 22:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="bWSfxybk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f196.google.com (mail-dy1-f196.google.com [74.125.82.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67342393DCC
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 22:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770245596; cv=none; b=eJAHBky/bTAVOqTB0GdwnSSrETPoYELf9ecfmMVKL4Ah/84fWkA3q2W5TGrGvk15UwN84X1aPgoTBqHd1i5pifBwrnM4ruI6n4zOeK4T+zwP8fE7zxN8njlYS8rHSI4QQbEB5Bdb4zDWNXXguwOu5yt5nsJYqUDzTunfsOlPPEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770245596; c=relaxed/simple;
	bh=UtnEJuWeKgvgT6VrEFz27zv2qXn5H3zHbKFGcXIsXQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aQrsVr6iBqb9+Qoj0pm32jIXXH95s+SzfzZNc3LflY9x7e+Fhj7Bk+FC97UZiHKbKttZeahNSS5GhobHwyu8oY3sO+9Y6j1YxD/3K670FbWD2cwUw8bJqnFS9i4RuOzCOTgcSIlFo9nIVq/x+fLjkCB0IK3BUEJRRFFfed0v3ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=bWSfxybk; arc=none smtp.client-ip=74.125.82.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-dy1-f196.google.com with SMTP id 5a478bee46e88-2b740872a01so521621eec.1
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 14:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1770245596; x=1770850396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tN1zBw764/GZTEakJtan3+9NStyElYE05SSxDHAbOWg=;
        b=bWSfxybkYiD4CkbY7oCLWXICk7JDX4SEZpvDNQabKma0xX0XvxIXMKoWCBFHtIQA9M
         YU1+CTFautwHfIVjUieEeN/wVfXXTdkWl/Lr6coAYQnEZ/i1QG2rVncvnanD1Nm6Epvf
         CQ2WQWhVr3P0Hf24O0g7Ui1eCS7hHQ3LI4eFjRWJ/MUGD0gGsP0ByVs7aOLiT489M172
         IYV2uekZ5SlsHbu9E2HMXvs9I4L/0rNgrwMDiURNFdwOg9GnfA5WyQux/soFqi/tbl5/
         RwiXherDkbTxi3tuGtUof9xxh8II+mJm9HRfAK7JM0X6/ogZ5pj38JY+rkcWajb0o6A0
         Wrmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770245596; x=1770850396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tN1zBw764/GZTEakJtan3+9NStyElYE05SSxDHAbOWg=;
        b=W3vnwxGR2Kd1gFGhXsVKLmUWhYEvkj6rTOmxuhurVEbGOqsMKkSX0ZWIj9M6x+EBxb
         tU0IpJYATAkumWPBT5oIQZFkVNllCeDwDe6GMjB9tIOQIJWCZP6ub03n/n769N1zAbRb
         DEGYJGclSGCkQD0vksvcRSwHJLkwovRKJq95is+Q3PtnFMBLBHdNQpNGGrvRymHsuM4I
         RzYkm1i+w5+OsTmC1ddAkmKyL8UVncEtRQFkzDSriniK4el/h9IztXncvFzc403n2ByQ
         H7bKzQhzyFjKiEH3JXE3i0AJyS8yY4C1CJSUuk9FfjPlaXanBKAlQoRSw81bfljiFqf2
         o1qQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJQ/zeO1wlFwZixppA8lQY6UBo6JDkRtQnet3oyJtYhdw5nmqIm3dVAb7NGfoszQM0q8kaj7o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC2gHeGMa8xdwRASK9jF0Ik+KMxklYMXWAcLNI5ebp42Sf1Wap
	mZEUeqVsdeiZwJ2CeJ3zAmU7dx9Umayr0ZnlYn0AHOUKG6VVygKeVEgCuziEZI+n9Q==
X-Gm-Gg: AZuq6aK6girSVxSiDZXewFKV7oxSQsKgXBFP/thLJ6MdTmwVMEmpLnFPWRjpOEkpvRW
	KpM09GtfKCojFhFUZfAL8upFpkNzBOLX8H3X6/NyxRlMh6b2OyFlGC6aQPnt/Q+GHD77O+RY+JV
	UzfdcMuYqw3o3klvxww1LIhswT4ml1baCYBy3Y75pa8T0+qGbgywrYph18yoO7H8L6Fllkow0FF
	vx1DgX3B5hIT6Bw/FbTQLWb62qF7BMo9VDy+hNQDdx+AOi7DblHZvK+6+cK3sGt2pBOkkeWPLLW
	PX3CS3v/Vugy4R+qljgnVs6SvV9Z9YLJ4fMpbYfrb0OizMeROBQY2/KaU8ZZD+r2Ks5brb7aN7C
	Nthto55jq8Cz1Hqa3RWM145j1HWVvloi57QlqBZljTIL8fBcITE7CdYwjuv1MMTYcrcERrMuRo2
	4FIikFrbmm5h6n6kVyLfn7mzeZbQX+T7T+URITgXf6qGDHUnmRKXw2Givt
X-Received: by 2002:a05:7301:4b03:b0:2b7:e2db:4a14 with SMTP id 5a478bee46e88-2b8329dfacbmr2016985eec.34.1770245595449;
        Wed, 04 Feb 2026 14:53:15 -0800 (PST)
Received: from pong.herbertland.com ([2601:646:8980:b330:5ee7:5720:1d16:9b50])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b832feacc6sm2587040eec.35.2026.02.04.14.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 14:53:15 -0800 (PST)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	justin.iurman@uliege.be,
	willemdebruijn.kernel@gmail.com,
	pabeni@redhat.com
Cc: Tom Herbert <tom@herbertland.com>,
	Justin Iurman <justin.iurman@gmail.com>
Subject: [PATCH net-next v7 05/10] ipv6: Document defaults for max_{dst|hbh}_opts_number sysctls
Date: Wed,  4 Feb 2026 14:51:49 -0800
Message-ID: <20260204225154.58245-6-tom@herbertland.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260204225154.58245-1-tom@herbertland.com>
References: <20260204225154.58245-1-tom@herbertland.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[herbertland.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[herbertland.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[herbertland.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[davemloft.net,kernel.org,vger.kernel.org,uliege.be,gmail.com,redhat.com];
	TAGGED_FROM(0.00)[bounces-256863-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[herbertland.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[herbertland.com:email,herbertland.com:dkim,herbertland.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 889E2ED1E4
X-Rspamd-Action: no action

In the descriptions of max_dst_opts_number and max_hbh_opts_number
sysctls add text about how a zero setting means that a packet with
any Destination or Hop-by-Hop options is dropped.

Report the defaults for max_dst_opts_number and max_hbh_opts_number
are 2 which means up to two options may be accepted.

Signed-off-by: Tom Herbert <tom@herbertland.com>
Reviewed-by: Justin Iurman <justin.iurman@gmail.com>
---
 Documentation/networking/ip-sysctl.rst | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index 28c7e4f5ecf9..bafb2ab08d0e 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -2476,20 +2476,26 @@ mld_qrv - INTEGER
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


