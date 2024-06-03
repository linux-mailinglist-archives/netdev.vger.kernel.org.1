Return-Path: <netdev+bounces-100304-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6646E8D8756
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 18:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2162F2895F1
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 16:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02FD512FF76;
	Mon,  3 Jun 2024 16:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Klhwk9nl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2CE6A031
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 16:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717432361; cv=none; b=bgRztW9ufLj8ojbP+Vx4K0AgV2QfVrWqA71lRdzwHxd/6DTJ3nKEhWvLX7zLfx9ijF5+dpAq5QwieCTcVIXd+nieIpgIKO8TkFdn7e3rB2SqONCTeVfvlDfr1EXM9sFv9xANy1adN/xt7nBrh1M1lrpDEt0Nr/ZEWV6Gqz3IHjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717432361; c=relaxed/simple;
	bh=IqLqspOHTl8hgSiM2prJnhvO55WUO3JHIBjl0LsKXT0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d0/rr9TMngSkg84GrVGOeVeIbsLgnkiknuJPQBuM/zi/8WbaR5ShuWGbfbo2Pp161Klpm8ZPTux1OybICV6OULFSY4YafzqM619MdAWDGxXhX7C5iBUPXtrY19uqs9oARV5WtM9Mp34bU3rkhWLKl58CPi30HycN4k2eP3FCFWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Klhwk9nl; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1717432361; x=1748968361;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0aTdtecEtokYI6tbmTy/VuHpW6bFvedj8rHlf72UyZY=;
  b=Klhwk9nlUnrOayFGyeu2XVbs2x2g+a/9HY0zN9gJuJq+nK16DT/AdSR3
   yu6s6sr4Hyl/ij9+4jgM7UWtelNRTCcmqt5IX+AdDWi5CFyVnmu8nsJOD
   MkXI1h3XYd7KrVHuiQecpgdB8CvLhWuRKEVfAj2hcKuMIFEcsQb9/QEQE
   8=;
X-IronPort-AV: E=Sophos;i="6.08,212,1712620800"; 
   d="scan'208";a="730126360"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 16:32:35 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:21409]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.35.105:2525] with esmtp (Farcaster)
 id b8b1c8bf-8ed4-4709-a366-835eda28084c; Mon, 3 Jun 2024 16:32:17 +0000 (UTC)
X-Farcaster-Flow-ID: b8b1c8bf-8ed4-4709-a366-835eda28084c
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 3 Jun 2024 16:32:17 +0000
Received: from 88665a182662.ant.amazon.com (10.88.143.104) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 3 Jun 2024 16:32:14 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <xiyou.wangcong@gmail.com>
CC: <cong.wang@bytedance.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <kuni1840@gmail.com>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH v1 net 01/15] af_unix: Set sk->sk_state under unix_state_lock() for truly disconencted peer.
Date: Mon, 3 Jun 2024 09:32:05 -0700
Message-ID: <20240603163205.84412-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <Zl3utZZF/Sa7OnAj@pop-os.localdomain>
References: <Zl3utZZF/Sa7OnAj@pop-os.localdomain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWC001.ant.amazon.com (10.13.139.233) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Mon, 3 Jun 2024 09:26:29 -0700
> On Mon, Jun 03, 2024 at 07:32:17AM -0700, Kuniyuki Iwashima wrote:
> > -		if (other != old_peer)
> > +		if (other != old_peer) {
> >  			unix_dgram_disconnected(sk, old_peer);
> > +
> > +			unix_state_lock(old_peer);
> > +			if (!unix_peer(old_peer))
> > +				WRITE_ONCE(old_peer->sk_state, TCP_CLOSE);
> > +			unix_state_lock(old_peer);
> 
> lock() old_peer twice? Has it been tested? ;-)B

Ugh, apparently no :S  (compile-test only)

Should've run the same command in the changelog.
Will fix in v2.

Thanks!

