Return-Path: <netdev+bounces-214659-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF91B2ACE4
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 17:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0B693A155E
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 15:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE5D25C80E;
	Mon, 18 Aug 2025 15:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SreVfZlo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5750B2566D2
	for <netdev@vger.kernel.org>; Mon, 18 Aug 2025 15:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755531374; cv=none; b=HH8DDgjMavUq1fFkVNWrtpVhY8W3yKdx0GTjAFcitMCBlBM9fCAYEqwrXS9jOyVDz23n6lo+edce6KyLrEQOTp+SmBmGI3XrNBYgb74YSJLDf4z3oJdAdWT+9BX3rK5m1NdFYOunv2Xq1wtjFkJBu+c/C5DhbjiYqJ5kDzq84Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755531374; c=relaxed/simple;
	bh=d7VCYZGrLn8maRLTI2zXfX4uJyHacQgqyAsqAF+vVsw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AL1gwGcplSWgCgW322bMhWB+LzqGimIjSlJxZ4eb9iADSjPYxdPlClRTd2n27PNifGkzcWmegsnBdrikT1t4wFkWCVJtWUs5hmAwFnksM8zT4nhiPAlFelYAA1kLUW6j/hOMdMHB7Z0htX3HY57Dx2usWGL4wKiRzXcXDqaqNgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SreVfZlo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A101C4CEEB;
	Mon, 18 Aug 2025 15:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755531373;
	bh=d7VCYZGrLn8maRLTI2zXfX4uJyHacQgqyAsqAF+vVsw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SreVfZloi9OI6+O/W8xwRIC4cntulK0wttb0Dh4GMDpAUsAiqassdwerzPZ2NR5oD
	 aWDvXZGOrIAzY40qAcfOA0Y+RVBnJa1gKNX1Q+uZvnVvzwlQuXZeFeYkHKiIt1k5Fx
	 cgItI/1Z/Tb/qP3SOBc4lhpNlrgT4quwtmLCNTSaZG8P1zV7XuW6KZntwqdZV8GFxF
	 xty3h53NZ3OP79xiDaVSuwIs29IXOWRSrhTsZuV5hIagorQtbfRuya3DZNvoVZLrhb
	 CugqSgHEFhKuC0JKp/hoKvAZNxV+whUbEYVeJR8ukJVTKKeLaMi9Ri7WhIedBcJ4vH
	 EaeY6RfjRRG9A==
Date: Mon, 18 Aug 2025 08:36:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Erni Sri Satya Vennela <ernis@linux.microsoft.com>, dsahern@gmail.com,
 netdev@vger.kernel.org, haiyangz@microsoft.com,
 shradhagupta@linux.microsoft.com, ssengar@microsoft.com,
 dipayanroy@microsoft.com, ernis@microsoft.com
Subject: Re: [PATCH iproute2-next v3] iproute2: Add 'netshaper' command to
 'ip link' for netdev shaping
Message-ID: <20250818083612.68a3c137@kernel.org>
In-Reply-To: <20250816155510.03a99223@hermes.local>
References: <1754895902-8790-1-git-send-email-ernis@linux.microsoft.com>
	<20250816155510.03a99223@hermes.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 16 Aug 2025 15:55:10 -0700 Stephen Hemminger wrote:
> On Mon, 11 Aug 2025 00:05:02 -0700
> Erni Sri Satya Vennela <ernis@linux.microsoft.com> wrote:
> 
> > Add support for the netshaper Generic Netlink
> > family to iproute2. Introduce a new subcommand to `ip link` for
> > configuring netshaper parameters directly from userspace.
> > 
> > This interface allows users to set shaping attributes (such as speed)
> > which are passed to the kernel to perform the corresponding netshaper
> > operation.
> > 
> > Example usage:
> > $ip link netshaper { set | get | delete } dev DEVNAME \
> >                    handle scope SCOPE id ID \
> >                    [ speed SPEED ]  
> 
> The choice of ip link is awkward and doesn't match other options.
> I can think of some better other choices:
> 
>   1. netshaper could be a property of the device. But the choice of using genetlink
>      instead of regular ip netlink attributes makes this hard.
>   2. netshaper could be part of devlink. Since it is more targeted at hardware
>      device attributes.
>   3. netshaper could be a standalone command like bridge, dcb, devlink, rdma, tipc and vdpa.
> 
> What ever choice the command line options need to follow similar syntax to other iproute commands.

I think historically we gravitated towards option 3 -- each family has
a command? But indeed we could fold it together with something like
the netdev family without much issue, they are both key'd on netdevs.

Somewhat related -- what's your take on integrating / vendoring in YNL?
mnl doesn't provide any extack support..

