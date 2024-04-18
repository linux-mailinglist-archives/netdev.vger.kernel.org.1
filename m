Return-Path: <netdev+bounces-89343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 758B88AA14F
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 19:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 909361C209F7
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 17:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD890175564;
	Thu, 18 Apr 2024 17:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="V8XaVnsZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3694D1442F4
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 17:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713462293; cv=none; b=q/8bxg8DSDp/nKIEgijckZDfzA1r+4aFEC1Jx1k/gvVISPs+BPIQQSQ0nirtrKJHOyJ4feWFSTHhLu3yKSYystsqpHvcz1aJyPH+x30LvEUzSgxK7cl/7KPc5EYg5RjdcNFpRA/NHFXO6w74tIh4cSrRcf3JjTmbmpGh/sA9Xjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713462293; c=relaxed/simple;
	bh=U+0Rv4+JR3cnVkb1K6S8qf7lnkOF5/Xx0cj4fnFNV+A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LT1Fcd4cjXR2eYN9N037DGispRIZRGIgFGFZLVXAMizNAKqwPzOUf1nohuAByqp7+gu52vRx1wQIw14OjsDm58JpYIANIRuP8SGyMYWoFcOVdVAxB1CqSqQJWSOFW+nRZcyUGnbMBBg+tab8rt05AMVOTtyN/wAbPt2oeJVcYzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=V8XaVnsZ; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1713462292; x=1744998292;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Dp1dSHNNXNO050ZhCgayZG188r9JGRX+7+7a/X4Pmcg=;
  b=V8XaVnsZ70EOORHYcIfNKrd8/r2UWTxqd5Lxk4N2i3esJGmKwAIpp/u4
   56fwZn2G7XZTCxBGT7595rT8NwrG06kGYRQRmpxfHp/q4aoJAaU5XDjw2
   24giNGzSRV4c/WzBw96q5700gr0DvIAGpWAZfHC5YFYgFgHhkjtDdCGH/
   Y=;
X-IronPort-AV: E=Sophos;i="6.07,212,1708387200"; 
   d="scan'208";a="82559508"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 17:44:48 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:37312]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.19.15:2525] with esmtp (Farcaster)
 id 429ba44a-3643-4481-bd7b-e761862e71b2; Thu, 18 Apr 2024 17:44:48 +0000 (UTC)
X-Farcaster-Flow-ID: 429ba44a-3643-4481-bd7b-e761862e71b2
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 18 Apr 2024 17:44:48 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.33) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 18 Apr 2024 17:44:46 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <bob.mcmahon@broadcom.com>
CC: <netdev@vger.kernel.org>, <kuniyu@amazon.com>
Subject: Re: UDP recvfrom/recv question on connected/unconnected sockets
Date: Thu, 18 Apr 2024 10:44:37 -0700
Message-ID: <20240418174437.26662-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <CAHb6LvpdHujbScC1YrVnwM5Nfp_HaSn1EAnT2eY87ZCWgXQ88w@mail.gmail.com>
References: <CAHb6LvpdHujbScC1YrVnwM5Nfp_HaSn1EAnT2eY87ZCWgXQ88w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWA003.ant.amazon.com (10.13.139.18) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Bob McMahon <bob.mcmahon@broadcom.com>
Date: Thu, 18 Apr 2024 10:07:51 -0700
> Hi All,
> 
> I have a question about the OS routing UDP packets to threads and connect
> vs unconnected sockets. Same src/dst IP and same dst port, different src
> port.
> 
> If there are two UDP sockets listening on the same port, each serviced by
> its own thread and they both hang a recvfrom() or recv() (for the connected
> socket,) will the OS route packets only to the thread with a connected
> socket vs the thread with th unconnected socket? If not, what will happen?

Connected sockets receive packets matching 4-tuple, and unconnected sockets
receive packets that no connected socket matches.

  $ python3
  >>> from socket import *
  >>> 
  >>> s1 = socket(AF_INET, SOCK_DGRAM)
  >>> s1.setsockopt(SOL_SOCKET, SO_REUSEADDR, 1)
  >>> s1.bind(('0', 0))
  >>> 
  >>> s2 = socket(AF_INET, SOCK_DGRAM)
  >>> s2.setsockopt(SOL_SOCKET, SO_REUSEADDR, 1)
  >>> s2.bind(s1.getsockname())
  >>> 
  >>> s1.connect(('10.0.0.53', 8000))
  >>> s1
  <socket.socket fd=3, family=AddressFamily.AF_INET, type=SocketKind.SOCK_DGRAM, proto=0, laddr=('10.0.0.53', 28947), raddr=('10.0.0.53', 8000)>
  >>> s2
  <socket.socket fd=4, family=AddressFamily.AF_INET, type=SocketKind.SOCK_DGRAM, proto=0, laddr=('0.0.0.0', 28947)>
  >>> 
  >>> s3 = socket(AF_INET, SOCK_DGRAM)
  >>> s3.bind(('10.0.0.53', 8000))
  >>> 
  >>> s4 = socket(AF_INET, SOCK_DGRAM)
  >>> s4.bind(('10.0.0.53', 8080))
  >>> 
  >>> s3.sendto(b'hello', s1.getsockname())
  5
  >>> s4.sendto(b'world', s1.getsockname())
  5
  >>> 
  >>> s1.recv(10)
  b'hello'
  >>> s2.recv(10)
  b'world'

Then, if you create a new unconnected socket, the old unconnected socket will
no longer receive packets until the new one is close()d.

  >>> s5 = socket(AF_INET, SOCK_DGRAM)
  >>> s5.setsockopt(SOL_SOCKET, SO_REUSEADDR, 1)
  >>> s5.bind(s1.getsockname())
  >>> 
  >>> s4.sendto(b'test', s1.getsockname())
  4
  >>> s2.recv(10)
  ^CTraceback (most recent call last):
    File "<stdin>", line 1, in <module>
  KeyboardInterrupt
  >>> s5.recv(10)
  b'test'

SO_REUSEADDR allows the newer socket to take over the port from the old
ones.

If you want to blance the loads across unconnected sockets, use SO_REUSPORT
instead.

