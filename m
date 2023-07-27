Return-Path: <netdev+bounces-21694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A71C7644F8
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 06:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C60BB1C214AC
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 04:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6452D1864;
	Thu, 27 Jul 2023 04:36:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C33ED5;
	Thu, 27 Jul 2023 04:36:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AB90C433C7;
	Thu, 27 Jul 2023 04:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690432577;
	bh=hsDktSd9M7zkimN2Hb5m6FsokqiQPRPyitSVBQKAxac=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rTmbpIy90BL0sU1NLGejD3NNaixelygXmcOnBZe5ben0Zqx+redlc6unHq1HoISB4
	 l5oIYdE+gqM6Uly3JenP0kPxnr7ryvfKipWRA9fMoBzCf4kW4KfKWSCOgdK7iGStN+
	 qvr3ieEWZedJ2F6+Bja6p2mxf7oQTaXkZtTQ6Gmt7crUIKZ7o50bxTizBXw77mKRiE
	 Agf0rCJ3G+HbQ4j8htsHK2drn6eh+c3TZJbhC/IbOiBZCJ6pG8qpirfjt8UQZ+RaiI
	 8wd2pdBsfoQ+UrSjuOgktdCWONe1Eqbc2Fm1AYzPRuvxW9P/06v/qADbC4R4yxd+e+
	 QCHEA25cA1nSQ==
Date: Wed, 26 Jul 2023 21:36:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev
Subject: Re: [PATCH net-next v2 1/7] net/tls: Move TLS protocol elements to
 a separate header
Message-ID: <20230726213616.25141508@kernel.org>
In-Reply-To: <169031734129.15386.4192319236812962393.stgit@oracle-102.nfsv4bat.org>
References: <169031700320.15386.6923217931442885226.stgit@oracle-102.nfsv4bat.org>
	<169031734129.15386.4192319236812962393.stgit@oracle-102.nfsv4bat.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Jul 2023 16:35:51 -0400 Chuck Lever wrote:
> --- a/include/net/tls.h
> +++ b/include/net/tls.h
> @@ -45,6 +45,7 @@
>  
>  #include <net/net_namespace.h>
>  #include <net/tcp.h>
> +#include <net/tls_prot.h>

I'd be tempted to push this only to places that need it:

net/tls/tls.h
net/sunrpc/svcsock.c
net/sunrpc/xprtsock.c
drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_io.c

to make rebuilds smaller. Bunch of ethernet drivers will get rebuilt
every time we touch this header, and they don't care about the proto
details.

But I'm probably overly sensitive to build times so up to you.

