Return-Path: <netdev+bounces-51946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C24CF7FCC8D
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 03:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9F371C20CF7
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 02:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC731FB4;
	Wed, 29 Nov 2023 02:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="WhtOjgn9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58686172E
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 18:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1701223730; x=1732759730;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XiWz2DbNZ4BeWCloKUV/VcVrHh51uGaaFyh5EOXpJsw=;
  b=WhtOjgn9MMbtI7sMUxdwzezolaqHq/qqiwvRdcCnwVaYoC4PlKWO6PSj
   UY9tFrJRCDGLUlBqy0+OAoF9eZekMjU6LQHZynLVIKbvm2zdkwGvZ2ING
   smtCQp19K95yjuuJ5rLwK3Q27qtmgIoZ4+5kdjMsbQWZT9ktvxvX7rdx8
   I=;
X-IronPort-AV: E=Sophos;i="6.04,234,1695686400"; 
   d="scan'208";a="47013935"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-a65ebc6e.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 02:08:48 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan3.iad.amazon.com [10.32.235.38])
	by email-inbound-relay-iad-1e-m6i4x-a65ebc6e.us-east-1.amazon.com (Postfix) with ESMTPS id CC3486341C;
	Wed, 29 Nov 2023 02:08:45 +0000 (UTC)
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:23854]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.12.176:2525] with esmtp (Farcaster)
 id c6effffb-f1eb-4675-bf49-aef2857f3f5c; Wed, 29 Nov 2023 02:08:45 +0000 (UTC)
X-Farcaster-Flow-ID: c6effffb-f1eb-4675-bf49-aef2857f3f5c
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Wed, 29 Nov 2023 02:08:40 +0000
Received: from 88665a182662.ant.amazon.com (10.37.244.8) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 29 Nov 2023 02:08:36 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <pabeni@redhat.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <horms@kernel.org>,
	<kuba@kernel.org>, <kuni1840@gmail.com>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>
Subject: Re: [PATCH v2 net-next 8/8] tcp: Factorise cookie-dependent fields initialisation in cookie_v[46]_check()
Date: Tue, 28 Nov 2023 18:08:27 -0800
Message-ID: <20231129020827.94167-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <c656e270bec67c2d7c99c42249b8cc890bec22f9.camel@redhat.com>
References: <c656e270bec67c2d7c99c42249b8cc890bec22f9.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWA002.ant.amazon.com (10.13.139.96) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

From: Paolo Abeni <pabeni@redhat.com>
Date: Tue, 28 Nov 2023 11:34:56 +0100
> > @@ -245,7 +248,7 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
> >  				  dst_metric(dst, RTAX_INITRWND));
> >  
> >  	ireq->rcv_wscale = rcv_wscale;
> > -	ireq->ecn_ok = cookie_ecn_ok(&tcp_opt, net, dst);
> > +	ireq->ecn_ok &= cookie_ecn_ok(net, dst);
> 
> Nice cleanup! IMHO looks very good. But deserves Eric's explicit ack, I
> think ;)
> 
> The only question I have (out of sheer curiosity, no change requested
> here) is:
> 
> have you considered leaving the 'ecn_ok' initialization unchanged
> (looks a little cleaner as a single step init)? Is that for later's
> patch sake? (I haven't looked at them yet).

Yes, kfunc for bpf cookie validation will set ecn_ok bit first at the
tc hook, and then ecn_ok needs to be updated based on sysctl or dst.

https://lore.kernel.org/netdev/20231121184245.69569-11-kuniyu@amazon.com/

