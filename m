Return-Path: <netdev+bounces-205021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A834AFCE0E
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 16:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9E774246F2
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 14:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B95F2E06FD;
	Tue,  8 Jul 2025 14:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GRCWCtUh"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB220226D0A
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 14:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751985899; cv=none; b=s+l0C8c8dauRBGgLVEKoEIV7Q4w1Vt0LutPcZqsKiiPpequ5vlCmorVmnQ0DLvV7tDSHgu7B5zAHV4oJ3ETc5OZN2zyng6rXz61y5D7cVIIUVYHToMNBNOfhm5Pvnf+YwURKDTnRfq1Sc+dhjBP3dcROT/z+z7fO4wtEJDoxxdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751985899; c=relaxed/simple;
	bh=TcDPvUHToLQm+qE1E4pCpm9KbQqVDU7Yt4W9UJNjcH8=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=ftqtLw64OLqZE/y7BtBg6jNlecdwhTVj9wGNdOb91ekTbgFEwJ2XJCjYPbUywr15BTLGlDQp0uycDuyAiXkD2fvPTJ8RVDL/YEwglirDmS9xpCeA6Z4RkeQTVditGAxBF6j1L/Zonch7AdJFVCYq11B6e7yS6o4xdFznafw9Kok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GRCWCtUh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751985896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xcTQlaxZHiwdLJ2cMTpNwOinGOe77WY04pTSRjm/G0I=;
	b=GRCWCtUhbqIqRiDkhwlkRk0VE3wyRzCNRByuu30ik74dQXFm9Iec5gQJYPjFKhjKJiN28r
	PgSGk8ocNBWvre8HAu+DYpxkZtD0iyg4s8t+KWBo13H7GZzSUv4d+LnFbCnq8VM6ScxvSO
	/d65wLQOZ59KSdOgOtqofisXothRVIU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-613-gcqhxnjcOCGariLGAkYUAQ-1; Tue,
 08 Jul 2025 10:44:53 -0400
X-MC-Unique: gcqhxnjcOCGariLGAkYUAQ-1
X-Mimecast-MFC-AGG-ID: gcqhxnjcOCGariLGAkYUAQ_1751985891
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6138A1808985;
	Tue,  8 Jul 2025 14:44:51 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.81])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9C07118002B6;
	Tue,  8 Jul 2025 14:44:47 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20250707054112.101081-1-jiayuan.chen@linux.dev>
References: <20250707054112.101081-1-jiayuan.chen@linux.dev>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: dhowells@redhat.com, netdev@vger.kernel.org, mrpre@163.com,
    syzbot+de6565462ab540f50e47@syzkaller.appspotmail.com,
    Eric Dumazet <edumazet@google.com>,
    Neal Cardwell <ncardwell@google.com>,
    Kuniyuki Iwashima <kuniyu@google.com>,
    "David S. Miller" <davem@davemloft.net>,
    David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4] tcp: Correct signedness in skb remaining space calculation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2627956.1751985886.1@warthog.procyon.org.uk>
Date: Tue, 08 Jul 2025 15:44:46 +0100
Message-ID: <2627957.1751985886@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Jiayuan Chen <jiayuan.chen@linux.dev> wrote:

> Syzkaller reported a bug [1] where sk->sk_forward_alloc can overflow.
> 
> When we send data, if an skb exists at the tail of the write queue, the
> kernel will attempt to append the new data to that skb. However, the code
> that checks for available space in the skb is flawed:
> '''
> copy = size_goal - skb->len
> '''
> 
> The types of the variables involved are:
> '''
> copy: ssize_t (s64 on 64-bit systems)
> size_goal: int
> skb->len: unsigned int
> '''
> 
> Due to C's type promotion rules, the signed size_goal is converted to an
> unsigned int to match skb->len before the subtraction. The result is an
> unsigned int.
> 
> When this unsigned int result is then assigned to the s64 copy variable,
> it is zero-extended, preserving its non-negative value. Consequently, copy
> is always >= 0.
> 
> Assume we are sending 2GB of data and size_goal has been adjusted to a
> value smaller than skb->len. The subtraction will result in copy holding a
> very large positive integer. In the subsequent logic, this large value is
> used to update sk->sk_forward_alloc, which can easily cause it to overflow.
> 
> The syzkaller reproducer uses TCP_REPAIR to reliably create this
> condition. However, this can also occur in real-world scenarios. The
> tcp_bound_to_half_wnd() function can also reduce size_goal to a small
> value. This would cause the subsequent tcp_wmem_schedule() to set
> sk->sk_forward_alloc to a value close to INT_MAX. Further memory
> allocation requests would then cause sk_forward_alloc to wrap around and
> become negative.
> 
> [1]: https://syzkaller.appspot.com/bug?extid=de6565462ab540f50e47
> 
> Reported-by: syzbot+de6565462ab540f50e47@syzkaller.appspotmail.com
> Fixes: 270a1c3de47e ("tcp: Support MSG_SPLICE_PAGES")
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>

Reviewed-by: David Howells <dhowells@redhat.com>


