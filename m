Return-Path: <netdev+bounces-194098-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A89AC7527
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 02:44:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5139D4E6942
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 00:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1EF1482E8;
	Thu, 29 May 2025 00:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CeIcR/mT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CF915D1
	for <netdev@vger.kernel.org>; Thu, 29 May 2025 00:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748479437; cv=none; b=DleQ7nd6IEZyaO+qNnXYcEMHwWoOmV+ki1b4JxTCtR3+Kr0KS9r4asnUN8lL2fXtGl2UKspDrj1JDBqOMcZH2UaYC9adAWEhPEWlrczbWRQUJ0pYhGfB1CSSVxevXbq4hbk859FvyAo5rWpft7gQzisgOXwJ0s4mt2v5BjrQyZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748479437; c=relaxed/simple;
	bh=aw/V4VSRZtXhDtBEDy4kI0aGDDZnQ5nulBC0vAkvaD4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uoGuksHHrMNTyfYovdwOZqKfaWZPbu0j+fRrc7Eu0yYYuAceQCH3JQRR3+sE9Jjvfx1WVz8un8G7wS0ZiLCh0eLXSSQ1UA+4vPCPaFMEdVrCnhp5/8gI6OdzLABqZoySdwaka1YAc9/I5D3xv3cIb2TTOGlwYBBK9AVlbY2aBNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CeIcR/mT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8835CC4CEE3;
	Thu, 29 May 2025 00:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748479436;
	bh=aw/V4VSRZtXhDtBEDy4kI0aGDDZnQ5nulBC0vAkvaD4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CeIcR/mTAOaAmUM5uEnL7EnuEvg7Voy9CcCTu1kHzSdvOnjG1Ek5LtPOzI9wmCakd
	 wtFhIzFY0qv98W/weaoUg2yPmlZLs4WSrZ3xC23S+ONDwUcvoM6lssI4cl6cUbCRxD
	 ml3yhQEc2kpbIzdKzinvCK1RGDhOqqXLU3tbLD/0suFrDXCXZL4yVfEHvZgCzy34mg
	 80nP7mgCaj87LMgIaQhMqgeQ2cWmLyYcxPh3Y3RfMb3Picdc/VLFIB8HrZyLHX0uyX
	 HIVeXbDhtH0CqJ+x+K+C5nIPe7xrG4K7xkeRHJQmiLbUuG0/BRvIyGBNmR0g24/vp2
	 TYemx5h9if3rQ==
Date: Wed, 28 May 2025 17:43:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH] netlink: avoid extra pskb_expand_head() in
 netlink_trim()
Message-ID: <20250528174355.2333a83a@kernel.org>
In-Reply-To: <20250528153628.249631-1-dmantipov@yandex.ru>
References: <20250528153628.249631-1-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 May 2025 18:36:28 +0300 Dmitry Antipov wrote:
> When 'netlink_trim()' processes shared skb, using 'skb_clone()' with
> following 'pskb_expand_head()' looks suboptimal, and it's expected to
> be a bit faster to do 'skb_copy_expand()' with desired tailroom instead.

Looks fine, but it would be useful to add more info about the practical
scenario where this patch makes a difference.

Other than that - net-next is closed, please repost after the merge
window.
-- 
pw-bot: defer

