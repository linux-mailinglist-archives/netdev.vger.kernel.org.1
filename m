Return-Path: <netdev+bounces-171489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD55A4D21B
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 04:38:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4E3116CD9A
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 03:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67BFF1946A0;
	Tue,  4 Mar 2025 03:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="FEcBMeAJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E30A2AE8C
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 03:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741059525; cv=none; b=pB2HUAVugCb9HRZYF3qdXc/00OzP9T9AdqJcoc/R2DJDFpcDxlW9n8I1gFUYc/2NplY3dbawXZDNzklLJz2EfMGEdcUtk1fxi2ZYbrxii3+KVXwTeP+GFZDN8fgBsizzMaKm54GVwDz8YCLcebPeHsO6GGo5tEFFnUb3UN9lztM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741059525; c=relaxed/simple;
	bh=Yw3BRhqRHcgvLMM2z9NVQxeCf03io7Nut0QRR3zfBJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kNj/RStw9+GyZsQMgGR0UtVsVjpFCVw0KycpMOBRGpxPL/fhzQ35dJz59XsJFo0hEfo4+Z8poPUYvfbZptQm7H7GWW1zWrIKgk1wTb4DpBEPfj+g4amQUeaYM1AIDSAXJirkCoatibBE7tQoJBwQbrxeyYvqVdiQxeKuv8IPwio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=FEcBMeAJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3D0BC4CEE4;
	Tue,  4 Mar 2025 03:38:43 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="FEcBMeAJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1741059521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Yw3BRhqRHcgvLMM2z9NVQxeCf03io7Nut0QRR3zfBJE=;
	b=FEcBMeAJcjvnDPb1F4rLSx1WyywhovqcVoB0EzrS4k7vVkXk1eiBU7ZZq6JSY7dyyFhSB9
	Kv9yvUjcACd6yn02X/h+PAedr0S2WdOw0UBYfBrop8K2chWNkqaSrd01IKvhNgroHAtuN9
	hTU4wmoJGnLq/bmpuvYfNjC8wNY891c=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id a21336a1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 4 Mar 2025 03:38:41 +0000 (UTC)
Date: Tue, 4 Mar 2025 04:38:35 +0100
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Jordan Rife <jrife@google.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	wireguard@lists.zx2c4.com, Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH v4 net-next] wireguard: allowedips: Add
 WGALLOWEDIP_F_REMOVE_ME flag
Message-ID: <Z8Z1uxRd_kNO6Ibv@zx2c4.com>
References: <20250304003900.1416866-1-jrife@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250304003900.1416866-1-jrife@google.com>

On Tue, Mar 04, 2025 at 12:38:55AM +0000, Jordan Rife wrote:
> NOTE
> ----
> I've addressed Jason's feedback from v2, but have been unable to
> get in touch with him about v3 after several attempts. If there are no
> objections, can we accept this into net-next?


No. I'll take this through the wireguard tree like usual. This patch and
the wg(8) patches ARE going in; I like them a lot. I've been very behind
as of late but am catching up.

Jason

