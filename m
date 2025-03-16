Return-Path: <netdev+bounces-175090-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 518CDA63358
	for <lists+netdev@lfdr.de>; Sun, 16 Mar 2025 03:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5128018905E2
	for <lists+netdev@lfdr.de>; Sun, 16 Mar 2025 02:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0022218027;
	Sun, 16 Mar 2025 02:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EDmrbhQd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7912E3377
	for <netdev@vger.kernel.org>; Sun, 16 Mar 2025 02:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742092034; cv=none; b=r/xwyEgRi+o+edR4PKlmHgmEEU9LMcbVwgOeP70/536wfwVmSapF8E2WXWOLRXfQ0hZ5uGQ/0+N/upqft6WRJshVnVtkGxkfpkZnv4o/pJbJbxBHQKupvwa4qkI8gEA6yI0fdjb9hXanGPhsCibliSF4kKJETD1Stysv3ifoc1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742092034; c=relaxed/simple;
	bh=Nt5rNGiAOtjrmQHFV8DSn4A8KnBmRg6btU81XoM2YpU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eenC7u4rBQRFbGdtdiRl0L1QZ8IwOhmTTnJI0HDdUdPypx/csJH1/heRfCLgnXnqrnGcgRgf1oW+EbdJdwWZ9wsQYdR2wa2/BbNo6QsFi6W0DJPuV8oAbp9xCzoEPfIC+mc1KTobP0uUCxedIEvKH8RSjyz884fh9EJ18oJ39Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EDmrbhQd; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-223959039f4so68226995ad.3
        for <netdev@vger.kernel.org>; Sat, 15 Mar 2025 19:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742092033; x=1742696833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DqkByP4iUXXPTRecmz6C4O9NznrXNPQREFGOsiQ+5/o=;
        b=EDmrbhQdZMtuHvp/zqR+NwhID8k+tCJeV2FN5tu0H/KZsohEDgHid6ywytrFCuIC7p
         CjIlTaQl8/mpSnvsPBxAIr9Uw51ZtzynR2lbxpdc19I4ZUt/SqkO8LP9OvxetfhlH9ke
         08ucVVwJQL7iOrUjzhS1qEmUqZwP2Ld6cWuFtNOme/FrsiTlnRGJJo0Ha8/Lqnr04tOX
         1Fzt0YCT9gfvyOwy5w/J066jVwNHP84XlIP6nz4U9s09oglzTIlSODEOJGm1pIiEQbsH
         mE2RTYeVetVd9milddwpI6cWVXCkViMfxQus1yO+Hi0eiK9HlTsCPbO1jwlOJRP5F6oV
         tiVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742092033; x=1742696833;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DqkByP4iUXXPTRecmz6C4O9NznrXNPQREFGOsiQ+5/o=;
        b=UiiBerdQE3N6HyKcj7qT6ehaj944lSTuvC36jV9tWm/G2zkmNiIbeVc52Ql+LiMPNx
         TObrZbZcPcq8bBBa89slt8HuaDVIqWAPMPqW0iRlhyPd2ConBrPE2r2tftBHsR/z32vg
         TqDPzZDaPO+wHDcg083Y1pEJZRJSC5G1ADpYJtnYJHxpH0SRTMgpS450SZtb67yVssNr
         va/eJhHmWoRPbRGma8QDSwpV4DZsqeNTyHP2XUtnCHx8tnNGn8OxLstQisdNzwBWu4Zr
         cX4I477xNmxTeAR8+HmOWa+YMqJHDcmJJ5+UgR6SPD3phk8SdsqVeoGZHcughgE/AP3s
         WhDg==
X-Gm-Message-State: AOJu0Yxf87pM1hTcjajiDLA7ZXGjzrFbI5cPTrWhYjy4hfphezfiQeCL
	t1Zl1OfBM3dCXzmQKTj4lPzIBs/OVovWX4MF1juM/Cah51rZHM6a
X-Gm-Gg: ASbGnctaoeYJAHEoLVbjSPZDeraR2X/ZknhiaCJ2ZVeUHu5NF5AcSlASVwyGHP3Sn0T
	omiiImKYEZnmfN8H0MnYoi3005stx81JZqmSXvCw02mQYjE+V1jCHK4l4njNo1uzmd1A3Ui3U1I
	wNlu+4g3T+BiyNVI/LG+h6txRRhvHAjTFOKGWx7BowKgsMaQNK5+jRwyvmmxI0Nbmzy44S1DV4k
	NAAxukIjsbcGg/xFKuvwYdixpsAMSV5NVPoIDom3XwuzfuOaXBV0z9d3Qtv4Xy1bLUxFGo2RTj4
	6gnMu1zDyhwawTybXcrHxvyCJgA5H6495uzgEr/RgnDPoXEFS1KAB4VfIaaxHlVsY8XFfVt16Yi
	mWymWQag=
X-Google-Smtp-Source: AGHT+IE96W5theOnhtDU6p3EDWVjjVmBZMzyRky3nubtoDtMDUw3GDztlxuWuCvr3g+VQ6hlXQHESg==
X-Received: by 2002:a05:6a00:4f92:b0:736:532b:7c10 with SMTP id d2e1a72fcca58-737223fccabmr9577271b3a.21.1742092032679;
        Sat, 15 Mar 2025 19:27:12 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([111.201.25.167])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73711694b2csm5068255b3a.129.2025.03.15.19.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 19:27:12 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	horms@kernel.org,
	kuniyu@amazon.com,
	ncardwell@google.com
Cc: netdev@vger.kernel.org,
	Jason Xing <kerneljasonxing@gmail.com>
Subject: [PATCH net-next v3 0/2] support TCP_RTO_MIN_US and TCP_DELACK_MAX_US for set/getsockopt
Date: Sun, 16 Mar 2025 10:27:04 +0800
Message-Id: <20250316022706.91570-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add set/getsockopt supports for TCP_RTO_MIN_US and TCP_DELACK_MAX_US.

Jason Xing (2):
  tcp: support TCP_RTO_MIN_US for set/getsockopt use
  tcp: support TCP_DELACK_MAX_US for set/getsockopt use

 Documentation/networking/ip-sysctl.rst |  4 ++--
 include/net/tcp.h                      |  2 +-
 include/uapi/linux/tcp.h               |  2 ++
 net/ipv4/tcp.c                         | 32 ++++++++++++++++++++++++--
 net/ipv4/tcp_output.c                  |  2 +-
 5 files changed, 36 insertions(+), 6 deletions(-)

-- 
2.43.5


