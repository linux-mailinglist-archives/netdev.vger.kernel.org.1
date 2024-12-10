Return-Path: <netdev+bounces-150679-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3FC9EB2BC
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 15:09:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7937188A54E
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 14:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A771AAA02;
	Tue, 10 Dec 2024 14:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FM39Fpu/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1A378F36;
	Tue, 10 Dec 2024 14:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733839646; cv=none; b=R2iDJmma3HvpQjVNGunFeNrKiGHn7SxZvkbrFblWd+Mwtoy8MbxleiOi6eKHeI90BYp4ZA904GzC+htX4HxtH8eJBPUcmvpjqeoJi0b9OjmvqQOZu1h8nqKSeEVUFq2xToXtcg69+SQhJEHhG/bqUYmhezZgfBYVEjA5pVCPzhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733839646; c=relaxed/simple;
	bh=/wBby0ZaQ5upXhJFQV1aKko4D11BdDLGyQDqBZJw7ng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=se1jxl3dhC4F8lGZFh6wIAHNYHPt8V31nZyHkN5V17esaevi0pomk3X097nPHFJWiJPlsJl7x+qzicFqdybmxVrUtYzQi7LkDYb3UDQX+FQZ1fDZqiJj6CwgeSv/7AZbkFcFXP98sa5pqrosZlzWH52TtL/f+dnJqYG/pbyfOY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FM39Fpu/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9867FC4CED6;
	Tue, 10 Dec 2024 14:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733839646;
	bh=/wBby0ZaQ5upXhJFQV1aKko4D11BdDLGyQDqBZJw7ng=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FM39Fpu/5upH/82Z/8Fd2WSdrJDJEVGe172obK/xEzH9uIao5ILbSih94BGykRLHZ
	 6LAdl+Kd1s7Ai6qGVpD8BoF+u0+SHBOD4MzHbopL6wOjR31GN8VxhVNEGOqpRo4ZZD
	 dM3cpEb8iJCcB0s9deqYRwpxKlf6utqhRnTIhmZyT1SoZvrJkMKRWZr+6YnwfghQut
	 sbc8C1/JaRRaqz4+IE5BL0K2umV3gGx46VcGVk65wYCWqPEgW5OZZ1uSNf1myzTHuX
	 Jzfr3iuhom3i1wqkRweTvaUbsfEmHxvuwEC6L2J+VaLcnh/xfwRMz2tpKqLbtqXiB3
	 fHyTBqHAY2Ucg==
Date: Tue, 10 Dec 2024 14:07:22 +0000
From: Simon Horman <horms@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dsa: mv88e6xxx: Move available stats into info
 structure
Message-ID: <20241210140722.GC4202@kernel.org>
References: <20241207-v6-13-rc1-net-next-mv88e6xxx-stats-refactor-v1-0-b9960f839846@lunn.ch>
 <20241207-v6-13-rc1-net-next-mv88e6xxx-stats-refactor-v1-1-b9960f839846@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241207-v6-13-rc1-net-next-mv88e6xxx-stats-refactor-v1-1-b9960f839846@lunn.ch>

On Sat, Dec 07, 2024 at 03:18:44PM -0600, Andrew Lunn wrote:
> Different families of switches have different statistics available.
> This information is current hard coded into functions, however this
> information will also soon be needed when getting statistics from the
> RMU. Move it into the info structure.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>

Reviewed-by: Simon Horman <horms@kernel.org>


