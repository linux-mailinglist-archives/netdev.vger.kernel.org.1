Return-Path: <netdev+bounces-99691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5030A8D5E09
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 11:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B87A284962
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 09:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82EE770FA;
	Fri, 31 May 2024 09:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="go1NEy9H"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BEDE74267
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 09:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717147082; cv=none; b=Xe8qaNQZq2ue0i/KHaB7I+OvOYB4PJadkMPDH8eMa6w1iUE9SpStM9P/4CG90kxKJh/eFzqdYBFYdliF3tD5/7t4W/Aq9qfCWikiFP9ZVy8BRiMm7XHi+syk7jhhpKf+fTKX5O255Gi6/UgMk38/jjOACbWOycSUqsBzFHEXdT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717147082; c=relaxed/simple;
	bh=8I/a30jZnTqfpfNPgkeeMDh2ALPauRl9rp3+2I9qbyE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nrhMLnFDCY1xFP8OAKAxnMDsHO6aNvg0dpoAFVSDs5ItFjUHMe/BAqxchQmKO36qkn68h2gLPLYx9Y0bTXWMBA2Qn325bzGVVWxda2FVXOegY3nT6KEfeuqqlP+qDRHQnyH0ebOKM9f9La2473XhO6OaaGbis2hRthg+ALkYD5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=go1NEy9H; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6ff6fe215c6so1591845b3a.3
        for <netdev@vger.kernel.org>; Fri, 31 May 2024 02:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717147081; x=1717751881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3tOB66n+P1I9gWnR6juVMERuYmSl2Jj0Hp5nLCvT/H0=;
        b=go1NEy9HX5sTBtkqZGI2nABLam8SmNGZ/mSOXjMl88psNTYeB3IlnZ2VgiLr2O9Ud7
         kIrK0UnQzyoIXToq+MwjB7y6+501b0Gd4ul0NabXv+S8UXBLUGXNq1Xc4gtf8M2o0UeW
         KVTeGFj5wlgk9d3nS5jySqD2RHYxe4x4QNwSKtRLnwyRVi2nLz03TijTWlecUn4PzEXQ
         r94uE5Xm4L7bFsOQR+hvkaD2RsT3lV2J28w8WswxT3e/8zsR06H54PualSugcmoIO90m
         1wLms7c97QT6MslbmSfSURwewXt3BnJJwQEbC7qydravilVHzOXMOrQ82+2Q9h1zNskl
         tFdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717147081; x=1717751881;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3tOB66n+P1I9gWnR6juVMERuYmSl2Jj0Hp5nLCvT/H0=;
        b=wmBHr/EMFGymnbhHm3hhHwRWwswqXv3e3Bu4tBSVDFiJagr3u3MndNi38xAOPCB1LG
         0WSo8ZUUHRNaAatMlqULTZZCbbu3jxSS8e/5OLxGzUhET3BgtUD/2bz9XJRUHwOHTXdG
         nFOQ2TdjhswxfMjg7VoWISZ9wGeizeUuxYymzAGf5GDZSMXJMex1CfDZ9pMo0J1aFLId
         U4QiGyO0yEq5ch6z1L2YsmkfxtTCZyI4hZ1ru3Gdt9+jZ/u8qySL4Qj0cs2PFRx2+LkV
         MuSkCogjtv56lAbXz3asPsMLStP2RVTs9wPS0tZEVtv3DZ9Fkn6Vx2/7U++HRS6eGoDc
         blUg==
X-Gm-Message-State: AOJu0YzI4kWjqq6T0/A+jJXljr1dnn7GPp4LF49vLUPebsSOBY3EhQJP
	ul9jNJ2potPP57lv81Xkr+H2dR+b+yjPojTLMMEaIQfYSBSioXlY
X-Google-Smtp-Source: AGHT+IGgEjX+CGeHGmFCGqmbKCLITKC2cQybiJvDG1yufPXs2ulzjW/ax1tp9KNasHN8tn8YI1hupQ==
X-Received: by 2002:a05:6a20:72a2:b0:1b2:663a:968f with SMTP id adf61e73a8af0-1b26f1f725amr1670814637.31.1717147080592;
        Fri, 31 May 2024 02:18:00 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f632356c84sm11950015ad.76.2024.05.31.02.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 02:17:59 -0700 (PDT)
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
Subject: [PATCH net v4 0/2] tcp/mptcp: count CLOSE-WAIT for CurrEstab
Date: Fri, 31 May 2024 17:17:51 +0800
Message-Id: <20240531091753.75930-1-kerneljasonxing@gmail.com>
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

v4
Link: https://lore.kernel.org/all/20240530131308.59737-1-kerneljasonxing@gmail.com/
1. correct the Fixes: tag in patch [2/2]. (Eric)

Previous discussion
Link: https://lore.kernel.org/all/20240529033104.33882-1-kerneljasonxing@gmail.com/

Jason Xing (2):
  tcp: count CLOSE-WAIT sockets for TCP_MIB_CURRESTAB
  mptcp: count CLOSE-WAIT sockets for MPTCP_MIB_CURRESTAB

 net/ipv4/tcp.c       | 6 +++++-
 net/mptcp/protocol.c | 5 +++--
 2 files changed, 8 insertions(+), 3 deletions(-)

-- 
2.37.3


