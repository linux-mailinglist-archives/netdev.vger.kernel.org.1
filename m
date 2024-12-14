Return-Path: <netdev+bounces-151938-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57AA19F1BF3
	for <lists+netdev@lfdr.de>; Sat, 14 Dec 2024 02:38:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65D117A02EE
	for <lists+netdev@lfdr.de>; Sat, 14 Dec 2024 01:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124B310940;
	Sat, 14 Dec 2024 01:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KwNuE5Kh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE21413FEE
	for <netdev@vger.kernel.org>; Sat, 14 Dec 2024 01:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734140311; cv=none; b=Yn/nGnoabE1nRgbZdhctMapMZ8CiAloJ1cMnThovtRhaKZQOvBP3zmh8y6DABC2D/KjYG3i/yaqQN5+lTvVAxyzdH2GyjoNObO+0xu/AACNGEK26/JQQvPSQq20pCDwx9NJHx2+HL6I2yGFURVVu2xsMOjHDHhkjgkDbYRCEOt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734140311; c=relaxed/simple;
	bh=wGD3MH2JDSJlPpCEuz5OFoxPd3WwE7Rmej7l4xjxr3w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=INxbKAHDdq/IgLUxxH/1RkhWMa7wzvb5IlPbOz3Fp+Io6eYr7QAphe35NBvanDD2Q9O4Q4+UYvK9USN5nZjc72UxdHLTcAEEdhQuY0b0am02mOTTT4A+dnty2wXiK4tJEYTrlnWqnkr7yc7UgVRagVk5G3dxSOsq20q5BL3cqfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KwNuE5Kh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EB33C4CED0;
	Sat, 14 Dec 2024 01:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734140310;
	bh=wGD3MH2JDSJlPpCEuz5OFoxPd3WwE7Rmej7l4xjxr3w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KwNuE5Khw9ab4IThZrPR+JddbQ1fEJApII1lLyqECMTGNXCwZhGjOuB3w/VE4xLrI
	 2CrHN3+mo1/1RHha73pgjkYZyP2G2NssgdT0vWQ1M0Tf0Pf53BPvqqJQ9nVCP9EDsj
	 BShkLy/aJv4q3N/JHOSXYwFD6kY9216hnq3qHjGk3WK7z2J4tZa3VE+demV3Lodg/+
	 9oe91T34gqNVi/mSQzHvl3N7yBYdkSCFXNimUIVkjG2MtHKIQnMf675CTwuIHYjC1Z
	 9xb5NGiM/t8c1OdLFOnWpkIPXYXF6PaLeetCCVmzFqaT4QQd7BcyUaAx+aiUtHJNcp
	 KzEwYs3FdMRig==
Date: Fri, 13 Dec 2024 17:38:29 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com
Subject: Re: [PATCH net 0/5] netdev: fix repeated netlink messages in queue
 dumps
Message-ID: <20241213173829.305b8048@kernel.org>
In-Reply-To: <Z1ysi1RHOr3S-40F@LQ3V64L9R2>
References: <20241213152244.3080955-1-kuba@kernel.org>
	<Z1ysi1RHOr3S-40F@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Thanks for the reviews!

On Fri, 13 Dec 2024 13:52:11 -0800 Joe Damato wrote:
> Patches 3, 4, and 5 seem like new features, though. Should those
> three be a separate series against net-next, instead?

Right, this case is a bit disputable. Docs and selftests can't really
break the current release. And someone who backports the fixes should 
be able to easily test them.

Also, thinking selfishly as a maintainer, having them in one series
saves me mental tracking of who promised to send tests via another
tree and hasn't posted them yet.

