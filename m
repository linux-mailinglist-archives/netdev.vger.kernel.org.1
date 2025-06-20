Return-Path: <netdev+bounces-199635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35092AE103D
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 02:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D38754A14CE
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 00:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146AB36D;
	Fri, 20 Jun 2025 00:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XuMA59iR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7B617E;
	Fri, 20 Jun 2025 00:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750378422; cv=none; b=OTFl/xQtm92baX2PvPMq7mCj0zyp6TspKKXwru7cm1lb7agJ7C3GecPAl5W3MxM4fdmCpk+eK4abD7ts3ZI9evr+TSefzT9075oUb+RltKKk6UCvPCc5vfUrHs01WzqvuigsGeLCwrYkL8m5TY7Mr9BbKPAy1PMHZCpA2j8jjes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750378422; c=relaxed/simple;
	bh=HASUCIL9ulPvLyn3zTulpno8DS94ekxO6WW6pn7Y6ms=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VES785xgAz3Ku/+/wihzH4xZ9DCDnYQePe8RkISQIiEYFQHEfSiWPwNqHWcDyKiN6bSxjTx9D3TarVy/8aUXLjGdjMYDAllYozSJ86T0fsO4QJXNeAxYruHd3n8l+vuO9DGMt/0vbdP1Qqorxu7mWJWDTaSJttRUUvamCnR73BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XuMA59iR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63888C4CEF1;
	Fri, 20 Jun 2025 00:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750378421;
	bh=HASUCIL9ulPvLyn3zTulpno8DS94ekxO6WW6pn7Y6ms=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XuMA59iRXoC4OrMM44QnuZF3MM/WJnbYjB9BPDvZrFYPEQ2kNMfGGZz8JnDY/c2jR
	 1812O2iaojg/6koDslMtFlbJTkD6pX5PHKzvjnu0Ldzv8FgnmaBwlvrtyPBeK5Nz8+
	 4/xGmDQnJdjmDVnSj0NIkYBcgp/ONwgujOTQKUeheJhkYL1b7qGBQ5w/aNckMIwpoy
	 kYCYvrKl06oYl/cQEvtnauN2Bt2d6rcACroXBXug0KA2slmpMOipopx+fM7Y42e4DV
	 HxGADf3EBYFtDKsqKN5RZqHJ5AxLgqSC/9BUGkF5qZEDKwthDsxRb1++jgCKXvbh5U
	 QUzHbwlfGzhCA==
Date: Thu, 19 Jun 2025 17:13:39 -0700
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
Subject: Re: [PATCH v15 0/9] ref_tracker: add ability to register a debugfs
 file for a ref_tracker_dir
Message-ID: <20250619171339.1bf28dc7@kernel.org>
In-Reply-To: <20250618-reftrack-dbgfs-v15-0-24fc37ead144@kernel.org>
References: <20250618-reftrack-dbgfs-v15-0-24fc37ead144@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 18 Jun 2025 10:24:13 -0400 Jeff Layton wrote:
> For those just joining in, this series adds a new top-level
> "ref_tracker" debugfs directory, and has each ref_tracker_dir register a
> file in there as part of its initialization. It also adds the ability to
> register a symlink with a more human-usable name that points to the
> file, and does some general cleanup of how the ref_tracker object names
> are handled.

Thanks Jeff!

I'm going to apply this based on v6.16-rc2 and merge to net-next.
If anyone would like to also pull into their trees the hash will 
be 707bd05be75f. Happy to create a branch if necessary, too.

