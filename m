Return-Path: <netdev+bounces-27394-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11ADD77BCDE
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 17:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C12EF2810B5
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 15:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAD8BC2C9;
	Mon, 14 Aug 2023 15:21:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3BAC154
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 15:21:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A63BC433C8;
	Mon, 14 Aug 2023 15:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692026490;
	bh=21qKNzNxPDfwgDE8vrKO7hvz6hkx7i2KtgQh0A7uQEY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QlLnqAwod8qr+qnrWizKJLr0QAlVPJe7byBm615TN6deShPujk5mavGHpOcZJWWcA
	 eIfqL4CF/PqebRzPhNeWjiPUUjJowwblTaBV1MzBFb1suIpIRanEhSW996sg+briwU
	 B20Vd88jQ3COmKHrRRTOiZUUnrXEroU7SoHMVBTA5ebiRYxtKjS9KeRQWY0rmaVCDa
	 TTqK/CZLciQkiP6ovrHFtrgSssanGyLUOIZW4RX32mokX200wTtZDy3qZha/PCyZT9
	 Df2ebIMWcezUDm6gs3cMxAK9RvJnEQCsMW0X73bjx/UqzIbS/jw7MXOYpgG+6FxDUX
	 nEyp0ewPF5Ngg==
Date: Mon, 14 Aug 2023 08:21:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Vadim Fedorenko <vfedorenko@novek.ru>, Frantisek
 Krenzelok <fkrenzel@redhat.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
 Apoorv Kothari <apoorvko@amazon.com>, Boris Pismenny <borisp@nvidia.com>,
 John Fastabend <john.fastabend@gmail.com>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, Gal Pressman <gal@nvidia.com>, Marcel
 Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH net-next v3 3/6] tls: implement rekey for TLS1.3
Message-ID: <20230814082128.632d2b03@kernel.org>
In-Reply-To: <ZNpC4lAmlLn-5A9h@hog>
References: <cover.1691584074.git.sd@queasysnail.net>
	<c0ef5c0cf4f56d247081ce366eb5de09bf506cf4.1691584074.git.sd@queasysnail.net>
	<20230811184347.1f7077a9@kernel.org>
	<ZNpC4lAmlLn-5A9h@hog>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Aug 2023 17:06:10 +0200 Sabrina Dubroca wrote:
> 2023-08-11, 18:43:47 -0700, Jakub Kicinski wrote:
> > On Wed,  9 Aug 2023 14:58:52 +0200 Sabrina Dubroca wrote:  
> > >  			TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXSW);
> > >  			TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSCURRRXSW);
> > >  			conf = TLS_SW;  
> > 
> > Should we add a statistic for rekeying?  
> 
> Hmpf, at least I shouldn't be incrementing the existing stats on every
> update, especially not TLSCURR* :/
> 
> I don't see much benefit in tracking succesful rekeys. Failed rekeys
> seem more interesting to me. What would we get from counting succesful
> rekeys?

No huge benefit from counting rekeys, the main (only?) one I see is
that when user reports issues we can see whether rekeys were involved
(given that they are fairly rare). It could help narrow down triage.


