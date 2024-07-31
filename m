Return-Path: <netdev+bounces-114656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC349435B5
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 20:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A7742850DF
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 18:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744BC45C14;
	Wed, 31 Jul 2024 18:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="GjmVS3Sw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF22381AD
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 18:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722451166; cv=none; b=uaJI5KPqLLfNxpnpB9GSOXsLAmXKYnI7mjbbi1FrZjr6C3pt0URvX6fMRysv9m3JtpKCxtBmxMlvlYgbfU7xrp5wJ3iFzfJgZ9vyAFeyBzo8qOkwbNeKhFCKitiU8YtJTSQW/uZj8+zTJ5nL6okOny5PluRlJbUg9rIKvvjo9Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722451166; c=relaxed/simple;
	bh=yN3uLr/0mFbkRwI3WVs97/Vht3kCBx9SNgLetUBmDxE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MrMouOaHD1YXt7Q6HQqgbeq9sdjqFAa/95EgwYIvOh5eYBPT7sTug0MPXtlGdiiejJ9LMeOgL9GjTd162jy1dzzTG8A3ifpndp8pc0JWhD3tAaaux/Pwq4gVvKe3hB0FuFNnO9s2oeFJKmiWECEbR+B/6MM7yxkX/3BTVP+RI/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=GjmVS3Sw; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1722451165; x=1753987165;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iS//K2CQ6tU55QB4EpB5rfIFo0OFQhh7MybKHXOWLlc=;
  b=GjmVS3SwgKDD04Tydh+xGW697SZKyrv19mFBckz2rBuYhQjrmzd0FRaf
   +Y4C/Ln51K+Ym4E+t9YksXPH0QDjGUCL/7puYAEkOqRbgvcYyReaY87P6
   jtcYiUwczKFBwKTwKyLU9MiXKgYLLFjHfPMdqb+O3EbqWANevV2C6YLov
   k=;
X-IronPort-AV: E=Sophos;i="6.09,251,1716249600"; 
   d="scan'208";a="418519443"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 18:39:22 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.38.20:1962]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.3.107:2525] with esmtp (Farcaster)
 id 24c3b365-b97f-4653-a77e-f7517655d667; Wed, 31 Jul 2024 18:39:20 +0000 (UTC)
X-Farcaster-Flow-ID: 24c3b365-b97f-4653-a77e-f7517655d667
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 31 Jul 2024 18:39:20 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.100.32) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 31 Jul 2024 18:39:17 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <horms@kernel.org>,
	<jchapman@katalix.com>, <kuni1840@gmail.com>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH v1 net-next 1/6] l2tp: Don't assign net->gen->ptr[] for pppol2tp_net_ops.
Date: Wed, 31 Jul 2024 11:39:08 -0700
Message-ID: <20240731183908.49471-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240730185219.5df78a5b@kernel.org>
References: <20240730185219.5df78a5b@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWC001.ant.amazon.com (10.13.139.218) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jakub Kicinski <kuba@kernel.org>
Date: Tue, 30 Jul 2024 18:52:19 -0700
> On Mon, 29 Jul 2024 14:07:56 -0700 Kuniyuki Iwashima wrote:
> > Fixes: fd558d186df2 ("l2tp: Split pppol2tp patch into separate l2tp and ppp parts")
> 
> pourquoi the Fixes tag? 

Ah, forgot to remove it.
Will remove it in v2.

Merci!

P.S. TIL pourquoi :)

