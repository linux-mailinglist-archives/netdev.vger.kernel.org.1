Return-Path: <netdev+bounces-14608-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B810742A59
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 18:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF5C3280EA0
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 16:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D209212B95;
	Thu, 29 Jun 2023 16:11:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95EB7134AF
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 16:11:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96951C433C0;
	Thu, 29 Jun 2023 16:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688055091;
	bh=poaFO3/bPh14xOgLxoo80j/K9Q/PKlqqhRQVP/H2PzY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qux7W8jRi3usYygYWoKQ80BcrBb8GJWqLvuGuwL8lbBwBavexsXOYZo/YD8NXuGDQ
	 d1242atZe6+maXcqWu2UAnmYyd7J7+MA4DN1eT1MDIHRkyEzElW6VSEb3knMaRxKVW
	 XEppM1gEwcAG3KvCTuYd1XN0lhyMaDdVi+bDG9Xza9K/Yxe3evXQMuZbe1q8stHxpw
	 jFl+XugO0YcGPCK7GH6CqDyUXfsresz9YrZfrbnLfuigc4HXzyiy3N4mFJYza82u5e
	 UronuKaEFZqz/r813jLP8q4qjeNA/rQDcvX4hMDW6iDW1hqjlUjnGMF6i94Uc3bgst
	 bhOgvbvlqGHhA==
Date: Thu, 29 Jun 2023 09:11:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: longli@linuxonhyperv.com
Cc: Paolo Abeni <pabeni@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>, Leon
 Romanovsky <leon@kernel.org>, Ajay Sharma <sharmaajay@microsoft.com>,
 Dexuan Cui <decui@microsoft.com>, "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, linux-rdma@vger.kernel.org,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Long Li  <longli@microsoft.com>,
 stable@vger.kernel.org
Subject: Re: [Patch v3] net: mana: Batch ringing RX queue doorbell on
 receiving packets
Message-ID: <20230629091129.19217388@kernel.org>
In-Reply-To: <36c95dd6babb2202f70594d5dde13493af62dcad.camel@redhat.com>
References: <1687823827-15850-1-git-send-email-longli@linuxonhyperv.com>
	<36c95dd6babb2202f70594d5dde13493af62dcad.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Jun 2023 10:42:34 +0200 Paolo Abeni wrote:
> > While we are making changes in this code path, change the code for
> > ringing doorbell to set the WQE_COUNT to 0 for Receive Queue. The
> > hardware specification specifies that it should set to 0. Although
> > currently the hardware doesn't enforce the check, in the future releases
> > it may do.

And please split this cleanup into a separate patch, it doesn't sound
like it has to be done as part of the optimization.

