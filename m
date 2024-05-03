Return-Path: <netdev+bounces-93371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C178BB5D5
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 23:35:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96874B241A4
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 21:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF11354903;
	Fri,  3 May 2024 21:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="id/eOmW8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EF04F8A1
	for <netdev@vger.kernel.org>; Fri,  3 May 2024 21:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714772060; cv=none; b=lXgGp1gH33k8+58sG5yXMB+77wRQmevFzQjtuhoioqYMZtR4SBMG63TWF7sKnqGdcirpzS0OyHKEi9xPth9VEWADjuw2uSB0cBSZgVQBgNy1dn9q86wHDIVO3gpF2VVOeWBhsPo8NuPK1RvIPTBtP/wFQGL8/2CyoT6IAo0jeE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714772060; c=relaxed/simple;
	bh=f6tdBMA1P3KWRfymXGsytzY/zKn2r1yS8Rl972jsOpg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BzKlACz60txvxLpNXbu1R0uboahfs16Ob1uGyXL+B3KUaQ6O3JvNd0FtJm6ELiy19Ut34Y3Zilahnan20mNtrr9HtV6vN1Of3A0hkPi1O9gF2/TKU7hYn6c/lUwYQwo/mcB3dQMccNctN00cD6J0Aw1K87FEOqoV/nw5FMsraQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=id/eOmW8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23895C2BBFC;
	Fri,  3 May 2024 21:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714772060;
	bh=f6tdBMA1P3KWRfymXGsytzY/zKn2r1yS8Rl972jsOpg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=id/eOmW8NoeLP/PiJiSe9M5raOveYcE+aPYv9SIlFLYRxOi3bVkNGA5QFNhvJMoHy
	 wa7dErCZcE0PplwE7XLupiIrGdhhAZDv4hrwHvfKssxmR+btUvT2pEwfK8vu3hulc/
	 NkfpxErMmUSxkLC08JDRPmxgJv2izAdwBOGo0zePhYWrYSKVX0CWpw9Ie6LcimNpU+
	 tJkKhddLAPHmJRGkJ+/OAaCG1Ia5CFQre+nqgLoK6rlhGjeMDDRH2PTX8Y3TgcvTWk
	 lDOQApjGnrW5KNGe5hblvHyRwcoqPhzBHjzPLTzsVPXGAKaPx28DmxCn25VKZOIThx
	 gEAS+nVKa71lQ==
Date: Fri, 3 May 2024 14:34:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yun Lu <luyun@kylinos.cn>
Cc: syzbot+1acbadd9f48eeeacda29@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com, netdev@vger.kernel.org
Subject: Re: [PATCH] net/sched: taprio: fix CPU stuck due to the taprio
 hrtimer
Message-ID: <20240503143419.2f2093f2@kernel.org>
In-Reply-To: <20240503091844.1161175-1-luyun@kylinos.cn>
References: <00000000000022a23c061604edb3@google.com>
	<20240503091844.1161175-1-luyun@kylinos.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri,  3 May 2024 17:18:44 +0800 Yun Lu wrote:
> #syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.=
git  master

Why are you CCing netdev@ on this? =F0=9F=A4=94=EF=B8=8F

