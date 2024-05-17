Return-Path: <netdev+bounces-96919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A118C8334
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 11:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC007282660
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 09:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93DE1EB36;
	Fri, 17 May 2024 09:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="nXtcsZ96"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CA320313
	for <netdev@vger.kernel.org>; Fri, 17 May 2024 09:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715937790; cv=none; b=n7uWi1OhZFjoxbqN1FBiaivyAIkGujUqUJ8kXVuZPrppmODwzEATh779qqmPu8g9OBmzauoSpmUdK9zOjnNC+E8cT3JX2C82+tyD2w21zhmZ5DdYQvT07GTlCS7B3UvorXJSBWSYJwfu2iRz3kidp8z7ga7305n528ROSLQf+Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715937790; c=relaxed/simple;
	bh=ZoQ4JqUZ2GPYyqakX6Qw4SGFqIe8YQSjQBRjmd9I7Wk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sv8Xs/d/6IuhVqIeMBEzdq70FLXG+kEfD6bubCBKq0cjboP7nU/ihQ+SAkySOokKeI6u9YeJEKxU2oGPQhmHQdpx76zOkSW5DumPQknEC+R/FnUVcEs4yMxWEJwzWy9Er48l1RWiNlyuW/HHDnFQLyiX05jupCGIzlrxzcKLhqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=nXtcsZ96; arc=none smtp.client-ip=207.171.188.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1715937789; x=1747473789;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Q5MlM5j8uG26alKvnRIBWo9Y3iGHnRmkxgLO97N0994=;
  b=nXtcsZ96akOVKQa28lEGhO7WgIcd+uTbGT9K7rmqeAVlkpZ0nke/Z5BP
   u3VfvTT8osJmOmCzXhKkOgnwWCFXaBHAGngN+xz1JFwFM4Wdd8su7xXkL
   8rWtYJmMujZIWMM93kNHW1susUA+VHt3Xn927smgZMVOCSeQ/+qRNIVH8
   Q=;
X-IronPort-AV: E=Sophos;i="6.08,167,1712620800"; 
   d="scan'208";a="727039422"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 09:23:03 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:7577]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.21.228:2525] with esmtp (Farcaster)
 id 35c8b3d5-0af6-4406-90a5-3b2c8a069c06; Fri, 17 May 2024 09:23:03 +0000 (UTC)
X-Farcaster-Flow-ID: 35c8b3d5-0af6-4406-90a5-3b2c8a069c06
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 17 May 2024 09:23:03 +0000
Received: from 88665a182662.ant.amazon.com.com (10.119.6.241) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.28;
 Fri, 17 May 2024 09:22:59 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <mhal@rbox.co>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<shuah@kernel.org>
Subject: Re: [PATCH net v2 1/2] af_unix: Fix garbage collection of embryos carrying OOB with SCM_RIGHTS
Date: Fri, 17 May 2024 18:22:50 +0900
Message-ID: <20240517092250.33314-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <c0fc4799-ee57-45dc-b13b-0be4711b5cf2@rbox.co>
References: <c0fc4799-ee57-45dc-b13b-0be4711b5cf2@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWB002.ant.amazon.com (10.13.138.121) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Michal Luczaj <mhal@rbox.co>
Date: Fri, 17 May 2024 10:55:53 +0200
> On 5/17/24 09:47, Kuniyuki Iwashima wrote:
> > From: Michal Luczaj <mhal@rbox.co>
> > Date: Fri, 17 May 2024 07:59:16 +0200
> >> One question: git send-email automatically adds my Signed-off-by to your
> >> patch (patch 2/2 in this series). Should I leave it that way?
> > 
> > SOB is usually added by someone who changed the diff or merged it.
> > 
> > I think it would be better not to add it if not intended.  At least
> > on my laptop, it does not add SOB automatically.
> 
> Sure, I understand. And the problem was that I had format.signOff = true in
> .gitconfig. Fixed.
> 
> > FWIW, my command is like
> > 
> >   git send-email --annotate --cover-letter --thread --no-chain-reply-to \
> >   --subject-prefix "PATCH v1 net-next" \
> 
> maintainer-netdev.rst shows an example with a slightly different order:
> "[PATCH net-next v3]". But I guess it doesn't matter?

It seems patchwork can parse either format. ("net,vX" and "vX,net")

https://patchwork.kernel.org/project/netdevbpf/list/

