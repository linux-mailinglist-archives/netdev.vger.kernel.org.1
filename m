Return-Path: <netdev+bounces-190739-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B11D8AB88FC
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 16:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C38CA024B4
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 14:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1D219CC0E;
	Thu, 15 May 2025 14:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YjuIe8YO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991EE4174A
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 14:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747318362; cv=none; b=RwZ1Gg14JZxFwN8L+v77u/S44M7Iv3esLynhOjD/eAhvzA1EMaUkhyh2QnjJr9wVv2dZpuKQePqvHBdvdzY/b01qN0yzyZ3Lwf3GVfCqo6TPrKCIvpe0+7jHEyAj48TZvhJhhHsTyzMR2knBkchh+g9VvzybmGPHIXviFQsZSxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747318362; c=relaxed/simple;
	bh=DPCQzZ/xxBw8zi54cYPzeWg5Dq4C3d6SQk+6mJ0yHeg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vAKQ3vK3vjk64CinjiuNtT7QootRSVvfRl9JFuHeZxxcL06H4jCK4BWs4/7zsfL5le7bPoJZRhkU8kM7HNESXJ3Eur3dEbJNWRJpnlnnuzBrjyYVrn7CiThXEbNTUU931ise2DhtfvT5RxXqhi9RppoLh6we8w2oTX04GCmIILk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YjuIe8YO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D7D2C4CEE7;
	Thu, 15 May 2025 14:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747318361;
	bh=DPCQzZ/xxBw8zi54cYPzeWg5Dq4C3d6SQk+6mJ0yHeg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YjuIe8YOSFnDbCnOSBgt4dRrqxX5CeV5bNjExGze5VfQ/ropfJ68L8H7LjV4ZwEqw
	 fzBbCrOjbReaQcGzzkMez11y1jd6UToMlsraB/ECdy0TxJ8qMBUHXLnJVj9jGT2OyW
	 ag88jrZ9IfomSKgmuhVSy8zfC63FdnZOhioQ+w/mJUUgUXdF33+Sh5nYyP5hJ6gcH3
	 oELAUy82n9hwd7S1fu5pi0CYt0ekdhJTtuwXfN9UZU6Ki81kYo/raNgGuXFjfCPcOd
	 eFRg2OcJpTkc/Pf08pV0pLnO16jDt6seQXt47H1/sXwgYstGmRFnoPZcjaAx7kiYw9
	 Xz0SN1vHzVH7g==
Date: Thu, 15 May 2025 07:12:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Subbaraya Sundeep <sbhatta@marvell.com>
Cc: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <horms@kernel.org>, <gakula@marvell.com>,
 <hkelam@marvell.com>, <sgoutham@marvell.com>, <lcherian@marvell.com>,
 <bbhushan2@marvell.com>, <jerinj@marvell.com>, <netdev@vger.kernel.org>
Subject: Re: [PATCH net v2] octeontx2-af: Send Link events one by one
Message-ID: <20250515071239.1fe4e69a@kernel.org>
In-Reply-To: <1747204108-1326-1-git-send-email-sbhatta@marvell.com>
References: <1747204108-1326-1-git-send-email-sbhatta@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 May 2025 11:58:28 +0530 Subbaraya Sundeep wrote:
> Send link events one after another otherwise new message
> is overwriting the message which is being processed by PF.

Please respond to reviewers in a timely fashion.

