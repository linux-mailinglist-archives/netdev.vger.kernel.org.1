Return-Path: <netdev+bounces-158568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E28BA12872
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 17:15:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A354C160D2A
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 16:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F9D1953AD;
	Wed, 15 Jan 2025 16:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FYcpxs4T"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8003194AFB;
	Wed, 15 Jan 2025 16:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736957608; cv=none; b=sWRGHEy/jmtg1iVnCx3OG52SEJdfTgPghpifzYGqjXuWXp+Nc5KHJj9FEPkf7PeQapb4cEFcRNdMwhfixqGYB2jEcHqQwW63EkUpj5DPbTZ7vA2G5SDkYLBKbX4PrEvqOY09KgiryPGt2eWTRr/6sPArqqPUPMq6PaE5YLKCiwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736957608; c=relaxed/simple;
	bh=H27/EeLGtoVg4ekRM18ftjJ6P6b82+NT+767+nzhbEk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ef1CPIvqmFK+TFscajVrxgzzBsT1HiH8/xpTYB9VYgbc9KYIHL8p+BTbv7Z4nQ+WXKKgDbI3b+Is/+CyT6THmgLhX+roWTRjgDEKtDj8OMfRDMSK6anZYyHMh/CtWeFIyQQ6TP1Q7qivYsBz5aXpBaY9rpC19wX97SXMGLramyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FYcpxs4T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F4FEC4CED1;
	Wed, 15 Jan 2025 16:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736957606;
	bh=H27/EeLGtoVg4ekRM18ftjJ6P6b82+NT+767+nzhbEk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FYcpxs4TvVVFy3+OEhnXhnhCFwZnmbiOlWWHTIwFcr1dS1RqKoYGjxVmiGLAt9prf
	 yO9LgauIH2PwDwxm5W0gZstsZ0RMh1/71f/bvRgF3klyEdcm0noY3/LpkbqhaUHvtU
	 aIq4Gln4QsWJT6m+eMqu3sq9HkqGrz5wFC0hAeQtS2yigEI5lpojkZSspf0ApkDFEc
	 TRO3vHEgQv9nSG8X2lkQt6WF2Nw+F2uIibIBLrX+7XVITqJdK9j85FksUSziQnPsGu
	 l06ShVbE2vK5hRty3ilo8oRs6Rwnp7HpSQvZdsYqozISofkej8/Kh1A9+n6+qySMXZ
	 jQpsBq/7bkZ/w==
Date: Wed, 15 Jan 2025 08:13:24 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Li Li <dualli@chromium.org>
Cc: dualli@google.com, corbet@lwn.net, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, donald.hunter@gmail.com,
 gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
 maco@android.com, joel@joelfernandes.org, brauner@kernel.org,
 cmllamas@google.com, surenb@google.com, arnd@arndb.de,
 masahiroy@kernel.org, bagasdotme@gmail.com, horms@kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 netdev@vger.kernel.org, hridya@google.com, smoreland@google.com,
 kernel-team@android.com
Subject: Re: [PATCH v13 1/3] tools: ynl-gen: add trampolines for sock-priv
Message-ID: <20250115081324.77cf546f@kernel.org>
In-Reply-To: <20250115102950.563615-2-dualli@chromium.org>
References: <20250115102950.563615-1-dualli@chromium.org>
	<20250115102950.563615-2-dualli@chromium.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 15 Jan 2025 02:29:48 -0800 Li Li wrote:
> From: Li Li <dualli@google.com>
> 
> This fixes the CFI failure at genl-sk_priv_get().
> 
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Li Li <dualli@google.com>

No, no, this is a fix. We'll try to send it to Linus tomorrow.

