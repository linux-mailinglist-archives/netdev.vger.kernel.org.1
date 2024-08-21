Return-Path: <netdev+bounces-120729-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2140195A67C
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 23:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC8861F236D4
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 21:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4DF17ADE2;
	Wed, 21 Aug 2024 21:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="VV/ZsWfG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DCB17A918
	for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 21:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724275369; cv=none; b=eeVuoabYVbXQKgKyGMYktcF+uCyo3qN8ZfyWPw+dei2kQaKorijPGt2zhrHb/DUlVbhFKavs8uq4XO0R/8dUyBcWy5Et+X0NB7Re4xl1nWR1ipXzJso2IxSbXNnru/TSXEdnNh2enM7r9hHhMZoT6JVbFB8gJzLeSZ+wEuZ3IS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724275369; c=relaxed/simple;
	bh=davFt26f0OS0c7z4U6yvfVFbReAjZVL2I2xDKhOPIfY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hU85HRUafbTy+tbx52JNBX4rLT5cE2wxy9vFl0eIbkqYvAIuWQ4QZjbjChurBAhuRc2HpGVw8vqq8Jbp1HOjRvP5tXRck5ZbpaMdu/JeOkf3afl83BXNJks29jUPOFp9+CyJLZ6mX89ULqKZmgk5J6xyFDTB4R/TxG/UjrN//Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=VV/ZsWfG; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-201d5af11a4so1101305ad.3
        for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 14:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1724275368; x=1724880168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HccMsd7uTeoExrzsTviCYDr+b+b128oucf8weYhgqhA=;
        b=VV/ZsWfG8yIZUeMAe/FXRv2vrzprLClnm/B+DtusQMfuPnN6+Vhv4QKM5vPavbYktu
         Z8/0RSCROJax2yekcVPqYzhi0TLYQVLx94EVhbqZWhpf/5iI4ploLIcx9+MNStiSgP7x
         Gw+4VtmySOVIjlk92Oxzk9yXVnVZEalTbF3cRiNVeRwml/2rMmOtjlFvpmrUGYbzpL4A
         BC1tLCMBG9tbXJ/O0DzBZ8xwBkQrhQhjuriV+r96Fw+b/1wpivgzKwEOYa91bmi5ScIS
         ixg7Mhaygt5FmicO7bM5YJrOKZRKPLncQMTCdl/aVY3mTtCxt7vXXNjDUigDPEBoWKXI
         p9Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724275368; x=1724880168;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HccMsd7uTeoExrzsTviCYDr+b+b128oucf8weYhgqhA=;
        b=iWLLpQJ5bANv2btqIuytW7LtK2AZVVU54Qk8cfVrt+xV5ojlPZrJrN/WeqzfE2kCJl
         Fh2NaOfGivwgOjvLhNGVPfZaWtZazfTQjTX6tnktpBmN5e9sMTDvPonjwO0Sw2jhZkMZ
         nA8KvQt4LpbvBQ+Ty9t8ScKjB/9hJtZT3jDOHMDp2t/uLxytv2hJP9D52/Ot0N0GHw7d
         vjNX4EB0SwhSIGdD8bmu9OWe2JgafaYVDV6JAg+S91KHVZRIOkFYB3NT6fQ626k9i0mY
         drW11eI2B5C71GH1leMfIWIfKkIOjHSFNnSPRHkesa0Erq2b8PInDhl8LHQejjMa9i8s
         l/AQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHskLGeSvXyYMb6sUi8R2FouV89MJazWHM01qNlfgxfdzCIpwzt2izA4c65RUB2MNjbAHGZi8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuZSBtW2MDf+VLdjteta2gZnYCMbomVEacclHNQsMdUfaBJHOk
	+fHYMMIfXsu3DCCaUCK+dN+ZWxNO5pYlZ+nkUnqPvK1WJj/bn6n9ujw63rZHig==
X-Google-Smtp-Source: AGHT+IEFiUFE1+QxzlHW5ZYCyKEYPoIYeCSFXG6QfKcIZzjElTWwuTEusuwREe0ttrxr7RqkBV6BzA==
X-Received: by 2002:a17:902:db10:b0:1fd:9e6e:7c1f with SMTP id d9443c01a7336-203681ad878mr38599175ad.56.1724275367661;
        Wed, 21 Aug 2024 14:22:47 -0700 (PDT)
Received: from TomsPC.home ([2601:646:8300:55f0:7a19:cf52:b518:f0d2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385ae701dsm388265ad.236.2024.08.21.14.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 14:22:47 -0700 (PDT)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	netdev@vger.kernel.org,
	felipe@sipanda.io,
	willemdebruijn.kernel@gmail.com,
	pablo@netfilter.org,
	laforge@gnumonks.org,
	xeb@mail.ru
Cc: Tom Herbert <tom@herbertland.com>
Subject: [PATCH net-next v3 08/13] flow_dissector: Parse ESP, L2TP, and SCTP in UDP
Date: Wed, 21 Aug 2024 14:22:07 -0700
Message-Id: <20240821212212.1795357-9-tom@herbertland.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240821212212.1795357-1-tom@herbertland.com>
References: <20240821212212.1795357-1-tom@herbertland.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These don't have an encapsulation header so it's fairly easy to
support them

Signed-off-by: Tom Herbert <tom@herbertland.com>
---
 net/core/flow_dissector.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index fed1f98358e8..331848f90f78 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -963,10 +963,23 @@ __skb_flow_dissect_udp(const struct sk_buff *skb, const struct net *net,
 	ret = FLOW_DISSECT_RET_OUT_GOOD;
 
 	switch (encap_type) {
+	case UDP_ENCAP_ESPINUDP_NON_IKE:
+	case UDP_ENCAP_ESPINUDP:
+		*p_ip_proto = IPPROTO_ESP;
+		ret = FLOW_DISSECT_RET_IPPROTO_AGAIN;
+		break;
+	case UDP_ENCAP_L2TPINUDP:
+		*p_ip_proto = IPPROTO_L2TP;
+		ret = FLOW_DISSECT_RET_IPPROTO_AGAIN;
+		break;
 	case UDP_ENCAP_FOU:
 		*p_ip_proto = fou_protocol;
 		ret = FLOW_DISSECT_RET_IPPROTO_AGAIN;
 		break;
+	case UDP_ENCAP_SCTP:
+		*p_ip_proto = IPPROTO_SCTP;
+		ret = FLOW_DISSECT_RET_IPPROTO_AGAIN;
+		break;
 	case UDP_ENCAP_VXLAN:
 	case UDP_ENCAP_VXLAN_GPE:
 		ret = __skb_flow_dissect_vxlan(skb, flow_dissector,
-- 
2.34.1


