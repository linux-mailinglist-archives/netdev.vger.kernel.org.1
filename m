Return-Path: <netdev+bounces-232778-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30517C08C66
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 08:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EA701A662CB
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 06:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF8E2D8375;
	Sat, 25 Oct 2025 06:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iE+Gp1Fv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1217C26E6E8
	for <netdev@vger.kernel.org>; Sat, 25 Oct 2025 06:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761375201; cv=none; b=WWXAYxCQkUvKYygiuvWGQYLk/EjZsvODUhfPTlx13tcrLIci/WspukK159SMi3/+yJh7ykGnGRc1XYCsUmX4Jzp7l7Ymk3jPzu/q8Z/GSeklSeYaTBuCmEI88TLyR4ROgXGbJL7qeuuNkSTu1ZYE9+kEMLFe27YlN0t+hZ7LBuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761375201; c=relaxed/simple;
	bh=w99RtLvpk8UVgGX6ieDZH4veRr9AEGHKN/Ya9s591E0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VJ8PL6btF1HhpB+kFOvlxDrEBp6NRIeO/YvugfzUWH2EfaIcmeNBQoFuqWsZJ/XECLmkswSaxdJeIYrVxxKW/kGlxGnmqs0A+Rs0/rylcBIdyE2iiz33LAzJ7bILNDPtPdIcHZpy/Z1OX7WkaqfRwurFxHR9ZAj6JnKnv909rj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iE+Gp1Fv; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7a27c67cdc4so2143794b3a.3
        for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 23:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761375199; x=1761979999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Kp1JMEroAvT24q+TEkRbK9XSf980ZtoUE9pXBiTTcZw=;
        b=iE+Gp1FveUCkDgob1sSgjodFoBV8V3Up+0YyTlZV4re4NTxFcqkNs+KeMDXTLn8Yci
         dbftkWMH50WbegbZ/+rq88vCp7YrK0rDmkcUX7wGPbuBiGcfuE220E4ysh/MXNF4BO8L
         5UqV3CRAm+yCLdw4cUVfTqbGyCnFqPfTs26iMPKA/p9W87licz5fbq13f2kXH4YAgmpy
         u/SiyVneLWdYNGKxGzKrj2uGtma8ee37Yk+z33PegNCQ9MrFcKI09QyihLvBX0cUZqOU
         68hCZVrvigQvaf6elDJQ5pv6grJRR3mNu+5b4r08Myx2wnh4wAxBbTLmFpQFMvdiY4jm
         J45Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761375199; x=1761979999;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kp1JMEroAvT24q+TEkRbK9XSf980ZtoUE9pXBiTTcZw=;
        b=ti8xx5fIdBedJ6LIUBHU0FrLkTgpn0SerIJxfjD5oIAd3u7hMnJOjA5+qPjo4gBx3Y
         +tIw5S1bSYfCZ5SWl6gf2u76Q3mYO2oEgumU8UgCNwgx37SpcNtqdbAYgj4wjsSPDa/4
         sw3ptzCVvHxWh9OvOVIX/9odGkRg8Lp7jd8rGQqbGzF1lKxceTgm0UYa4m6XgT+gkHqn
         ULmEvvGCDo2w5sl+9oVorPobWGznelwbJz1cGpZuHpTbTPj5eySSb6xWsw2kXPkeczpS
         XudtDPkNA4yJftKHebV3kdby1uSFzjj7/wcT4JGUo2Y0WqpGIQj9TnYetKCA0AjWV+6u
         6/cg==
X-Forwarded-Encrypted: i=1; AJvYcCXyAn3vgUYMwnOJ1uJC/gdHoh2ppend3+qezxzAmPrmCKKX8euOUPV5y0dYToOzn5MNtyE2zPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiycC72YTlUH07UWgUA8xQxWsO7L3HlWCIgexiOyD1Skxv6aOf
	zSptzs+Pwen2WWrLwuyTGJUPLtMRWunMZiAbSoLLMa5K6QtFRg2ufcSl
X-Gm-Gg: ASbGnctT41dCU9afPf+HPc82Qph0I2bl1EHJ2Ak1jJ3noqqQ4WGDlUTTzC67w+4i0kL
	Cv7FaSWDvrNxWIAGdiTibgdJ4YCBVvxau3mwQKB4ElZ+LJwhiqjtrs7TFb4Cv+STSMlP2/txP3G
	CLdemO1h5gkXYZrcbQJQtm5gJlOwQNeUl7P941LmhW8GWnSFejTuj6wW9WHZoDAnEuLmw9koscr
	PqDjIhU4U+DSmB6q86qEVTL+tkREyBFFzVXfh3ydV9ToRcGgdHFiUmpkGN1gbEABfEgtWV2mwW8
	oiFb2w6EjQDVSZ3KQ32lTLqf3R3jXvIqsjKnE1TNc5jXdO7o329q1tBEgu80VcTFg9f0Rxur0vA
	aaFNNZpag00iVAO0+yxCZNfi23VNIOXx6xxS/OTfCjsqPVJRu9fxajQdZmemzqUcvBBl63mlTai
	Tqjf1UIUaQ+N85i5QBAHQ8DxHAZPxTY4GXXSvEH6ELkQ==
X-Google-Smtp-Source: AGHT+IEFW/6eK7FLLLHanhNe2hYWEwfdayYE2KNuu89PBLF3Wc88bg+ZRhMRoOMulVRY8+1YDsQbmA==
X-Received: by 2002:a05:6a21:778c:b0:33b:1dce:993b with SMTP id adf61e73a8af0-33b1dce9c9dmr13244537637.10.1761375199251;
        Fri, 24 Oct 2025 23:53:19 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([111.201.29.154])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a4140699basm1262820b3a.50.2025.10.24.23.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 23:53:18 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next 0/2] xsk: mitigate the side effect of cq_lock
Date: Sat, 25 Oct 2025 14:53:08 +0800
Message-Id: <20251025065310.5676-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Two optimizations regarding cq_lock can yield a performance increase
because of avoiding disabling and enabling interrupts frequently.

Jason Xing (2):
  xsk: avoid using heavy lock when the pool is not shared
  xsk: use a smaller new lock for shared pool case

 include/net/xsk_buff_pool.h | 13 +++++++++----
 net/xdp/xsk.c               | 20 ++++++++++++--------
 net/xdp/xsk_buff_pool.c     |  3 ++-
 3 files changed, 23 insertions(+), 13 deletions(-)

-- 
2.41.3


