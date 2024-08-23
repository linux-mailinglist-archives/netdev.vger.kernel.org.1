Return-Path: <netdev+bounces-121516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9306B95D7C2
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 22:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5058728120A
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 20:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F0719753F;
	Fri, 23 Aug 2024 20:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="eEyIs1Cu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27221953BD
	for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 20:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724444190; cv=none; b=aQK5qPCR+aKuJl3ELOU3UlAjLY+U9WW4BwYstE+UhavV2mctx6H3zyj0Mua1bGpvBuKSQUDHB3YZYRZ/3jbU84AAgIrAZ5WFRHvdvbiX9OVqFIRg3UZ3xs3wHeGPh+AhWLu6zcbyrzPVHyaOAqE+nlQM4H2Idqrb0mQvWbfNkFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724444190; c=relaxed/simple;
	bh=iMWvxLg6mk3YOZu2GoOmMymABsgkj70W/qqTIhUzPek=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Tie416hvZEAQpQVJJFaKffLrTLEpvOLu1503inl6+XCTr1qXtHtIA+P/BviE6gnAcRIOOmQI7x+w1gSgJ8MkxNWPyjXS1A9h2Lbea3LZbJScBYehX5mkO2jzDX6YnS3Luj1E8CWXuPnAL3dRTqV1m8wHuy/moRX+PV5fRjRZwUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=eEyIs1Cu; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-71456acebe8so37895b3a.3
        for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 13:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1724444188; x=1725048988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GC41Q2Yt1vb0S2eoC29cm2dAZ//HWncpeQ3N2y1epA8=;
        b=eEyIs1CuZI7cr4FjUgzRP7gEIldhNVN+mZ+IWhcdBZNPBcoArHsm/iJGEWjECos4VM
         Ekj3Jo8z4LRHrpdnpIR4gi1/Wg9bdzLvaw7VO7py2BatcmMOqgKmtYCoTfbeK9IVTYeh
         xps99qK393MB1zRVhdBZeoKsNSLVry9X5YGI4YPWpo9/WOepGq7gVe9UOvWT8e8mj7zT
         Q9NTn4wKOLff6G+92d5OW7JcZZr9bgdPd+WmgbmH3SqFogT6mjbg7vkUm49iyP4x9ct/
         vSuLTSlvlHqXmOZf0rKi8CShxddQKFfdKsFM+18W2hH1FKYEWRlsEQ1SBABkzJ/eRcxs
         r10Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724444188; x=1725048988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GC41Q2Yt1vb0S2eoC29cm2dAZ//HWncpeQ3N2y1epA8=;
        b=pblXjLxRyEkNoDgBDNEHLjkLnNKMcupl+Gc3Sv6JuUcvoucY5WYuxlFaNqoRHxa26l
         yopS8zyPPqCp5YSGzYtHR9jbe37O0gMAWJz/O+hGiv80rXNyaRf2XTV1Kzzal2Ntr8nS
         jgWSKLWUwWdN9OP+T+FXsVBuOO5BA6kmmLdM68MwP5NwKpWGDeyPQ2AR4KuzR6Dhjytu
         WOTU1D0NBT7mYNcK8SLhAs8qHeIV9H62RTJtBsbN0/wTI0A7bKChAUYzgsJiZASgaKv8
         BepT7qOESA7Lqyset2QEifTuhC4T33VEjrO4whLwzUsa1g65iSiKK9OLq3YwiCkhr62x
         rkqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIRympoQCSJASFjMiLYJJK4rBHOPeXvLM/elAiAfyGKMGd42KYWEV1PmgFDAxDl4ydpsNh3F4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXGPuxex/TxaNcMtXDW9xnMfMSFq1k+Y/kjtH5p6ufzXLwRHWL
	89YDVtWwj6B2iMPHvmlus0lyfWYwwaYkpdrbBJsCXWtWJgba28TeERUsre17Mw==
X-Google-Smtp-Source: AGHT+IEQoeYGtxW4mC2FsUcy/CzXoh29ktEXuGudRD/H1+eF7YnZwyOSOsdHpjVnc1P/UqeeUOl5nA==
X-Received: by 2002:a05:6a20:d497:b0:1c8:eb6e:5817 with SMTP id adf61e73a8af0-1cc89d29d31mr4337235637.5.1724444187742;
        Fri, 23 Aug 2024 13:16:27 -0700 (PDT)
Received: from TomsPC.home ([2601:646:8300:55f0:9169:3766:b678:8be3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7143422ec1csm3428525b3a.39.2024.08.23.13.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 13:16:27 -0700 (PDT)
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
Subject: [PATCH net-next v4 13/13] flow_dissector: Add case in ipproto switch for NEXTHDR_NONE
Date: Fri, 23 Aug 2024 13:15:57 -0700
Message-Id: <20240823201557.1794985-14-tom@herbertland.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240823201557.1794985-1-tom@herbertland.com>
References: <20240823201557.1794985-1-tom@herbertland.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Protocol number 59 (no-next-header) means nothing follows the
IP header, break out of the flow dissector loop on
FLOW_DISSECT_RET_OUT_GOOD when encountered in a packet

Signed-off-by: Tom Herbert <tom@herbertland.com>
---
 net/core/flow_dissector.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index ae56de7d420a..6f50cbb39539 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -1993,6 +1993,9 @@ bool __skb_flow_dissect(const struct net *net,
 		fdret = FLOW_DISSECT_RET_OUT_GOOD;
 		break;
 	}
+	case NEXTHDR_NONE:
+		fdret = FLOW_DISSECT_RET_OUT_GOOD;
+		break;
 	case IPPROTO_IPIP:
 		if (flags & FLOW_DISSECTOR_F_STOP_BEFORE_ENCAP) {
 			fdret = FLOW_DISSECT_RET_OUT_GOOD;
-- 
2.34.1


