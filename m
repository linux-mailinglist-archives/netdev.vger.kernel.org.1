Return-Path: <netdev+bounces-114659-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E749435D1
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 20:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06B8E28552F
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 18:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E6F43169;
	Wed, 31 Jul 2024 18:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Fktr4fqY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9A74C634
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 18:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722451614; cv=none; b=RIEMI66VckBKEjbQqmxIsI+aOlTFepLrWRqLala/CgJGrnA85Cux2t1ryBvicfbHuXl1N9p2IvNBP5hkOCMNJ6AEmheowGgBwoKd1Yq8pZABRI6KGYqtzJU2xGG32l6IzzaNoHhW0tsBqhv33CHwsJ6p7U2DZ1OxWY/JUda774Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722451614; c=relaxed/simple;
	bh=qJySbphrYiYcImaHsthNmDFMrpXzwB98RK8w6wfGrN4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z4Bu24fX+svQGBWtEtaSKSXGypQGTpgdLCfxmwNPczpFXgwMtEnGrUbA/Da37I0oHi5643+6qG6Z9JvhWYQhsCdt7pbRKSD9OvHGNlgKEmH6MImnPrRYk5DDvL/eXE5olcznNaNE51GbVYScbQ6JbMdbYPFlx/n9wxTe4ccUx0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Fktr4fqY; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1722451612; x=1753987612;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dD81DsftO+Dtz6VZVTTtx1pQKS0nv0s0Fu62C7FAQTo=;
  b=Fktr4fqYtg7XOXjwRyBxsYDHh68WRaLjpfW/TcaiGSHiXCo7VP7GCpMS
   DIfC2ak/RkGGHilXpeZf5vIZ0RKXgzTtXoKUZtuZf/eOGRcDBDXEzxYA8
   0KuQp+S/Z03QBpKsSUDtuwO505Ja3c1zBpbeGkjf22S2soz2/udxYaBaU
   Q=;
X-IronPort-AV: E=Sophos;i="6.09,251,1716249600"; 
   d="scan'208";a="439869012"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 18:46:46 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:61957]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.36.228:2525] with esmtp (Farcaster)
 id 27fbce92-ee66-4f09-bd34-c4d7b7a9ddd7; Wed, 31 Jul 2024 18:46:46 +0000 (UTC)
X-Farcaster-Flow-ID: 27fbce92-ee66-4f09-bd34-c4d7b7a9ddd7
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 31 Jul 2024 18:46:39 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.100.32) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 31 Jul 2024 18:46:36 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuni1840@gmail.com>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH v1 net-next 0/6] net: Random cleanup for netns initialisation.
Date: Wed, 31 Jul 2024 11:46:28 -0700
Message-ID: <20240731184628.50198-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240730185234.45a87b6e@kernel.org>
References: <20240730185234.45a87b6e@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D032UWA004.ant.amazon.com (10.13.139.56) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jakub Kicinski <kuba@kernel.org>
Date: Tue, 30 Jul 2024 18:52:34 -0700
> On Mon, 29 Jul 2024 14:07:55 -0700 Kuniyuki Iwashima wrote:
> > do not reqruire pernet_ops_rwsem.
> 
> require

Aha, I should've used Grammarly even for short cover letter :)

will fix it.

Thanks!

