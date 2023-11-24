Return-Path: <netdev+bounces-50971-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 697197F8598
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 22:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69EEC1C20A59
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 21:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C803BB51;
	Fri, 24 Nov 2023 21:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ujAOAtyp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B323BB48
	for <netdev@vger.kernel.org>; Fri, 24 Nov 2023 21:46:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 442FEC433C7;
	Fri, 24 Nov 2023 21:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700862364;
	bh=3HJ3UMipGHdP4ZFlC43T15Db2a+wMUEz4rK6se8aDOA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ujAOAtyp8ixYRqC9TFAyCgCM2AoVTXAkiZYAJbAotcYNQztr+eLRT6YMnCmESAx/c
	 mzx64vOEdiab+vDWJRCJISzH0+bhwslMrH97SvKk9JGsiFxg/RUZbt8Hs7gpi+0H2R
	 LP09QOfsKefdkKDakYBplZrbAAfjzfMQrPxFfW56gc9g/iIQWi/hwcnk7YXDmOQaZi
	 aV2IwsRFpSzlkMkHaKfsgj3MCJTdMoTdLmTYdPG3ytM83VAlaKjcJJUFkotKJBjdEC
	 qi6sVQr7POJYfxNw+JZKSQWzocB9lhIpt9f3Yf+8bMaGT7/8KYIGS7PGKn0pyUSOHu
	 DTE48XAHSz7iQ==
Date: Fri, 24 Nov 2023 21:46:01 +0000
From: Simon Horman <horms@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v1 net-next 6/8] tcp: Move TCP-AO bits from
 cookie_v[46]_check() to tcp_ao_syncookie().
Message-ID: <20231124214601.GD50352@kernel.org>
References: <20231123012521.62841-1-kuniyu@amazon.com>
 <20231123012521.62841-7-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231123012521.62841-7-kuniyu@amazon.com>

On Wed, Nov 22, 2023 at 05:25:19PM -0800, Kuniyuki Iwashima wrote:
> We initialise treq->af_specific in cookie_tcp_reqsk_alloc() so that
> we can look up a key later in tcp_create_openreq_child().
> 
> Initially, that change was added for MD5 by commit ba5a4fdd63ae ("tcp:
> make sure treq->af_specific is initialized"), but it has not been used
> since commit d0f2b7a9ca0a ("tcp: Disable header prediction for MD5
> flow.").
> 
> Now, treq->af_specific is used only by TCP-AO, so, we can move that
> initialisation into tcp_ao_syncookie().
> 
> In addition to that, l3index in cookie_v[46]_check() is only used for
> tcp_ao_syncookie(), so let's move it as well.
> 
> While at it, we move down tcp_ao_syncookie() in cookie_v4_check() so
> that it will be called after security_inet_conn_request() to make
> functions order consistent with cookie_v6_check().
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Simon Horman <horms@kernel.org>


