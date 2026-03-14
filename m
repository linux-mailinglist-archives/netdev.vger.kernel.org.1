Return-Path: <netdev+bounces-267808-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6OeuMPqgtWk02wAAu9opvQ
	(envelope-from <netdev+bounces-267808-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 18:55:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF7928E435
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 18:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F2F053029B94
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 17:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50D2344DB3;
	Sat, 14 Mar 2026 17:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="hb/YCajZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8A5330647
	for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 17:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773510716; cv=none; b=l1XZTY4ItisgKqqGcN0hXMi1836FjwNFhNxJVsKjexJeliSYg8NDNjGQYZuq+8G54cPjuyI002tpOp4/QWHlPuX2nedtxt5DKr+tBktGHiZu7MFlhwkMs7d1gqlUTFY0wWAWLIKhCMevCVaafG+IDAJO6aOlRgtuwul5toiKhh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773510716; c=relaxed/simple;
	bh=qKqtxCzBXIzGk8JlmvBjYx71RKayrMcxp+vv//+DAyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hs5kniuxZF48B3LMkRAf+QE6AnLHWb0/ic8Db3IfkFXkm8kC2jHzpmW040HViGv5jaggBFWabIJE0wfFpVa186Dmvd401QMuRHufwF9K/wurExaPrDvjyeDOskIZl7taZ/fZ+pbyAtjsgcSZ/0vY49vhCNgVMJUsoBpax0RbiSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=hb/YCajZ; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1271257ae53so4775352c88.1
        for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 10:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1773510715; x=1774115515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ffNE/V5dVULFOqPtPyBXTaniKjCJVhXKcrWx81ht9Ek=;
        b=hb/YCajZ3/M8UeQDS2V9nOTyu1lOdNEU/WjbcTCrSeFTaOylF9zjDMYtFS9f8BjFoh
         qvzz9qW+YFx9Mmz4Nn8WdRc80vODqdSI56r++/aF6u+x2CLCXbYAXS0udICC5gKDvB5W
         vAvGgPNAixr0iibCNj4TCqgXDWd2YWdaM6HlPsEkXep/qtozKDvN2kDX4/TLb+q56Ph+
         GBFUACtFJmYhoX/7BOB7DXxV6IaQ94PveQAfFbaKt/om6nf+Jcjk4bTF8bio5zMZ6UXs
         SoPQG3b4xDITITnyPXZ3RJF5r+qXMLkRGlqo56Zre/omEBMn4Y2K5ZERiGKfydhjMHs2
         KErA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773510715; x=1774115515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ffNE/V5dVULFOqPtPyBXTaniKjCJVhXKcrWx81ht9Ek=;
        b=dllo6Yunmhle9zRajDa5zfwSjVSraKfAA4mWTClz78lqVEJ3SGtGql+81LDNKKF8sb
         nDb/1YRo6fYCjN+gN4ELDPyR5lPPROqOcU8OvT1m58KJoSw2yrlMqHXsMgwPEXyUGJwo
         TYb2RCkbaEk0J/vh/r5VGusIIRheW2/1JfF4thrMrqH/xqyGPwE3fYG1ojR6CTQVkjSm
         b+g3W5eEh3SnwXwiZDPiW05PWRebw0GoCXdpAH5OBU9EvLD8YPtV+qR0WN/ePE0Yt61E
         eH5yBr/FF9zIYFqBcd0bNeJNlA8iFi71rrh/l6ecHlSOsES+TIGvMOvlHzCty+7AA6RK
         MDGw==
X-Forwarded-Encrypted: i=1; AJvYcCXmEvUeX0kcNH6d/K3ZJUOpclwj8MAIRcuZ6unewAWpJgQFZGJWNoBrAB21lQHEBbD2dJpQMWc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgQl2Uy9xMvVz+dJmGpftw9z2sT11a/ixV0Dd4c05yLQt9xQhB
	Mlawv9ncktnGQkExlaqW92lHm3fX0qOdvL/vmAAtCjHHsYkfpT1zf+w6ELP0T1qBQg==
X-Gm-Gg: ATEYQzzfvY+M9HpQYlaml6qgBH90lMNzd5XWYyfnxCv8dkO3HYntCH0/nxb58u0Bmgt
	bQEXCMEaLZmfX5xONUNgou60sxFOmcQl2vFXppzbmeYrO8lQQKLye9WYTcPlTjvcS+F0pdU1OGG
	2bJn6I1l0Oin9lgYFgqTmKheJ7w4BQfPeaVtpwBEg3slJeMs7BbkTyKnomhe5kgl4hQxHfD3O9+
	t3gfly8hDf1cDygDVGFOkL98R4fr+FJzwjRmGrRf0pVaeFQCHzKrjQxo7sBqB5DC9j78VEj5eyj
	c6SmlNO6KrzLknXQqt1EDwr0CgNcrcHolI71FGKksUpZyBhwF+nAr3LHY+otx3xhq3jwzTW3Y4r
	BswGaqDiieyz2vtZzbNJpwb6vHBOFjrPY8tMkB0nv/Ia3yTE6YcOehUc0HrNcNTJi/OMVoJVFXq
	DjHKFDVLRcfZxwiRR0gPtKt1cHQY2NaiqZd2dE3X9+/kkBkLlRxaLWnPRTQU7WciTCjkD9eQ==
X-Received: by 2002:a05:7022:698c:b0:128:d23d:81a7 with SMTP id a92af1059eb24-128f3d006b5mr3468981c88.6.1773510714794;
        Sat, 14 Mar 2026 10:51:54 -0700 (PDT)
Received: from pong.herbertland.com ([2601:646:8980:b330:eb38:94c4:209f:a764])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-128f6384f6csm5917206c88.9.2026.03.14.10.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 10:51:54 -0700 (PDT)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	justin.iurman@uliege.be,
	willemdebruijn.kernel@gmail.com,
	pabeni@redhat.com
Cc: Tom Herbert <tom@herbertland.com>
Subject: [PATCH net-next v9 07/10] ipv6: Document enforce_ext_hdr_order sysctl
Date: Sat, 14 Mar 2026 10:51:21 -0700
Message-ID: <20260314175124.47010-8-tom@herbertland.com>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[herbertland.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[herbertland.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[davemloft.net,kernel.org,vger.kernel.org,uliege.be,gmail.com,redhat.com];
	TAGGED_FROM(0.00)[bounces-267808-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tom@herbertland.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[herbertland.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,herbertland.com:dkim,herbertland.com:email,herbertland.com:mid]
X-Rspamd-Queue-Id: BCF7928E435
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Document the enforce_ext_hdr_order sysctl that controls whether
Extension Header order is enforced on receive.

Signed-off-by: Tom Herbert <tom@herbertland.com>
---
 Documentation/networking/ip-sysctl.rst | 30 ++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index 453643c70c8d..fa0ed1936f59 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -2617,6 +2617,36 @@ ioam6_id_wide - LONG INTEGER
 
         Default: 0xFFFFFFFFFFFFFF
 
+enforce_ext_hdr_order - BOOLEAN
+	Enforce recommended Extension Header ordering in RFC8200.
+	If the sysctl is set to 1 then the ordering is enforced in
+	received packets and each Extension Header may be present
+	at most once per packet (except for Destination Options that
+	may occur twice). If the sysctl is set to 0 then ordering is
+	not enforced and Extension Headers may be present in any
+	order and have any number of occurrences per packet (except
+	for Hop-by-Hop Options that must always be the first Extension
+	Header and occur at most once in a packet)).
+
+	The Extension Header order is:
+
+	    IPv6 header
+	    Hop-by-Hop Options header
+	    Destination Options before the Routing header
+	    Routing header
+	    Fragment header
+	    Authentication header
+	    Encapsulating Security Payload header
+	    Destination Options header
+	    Upper-Layer header
+
+	Possible values:
+
+	- 0 (disabled)
+	- 1 (enabled)
+
+	Default: 1 (enabled)
+
 IPv6 Fragmentation:
 
 ip6frag_high_thresh - INTEGER
-- 
2.43.0


