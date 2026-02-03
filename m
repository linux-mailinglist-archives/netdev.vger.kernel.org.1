Return-Path: <netdev+bounces-256047-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EBLWEYlGgWnNFAMAu9opvQ
	(envelope-from <netdev+bounces-256047-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 01:51:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A51D325D
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 01:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E07C30484CB
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 00:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18982217705;
	Tue,  3 Feb 2026 00:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="IlxpN9iP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f196.google.com (mail-dy1-f196.google.com [74.125.82.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B5E1C8626
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 00:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770079769; cv=none; b=HkslapRdZTYYqGYhExoCZjlsLvkNGm0aSH7T4UDkQx252T9s5D+lyQDVo6n0btXnPQSlrWl8f7erZLDtN29tIYnj89CcHNBWhULdzwlgOJBTk0pfJxg5v0eL84r6RZRI0zBHeKUTbhnANMCij210+my7h+4y8ZVSvX9CrXGPhoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770079769; c=relaxed/simple;
	bh=Hm7FzUPxdWVVABSX/3Q3cCUaNB3cREv//ASK1B2etfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FzC4NmHDkP4cqxnHaHt6JjKKWEidzX8cR56YJ8Cz6693Ji82dJ4CiPC7UE7fS+plNjIK+7y4w/0LU1+CkW0FkQ5+yYpdqc7nAIjRBKTyobZ+QhA4vBo6MDKibbJQaCZxaUNESfOhvGZVAKSv6OGMgQeOpvqulS68CnIMZ0/Pfhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=IlxpN9iP; arc=none smtp.client-ip=74.125.82.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-dy1-f196.google.com with SMTP id 5a478bee46e88-2b7da62b487so6458104eec.1
        for <netdev@vger.kernel.org>; Mon, 02 Feb 2026 16:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1770079767; x=1770684567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qT1MfSdo7HvQGzo8ZvTZCniairqAvZI3FxEmw7sL3PQ=;
        b=IlxpN9iPjHt2eafvMYkQmvje3i93KuF3axZ6LDkYKmSOpzOCU6Z1XsSBaaO1tJkwWw
         U0FEfuV8Ineg1uQOCCuz9gLgcvY8Ieu2jo0YxAPDvjV4U0APtRP2S6Z8hPsd1cPdoHGb
         zN9C7cl9ob/xSf0Z5arRaXt2AwCSCux7IOPkLX5NaRMXgXg8EedQQx5YoIw0NGs7th4v
         RoqGpaIpmyuCbay3T7J1tb2+cj33wLKSwGG0aqbW7lVqWwZtlzVP8wE2yWsr46kCuJ9i
         pKjJqGVyjAtFwM2dkbWRWkm5gInUQPlFLnFOWxAk+kb1xze96d1fLAjpCEEbcMNGWxZP
         GNXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770079767; x=1770684567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qT1MfSdo7HvQGzo8ZvTZCniairqAvZI3FxEmw7sL3PQ=;
        b=RkrZAppp6zIhL5PvBAmDi7hItvbeAibPDc2X8Loqfj/nG6J14nbqlzj4uMHvQaUbD5
         5Jvjhjf/L36dz3Lr9FvynGCkPsz1i/0a7HSb+uB5GhfNv0RBEN6tz7432HmVxFbinjoU
         qHCUh1O2Vj0IuNIzNwvrkQCbDb7sba+jj+VbIio29gqA4Tyv4TXBqSeR/xQQQBFjRMvG
         DNJgWECzMpikTGUpmhLVUacH55CWLkxBGu4OFuCh1/WfaIL0E6xjwls8P9YB5PQVNk1d
         dYBd5ht8nJZ4yoKEWfp+E6mITufPAt6nbN10SX68Cwj6wt1z7PlED3PpWrd0PQrG07y1
         01Aw==
X-Forwarded-Encrypted: i=1; AJvYcCURUwLc7yBek/mdL1qd3XVndGNVkr36lHTVSjtvG0lZh+JLEJ7cWLSo6ourrYe2w0JJjIPviaY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaSTxvowO7+VOmscnW1o0hBjeZG5c1DoaO92H9Jqzp8477WhO1
	FWEdM0DJMQ3ba0ZoZ9sLuhBNW7DaCbhH53ZHOrFZ9mANFt9NTVZEkQuZWuLQBGArQZlsDYrhT4E
	l0Q7QRQ==
X-Gm-Gg: AZuq6aKsj0FyIayKH8gZ4mbpKCjTgfkXPV4unEFgqFvVNJe0EelLda2LLHosTVTAtXQ
	ARBF0iyMJuxjkpsDrlITUjq94K3Y9Quv3++EHLj0xOTWVIV4K9kM+RimkYPCu14XcvfE+hHta3K
	106gReA6eYA20CPVdxnP3D7LTwx+47lsx8umaF49APwvZ5PkL555QTroL2t/nIHE/769yLjDxJu
	ZNThqMkCVKThFfXZySOFe1lnTNyd8UZ4B/Q8eXzHuS5iwSDtHOs/Bm5xvQeFRJ6VfJPRNL2HMHe
	52UKhxvsKJCd1FAuiw7vz6RaQLLb3D9SIztbilMAHsaCIlyesVxkaycJYGZ61SgJyQRE4O/e31k
	xayltfuRLUUxdibtBuxIuuUsIdTdIDaHBVMzqD7JTLUBVSFriDPamU5shRlIeqe7AXDw+8Fb0sv
	u//8uwoTDOhyC0jGBcxYngGtknZPkqycAEmIEc+FOJTM3+2aNcmwXkzVN1
X-Received: by 2002:a05:7300:bc05:b0:2b7:a3a9:9c2a with SMTP id 5a478bee46e88-2b7c8902b1dmr6485346eec.30.1770079766572;
        Mon, 02 Feb 2026 16:49:26 -0800 (PST)
Received: from pong.herbertland.com ([2601:646:8980:b330:d7c2:35ea:5a4f:74f9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7a1abe92dsm21017016eec.17.2026.02.02.16.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 16:49:26 -0800 (PST)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	justin.iurman@uliege.be,
	willemdebruijn.kernel@gmail.com
Cc: Tom Herbert <tom@herbertland.com>,
	Justin Iurman <justin.iurman@gmail.com>
Subject: [PATCH net-next v6 05/10] ipv6: Document defaults for max_{dst|hbh}_opts_number sysctls
Date: Mon,  2 Feb 2026 16:48:48 -0800
Message-ID: <20260203004853.94438-6-tom@herbertland.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260203004853.94438-1-tom@herbertland.com>
References: <20260203004853.94438-1-tom@herbertland.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[herbertland.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[herbertland.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[davemloft.net,kernel.org,vger.kernel.org,uliege.be,gmail.com];
	TAGGED_FROM(0.00)[bounces-256047-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[herbertland.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tom@herbertland.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[herbertland.com:email,herbertland.com:dkim,herbertland.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A1A51D325D
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


