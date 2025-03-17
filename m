Return-Path: <netdev+bounces-175285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D7CA64DD8
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 13:05:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D24F18982E6
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 12:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66870219A7D;
	Mon, 17 Mar 2025 12:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WqiG9KN1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD78619DF64
	for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 12:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742213002; cv=none; b=HvYE0SSDdaT0/POSST+D4gu2HeGriIj88FCRhWbYLYcXyOvA0A2l1I1fQM+WJFU++A0uBYrwKemwHZIjpmK20Z5PYrav9eP6yVJzxdx5+HcipU/hMcmz3oM5oGFQTjEsvn6PbQzonUvCgk6ZJ25fLljaz4xLDMf80L4LzSHWgKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742213002; c=relaxed/simple;
	bh=aLINJxXGpjNW8wHZB9DthJVcFjbeN8QFm6Qa/JaEH6A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dqWhvi5EmE6BRVO3t61zK2TKohjNN6FbDfczU/WmjEKe5Tj7+5H2ZmTk6XWXGILOzk47GjHFkZD/H4ZtxKx5lTzqq55Zj/tDrVuY8WuCdQnf9OLAeNPP+D2JLcGGNj5M8OVagXWC0616f9pcujBy6wDlimgfJDAQI0OiebSUfHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WqiG9KN1; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22401f4d35aso76605095ad.2
        for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 05:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742213000; x=1742817800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3oWc5E9Z1bFngKjW2yml7E2dzD8FTIkYP9J9pXuWdaA=;
        b=WqiG9KN1ERHyJunKnokmxzFvvTgJB4sbGl131RUTNf3veL4I4yML8TKe4UhviOOqSj
         4vFyuW6vHToQrREiFlDEs3ZzoXQoDld2tcGPWCiW4LR1uFiYoEd0El7op8o4Awk94+Dc
         XSOG2/6st6KwzRkYcnxa5qpDV0ADtA0R4YpLkt1/Ld+1dt75KDUvBkv4clRjGUqb9vHX
         jL2W/t8aBELPgFGg4+PRuUl/Umr/daYn8RsSbDZu+7Pdx8VHlE4By0qSI+si21LzFAs2
         IFjdMUMzaiV6WeoK74UBzPAXlRsy/XDfbDzI6+yhISm2wWSqpdZq5N7Z1GS34XipsmgF
         wsAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742213000; x=1742817800;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3oWc5E9Z1bFngKjW2yml7E2dzD8FTIkYP9J9pXuWdaA=;
        b=qhTHCuALTRzOBo+IM/s0Ne75OpegyjNrKMyzwhh+buKB9Ver2wdQfB85/cvDyCU6dk
         IG6cuCWXwonOSDPcx8/Aqzn2B2sqrbPnysgInlD/19nFY1nTpxrhs999YHfaJwtJUm4x
         7utelMwJSjxXi5dwsgGBUlLX5bI0Vk855UlRuuBskpbdoZLOIQR9E0bmtnEog1PuTJQZ
         lMAvQI6OjmU+LzyoZxt80mPqrDrzf16Kpa5kk7HQwxER/ebEZnbPF5zL8TsTkUtzMu3Q
         ehMf4yacO0sCDjqLJyPbCVsBw72lHkIz9lM0mKgNuxVQ3ucdH7BSJhBe8+h3IqNhu60X
         b8Dg==
X-Gm-Message-State: AOJu0YyymWaQ3Oe2z1Y6fCwnzeAAAvr8IvkHmbXUmRsIVJuKi5Fets3M
	iOgtdZafxtGUgVtnPWgeuBXCo0MuUH8CCZfKNXVIMo3yImy0p51FpWxfZJHLVDra3w==
X-Gm-Gg: ASbGncsycwCSXunGl3yVvohQ8LDVGsPuhf0nZ5DUf5xNxcKw2svgE5DHiJlMoGnbY7H
	Qxf4aBgGeo+qIsdtLen4FQUTxMjklvm3rqX23J+XdZf/Bf0364SZ0sF+WZtMPcQhVIbjAz7OIDA
	/nIk+8b5CrfOEu/O/CCKIaw/WU0o3J90r/XLFqYZglR+fTNWzgoche+GcyYsM9Ta3x1HTgXc/Kg
	k8Rs9W8DvW2vr3tekESxlXnwi9MpmJGr0u0z5ceqJxjpm1CJOlyhSUcpMq+Hn7wWxDskN5qO2s9
	s8Dg0ITIB+gNf4OoJHWNEDH6BaKW49vzonvKyjw5KI3ZacQsDSc4YgzHA2C+nnA8K3HFG6JlbMG
	SrxbGvR6h9msuDMmM
X-Google-Smtp-Source: AGHT+IF9mmMQzHTCgqXH005UB7Z42fqHHUR6wFWPoiOpfd0+as0Bj2ZukRAxXdKum5WskrbHikrg4g==
X-Received: by 2002:a17:903:2349:b0:223:4d7e:e52c with SMTP id d9443c01a7336-225e0a23febmr158267375ad.5.1742212999977;
        Mon, 17 Mar 2025 05:03:19 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bd4e02sm73045835ad.226.2025.03.17.05.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 05:03:19 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	ncardwell@google.com,
	kuniyu@amazon.com,
	dsahern@kernel.org
Cc: netdev@vger.kernel.org,
	Jason Xing <kerneljasonxing@gmail.com>
Subject: [PATCH net-next v4 0/2] support TCP_RTO_MIN_US and TCP_DELACK_MAX_US for set/getsockopt
Date: Mon, 17 Mar 2025 20:03:12 +0800
Message-Id: <20250317120314.41404-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add set/getsockopt supports for TCP_RTO_MIN_US and TCP_DELACK_MAX_US.

v4
1. add more detailed information into commit log (Eric)
2. use val directly in do_tcp_getsockopt (Eric)

Jason Xing (2):
  tcp: support TCP_RTO_MIN_US for set/getsockopt use
  tcp: support TCP_DELACK_MAX_US for set/getsockopt use

 Documentation/networking/ip-sysctl.rst |  4 ++--
 include/net/tcp.h                      |  2 +-
 include/uapi/linux/tcp.h               |  2 ++
 net/ipv4/tcp.c                         | 26 ++++++++++++++++++++++++--
 net/ipv4/tcp_output.c                  |  2 +-
 5 files changed, 30 insertions(+), 6 deletions(-)

-- 
2.43.5


