Return-Path: <netdev+bounces-115023-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B40DA944E8C
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 16:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38C3CB2574B
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 14:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 705C71A8C11;
	Thu,  1 Aug 2024 14:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hcbzCz0t"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C361A721D
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 14:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722524092; cv=none; b=Z3Jf/5mYWW2nwxxidG60n3xQw0L0s9yIcotH9/QfigMAt5VU+ycfmHVdffjgTm24FC4C9NSf+e2MOJn9Ri8tu/sWcbDcLhYjg7YFo3DWBoxDJwhMf4uf9O7E1wMuZonivg8k8veuUdLY9jIl/EI7Jf+Xo/SeGOyr5wTHI8gAU2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722524092; c=relaxed/simple;
	bh=jv+dQylR9fga8tQcWXR3RaLwfF21nhKYpzyeObDdMm0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OFC1V1awC87GGyx9JtmbWIY04o/F7Tza4iJHVCwR8MOz31O8+LyZvR/U3df20mYQVxfbmCEMuaNfw5aARSF7hSCQeMqEp+iBP682I7OunTHkNe30G0Db4ZOdJ/pfTC+bCod4vRg0xEjDXkKEosETzWNpvfOkb5wmv4gOJ4ceZCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hcbzCz0t; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-70eae5896bcso6133266b3a.2
        for <netdev@vger.kernel.org>; Thu, 01 Aug 2024 07:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722524090; x=1723128890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gwbnad0v9U6oieBU2b/4iyKDoPO84YOEXBMphmMI+vM=;
        b=hcbzCz0tqMSL5v4Ng2H5JPoEmpKkU67icTt7Zlc8VQjjMqcrLX3qz3E6m6ZBo6PydP
         1Tgh8P2KGG3zfzKx8EqdpOodzQ4YMnlgo0XSiMHDs8wD5mi+Zlbquz6slJAjj530KU9W
         sUum8i2U+G4x9vIY/4A3JM5bRbM002KsLUC93bUrCava05VmctlM5RNaQvzWLbsLIrtp
         6CzpVak5LLDDs8RHmyj6UL39vnSaIN4kKek2jGceEfWjpmBHeHZDzIossneJ3cYVyexU
         bLox228me0tfhzu/Ghk4Ww4RnQCeWCGXSbpLnmkh1NCOvHGASKpVm/A1pfTFfsdVGURa
         +DSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722524090; x=1723128890;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gwbnad0v9U6oieBU2b/4iyKDoPO84YOEXBMphmMI+vM=;
        b=TioFlylir5zEzd1HFNXsQQ1/WsooiZo5qyQXhFD6wslbqdneIEmpk/LexSy15wWPve
         bzCAxdCc1ljPw2ez2CbIAvcbNuwLy0LvxkC/Qztjj7KoiUx/Jtc3DmZg+/HeaBWchd1c
         xLl+EA6BpbR2j1x3u5OxTSFD+H/G+y6EmV+gZQIC7lCXixM2au9r7k9fDMkJhi5E/ftv
         6eBxzxISsgOZxcadMJ4mwCd7ZeukCFM9AZMNEUVarOhT0wPIZuoiGOoozm2m8GiGLI/F
         JapM8GIAOJw6S+4yjjq+Dvy1klD0wcFdble8kEDdlC9nmcjPLPHtQHaVx0WVnKq88iB7
         wWZg==
X-Gm-Message-State: AOJu0YzAQdljFu0vBDz0K/gU2N3F93m92PfXx3nuyF+vZmVDldk22rJA
	Gp5YvtRfHpK1ehrVFXLly8+YtabZGgCIe9Am7rF7qO+nYjnMIyCe
X-Google-Smtp-Source: AGHT+IFZGzWiklWakpoECqG06JvEmS2/UrjwcFugzRynEGm81TJ0lHSsWrwoFKOj2gGkU1sM0MA32Q==
X-Received: by 2002:a05:6a20:d49b:b0:1c6:91de:aa10 with SMTP id adf61e73a8af0-1c69968d5d2mr668554637.49.1722524090163;
        Thu, 01 Aug 2024 07:54:50 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([114.253.36.103])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead8a35c7sm11611739b3a.200.2024.08.01.07.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 07:54:49 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	kuniyu@amazon.com
Cc: netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v3 0/7] tcp: completely support active reset
Date: Thu,  1 Aug 2024 22:54:37 +0800
Message-Id: <20240801145444.22988-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

This time the patch series finally covers all the cases in the active
reset logic. After this, we can know the related exact reason(s).

v3
Link: https://lore.kernel.org/all/20240731120955.23542-1-kerneljasonxing@gmail.com/
1. introduce TCP_DISCONNECT_WITH_DATA reason (Eric)
2. use a better name 'TCP_KEEPALIVE_TIMEOUT' (Eric)
3. add three reviewed-by tags (Eric)

v2
Link: https://lore.kernel.org/all/20240730133513.99986-1-kerneljasonxing@gmail.com/
1. use RFC 9293 in the comment and changelog instead of old RFC 793
2. correct the comment and changelog in patch 5

Jason Xing (7):
  tcp: rstreason: introduce SK_RST_REASON_TCP_ABORT_ON_CLOSE for active
    reset
  tcp: rstreason: introduce SK_RST_REASON_TCP_ABORT_ON_LINGER for active
    reset
  tcp: rstreason: introduce SK_RST_REASON_TCP_ABORT_ON_MEMORY for active
    reset
  tcp: rstreason: introduce SK_RST_REASON_TCP_STATE for active reset
  tcp: rstreason: introduce SK_RST_REASON_TCP_KEEPALIVE_TIMEOUT for
    active reset
  tcp: rstreason: introduce SK_RST_REASON_TCP_DISCONNECT_WITH_DATA for
    active reset
  tcp: rstreason: let it work finally in tcp_send_active_reset()

 include/net/rstreason.h | 39 +++++++++++++++++++++++++++++++++++++++
 net/ipv4/tcp.c          | 19 +++++++++++--------
 net/ipv4/tcp_output.c   |  2 +-
 net/ipv4/tcp_timer.c    |  6 +++---
 4 files changed, 54 insertions(+), 12 deletions(-)

-- 
2.37.3


