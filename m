Return-Path: <netdev+bounces-119004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03BD7953CE3
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 23:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A741E287B4F
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 21:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07273155324;
	Thu, 15 Aug 2024 21:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="LaHYUiIY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EEF3154C0F
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 21:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723758383; cv=none; b=iX07T5YaaqkLbI8Y76A/ZFO38YRTTcrFV2DKLdjgidiGGtBKBDuBvs6yQvRitWjpJqWF6DOXOUk4htk6QymmJ4L44UhDt9OhYUWyGaW2SB1kIY686cSE9VYmRhkrXxr9eQYUBOx7Liqz/SCKylvXQ3CHOi3vggXm2pacG9LNhq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723758383; c=relaxed/simple;
	bh=PXBP4otjfoI2KnZ03tyygL+2esXXiEIeV344gWDQjo4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nx2MyooSaAxC026c2XaxkrhWF/72lAoTiIb469kfV2CVDyzHG/GQn8zaZNNskCA1UXliKmCI6dTiY4MTVrOgTNpNXOg6iejsVArmXrrwShS/2J+dSOCL+3W9nd+OIz6GCpdGa18L17hUjYJZ1Y52jSe0tcfmwClz8bXun754NoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=LaHYUiIY; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7b594936e9bso958155a12.1
        for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 14:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1723758382; x=1724363182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M5PeGhSnOFENfQ9oa4tF+z+r4plsYTo0K+Sh8hUO/8s=;
        b=LaHYUiIYXFqWo7ycTCYwGRaXMWe7hzFkERx2upkoyCMqX69hHiZT3ABpLOWzqliXVZ
         xr1+jBWj1jIwujNr+aWxSZASfq/O9NN+FBrkc7SAA6vzv5iY49tosgpDtcEYSMFVmlGh
         KZfQn92m3JcKIVMrPbV0Ce85ZdBXo8AhafCz/ZEawpXlF3kozHJma3fMFNwSZSL5kaZH
         plm3qIvORHlmvmQRsViXPwZDwuFblXfEFlxf9shbFYQhY4yxAp0jEqK7rzo73z8dnP2b
         k/Q+4X2xzgHzCpADtSINcFmp/MQWO/MD7gJgRePO6bYH7La6xHMTeidM4m4Iknc7kVbC
         mLTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723758382; x=1724363182;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M5PeGhSnOFENfQ9oa4tF+z+r4plsYTo0K+Sh8hUO/8s=;
        b=tBePfZ1VQ9AAYQtf3zLQ6aKIkRv/VMwiwmDCAjOjPzCpGqQx9MIF+CCfvUa1xJGHiz
         aQ0IAjmP84ha253lRS+OWsbwgD848GsL51RWAWzRVvafUbmO+s42q/1l1Kts34O4n9ZQ
         denO9aUv6641m1jSB45LlgdsnelSPO4mwvPM6e6ayBKRx6QfoCBbwllJ3zKdvdtL5DLg
         1e0ZAxsjXDuzk8Y45lqsFNAFLzcD1nOfxrDbQvgFjSXj3TzGqLv0sOXNs9EZ/BI+ce4M
         kC67SwPiBDDSSJG3Z2Flh/wfNPN4Xe4aQyYsnBVhEzDvVGhBjCWGqcnTRnvUKuni73h7
         Cvvw==
X-Forwarded-Encrypted: i=1; AJvYcCUOwkLDHCqDrJSCaeqI5wyhyuFBRLYEcvrNrTartxkHVxgYgXRal6G+ruMM0PMDz+HGGaoLc9ryiqvZZab7wEaOEzjJd9x6
X-Gm-Message-State: AOJu0YzmOD/iNm9792mTO3yZazA3YBoM+XUGTq+EYYb8ImHt9P//Ikza
	p3ERH8XHyvzZEdg7aMFkbDcT81aIbHESMkXwgSrkktGpRuP+67qGEa8iPSLK2g==
X-Google-Smtp-Source: AGHT+IG0wa4EQ5Fhf/JTVtyv7FH2IGq96L3od5XrN8nGqanM2BKXTsrFgmMGejz1lKiKo17lQm0/9w==
X-Received: by 2002:a17:90b:1d91:b0:2d3:dca0:89b7 with SMTP id 98e67ed59e1d1-2d3dfc240a7mr1252370a91.3.1723758381635;
        Thu, 15 Aug 2024 14:46:21 -0700 (PDT)
Received: from TomsPC.home ([2601:646:8300:55f0:99b4:e046:411:1b72])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3e2c652ffsm303288a91.10.2024.08.15.14.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 14:46:21 -0700 (PDT)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	netdev@vger.kernel.org,
	felipe@sipanda.io,
	willemdebruijn.kernel@gmail.com
Cc: Tom Herbert <tom@herbertland.com>
Subject: [PATCH net-next v2 07/12] flow_dissector: Parse ESP, L2TP, and SCTP in UDP
Date: Thu, 15 Aug 2024 14:45:22 -0700
Message-Id: <20240815214527.2100137-8-tom@herbertland.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240815214527.2100137-1-tom@herbertland.com>
References: <20240815214527.2100137-1-tom@herbertland.com>
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
index ce7119dbf1ab..5878955c01a5 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -958,10 +958,23 @@ __skb_flow_dissect_udp(const struct sk_buff *skb, const struct net *net,
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


