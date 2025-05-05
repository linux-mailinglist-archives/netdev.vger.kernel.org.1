Return-Path: <netdev+bounces-187997-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 035CCAAAF02
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 05:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 450C116A90F
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 03:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D411028A719;
	Mon,  5 May 2025 23:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UXAcwsgW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA402DA0EA;
	Mon,  5 May 2025 23:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486177; cv=none; b=M+T+PaijYZ7VKOCXAZWeQiOp9O9apIXXC8ndrMNw0RhfJYe7lJ+fXVlzT6dcEh/wKQwBdXYAR0yLDYUtC7RwOhgSudHWkOCBm8LQkuUQTaUcd7QhgSpAVpjTfbApeQue54NH/P7HmWU/bnDrwm9MDWpX5AW+bba+W5NMPyY2kow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486177; c=relaxed/simple;
	bh=pEmDVUXvc0J46+4t6pQY34qv1kz8YJhrfowiq+L+feA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gIjnDopG3EB3FvNPh07p7ILpgM2cSJHYBy80fHFfTptBzMpgnRIrIDbmxOgvcNwnWFgu1XWgZWNxFn/eFNxvMDeub/AAmAg9ZG7nl3E2Y2jFIBWqy0ZhmnQvMi0WZ3cQ7o9eiC3+daObQgIMgVpRQgedRhWUF0maCwHGe+K1SXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UXAcwsgW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57D1CC4CEED;
	Mon,  5 May 2025 23:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486175;
	bh=pEmDVUXvc0J46+4t6pQY34qv1kz8YJhrfowiq+L+feA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UXAcwsgWa1shdmgMd4J6YmBSb37jGGNWNiDwN5W0hrXuQCM4ei3rTEvGxbYQmpuOB
	 0KBVWAzhLvuusSaEiWughaw8K96UmAZLjNC/a4kn4GhytEsFD5U20nuy1iqQxESjk8
	 Gi5DW2Rm7rhtS96ChJgaN45Ae0+18fi3KuwW5c0F/7RWAKoW4g2OuDJxWCnpIkBgbL
	 upx9EJrnmRlVrUc7RtdRj5ffRPtgry4B/7W6R8zhPWnr91k206yMzaaXfd/pLmZ6K0
	 bjF1J84dHygQUCWIPwmL0vrVaHF+vhB+Eup9PwF2xmqGrhqs/whyzKEoGTBShkWw7m
	 /eyDguntyItSA==
Date: Mon, 5 May 2025 16:02:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, linux-rt-devel@lists.linux.dev, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>
Subject: Re: [PATCH net-next v3 00/18] net: Cover more per-CPU storage with
 local nested BH locking.
Message-ID: <20250505160253.3d50ebab@kernel.org>
In-Reply-To: <20250430124758.1159480-1-bigeasy@linutronix.de>
References: <20250430124758.1159480-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 30 Apr 2025 14:47:40 +0200 Sebastian Andrzej Siewior wrote:
> I was looking at the build-time defined per-CPU variables in net/ and
> added the needed local-BH-locks in order to be able to remove the
> current per-CPU lock in local_bh_disable() on PREMPT_RT.
> 
> The work is not yet complete, I just wanted to post what I have so far
> instead of sitting on it.

Looks fine overall but we're anticipating a respin for patch 5?
When you repost could you split out the netfilter patches so they 
can be applied by Pablo to the netfilter tree?

And there really doesn't seem to be a strong reason to make this
series longer than 15 patches, so please don't add more:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html

