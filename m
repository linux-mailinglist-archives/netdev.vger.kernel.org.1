Return-Path: <netdev+bounces-127152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D08974624
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 00:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5328BB25262
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 22:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B52B1ABEC7;
	Tue, 10 Sep 2024 22:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VSq7NH49"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E88D1A2C3C;
	Tue, 10 Sep 2024 22:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726008433; cv=none; b=PyIXIOJ3RMx9b3KMc/83TwH610EtqmkSmfmSn28Hh73RKpdqomCZLd0mfPG0nRgKw/gbGJkK1YpXsmXj801XUPXor35Hwg22ip7VBxs92HT2oM3+5VEFTkO9u6IxslPc2lFOP8V6xl4V6HR4EMpODiuGa7Jx0Z7xNUl/pVhj3WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726008433; c=relaxed/simple;
	bh=awCwBvOZqjZ4k43u7ObQtippMTkO+H2VcKzFTlCYDdU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YQE8yRLS9mfXkeTwD6MToFJtjd065dXWsmOh50FSHbcQEqT0GRgaBMpyD98hY8WCRDloqcNn+Y1NagCGJSt6UX3ZGtCZWV4vtC59cVqVyDWvYkJd4WZoEncQtlXLXlizu15xTm9pqyVoTvXWF834uSrsDqrqewzQvxczmuucOQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VSq7NH49; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E667BC4CEC3;
	Tue, 10 Sep 2024 22:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726008432;
	bh=awCwBvOZqjZ4k43u7ObQtippMTkO+H2VcKzFTlCYDdU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VSq7NH49L+evfVF6RzeqwEgKVGM3G/SdsnctGU+kQLogLF9id6FeBG1rZuz7uBRX1
	 YoWhuYM/XFxSwgD4LcOftE8xirRUEdHK7idWU0tTR5R21xB1ZXTMrQfzqUZga/V7mR
	 BaSf/Ll5q+zBWVWLuxKKMnjymvf8qIG8XcC7Hq3XYmvUUFV+PY4eD1aZohKAqt775x
	 EIEU33dopP2ciUJw9jyysOAcByFr1ZPbyxLENzIO9Bjh7EDuvJcF1jmNf52rivnGc/
	 ANNyAEZCZEYrps6QEcnIwddyNjEJKQjMo66RluyuxVRo26I3FjxhmTwj8pUUwALUMY
	 55cxKj4YyKKfQ==
Date: Tue, 10 Sep 2024 15:47:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lee Trager <lee@trager.us>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jonathan
 Corbet <corbet@lwn.net>, Alexander Duyck <alexanderduyck@fb.com>,
 kernel-team@meta.com, Shinas Rasheed <srasheed@marvell.com>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Phani Burra <phani.r.burra@intel.com>, Joshua
 Hay <joshua.a.hay@intel.com>, Sanman Pradhan <sanmanpradhan@meta.com>,
 Sridhar Samudrala <sridhar.samudrala@intel.com>, Alan Brady
 <alan.brady@intel.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] eth: fbnic: Add devlink firmware version info
Message-ID: <20240910154711.57c6557a@kernel.org>
In-Reply-To: <20240905233820.1713043-1-lee@trager.us>
References: <20240905233820.1713043-1-lee@trager.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  5 Sep 2024 16:37:51 -0700 Lee Trager wrote:
> This adds support to show firmware version information for both stored and
> running firmware versions. The version and commit is displayed separately
> to aid monitoring tools which only care about the version.

I don't see a reply from the bots, so FTR Paolo applied this to net-next
as commit 0246388b9b79 ("eth: fbnic: Add devlink firmware version info").
Thank you!

