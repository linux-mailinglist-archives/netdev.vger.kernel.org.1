Return-Path: <netdev+bounces-88069-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4583A8A58DC
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 19:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A54FB282430
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 17:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1BE82862;
	Mon, 15 Apr 2024 17:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eIasiNnX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CA7811EB
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 17:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713201063; cv=none; b=kNebsxpCsFl+fiziGWHLug++ztWxbONjf6KKG1EZgOoaeXReSzPYWRJyufx3Q8DsMkiE3WNkq1GgmrDNJrQw9Qn4+KKlgxZDGS3u5N6E16/Aqs39k3/V2ruyfqplAYs7xBkTeRyAVfaAX9URE8Iw4z10Lh+Asz55kV8o7LFYHA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713201063; c=relaxed/simple;
	bh=rdemyd14lAu4jmBNfIfrIRGyaRWg60bezAiN0bweEQs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QD6Yd9OM4KiuQuqa066nypAEMolSy/yLyzej1SD8F5gThgAEn+zSyQGi2BjbwkYn1AmA01UhkWf9Dwf0K+wFoI2CNCIRRbl6ZSKDZoiAbJl6GVIA5+NTIYWheiA54AY/Q5jco1K9LeVE8VG2qxElGy+M8v4F6uMHU0/Zp4qyZO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eIasiNnX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95346C113CC;
	Mon, 15 Apr 2024 17:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713201062;
	bh=rdemyd14lAu4jmBNfIfrIRGyaRWg60bezAiN0bweEQs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eIasiNnXv1bl+oIxk2vR7h/qYa4jEs3HFcqCjy3M/RZkVAjrYYPyBBv+Leq57q95q
	 Rbndpc4gyJXuhmxW5+y2CkFUCiSgk5IS9nD2W5wuZrEDVhPWIBkwExFRqp9pIBWbY2
	 3F90y9VmDiz/6LGYjGqIS4Tc2dLhpC7TMlrAY4gSfPC+F89WOrSSuZ9trXULWk6+Fk
	 10IgDdstNoAoibEXblV19+yo+MoFr0/0/SYnM3vspXmVpCn5CItnrvQtmeaoC1oAFv
	 Q5LrsxmVwjB/ofzK2NS3f0IL93CSzuiWJIz3pORk4gtoHoNGfyFOSraPr+QyCKJr7I
	 1Q7fMc4Wirr0g==
Date: Mon, 15 Apr 2024 10:11:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Yunsheng Lin <linyunsheng@huawei.com>, netdev@vger.kernel.org, Alexander
 Duyck <alexanderduyck@fb.com>, davem@davemloft.net, pabeni@redhat.com
Subject: Re: [net-next PATCH 13/15] eth: fbnic: add basic Rx handling
Message-ID: <20240415101101.3dd207c4@kernel.org>
In-Reply-To: <CAKgT0UccovDVS8-TPXxgGbrTAqpeVHRQuCwf7f2qkfcPaPOA-A@mail.gmail.com>
References: <171217454226.1598374.8971335637623132496.stgit@ahduyck-xeon-server.home.arpa>
	<171217496013.1598374.10126180029382922588.stgit@ahduyck-xeon-server.home.arpa>
	<41a39896-480b-f08d-ba67-17e129e39c0f@huawei.com>
	<CAKgT0Uf6MdYX_1OuAFAXadh86zDX_w1a_cwpoPGMxpmC4hGyEA@mail.gmail.com>
	<53b80db6-f2bc-d824-ea42-4b2ac64625f2@huawei.com>
	<CAKgT0UeQS5q=Y2j3mmu9AhWyUMbey-iFL+sKES1UrBtoAXMdzw@mail.gmail.com>
	<0e5e3196-ca2f-b905-a6ba-7721e8586ed7@huawei.com>
	<CAKgT0UeRWsJ+NiniSKa7Z3Law=QrYZp3giLAigJf7EvuAbjkRA@mail.gmail.com>
	<bf070035-ba9c-d028-1b11-72af8651f979@huawei.com>
	<CAKgT0UccovDVS8-TPXxgGbrTAqpeVHRQuCwf7f2qkfcPaPOA-A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Apr 2024 08:03:38 -0700 Alexander Duyck wrote:
> > > The advantage of being a purpose built driver is that we aren't
> > > running on any architectures where the PAGE_SIZE > 4K. If it came to  
> >
> > I am not sure if 'being a purpose built driver' argument is strong enough
> > here, at least the Kconfig does not seems to be suggesting it is a purpose
> > built driver, perhaps add a 'depend on' to suggest that?  
> 
> I'm not sure if you have been following the other threads. One of the
> general thoughts of pushback against this driver was that Meta is
> currently the only company that will have possession of this NIC. As
> such Meta will be deciding what systems it goes into and as a result
> of that we aren't likely to be running it on systems with 64K pages.

Didn't take long for this argument to float to the surface..

We tried to write some rules with Paolo but haven't published them, yet.
Here is one that may be relevant:

  3. External contributions
  -------------------------

  Owners of drivers for private devices must not exhibit a stronger
  sense of ownership or push back on accepting code changes from
  members of the community. 3rd party contributions should be evaluated
  and eventually accepted, or challenged only on technical arguments
  based on the code itself. In particular, the argument that the owner
  is the only user and therefore knows best should not be used.

Not exactly a contribution, but we predicted the "we know best"
tone of the argument :(

