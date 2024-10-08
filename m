Return-Path: <netdev+bounces-133186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CCB7995424
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 18:12:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2CF9B28F86
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 16:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5CC1E0DA5;
	Tue,  8 Oct 2024 16:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="DzwISJwZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78D31DF73A
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 16:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728403949; cv=none; b=F87zqQt+GQNmUPGvmPrQfu8Ab2iLcfDIxIJRyDd+MfcyrrWY6q8XgfhX8wYm6zO6WI3DFOOBbEqG62d04xLdqk28/zOZeCdzJW0xccFoFVKavC43K8OeK64iZJ6i5RwGMHJX6VRoFcNjYneXSDu2RpHoniff38P/0nK+W5MLApA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728403949; c=relaxed/simple;
	bh=PwIBzBtCMxPX3gim1jb6wGk323exibSdhDQQEpL42Eg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kaPDkSoNEK3IhV6teweMdJDojxA6GK/3ZA/l5HDPEZyfdjZLv0uP0gMKQOSKCumcvTebsehDxX4UUsC9pxyjgWf0MBz/z4Yh97Ed3Xk+g/IAXfEUE01tr50g5PVihdt3UAEtcNI4nzSlbU3gV+IzLVACJFTxdYu3TM81/Blgdkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=DzwISJwZ; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728403947; x=1759939947;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iziHSwjODokZRjtqdI3f8BzpxmpJono3bEfemU2GgPc=;
  b=DzwISJwZOyCS9ZGJqiGWEzxp3lAKmhIiUcZA3zGlkX0g9y2eXRQPlK5Q
   nPf5C7JHyVmwDodZatddvD7xLgXeLNLYOPTjgAJIRA5uo+svP+e/cg078
   u2+Scy3O1ZY6Z5a99BR3ipy/CRBpralGzRd42kzYqNird8al+3lc/kQzP
   M=;
X-IronPort-AV: E=Sophos;i="6.11,187,1725321600"; 
   d="scan'208";a="237691525"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 16:12:23 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:29570]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.59.23:2525] with esmtp (Farcaster)
 id 4665a49c-323c-4bbe-8983-482abf0dcd9f; Tue, 8 Oct 2024 16:12:22 +0000 (UTC)
X-Farcaster-Flow-ID: 4665a49c-323c-4bbe-8983-482abf0dcd9f
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 8 Oct 2024 16:12:22 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.17) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Tue, 8 Oct 2024 16:12:20 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <pabeni@redhat.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<kuni1840@gmail.com>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>
Subject: Re: [PATCH v3 net-next 3/4] rtnetlink: Add assertion helpers for per-netns RTNL.
Date: Tue, 8 Oct 2024 09:12:11 -0700
Message-ID: <20241008161211.92974-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <9bb97d2c-878f-479a-b092-8e74893ebb2d@redhat.com>
References: <9bb97d2c-878f-479a-b092-8e74893ebb2d@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC003.ant.amazon.com (10.13.139.252) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Paolo Abeni <pabeni@redhat.com>
Date: Tue, 8 Oct 2024 13:39:24 +0200
> On 10/5/24 00:10, Kuniyuki Iwashima wrote:
> > Once an RTNL scope is converted with rtnl_net_lock(), we will replace
> > RTNL helper functions inside the scope with the following per-netns
> > alternatives:
> > 
> >    ASSERT_RTNL()           -> ASSERT_RTNL_NET(net)
> >    rcu_dereference_rtnl(p) -> rcu_dereference_rtnl_net(net, p)
> > 
> > Note that the per-netns helpers are equivalent to the conventional
> > helpers unless CONFIG_DEBUG_NET_SMALL_RTNL is enabled.
> > 
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> 
> I guess Kuniyuki stripped the ack received on v2 due to the edit here.
> 
> @Kuniyuki: in the next iterations, please include a per patch changelog 
> to simplify the review.

Sure, will include changelog per-patch basis for future submission.

Thanks!

