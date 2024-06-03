Return-Path: <netdev+bounces-100306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7DCD8D8790
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 19:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12D5A28A0AB
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 17:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A643130E44;
	Mon,  3 Jun 2024 17:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kni+LbIs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEAE12FB0B
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 17:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717434153; cv=none; b=IF8RyMPFuLhN65cN3nd01u6Z0vvYNUyhzKt0k4vO9vnnQrgZWWs4xlQ5VwVGBQLJ5slhyOc+WUfN9hJ8piXhnyXFLdmK3BAZ9Qwr8j/9Un+H7SsfRLTY5qjkp236frVOLO0GaMRcqZYG5GqPER/nLaYH3MjaKQxwVBiNp2auAaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717434153; c=relaxed/simple;
	bh=VjMt0glpQePD8evdEjP05HrOAXJ7FMPoS+Bm3n4Nkhw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=N3zPw1vOz5klS2pub1fOtIB/ZPXbZgZ2LJ/54DK4ROOHGQn9MIPhhzV32+4K8OaHvOZILg9NagQxNSyvg4628QYilcVfp+QbixsAMY4EFxw1Yvr9zjvpo+Fpf95Qr6SdWZZ8Nz12JuRe/qam1MP+iMEFNEZYffdAbdCueh50zag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kni+LbIs; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-6cdf9a16229so115578a12.3
        for <netdev@vger.kernel.org>; Mon, 03 Jun 2024 10:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717434151; x=1718038951; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hM97C1DwkDE3R6cN0KJoKmJQI59XMjBaknQKnZz5NeE=;
        b=Kni+LbIsJRhvOZLzwZvcTkFTDcVLIWL3x/k8l11HJMhzHzyz47G4Bwsq8tZuEXnBlU
         O+LE+uti+aFlv7r5srl2dzBQWzvFH4JN7gnezbalgrmqglpU+XEo6BbXucGfbl2P1XQT
         VgtxAM60E3ZgWNixIX59+JvN+KZxQz96kleFDl+kdykd5a8SrVU5AlcDk5NhEVpmcuKR
         f6j1e//S9J5AKtll622TPY6hXdL/GsU66+LzBvPKDb6EYGekgOrUkBr4PZa/7KRGxHAf
         +Arw+nK/ChLyqavmMRQxw3fdR53WCMlPC80yP654XUmzSya9Tc6UpLLR8DgaIHGZeOWA
         MsMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717434151; x=1718038951;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hM97C1DwkDE3R6cN0KJoKmJQI59XMjBaknQKnZz5NeE=;
        b=mkKUASgpc1vU4/il0ZPMUxXzKQb7rsYlmK1O7Lf/X2UDDVCY3hsW4xc/VrL0O+yJUB
         cDI0hfM4Qnj5ABRVDOz8B/ByGFY9vbvbcwclFkrRmgGqptM8FzQNL4/4uoSmBSItnlaL
         rLUYc5dE/2LUDqNdgicuHx0c0a8ItQHqelJJ217ECwzP0k9j4ZnpG7/bDAF2il5mN3At
         rcRTvTfrQCCh4vOpZ30YqUU/npGFOVZCHx4YxVsh+J1rytit1qKF+8/wsRnyyIFZBkJM
         iIaeMuIZt5Vvf8H5n4NcxytZtxu6Tzrgmn23f7/Lil3Mn5kPixNesyRkwpahqOErtFXh
         iKRQ==
X-Gm-Message-State: AOJu0Yzu9sFlD0yWsRR1nFlaP2FrL4zScwgBS4592kE5+suYnUkidHp1
	obC/aTZdZ/3v+gkqJ5S7VRIHqiYE/fDGWg9Y7VLeGBNFUTfhJglF
X-Google-Smtp-Source: AGHT+IGuDw2evC4F6PvTbIamoMcNVw149vK0hJNtZu5/sqgt0ZQEGrCWXYyJox9BE24L7f9VJsNREA==
X-Received: by 2002:a17:90b:1241:b0:2c2:1d86:f785 with SMTP id 98e67ed59e1d1-2c21d86f8e4mr3703907a91.47.1717434151173;
        Mon, 03 Jun 2024 10:02:31 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([111.201.28.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c1c27e577fsm6460431a91.32.2024.06.03.10.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 10:02:30 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org
Cc: netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net v5 0/2] tcp/mptcp: count CLOSE-WAIT for CurrEstab
Date: Tue,  4 Jun 2024 01:02:15 +0800
Message-Id: <20240603170217.6243-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Taking CLOSE-WAIT sockets into CurrEstab counters is in accordance with RFC
1213, as suggested by Eric and Neal.

v5
Link: https://lore.kernel.org/all/20240531091753.75930-1-kerneljasonxing@gmail.com/
1. add more detailed comment (Matthieu)

v4
Link: https://lore.kernel.org/all/20240530131308.59737-1-kerneljasonxing@gmail.com/
1. correct the Fixes: tag in patch [2/2]. (Eric)

Previous discussion
Link: https://lore.kernel.org/all/20240529033104.33882-1-kerneljasonxing@gmail.com/

Jason Xing (2):
  tcp: count CLOSE-WAIT sockets for TCP_MIB_CURRESTAB
  mptcp: count CLOSE-WAIT sockets for MPTCP_MIB_CURRESTAB

 net/ipv4/tcp.c       | 6 +++++-
 net/mptcp/protocol.c | 9 +++++++--
 2 files changed, 12 insertions(+), 3 deletions(-)

-- 
2.37.3


