Return-Path: <netdev+bounces-114547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B26942DD1
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 14:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34B431C20845
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 12:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9FB1AD9F4;
	Wed, 31 Jul 2024 12:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AbkB2imU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9AD91AB516
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 12:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722427807; cv=none; b=CJBVPXUVjstgAwAfy9a7OTAT3yiZFw0Ecbhl9TxxJhkz7GIvNGcw5Sl4F/QwwcMmKmz2KqOafc80pk48NbB8MGWjKhsVAc4ppSfZPQSx40eamOX6gC/eBKNRyYyyZveXv06Am42Oc/+/d29mmoCKVTQUgtMvNWNJDiQ1C1rnpk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722427807; c=relaxed/simple;
	bh=z/LFQNS+1IGtG8xA8I/E1Ngr3KNA9ENKJDC19gOl8V0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ik+z+8uQNoSWj2w8NTqoyoUMY/8FD3nXMecAbLxKnmOux6AZkp537E/ZGUljtVjuAZ2Mm5sdnUZav7OUK0eTybNXCElmbAss/PVydoOMxuwv3rtIpWyLNMCVPGHlt5t1FSEdsbRkU3f+uBjIHNlncFw6LkTxD9M+yvL5PU4gqv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AbkB2imU; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-70d333d57cdso4007342b3a.3
        for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 05:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722427805; x=1723032605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P0NrmmGEp1LJ2llR/oQ5QXNzHsaT5oDLXukMnec2Jgw=;
        b=AbkB2imUGSoXHPAGWiqxvBzcvWtEtPb60rP+IGCl9XkGkpfDZchMvBN3zsbuNhvbh3
         VTvhnWi16HtLIruYWy1Ix/RHvj+XojhVZ90ovEJ6tqJQ0U+Jc4BDWgfk8xUox29P50wP
         tcfL3K8L9YVE1Zke/dNI9YEbmXkIAMLFAzKKRycDy5Uj/va40kUyTmpryfHOW0Pzol0p
         zd/3coN3FojeHOyYmAQB+2FmPu3ExM4NEdPSd7jjpjDLZcuJeh8kZgbYhxeTU7LTwN+s
         6QLtSF8JSYlrRoWuoGn+fghSBgFSszwicUTOn9K9bj2NrHiKyJkCYAlFDSjwGw3n+E+p
         o2hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722427805; x=1723032605;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P0NrmmGEp1LJ2llR/oQ5QXNzHsaT5oDLXukMnec2Jgw=;
        b=Wq35y/OPXNC0mHn3x1EcK8QUuk4Dho6k/i3KGYque3rYH+PJy5qxTri8YMjWD8jb4Y
         gP4//r44MIQZVIsjRYMRWXXzJXoo+lyhtyx8Cb0gbK8pF7R9Chcd+NVBWLnlYwubopkz
         htABU7jTk7kRMrb48gW+SJ0i30blYy+PHTZWFO/MJbCO84tB9LtRKlyh+QImoUF/uGl7
         YNHlr7A/47rAJB1ONu88sX8XStYjUKzRZG7Y9HDBdSTiH7OZgLGQ1Uf5e2GChhZPRv8a
         SLbYQ+NOky4q4IQAAAo4C5e8Ib3aMpK2AWcTNjOQ3RzcIv5H3u1DbkP8W9cbh+cs5qSX
         LiWw==
X-Gm-Message-State: AOJu0YzmS1m6tZc6IJXx39/sr2hUCvz4ZjTvkwayzJsJw5NZ4vNALcjK
	Gsy195cKZvFc8mutfbKlrJHnfZ4ZD4rMTdwDy8+BDI2l/I5yyepb
X-Google-Smtp-Source: AGHT+IEPe4tb3BdcPgbSv2a65jQJxPUvcjSExkh37ac10qQop+6BpGUH3TsYh8iouQJ+uWN0hrbX4g==
X-Received: by 2002:a05:6a20:7fa0:b0:1c1:30fc:90d1 with SMTP id adf61e73a8af0-1c4a117da3amr13400501637.9.1722427804984;
        Wed, 31 Jul 2024 05:10:04 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70eca8af213sm7488545b3a.180.2024.07.31.05.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 05:10:04 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	kuniyu@amazon.com
Cc: netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v2 0/6] tcp: completely support active reset
Date: Wed, 31 Jul 2024 20:09:49 +0800
Message-Id: <20240731120955.23542-1-kerneljasonxing@gmail.com>
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

v2
Link: https://lore.kernel.org/all/20240730133513.99986-1-kerneljasonxing@gmail.com/
1. use RFC 9293 in the comment and changelog instead of old RFC 793
2. correct the comment and changelog in patch 5

Jason Xing (6):
  tcp: rstreason: introduce SK_RST_REASON_TCP_ABORT_ON_CLOSE for active
    reset
  tcp: rstreason: introduce SK_RST_REASON_TCP_ABORT_ON_LINGER for active
    reset
  tcp: rstreason: introduce SK_RST_REASON_TCP_ABORT_ON_MEMORY for active
    reset
  tcp: rstreason: introduce SK_RST_REASON_TCP_STATE for active reset
  tcp: rstreason: introduce SK_RST_REASON_TCP_TIMEOUT for active reset
  tcp: rstreason: let it work finally in tcp_send_active_reset()

 include/net/rstreason.h | 32 ++++++++++++++++++++++++++++++++
 net/ipv4/tcp.c          | 10 +++++-----
 net/ipv4/tcp_output.c   |  2 +-
 net/ipv4/tcp_timer.c    |  6 +++---
 4 files changed, 41 insertions(+), 9 deletions(-)

-- 
2.37.3


