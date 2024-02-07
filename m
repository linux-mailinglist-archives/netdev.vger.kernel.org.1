Return-Path: <netdev+bounces-69968-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC9C84D245
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 20:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F4B81C22B99
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 19:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB4E18564C;
	Wed,  7 Feb 2024 19:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GZZGGVl+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13513433B4
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 19:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707334660; cv=none; b=B/mReMMEkkXshjcBKNKLMYrU6ob1vAv/wZV43ibEUsyzoGktN4YDZWd0Duj/yWiut47oV0dPsdEhYeZWMyp07Jb4pa6Q42hRGrS4vEd07oJhJx3upMF8WT7CpSvtXvs5RfMYho4pciHcwzxUi4odJscTSSf49Qqi1ddbeBfsJK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707334660; c=relaxed/simple;
	bh=QD8tesKlWVdthCFD3iM/Al74RxchI56HAuM8c3eqKPo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=t+wPaHQz4Z9hgRTwEofeCt/+rOvUBqYBvPoNPKzyedebdwAjKf9utB50fJTsaWPW3n4Pz4pmtQULWJUQvQ91GwsVSwLxDOZtzKV9rdw48mZcs/fBRmcwk90fY4fmKoY7LqcUPiqATUw/8cCumo62YTId7Noh7oI0x8IUQ/1hPAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GZZGGVl+; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a271a28aeb4so130186566b.2
        for <netdev@vger.kernel.org>; Wed, 07 Feb 2024 11:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707334657; x=1707939457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+tSAsZLExBYg18QmQGhOIxY/UPSUHmg7JW4JuYsH+7k=;
        b=GZZGGVl+dCv77ToSpxrF+Ig3vPgdlmav7oT/IqTtznIORjEkFEco71UOLAduLtP2tW
         2Bqh5LWmcEhpstLq6zSzrRlqX3WRG5XuZFgFnHtIqYNKkQ75Xv2zAy+cpVglYjfAL11k
         lE/T48rsDvz/bNyap41Us34CsE3wFLCpGbqagqLwM5m6h8JDNho1b/vFSFxoJ9UqzShx
         gifmUgQXvZgBx7f9crdzMeexTssy8ajI/6lN9pIY8ruzhKHBvs3DLc5k9exhF6boBo5K
         KfJQuAK14ZVUePI0TMG8GRVPUN58ijKSEjSxZLOwy1AXj1n9znRcbX4nFoWs1t2dk5CU
         jOyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707334657; x=1707939457;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+tSAsZLExBYg18QmQGhOIxY/UPSUHmg7JW4JuYsH+7k=;
        b=q1Tgx+19TWcqrsaa2spox6l0G/h2wVcydrPoc8fPcQwaU2FpNTUAVev9kuamFYTMCp
         1Hkmy/xPEjRVUchwf0G7zqC0v+tHYj2TgdTvDxgSHbJFB9E4zF3n2pnKUZJ/xCWvByC2
         /y86YsmEbYRzmnpzdW6YuwatjW+yuUl/vH1XB8FocoVyPNmlNCGqgFIGAuDqlCx4oDAX
         H+ctLlZgfRSKxXO/4Xf9cv75PjvSOTlQihwejd4SFDm14TBJhuWW+FPf7gYmK5Pmw5xi
         pWZSuzSy45hEBNSFLZvxvfsB8MrnqL+z7ZxCKoGVSfGw3cKmX5bCWkoKbICBb60m1kAB
         sQjA==
X-Gm-Message-State: AOJu0YyYac5A31nBnKV6XzMS2nkJ1MEGJCp0TiqwBNe6m4BvZCVa1vM5
	m8GehN8ZMMBzzu/uC2FbW2QA18m5ZjRjCEIiYqp+SIf4MPZJDK1zqauoOspx
X-Google-Smtp-Source: AGHT+IHRUrdxrUZfpWcSER7zY7F37W0Ys88h9Vk33TyR3wGFzYUuymQDpMMFc85FB/nog+4MTOMb6g==
X-Received: by 2002:a17:906:2b53:b0:a38:6454:f821 with SMTP id b19-20020a1709062b5300b00a386454f821mr2553554ejg.68.1707334656639;
        Wed, 07 Feb 2024 11:37:36 -0800 (PST)
Received: from localhost.localdomain (178-164-213-103.pool.digikabel.hu. [178.164.213.103])
        by smtp.gmail.com with ESMTPSA id vw1-20020a170907a70100b00a3896ef417dsm483815ejc.180.2024.02.07.11.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 11:37:35 -0800 (PST)
From: Balazs Scheidler <bazsi77@gmail.com>
X-Google-Original-From: Balazs Scheidler <balazs.scheidler@axoflow.com>
To: netdev@vger.kernel.org
Cc: Balazs Scheidler <balazs.scheidler@axoflow.com>
Subject: [RFC net-next 0/2] Add IP/port information to UDP drop tracepoint
Date: Wed,  7 Feb 2024 20:37:14 +0100
Message-Id: <cover.1707334523.git.balazs.scheidler@axoflow.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

In our use-case we would like to recover the properties of dropped UDP
packets. Unfortunately the current udp_fail_queue_rcv_skb tracepoint
only exposes the port number of the receiving socket.

This patch-set will add the source/dest ip/port to the tracepoint, while 
keeping the socket's local port as well for compatibility with previous users
of the tracepoint.

Balazs Scheidler (2):
  net: port TP_STORE_ADDR_PORTS_SKB macro to be tcp/udp independent
  net: udp: add IP/port data to the tracepoint
    udp/udp_fail_queue_rcv_skb

 include/trace/events/net_probe_common.h | 41 ++++++++++++++++++++++
 include/trace/events/tcp.h              | 45 ++-----------------------
 include/trace/events/udp.h              | 33 +++++++++++++++---
 net/ipv4/udp.c                          |  2 +-
 net/ipv6/udp.c                          |  3 +-
 5 files changed, 75 insertions(+), 49 deletions(-)

-- 
2.40.1


