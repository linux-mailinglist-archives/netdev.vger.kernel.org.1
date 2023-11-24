Return-Path: <netdev+bounces-50970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F33F67F8597
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 22:45:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADF7E28161A
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 21:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7DD3BB50;
	Fri, 24 Nov 2023 21:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kx2s032V"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E11228DB8
	for <netdev@vger.kernel.org>; Fri, 24 Nov 2023 21:45:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AFD0C433C7;
	Fri, 24 Nov 2023 21:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700862346;
	bh=8yy9WafPl9l+IoPfIh4au5jXbM2ntfRav9lR4VWfwZs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kx2s032V6QsgsnE0puuwezyPLbvHMHO4cLzoftqprOt/+eyzZDPMmAGuIzNTEXuN6
	 CZNP3p/HQKrKgCrrQN/D0qvJAoNRpOXxWo/jlZFyehNC6ZbrFXSQ2oTPTLeBxHSrvU
	 MKG+tj7BBZ3d6SpyTwqGRXhlKh3EDVXlfEqLYEqfVXI5cz1CsJuVeGvXqaKiK1QDja
	 Y8PMoTMPdCvKUQu3tIZ0dOjqd1My1MidPsyNyiQ8e6QRnqs25+I1f2+1KzZBUWIPK3
	 SpWtZA/Q8GD7i0BDTLHyxMdOjVBDp/UJTrTBsQfmZj3280o/wQdbaFXiv/0No3UsgN
	 w3GIA7K3DIrPg==
Date: Fri, 24 Nov 2023 21:45:42 +0000
From: Simon Horman <horms@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v1 net-next 5/8] tcp: Don't initialise tp->tsoffset in
 tcp_get_cookie_sock().
Message-ID: <20231124214542.GC50352@kernel.org>
References: <20231123012521.62841-1-kuniyu@amazon.com>
 <20231123012521.62841-6-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231123012521.62841-6-kuniyu@amazon.com>

On Wed, Nov 22, 2023 at 05:25:18PM -0800, Kuniyuki Iwashima wrote:
> When we create a full socket from SYN Cookie, we initialise
> tcp_sk(sk)->tsoffset redundantly in tcp_get_cookie_sock() as
> the field is inherited from tcp_rsk(req)->ts_off.
> 
>   cookie_v[46]_check
>   |- treq->ts_off = 0
>   `- tcp_get_cookie_sock
>      |- tcp_v[46]_syn_recv_sock
>      |  `- tcp_create_openreq_child
>      |	   `- newtp->tsoffset = treq->ts_off
>      `- tcp_sk(child)->tsoffset = tsoff
> 
> Let's initialise tcp_rsk(req)->ts_off with the correct offset
> and remove the second initialisation of tcp_sk(sk)->tsoffset.
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Simon Horman <horms@kernel.org>


