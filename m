Return-Path: <netdev+bounces-121728-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1645795E425
	for <lists+netdev@lfdr.de>; Sun, 25 Aug 2024 17:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB11D281531
	for <lists+netdev@lfdr.de>; Sun, 25 Aug 2024 15:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2DB613B599;
	Sun, 25 Aug 2024 15:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MChyxkfC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F3A1E4A2
	for <netdev@vger.kernel.org>; Sun, 25 Aug 2024 15:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724599487; cv=none; b=Y1EwgLE1lMi6+S98ZKQ9eqBEbkH2UZIAFDBGCJql1c31+NTnh2bO2mbT/YOZZN1xaW1mA+nRZFCHnB1K0Cxq2a+Sa945cQX+xgrdHGd7u8kdKUT9X0WR67MPE+jaHuntAroLBtg4qVa+/Exl0MKiNaAElGF+UGwZFi7+/LrLjBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724599487; c=relaxed/simple;
	bh=qlNs1x+H+20gjXrr4TFU0UYKKeeB21+1956i5KI10I0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sWlpvZFGBDwsB2mVflA4S4hedPPTUdrFVX0GoDIf3233SVqyDkNJIlstlxJ5J38ElqmmrFiGrGiTe4vIRBdeXTUYOqLHUiXUxdVWZXDZt9a7m1wiEkRIcrnnfpvz1u4FnQ/ZNos31oGNzYcu40IoBR6EbwoJyZ4xides1LP5y04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MChyxkfC; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-71431524f33so2982729b3a.1
        for <netdev@vger.kernel.org>; Sun, 25 Aug 2024 08:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724599485; x=1725204285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=licbOUMLRJtpwsf3xovc5X8ZTBDPwlJgo+mSnhuIspY=;
        b=MChyxkfCwA7L0HINo24VvpGcLoesYuxlbMFLdIXG1NzQ34umXSOVsOHz26+v/kWX0d
         mDBakH9eLYNIR/+mlkwpbHoQTZ9Zqo3Gcn46Nv19yKXbltDmP3yEKbtLqaRkX/5u7GYd
         bpc9i9S1N0TpWjtI8ILCQLYhkQOFAoKK/wpjOQxym6xWurjrvJtFTXc64Zrj5Ajh3dct
         8jPTh60woOqnQbIvJqRIPp0lTdF0EsUVCnkxgQ0s3mImKmIFj7kTqCCxcfhOxivjMHIA
         Hwfbn7RUrAmJef9vZkoG+/tRTerbGAchSrpjVo2wsWnUIDHeOeBn3WhQ1hGjuO8Lf9Is
         kSNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724599485; x=1725204285;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=licbOUMLRJtpwsf3xovc5X8ZTBDPwlJgo+mSnhuIspY=;
        b=tOqK+kZT14gqunGFkisPtNTpqRI/HPAVwges/yzCEdaKD5HRYV1xdq65huKBVqTPCF
         jbqy5Yd+BvQnvKmfrapBA9L8Ua8yX8sYEULqUUtMCs3tIwDpFHPR6QQL2eCqN/FFb09w
         22Y5bTu7MmAZX19W0/GLatUQ76NBs/rqx4aBcuB8HxqK5we2cHyHt6S+uaWex/IYsQXX
         Ya0uZ78Oz2ilCqK4KrD2GvpLZbGTATLqh39fr01gI9tZ5aVcVZAj+rRlgf+Kls13PUmW
         1HW/0D3jv51DB2Krs0o+psSZDf4CyUcNkbJpHfxZymL1TkEr1qu91OytTTTpf4LHhaAE
         yXrw==
X-Gm-Message-State: AOJu0YzqLsKz+THLfjTgH3g2SrzD7WHhJqiQ4HNWftbIx9Mc/h8YauAQ
	gFmhGUeQwpKKiC5Kc1Oh5ZCsLTyZrWymsDrMnlyD8o4ZTdaxjqqM
X-Google-Smtp-Source: AGHT+IGluv2hVigQw58dPqnU9yEbg8K89fI9tshaTVJmFMgh21a4bvz0ur2+SdU+vLRequFHnZ2Ojw==
X-Received: by 2002:a05:6a00:2ea9:b0:70b:176e:b3bc with SMTP id d2e1a72fcca58-7144588f612mr10380622b3a.28.1724599485308;
        Sun, 25 Aug 2024 08:24:45 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([114.253.36.103])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7143430941bsm5775166b3a.168.2024.08.25.08.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2024 08:24:45 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	willemb@google.com
Cc: netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next 0/2] timestamp: control SOF_TIMESTAMPING_RX_SOFTWARE feature per socket
Date: Sun, 25 Aug 2024 23:24:38 +0800
Message-Id: <20240825152440.93054-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Prior to this series, when one socket is set SOF_TIMESTAMPING_RX_SOFTWARE
which measn the whole system turns on this button, other sockets that only
have SOF_TIMESTAMPING_SOFTWARE will be affected and then print the rx
timestamp information even without SOF_TIMESTAMPING_RX_SOFTWARE flag.
In such a case, the rxtimestamp.c selftest surely fails, please see
testcase 6.

In a normal case, if we only set SOF_TIMESTAMPING_SOFTWARE flag, we
can't get the rx timestamp because there is no path leading to turn on
netstamp_needed_key button in net_enable_timestamp(). That is to say, if
the user only sets SOF_TIMESTAMPING_SOFTWARE, we don't expect we are
able to fetch the timestamp from the skb.

More than this, we can find there are some other ways to turn on
netstamp_needed_key, which will happenly allow users to get tstamp in
the receive path. Please see net_enable_timestamp().

How to solve it?
setsockopt interface is used to control each socket separately but in
this case it is affected by other sockets. For timestamp itself, it's
not feasible to convert netstamp_needed_key into a per-socket button
because when the receive stack just handling the skb from driver doesn't
know which socket the skb belongs to. So we have to test the exact
timestamping flag when the users do recvmsg: if we set both of flags, it
means we want the timestamp; if not, it means we don't expect to see the
timestamp even the skb carries.

As we can see, this patch makes the SOF_TIMESTAMPING_RX_SOFTWARE under
setsockopt control. And it's a per-socket fine-grained now.


Jason Xing (2):
  tcp: make SOF_TIMESTAMPING_RX_SOFTWARE feature per socket
  net: make SOF_TIMESTAMPING_RX_SOFTWARE feature per socket

 include/net/sock.h       | 11 ++++++-----
 net/bluetooth/hci_sock.c |  4 ++--
 net/core/sock.c          |  2 +-
 net/ipv4/ip_sockglue.c   |  2 +-
 net/ipv4/ping.c          |  2 +-
 net/ipv4/tcp.c           | 10 ++++++++--
 net/ipv6/datagram.c      |  4 ++--
 net/l2tp/l2tp_ip.c       |  2 +-
 net/l2tp/l2tp_ip6.c      |  2 +-
 net/nfc/llcp_sock.c      |  2 +-
 net/rxrpc/recvmsg.c      |  2 +-
 net/socket.c             |  7 ++++---
 net/unix/af_unix.c       |  2 +-
 13 files changed, 30 insertions(+), 22 deletions(-)

-- 
2.37.3


