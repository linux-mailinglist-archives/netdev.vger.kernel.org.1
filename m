Return-Path: <netdev+bounces-300041-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id H6mWKZI6Mmp/xAUAu9opvQ
	(envelope-from <netdev+bounces-300041-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 08:11:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C39C696C70
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 08:11:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=canonical.com header.s=20251003 header.b=L1dNSXLd;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300041-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300041-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=canonical.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D036E3019AAD
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 06:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB773B27E2;
	Wed, 17 Jun 2026 06:11:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F02F3B27D8
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 06:10:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781676660; cv=none; b=pSeklylPPUUc/14VI9Zf4ptmypY8800xSlEZRRSoR66ctfjuLE5R7geOXWvMatW+ptU6Zff1eUMujs1jVqrLAszYlwfzcYz/LMHwUJWlWprCYAeFbstqOXIhLjmrDx5TSTR16UzLbpoELxBFKu5cTioyLdP/Tv1pPPHYSQJp8Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781676660; c=relaxed/simple;
	bh=oJAtrOLVtF+GBmtQGqaY9bBzbr0/iVZWQUsi/oY1hhc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VdmO2jURD/lwPbbEQpnVJDfmyYciC4lOZAfuvAwpRH7X/Epk1KU1dQ2AzuR1SfEverjtZHwanuMblcorxePKNkx7G+YEeRkRilZlIS1ZB2/9cedk1ICOO36gOnZb26f3vp5mnxIJEsQul0TjBY6FJgP68HuntPalKsLnTgD1fKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=L1dNSXLd; arc=none smtp.client-ip=185.125.188.123
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 7C2853F610
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 06:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1781676656;
	bh=yYyjbUwTbz5kYjrY+YDLT8Sq9O45djIje08c44tj+s0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=L1dNSXLdhygcRMn7A9AblErsG9ZIB//1tFzNasW3PyXsr0MPvoj0xX4nPdaK88C0U
	 OCU35XLLR1R3HJ0CKUZfxDVrHdhEPjaAz4q1qPmE452CfLdLwIVY7pXukPGErtaQ+p
	 ihzRghRE32xA3GBkr6Kedhbzvh+6du8iwEvWLvl44pEog9ldySC+PC73Dq/hFzpVHy
	 3xVDZs3qA9uIQ8uX5Og4h3wSNb+14RKAf5qhI0Y/UNtZTrGLOZAOPSfeNxhlzuR36q
	 zx2W/C2jezx5x0YfYH102h2hulc8mjKuPTnXTU3QLguxzG4UzR1bFNsz+WPyjxgSQH
	 /iHf2WZnA9rPTRVU2f2al3UVoi2TomeiZZ+hk17FdOIz60LWfRfQ9EKPW0dAy3dMzg
	 E40wueYTxcU7KjhX3pgBhTuYpsCXq3Sg8I6NoJrKJIFLLLndPoBffluPvJMaQa9qrI
	 p8WuU0PY8Fk6JyXYQpAoPrq+dY5axMOavoDgrPBJrm8usvyPq711WVoViHgAgi9AHE
	 dhX44iTr+HVmJ05GhQZyYhBfwq/ZK+Jv+uQBPc+JodgSNgRxuGw0f2CagNlvTpxJAl
	 YDi0sumNWriNVVZMHk7uU7rHmQcMpssKkGHfC56SmvGWTHlFw/UQZ6D/TQnbK1yvda
	 3yPwtNmhk/t8EIAONgLCC8Ao=
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-490a060eb84so37761845e9.0
        for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 23:10:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781676656; x=1782281456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yYyjbUwTbz5kYjrY+YDLT8Sq9O45djIje08c44tj+s0=;
        b=pnUV5FoQuP2ghjDImxqfoaiG712WhQ+YKCbYgFwvtK2hrslB0JpYaEOSSgGHWPY8wq
         o4hdoJTIrjjo2pBaKFULF0P6Ea6Z2r+wIG1UbefytlfyMzs1n3ROiDluYeEMBkxEO2aZ
         m8Dky3mO6IIOD61IwG5fuffJ0M2hrmJG2/nGYfAJDpJ2DNRvpSbZEvorm6Op6knbi1GN
         zGBjswtHt1J/6sRcprgXt8q82+Cx+8luboCA7FbhFPK4tNaUyC1rGtpzEEu0287l863u
         5k/WJ3HmWSYprJBA1L9EYfwVe2g6lzyLj47uKFd8zuzviZlPxGZL7hFHp88jaj6RPGJ6
         rgCg==
X-Forwarded-Encrypted: i=1; AFNElJ8PZnAieI6T7Rue/yNtbLCvZjgNsZ21DXH7uBYwwpYuDn0m+25VT5qljlqQHWkXHRwh/etewYg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKnoGFS3E1RJR4xgISb7eMTc0dCGH9dyf/dVwXyYVbywFlTfK6
	lUSs341qBbI71BmfiM14/ohX0jaZSCDFDlW9+V1o9G2QP871+zbBxXEGQes+fqQyLJdJEiu0Lye
	cxWRL/Ura6GQ3zm6o2X17EBLnpd9ofIAhgm/y8FSBaiGepCtErpqyTaebJDqicx9D76Aa0qZsnQ
	==
X-Gm-Gg: Acq92OHZOVr1prM5yhCnbAAaNww0vrf1yiCrXnKPrJd/UUlp9HSzvTdDb0ZYgB5ngU4
	p/kxrBXT+xsOlMEJWG5x+kWLAZWDhW36Ge7rVxeUfPQXmpsuceKjCfzXYsaOi6bNsB0uaqrBByu
	FVP9hFZPEgr+QvrOoBYredGh2B54B1s5wa9LMpZoNaKkjKmbky40TbjUM9BxH5FaqMu1slr8IpJ
	Ia4FC2kWb+04efOGuet3s1uaqKGgejEYEAtLyz7a2O/oxDbnni9j0KkVuZ9GG6mVrfY87J6iUFu
	8a9n+TZeugaYnGD+PpcSpvmQ0LN6T7KdG74gHzZt/JM6jKE1vU2r61K0PwFbzzzMRnrRYKqZxo3
	w1W3V9yG5UaQ=
X-Received: by 2002:a05:600c:5644:b0:490:adb6:7957 with SMTP id 5b1f17b1804b1-49234141d98mr16811895e9.33.1781676656071;
        Tue, 16 Jun 2026 23:10:56 -0700 (PDT)
X-Received: by 2002:a05:600c:5644:b0:490:adb6:7957 with SMTP id 5b1f17b1804b1-49234141d98mr16811665e9.33.1781676655730;
        Tue, 16 Jun 2026 23:10:55 -0700 (PDT)
Received: from ross-pc.local ([2001:67c:1562:8007::aac:41a0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f26f309sm46674988f8f.14.2026.06.16.23.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 23:10:55 -0700 (PDT)
From: Ross Porter <ross.porter@canonical.com>
To: linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org
Cc: ross.porter@canonical.com,
	stable@vger.kernel.org,
	Edoardo Canepa <edoardo.canepa@canonical.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Brett A C Sheffield <bacs@librecast.net>,
	Oscar Maes <oscmaes92@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] selftests: net: fix file owner for broadcast_ether_dst test
Date: Wed, 17 Jun 2026 18:10:39 +1200
Message-ID: <20260617061039.79717-2-ross.porter@canonical.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260617061039.79717-1-ross.porter@canonical.com>
References: <20260617061039.79717-1-ross.porter@canonical.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[canonical.com,reject];
	R_DKIM_ALLOW(-0.20)[canonical.com:s=20251003];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300041-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[canonical.com,vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,librecast.net,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[ross.porter@canonical.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:linux-kselftest@vger.kernel.org,m:netdev@vger.kernel.org,m:ross.porter@canonical.com,m:stable@vger.kernel.org,m:edoardo.canepa@canonical.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:bacs@librecast.net,m:oscmaes92@gmail.com,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ross.porter@canonical.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[canonical.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,canonical.com:dkim,canonical.com:email,canonical.com:mid,canonical.com:from_mime,launchpad.net:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9C39C696C70

Ensure the output file is always owned by root (even if tcpdump was 
compiled with `--with-user`), by passing the `-Z root` argument when 
invoking it.

Cc: stable@vger.kernel.org
Reported-by: Edoardo Canepa <edoardo.canepa@canonical.com>
Closes: https://bugs.launchpad.net/ubuntu-kernel-tests/+bug/2129815
Fixes: bf59028ea8d4 ("selftests: net: add test for destination in broadcast packets")
Suggested-by: Edoardo Canepa <edoardo.canepa@canonical.com>
Tested-by: Ross Porter <ross.porter@canonical.com>
Signed-off-by: Ross Porter <ross.porter@canonical.com>
---
 tools/testing/selftests/net/broadcast_ether_dst.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/broadcast_ether_dst.sh b/tools/testing/selftests/net/broadcast_ether_dst.sh
index 334a7eca8a80..5e7a8fe23c7a 100755
--- a/tools/testing/selftests/net/broadcast_ether_dst.sh
+++ b/tools/testing/selftests/net/broadcast_ether_dst.sh
@@ -44,7 +44,7 @@ test_broadcast_ether_dst() {
 	# tcpdump will exit after receiving a single packet
 	# timeout will kill tcpdump if it is still running after 2s
 	timeout 2s ip netns exec "${CLIENT_NS}" \
-		tcpdump -i link0 -c 1 -w "${CAPFILE}" icmp &> "${OUTPUT}" &
+		tcpdump -i link0 -c 1 -w "${CAPFILE}" -Z root icmp &> "${OUTPUT}" &
 	pid=$!
 	slowwait 1 grep -qs "listening" "${OUTPUT}"
 
-- 
2.53.0


