Return-Path: <netdev+bounces-122854-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC9F962D29
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 18:02:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E8A21C23ACC
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 16:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB661A38CE;
	Wed, 28 Aug 2024 16:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IiryJDqt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64211A254C
	for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 16:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724860913; cv=none; b=SeGSwaD2WZZv1SvyJmmmcp4Ui2Ro1psFdRU29/MltimvAa7oNoc4PHg48vMNeoUyZC4iTIu1jDQ2uTLGF6aWAVGeZbxViZ4q1/D2u0e0va+Z75TmZlX2tM+paewVdErvbgRTbo0gqt/pyfiNWJVK9hmcEEbKpLXKKxUMOvAFIMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724860913; c=relaxed/simple;
	bh=XcAl9r+iAnsPq+YkHVPRVsodq0PBNPRMhAyMvRNMzRk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=miE/ERmMg67Z5H/jfTP3Xx+M1ccGmuVXuZ+2tO2EkxctThL+crjgtBH9S4nTotG8gWy0qFVn1NslvEVjyVAi5o39weXiAH7UPKpm+ygAODSidkPkzNQxMtqGjZPllKDRSTx1xqb/n7xTjrSIkfQS7GPEC+IGDZxqy0iVB6fvDS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IiryJDqt; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-201fae21398so49146815ad.1
        for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 09:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724860911; x=1725465711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DQrdj6LIBKnYLBqWRL2zYNFdj3o0U42i0y8W82KXge4=;
        b=IiryJDqt9z3HD3ZmcECuOg8yBkvZG4SQiHUMZk3xrqRsSqTVmvTyEmnutc9hu1P8ms
         SuZ6f8bnK2lfMGaVhT+AESYxTTzMc7DCf+5rpDpSfowrvxCn/bb7y3TPYSUuytBS5wCH
         UPO6ravl696jSQKRHyn2W4ZB5+STRVatfcvq9EJCWP9W8KFkMCTV3ZVbeSFQQ0Qo4Nrk
         guFiN6oCiVk+8gnUsEjGwMe91Xlco/BhDsh7gaXI+vJvDnHFMgj2GYFwhY0jM1xpNXq8
         utZy/DGQL6mMfZNW+Gabp9xdtUIGrohFwkUVnxSDScQeaLHDmoAOfsCrYRXnCWWXfdx7
         S+RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724860911; x=1725465711;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DQrdj6LIBKnYLBqWRL2zYNFdj3o0U42i0y8W82KXge4=;
        b=px0ueOen+weL5+lPJ02QX6LVLO1mBDxnbBVd+nA5jDjLMP+i6xS5Ov5brCJKRvXXxv
         jlnkZFzqOPZMhtkjAseYuGJ73uFPfDELRQzGioPqpqwVVRW3R8M5xhVt41i60TwKB7Cb
         gwbuu0RrSsI/TC9i232yWNp4Bo40m/TsRVPlGSZSmgyIml7DFt6Ux3No0ro811cH/mmH
         vlFBbRyMTv09sDn/cAHRX9ZaNmHNsOOKKKyt1F/pWZuEWiBspA6NauTl8Txk9BSLSoJK
         sV2sk9Bw88NZy3Y5XBrMnKZlqBEhsCBXLNf8ZfMj9J0eg20gHDupsI2KSDnJni5j9vbD
         zgWg==
X-Gm-Message-State: AOJu0Yxx8kcdUNjwrOhpUnwaHv/9h3jeEmfE0jmvAPGy3O5Vj60HXEtK
	Votf+mlkcdX1q/xG0ahSnJcnsDGTq95akWt+muetkudlGw5kLqWM
X-Google-Smtp-Source: AGHT+IFvLxtW7LiRb2xMbSpZ6lo6DPiQVZqm5pAUPHtJCbXCLvY/mab4gVn56vCSlxXQ/A1hots2TQ==
X-Received: by 2002:a17:902:fb88:b0:202:3bae:9729 with SMTP id d9443c01a7336-204f9bf6d90mr21803265ad.43.1724860910586;
        Wed, 28 Aug 2024 09:01:50 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([114.253.36.103])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385564dd9sm100061755ad.51.2024.08.28.09.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 09:01:50 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	willemb@google.com
Cc: netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v2 0/2] timestamp: control SOF_TIMESTAMPING_RX_SOFTWARE feature per socket
Date: Thu, 29 Aug 2024 00:01:43 +0800
Message-Id: <20240828160145.68805-1-kerneljasonxing@gmail.com>
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
know which socket the skb belongs to.

According to the original design, we should not use both generation flag
(SOF_TIMESTAMPING_RX_SOFTWARE) and report flag (SOF_TIMESTAMPING_SOFTWARE)
together to test if the application is allowed to receive the timestamp
report in the receive path. But it doesn't hold for receive timestamping
case. We have to make an exception.

So we have to test the generation flag when the applications do recvmsg:
if we set both of flags, it means we want the timestamp; if not, it means
we don't expect to see the timestamp even the skb carries.

As we can see, this patch makes the SOF_TIMESTAMPING_RX_SOFTWARE under
setsockopt control. And it's a per-socket fine-grained now.

v2
Link: https://lore.kernel.org/all/20240825152440.93054-1-kerneljasonxing@gmail.com/
Discussed with Willem
1. update the documentation accordingly
2. add more comments in each patch
3. remove the previous test statements in __sock_recv_timestamp()

Jason Xing (2):
  tcp: make SOF_TIMESTAMPING_RX_SOFTWARE feature per socket
  net: make SOF_TIMESTAMPING_RX_SOFTWARE feature per socket

 Documentation/networking/timestamping.rst |  7 +++++++
 include/net/sock.h                        |  7 ++++---
 net/bluetooth/hci_sock.c                  |  4 ++--
 net/core/sock.c                           |  2 +-
 net/ipv4/ip_sockglue.c                    |  2 +-
 net/ipv4/ping.c                           |  2 +-
 net/ipv4/tcp.c                            | 11 +++++++++--
 net/ipv6/datagram.c                       |  4 ++--
 net/l2tp/l2tp_ip.c                        |  2 +-
 net/l2tp/l2tp_ip6.c                       |  2 +-
 net/nfc/llcp_sock.c                       |  2 +-
 net/rxrpc/recvmsg.c                       |  2 +-
 net/socket.c                              | 11 ++++++++---
 net/unix/af_unix.c                        |  2 +-
 14 files changed, 40 insertions(+), 20 deletions(-)

-- 
2.37.3


