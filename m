Return-Path: <netdev+bounces-119989-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B28B957C8F
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 06:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0A46283D96
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 04:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880642E634;
	Tue, 20 Aug 2024 04:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="H7pO2Oqp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE6CE541
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 04:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724129617; cv=none; b=BouAYeHks39ATz18qqI2PaE/ghXRU9LAqzKjFmYA8GTRQ98ILllOjirYKGuDbXcJBV21ziqOcaFquBDMQRK4mg7oXfDLQuPDpwLgoQn4qQyC4ImcuRx2fK/+SITpsEhfV5efBsvoLMXfoBhfM3NSW9tEMhoW5/njbTLWp7n5Tic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724129617; c=relaxed/simple;
	bh=MHGcARM6pG7VgUoD86sApglrP7nib28OePa6TD2leIw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NjiYmuEpKWccjxBOL7Vc1Tawmz1o4t308j7hYp2t69DY15/EVRf+9udCJgKew/GDDsGBqDKOcbpVv3CDsMg0aImqPENv9wiz0z+UC6nYF65GIBN72Hx2L6au21Ke0rB14AX7X14A+5Y1UlbcjDfNq497yc3ylavBdajE5EHbM2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=H7pO2Oqp; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1724129615; x=1755665615;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TMvNEV9lWOoRBGTdKwV7MphbOr084b5sVnXGFjRkMNM=;
  b=H7pO2Oqp+LDjRulvRnMGhYnVi4a0PsBPM1E8qXq4jeqQbxA42xgQFIKc
   bCD4cFQxB8V12roo4IwcIzycLPNue03DF3EsujO9x2MbCibtuIX6mXMAE
   YS3KZfHXzBHrCQA48S2i3MMqYKI6vBvLb5FkHGtS6lxGcwnByWRChvPMi
   Y=;
X-IronPort-AV: E=Sophos;i="6.10,161,1719878400"; 
   d="scan'208";a="653495107"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 04:53:32 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:60024]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.24.187:2525] with esmtp (Farcaster)
 id 61a10ba0-a232-4f28-a02e-2cfe35310eda; Tue, 20 Aug 2024 04:53:31 +0000 (UTC)
X-Farcaster-Flow-ID: 61a10ba0-a232-4f28-a02e-2cfe35310eda
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 20 Aug 2024 04:53:31 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.101.26) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 20 Aug 2024 04:53:28 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kerneljasonxing@gmail.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kernelxing@tencent.com>, <kuba@kernel.org>, <ncardwell@google.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <kuniyu@amazon.com>
Subject: Re: [PATCH net-next] tcp: change source port selection at bind() time
Date: Mon, 19 Aug 2024 21:53:19 -0700
Message-ID: <20240820045319.4134-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <CAL+tcoAJic7sWergDhVqAvLLu2tto+b7A8FU_pkwLhq=9qCE1w@mail.gmail.com>
References: <CAL+tcoAJic7sWergDhVqAvLLu2tto+b7A8FU_pkwLhq=9qCE1w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D036UWC001.ant.amazon.com (10.13.139.233) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 20 Aug 2024 08:53:53 +0800
> Hello Eric,
> 
> On Mon, Aug 19, 2024 at 11:45 PM Eric Dumazet <edumazet@google.com> wrote:
> >
> > On Fri, Aug 16, 2024 at 5:33 PM Jason Xing <kerneljasonxing@gmail.com> wrote:
> > >
> > > From: Jason Xing <kernelxing@tencent.com>
> > >
> > > This is a follow-up patch to an eariler commit 207184853dbd ("tcp/dccp:
> > > change source port selection at connect() time").
> > >
> > > This patch extends the use of IP_LOCAL_PORT_RANGE option, so that we
> > > don't need to iterate every two ports which means only favouring odd
> > > number like the old days before 2016, which can be good for some
> > > users who want to keep in consistency with IP_LOCAL_PORT_RANGE in
> > > connect().
> >
> > Except that bind() with a port reservation is not as common as a connect().
> > This is highly discouraged.
> >
> > See IP_BIND_ADDRESS_NO_PORT
> >
> > Can you provide a real use case ?
> >
> > I really feel like you are trying to push patches 'just because you can'...
> >
> > 'The old days' before 2016 were not very nice, we had P0 all the time
> > because of port exhaustion.
> > Since 2016 and IP_BIND_ADDRESS_NO_PORT I no longer have war rooms stories.
> 
> As you mentioned last night, the issues happening in connect() are
> relatively more than in bind().
> 
> To be more concise, I would like to state 3 points to see if they are valid:
> (1) Extending the option for bind() is the last puzzle of using an
> older algorithm for some users. Since we have one in connect(), how
> about adding it in bind() to provide for the people favouring the
> older algorithm.

Why do they want to use bind() to pick a random port in the first place ?

bind() behaviour is not strictly the same with connect(); the port reserved
by bind() is not reusable for connect().

Also, bind() requires SO_REUSEADDR to share a port, but by default, even
SO_REUSEADDR enabled sockets cannot share the same port if application
uses random-pick by bind((IP, 0)):

  # sysctl -w net.ipv4.ip_local_port_range="32768 32768"
  # python3
  >>> from socket import *
  >>> 
  >>> c1 = socket()
  >>> c1.setsockopt(SOL_SOCKET, SO_REUSEADDR, 1)
  >>> c1.bind(('', 0))
  >>> c1
  <socket.socket fd=4, family=AddressFamily.AF_INET, type=SocketKind.SOCK_STREAM, proto=0, laddr=('0.0.0.0', 32768)>
  >>> 
  >>> c2 = socket()
  >>> c2.setsockopt(SOL_SOCKET, SO_REUSEADDR, 1)
  >>> c2.bind(('', 0))
  Traceback (most recent call last):
    File "<stdin>", line 1, in <module>
  OSError: [Errno 98] Address already in use

Then, net.ipv4.ip_autobind_reuse needs to be enabled at some risk.

bind()+connect() simply decreases the number of available 4-tuple on
the netns unless all applications use bind()+connect() instead of just
connect(), and it's unlikely.


> (2) This patch will not hurt any users like in Google as an example
> which prefers odd/even port selection, which is, I admit, indeed more
> advanced.

Indeed, it won't hurt existing users but will lead new users to the
wrong way.


> (3) This patch does not come out of thin air, but from some users who I contact.
> ?

Is someone who contacted to you really aware of all of the above and
even then in favor of bind() without IP_BIND_ADDRESS_NO_PORT ?


> In my opinion, using and adjusting to the new algorithm needs some
> changes in applications. For some old applications, they still need
> more time to keep pace with a more workable solution.

They will add setsockopt(IP_LOCAL_PORT_RANGE) whether your patch is
applied or not, then, only thing they need to do is replace SO_REUSEADDR
with IP_BIND_ADDRESS_NO_PORT, simple enough ?


> After considering it a whole night, I would like to push this tiny
> feature into the upstream kernel, I wonder if you can help me review
> it? Thanks in advance, Eric.

