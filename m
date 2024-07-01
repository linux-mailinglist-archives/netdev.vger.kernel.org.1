Return-Path: <netdev+bounces-108290-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0375891EB2E
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 00:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 348C31C212BC
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 22:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C27C17106C;
	Mon,  1 Jul 2024 22:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="GxcgQwST"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF89153835
	for <netdev@vger.kernel.org>; Mon,  1 Jul 2024 22:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719874437; cv=none; b=ORNlPe1HjKNtGvn4ZMlKshMP4FeSiWlrqpIGPAqbDWa4o8i55DcvdOwxPIBL+XSLRFyhux+NvDhRC0MV3+tJ0A6bf3xXn3Yoqt8hmrDCbhjp1GzCFbNjCLvdPEL5/QOLJHVBXXUJJlVJGqs9jxR9r4J2fzOxWGhNRk/ZU5eNLCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719874437; c=relaxed/simple;
	bh=JDa/S48yD3cJ2UWZE5UKPuzjnamQRULphKEoHadG15Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=grjZuDo0VK82frK+TiGVUhHHukwdJ0NMgTxhGXlL7c4M7bMJarv1UrWjYAnld8cBp2HL6QKKyZB3pyOVN5Rh6kUpt804Ko3ZDxdKqAmUwQ4TnYYhUO+OuFtC/ziZbNqZ0Ro2B5qI7oqxDNplUF48d1wtsbFK/pUbh4RfynuHSVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=GxcgQwST; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6b56000f663so17028486d6.1
        for <netdev@vger.kernel.org>; Mon, 01 Jul 2024 15:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1719874433; x=1720479233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wTmw6fxDXvJlFZ1SgX2ixNCckiqQZEO4GvZY3nDkqwg=;
        b=GxcgQwST7iGC0Jvjb7T7f2+W/1o8Zo0joCtPx8KaRIVb0D9qvZKp5UB4L8x396zwd7
         LDJHvS/stUuXPYzUtHX2zsIe8Z46QOQIMRcwdwkG7Rt29kEGW3Wnl0tupxXq4b91ep1g
         t4azSDYGTyGZFgGrtHuJUMRu+SVVPK2ykqnUhN4dMf4bz74BTAeKCE3mmEms8oFrq5dQ
         /cCzy4HuQB32wLbUPPymBC+AKDHkd+oE3VjjSl6gzQw/Yx0UFH5JhlyseRzD+dyFX+CG
         hGxDbzO1JeLfWZi5sk1tTm7JQNrwN2dy32X+sTxBXGxajfXBoJXZ3a46ETQj5Weoft/I
         /Xzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719874433; x=1720479233;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wTmw6fxDXvJlFZ1SgX2ixNCckiqQZEO4GvZY3nDkqwg=;
        b=J4fCuGqF3z5DuYZtNaQxZk7mnOVCE1edKUjXh6F8cPfw1IK09DmLcrPiEJ0iQXrRuo
         BhgIRpOQAENNbeElwWk9+aXyiR9b1iiI6vfzI6E7Ul/Oh8vtpeTE9S8sH3NlvUraYZgF
         LOq9Z28OGAETdtRxk5kAgCp2LLrmU/WwZnLJMDRoZOo85jFBx7+nLqVVdNHHT1Nz6hLi
         jVNcxrA2utNLldK8Z7fuy8u8WsXk/rbbc4Wsl8ZnC7+1v+VzevsDmfJG9FmdnSL73F1I
         c3ppyhXQFtmRswTgwPs4Chsi0Q1ShLf2o2SO9krLEPbuo8oS7eBYteIibZsnlu9FyAgt
         Pycg==
X-Gm-Message-State: AOJu0YzlsskLzWgEENwcRC0MqQ6qjgEN4GlpC7YW07o/ZU+zqUXtMJ2Q
	3MhTk3HcGJo2tJv/8CwADJUNICInjdw7Xo127bBR48brbS/Dqupi+z1TyG9I7K5iA1xwOTp6Utv
	I
X-Google-Smtp-Source: AGHT+IFfJlIM3sENVMNr1MtpfQTNfUdOhkq5ajri8luOpdUJaK0fJmNfOt+uHjOMluH41hdP6uXONQ==
X-Received: by 2002:a05:6214:226e:b0:6b5:4878:49c with SMTP id 6a1803df08f44-6b5b70b5b7bmr69710466d6.21.1719874433332;
        Mon, 01 Jul 2024 15:53:53 -0700 (PDT)
Received: from n191-036-066.byted.org ([130.44.212.111])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b59e5f34efsm37706356d6.90.2024.07.01.15.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 15:53:53 -0700 (PDT)
From: zijianzhang@bytedance.com
To: netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com,
	cong.wang@bytedance.com,
	xiaochun.lu@bytedance.com,
	Zijian Zhang <zijianzhang@bytedance.com>
Subject: [PATCH net 0/2] fix OOM and order check in msg_zerocopy selftest
Date: Mon,  1 Jul 2024 22:53:47 +0000
Message-Id: <20240701225349.3395580-1-zijianzhang@bytedance.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zijian Zhang <zijianzhang@bytedance.com>

In selftests/net/msg_zerocopy.c, it has a while loop keeps calling sendmsg
on a socket with MSG_ZEROCOPY flag, and it will recv the notifications
until the socket is not writable. Typically, it will start the receiving
process after around 30+ sendmsgs. However, as the introduction of commit
dfa2f0483360 ("tcp: get rid of sysctl_tcp_adv_win_scale"), the sender is
always writable and does not get any chance to run recv notifications.
The selftest always exits with OUT_OF_MEMORY because the memory used by
opt_skb exceeds the net.core.optmem_max. Meanwhile, it could be set to a
different value to trigger OOM on older kernels too.

Thus, we introduce "cfg_notification_limit" to force sender to receive
notifications after some number of sendmsgs.

And, we find that when lock debugging is on, notifications may not come in
order. Thus, we have order checking outputs managed by cfg_verbose, to
avoid too many outputs in this case.

Zijian Zhang (2):
  selftests: fix OOM in msg_zerocopy selftest
  selftests: make order checking verbose in msg_zerocopy selftest

 tools/testing/selftests/net/msg_zerocopy.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

-- 
2.20.1


