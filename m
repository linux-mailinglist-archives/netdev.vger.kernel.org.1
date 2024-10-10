Return-Path: <netdev+bounces-133975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0661C99797B
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 02:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EE90B212CD
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 00:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8234517E;
	Thu, 10 Oct 2024 00:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="UzLcK3nr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115AF623
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 00:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.190.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728518752; cv=none; b=NsUe6yNiM0klAwfnPW435KBX7FjnTeKMHHzL5QaeC6hcgBeTc+XSS5eRXU7y1mv5+xxpla9/dxPomaeGfj0pailYJ5dnU6ZYO22vUWh5PZ1ctzfgzug6KT2JNcDpRt3/1Ewd2Fg9D7h+Acqu/ql/BtyCTzv1W/S0Ig1HmnbeLBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728518752; c=relaxed/simple;
	bh=u3Y2+rtzHLzkRHFW44hHdeJede2d7FiQGE2jB3tAkqQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UktN3yGJZOrG2dahafffB22gzVIQ/sDmtLWdzrbYnkmb6zKDgrx0ndfp3sMumvQPproZxbyyDImvN7ljrrKub2ctWP+Z1VWR9EJSzXMSgspP66eFtIvnJRm8josqa2URt6EqGMsgeGNaueF6G91GZwtWRG+DNvI8bqnpMYtBzWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=UzLcK3nr; arc=none smtp.client-ip=207.171.190.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728518751; x=1760054751;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9sQfMUtARuFKxBQtEKXXjtI8F9kVpSZMj2GDSVj+Wbk=;
  b=UzLcK3nr42rniz1p/X8lisU7P0D7hguLp8owFwkueOpVfCk1UgTcWis4
   ki9i0VGkJDvsW/uy04bPdatHzDY6HgVW9ZGP3WrgwxmJ1M6+O6lEtvUVy
   Cn5mI0mUOZ92JwU7sSNfC5j4owaerak7mDEDHGD/sbkrHveayxphUxRzG
   E=;
X-IronPort-AV: E=Sophos;i="6.11,191,1725321600"; 
   d="scan'208";a="374835478"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 00:05:50 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:60899]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.37.107:2525] with esmtp (Farcaster)
 id 55d03382-1d95-4fd0-9152-6c8d00231688; Thu, 10 Oct 2024 00:05:50 +0000 (UTC)
X-Farcaster-Flow-ID: 55d03382-1d95-4fd0-9152-6c8d00231688
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 10 Oct 2024 00:05:49 +0000
Received: from 6c7e67c6786f.amazon.com (10.187.170.17) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Thu, 10 Oct 2024 00:05:47 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <eric.dumazet@gmail.com>,
	<jiri@resnulli.us>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next 4/5] ipmr: use READ_ONCE() to read net->ipv[46].ipmr_seq
Date: Wed, 9 Oct 2024 17:05:36 -0700
Message-ID: <20241010000536.61815-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241009184405.3752829-5-edumazet@google.com>
References: <20241009184405.3752829-5-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWA001.ant.amazon.com (10.13.139.110) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Wed,  9 Oct 2024 18:44:04 +0000
> mr_call_vif_notifiers() and mr_call_mfc_notifiers() already
> uses WRITE_ONCE() on the write side.
> 
> Using RTNL to protect the reads seems a big hammer.
> 
> Constify 'struct net' argument of ip6mr_rules_seq_read()
> and ipmr_rules_seq_read().
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

