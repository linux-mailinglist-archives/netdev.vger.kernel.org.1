Return-Path: <netdev+bounces-17258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85FCD750E9E
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 18:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39245281B39
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 16:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A81AD535;
	Wed, 12 Jul 2023 16:34:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5A020F93
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 16:34:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5058C433C8;
	Wed, 12 Jul 2023 16:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689179658;
	bh=BNxudH+k/l9eNzIT6/GayLGshKc3HHixfiwJvQewo4o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZvnN2VEvpdtt8a9Gz4WzUfQbjZBcw9rgxxBptM9z7MnCvgGRf310GffbD5sTpek8/
	 jZmun88oMfp4lzxeV9KrkEeFkDivJ9RlfHleW4bSbXn2xxMSNy110c8UrRsGJHbIId
	 DqukaV8AbqhMfWbXgnPkecagyCyHXTAeyerYx6QAlJHD+OStYbWeRVsQz13HZx8xK/
	 Byvvbq1jQAl2kx7jkcRQPXdtcQNEVSJHuopxLuRERIV3Zne//xOZYKWangpDLcrLVA
	 fUpjWlG/SNvh3Q0tfyh7dy7uCUYznfItccdWYbB48/2/jIdz9M6K3wIiCgbIezSG7q
	 qla1KxGG2/N/A==
Date: Wed, 12 Jul 2023 09:34:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 michael.chan@broadcom.com
Subject: Re: [PATCH net-next 3/3] eth: bnxt: handle invalid Tx completions
 more gracefully
Message-ID: <20230712093418.5578c227@kernel.org>
In-Reply-To: <5b722084c6031009f845e6af8b438d49b9ea7dc1.camel@redhat.com>
References: <20230710205611.1198878-1-kuba@kernel.org>
	<20230710205611.1198878-4-kuba@kernel.org>
	<774e2719376723595425067ab3a6f59b72c50bc2.camel@redhat.com>
	<20230711181919.50f27180@kernel.org>
	<5b722084c6031009f845e6af8b438d49b9ea7dc1.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Jul 2023 08:50:06 +0200 Paolo Abeni wrote:
> Surely not a big deal. But some users (possibly most of them!) have
> older compiler.

I checked GCC 10 and GCC 9, and the code is the same :(
Any idea on how old do we need to go?

> Including an assignment in the test code, I get this
> additional difference:
> 
> -   c:	80 4b 09 01          	orb    $0x1,0x9(%rbx)
> +   c:	c6 43 09 01          	movb   $0x1,0x9(%rbx)
> 
> with the bitfield using the 'or' operation. Not a big deal, but the
> other option is slightly better ;)

Is there really any difference whether one changes a byte or ors
in a bit? Either way it's a partial update of a word.

multi-bit fields may be harder for the compiler, especially weirdly
aligned but for trivial single bit values I think we may be overly
cautious.

