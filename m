Return-Path: <netdev+bounces-211088-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F54B16935
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 01:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 339654E7351
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 23:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D97A22A4DA;
	Wed, 30 Jul 2025 23:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mN9MfhjT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04997376;
	Wed, 30 Jul 2025 23:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753916880; cv=none; b=sLn3fY4ngXKb8QFNaLi0Jrk6tIZ8zCFUETEfDSYM9xPrptYvxblenT6i992VydVfiHbHoPDKbAbrMOFq3PSQTj5qjuNTJLAkRMsEZOnyzKjA0keP/Zj0GMB8rUSF0CjADllbo147N7AbQ1Xoth89Ily83IMDrmx1DzKH7b4WxjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753916880; c=relaxed/simple;
	bh=zzjnzxC1bl9JFaBe32DCTnSQkUzSkshMzgbbgw6ZEMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qQIlnp3VK6F3NpaSglEiYu9iRwQaZeWSonrlM7ZVccZ4C0ZTmJQNzBMzhGIEazWdCNLKr9ShMPc8P74zFIHEpfPn4+q2skU3jjohEHLlljer4A2FrwmhZiFjSyEJhHXhmpUPY3T+oN/rnAtcURfj5r+qb2CUnUFWQ+zx1qfiQrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mN9MfhjT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CFABC4CEE3;
	Wed, 30 Jul 2025 23:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753916879;
	bh=zzjnzxC1bl9JFaBe32DCTnSQkUzSkshMzgbbgw6ZEMs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mN9MfhjT+/YVyTMyWJLvfNo0eu+njIpdeOca+ciB1jMjxGPPBjFdK1mkMyxSmSAYp
	 Cj73hk3g3w81+yK0sinTnoDYcsitkpw9BUTGBJF7Wrq/8hJIqSmJlqIFmQijX82occ
	 nERVS98Xurmxr2m4x1gka7Zgf7hh2SB8CTiLLNlmh0EUKHIHBl+QD533eSgMiMHqch
	 HsD6aNHrWPUP5ufPnToBhwJHpMHHiKxaKy4v7c8Wr+rF/5Z8fqej+a73kGQr26N7zq
	 gwbqTceMDvY3glLoJ0Tc5/vxm6TKhyQNur0Nb9ou35jrmzy11QU8kaI3tFd6C+Rfji
	 cl9TgwKzCSxdw==
Date: Wed, 30 Jul 2025 16:07:59 -0700
From: Kees Cook <kees@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Krzysztof Karas <krzysztof.karas@intel.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Qasim Ijaz <qasdev00@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH v15 6/9] ref_tracker: automatically register a file in
 debugfs for a ref_tracker_dir
Message-ID: <202507301603.62E553F93@keescook>
References: <20250618-reftrack-dbgfs-v15-0-24fc37ead144@kernel.org>
 <20250618-reftrack-dbgfs-v15-6-24fc37ead144@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618-reftrack-dbgfs-v15-6-24fc37ead144@kernel.org>

On Wed, Jun 18, 2025 at 10:24:19AM -0400, Jeff Layton wrote:
> [...]
> The file is given the name "class@%px", as having the unmodified address
> is helpful for debugging. This should be safe since this directory is only
> accessible by root
> [...]
> +void ref_tracker_dir_debugfs(struct ref_tracker_dir *dir)
> +{
> +	char name[NAME_MAX + 1];
> +	struct dentry *dentry;
> +	int ret;
> +
> +	/* No-op if already created */
> +	dentry = xa_load(&debugfs_dentries, (unsigned long)dir);
> +	if (dentry && !xa_is_err(dentry))
> +		return;
> +
> +	ret = snprintf(name, sizeof(name), "%s@%px", dir->class, dir);
> +	name[sizeof(name) - 1] = '\0';

Yikes! Never use %px, and especially don't use it for a stable
identifier nor expose it to userspace like this. If you absolutely must,
use %p, but never %px. This is a kernel address leak:
https://docs.kernel.org/process/deprecated.html#p-format-specifier

"helpful for debugging" is not a sufficiently good reason; and "only
accessible by root" has nothing to do with kernel address integrity.
Those kinds of things are (roughly) managed by various capabilities,
not DAC uid==0.

-- 
Kees Cook

