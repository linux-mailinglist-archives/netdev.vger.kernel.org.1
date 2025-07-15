Return-Path: <netdev+bounces-207300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FAC0B06A04
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 01:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CADDE7A888C
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 23:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D512C3258;
	Tue, 15 Jul 2025 23:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c7NPD4nK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8591F30CC;
	Tue, 15 Jul 2025 23:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752623134; cv=none; b=Eqka7HZGtb00KP0UAvWlp2s406SYStiMh9J4PDYJOveyRFoP+hqTwzNz6C1iZaFDfJR0AcXwPOm+MtfJIrmiKXbjd5/oFBNR7JbTBgmEKeCo1My4eOyGelt391CZ74SdQZUetkaoN1etqOjbkcpzjZvpJAzLZxh6JZ+1sligGgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752623134; c=relaxed/simple;
	bh=vHOQ2jry88zOnVVJZnM/DJXyiUBLY5+Ih9GHdsfOQOY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SFLZZTfSEhkezHuobYbApOemm/VEuV0MUE6hkRJCxIQPyYHg4+VHtrsbACHwK1iZR8ljxR3hrbrBsnOb8e3QZ2Wguxq4O2JAaI85hFZOpPqzI4dnhFivmVQ+8Fpzy3jZjLtxYUJUsOjocqYwIZlwZxBxmAQjL1qBXwJTzfN6Mmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c7NPD4nK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B645DC4CEE3;
	Tue, 15 Jul 2025 23:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752623134;
	bh=vHOQ2jry88zOnVVJZnM/DJXyiUBLY5+Ih9GHdsfOQOY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=c7NPD4nKlLEDBsXMithXGlQx9kj7Z/cYKhSmIaGI0FKGN6KrFmF+H0pPetrTQa41k
	 ApmO+1Vl7UwZbOMBEGwMUSfUkOvqe3BWcisA9WsSiJtglWiRmcZdxUXVAWOdj4NTTI
	 BWCEo/B8nHEBpBx+7LO1KZAqn5yH39pGYSS6Nl1SwGCqIBmdDL0DX/dKsqdv+W5/VD
	 uDkNsDXsClxJCAtmvUvjmC1u2Co/jIoo0SS8w0ODOaTib6Lia52Q31fg/dCLneBMc6
	 QJJ+spsETQLfqwoT3feOiXBDsle8X2Ab5002xIjr7rmLwsJ/TZ0dS7d0vUmdzWvhhu
	 BlE66QF75VVeA==
Date: Tue, 15 Jul 2025 16:45:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Felix Fietkau <nbd@nbd.name>
Cc: netdev@vger.kernel.org, Michal Ostrowski <mostrows@earthlink.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: pppoe: implement GRO support
Message-ID: <20250715164532.28305dc3@kernel.org>
In-Reply-To: <20250715104425.8688-1-nbd@nbd.name>
References: <20250715104425.8688-1-nbd@nbd.name>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Jul 2025 12:44:24 +0200 Felix Fietkau wrote:
> Only handles packets where the pppoe header length field matches the exact
> packet length. Significantly improves rx throughput.
> 
> When running NAT traffic through a MediaTek MT7621 devices from a host
> behind PPPoE to a host directly connected via ethernet, the TCP throughput
> that the device is able to handle improves from ~130 Mbit/s to ~630 Mbit/s,
> using fraglist GRO.

Doesn't build:

ERROR: modpost: "inet_gro_receive" [drivers/net/ppp/pppoe.ko] undefined!
ERROR: modpost: "inet_gro_complete" [drivers/net/ppp/pppoe.ko] undefined!
-- 
pw-bot: cr

