Return-Path: <netdev+bounces-105811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FAC5912F4F
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 23:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5087C1C21D84
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 21:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD7F17BB3F;
	Fri, 21 Jun 2024 21:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N/WNm3vc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4216E16DED5
	for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 21:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719004704; cv=none; b=n7nrkGVUYm5n2XFyBQ36giGcsVkbgwzsR9ZSNQn3Y7MuGDx6428zJgRHkqOFPuyyhAHQrH+XWAXxKeydPI5Lsmf3rgyEZku11s+H6sbN2ecrDKZiUsylyTWgnOm3inHyydGCSCPJthAX2T/U6KlIBzsJW3PN+WmBReeRlSDR15I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719004704; c=relaxed/simple;
	bh=B+G9QtsD7C2Jc3sDzbUlvXmN736PbhSU6BpyDPCIla8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=E+BohqGCeschvsMSr96g7/9rz+WD7gnKmtsn+YZEWqCMLjaLo175DFSYjACuztLiMetQy1z7bXGiZJOW8V3xsTL4UpyFAAUB2OeZ5B00X+P22EglVwzOPlH2MmxC5cVoDRTww6OM0VZ3MEkMcYWuAnBeSgpjlG4eaRhdQkRHwhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yabinc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N/WNm3vc; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yabinc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-63c418df767so43506317b3.0
        for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 14:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719004702; x=1719609502; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lEa6AhAPPJv6m60+8usBRJvGW03PUOWIeiJHHFIJ3k4=;
        b=N/WNm3vc9n+ujg5+G3tuA6wnC+rytZnaoKChCEU/abyVu+pn0dpxyQ93GWS8AIlYkL
         IdU/D2L6j77bwcalfAGbYvc+xDCTakNN1bgI2dQvbzU2Yf8djU6I/6tBmWSFC90K5Ic+
         2OVolDin1HWx/FwdWKvnr3FgUDul0rKxv6kOGV3fHk2Hk8xam2dMw8cFdZ6QJV2nm+ej
         irTCTNsSoTrp2rxUhujFCpMKcwYy1LjWsgpKpmotHM6A/cO4pzYK639ygXZ6UsjUusHE
         +CByxlUWiVcnS3wVWowobRRVnHfzAaOkrJOaC06D9tmur94uPa7AsYzfEOaCHbvHTFOQ
         klhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719004702; x=1719609502;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lEa6AhAPPJv6m60+8usBRJvGW03PUOWIeiJHHFIJ3k4=;
        b=G8vzkDLRH77nKd2AFMuxnFKXtbxDSXnsVsDfljDoniOeofjaZsgchcy1gSbZ7Qrt/r
         kUmQgJjLtT8HGnOimr5ycX38bfYDvNG3H4OJnpC50Ej4uc9no0giyeylJ1aol8kZzf+/
         u6J1Leodc2rsNZoaBZpJ/kv7h5zaGIUT5bMgxMJWmgwnM62cIOIJS72S+Yjj/RpqyxFF
         020bNkU2PkDdonJloKfWT5cNTz55eLrsoGL+YzkqTS+lIbYbiKo0MpRRY8fDUXxen1KQ
         LZqmlFhrbutzOxO5TX7saBAdyubK8aJvcL00OteJAJ+OqXG1LwdUU3qGl9V2Ts5jpR46
         +djQ==
X-Gm-Message-State: AOJu0YzJ9R83MfRt9G7cSJrd61ymaStS+4Z8Cs6CIgPvRHVl9SQ7QOte
	tdVlVM18yBILWenJQEVbeN+gPrNRaz+djsk3IarU9L23/NZZP+qf78B6vpYpa9XMU/9CvUkKOWQ
	D
X-Google-Smtp-Source: AGHT+IEP/2Rh6WitHSvCa6ePiTeFcXPS1z9OBz0PJKzZRVE8qWAYk4K12RXfyoLq827IauC3/poGWrv3R4c=
X-Received: from yabinc-desktop.mtv.corp.google.com ([2620:15c:211:202:9257:c357:1f0c:2e57])
 (user=yabinc job=sendgmr) by 2002:a05:690c:6106:b0:627:a962:4252 with SMTP id
 00721157ae682-63a8faf1313mr15919837b3.7.1719004702263; Fri, 21 Jun 2024
 14:18:22 -0700 (PDT)
Date: Fri, 21 Jun 2024 14:18:19 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240621211819.1690234-1-yabinc@google.com>
Subject: [PATCH v2] Fix initializing a static union variable
From: Yabin Cui <yabinc@google.com>
To: Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	Yabin Cui <yabinc@google.com>
Content-Type: text/plain; charset="UTF-8"

saddr_wildcard is a static union variable initialized with {}.

Empty brace initialization of union types is unspecified prior to C23,
and even in C23, it doesn't guarantee zero initialization of all fields
(see sections 4.5 and 6.2 in
https://www.open-std.org/jtc1/sc22/wg14/www/docs/n2900.htm).

Clang currently only initializes the first field to zero, leaving other
fields undefined. This can lead to unexpected behavior and optimizations
that produce random values (with some optimization flags).
See https://godbolt.org/z/hxnT1PTWo.

The issue has been reported to Clang upstream (
https://github.com/llvm/llvm-project/issues/78034#issuecomment-2183233517).
This commit mitigates the problem by avoiding empty brace initialization
in saddr_wildcard.

Fixes: 08ec9af1c062 ("xfrm: Fix xfrm_state_find() wrt. wildcard source address.")
Signed-off-by: Yabin Cui <yabinc@google.com>

---

Changes in v2:
- Update commit message to add/update links.

---
 net/xfrm/xfrm_state.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 649bb739df0d..9bc69d703e5c 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -1139,7 +1139,7 @@ xfrm_state_find(const xfrm_address_t *daddr, const xfrm_address_t *saddr,
 		struct xfrm_policy *pol, int *err,
 		unsigned short family, u32 if_id)
 {
-	static xfrm_address_t saddr_wildcard = { };
+	static const xfrm_address_t saddr_wildcard;
 	struct net *net = xp_net(pol);
 	unsigned int h, h_wildcard;
 	struct xfrm_state *x, *x0, *to_put;
-- 
2.45.2.741.gdbec12cfda-goog


