Return-Path: <netdev+bounces-88290-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9E38A69C3
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 13:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4DFB1F21652
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 11:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8BF1292FC;
	Tue, 16 Apr 2024 11:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EE4BiwNr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C31128809
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 11:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713267621; cv=none; b=P0Ho7f83RpyVCwPVpXNOBpJ0a9Po74BapbUsvB59Xn/anOwieRYk1y9uG+AclxLjE/IVRApcHxvJy+RgZqyZg9nQtlL75p25p7FReDsBDtjbyTPKy9YmZ7PCJKptkepS9h3t3Ybwau/alb+/v5C6bJFt40vPwhfKOILMDUYs7g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713267621; c=relaxed/simple;
	bh=bMHexggEFAP7BIJ8i9M+5aDV6PJGpmiVKntFi3s/umo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gXG5UO33U/R7dsDinJtyu10W5IgLwewUNgfVsEPnBGTZE6AxEijj/W4vaNHcXGt8hlVz4zT6ZnqjW2j/DxjWg1DPHmAEgOl0kC/DfKDAhh2XoGG1ewSN+gCrerTC07aIaQmZ++UReYRtuoigEiHUYi5FSzUDrUFy6L7GLWmSTX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EE4BiwNr; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6ed32341906so3754398b3a.1
        for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 04:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713267617; x=1713872417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D584Ey7dj7Uc06fGbbWqllzw7nDGrh0wvYItcfpmMYI=;
        b=EE4BiwNr02mv80ZF20wvMyie4Uha0dnb3n2vE/AZ6yoKt+Nz6aneq8skWW7zLm/gmf
         v/4NeJ3hZ/VCIQRuakIdZBKNFLcydVa8kO1FZoz7isJiiJOy/dBSHIZmz+NHD7YdtoHl
         oQnDhJ7lEvV/uiBHDREgw2SknI4ooEzsrLlhN8qRv83txq3dIs45LoTSx/NWWTO8MCtn
         2uchWQ6lRQxogNSxER+SGVHVH4K5MLaK6dnqr2RUHGTjaUEql4hWlCz/cPTqa1xrEl/5
         dxNBhBNjf+KEFriDErMXqHxMbGcAjR1vJGJT6X8sedrRxR2+JdvaNhbb8GMpV5mdbxXv
         mj+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713267617; x=1713872417;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D584Ey7dj7Uc06fGbbWqllzw7nDGrh0wvYItcfpmMYI=;
        b=oB8kBdOzPvXd1W/a0kzCwD5R12T61ocBR+kFWKjU3RXDvofGOcdHvinUPh2+cUfLed
         UWdwprBfb/01L2xMolF3k5bIorxrF8lAhLd4Pir/Xo88bIKGLd5ue93MUW00AJZSdTsp
         nUzrE0oJokFPup/XJy6EGT/EOJx3uZi8o4IlSIBgWuk9omiFKS3uR0E0JcMIdTkH6RSA
         EQ169h+ypXiqu9XyuABMDwRAsubcEpsixjL3uVnb83CgPBuNyhEyI7VNas+6E9LMNqWE
         wDu/8rIp+hNc/fQ1yXcQI1/EddkASkduyUlXzuPffyyombmZ3mOHPbxrJiM0F7a0UPdB
         6TpA==
X-Forwarded-Encrypted: i=1; AJvYcCWtd2w6oj5H4E4MBFOl2qYq3YZrcRSJU8QYJCv/P7IPByxNRJ0RymHuGkVMFJGHZPHjryWHhzk2lr7qS6ErygY6xfKrevsb
X-Gm-Message-State: AOJu0YwQMB4tV0kQ+sjqofTLpqFkbuJnKhADni0SsDqA1d3bI6ABz5tr
	ZMP6j06RVK1uv/wqzkJOG7gt3xpcamrZEG8tcpKbkkwNrEtGd06dNUk0y1hr
