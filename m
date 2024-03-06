Return-Path: <netdev+bounces-78013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6664873BCA
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 17:13:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13D951C212E3
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 16:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A356C135403;
	Wed,  6 Mar 2024 16:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="czqlx4JO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8014960912
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 16:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709741605; cv=none; b=iwAY8al/7cWe3WkMFnVs/Lch1zny1MKIXbH/aIzXXvIsDR50lJ2/+Ohwqe0/6t23AbJ/Wg/Qtj4xJO6M6Um5ZW8z3uFjL7ccfBqRrKL087kvhJZS1jFs3FVSLzrAkPrSIx1WsvmXlzpnXt4DnEvPGU/ALsHyaqiHHGezcR+O298=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709741605; c=relaxed/simple;
	bh=xiNPVvq6XCN20WYZBLkKWC0Zz3ZQNRYQi0CBtTVTOpc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JloP2hZAtYLnPh7WqMRgEnw4M6Be0NXlYGG5JoVmwh35AmCSoZLpEve/9s8N9jx9h0BAbsSEfS8iRBq79ex9/rdG1vhz+HP14TUdZHXJ1Z3ndeZDiL1KNW01t443DsuIyxQSnKfVXZvaN+yUiygrI2WvCMII/Q4MWUoTTuQ9IUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=czqlx4JO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3C2FC433C7;
	Wed,  6 Mar 2024 16:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709741604;
	bh=xiNPVvq6XCN20WYZBLkKWC0Zz3ZQNRYQi0CBtTVTOpc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=czqlx4JOA5vDarQnP3mjkrZSuMc+Y5kkBYwbE6VfrH3HgWYeXzTtJextY90bl2ZEz
	 j2nm4TTjSqpG+g+KkLiLtHXbOC4Vvupg6epst0TSMw3uHGnjQ86tA3bPumqZ8jTSB0
	 Dld0rLHoJITwbL6qbv4Zj0K6C1rUZyTBTQSjMhT+VRwpn8Q3SH3VhTt6DdsVWZHgja
	 /H+6Z4S/3BLXHyJfUSgYfEikg7rF1W1S4WGSVBZRac26f1wboWaJOLtXTzrz/LY7qM
	 F3F5L6onuRMAe+oMoLgBoC81j9B6L2Su+KQaAbFXs6zcGESx2dnsKXcAr5W2lAj+zp
	 yaVFC15MfxQVg==
Date: Wed, 6 Mar 2024 08:13:22 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Sergey Ryazanov <ryazanov.s.a@gmail.com>, Paolo
 Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next v2 00/22] Introducing OpenVPN Data Channel
 Offload
Message-ID: <20240306081322.6f230dc5@kernel.org>
In-Reply-To: <31c1d654-c5b4-45a1-a8e3-48e631f915ab@openvpn.net>
References: <20240304150914.11444-1-antonio@openvpn.net>
	<20240305113032.55de3d28@kernel.org>
	<31c1d654-c5b4-45a1-a8e3-48e631f915ab@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 6 Mar 2024 16:44:41 +0100 Antonio Quartulli wrote:
> >   - some basic set of tests (or mention that you'll run your own CI
> >     and report results to us: https://netdev.bots.linux.dev/status.html)  
> 
> I currently have a small userspace tool (that implements the netlink 
> APIs) and a script that by means of netns and this tool runs a bunch of 
> tests.
> 
> Is there any requirement about how the test should work so that I can 
> make it compatible with your harness? I will then push it to 
> /tools/testing/selftests/ovpn so that you can pick it up.

Standard kernel selftest rules apply, we try to keep it pretty vanilla.
Test should exit with 0 on success, 1 on fail, and 4 on skip.
Skip if there are any missing dependencies in the test environment.

This has more deets on how we execute the tests:
https://github.com/linux-netdev/nipa/wiki/How-to-run-netdev-selftests-CI-style

