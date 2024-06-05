Return-Path: <netdev+bounces-101102-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8455C8FD5C0
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 20:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 878391C22F1D
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 18:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A31E262BE;
	Wed,  5 Jun 2024 18:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="FGydnf1i"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A885A5228
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 18:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717612160; cv=none; b=XTwqqxnZ/HFvmHTwGppXXpP0ptwookz4oiBIR0eqBsNmPYqaCBaGyPy48sBI4qpYR337fwkSN+90XQQJbqi5QiLAxAt/QLQg3VI/Wdnj3zr5/10onbxxlLQrTLP2cBx5N54TAw9/BEVQB4Kc831fbyk7VDKTlXHuU0R9HdImmwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717612160; c=relaxed/simple;
	bh=gQtVV8XEg8vV8Gl1Maj8rbsf1txOJE609r/QQqVZmxY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kISLIVYC9S8n78i1IAQlem0oRIb4DqvcO24F0aOdiIVlOBH3ow6glAD3/8n26BJ980NDkSwONsw+drHObOlPs0+Fvml/cZtXv3IvHDCTnnY7wRhDotvO0aFYPbs/++pKkwCbNqE7O/5C1yDxiMWOI3HOxvqUVPpl618ThwUnPjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=FGydnf1i; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1717612160; x=1749148160;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qQJY+DabluqbIgX7j5WkTRCW2O7eqgJRj7jLWtKSZ1c=;
  b=FGydnf1i4Bc1wuOEuCHj/J8Gz62S7LVa1nnfkyDkZ/J+zz5y7XB1hYgf
   2BG2pbr60NNXKIf6Vv7inT6KsjLaXgLXdZCPS1AjlTZqdnwlndtaak6RY
   59KeELR4uoErkO5VfXuz2bckw8C2Q6D4kwHnyASppF9kmez/RPaQ+UDT+
   Y=;
X-IronPort-AV: E=Sophos;i="6.08,217,1712620800"; 
   d="scan'208";a="424194977"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 18:29:15 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:2938]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.23.252:2525] with esmtp (Farcaster)
 id 2d3535a7-d1f5-4f3d-ad44-76b7e7b22f23; Wed, 5 Jun 2024 18:29:13 +0000 (UTC)
X-Farcaster-Flow-ID: 2d3535a7-d1f5-4f3d-ad44-76b7e7b22f23
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Wed, 5 Jun 2024 18:29:13 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.24) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Wed, 5 Jun 2024 18:29:10 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <eric.dumazet@gmail.com>, <kuba@kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, Kuniyuki Iwashima
	<kuniyu@amazon.com>
Subject: Re: [PATCH net-next 1/3] tcp: small changes in reqsk_put() and reqsk_free()
Date: Wed, 5 Jun 2024 11:29:01 -0700
Message-ID: <20240605182901.27344-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240605071553.1365557-2-edumazet@google.com>
References: <20240605071553.1365557-2-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWB003.ant.amazon.com (10.13.138.8) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Date: Wed,  5 Jun 2024 07:15:51 +0000
From: Eric Dumazet <edumazet@google.com>
> In reqsk_free(), use DEBUG_NET_WARN_ON_ONCE()
> instead of WARN_ON_ONCE() for a condition which never fired.
> 
> In reqsk_put() directly call __reqsk_free(), there is no
> point checking rsk_refcnt again right after a transition to zero.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

