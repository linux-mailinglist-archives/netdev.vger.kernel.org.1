Return-Path: <netdev+bounces-194981-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B0F6ACD5BB
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 04:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 439C03A38F3
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 02:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10ED73BB48;
	Wed,  4 Jun 2025 02:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cVDEXVN4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF85B256D;
	Wed,  4 Jun 2025 02:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749004706; cv=none; b=RDKhKB0WWxXPK9YqA4hu8eUQkNSTQGYyNedk6Qy+UTFAioXbQ6m2Tjhpslbwi1zWO9G0dM7+AkiTNTC0T+E5D+hxUbxuhGrubcTzHW6F88Y5WYT7j3ICVVt1//sHbrIsG1fc/Z0M/Okml5MZYy6UzE9ZGkeTdxB+47j8t/BIOQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749004706; c=relaxed/simple;
	bh=5LknMU9rKRcy1V8M/qjdNcpnPrDlru7bTCB1snpWuss=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=HQn7qMVSoU/i3w633m5910n/Ro2NybS5uYfUxOSyqPxVitiDlFyHS87HbxdfBpt05kJsvMzILLP3HENwQ05clK8VPB6S5DUqiZ9qk7do8QPoujkDeOr4C7netOeLBD2ZAi758h4Y6sFVlSf6YBdaaFKR05DhYsH8D3ek2Caflas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=cVDEXVN4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89BABC4CEEF;
	Wed,  4 Jun 2025 02:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1749004705;
	bh=5LknMU9rKRcy1V8M/qjdNcpnPrDlru7bTCB1snpWuss=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cVDEXVN4YyJdlsmQA7dMICujsUpBPH9NR59vj/MT7X38O3W19IporL5kJnoQbOUHA
	 77NxCWDe7rZ7oSLnFLw+ZRQwr7FrU1jVQXkj2y7U8Vf04ON3mgM3kZjN+s/VbvWKTJ
	 s0oSTLtTonnbwNwB6PH7Uo6bXB5WUapfie4/rQ74=
Date: Tue, 3 Jun 2025 19:38:24 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, "David S. Miller"
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
 intel-gfx@lists.freedesktop.org, Thomas =?ISO-8859-1?Q?Wei=DFschuh?=
 <thomas.weissschuh@linutronix.de>
Subject: Re: [PATCH v13 0/9] ref_tracker: add ability to register a debugfs
 file for a ref_tracker_dir
Message-Id: <20250603193824.f0ba97cd26e7ed4152a91921@linux-foundation.org>
In-Reply-To: <20250603192949.3a7fc085@kernel.org>
References: <20250603-reftrack-dbgfs-v13-0-7b2a425019d8@kernel.org>
	<20250603192949.3a7fc085@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 3 Jun 2025 19:29:49 -0700 Jakub Kicinski <kuba@kernel.org> wrote:

> > I think the i915 driver is doing something it shouldn't with these
> > objects. They seem to be initialized more than once, which could lead
> > to leaked ref_tracker objects. It would be good for one of the i915
> > maintainers to comment on whether this is a real problem.
> 
> I still see the fs crashes:
> https://netdev-3.bots.linux.dev/vmksft-packetdrill-dbg/results/149560/2-tcp-slow-start-slow-start-app-limited-pkt/stderr
> I'll hide this series from patchwork for now. We will pull from Linus
> on Thu, I'll reactivate it and let's see if the problem was already
> fixed.

Ah.  I dropped the copy from mm.git.

