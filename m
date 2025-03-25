Return-Path: <netdev+bounces-177518-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BEB5A706CC
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 17:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C09A1891300
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 16:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6C125E80A;
	Tue, 25 Mar 2025 16:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ggKBePbE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBB825BAAA
	for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 16:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742919849; cv=none; b=VnAbMq1HaOEe8iawAfqBJa00/i8lGou6dRXoUhcWsXfUSymRQS6h8InuYu2dYCOXu6wCyP8mF7uAOpFt65dLQWP2a7Fiwvo1R3kli7m0UJ5TI083oSr3THfWzPoJFaV0d7WxxqwJdy3C6IqNSINR8dyaAc4XfxIcEJWF4iGx4jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742919849; c=relaxed/simple;
	bh=hCjMCSxoS5xwDSZShrGnSk1JHSGVfXw671gCzUPTRIM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R+uhocxi/X05iq8TdwWtiUIdLaFl2m2N+Iepld+C55oX8toeWDtWdJutCVR7bKF5RCLTjNvZtuBABqUdpES9r5SVp6khnQaISK8ZqZWVeOszCO5ij5vSE839p3yWt8xq7tmd1UV/lw+QIPURCYcZGqq1p81PXk3SBSXcyw2/Eqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ggKBePbE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60AE0C4CEEA;
	Tue, 25 Mar 2025 16:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742919848;
	bh=hCjMCSxoS5xwDSZShrGnSk1JHSGVfXw671gCzUPTRIM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ggKBePbE8r9pCZOtCxxW9UlSEHQ9AnR7IE2NTHS5yfr2+hpFm/Cgk1JCjL7kAk+KP
	 /kUX8qzFYjkvKq24vAF8Alom6lDDPYQFJ6MAl8hCESKD63XP0eAL+orOfY4NazzhqJ
	 zy6UhTJ6sZvEGVzF67Hprp4MI6OxbEbHINq8/OJcAoD3e60QBEBavPmNC6PXQX3Cju
	 oU0H0NbakmVSIOWj7Eb6gJVAYtlKGdfWWYjNPlgaDKWD2JqAsvGszKjfXtEnRAIPrX
	 ZhLbaxkmiqPzvllHAcqwxoGLx76gcGvn0FzpNANnDxOaQWgui/W7YyByu7ibT/Afm5
	 eRm533cONzNOw==
Date: Tue, 25 Mar 2025 09:24:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>, Willem de
 Bruijn <willemdebruijn.kernel@gmail.com>, David Ahern <dsahern@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH net-next v2 0/5] udp_tunnel: GRO optimization follow-up
Message-ID: <20250325092401.037968a6@kernel.org>
In-Reply-To: <cover.1742557254.git.pabeni@redhat.com>
References: <cover.1742557254.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Mar 2025 12:52:51 +0100 Paolo Abeni wrote:
> Should this prove to be too invasive, too late or ineffective, I'll be
> ok with a revert before the upcoming net-next PR.

Looks like the conversation isn't dying down and the patches were
merged quite recently, so revert isn't too risky. I'll go ahead
and revert.
-- 
pw-bot: nap

