Return-Path: <netdev+bounces-213525-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E274B25829
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 02:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8878C5A1413
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 00:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468402FF649;
	Thu, 14 Aug 2025 00:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Avusdu/1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2355B2FF64D
	for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 00:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755130819; cv=none; b=eMrY31VuKlvkmkxKCZWBTp7y6MhLSw7tQcz7fGefZ4UlmgYRQDa6GvQQrxm99XR/0i2HFgmUHT4jmiGJKuqV8AKC0rGCK7rA5IJ7lOnOJYUgVeHh1PgvQ1f1K8wrAVtEVvWLVPUKJkXSOQLEyNI214sdC7XMv7GNBZhI8gUtEt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755130819; c=relaxed/simple;
	bh=lQV6PvjD5OLXKSX9pxO3TIO0P9TXKQcWs9Rt8ZRL1Gg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TKXMxVGW/XLLLPK/CJO9Ha0CYtqo2a2iNx1Vqr+LCYUND4PqeXEFC6bNG00Q//SaSWYFgrDv/rN7jKWOp3B5JM8C2StizXV8wKqKFas9ZZNUkOPMwskW/cOsszBn0S1r6G/Rjpkz7FIBC06HYNAk2cQqOQU5P9FnBn2bmUDN3zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Avusdu/1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67D78C4CEEB;
	Thu, 14 Aug 2025 00:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755130818;
	bh=lQV6PvjD5OLXKSX9pxO3TIO0P9TXKQcWs9Rt8ZRL1Gg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Avusdu/120ohZHhcsz6w+jSIWPd8lPgbbeOH62tVbrycPtDybhrhcx55dBQ+Cz+Yq
	 UpxFk6l3cxp0yOYt7DXSs/LyYRQVBFjmiDiZ36C17Jeqelo/pGVs1Gh5Twb3LhgTWk
	 I5TVzLWx6sdDfpZu+NiEsVM5JUP7Pa+HiBKNTPvLOIIUWWbQObDLD3+nzaEH4Fx457
	 MyG71Cd4DsUIlXMJbm2bTqx8rk+L4GqtExVQGiO/F2vBoNCnz237F4Dbgc4clpI8MK
	 cg6vHggKdYHv+cFaDVlnIuk89qFV06reHXgF42lSipNjeBtgDoSpZDXvVbgVd/FV2y
	 u5VbdNrIy/VZQ==
Date: Wed, 13 Aug 2025 17:20:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ido Schimmel <idosch@nvidia.com>
Cc: <netdev@vger.kernel.org>, <bridge@lists.linux-foundation.org>,
 <davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
 <razor@blackwall.org>, <petrm@nvidia.com>, <horms@kernel.org>
Subject: Re: [PATCH net-next 1/2] bridge: Redirect to backup port when port
 is administratively down
Message-ID: <20250813172017.767ad396@kernel.org>
In-Reply-To: <20250812080213.325298-2-idosch@nvidia.com>
References: <20250812080213.325298-1-idosch@nvidia.com>
	<20250812080213.325298-2-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Aug 2025 11:02:12 +0300 Ido Schimmel wrote:
>  	/* redirect to backup link if the destination port is down */
> -	if (rcu_access_pointer(to->backup_port) && !netif_carrier_ok(to->dev)) {
> +	if (rcu_access_pointer(to->backup_port) &&
> +	    (!netif_carrier_ok(to->dev) || !netif_running(to->dev))) {

Not really blocking this patch, but I always wondered why we allow
devices with carrier on in admin down state. Is his just something we
have because updating 200 drivers which don't manage carrier today
would be a PITA? Or there's a stronger reason to allow this?
Hopefully I'm not misreading the patch..

