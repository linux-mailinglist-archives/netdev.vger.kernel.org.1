Return-Path: <netdev+bounces-167526-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 669F8A3AACF
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 22:25:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56F003A5C69
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 21:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00CC1C6FFD;
	Tue, 18 Feb 2025 21:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PZVWjkS0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8536286286;
	Tue, 18 Feb 2025 21:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739913896; cv=none; b=lSGx1WvvWmDl/QCezQaTj8xi37H0WlOI+nJIUyWu+pC0LmhaPAMByl907GXMy85kEe4WNMuBhpCkYE0LsebuwtoqTqJjoolwKSXN4ZZpHxF56H4M+yZQHYJ8shDC7zsD6wkynVfyDyC0rxgdZS0s+KPTPtIA9G56KTVBmCVHD5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739913896; c=relaxed/simple;
	bh=j1wOK1WtP3hJwN/NmZJ5XR/o3Elun+UHcrO3nEkIDL4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sqYBkZLIW8pYgnwLOOG8MaOSf6zfkJOKhjrQkyh9Mr5yY0tkaIsee9vLaEUqzI9rVivNp+FIYZxnhJ/q30iyM6O2gBT19wvYxFYk7T93Rtz9zLw/ApL8i8F5pHBzOh60oRfUx6TrOdm8wmRtj5F/kb4MwmG3v0ZnKYti47S1dk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PZVWjkS0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C693FC4CEE2;
	Tue, 18 Feb 2025 21:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739913896;
	bh=j1wOK1WtP3hJwN/NmZJ5XR/o3Elun+UHcrO3nEkIDL4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PZVWjkS0Ud5rDE4zqCL5lzSn72OTjLZmFgzuI0yrJ7uij+nJihfklxdbUL14NXgoI
	 LH671gUdoZtKEDyxbQjrkpBsgiAH42WQdB+4zYDOb6sBZ4o6CUx8ahvZfSW5MQPaLs
	 WGiivCnwBTnqDZgJ1OGt0Gi+O6LceQH38/ghhhOWV+Y057c96yDWhYwMo87qQfHYd7
	 MvdzSl2tb2zlXtGtRSEbD+gIVmTtsiXjk5uFM1JpmcgyRfu9+BAZmM1tH5qTnRfW2C
	 dTnC822uScKhlAisMSO14++3Vfsudg+PUBSwsJTuQifze0pqQ3dVoY18/6itkYchif
	 gZ3uoSmCYNzWg==
Date: Tue, 18 Feb 2025 13:24:54 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Gal Pressman <gal@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Tariq
 Toukan <tariqt@nvidia.com>, Edward Cree <ecree.xilinx@gmail.com>, Ahmed
 Zaki <ahmed.zaki@intel.com>, linux-doc@vger.kernel.org, Nimrod Oren
 <noren@nvidia.com>
Subject: Re: [PATCH net-next v3 5/5] selftests: drv-net-hw: Add a test for
 symmetric RSS hash
Message-ID: <20250218132454.01345f86@kernel.org>
In-Reply-To: <9eb3db1a-514b-4fcc-8318-7af0bd0a62df@nvidia.com>
References: <20250216182453.226325-1-gal@nvidia.com>
	<20250216182453.226325-6-gal@nvidia.com>
	<20250217161954.57fd1457@kernel.org>
	<9eb3db1a-514b-4fcc-8318-7af0bd0a62df@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Feb 2025 22:26:25 +0200 Gal Pressman wrote:
> > Would be good to test both IPv4 and IPv6. I'm going to merge:
> >   https://lore.kernel.org/all/20250217194200.3011136-4-kuba@kernel.org/
> > it should make writing the v4 + v6 test combos easier.  
> 
> Should I wait for it to get merged?

Yes, please, I remove the members you'd need to use to test both v4
and v6 so you patch will stop working once mine is merged. Stan reported
a problem, I'll repost once again and hopefully the new version goes in
tomorrow.

