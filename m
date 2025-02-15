Return-Path: <netdev+bounces-166717-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD262A37067
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 20:31:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFB097A3A4F
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 19:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6AC21EA7F5;
	Sat, 15 Feb 2025 19:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aIiparAn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8297E1624D3
	for <netdev@vger.kernel.org>; Sat, 15 Feb 2025 19:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739647867; cv=none; b=c1c90RTHPEr9l3QT8GTnj3sjIq63I1p31+jTCmeVGhyTUByMaAuS12V6u6qvUXIERT56dAT7bW5DqXURQfNa0lle0pOq09MlfBrwaNRBF2l6gY1zwWT/E/TSlEFU+48Xan8T9D6VW7rEo9HL6mcVsOuboupwYeBWCAMYFz3kzMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739647867; c=relaxed/simple;
	bh=TXTdzNW0VGtfO466EM72fkTi81UqXLfTYU598Ty8rzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ewp3RqD+H57udAZBG3+PDfP1+LnCqFubLHfhn/gNTGb4vStxG8a+IIAD4d3ZThoSepW2TVXGFDi5LshwHYa6Fyqy1ow29qRkCZUGVy1I0dwS/eAKwwrdGcAfgVaon7lWg26u3UKcbNS9d49Akg12wEckM7fyeHZBnAQmBg5BzyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aIiparAn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA66DC4CEDF;
	Sat, 15 Feb 2025 19:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739647866;
	bh=TXTdzNW0VGtfO466EM72fkTi81UqXLfTYU598Ty8rzk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aIiparAn1uj6lU3nl882HdQsutxt0iki79X9Di4Y1si8bLhe+TD/IeJmoYCcOgetq
	 SfYxawOI5bO3D8HiSVvjQPeqUws6ROyoGpvyG2/6gevKckDkBpUDVdgUuWC9cQ8DYq
	 aaf2Fsa5JnteSx+OwK51t6BO+0xM2QkZdwNfgvTZdDjJxb2q1bxuDwugtsfNx5Vvoz
	 DgKhPyMMujsoSiJz2GCIuM5FW7IzVsH3vCBbzIxbw7QeTvosR9mjkM2KuYI7tp15hk
	 rjZZIekc4SYnQhh/EUlvX2Iq5wAY1CoohabZg7O0C+UjxfIpnSc0yWXb0VAYvogCYd
	 qUR+qQ/k0AxTw==
Date: Sat, 15 Feb 2025 19:31:02 +0000
From: Simon Horman <horms@kernel.org>
To: Marcin Szycik <marcin.szycik@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	michal.swiatkowski@linux.intel.com,
	Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>,
	Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
Subject: Re: [PATCH iwl-net 1/2] ice: Fix deinitializing VF in error path
Message-ID: <20250215193102.GV1615191@kernel.org>
References: <20250211174322.603652-1-marcin.szycik@linux.intel.com>
 <20250213105525.GJ1615191@kernel.org>
 <72975a9c-0daf-4100-b31a-cee0f52e2514@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72975a9c-0daf-4100-b31a-cee0f52e2514@linux.intel.com>

On Thu, Feb 13, 2025 at 01:32:38PM +0100, Marcin Szycik wrote:
> 
> 
> On 13.02.2025 11:55, Simon Horman wrote:
> > On Tue, Feb 11, 2025 at 06:43:21PM +0100, Marcin Szycik wrote:
> >> If ice_ena_vfs() fails after calling ice_create_vf_entries(), it frees
> >> all VFs without removing them from snapshot PF-VF mailbox list, leading
> >> to list corruption.
> >>
> >> Reproducer:
> >>   devlink dev eswitch set $PF1_PCI mode switchdev
> >>   ip l s $PF1 up
> >>   ip l s $PF1 promisc on
> >>   sleep 1
> >>   echo 1 > /sys/class/net/$PF1/device/sriov_numvfs
> > 
> > Should the line above be "echo 0" to remove the VFs before creating VFs
> > below (I'm looking at sriov_numvfs_store())?
> 
> Both "echo 1" commands fail (I'm fixing it in patch 2/2), that's why there's
> no "echo 0" in between. Also, in this minimal example I'm assuming no VFs
> were initially present.
> 
> Thanks for reviewing!

Likewise, thanks for the clarification.

...

