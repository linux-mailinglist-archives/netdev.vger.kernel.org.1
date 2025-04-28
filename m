Return-Path: <netdev+bounces-186446-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52879A9F1DE
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 15:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B41D465F90
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 13:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F302226B0A7;
	Mon, 28 Apr 2025 13:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="FaSybVNo"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D28026AA9B;
	Mon, 28 Apr 2025 13:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745845763; cv=none; b=HC7wcQzWJDNf6Cwb4nw8UkOeMwh8xWlpNOtNRN4sEutO2qQFhbR5UHL6zf3ejohYx3fMNFgnPi1hfusZHGpu+KmTalrAs9UPPc17G8hj955q46QIf+2x9gRxbGMMh/ebG5XfwWxXBvsA1VE17R6Vlrp0K7JU2d4bhXbkpC+PvX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745845763; c=relaxed/simple;
	bh=M+ne17Ci8brxxiF6zM2rjTZTd+6eE6S53IATKk1fCQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TFI6DPz6uryHSXTkpVXiVJDPuogdD4Kdq7IaImMz30W8J1HKVHXK0auEAkXVnTksD6vd//g+1hr/mB3Ewgl9DA3UmoMP1qUTSXX+MlvXAhYTjgIMg1bfqTKpuYLMqLEMVsm+9jMX0Dz/8QB5K1j+PQu7c0vRmcbmMjyHzsBY8EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=FaSybVNo; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=9Dq8il2QJNNgK3JIhgsqHC5a3nDdTbM2zOFlHUgijkE=; b=FaSybVNozzltaC14aUqmbcgt7y
	Ry69yPSwDlEEfEpJgy/T7a/k3kXWsdnlq+M9gmMV9MmMo92AH3up/yNsbuXjsYkheGfSTqvgrXnHW
	60EaAhb8WpiwK64uaEJcj+JflBc1XN92ZRhDvsJzlKuOP6C0BDKcaRY0zBpARWXECuqQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u9OET-00Aq9T-Fg; Mon, 28 Apr 2025 15:09:13 +0200
Date: Mon, 28 Apr 2025 15:09:13 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: mattiasbarthel@gmail.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, wei.fang@nxp.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mattias Barthel <mattias.barthel@atlascopco.com>
Subject: Re: [PATCH net] fec: Workaround for ERR007885 on
 fec_enet_txq_submit_skb()
Message-ID: <0367ef43-e061-4e2b-a3ef-acf292a7469f@lunn.ch>
References: <20250428124325.3060105-1-mattiasbarthel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250428124325.3060105-1-mattiasbarthel@gmail.com>

On Mon, Apr 28, 2025 at 02:43:25PM +0200, mattiasbarthel@gmail.com wrote:
> From: Mattias Barthel <mattias.barthel@atlascopco.com>

This version 3? I hope you can see why there is the 24 hour rules.

Also, please put the version number in the subject.

https://docs.kernel.org/process/submitting-patches.html

    Andrew

---
pw-bot: cr
	

