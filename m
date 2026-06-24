Return-Path: <netdev+bounces-301634-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8XGZBAzMO2oUdQgAu9opvQ
	(envelope-from <netdev+bounces-301634-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 14:22:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CCEC6BE0E5
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 14:22:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Ll3pdBFM;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301634-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-301634-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A9B7E300C9A8
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 12:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67EDD3A8743;
	Wed, 24 Jun 2026 12:22:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124A439DBC9
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 12:22:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782303753; cv=none; b=nb0fLhcOdcwcMjqvNKSUJl00XZ6gAP4Vff/E+gE0yDVD8WAScwt0RHRX0jv7k7srtbZ6fMDHeq9luUfpCttZ8mwP1M9xfI2d/rURDrWXvrCvzdgdywT2RbyiKidx7QIzy1E4uSaeUsEgQP564chokAkoaMldPKmCI7rLpAOHL6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782303753; c=relaxed/simple;
	bh=FnG9zHq+2xxL21OVE0ldGOEIqmMpwP6fHAL5vebTYj4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E37rstu6co50CFQroL/1UW2Kz56rb2UOBYh9g1mWklXRgpHS5pn9MYamqa/MUMUc/BogJiCTOGqSkMc9L9g5cU1H4c+JDueMxWlQvVRZVYB5GuRkA/Xu93UTB6uD3DM3h/qr6FEdzhU993iVtSAAhnYoLLv8OOMR4EtYF/U1uM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ll3pdBFM; arc=none smtp.client-ip=74.125.224.45
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-6647a6c1f0cso106109d50.2
        for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 05:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782303750; x=1782908550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c3hCWf81IkIHy8M4N5mPkeK3GOsJg4h+ZHQGj103FE4=;
        b=Ll3pdBFMWhKGBRZbzPTY8hdN5DvvY3EGY9o6W3Hp7MvZce70I5py899BshXy0LTTuj
         ma0kKCpEFlrJ4VQCpXtlG7grbC2wNcc+725u31pA7XuMu73m6j+rtJb+lPxF2T0DVU9O
         NkrMn3Po7ifwemlg7ehQ+/mWStRNPeQdKoTqtOnp09XCwH7p+DLoB/0KD+cUxkXbSBAZ
         3mvdc05VRBXT8DikGnWJew4d1l8kXeEB4Ta+ZIfv3ARrgVMGVJY1Bw46gAARk9tE9yr8
         OpNeD1mcXmndjdkBXjKqyvBzNwL2ZDdN1DFPzr52Ag4Hefw9jGLE9YaYDu+auXY1Eikz
         l7gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782303750; x=1782908550;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c3hCWf81IkIHy8M4N5mPkeK3GOsJg4h+ZHQGj103FE4=;
        b=qIv33L3WRxNdt8zpX7vIYOMj18JfTE9XTotHAm6oNTJKcdM6T3sWl1MrIkKVaQivpO
         sl7JdMQINJfA1YKbqPT2OqH1Y/H6Uv72bDUJVL3KQ/x5Usok/UQZnMMu8BnbxK3ZiV3Y
         ul2bJj8z4jH2siiEM7mTm8oq7atqXgmXipr4h7r+x2iRXT2a+KhWLFTVIrM6IUssXKgj
         WP4lSHbKzmB4O0CI/s1c0x2nxXkuzmXYnaO7pYbTC5A9ko08Bu2/b1H3/cOc4xU/LP4U
         yUKtoQGzne0Ko0iYgpoFvCMwGGFD02atHu7WflV0VCwUerFHuI1cmgqFBbHu3XfCY+1u
         rFxg==
X-Forwarded-Encrypted: i=1; AHgh+RogN2Hb+hNzO8j74WcrYAhKf3byXNny3XeWsD2l2e8iSRXAmoVPSuDjr+8kSY6mhwr061O8MfQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGlx+9xwbcXGbq1X3QpHm2vptVu8AXe9Gjvmj3AvtSZRpe8F4q
	laEgkwwH8WykJVAderjYvwOPpiotyM/YJH1j6/gUbdXcUgHeFrRNU0fa
X-Gm-Gg: AfdE7cmH4dVWaLJ5jYY+FXcG0ZyBI5r4UT7PPKwr5Yn3J9e4RdqGtYet2bgxzP8h6d5
	agB/pV/IVGb73bebCr8oaWle6/xfJdbN8A7ZpjP7Qq2rHX9IZkwh6lOXiD+QyLTSrr8/s1x7LqS
	BJ2mZiPsvdZFjnmKMh9gKiqrImew5UY4unG5CZfHvRCVUxRaXmIsESOWKsVe/tSmuIwdmoEVxxR
	59zDUktxaFkN4KL6+kusixhnlBh2dX2849dwzECpnH8Rtuxt7u8wvyPxUYDYfVrcSfJYfmV6agQ
	K3p5PBVJSSA/W6yqvvZKUAENhPjVDi7Bukp3POX+gYCmAsw2h5FCobEQL/D8eEgnyyBDlqytNm8
	73NGZqrXPD282AOboIjzzhc+Q4BoE0Jfp7rschF6F0SQog/05uU2REoOyDyTEFp7E93IpPEzBpJ
	7OQ3hFRR8uhSyDXNXKy7WaXMjrzxORpmKx/A5O
X-Received: by 2002:a05:690e:120d:b0:661:1307:3d62 with SMTP id 956f58d0204a3-6636e61116cmr2426807d50.52.1782303749893;
        Wed, 24 Jun 2026 05:22:29 -0700 (PDT)
Received: from Dev-Null-MSI ([2a0d:3344:52ac:a808:98a4:4381:be45:536f])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66314d444c7sm6614118d50.13.2026.06.24.05.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 05:22:29 -0700 (PDT)
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH net] sctp: fix SCTP_RESET_STREAMS stream list length limit
Date: Wed, 24 Jun 2026 14:22:13 +0200
Message-ID: <20260624122213.4052-1-alhouseenyousef@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-301634-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:marcelo.leitner@gmail.com,m:lucien.xin@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-sctp@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:alhouseenyousef@gmail.com,m:marceloleitner@gmail.com,m:lucienxin@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[alhouseenyousef@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alhouseenyousef@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2CCEC6BE0E5

SCTP_RESET_STREAMS carries a flexible array of u16 stream IDs, but the
optlen clamps treat USHRT_MAX as a byte count and then multiply
sizeof(__u16) by the fixed header size.

That caps the copied and validated option buffer at about 64 KiB, which
rejects valid requests containing more than about half of the u16 stream
ID range.

Use struct_size_t() for the maximum struct sctp_reset_streams layout
instead, so the bound matches the flexible array described by
srs_number_streams.

Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
 net/sctp/socket.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index 66e12fb0c..b8f13044a 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -4111,8 +4111,9 @@ static int sctp_setsockopt_reset_streams(struct sock *sk,
 	if (optlen < sizeof(*params))
 		return -EINVAL;
 	/* srs_number_streams is u16, so optlen can't be bigger than this. */
-	optlen = min_t(unsigned int, optlen, USHRT_MAX +
-					     sizeof(__u16) * sizeof(*params));
+	optlen = min_t(unsigned int, optlen,
+		       struct_size_t(struct sctp_reset_streams, srs_stream_list,
+				     USHRT_MAX));
 
 	if (params->srs_number_streams * sizeof(__u16) >
 	    optlen - sizeof(*params))
@@ -4598,8 +4599,8 @@ static int sctp_setsockopt(struct sock *sk, int level, int optname,
 	if (optlen > 0) {
 		/* Trim it to the biggest size sctp sockopt may need if necessary */
 		optlen = min_t(unsigned int, optlen,
-			       PAGE_ALIGN(USHRT_MAX +
-					  sizeof(__u16) * sizeof(struct sctp_reset_streams)));
+			       PAGE_ALIGN(struct_size_t(struct sctp_reset_streams,
+							srs_stream_list, USHRT_MAX)));
 		kopt = memdup_sockptr(optval, optlen);
 		if (IS_ERR(kopt))
 			return PTR_ERR(kopt);
-- 
2.54.0


