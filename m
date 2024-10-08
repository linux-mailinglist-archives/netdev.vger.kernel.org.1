Return-Path: <netdev+bounces-133136-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAEED995182
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 16:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E03901C2468A
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 14:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48EC1DFDAE;
	Tue,  8 Oct 2024 14:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GUs5lpLt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6328B1DEFEC;
	Tue,  8 Oct 2024 14:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728397448; cv=none; b=qus7tPy0ThR44aVHSzvJ+1hqt+VzEp4e/QiGnmGe6IbKfFdOLPxTt8feEXbmEvqoTH3j09iSC/mFFKGrEEAzjxrFn5b3sorjCPDgjjefLIxkrjdpMNxy6yq0N85CX6bhBJJk9RNuZgNgPJhEkZwFwWCrLkP1XllBYESCzk+/Cnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728397448; c=relaxed/simple;
	bh=qDSFVKxj5P9OuUbcZh8vXPtfp9NKaBMFgSQrL48vbZk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DQ1IxzVTTy04uHGGw0F+qbaHrTUpnFgRn8LcEMVt8d/PBDrjnNRphzad5dkk8P6N3WEHfAeAiQtPVFRewcY79Eq2Q7bb3gSm2E235lUq0fn7Oq7KHrkckvNaT29bhzNt7cLWNZM5k+EE1K2K+a7dkncOBRzJvcPr6g8ZbcQZ53s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GUs5lpLt; arc=none smtp.client-ip=209.85.216.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-2e2993de292so54202a91.2;
        Tue, 08 Oct 2024 07:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728397446; x=1729002246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zLvKfqnfSpZ28mnT6KrdGxzwf8Ry3wsHVE17xRaKj5k=;
        b=GUs5lpLtKymu80RGcIXBSt1Bbp5eOhWoOps5xIw2SfPbTiolvyn0ioUYtJ2kzESmpk
         fNI3GHlyi+sc5uoAw1kZZ0/aXuIddqAAOXQ1bfisPJcxK11LaCPvjrjZOMl2uuXf9OEu
         qyOOM5hOvtTOuMo4Z/pq+BxiXSqEHLMTRmrcpxO2gRH0lMFfp00bjZrTSwrzpbRyJkrh
         PhEG4H/Qe903BDe77WEnnC46RXVle8REA46AnUMcXjikbq1NoM3PI05R9omdwFkYHBp4
         +v7I2qLNsRGiyHx5FfBn2pkpgKuuFe/xNcs4/eEfJ2sSlGP/pgXJYPJg2kjzklbPQ1Iw
         imCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728397446; x=1729002246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zLvKfqnfSpZ28mnT6KrdGxzwf8Ry3wsHVE17xRaKj5k=;
        b=ESIhMafk+tCAJwGRYt5+x5+CLSSbl0MOFPqrknp1wMyJfheprBbg+s+rLfC4wQZ2o2
         QT9ppcM4x3OLksyVmoIRI54EGAO9vB05LxCkuee4RJtN+qe3ALn3/gAEV/As7hOA4lcs
         dmifUI3Jr/fAEh41uLUPKh5eXqmMpTa67KJIHppW7OkS9IpafEa41e234h10jJiptttA
         LN2gLnHYqqF5+r5HC7DFilibUFGI0jqiNVIrNTAasll64BgTDI2rXZSs9CJvYNcV5s+D
         a7m3ai5JbgX9XoweZ95iq92KsvXla0GfFVdH9DVs2W2YIifpyKfCqXtzyPKQ8VWiKU+k
         y7hA==
X-Forwarded-Encrypted: i=1; AJvYcCUBf08w2llMcnwtBdEHKXhj48Uc/JGcoc2U9NFkjoILyLd1jANkaFGyvmTz1sqlbI4XV9+UJ6cnCb4UiGo=@vger.kernel.org, AJvYcCVLPIUA5sNsLxMqhfeTuc17VisAjC11FWsr9hFnShXb4ZvYNE4xgK1E+I3ADyw7UuzDQVO1w629@vger.kernel.org
X-Gm-Message-State: AOJu0YylqbDOjnzBCuep4nS6Nm7GCkZsZ4fjjoa4NMRsT2iLwMOCvRbD
	9riy2NKo3v18NE7cPaWFjbghdlwia+xbm1DvVWLZT+jUFrERHSkZ
X-Google-Smtp-Source: AGHT+IGv7zNOT40cUxDCGMBKCOwZxYX68Vww/V+htCSaJv2yWGpwfzqQyiMhYZa8ep1bXYSRaHVvOw==
X-Received: by 2002:a17:90a:3f09:b0:2e2:8f1b:371f with SMTP id 98e67ed59e1d1-2e28f1b382fmr1740282a91.26.1728397446372;
        Tue, 08 Oct 2024 07:24:06 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e20b0f68a8sm7675987a91.36.2024.10.08.07.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 07:24:06 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: idosch@nvidia.com,
	kuba@kernel.org,
	aleksander.lobakin@intel.com,
	horms@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	dsahern@kernel.org,
	dongml2@chinatelecom.cn,
	amcohen@nvidia.com,
	gnault@redhat.com,
	bpoirier@nvidia.com,
	b.galvani@gmail.com,
	razor@blackwall.org,
	petrm@nvidia.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v6 01/12] net: skb: add pskb_network_may_pull_reason() helper
Date: Tue,  8 Oct 2024 22:22:49 +0800
Message-Id: <20241008142300.236781-2-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241008142300.236781-1-dongml2@chinatelecom.cn>
References: <20241008142300.236781-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce the function pskb_network_may_pull_reason() and make
pskb_network_may_pull() a simple inline call to it. The drop reasons of
it just come from pskb_may_pull_reason.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 include/linux/skbuff.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 39f1d16f3628..48f1e0fa2a13 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3130,9 +3130,15 @@ static inline int skb_inner_network_offset(const struct sk_buff *skb)
 	return skb_inner_network_header(skb) - skb->data;
 }
 
+static inline enum skb_drop_reason
+pskb_network_may_pull_reason(struct sk_buff *skb, unsigned int len)
+{
+	return pskb_may_pull_reason(skb, skb_network_offset(skb) + len);
+}
+
 static inline int pskb_network_may_pull(struct sk_buff *skb, unsigned int len)
 {
-	return pskb_may_pull(skb, skb_network_offset(skb) + len);
+	return pskb_network_may_pull_reason(skb, len) == SKB_NOT_DROPPED_YET;
 }
 
 /*
-- 
2.39.5


