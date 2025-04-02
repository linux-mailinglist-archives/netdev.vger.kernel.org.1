Return-Path: <netdev+bounces-178844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC829A792F1
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 18:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D35D3AFFFC
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 16:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B6B18DB3D;
	Wed,  2 Apr 2025 16:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pw1mwMrB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFD113C81B
	for <netdev@vger.kernel.org>; Wed,  2 Apr 2025 16:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743611027; cv=none; b=mE2H5PE0bt/BPAJRSVikoLz5R4GNcd7cSOPVCkoswhrcNv+ITj/9+GtZIH+Hzn32wI/3MNKFygbOtTzU8CRWXH0m1TKct7j5iaAJupJFRGVp9U9wGis4tpE0Ph9plu43/XZosnmPgImGvq+JG46Nm78yOZ6DNN+bB09op7dIWYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743611027; c=relaxed/simple;
	bh=dmrKGzqUd1GVFzy4It40DCXnIT6NJijDToqqOeuvvUM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AGZ7eHR6nKUlXowDqXXO3zWGqaFutd2tcGcs085QBquOJxRBprYG4LpJPbTCizU4o6vnAtoCPfdcVKxc81d74JTBcPsO1M2zqOmuIsgdiCxm/PsKhRxRTt7BuP7WneUwHZhQ+DwjYuiF5ocQFukvd/T6iSVRRjCJQYsaVrRQKJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pw1mwMrB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79A53C4CEDD;
	Wed,  2 Apr 2025 16:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743611026;
	bh=dmrKGzqUd1GVFzy4It40DCXnIT6NJijDToqqOeuvvUM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Pw1mwMrBV6zyGiJmhdIzGAmb9tWWEQrstOpZvF4ASzG/Gaz+scl5yPTGB/ifLdLHE
	 12qfv+b90q5duPv4h92sLXXACeIktca/FWNJJ+VbBsc3qEGGvY5dnUR5GcaOFB0a9z
	 JxmGk63Ddo5kTg5ligk5b/vkovtjSU5LVQLkACTlVc7UFaM8OMHAb2MV55UnT4oU0R
	 rv8lsrM/cu76h4ltkws13F8D/yRB/ovgzIBwKP2kL1u3hx58GoL7fVENhI4kkA7JkB
	 Qw7tRbpLhX8wRX8uOvlXvBC67xuoPcslKLx/zwJ+TSBbbpSyXmfBlf6XNICP4oBZQ8
	 R090twtn609pw==
Date: Wed, 2 Apr 2025 09:23:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Andrew Lunn <andrew@lunn.ch>, David Arinzon <darinzon@amazon.com>, David
 Miller <davem@davemloft.net>, netdev@vger.kernel.org, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Richard Cochran <richardcochran@gmail.com>, "Woodhouse,
 David" <dwmw@amazon.com>, "Machulsky, Zorik" <zorik@amazon.com>,
 "Matushevsky, Alexander" <matua@amazon.com>, Saeed Bshara
 <saeedb@amazon.com>, "Wilson, Matt" <msw@amazon.com>, "Liguori, Anthony"
 <aliguori@amazon.com>, "Bshara, Nafea" <nafea@amazon.com>, "Schmeilin,
 Evgeny" <evgenys@amazon.com>, "Belgazal, Netanel" <netanel@amazon.com>,
 "Saidi, Ali" <alisaidi@amazon.com>, "Herrenschmidt, Benjamin"
 <benh@amazon.com>, "Kiyanovski, Arthur" <akiyano@amazon.com>, "Dagan, Noam"
 <ndagan@amazon.com>, "Bernstein, Amit" <amitbern@amazon.com>, "Agroskin,
 Shay" <shayagr@amazon.com>, "Ostrovsky, Evgeny" <evostrov@amazon.com>,
 "Tabachnik, Ofir" <ofirt@amazon.com>, "Machnikowski, Maciek"
 <maciek@machnikowski.net>, Rahul Rameshbabu <rrameshbabu@nvidia.com>, Gal
 Pressman <gal@nvidia.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>
Subject: Re: [PATCH v8 net-next 5/5] net: ena: Add PHC documentation
Message-ID: <20250402092344.5a12a26a@kernel.org>
In-Reply-To: <dc253b7be5082d5623ae8865d5d75eb3df788516.camel@infradead.org>
References: <20250304190504.3743-1-darinzon@amazon.com>
	<20250304190504.3743-6-darinzon@amazon.com>
	<aecb8d12-805b-4592-94f3-4dbfcdcd5cff@lunn.ch>
	<55f9df6241d052a91dfde950af04c70969ea28b2.camel@infradead.org>
	<dc253b7be5082d5623ae8865d5d75eb3df788516.camel@infradead.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 01 Apr 2025 09:46:35 +0100 David Woodhouse wrote:
> On Tue, 2025-04-01 at 09:02 +0100, David Woodhouse wrote:
> > 
> > I think the sysfs control is the best option here.  
> 
> Actually, it occurs to me that the best option is probably a module
> parameter. If you have to take the network down and up to change the
> mode, why not just unload and reload the module?

We have something called devlink params, which support "configuration
modes" (= what level of reset is required to activate the new setting).
Maybe devlink param with cmode of "driver init" would be the best fit?

Module params are annoying because they are scoped to code / module not
instances of the device.

