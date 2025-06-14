Return-Path: <netdev+bounces-197691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C41E2AD995D
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 03:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C9F317C909
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 01:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5436079D0;
	Sat, 14 Jun 2025 01:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qXpdVQOg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FD72E11AE;
	Sat, 14 Jun 2025 01:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749863786; cv=none; b=s5yLUKGWI0LfCaj4aLzhxj/kuJQ+KRZdBmrTifD3V/Kl8hLWfBYVHAHHqbcVO1kW2c70YSWnpocpZrQAVnX4lb9ntqj7MwoTGUsEkP+iXyS29omh4yuFuLuFeSoVWX1aeGt5jhTGHz0+QyaVzYxIzhaoiOCk8KeKaqBb/GMRTM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749863786; c=relaxed/simple;
	bh=AaF8N7xPt/4+gyAd6e71qc7Xjriu4g8VE4OQmpPUhm8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qx/O/bSysFI/Ok+ka2R1tY36f49i6Z/Eqp8tM9faEva83jU/7HoWOZW9lo8ne2yjv1Y+ra2tv6QsE2wfT6GHV6h8p+9QMmLAE6SEU/CStajXN82Tyqr6dk5gDhPp55yIw3YNzfsMezQbcOr0U6u9YtRQkRL3wgFZWGvwxtzfPek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qXpdVQOg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39BCDC4CEE3;
	Sat, 14 Jun 2025 01:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749863785;
	bh=AaF8N7xPt/4+gyAd6e71qc7Xjriu4g8VE4OQmpPUhm8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qXpdVQOgzZBok1z2w5NjwFVivBAn1919p4GFR9bSYe7dbVSqOKc1yFG38alcBdE0D
	 Vs4LXSahIJHyK0O1NDXXRxyCZovbbN+Yc88OBVVve1lfhO9JvPAW8N3fSCdsMGf6FV
	 v5xm/B53pm84Gre20WWX/kUlQAoPo3INAI01DH5lPxq3+qyAeXfLsSIAu5aTYoVPV8
	 H/JeC2HS3+M8nxLN5E1Mw1mM2m7JKviuXyICNaNj6hBLw9eVKk/nZNx7UxCavNPfkr
	 fiV7FUVB+l2hibEjOvK/Vhxb8aHJlL/LChUu3IQDgY0y1/9Xsg1b4vjexN2J/1FJj7
	 UDqQaTbBMDgjQ==
Date: Fri, 13 Jun 2025 18:16:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Pranav Tyagi <pranav.tyagi03@gmail.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, skhan@linuxfoundation.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH v2 net-next] net: ipconfig: replace strncpy with strscpy
Message-ID: <20250613181624.5684fc0b@kernel.org>
In-Reply-To: <20250612114859.2163-1-pranav.tyagi03@gmail.com>
References: <20250612114859.2163-1-pranav.tyagi03@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Jun 2025 17:18:59 +0530 Pranav Tyagi wrote:
> Replace the deprecated strncpy() with strscpy() as the destination
> buffer is NUL-terminated and does not require any
> trailing NUL-padding. Also increase the length to 252
> as NUL-termination is guaranteed.

Petr is making functional changes to this code:
https://lore.kernel.org/all/20250610143504.731114-1-petr.zejdl@cern.ch/
Please repost once his work is merged to avoid unnecessary conflicts
-- 
pw-bot: defer

