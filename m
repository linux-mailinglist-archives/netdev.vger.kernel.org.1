Return-Path: <netdev+bounces-17007-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5054274FC91
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 03:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB6AA1C20E5D
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 01:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC85E37A;
	Wed, 12 Jul 2023 01:19:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290CD362
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 01:19:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BECEC433C7;
	Wed, 12 Jul 2023 01:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689124760;
	bh=XXXzOg9TepOar5r/s93chuY4Kp3jgxCQsg1AJXeSjuU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=H4PsSoiHErYE0qP3vtw/uQhP0gnWOUlJQhVjFFQgPDR8kgrwP16HcHGLitDo/qyKu
	 kIW/9BJ1GKPMQdD5Gowa3RsREnyFUjHgJQNY3K2mQw8VvWI5SCIadkxZviECM7j4wd
	 8z12eALxnZ0oMZoqPq+FoKARFbMYjYz4qNq+8Z/tPpE2k7RxS+skMcQ6dv7BRTuIf9
	 e7Nq0zIm0aGIdx7tKeJGyksv6IH9Z9ix647G6IMdgRtVRlZnmM7pOwBiykWoK6clFF
	 pG2vVpsU2qAQrH0FFRMgX/EMOqXaO0KdZSMPwyBaOiC0kT0vhtKup3sHu+ioRB7RKx
	 e8bccfFR8qgrg==
Date: Tue, 11 Jul 2023 18:19:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 michael.chan@broadcom.com
Subject: Re: [PATCH net-next 3/3] eth: bnxt: handle invalid Tx completions
 more gracefully
Message-ID: <20230711181919.50f27180@kernel.org>
In-Reply-To: <774e2719376723595425067ab3a6f59b72c50bc2.camel@redhat.com>
References: <20230710205611.1198878-1-kuba@kernel.org>
	<20230710205611.1198878-4-kuba@kernel.org>
	<774e2719376723595425067ab3a6f59b72c50bc2.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Jul 2023 12:10:28 +0200 Paolo Abeni wrote:
> On Mon, 2023-07-10 at 13:56 -0700, Jakub Kicinski wrote:
> > diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> > index 080e73496066..08ce9046bfd2 100644
> > --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> > +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> > @@ -1008,6 +1008,7 @@ struct bnxt_napi {
> >  					  int);
> >  	int			tx_pkts;
> >  	u8			events;
> > +	u8			tx_fault:1;  
> 
> Since there are still a few holes avail, I would use a plain u8 (or
> bool) to help the compiler emit better code.

Is that still true or was it only true for old compilers?
With gcc version 13.1.1 20230614 :

$ cat /tmp/t.c 
#include <strings.h>

struct some {
    void (*f)(void);
    unsigned char b;
#ifdef BLA
    _Bool a;
#else
    unsigned char a:1;
#endif
};

int bla(struct some *s)
{
    if (s->a)
        s->f();
    return 0;
}

$ gcc -W -Wall -O2  /tmp/t.c -o /tmp/t -c
$ objdump -S /tmp/t > /tmp/a
$ gcc -DBLA -W -Wall -O2  /tmp/t.c -o /tmp/t -c
$ objdump -S /tmp/t > /tmp/b
$ diff /tmp/a /tmp/b
8c8
<    0:	f6 47 09 01          	testb  $0x1,0x9(%rdi)
---
>    0:	80 7f 09 00          	cmpb   $0x0,0x9(%rdi)

$ gcc -V

Shouldn't matter, right?

