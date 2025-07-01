Return-Path: <netdev+bounces-202789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77740AEF02A
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 09:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE1453BC8BC
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 07:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B4D2620E4;
	Tue,  1 Jul 2025 07:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dflVcLuI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7746425A655;
	Tue,  1 Jul 2025 07:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751356357; cv=none; b=i4AdjBUaIdJlX/gLq4Q8yO1ruMzMITDMjqNgunEaQjiE1GeMkr69b/FxbrixT9XKehOKVy6YuAs/p/Y5dL5oCgI8fMDWAQQk63xSn8YDpv/AKR++iyPHGAdDrSpxcUELMX5xAXI9k+f41mQbYMIpXrzRWLuDV3qM3qmuvAouI2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751356357; c=relaxed/simple;
	bh=GC0l50J4RGAmBkxPUPVkSKc7Gg6maGMh/ExAKh4C2uo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tfURwJQDAwT9T9dd5aUfYJkia1ACMW/BH3Sji7SFYOAPOaNGlIZm0VDq4SEwrwC78OTpy0SBCDYoTmI/ptWI/nhWrY/N/ukCqupxeF2Spx9t9FEdKniPPMx9unq2UDfJOn51mFuLG91CaR/s5sV0YgnQBYCDgDggPFGyDMjdaFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dflVcLuI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D229C4CEEB;
	Tue,  1 Jul 2025 07:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751356355;
	bh=GC0l50J4RGAmBkxPUPVkSKc7Gg6maGMh/ExAKh4C2uo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dflVcLuInnPYyU69wjjHMp573MbW8rdkx+/xngrKP70A3LEtsagc6z5O2/oRQJpj3
	 GCJvw1pOAqi7jhmb7anww4l3OoKjimfG81KCHGzgjHg0R1Pdq3qmCk/aYKp8AOVMGk
	 1jdCm8XD/Qs1edGOdQZeUU7I+HUqhD0YTr2z1MjEsWveiHT7eUocvmz527U7LjHoVz
	 umTn2rUOEcEx8UCFPVZCev3Y2Ln2JlZo4OiEjUHTIeoSaZsZ+oHiQH+hUDOLW6dujF
	 jx8X+q8ZY4x0OcqzxtSV7E5tYwb+uQLCgXxrOoYYriOPV+tDjgkz845Xur32weCVBg
	 M/GluuBHMs1tQ==
Date: Tue, 1 Jul 2025 09:52:29 +0200
From: Christian Brauner <brauner@kernel.org>
To: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc: kuniyu@google.com, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Leon Romanovsky <leon@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Lennart Poettering <mzxreary@0pointer.de>, Luca Boccassi <bluca@debian.org>, 
	David Rheinsberg <david@readahead.eu>, Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: Re: [RESEND PATCH net-next 5/6] af_unix: enable handing out pidfds
 for reaped tasks in SCM_PIDFD
Message-ID: <20250701-feiern-biegt-f454cb8b0d04@brauner>
References: <20250629214449.14462-1-aleksandr.mikhalitsyn@canonical.com>
 <20250629214449.14462-6-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250629214449.14462-6-aleksandr.mikhalitsyn@canonical.com>

On Sun, Jun 29, 2025 at 11:44:42PM +0200, Alexander Mikhalitsyn wrote:
> Now everything is ready to pass PIDFD_STALE to pidfd_prepare().
> This will allow opening pidfd for reaped tasks.
> 
> Cc: linux-kernel@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Simon Horman <horms@kernel.org>
> Cc: Willem de Bruijn <willemb@google.com>
> Cc: Leon Romanovsky <leon@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Kuniyuki Iwashima <kuniyu@google.com>
> Cc: Lennart Poettering <mzxreary@0pointer.de>
> Cc: Luca Boccassi <bluca@debian.org>
> Cc: David Rheinsberg <david@readahead.eu>
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
> ---

Thanks!
Reviewed-by: Christian Brauner <brauner@kernel.org>

