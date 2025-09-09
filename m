Return-Path: <netdev+bounces-221048-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56369B49F34
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 04:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12B3116379D
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 02:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D2A224B0D;
	Tue,  9 Sep 2025 02:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GL5/aXg1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D970F54723;
	Tue,  9 Sep 2025 02:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757384875; cv=none; b=ia0m2FQ6agWK4RFGzk5/Inm/SOoNPM1pDqs548T4grW3bM5ueRqmuFGcV/f/ti2RjOg+FbElMFLe2uIWxjNiRQB6nr8i3CxEeTlsViGOenunj/MRsLwfE9pojrC/E4gHwNM3DLgeXKchQIu+2sqfNqZTehxrV5ym5gZ8uY0B5MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757384875; c=relaxed/simple;
	bh=aOJXJVE/Lnnubw2Zk014wpNipNtKNDlXijcoSv/vxVc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hDhVXU8AOViqO72CSBnAZa4eckghEB95r3Yq5ajjtuRTElo1aOPEZvEwU3khI9cJyAsXhV0cbpmhM7gWFmCY7L21JCFU/mez31rsotZXdXMaVL9dHC+UKuvd86eAEBDB5OVXOajvWrpmRnx0PhY+SpfUbRwQ+4a9hE5xvW3cdc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GL5/aXg1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40725C4CEF1;
	Tue,  9 Sep 2025 02:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757384874;
	bh=aOJXJVE/Lnnubw2Zk014wpNipNtKNDlXijcoSv/vxVc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GL5/aXg1FiXS7Eixva7+RrTQ2uxPAAVSaTU08aFrMz0fJuSKet8lLDWa4PGYZhouI
	 cf+NNLYLCIUNMbH3zL+ZkI9J0vGndh0+vS1YvirwsYo/1jEpyYFxVsN7QNjONzR2VB
	 cIXN84/1EcH4gYM3ahOGSF08Qxk10EX0DtCpmCsq5XODg2x+LPVDJIkEsYiRvT0EAC
	 FVroCAea3TDkdM+RPD9Wm3mKSQDbAh7DxZflVFwpCqyHXHHY+rKcHeooWIj6vYyqzH
	 WOMFrT2687EOe+9SPjVYNDzXj3u8qbkbxFeXcBKXt9q2rGLc/1rTXNrfJNQhpfDFsY
	 vu9O55f6ef4Ng==
Date: Mon, 8 Sep 2025 19:27:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, Simon Horman <horms@kernel.org>, Nikolay
 Aleksandrov <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>,
 <bridge@lists.linux.dev>, <mlxsw@nvidia.com>, Vladimir Oltean
 <vladimir.oltean@nxp.com>, Andrew Lunn <andrew@lunn.ch>, Jiri Pirko
 <jiri@resnulli.us>
Subject: Re: [PATCH net-next 00/10] bridge: Allow keeping local FDB entries
 only on VLAN 0
Message-ID: <20250908192753.7bdb8d21@kernel.org>
In-Reply-To: <cover.1757004393.git.petrm@nvidia.com>
References: <cover.1757004393.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 4 Sep 2025 19:07:17 +0200 Petr Machata wrote:
> Yet another option might be to use in-kernel FDB filtering, and to filter
> the local entries when dumping. Unfortunately, this does not help all that
> much either, because the linked-list walk still needs to happen. Also, with
> the obvious filtering interface built around ndm_flags / ndm_state
> filtering, one can't just exclude pure local entries in one query. One
> needs to dump all non-local entries first, and then to get permanent
> entries in another run filter local & added_by_user. I.e. one needs to pay
> the iteration overhead twice, and then integrate the result in userspace.
> To get significant savings, one would need a very specific knob like "dump,
> but skip/only include local entries". But if we are adding a local-specific
> knobs, maybe let's have an option to just not duplicate them in the first
> place.

Local-specific knob for dump seems like the most direct way to address
your concern, if I'm reading the cover letter right. Also, is it normal
to special case vlan 0 the way this series does? Wouldn't it be cleaner
to store local entries in a separate hash table? Perhaps if they lived
in a separate hash table it'd be odd to dump them for VLAN 0 (so the
series also conflates the kernel internals and control path/dump output)

Given that Nik has authored the previous version a third opinion would
be great... adding a handful of people to CC.

