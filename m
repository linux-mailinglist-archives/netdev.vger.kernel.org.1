Return-Path: <netdev+bounces-280469-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WIvTNObz6GmQSAIAu9opvQ
	(envelope-from <netdev+bounces-280469-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 18:14:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B2FEE448584
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 18:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9655930FC104
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 16:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6830834A3AC;
	Wed, 22 Apr 2026 16:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bell-sw-com.20251104.gappssmtp.com header.i=@bell-sw-com.20251104.gappssmtp.com header.b="HYl1TdMB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49CA273D77
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 16:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776873993; cv=none; b=jgcGJ/1+sLW1Z0ghVMD0i46LUzpQemsAGkCPC2MoV5o5JifNwljT3CGQGekZ1MFLTadAyOljDjk7VGvAf0G21gptTSL+XzJ3lofxw6OXriMvfU4dYVYiLIHaHNK/u7FBgqlOTCGA89Lb16cY0P8FhHSj5ckoNaoWauUZz8njN7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776873993; c=relaxed/simple;
	bh=OES11U6RJhIxlpYHbZu1AGI2yaa+zPDWZog/rE/nnbw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mnR1Rc9YJNDoBb79XYB8+g1FWwV1hCTzLzC7jQzrJccuV2FsFOKUv4b1H8D2Gfkj2nPV85WD9tkCndcvNQ/cDi104VUMRFS7S3zqH88SapCK0WYy0Qq5G+WUi3TT6VI5ldSUQtrXscSZFYR9942G+oqyZTtAK1t+BJ0M4VQNOJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bell-sw.com; spf=pass smtp.mailfrom=bell-sw.com; dkim=pass (2048-bit key) header.d=bell-sw-com.20251104.gappssmtp.com header.i=@bell-sw-com.20251104.gappssmtp.com header.b=HYl1TdMB; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bell-sw.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bell-sw.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-79a7109f568so67275947b3.1
        for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 09:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bell-sw-com.20251104.gappssmtp.com; s=20251104; t=1776873990; x=1777478790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/3fX2z9Ff+ct+KP7n89t0K+j23JpEAx6OoiTsK1z6EE=;
        b=HYl1TdMBKtbUtToN3GmTQGDieBaOmYsMUixq5t/bu/wuk9xiYrYjVu3qS6vFqK1Nuv
         oqXhU1m9T1OaXaZ3fP4JbNJY01cszxkf2NoH9oBs3aWJ2T3XDw+3OtSjd6XDetl3EYPV
         Ulvz2rxtOKlP9SIzDQsw/cq9diyhMErZf/RveN3ZtC10SJsxWS+McxAP3W7OavJHFBU+
         kPdprNfRpnFaKIzlRPs5+yuotHvej+mlBwFTLOBsxx/ayRd2t2klLR5RqIyVjSBpTZHm
         UH6rthaPAL9nS4/ww7LUWRp6LVT2UMq5gIND2GFBTdpvpI+xuwO8Y9pZG22S230BM+La
         HI7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776873990; x=1777478790;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/3fX2z9Ff+ct+KP7n89t0K+j23JpEAx6OoiTsK1z6EE=;
        b=Y1M+HbLHmTnJP/PBZl2taCUyGfosDMYS5ZmXdjkIbp8DNQQC14bUgD7hy14DP0lIAO
         iWsMcpU2ctyhxfy3zMB9i5WiX1v2VeC5aMZlaGudhsyZCZDxAGtfMf+luJ6r9AWf4oOT
         Kb0otyg7MJkSew4lRCAO/n7TBJnPWrVSgSe9srwMIhOBb3ZAq+DYHIYlnyyMPtQHxlHn
         Wc8wVkA2hZSfJKcMidiCdpdwyj2XDiIy1fO6EWehDOqZBrz9HmZGbZJCA6UFVr7zrWZb
         YJvguOTIJoNOslC56WCa9iWgHnkRbDAQiTKIdDhZmkxZ/aA04YnidY5/bNlVvtjCh3EF
         R57g==
X-Gm-Message-State: AOJu0YwhRfw/di5w5jhoxbp+1D4dvgRxW2nmU9uj+IOZ+ahv2qjcW3bK
	BkQkjBK4o4vvcb6ZK0AbmBxjlMYungEd94KDiCdfNBHtzX22edO5PC12pWI2QVQqFO/XG3aPXfE
	ROns=
X-Gm-Gg: AeBDietPB36LxiVr9dktnv+zWob9mtn9YGCxNqv50VDClWe0u+Ng/ciu3ATRKpt9gAp
	n2FJya2VliA/TqWnF/maEsW6FL+sz1Qh+FRcvKUIcptWmpulZtgixmgmrUUTlVQu1FLoFjZ62Ln
	7eTsw4mCT7KElHC0JkfjnCjyMOxq17WZN0FqhL9xtCnmjU3xePfw2J40qsr7gcwW+EB6oWJ9mH9
	yVgBV+Sc0t/3W2ehVbQXZaPWnJOdoEKmAYB1hfjDEfcL1ejtcacdGdE+UgXZry8S20orzjET2Nt
	Lc+73bva2WMOyXXu0wyRth0Dy4nOF1fz1TlY35IYHyE0wna2mNBWOvdcqTwAQ5ux/iU1/ZvYm6s
	VfW1T5yaZZoOPLfAo5XVo554SIt76H5jHbjTc38jx7yyXKbIajURiJqHX+om2D6IxVFrTP9hrA6
	xDVbIaiMrAPmUnRLh2GJnDOVP/+0nnH5wa3JFvV1/ZEbe2YUNTTRHcAA==
X-Received: by 2002:a05:690c:e3ee:b0:7b1:d1af:4ba6 with SMTP id 00721157ae682-7b9ed03cdf8mr252646437b3.43.1776873990023;
        Wed, 22 Apr 2026 09:06:30 -0700 (PDT)
Received: from localhost.localdomain ([185.119.0.227])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7b9ee8c03c8sm71079887b3.15.2026.04.22.09.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 09:06:29 -0700 (PDT)
From: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	oss-drivers@corigine.com,
	Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Subject: [PATCH net v2] nfp: fix swapped arguments in nfp_encode_basic_qdr() calls
Date: Wed, 22 Apr 2026 16:05:36 +0000
Message-Id: <20260422160536.61855-1-aleksei.kodanev@bell-sw.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[bell-sw-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[bell-sw.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280469-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[aleksei.kodanev@bell-sw.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[bell-sw-com.20251104.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bell-sw-com.20251104.gappssmtp.com:dkim,bell-sw.com:mid,bell-sw.com:email]
X-Rspamd-Queue-Id: B2FEE448584
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

There is a mismatch between the passed arguments and the actual
nfp_encode_basic_qdr() function parameter names:

  static int nfp_encode_basic_qdr(u64 addr, int dest_island, int cpp_tgt,
                                  int mode, bool addr40, int isld1,
                                  int isld0)
  {
      ...

But "dest_island" and "cpp_tgt" are swapped at every call-site.
For example:

  return nfp_encode_basic_qdr(*addr, cpp_tgt, dest_island,
                              mode, addr40, isld1, isld0);

As a result, nfp_encode_basic_qdr() receives "dest_island" as CPP target
type, which is always NFP_CPP_TARGET_QDR(2) for these calls, and "cpp_tgt"
as the destination island ID, which can accidentally match or be outside
the valid NFP_CPP_TARGET_* types (e.g. '-1' for any destination).

Since code already worked for years, also add extra pr_warn() to error
paths in nfp_encode_basic_qdr() to help identify any potential address
verification failures.

Detected using the static analysis tool - Svace.

Fixes: 4cb584e0ee7d ("nfp: add CPP access core")
Signed-off-by: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
---

v2: tag patch for "net"
    add extra warnings to nfp_encode_basic_qdr() error paths

 .../ethernet/netronome/nfp/nfpcore/nfp_target.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_target.c b/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_target.c
index 79470f198a62..9cf19446657c 100644
--- a/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_target.c
+++ b/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_target.c
@@ -435,12 +435,17 @@ static int nfp_encode_basic_qdr(u64 addr, int dest_island, int cpp_tgt,
 
 	/* Full Island ID and channel bits overlap? */
 	ret = nfp_decode_basic(addr, &v, cpp_tgt, mode, addr40, isld1, isld0);
-	if (ret)
+	if (ret) {
+		pr_warn("%s: decode dest_island failed: %d\n", __func__, ret);
 		return ret;
+	}
 
 	/* The current address won't go where expected? */
-	if (dest_island != -1 && dest_island != v)
+	if (dest_island != -1 && dest_island != v) {
+		pr_warn("%s: dest_island mismatch: current (%d) != decoded (%d)\n",
+			__func__, dest_island, v);
 		return -EINVAL;
+	}
 
 	/* If dest_island was -1, we don't care where it goes. */
 	return 0;
@@ -493,7 +498,7 @@ static int nfp_encode_basic(u64 *addr, int dest_island, int cpp_tgt,
 			 * the address but we can verify if the existing
 			 * contents will point to a valid island.
 			 */
-			return nfp_encode_basic_qdr(*addr, cpp_tgt, dest_island,
+			return nfp_encode_basic_qdr(*addr, dest_island, cpp_tgt,
 						    mode, addr40, isld1, isld0);
 
 		iid_lsb = addr40 ? 34 : 26;
@@ -504,7 +509,7 @@ static int nfp_encode_basic(u64 *addr, int dest_island, int cpp_tgt,
 		return 0;
 	case 1:
 		if (cpp_tgt == NFP_CPP_TARGET_QDR && !addr40)
-			return nfp_encode_basic_qdr(*addr, cpp_tgt, dest_island,
+			return nfp_encode_basic_qdr(*addr, dest_island, cpp_tgt,
 						    mode, addr40, isld1, isld0);
 
 		idx_lsb = addr40 ? 39 : 31;
@@ -530,7 +535,7 @@ static int nfp_encode_basic(u64 *addr, int dest_island, int cpp_tgt,
 			 * be set before hand and with them select an island.
 			 * So we need to confirm that it's at least plausible.
 			 */
-			return nfp_encode_basic_qdr(*addr, cpp_tgt, dest_island,
+			return nfp_encode_basic_qdr(*addr, dest_island, cpp_tgt,
 						    mode, addr40, isld1, isld0);
 
 		/* Make sure we compare against isldN values
@@ -551,7 +556,7 @@ static int nfp_encode_basic(u64 *addr, int dest_island, int cpp_tgt,
 			 * iid<1> = addr<30> = channel<0>
 			 * channel<1> = addr<31> = Index
 			 */
-			return nfp_encode_basic_qdr(*addr, cpp_tgt, dest_island,
+			return nfp_encode_basic_qdr(*addr, dest_island, cpp_tgt,
 						    mode, addr40, isld1, isld0);
 
 		isld[0] &= ~3;
-- 
2.25.1


