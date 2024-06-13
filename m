Return-Path: <netdev+bounces-103414-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 658E8907EBF
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 00:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E9B01C205E1
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 22:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8119C13B580;
	Thu, 13 Jun 2024 22:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VqcgrtX1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6C681AB5
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 22:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718317170; cv=none; b=tnQgy0fdO42v5WbXVJcRk1F/Wd8O4tf04awQNObPliqhkplx5eAjhPJJqDDo84hXaEzsyu7KZIG2q+aNnPqsJ3m4JmJ4fBZZLWRvGlCCqZR8nP1tmRzAMZwsP3cQCvZmaaoYkt9MAbRpTnVb4CKqk7a3zJVNUlOwspOmP0IjcaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718317170; c=relaxed/simple;
	bh=u6l7hA3Ib5OND5z6WPiNElN7+Sfb+ZfHEFcPAk6Myu0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qQQvtDts9btOPXl+/75KhKXfnQP4zdOoylEN40oj7nkx17o4cZ8tg4Xl0YUhgDSI1D0Vnpp0P0LNij1FdVMQL94zfsG379uLtijBvBSzqCAItEAU7ASpex8Wh4036QAvgenq9ek4VRDCn9UtFoeFjQdKPNCJnnx/nLtFc99r2y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VqcgrtX1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81074C2BBFC;
	Thu, 13 Jun 2024 22:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718317169;
	bh=u6l7hA3Ib5OND5z6WPiNElN7+Sfb+ZfHEFcPAk6Myu0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VqcgrtX1w7ShxH7sqNZipaiHVQc5zKvmrMsacaKokuzjMaqD5DAs2tBH+3+JpIs/N
	 Y2VrHagH+73b4WOozHnqa/LSUGubTVyA2IjFeuXOwfVRgkBTiI3FX2Y7sq2oKrTmVF
	 QMsK1jsaAGIJsDDYZzG3TCcBdxsHyfzLDNUXPAMppfYe4Py98qpJG33wEPQJ8TJwX0
	 r2RSCZr/DIFbKMnj1FNs3sX+R5/lrivPoWiauiUyPBS3bOwizw8NKU0J7guzkJYnIT
	 /9l6UU5Z/xdV96jzNdf27uG7DnBpSFvbXKCEXI8AVwa2ZUoKu47ywiro8Wa4W+Vggn
	 5kEhLcj/tb9lg==
Date: Thu, 13 Jun 2024 15:19:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Nelson, Shannon" <shannon.nelson@amd.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, brett.creeley@amd.com, drivers@pensando.io
Subject: Re: [PATCH net-next 3/8] ionic: add private workqueue per-device
Message-ID: <20240613151928.6cc91d18@kernel.org>
In-Reply-To: <54c39843-b81b-4692-a22e-d2c51e617219@amd.com>
References: <20240610230706.34883-1-shannon.nelson@amd.com>
	<20240610230706.34883-4-shannon.nelson@amd.com>
	<20240612180831.4b22d81b@kernel.org>
	<54c39843-b81b-4692-a22e-d2c51e617219@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Jun 2024 13:38:18 -0700 Nelson, Shannon wrote:
> > little jobs little point of having your own wq, no?
> > At this point of reading the series its a bit unclear why
> > the wq separation is needed.  
> 
> Yes, when using only a single PF or two this doesn't look so bad to be 
> left on the system workqueue.  But we have a couple customers that want 
> to scale out to lots of VFs with multiple queues per VF, which 
> multiplies out 100's of queues getting workitems.  We thought that 
> instead of firebombing the system workqueue with a lot of little jobs, 
> we would give the scheduler a chance to work with our stuff separately, 
> and setting it up by device seemed like an easy enough way to partition 
> the work.  Other options might be one ionic wq used by all devices, or 
> maybe a wq per PF family?  Do you have a preference, or do you still 
> think that the system wq is enough?

No, no, code is fine. I was just complaining about the commit message :)
The math for how many work items you can see in reasonable scenarios
would be helpful to see when judging the need.

