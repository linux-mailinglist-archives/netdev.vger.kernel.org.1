Return-Path: <netdev+bounces-253583-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0B+QESzFd2nckgEAu9opvQ
	(envelope-from <netdev+bounces-253583-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 20:49:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC518CC07
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 20:48:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0A5BA3006088
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 19:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DDA128726E;
	Mon, 26 Jan 2026 19:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="B3ajmMgn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F7D285C8C
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 19:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769456935; cv=none; b=J5px+tKgex/wDw1cydKRhYYztAQA3R/76IXJVP1b9jlMjGSeYeBu1I29Y/OTbCAP0i4jGdYhwhTfk40ORA/zd9+acnSvI2ZPOcfDRF1xccMIFqrzODOHLmiG4U+8z+Lg5HL0hM/i7ncZJQayLmS8sX3kHS7t8jDO2IsqxxUqOUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769456935; c=relaxed/simple;
	bh=C8OZ95/WAU5Mgc4JqBFq9iwhhE8rNCstGFD15StYgfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qGOMhgjzmS84891iVwqLWDVFKM+JF0sAL9g7q2+kwsMzYSmNHO+kJq+3BJZFyZxwMjLmXp/bxsc3X4j00ZPdByf2Fj5kTBVl/nAjbtce4/4Yv7hYHSP3mP2/tdeuzqlJJdXnTy8Ev0VJjyhCcw0n6ia6TEaixQ4aygPWmTW7RsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=B3ajmMgn; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-12332910300so606082c88.0
        for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 11:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1769456933; x=1770061733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZO6+38dWH2OotCsTPz22/g1kneoq3nExDC81to23zRA=;
        b=B3ajmMgnAuskgtVVaH6oYVyV/Wb3OHQSMfkowWMYbk0aF6S1t+3X4UBey1CMkwsxNM
         8AC2WuZcOcVk2T5G64AkJBeHLJYJ1kfNB4niGX5IxDg8NeOaWID2lU5rtg5+VEueTa3Y
         d5uz66iJciOZsCdLlUBQJ2VUC4IwY2/iOI3DzVfRzlocct0Jbg8YzUnmhsR7xW8gpAhY
         ECFh/vuU5U+PVpwKlEsFiZ2qW7yHYRUrxdCpvyWoEwrws3UctBKQ3kFmFbZEhFHoFUMl
         i3srzF8s+on0ePXTaDU4KVLcVF5DLH0QqFwDM8nYltBWi2SDQNAWw2yTJ+RFIAjNXua3
         gAAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769456933; x=1770061733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZO6+38dWH2OotCsTPz22/g1kneoq3nExDC81to23zRA=;
        b=AZaMjL+fcUl6Z3p497AX1NoxmbiAcD0zXophmjh+aYaBwUNzAN9oRU0f8Kvno605Li
         v0i/WUNVBd59s3CN3o9pDjSjL6Lf4k9VHoQSLjmIoUXJhOWQ1IMyXDlVcib1mo1NHzF/
         OU0+gVdXlTiS2ZVJ/YqxNXkG13hjmSk7EzENQRhbE6iohKl1V2OlikmgbW1ucHSIIMfM
         0j19PJ3hcWpuYcp1PD4oPjFW7THxl8A4eidrR8E3AQpsiD2eiRYwAnFq6h8tAJQgu+uu
         1j6s6ehDYmuzzlFcqwDh90QggPrXXI3gxDHssuCaBgP5fRnwbfRZMUT7L/1Jva5IL4eG
         gGEg==
X-Forwarded-Encrypted: i=1; AJvYcCVgdHeFEO6Cwzyzz0qez57ecdfwNKt5R+xDWuFIPG9qIfHs9wOcOfrl9uviacwtPUD2Tud1Czw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsEaaI1x56uKEcVxzi3n/sOBYUeI3cKKcMJ+xOifJeoQfID/d8
	zoXviBkEZ2JKvK2yGLKw1wh8121iD+xLNcGgToxNKaAP4ZnTIny7bMtlZbiw3Jbxpg==
X-Gm-Gg: AZuq6aKMnrFh7c1OButToU4C5a76V2LplhldDLUQMov/C50kpq4cFKgzjnkq5V1LyEy
	9PtfM/ugsmJUcBOnoB6gy1Abrme66NEQjKg7u9pEiSR+Jr26nFLx3pG+6HLDBAsCanqqkzTa3vB
	Fh19WPta+9D40JaGB+3Aa8fyuqM1uSpfD4qFjp4inB64UkUXtNYyKqSTa1w8dO8K5F5k9Vvgg3R
	SMUD6npWgx928Ole6IRnq0g87QlzarBXFauLHfI+cT7p90uHwfeFUVPyZtt6d7RLf/o4HjeRVJR
	G49iqg2smkbRMXFoKZSNP6aP8vIoKMRYPWWvGfJbljYhATB6evOCvgpaRpb0ZliUMSqR0pbErFz
	4enH1f18o9bFyPBztN62h1eX1/XUBW5kMij1ZLnCb5dRsfLQTTg7gOLprAvkFk4NQPC4n7CJaYm
	pgqURCCzCfSW+wT8byvDioQ6wvQN1UL5Z753GmCLnleC7/TVFYCVjJxw8=
X-Received: by 2002:a05:7022:6ba5:b0:119:e569:fba9 with SMTP id a92af1059eb24-1248ec6f858mr3517480c88.24.1769456932469;
        Mon, 26 Jan 2026 11:48:52 -0800 (PST)
Received: from pong.herbertland.com ([2601:646:8980:b330:1485:5851:22a:4c2d])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1247d99804asm21121295c88.12.2026.01.26.11.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 11:48:52 -0800 (PST)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	justin.iurman@uliege.be
Cc: Tom Herbert <tom@herbertland.com>
Subject: [PATCH net-next v5 4/7] ipv6: Set HBH and DestOpt limits to 2
Date: Mon, 26 Jan 2026 11:48:23 -0800
Message-ID: <20260126194826.236075-5-tom@herbertland.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[herbertland.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253583-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,herbertland.com:email,herbertland.com:dkim,herbertland.com:mid]
X-Rspamd-Queue-Id: 6CC518CC07
X-Rspamd-Action: no action

Set the default limits of non-padding Hop-by-Hop and Destination
options to 2. This means that if a packet contains more then two
non-padding options then it will be dropped. The previous limit
was 8, but that was too liberal considering that the stack only
support two Destination Options and the most Hop-by-Hop options
likely to ever be in the same packet are IOAM and JUMBO. The limit
can be increased via sysctl for private use and experimenation.

Signed-off-by: Tom Herbert <tom@herbertland.com>
---
 include/net/ipv6.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index c7f597da01cd..31d270c8c2e4 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -86,9 +86,12 @@ struct ip_tunnel_info;
  * silently discarded.
  */
 
-/* Default limits for Hop-by-Hop and Destination options */
-#define IP6_DEFAULT_MAX_DST_OPTS_CNT	 8
-#define IP6_DEFAULT_MAX_HBH_OPTS_CNT	 8
+/* Default limits for Hop-by-Hop and Destination non-padding options. The
+ * default value for both is 2. This sets a limit at two non-padding options
+ * (see sysctl documention)
+ */
+#define IP6_DEFAULT_MAX_DST_OPTS_CNT	 2
+#define IP6_DEFAULT_MAX_HBH_OPTS_CNT	 2
 #define IP6_DEFAULT_MAX_DST_OPTS_LEN	 INT_MAX /* No limit */
 #define IP6_DEFAULT_MAX_HBH_OPTS_LEN	 INT_MAX /* No limit */
 
-- 
2.43.0


