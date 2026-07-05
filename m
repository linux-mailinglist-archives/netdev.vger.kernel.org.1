Return-Path: <netdev+bounces-304816-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XJHIDb3OSmqHHwEAu9opvQ
	(envelope-from <netdev+bounces-304816-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 05 Jul 2026 23:38:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD0D70B7D8
	for <lists+netdev@lfdr.de>; Sun, 05 Jul 2026 23:38:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=yahoo.com header.s=s2048 header.b=N3SsMR5d;
	dmarc=pass (policy=reject) header.from=yahoo.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304816-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304816-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E30A30063B0
	for <lists+netdev@lfdr.de>; Sun,  5 Jul 2026 21:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3900359A90;
	Sun,  5 Jul 2026 21:38:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from sonic303-22.consmr.mail.sg3.yahoo.com (sonic303-22.consmr.mail.sg3.yahoo.com [106.10.242.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF5C2DC792
	for <netdev@vger.kernel.org>; Sun,  5 Jul 2026 21:38:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783287482; cv=none; b=bUE9LrD2TctWa/Y18wLsFotLAU71v3bH3SfRELhu7hf/PQfxwoAXTSywSScmvnF5UFp3BfeeQKdpDK4vVg4rM/fyAoOZCsaRcsJaFE+ZVxPeVs6CuBRSyJay4SH6dH5W7HDd2RvEN76ik+ElheMeMy/3sT3bD2aVQ1zl83P9BSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783287482; c=relaxed/simple;
	bh=bJ7PaBfd3x3lBU5h7Ebcue4yo4GBvdL+kOqYGQ9V98U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=SKQ3fssfmqwlPLqUpEN4fK38KzFV4HrbHi10oerk02CtHfzcRCXQ7/tFeFJfLRlUkqYmBlMXUyd0wHO0I7AvON8yuLvawLghwuJ9qHP5ZuS3desNecnmLL2ljmOGU6ZoJOPeIP+6PAJv9J1DGGgKYcJQNZve2RtgaqhkXA4eBlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=N3SsMR5d; arc=none smtp.client-ip=106.10.242.39
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1783287479; bh=ev6TcxQOxq4IjUViXN87CoQCMCwqYIDTzOXWg/41fPc=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=N3SsMR5ds2VOKGT/cWTh4T+LbMULRwvJqslLuR+ePMSUSSWx9xVm+3AHsgPRlpC9OKRZ0KGmkadFsjvsWZsvTOcPMkku4D9Pyc7tWykkhJCIfwZCuSO5ZlXxPLHE02uz6IGIVAom7PEIHPOxNuQHjGRXwiAoT0o1ELwZYuJeU+ThUrOrF2s9uLWk5ZE4jE51XRhdEh+FEdT1mzCibSCRGHtulTiqdfCgUisuiqDPW5gVNLC8r4a/ZRdpd2PVzeoHesJ3kJ0pzM/NGho5ULdeyCaxvgNg3UL93GpzKUnl5h5iP+dyRPPeyzrLXjYbvbyKzbxYGlJzDOGkQ2x9aCkwyw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1783287479; bh=Th4JhHIaHz+QDkTgU1pMaqUn9/PClF86LSuyyQ6zZ9W=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=nAFQWri9EI3ZL75JgqO80I1xGBUqN138mNVniRKP7tFPPaj4nZJw3mmUkDtWu9JzqsMVwBG+Pu/ovbcMJ8OlVD6SJhrjp8VbA2A1Bvxdnru/M/e6P4iX0mTDVvYeBYe7bvqm+iHcslQerJGb5CCBvQm899dF/ec0qugJxuj7S8m7vN2KcWNzej5Z/Dh2/i2zrkhKa9fcOmeGnfHAr8kY583+U0J5x7wmeuwu2BACKe52w3Z7EJXS037YJKoEjQ2Xkyn/kIJXEtcPl05zal/3NPbmAJi0buomGxisTB1bDBnZJuOkgq8/YysYnHUiCXIqg7UIf8UsvDe/Aqogdr/SrA==
X-YMail-OSG: HM.Q6A0VM1lfAGCWbf_Uvvb52dMZH2uNYTpFcLQ4KKxzbDQh9BNAdCNzQEfJYht
 7Uz.wrtdj1WOA0O4YcgmFkwEpqU3Bv2NHOhfISwbbvCKhDLgPy0mQHz_UtaDdVSDFVcclueov.NO
 gCj5vwSFpviUTPpbW0JIWlGkfKtDt5rhK.wMUvGO4qBP.Y9fEHTJdwhgJ.P1YSaaYRB4zX32E7C6
 NKrSIPhgTnwWANMf4QPoeQv5zQ85WmJZdTYdxSi5SOoE93LEyt7pRFOv334ihggKp1bZiVkvDgkw
 u2UjB9IldkZ0FYF1XOimr1fTL.VcQV.2AIlrMg7gNeL7URaohP8hARfE37wfkQ4sxy2t7P6o541u
 kQndZ3180jZKxWruddxf352JjgM571Bw2toHKD6UXXTEftK0mOEXWmHP6h7sWKy8POrFN6mf0SiK
 y2mhEjJZocjtIyLN2z7j2Xvq7RA2IEPjLVXq.6UY01ef.ksJTzxyjdQQLNBY1ItkWuoVHjQn8.8j
 PIvnUiX_xBQHjmUZlPiqRCGNGM6fD3tP77CwuKmBh2YlNSiVCTjOOrbwkyGNFUjaz85.zakKghft
 dL12WLj2BUEE3.WOjEzMPB22HXvCt84R0eWC2dOA9prlXO3.zA6CLW6figUhgs8FF4KaYnhl0slt
 7oSryq6hKR919s8U10ZmZV_JNDYqNPogpr7UkHA3bMPEqAEvm4T79Wya2c.ec9bTCeieIqFCfyNd
 lslqsnJuw7QY_dM0dIcVIDZDf1DYZiESsMLsXPB.rDnp7X2Q9QIoZEYfUrevw2lFlwPNVZicI3Kq
 VsXrdvgSRJLCOVxt43GayUAEky4DkSZ7bvb4ttDj8lzhblyIaQDoku6yYtOmermEp.59E5FyiNy.
 3WW3UzY2OudHn3cmWaewALO0hCkPwDYjlT6n7MpMq_q69VmMYn4ba9SbGLGPc5tMqOvkoQSr4kTx
 Dg0BfCwTXNC9fZpFRuGCXm3MMvZKDsUX0ZFaMHbRu5V1zXU5Gnlfi6_8R3a9HTrkGV1oLJBj0dZa
 sEwC6SAI5NTCw42MEwrSNB5ugpNAtqR4VfYsGW9Q1RFVZQ6cbK_ApoDmmjHJiNqsRxQfutXtlrkM
 bFJKxxW2TrY7U1sFI.0iQIf4y9Plen5AFdv7S7mX4wpdgRRBTrNY3YtSXbuSEmrP48it3Iy5tHqG
 jsnWmUFD6l9iBmcL7cU6QNXRb88y9nUL4H.f1dXw1kVvLTo7CFIRma5U4OrW.WBnIa7vpGXjRHMl
 Gg9oR0m1x2tAaTtIicFgISic3rAEmizeCZrRVLqiqoEHYLJPF.BQwG28ZlWoxaHSyumdy_APgI4v
 IH3rfXaN3Kv_y0iVphiR_KpG.RI3wCG6nqjBeLzQZMHmzcJwIj3svwA0GSE7YqMI7Fys1bJHRa23
 R3DozQJ0.2TPRx.6T3Sxp4w0fHM4tyMKxOV3lGDboiQ1wg5TQbYHVjszmq3tBKvUl0ZEVt5lG.MP
 ORtpqXe1fDegEA_JS9EdIUw8APRF_iKFnNjjG9aQUqzrGp0eBMmS_3FQeWjyXPx602NECOgfqqs6
 _sRbdCjrV8c15da98.UHlsAThKaiRNY0bR.BoKIm8BDfpiMzH0XQkP3t4IOzLQYuv8x1MXpWAYpc
 oKi3wCkG_zKm.2bXlbIBE91AwwKp4p6ilBroUWJ4UaX3pbXRJPpayYVgeJLxrdBX6jCeHLOuZuJN
 KKnVkyMxy5FPG9DqmhNXUItoBsozs9fWJGESLTv3gc2ElaZ2CaEu1fSsExUiQBPttMLKwQaTv9oQ
 dkjzBhlegOLt2xBVjDLn3rvF.XO9uD5Iv6aNH5C_JV8fSLz7bhgWI6vXrGcFnhcXTpiJSCXJIBEf
 qCoe5SCMXuqjIrNsZxAgL7r_pgbZPNbkoaeRdn7IRB569TbiT2PusdsJ.7IgvzLwnShHsHkg5jnv
 NIyHljDDJVbWuwoxLOkwLJePBqbJ55olCejvI0GWo8BCLWwXTJEiCt9J0lEjkuu53TnBifpVoGcr
 u8Oi0GF9Gj7HdRG_nPOHarmbvjhYSS37sRbKsI7p3KDXqSGpQkosCTIPF.6cYJVuC5tfQn0CesTg
 2c15RNZcDrMX_aA15KLlomPRtFQHsKFNY0CzslE4KMY3YxJbZu8SdcXogLgRgUB5w8maxAQKrDn3
 AtN7cAVREZc3l7tYqpf1Ce1Ut3fXfd9S0ox1lCkhkBcohKg9fgGNODdtVe9COLHolOJatuPDzPpX
 8BS7ic0BSOU1CZO5yIbYRHF6wLj1FjjJvWbnnZV70j.PfbiHVCkT89d2z3zoOCqP86ks-
X-Sonic-MF: <dharmikparmar2004@yahoo.com>
X-Sonic-ID: 9accaf53-6f2f-4d39-8e71-58640a4ac3ea
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.sg3.yahoo.com with HTTP; Sun, 5 Jul 2026 21:37:59 +0000
Received: by hermes--production-sg3-847cd67bd4-92cbz (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 5d2170ff3249e7e6e43152568d545afc;
          Sun, 05 Jul 2026 20:43:06 +0000 (UTC)
From: Dharmik Parmar <dharmikparmar2004@yahoo.com>
To: netdev@vger.kernel.org
Cc: Dharmik Parmar <dharmikparmar2004@yahoo.com>
Subject: [PATCH net] selftests: netfilter: conntrack_resize.sh: fix skip exit code
Date: Mon,  6 Jul 2026 02:12:52 +0530
Message-ID: <20260705204252.630729-1-dharmikparmar2004@yahoo.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20260705204252.630729-1-dharmikparmar2004.ref@yahoo.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[yahoo.com,reject];
	R_DKIM_ALLOW(-0.20)[yahoo.com:s=s2048];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[yahoo.com];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-304816-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[dharmikparmar2004@yahoo.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:dharmikparmar2004@yahoo.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[yahoo.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dharmikparmar2004@yahoo.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[yahoo.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7FD0D70B7D8

When conntrack sysctls are unavailable, the test prints SKIP but exits
with $KSFT_SKIP.  lib.sh defines ksft_skip instead, so the kselftest
runner did not see a proper skip.

Use ksft_skip.

Fixes: d33f889fd80c ("selftests: netfilter: add conntrack stress test")
Signed-off-by: Dharmik Parmar <dharmikparmar2004@yahoo.com>
---
 tools/testing/selftests/net/netfilter/conntrack_resize.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/netfilter/conntrack_resize.sh b/tools/testing/selftests/net/netfilter/conntrack_resize.sh
index 615fe3c6f405..51564092cec4 100755
--- a/tools/testing/selftests/net/netfilter/conntrack_resize.sh
+++ b/tools/testing/selftests/net/netfilter/conntrack_resize.sh
@@ -22,7 +22,7 @@ insert_count=2000
 modprobe -q nf_conntrack
 if ! sysctl -q net.netfilter.nf_conntrack_max >/dev/null;then
 	echo "SKIP: conntrack sysctls not available"
-	exit $KSFT_SKIP
+	exit $ksft_skip
 fi
 
 init_net_max=$(sysctl -n net.netfilter.nf_conntrack_max) || exit 1
-- 
2.43.0


