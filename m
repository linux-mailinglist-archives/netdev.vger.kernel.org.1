Return-Path: <netdev+bounces-158486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B379A12230
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 12:12:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EF333A6A10
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 11:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29A41E98EF;
	Wed, 15 Jan 2025 11:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sv56Ix0h"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEAB9248BD4
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 11:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736939573; cv=none; b=chs2eq0f0Wcl8c8oq7lWsm69oZ0nV4DhjZTciQJH7nDT+pzs6Ip7r1z8fDncb4ZeK8ez7OfwNx0qEyPRT/0Dp7wSxFVIvZ93dB+HI+y2fKdxwsRm83Rk4IDTBv1fGEgZJrtbO4eTRDE9YTIQYuGWjP07zRYkr0gLTdyaUp9r6w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736939573; c=relaxed/simple;
	bh=+5jcLrvXhMFrcNevqMA61s4ZZ2WCDSaHjH3dnJJxmdI=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=m4tnQUJ/m32qyd3ARjc0OnXzZAVt6O/S1eiAOarw4ryX87vhLVzgUQL8hfBgvGNxG5vS9ER3gk6CcoylHcGTsSDuuLL3V+USaJI0iPR0qs6LBubOreDqs5ZaKFAsmbMMgo8+dVqkdTVYNa2lZWAdifoRiFOCX7b5ciO6QFgQpnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sv56Ix0h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFC71C4CEDF;
	Wed, 15 Jan 2025 11:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736939573;
	bh=+5jcLrvXhMFrcNevqMA61s4ZZ2WCDSaHjH3dnJJxmdI=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=sv56Ix0hlpg0b8NChI/h5Ivu+3H+bpzUXUyJwIn4nBW9JNSXTwigHZ8VLE86Kmeji
	 buqtK67vYeRJPP6U2p/r+EL4hjBB09skdDwlbCVnO8bi+tGVKyjxAICTVFi+wd7Avm
	 w7IJCOTAthRiUGSlGO0mfTY39CX+bg2o6LBESPHPLr8NFj0EkDV+194+slpeJAS9+U
	 7N6/8ZxMHW4/RvOIz3/OuW34L3Ju+9FiYyW/I9etF/MH5VLrM/EtstFPRsu3p7iy4R
	 KwaI+agqkmiFiub0JVUl2/nKpA6DWpQ2sL2BN0JKmY7r77/Xtb/pWmWP+UO9iYxXJu
	 tUBDTfcdiYwQg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <7fe79d84-70ba-5bad-58ed-6bfa1a28e555@gmail.com>
References: <20250113161842.134350-1-atenart@kernel.org> <20250114112401.545a70f7@kernel.org> <f87576e0-93d2-42fe-a6da-09430386bc16@gmail.com> <173693410183.5893.12485926901643155644@kwain> <7fe79d84-70ba-5bad-58ed-6bfa1a28e555@gmail.com>
Subject: Re: [PATCH net] net: avoid race between device unregistration and set_channels
From: Antoine Tenart <atenart@kernel.org>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com, netdev@vger.kernel.org
To: Edward Cree <ecree.xilinx@gmail.com>, Jakub Kicinski <kuba@kernel.org>
Date: Wed, 15 Jan 2025 12:12:49 +0100
Message-ID: <173693956967.5893.6870114019136382998@kwain>

Quoting Edward Cree (2025-01-15 12:04:58)
> On 15/01/2025 09:41, Antoine Tenart wrote:
> > Quoting Edward Cree (2025-01-15 03:51:12)
> >> Would __dev_ethtool() need a similar check?
> >=20
> > It doesn't because it calls __dev_get_by_name() and returns -ENODEV in
> > case dismantle started.
> >=20
> So, to check I'm understanding correctly - this is because
>  ethnl_default_set_doit() calls ethnl_parse_header_dev_get()
>  before it takes rtnl, whereas ethtool takes rtnl before it
>  calls __dev_get_by_name()?
> Subtle enough difference that the commit message should
>  probably explain it.

That's right, and because unlist_netdevice is called from
unregister_netdevice_many_notify. I can add the explanation in the
commit log.

Thanks,
Antoine

