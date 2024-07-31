Return-Path: <netdev+bounces-114644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D989434F2
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 19:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D446128BD71
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 17:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F291BE841;
	Wed, 31 Jul 2024 17:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="hC84F03a"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518721BE24B
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 17:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722446645; cv=none; b=dnbb+U0iR7hnhdcsSV+Gh6/Ek1Jgaez3g0er1QIiLnMUoemHcIJ2iG7ziqqg82vck0W77dMWoUOs6DESru/hHsGu+/rx+tDMMMZ6B4DQFrQWMFYpx3OknDWxTRhl0wFNYJF7Ppvc+heGoJu2THGTE9b0nMxyopO69nC/ZhYF5OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722446645; c=relaxed/simple;
	bh=296isLAADgrxQrxtxkq4pUsuyUhJiENDHC0DxsFqIBI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bnmR7gxoVG+422EuCLJFMDNGljz+LjwnReHBmnz16PgldZ6+IAI788FMA94CZkrM0jUZnCnP+RZtNeOvNwuLLGLfCp4paqBjv5kAhTHrlds4D6aV8wLXNLPUNquVWHWmTVapc1q08LbfIdmklLxzRu2mX0/q30etficFfInGK5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=hC84F03a; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-70d333d57cdso4299287b3a.3
        for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 10:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1722446643; x=1723051443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WvQhfDiwAzUjEhxoZFVKQ1onbUQ2OV+Y2W79oOVwrwk=;
        b=hC84F03au82rcC60RVoJ4BirbwYHp53EpNa5LtRyImRw5I6gaDp9UmjdjFVuV3dcaW
         Vs0hGCdkLmWFrE5GqtWHnIO994pS7YzQvEvSHctUFFADIwyz56obZm7DIsaDlXbEAE/E
         /kHHpBzmQNJnYkFvdgwS2LSyaWFWNolilBksn2LVGB1Z/l3P9oz5Tu1SKFsQmOoPuZYj
         TPCswSgcclJHocp4iXxgB+Z/wStgChVIH/NJwC3irT78yf5+5wabVLi6RIfM7tcNRdk4
         yMVExAzVGk64J1dal+omA6MuH6xKkJXV4e4L2vqseBpYOaFWdZs+Gh4PQctwvmQoFTZJ
         F1gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722446643; x=1723051443;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WvQhfDiwAzUjEhxoZFVKQ1onbUQ2OV+Y2W79oOVwrwk=;
        b=Eib10zvYHThEHCdIdjeBTpN/N6WMFh/L/XmM7kpVErcHo/F7SoKQbc3QF2HMQvGszN
         k8QO3mXr6lEHOjxgTZlvidZ1MWnOMXa200IoIK0q7bHH/+u4ybcwDdbd5JBMJXjasMAY
         ppTaCMI1ajWDC8249GuV/LujlYaF1Ht6Z44jV/sllDFE9FGWimcN62fxUny5N2irJqwR
         vTlbiG6aCENwhOnaxhM7IYQ4MkT4ZJneTl78kUzhdUCkduvOEJigi/BsrsX5wAp45R/2
         WEXLbZUZuReazmLvSFNLrImZURdDR0Skrt/gP1+ZGooKVxVb8WBvYzSyTOW6alxnFLD0
         4CQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWb3e8Wxqq2HKFoD0hIK5pDD1uQb1/q7epGseC/MyUFKW9gv8WTSvU9SglTI46S6CkGil027rqV9bObb+fj7WRgeVAtNCGw
X-Gm-Message-State: AOJu0YzdQiFSqLIIU2g+i0EbT1QqUSFlnvFnS7YfLHY/zc0UJiCsy3ic
	JM2oIm1nmnkfVG+xb4Ih1AxL15iIvET0oNDnupM97Y1fsbEXVMQvlHFqtMIXBw==
X-Google-Smtp-Source: AGHT+IHhTCBtjF5lXf+QshaFRGe8EGUEplT/BmYOb/uv71kOHuIHex4ULAjafDirSVgtgULWxoSP+g==
X-Received: by 2002:a05:6a20:4303:b0:1c4:c305:121d with SMTP id adf61e73a8af0-1c68d2607cdmr98249637.39.1722446643516;
        Wed, 31 Jul 2024 10:24:03 -0700 (PDT)
Received: from TomsPC.home ([2601:646:8300:55f0:be07:e41f:5184:de2f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead72ab97sm10487203b3a.92.2024.07.31.10.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 10:24:03 -0700 (PDT)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	netdev@vger.kernel.org,
	felipe@sipanda.io
Cc: Tom Herbert <tom@herbertland.com>
Subject: [PATCH 09/12] flow_dissector: Parse ESP, L2TP, and SCTP in UDP
Date: Wed, 31 Jul 2024 10:23:29 -0700
Message-Id: <20240731172332.683815-10-tom@herbertland.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240731172332.683815-1-tom@herbertland.com>
References: <20240731172332.683815-1-tom@herbertland.com>
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
index 68906c4bb474..3766dc4d5b23 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -951,10 +951,23 @@ __skb_flow_dissect_udp(const struct sk_buff *skb, struct net *net,
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