X-Google-Smtp-Source: AGHT+IGX+zF8CmopMx+clskbHNVd/d/eVMbnT0wtTPnMZAB18froXkCVhjaiAddKDedrmnuhFOth6A==
X-Received: by 2002:a05:6a00:1708:b0:6ec:ec8f:d588 with SMTP id h8-20020a056a00170800b006ecec8fd588mr12861623pfc.16.1713267617432;
        Tue, 16 Apr 2024 04:40:17 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id a21-20020aa78655000000b006e6c16179dbsm8862045pfo.24.2024.04.16.04.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 04:40:16 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: edumazet@google.com,
	dsahern@kernel.org,
	matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	atenart@kernel.org
Cc: mptcp@lists.linux.dev,
	netdev@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v5 0/7] Implement reset reason mechanism to detect
Date: Tue, 16 Apr 2024 19:39:56 +0800
Message-Id: <20240416114003.62110-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

In production, there are so many cases about why the RST skb is sent but
we don't have a very convenient/fast method to detect the exact underlying
reasons.

RST is implemented in two kinds: passive kind (like tcp_v4_send_reset())
and active kind (like tcp_send_active_reset()). The former can be traced
carefully 1) in TCP, with the help of drop reasons, which is based on
Eric's idea[1], 2) in MPTCP, with the help of reset options defined in
RFC 8684. The latter is relatively independent, which should be
implemented on our own.

In this series, I focus on the fundamental implement mostly about how
the rstreason mechnism works and give the detailed passive part as an
example, not including the active reset part. In future, we can go
further and refine those NOT_SPECIFIED reasons.

Here are some examples when tracing:
<idle>-0       [002] ..s1.  1830.262425: tcp_send_reset: skbaddr=x
        skaddr=x src=x dest=x state=x reason=NOT_SPECIFIED
<idle>-0       [002] ..s1.  1830.262425: tcp_send_reset: skbaddr=x
        skaddr=x src=x dest=x state=x reason=NO_SOCKET

[1]
Link: https://lore.kernel.org/all/CANn89iJw8x-LqgsWOeJQQvgVg6DnL5aBRLi10QN2WBdr+X4k=w@mail.gmail.com/

v5
Link: https://lore.kernel.org/all/20240411115630.38420-1-kerneljasonxing@gmail.com/
1. address format issue (like reverse xmas tree) (Eric, Paolo)
2. remove unnecessary casts. (Eric)
3. introduce a helper used in mptcp active reset. See patch 6. (Paolo)

v4
Link: https://lore.kernel.org/all/20240409100934.37725-1-kerneljasonxing@gmail.com/
1. passing 'enum sk_rst_reason' for readability when tracing (Antoine)

v3
Link: https://lore.kernel.org/all/20240404072047.11490-1-kerneljasonxing@gmail.com/
1. rebase (mptcp part) and address what Mat suggested.

v2
Link: https://lore.kernel.org/all/20240403185033.47ebc6a9@kernel.org/
1. rebase against the latest net-next tree

Jason Xing (7):
  net: introduce rstreason to detect why the RST is sent
  rstreason: prepare for passive reset
  rstreason: prepare for active reset
  tcp: support rstreason for passive reset
  mptcp: support rstreason for passive reset
  mptcp: introducing a helper into active reset logic
  rstreason: make it work in trace world

 include/net/request_sock.h |  4 +-
 include/net/rstreason.h    | 93 ++++++++++++++++++++++++++++++++++++++
 include/net/tcp.h          |  3 +-
 include/trace/events/tcp.h | 37 +++++++++++++--
 net/dccp/ipv4.c            | 10 ++--
 net/dccp/ipv6.c            | 10 ++--
 net/dccp/minisocks.c       |  3 +-
 net/ipv4/tcp.c             | 15 ++++--
 net/ipv4/tcp_ipv4.c        | 14 +++---
 net/ipv4/tcp_minisocks.c   |  3 +-
 net/ipv4/tcp_output.c      |  5 +-
 net/ipv4/tcp_timer.c       |  9 ++--
 net/ipv6/tcp_ipv6.c        | 17 ++++---
 net/mptcp/protocol.c       |  2 +-
 net/mptcp/protocol.h       | 11 +++++
 net/mptcp/subflow.c        | 27 ++++++++---
 16 files changed, 216 insertions(+), 47 deletions(-)
 create mode 100644 include/net/rstreason.h

-- 
2.37.3


