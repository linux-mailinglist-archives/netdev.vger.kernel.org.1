Return-Path: <netdev+bounces-84438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE13E896EFA
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 14:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D1B5B2598F
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 12:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E134DA13;
	Wed,  3 Apr 2024 12:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nqSAGuK/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721291C683
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 12:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712147965; cv=none; b=PnXvdB3PrvvPx8PRt+gI8ZPGneznE9z/07MUMz6oGCQv5rF2t/YKJeFKq7k0GPRhZ/MI50b2r+2C21IG2A4QP53TSgN5Mj3tkm8k+FxdlnN3J9Ygo76qkKMcDlEZXrU83Frhpn3gOCucCZUgAa0Qqxjmxed/yCzl0t/6EuC/0As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712147965; c=relaxed/simple;
	bh=SukUxI5ID6ogyUVj6oblA90AgOVXSpAYjogxMWAGwJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u11mq8SwbX6oGRj8HyGxg6MX4+y7HqDzkE2dzJnyGS4feqpIr+n/xgUybLPGyWixUYoOILDvKhz9MK57H2LY9WuQRoFLeKzDcS2bHKW0jVgRSh7sSkx7JtOoQpsLaDZ/w9xXLNrI5jOn478oVKvQ2xzka0YYWs53ONotZ7vv3xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nqSAGuK/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10991C433F1;
	Wed,  3 Apr 2024 12:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712147964;
	bh=SukUxI5ID6ogyUVj6oblA90AgOVXSpAYjogxMWAGwJw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nqSAGuK/X32IrIZGGqXoQvzEEQhAkgutjVLH9KdHHr6yKUk8NybR1IdcacO6vG5gS
	 7iZ1ISj/4gahbm76xDiPwvqgchDYPL5pZ5Qz8a0IJUqk8+/TwGYL9a31Sf9AcCeR0n
	 MKrED3EquMzaauPUNbKPKABLQehGpYd6k8wBYNR0rPjwXj8td64cwsjC2Et24UR25k
	 X4ChgYc/MsdBKmYormq/xzKJOqh491j+sbljwYh/uaI3io8HO/RNSZxLF7Bu8VknQY
	 KBIdhHSL6U5eyGxWz1X0N1dfGze+QBmLcUl0sla8nnNUcYchFHebJQmS0RYf7HaU5E
	 Qt/mafG6o2C4w==
Date: Wed, 3 Apr 2024 13:39:21 +0100
From: Simon Horman <horms@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
	Amit Cohen <amcohen@nvidia.com>, mlxsw@nvidia.com
Subject: Re: [PATCH net-next 09/15] mlxsw: pci: Use only one event queue
Message-ID: <20240403123921.GE26556@kernel.org>
References: <cover.1712062203.git.petrm@nvidia.com>
 <23d764f5c032e4c363b98590b746a4b32d2bf900.1712062203.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23d764f5c032e4c363b98590b746a4b32d2bf900.1712062203.git.petrm@nvidia.com>

On Tue, Apr 02, 2024 at 03:54:22PM +0200, Petr Machata wrote:
> From: Amit Cohen <amcohen@nvidia.com>
> 
> The device supports two event queues. EQ0 is used for command interface
> completion events. EQ1 is used for completion events of RDQ or SDQ.
> 
> Currently, for each EQE (event queue element), we check the queue number
> and handle accordingly. More than that, for each interrupt we schedule
> tasklets for both EQs. This is really ineffective, especially because of
> the fact that EQ0 is used only as part of driver init/fini, when EMADs are
> not available. There is no point to schedule the tasklet for it and check
> each EQE.
> 
> A previous patch changed the code to poll command interface for each use of
> it. It means that now there is no real reason to use EQ0, as we poll the
> command interface.
> 
> Initialize only one event queue and use it as EQ1 (this is determined by
> queue number). Then, for each interrupt we can schedule the tasklet only
> for one queue and we do not have to check the queue number. This
> simplifies the code and should improve performance. Note that polling
> command interface is ok as we use it only as part of driver init/fini.
> 
> Signed-off-by: Amit Cohen <amcohen@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Petr Machata <petrm@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


