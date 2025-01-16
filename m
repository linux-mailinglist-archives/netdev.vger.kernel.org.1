Return-Path: <netdev+bounces-158744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 277A4A131E4
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 05:09:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 942F83A12AA
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 04:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F72137932;
	Thu, 16 Jan 2025 04:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="iONjz8XW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC87E555
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 04:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737000592; cv=none; b=oaZ6M6GtNJFrhlAqSLe2hTQjUlhnQumHvLJi/e7jgW98guYswVK6tYsSi+0bkMnveqCUuRdvDg6elEG0i4P4vebeqjRyBiqEbM83UKjhZFE1mvK23BRTeg9Z6SJqJhDDVGsdhWh/RLgLkcOy/0vYTn21XayoJjp8kp+WaX6MO8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737000592; c=relaxed/simple;
	bh=cQKzpfXlvieT3WmbrvvHFfNbVP1Ga/EXQB4MVZUvxBs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mz4Vrz8/y8qHOUksqxdKmPSl5oGL7AdKpjurNWFDx6m/T3MWXQnY6HanvXP84es9gExKswPT5vzDY14OrrkjLbIiFxczsd+FUU/sDQ35cp6Mc4IvKGH8mREuYxbVOwl2LeeaxN8dxLf/KN3jMxy87fNg3fumlnT/VlIy6zbbfs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=iONjz8XW; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1737000591; x=1768536591;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dZ67Y5OrleyP1+4XyR5naRI2nsMgMaqU77PyXtsxXvM=;
  b=iONjz8XW53oTUa0dQ+R9Z96nD1PLi8Ay/6Kpmmcs2kgs/kglWBV0kKcz
   Og8Xdk9O4fr4Drc3WLRZQsJI/m8zqug3/eqpuGYL0PKWUaAHsynv2odlo
   hmc0+S15h2wUesilNnYpddY8iXxTHGmmsY4f/IZiRFvPxiMLed6BWLenB
   g=;
X-IronPort-AV: E=Sophos;i="6.13,208,1732579200"; 
   d="scan'208";a="459193436"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 04:09:47 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:37568]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.27.193:2525] with esmtp (Farcaster)
 id 39e13d26-8c6f-482e-aa0e-6f38b7b4c608; Thu, 16 Jan 2025 04:09:46 +0000 (UTC)
X-Farcaster-Flow-ID: 39e13d26-8c6f-482e-aa0e-6f38b7b4c608
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Thu, 16 Jan 2025 04:09:45 +0000
Received: from 6c7e67c6786f.amazon.com (10.143.84.222) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Thu, 16 Jan 2025 04:09:41 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <pabeni@redhat.com>
CC: <davem@davemloft.net>, <donald.hunter@redhat.com>, <edumazet@google.com>,
	<horms@kernel.org>, <kuba@kernel.org>, <kuni1840@gmail.com>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>
Subject: Re: [PATCH v2 net-next 06/11] af_unix: Set drop reason in unix_stream_sendmsg().
Date: Thu, 16 Jan 2025 13:09:32 +0900
Message-ID: <20250116040932.96265-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <eb30b164-7f86-46bf-a5d3-0f8bda5e9398@redhat.com>
References: <eb30b164-7f86-46bf-a5d3-0f8bda5e9398@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWA001.ant.amazon.com (10.13.139.92) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Paolo Abeni <pabeni@redhat.com>
Date: Wed, 15 Jan 2025 16:12:59 +0100
> On 1/15/25 2:52 PM, Donald Hunter wrote:
> > On Tue, 14 Jan 2025 at 20:05, Jakub Kicinski <kuba@kernel.org> wrote:
> >>
> >> On Sun, 12 Jan 2025 13:08:05 +0900 Kuniyuki Iwashima wrote:
> >>> @@ -2249,14 +2265,13 @@ static int queue_oob(struct socket *sock, struct msghdr *msg, struct sock *other
> >>>  static int unix_stream_sendmsg(struct socket *sock, struct msghdr *msg,
> >>>                              size_t len)
> >>>  {
> >>> +     enum skb_drop_reason reason;
> >>
> >> I feel like we should draw the line somewhere for the reason codes.
> >> We started with annotating packet drops in the stack, which are
> >> otherwise hard to notice, we don't even have counters for all of them.
> >> But at this point we're annotating sendmsg() errors? The fact we free
> >> an skb on the error path seems rather coincidental for a sendmsg error.
> >> IOW aren't we moving from packet loss annotation into general tracing
> >> territory here?
> >>
> >> If there is no ambiguity and application will get an error from a system
> >> call I'd just use consume_skb().
> >>
> >> I'm probably the most resistant to the drop reason codes, so I defer
> >> to Paolo / Eric for the real judgment...
> > 
> > For what it's worth, I agree that there's no need to annotate a drop
> > reason for sendmsg failures that return error codes to the caller.
> > That's why my original patch proposal just changed them to use
> > consume_skb(). I did misrepresent the cases as "happy path" but I
> > really meant that from the perspective of "no send initiated, so no
> > drop reason".
> > 
> > https://lore.kernel.org/netdev/20241116094236.28786-1-donald.hunter@gmail.com/
> 
> I also agree with Jakub with a slightly different reasoning. IMHO drop
> reason goal is to let user-space easily understand where/why skbs are
> dropped. If the drop reason reflects a syscall error code, the
> user-space already has all the info.
> 
> IIRC the general guidance agreed upon in the last Netconf was to add
> drop reasons when we can't distinguish multiple kind of drops within the
> same function. IMHO such guidance fits with not using drop reason in
> this specific case: as said we can discriminate the errors via the
> syscall error code.

Thanks for the feedback, all!

I'll change kfree_skb() to consume_skb() in

  * unix_stream_connect()
  * unix_stream_sendmsg()
  * queue_oob()
  * unix_dgram_sendmsg()

where we can distinguish what happened from errno.

