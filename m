Return-Path: <netdev+bounces-89331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6B58AA0AC
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 19:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63DDF1F214AE
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 17:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D5015B117;
	Thu, 18 Apr 2024 17:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="jMkNg6eW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A4F15FA92
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 17:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713459749; cv=none; b=DrdRo348KITqWqrgUKcdMOb7P4SJ1GTVZjqcTXrciyG1kRboHGJuJtB504y2sLufdXzWCMEisD85j23WUTEMEwK9NjKdnuml4BHwE3bGf2h7cAEz6EODdKUQ8fl/t+TbpQOMUghLhsdvolVo0MB1euTrZLFWq+QICNP3VlPY9ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713459749; c=relaxed/simple;
	bh=RX3o28oTXZ3os0EIFFiqztAzjEJknxtM2ibLcV5CBBE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EvCFdO95vLgyTyDL0vUyTGXjofA/IXq3ud2MvVQ5OFoWPv4uKHWvlYO0AE46N3BkjgSnWYNfNTinuCVXYRCVxBBfinfT5ugO+SJozzuAbdql1l8qpGwz7XvMAsHAARLRhvT1bGEISLXU38tp2vc08H5E9rQZ+3TRQSPbUOnSpO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=jMkNg6eW; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1713459748; x=1744995748;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HaZTC6HJ1xGeOz0Y0Qp/ezMegV95yBFeV8li2c/59s0=;
  b=jMkNg6eWFrCY+a1NgyUArUoeTCCnyG6QKKfGtjlSEV3FW28HZAEISai8
   QA34XimuX1MF5hstnlhKjr5cb8x/kVoAXdwd1hBrs0jwe6+jIhSEIW4n5
   L5K2IokM15trAWu4EbaPGBVullW78YJO1ci785qyenIEzV/f3/csV1jcx
   g=;
X-IronPort-AV: E=Sophos;i="6.07,212,1708387200"; 
   d="scan'208";a="412724455"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 17:02:22 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.38.20:3605]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.46.15:2525] with esmtp (Farcaster)
 id bc4bbf8f-0340-4dec-af1a-59d8bdfc13c9; Thu, 18 Apr 2024 17:02:21 +0000 (UTC)
X-Farcaster-Flow-ID: bc4bbf8f-0340-4dec-af1a-59d8bdfc13c9
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 18 Apr 2024 17:02:21 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.33) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.28;
 Thu, 18 Apr 2024 17:02:17 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <pabeni@redhat.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<herbert@gondor.apana.org.au>, <kuba@kernel.org>, <kuni1840@gmail.com>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>,
	<steffen.klassert@secunet.com>, <syzkaller@googlegroups.com>,
	<willemb@google.com>
Subject: Re: [PATCH v1 net 1/5] sit: Pull header after checking skb->protocol in sit_tunnel_xmit().
Date: Thu, 18 Apr 2024 10:02:08 -0700
Message-ID: <20240418170208.23991-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <9fae6b381dccd6566b6366c7090468bea1f5e1d7.camel@redhat.com>
References: <9fae6b381dccd6566b6366c7090468bea1f5e1d7.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D045UWC001.ant.amazon.com (10.13.139.223) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Paolo Abeni <pabeni@redhat.com>
> On Thu, 2024-04-18 at 09:00 +0200, Eric Dumazet wrote:
> > On Thu, Apr 18, 2024 at 8:56 AM Eric Dumazet <edumazet@google.com> wrote:
> > > 
> > > On Thu, Apr 18, 2024 at 5:32 AM Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
> > > > 
> > > > From: Jakub Kicinski <kuba@kernel.org>
> > > > Date: Wed, 17 Apr 2024 19:04:32 -0700
> > > > > On Mon, 15 Apr 2024 15:20:37 -0700 Kuniyuki Iwashima wrote:
> > > > > > syzkaller crafted a GSO packet of ETH_P_8021AD + ETH_P_NSH and sent it
> > > > > > over sit0.
> > > > > > 
> > > > > > After nsh_gso_segment(), skb->data - skb->head was 138, on the other
> > > > > > hand, skb->network_header was 128.
> > > > > 
> > > > > is data offset > skb->network_header valid at this stage?
> > > > > Can't we drop these packets instead?
> > > > 
> > > > I think that needs another fix on the NSH side.
> > > > 
> > > > But even with that, we can still pass valid L2 skb to sit_tunnel_xmit()
> > > > and friends, and then we should just drop it there without calling
> > > > pskb_inet_may_pull() that should not be called for non-IP skb.
> > > 
> > > I dislike this patch series. I had this NSH bug for a while in my
> > > queue, the bug is in NSH.
> > > 
> > > Also I added skb_vlan_inet_prepare() recently for a similar issue.
> > 
> > Kuniyuki I am releasing the syzbot bug with a repro, if you have time to fix NSH
> > all your patches can go away I think.

Thanks for sharing the repro, Eric!

> 
> I agree a specific/smaller scope fix on in nsh should be preferred

Hmm.. I think the bug is both in NSH and the tunnel xmit
functions in this series.

geneve is in a bit differnt position because L2 skb is sane
for geneve, and it needs to inspect vlan and the upper layer.

However, L3 tunnels should validate skb->protocol first before
accessing skb->network_header, otherwise that could trigger KMSAN.

