Return-Path: <netdev+bounces-230056-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 04601BE35DD
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 14:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A99194E1318
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 12:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EADB032BF4E;
	Thu, 16 Oct 2025 12:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M3bwPmMl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C648A31AF00
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 12:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760617743; cv=none; b=WAyTfwjMPAyRXpG0cFuUO7627vM8glWwXmakcWr5ofx6N504RgPpIv4bGoYYOao+doksSI6FRixIgt3pC7sCMBCodlAAqH2snYI8T5w0BO+1MLkPRoKUnljICQS+3gk1WBJHwAupeyz31dCNWlOOsPtr82hz+TT61V1Ewvp1O2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760617743; c=relaxed/simple;
	bh=fiGEWIZNMeRJF/oGopyMFJLZi5LTITrLPrvghw8+xHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hfTlcfRUpf2+Yaw8QP9xD3kEOcd0X7zKMVVROeVEhCTka6zK3Ln9kMYvYbmTifKaevchs45zZkhhw7lW/JHzRgSQSAHRyqNgPHWuGUK01iCzUizL/7K1JZSFZ0Y3WZHs/Iy7H7U1UjhMgENCbIWrlk/OLCmQJgVk4AgbTM/fZjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M3bwPmMl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE708C4CEF1;
	Thu, 16 Oct 2025 12:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760617743;
	bh=fiGEWIZNMeRJF/oGopyMFJLZi5LTITrLPrvghw8+xHA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M3bwPmMll55M1Oz4fkhtVmqA3UcwBCAjbUIqFSQziBhbotUVL100pk7SQPg2hErw9
	 /eI3uCetRc+3tJz4M3kS+I+DXQS+2Wc0ZrCmSRFj/ViOtdiuPiBoU+oZI6CeXIbYwe
	 68TdwOMm7n+Zj9wS4w6pvW7Ps4akYooodfrOKT/p0Cm/wzrQKqnxvelQd/2RNTmSM5
	 EvlKbH9+w4G1RdV967TcHDzNm2zIVJSXcCD5GREJ8koLaTD4KU4OTAZSiEG2009Hpq
	 nEPuflnbcg1fJ3PGnTGiuRTlN1DWuVXLZ8Cu8IiPnERfhnf6E2xGRoe5udY1DXfACg
	 burgwcPCvUNXw==
Date: Thu, 16 Oct 2025 13:28:59 +0100
From: Simon Horman <horms@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Realtek linux nic maintainers <nic_swsd@realtek.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] r8169: reconfigure rx unconditionally before
 chip reset when resuming
Message-ID: <aPDlC12BWk6Q_bTY@horms.kernel.org>
References: <418fbd41-6ec5-4c86-9bc3-e68d3333913f@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <418fbd41-6ec5-4c86-9bc3-e68d3333913f@gmail.com>

On Wed, Oct 15, 2025 at 10:12:44PM +0200, Heiner Kallweit wrote:
> There's a good chance that more chip versions suffer from the same
> hw issue. So let's reconfigure rx unconditionally before the chip reset
> when resuming. This shouldn't have any side effect on unaffected chip
> versions.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Hi Heiner,

This patch looks good to me. But I think it needs to be reposted - so that
it applies to net-next - one net has been merged into net-next so the
following patch is present.

commit 70f92ab97042 ("r8169: fix packet truncation after S4 resume on RTL8168H/RTL8111H")

Please feel free to add.

Reviewed-by: Simon Horman <horms@kernel.org>

-- 
pw-bot: deferred


