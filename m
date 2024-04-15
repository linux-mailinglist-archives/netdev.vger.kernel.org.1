Return-Path: <netdev+bounces-87993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 974528A5247
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 15:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AE9C281601
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 13:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E132374409;
	Mon, 15 Apr 2024 13:51:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C517352B
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 13:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713189104; cv=none; b=kG2/z1C+5HowSQgpSREVF69qO3SOvUpEan5KPegk3bLHcQxvtwVciVKPsrzTCFjm0gCuIWbNuCywKxQpYfU4Joh9sa43bczBZ5qIQpWYL0qihvQaJ5OJYCVwmszyvxyir8RWvmDaIMOsPD4ZcGEgNz3k6WQ0Uxw1a1T3K2qlfh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713189104; c=relaxed/simple;
	bh=ymdSbtmN4ja8Uco9kz68ASVywr9aBZbH2f8vREr8AbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cEgoNkwumRmmefJcsZSNwfJeVL8WwC0lYzy6QvKXm6n3ZJUFZzgDTKtHHkbzEfA28fIvgrPYTZP9JPjxCpYgkFgEQ+H3BvQUuXRVQw3hVDcowEePKgg3XfIbXkCApI4NqCeKT8kAhPlDp1SJQBiws35M7J6BPwdLRmHXfBkL454=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id BAC6A300037E5;
	Mon, 15 Apr 2024 15:51:33 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 84A1639E; Mon, 15 Apr 2024 15:51:33 +0200 (CEST)
Date: Mon, 15 Apr 2024 15:51:33 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Kurt Kanzenbach <kurt@linutronix.de>
Cc: Roman Lozko <lozko.roma@gmail.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>, Sasha Neftin <sasha.neftin@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [PATCH iwl-net] igc: Fix deadlock on module removal
Message-ID: <Zh0w5by0atP6XuX5@wunner.de>
References: <20240411-igc_led_deadlock-v1-1-0da98a3c68c5@linutronix.de>
 <Zhubjkscu9HPgUcA@wunner.de>
 <877ch0b901.fsf@kurt.kurt.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877ch0b901.fsf@kurt.kurt.home>

On Sun, Apr 14, 2024 at 11:15:26AM +0200, Kurt Kanzenbach wrote:
> Perfect. I was wondering why you are not submitting the patch
> yourself. Then, please go ahead and submit the patch.

Here you go:

https://lore.kernel.org/netdev/2f1be6b1cf2b3346929b0049f2ac7d7d79acb5c9.1713188539.git.lukas@wunner.de/

You may want to double-check that it fixes the issue and doesn't
cause any new ones.

Thanks,

Lukas

