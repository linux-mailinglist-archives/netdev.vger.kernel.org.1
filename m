Return-Path: <netdev+bounces-242621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC38C92F08
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 19:51:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91CA13A7485
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 18:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5BBC285CA7;
	Fri, 28 Nov 2025 18:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TBk6wkJC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E5127EC7C
	for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 18:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764355865; cv=none; b=LdOyrU44riYq1IlvDWN3dAecDwH+4NUsmuerUR1MzlGL9muz1GBz2DZKCTiXAHxfxKdZs6caX/Dkux171Ax1MIgy4GrhsJimFk+rdkJNwq3Vxlg8lSd05gFreVl6coxH0lqrDL5SRKp9EJKtgsaI23DQNZTLyZhHWoR1PS2UEME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764355865; c=relaxed/simple;
	bh=u2EPr5WZuMcmAhXrIw+UrWdv+NqLrDBJIhp6mbV9trw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ut2rntyLDNK3wzhmCRjcXXs+NXJhSeTeHKDNu1WNoqzcjhDV4TaraJCWIx7yErTFMQ/NgeoUek4Q43ZwS7abPgehccR7X4i+1R+Uc9GsO7YBFgWiZAMyzu5t33dk59SbUAj9FXEJZU8lswBPLo65WlrxrvW76eSCIrdY58tjur0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TBk6wkJC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6DF4C4CEF1;
	Fri, 28 Nov 2025 18:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764355864;
	bh=u2EPr5WZuMcmAhXrIw+UrWdv+NqLrDBJIhp6mbV9trw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TBk6wkJC9fXUFjUUAkpKHNpE1Wqy3x3iN3M4kqJT1k/eFjQmb/KKnZAdb+LPRMa2p
	 iHbjNAO2roTgM+AGgeI3ZN0SEkq1wI07/suzkYFIkY5wz5LzJNVUG6LJW+RJtIcWz5
	 Rb9VI+8lgqxgQa9F6XnOtGvVcGjtDugdtJ7d90j7RGztiziGzOWr0ytcOLLxnOuhxM
	 RyX4ehQLxyZKxDZ/7vfpBnKtIcO9dTjOfBGNTX8O9oZZGpXedwjMTanFkgSSnq8y4Y
	 khaJs8J6pdOWSP6v1OXlMmyEgmQXURlGreGf+NDcqcD9znsX1/RlZUwYadx4NCXLZY
	 wkxHCHsj53Wnw==
Date: Fri, 28 Nov 2025 10:51:02 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Pablo Neira Ayuso <pablo@netfilter.org>, Julian Anastasov <ja@ssi.bg>
Cc: Jozsef Kadlecsik <kadlec@netfilter.org>, Heiko Carstens
 <hca@linux.ibm.com>, "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Florian Westphal <fw@strlen.de>, "D . Wythe"
 <alibuda@linux.alibaba.com>, Dust Li <dust.li@linux.alibaba.com>, Sidraya
 Jayagond <sidraya@linux.ibm.com>, Wenjia Zhang <wenjia@linux.ibm.com>,
 Alexandra Winter <wintera@linux.ibm.com>, Thorsten Winkler
 <twinkler@linux.ibm.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: Remove KMSG_COMPONENT macro
Message-ID: <20251128105102.418261d7@kernel.org>
In-Reply-To: <aSmNRDG8RAHVoC7C@chamomile>
References: <20251126140705.1944278-1-hca@linux.ibm.com>
	<20251127181127.5f89447b@kernel.org>
	<aSmNRDG8RAHVoC7C@chamomile>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Nov 2025 11:53:40 +0000 Pablo Neira Ayuso wrote:
> On Thu, Nov 27, 2025 at 06:11:27PM -0800, Jakub Kicinski wrote:
> > On Wed, 26 Nov 2025 15:07:05 +0100 Heiko Carstens wrote:  
> > >  net/iucv/af_iucv.c                      | 3 +--
> > >  net/iucv/iucv.c                         | 3 +--
> > >  net/netfilter/ipvs/ip_vs_app.c          | 3 +--
> > >  net/netfilter/ipvs/ip_vs_conn.c         | 3 +--  
> > 
> > Jozsef, Pablo, should we ask the author to split this up or just apply as is?  
> 
> Patch looks trivial, and not so large for a tree wide.
> 
> But I'm Cc'ing Julian Anastasov so he has a chance to ack the IPVS bits.

Oops, my bad, I also meant Julian not Jozsef, sorry.

