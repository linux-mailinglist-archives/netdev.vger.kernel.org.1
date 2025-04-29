Return-Path: <netdev+bounces-186884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D10DAA3C14
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 01:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD415189D2A2
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 23:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6DCE2DAF8C;
	Tue, 29 Apr 2025 23:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CgDlLGqh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993782BE0E7;
	Tue, 29 Apr 2025 23:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745969200; cv=none; b=RI3/aLzUo58Cc54A5FjorvSMM77ls8uvHR+W6+GzfuET57GiLQw7Z/7y+rqOnXQro3swggDUC0ya2Osn6hZhZmD3qXN4TVpnGhzXqJFSo9VpsQXzebUXt9DwvTjW23wnYV5HvWgVMBrck7JFrb2dFcQ7n4OppRKNzoIsHyw/U2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745969200; c=relaxed/simple;
	bh=gLU5bTmzAEhOlzZzVyqUxAhX9otof8GitmxtEhirTV4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M754BcycX/0K4UJu4lZv4QPsGiUSWGnKlbFJGluuP64liyuTmhio8YnSintAdMqZA8HZegIrn75kEBaRN8f5ApyQ7t6c5e9IMPGHzwQLoj3NAx1t+xzXn4hhAYPqtshzcccgYbTKUfRts637mIrET9EqEMTdyONGrzTuwr/iO/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CgDlLGqh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A5A7C4CEE3;
	Tue, 29 Apr 2025 23:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745969200;
	bh=gLU5bTmzAEhOlzZzVyqUxAhX9otof8GitmxtEhirTV4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CgDlLGqhAl5Lj7X309PtgVdI8yxsnCfWAIkUGfGdUTqbplV+WJrwhgPq1i9qoIkMG
	 4rLDFaLuwQRW4dBOpQJ+1pFF2FNId/8VJIRU6F/6UKb1J7qlrJbgW+p1VLvfiWiC1I
	 p2CkcgNAkF66dmwhYdJfkEF8JIv1XeCQ1aWlXgu8Od8OmD/WW9BSKG8VrIVcxOYWAY
	 BEqza099VlJKRlWHwm0YpYF+yRFru9oM0Q268xgsA8bt2Mrt5ihKNjaoDsG6b75iOF
	 81qav3ACB6GizH+rN9BmgSOcjN8Vs8fXGYVe+dYkrBJYYhBjTug/6u8eqrHrdgFL40
	 98DJ6F7KdYMxg==
Date: Tue, 29 Apr 2025 16:26:38 -0700
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
Subject: Re: [PATCH v5 00/10] ref_tracker: add ability to register a debugfs
 file for a ref_tracker_dir
Message-ID: <20250429162638.0a8ff24d@kernel.org>
In-Reply-To: <20250428-reftrack-dbgfs-v5-0-1cbbdf2038bd@kernel.org>
References: <20250428-reftrack-dbgfs-v5-0-1cbbdf2038bd@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Apr 2025 11:26:23 -0700 Jeff Layton wrote:
> This one is quite a bit of a change from the last set. I've gone back to
> auto-registering the debugfs files for every ref_tracker_dir. With this,
> the callers should pass in a static string as a classname instead of an
> individual name string that gets copied. The debugfs file is given a
> name "class@%px" The output format is switched to print "class@%p"
> instead of "name@%p".

Nice, I like this version!

Since it applies to net-next now I can point out various (transient)
build issues :)

