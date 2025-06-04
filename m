Return-Path: <netdev+bounces-194980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B94EACD5A1
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 04:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D4361899F51
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 02:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4DDC8632E;
	Wed,  4 Jun 2025 02:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cb1ohwlp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC5327462;
	Wed,  4 Jun 2025 02:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749004191; cv=none; b=H/l/yzZ1y3DTk0/Y+/MvIg9PKjk1SuOUKazhOtn07JlraK/72XdXYM7FVK1xbNLgLWR+TGyVHQjdehSIFsUWdH/5wnYvKOpCBmfj9jTv9+kEaV7Q6CpUFoYYXdU+FAenA19nfnrKNXOMdUKFUFuvt0POqxfgUXp432zj1RCQCCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749004191; c=relaxed/simple;
	bh=bPqB4UZU6V2fT7jBdDYxwFtvGjfygIA1UIxiMxSiYi4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EwQ+176ZcY81wBz8Rvf0u+js5ewVjjRXDXSSDn0L5kyzafPHcOmkgFEIpCeSC9ke/r234qCwXORVwIV3vtNvdLZdC5EU+y4ibeha+PCkpe99/LNNikW30K11YRUNP7E+mK76aY1LODR5eNi5EQej1k9lomSkEkrAbtvU7MkvkkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cb1ohwlp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 327BFC4CEED;
	Wed,  4 Jun 2025 02:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749004191;
	bh=bPqB4UZU6V2fT7jBdDYxwFtvGjfygIA1UIxiMxSiYi4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Cb1ohwlpgzrn2LhpNWN9eSYPo632mfVce3z+QmIb31Ycm7qWykyjpbyuBRd8porrQ
	 DN6aG/r6DntLjj7aAMoCw8yzFKlQ5Y+t5nt8SXZd2gIWdE4whVNA68hyTmeQrU4V+B
	 ZBMVPfrJGmN5LEZcQm13UliqEQEm+7aBIZWm2lbyZ7T61I+Puj37un75lo9qyq4TND
	 bC0rdTS64c9HmoIix8EU+KFY9lm9DdWV1vsq3HEHMScaeRst7JXJDpvhdzBb8m1TU7
	 r0IsZPBrLEbM2GtVExYC/BNRT2AjA9skoeRlT92Z+JszUNQUPf3VO245g1s1+N6muI
	 v+M/uhmVxT38g==
Date: Tue, 3 Jun 2025 19:29:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>, Krzysztof
 Karas <krzysztof.karas@intel.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
 Qasim Ijaz <qasdev00@gmail.com>, Nathan Chancellor <nathan@kernel.org>,
 Andrew Lunn <andrew@lunn.ch>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, Thomas =?UTF-8?B?V2Vpw59zY2h1aA==?=
 <thomas.weissschuh@linutronix.de>
Subject: Re: [PATCH v13 0/9] ref_tracker: add ability to register a debugfs
 file for a ref_tracker_dir
Message-ID: <20250603192949.3a7fc085@kernel.org>
In-Reply-To: <20250603-reftrack-dbgfs-v13-0-7b2a425019d8@kernel.org>
References: <20250603-reftrack-dbgfs-v13-0-7b2a425019d8@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 03 Jun 2025 07:27:11 -0400 Jeff Layton wrote:
> For those just joining in, this series adds a new top-level
> "ref_tracker" debugfs directory, and has each ref_tracker_dir register a
> file in there as part of its initialization. It also adds the ability to
> register a symlink with a more human-usable name that points to the
> file, and does some general cleanup of how the ref_tracker object names
> are handled.
> 
> This reposting is mostly to address Krzysztof's comments. I've dropped
> the i915 patch, and rebased the rest of the series on top.
> 
> Note that I still see debugfs: warnings in the i915 driver even when we
> gate the registration of the debugfs file on the classname pointer being
> NULL. Here is a CI report from v12:
> 
>     https://intel-gfx-ci.01.org/tree/drm-tip/Patchwork_148490v8/bat-arls-6/igt@i915_selftest@live@workarounds.html
> 
> I think the i915 driver is doing something it shouldn't with these
> objects. They seem to be initialized more than once, which could lead
> to leaked ref_tracker objects. It would be good for one of the i915
> maintainers to comment on whether this is a real problem.

I still see the fs crashes:
https://netdev-3.bots.linux.dev/vmksft-packetdrill-dbg/results/149560/2-tcp-slow-start-slow-start-app-limited-pkt/stderr
I'll hide this series from patchwork for now. We will pull from Linus
on Thu, I'll reactivate it and let's see if the problem was already
fixed.

