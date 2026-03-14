Return-Path: <netdev+bounces-267790-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oCoQB66etWms2gAAu9opvQ
	(envelope-from <netdev+bounces-267790-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 18:45:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C9DC28E2DE
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 18:45:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 41B84303E4B2
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 17:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFAEF2DECA3;
	Sat, 14 Mar 2026 17:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="AO3hffKX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86BB2D592C
	for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 17:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773510261; cv=none; b=koWSKTqAK0PP+GDRhWCSM7Rk2TUvJXSrUkjdDE1ZwwRxDazvVnorfF8HdMAZV4zVkqBY21p2HxedKEXU5uFL3Sko9NoAZEFNsrrzVbUYjC/tjWyzkwc8tqznm0pw1jRuGgPGGF3QrXr+3198iD8r12MfHzAveG+QFci592snSpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773510261; c=relaxed/simple;
	bh=uItdHPzM8/YhmEnZVDdGZfkeDxlbuzv/yCC5R1HveNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KfAwpIWA+G0X7088+d/W/LnLxQsEgjzwUlI4gHawvYRaIJO0KpjP1hRuSMUzSieq3/fxURVbpXpEuUp/4UAccXJ4SJ5BTcbGc4iDg1TILSpJ0ETXBdcdZEYDoAm4/L0VqMMAGgLw5bztKuYZwAmF3qMGhh0Wl9NeW1+7zxcQ5sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=AO3hffKX; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-12732e6a123so1777966c88.1
        for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 10:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1773510260; x=1774115060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A6arbcjbT27jtKab9iAQCIQYW6MTuFeHR9L7LFxRYIY=;
        b=AO3hffKXEkJ6dpjALZtyWh7QzLIkqrzlNb33VWVmi1Nqg/Ym2jHvoy1FlDQj2luzqY
         1/g9/TsbJK2E5/Lma+ei7lIETXEZCVFHmVsmtRC5UVh1tn46RifkPytAQ9LYZnwomlpf
         M3u5QF2eRN9I1RckzYMW2iVXAx1aIA09S+fT4qmV4sncKpEs0qiJd5RqH5OQv8Ov44uW
         TiT2jfGSjppbIJUg+4YLfAQaY7vKnIvmouMCNrWSKK2anS0Eq6XkJW7xz+dZBheulO/v
         ZKTMHIXgop2LDqMSo4m+c6hu7yzSRxdyntbyhFWVBc/8fer7XGrna1XSsKhWRSwh3kMR
         2G4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773510260; x=1774115060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A6arbcjbT27jtKab9iAQCIQYW6MTuFeHR9L7LFxRYIY=;
        b=Lmk1dVdT6BfRzLl2YIEbTU9wAmYnpb0WcrAUJfQNLeGqhOLGWX/ISlxsNlav9oGe8S
         JbqGKON6Lr4u4KQGC/9Zki34yRhXFDphO7c5oAuxHaO++OV6Y0Oj7OYXaiBWkk0SvqhW
         UnqJQq/js/BWb3auHWP7BBAMz7F9BOlFLXabIIH2OfYMotNByisYZRQZvChxXZvW1QhV
         tNCY4fM9ziDhjdAXOLPdXREnIVZd2mFdaxPWnuK8AOSRC+I5eY7f+iQT76TqN2jCdjpR
         Ws1fpDdNVWxGIlU/mTWi/HUtunlokafPM+qjYRVAnZ+fftBEFEZctxhkVMBZiNHCCdg0
         uu8A==
X-Forwarded-Encrypted: i=1; AJvYcCVNkobsmxw9OgDPQc2opwQ2D1CsGTxeUeri6bNJbgLKwgULiwbumCyJNXZ2ge3nZaB7SKXimHM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxANRNnYFBOGa9p2YpkWY3q4iOzt3hDYvh4bk7N3yBZ+c0iQHV0
	rBqRYexxxVsly/VOuDhu1ivA5Y0pICjdzFNPVdAbgBW/6tf5f1eQFjkgypUb5y+xPw==
X-Gm-Gg: ATEYQzyPxnvZnxgOQT6XaM9XvpN4zgpH3jZ1cQI4LAQ7BwsuJvkYF08TZWa03Ny4kNR
	Vb97Rii0GiFeNebK7w9svkKLWSnSoZdyMtlY6PjCzpvwU0na5d9EupmxBwoSapFZddSzycpdhb6
	iIhdr4TGpU2nUkCm4FKB+Kna9yHN7SyNtVijXi+NLd3RMYyJx3Wpvwygfo4HnDamjL8Ym/zUvE+
	76u7yq8oHzuBdvtE3W/oj+BPj088qp9IDiBVM9z5y3IQ3shWVNMKZj0lsSzaIKUdDjhf8jA9u/w
	lVtiYxcaB9b8b47gzfEl54JDjdpCknNhz6nQycfQz5gHrm7jofPcdshmRy1efsr1KsV/2vDxDY3
	a1f1NSk+aNORPowXRvnSUzB6W0/sDXYU+s+SSLucIkIV9Wqit/VQJ3fPublHAf4ONoLKKGpMHlf
	9Tg777GcBcTukFTf/wAojHLhPq360Et1bOXmkRsE1T5PsKZmwjEqF8a506EDoET6NTLjCIwQ==
X-Received: by 2002:a05:7022:4186:b0:11b:88a7:e1b0 with SMTP id a92af1059eb24-128f3dc48a8mr3629234c88.26.1773510259679;
        Sat, 14 Mar 2026 10:44:19 -0700 (PDT)
Received: from pong.herbertland.com ([2601:646:8980:b330:eb38:94c4:209f:a764])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-128f62837ccsm8326734c88.3.2026.03.14.10.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 10:44:19 -0700 (PDT)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	justin.iurman@uliege.be,
	willemdebruijn.kernel@gmail.com,
	pabeni@redhat.com
Cc: Tom Herbert <tom@herbertland.com>,
	Justin Iurman <justin.iurman@gmail.com>
Subject: [net-next v8 05/10] ipv6: Document defaults for max_{dst|hbh}_opts_number sysctls
Date: Sat, 14 Mar 2026 10:43:28 -0700
Message-ID: <20260314174333.46406-6-tom@herbertland.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260314174333.46406-1-tom@herbertland.com>
References: <20260314174333.46406-1-tom@herbertland.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[herbertland.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[herbertland.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[davemloft.net,kernel.org,vger.kernel.org,uliege.be,gmail.com,redhat.com];
	TAGGED_FROM(0.00)[bounces-267790-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[herbertland.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[herbertland.com:dkim,herbertland.com:email,herbertland.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7C9DC28E2DE
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


