Return-Path: <netdev+bounces-194067-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC84AC72E9
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 23:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5F4B9E51AE
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 21:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1F420AF62;
	Wed, 28 May 2025 21:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j66ZH4aC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AE7258A;
	Wed, 28 May 2025 21:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748468853; cv=none; b=TOJkbueZ/+STjhcKvx6d+STjt83WTptd1+fnbsCEgWjP3szMThGlFpdGerU2+dKFkjCypOU5V+OP1qQiS1sXCkRrDIHekkhEnVyfM4sB3vW0XLR1X89GhGVjir6/eb7YukmmMpEgOk4FXNCEtMcX2Hum++GpkDKmwM5/0P8ak1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748468853; c=relaxed/simple;
	bh=nuz0o0BGLyrSP915wdaM0jKsDNSUMxNsELda8wm1SiE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kaFqMxESE3Yw9Lw8q95pA53V58jij+/7yQ1eG87IlCq2v+O+CoWj6Q6p6OOfrQQ27GqNiM/CWkI7pCtXBRs2E5zmII+2corCNSujldSq+px2b56BSa4X5m83A9bJagRs9E30kgoaY6cit2RGEDG5Xf+AqTYP3QrOtNaMI+uZmQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j66ZH4aC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBD22C4CEE3;
	Wed, 28 May 2025 21:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748468851;
	bh=nuz0o0BGLyrSP915wdaM0jKsDNSUMxNsELda8wm1SiE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=j66ZH4aCk4nt9Y7OjMFjdnQMYLSLJMVrWU0QsR4oGgbTZ68S1L4GrjKy6xWyVy9qW
	 m1+IbaRuOnK3v9IbtKihJs9DuSa8gErD5IKcIROVkl8B9pK8lMdajwomDUFJ6bocKd
	 1FaPOwGScP+rnGVrBM8c0nILi8KSX9F05IuRF4aaP+wcxnENgqIH/75miinJbkkyiJ
	 iz4iyKGe5e9y5OadzWnHU7gGjas47wXMZxVIQL62OB9nXnr1ZO8Xd7XDH0/oTv7cxo
	 CoutemBqrTnC8bdFs56x2TExoIQ7ZGeiVVtzPQ4SInq1P1Mcx9giiO21NXTRLLZ+uA
	 qAjhxgb6V7SwA==
Date: Wed, 28 May 2025 14:47:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>, Kuniyuki
 Iwashima <kuniyu@amazon.com>, Qasim Ijaz <qasdev00@gmail.com>, Nathan
 Chancellor <nathan@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, Thomas
 =?UTF-8?B?V2Vpw59zY2h1aA==?= <thomas.weissschuh@linutronix.de>
Subject: Re: [PATCH v11 00/10] ref_tracker: add ability to register a
 debugfs file for a ref_tracker_dir
Message-ID: <20250528144730.57741830@kernel.org>
In-Reply-To: <20250528-reftrack-dbgfs-v11-0-94ae0b165841@kernel.org>
References: <20250528-reftrack-dbgfs-v11-0-94ae0b165841@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 May 2025 10:34:32 -0400 Jeff Layton wrote:
> Changes in v10:
> - drop the i915 symlink patch
> - Link to v9: https://lore.kernel.org/r/20250509-reftrack-dbgfs-v9-0-8ab888a4524d@kernel.org

Hm, I reported the refracker warnings at boot on v9 :
   ref_tracker: ref_tracker: unable to create debugfs file for net_refcnt@ffffffffb73a98f0: -ENOENT
   ref_tracker: ref_tracker: unable to create debugfs file for net_notrefcnt@ffffffffb73a9978: -ENOENT

Did you decide against fixing those? 
Or did they creep back in?

