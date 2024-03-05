Return-Path: <netdev+bounces-77545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 657EE872273
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 16:13:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 210C0286E99
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 15:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176F7126F32;
	Tue,  5 Mar 2024 15:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QnvcBMTt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7336126F14
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 15:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709651617; cv=none; b=bmBky9+kEre595UB+nY9MMIAcmMeoINQZNiTk+V0UKpwwjwbuHJw7WyXV6AlnAg4H4m3Ht0NLGkbNy4RpHLJOziY84sYIB/gNFfYBwCa6oJqBAN1qVc+oPwzfEybCvUPlR1gFAN4tq3nG+S7FvveUc5cU6ltIRgrtcw2JMpUkS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709651617; c=relaxed/simple;
	bh=Fg/Grg+6rgPwulOXPl3HuutGDCRoRtxI0tKFCJSClbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sn8vqtIJ3H02KXS4GewvhQK+KziOX2SIlOB/KMBGu9CDhoIVHzOU+2g2SAMTVdw/Lur19hVdLUtLTZtlMgoUx6OD2Xt0zCqll0aEoKCMSLZwHqCKT0fggaLo3noKY+su9aeixixXPKbs5X7JjZ019a/MPiF96U9meqPw8BMaw8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QnvcBMTt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DF35C433F1;
	Tue,  5 Mar 2024 15:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709651616;
	bh=Fg/Grg+6rgPwulOXPl3HuutGDCRoRtxI0tKFCJSClbc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QnvcBMTtlIYBrbDne++E8iWIQnciinMqQrOOk8oynBJtKIsAflUzQiIz9q12sGeBA
	 lFaOJCXwXQKvP8zqzdEOztD5X4x2mwf+bogagmYtrluJKrbbiQLX4y1S1QUzqSLJWF
	 KF/Ct+Zcvgapr/9+kRlGlCYz4aj64WxyIoSQ9c4kGPbs1ywhE00KUTlzvhF9JvGCIb
	 U/YRY30kG76ZD/wRW9zxe5WruJCDp1+WUovHt6psl1Udn0Js4DNwNDG0amRUrGWULV
	 nYxrzKl8uCNV1Y8YiEF854SNuT70bQ10B2pMGWY5R0G/X8o0Gmt+qF3h+PybMgcI2p
	 7BkjLtCGHBw5Q==
Date: Tue, 5 Mar 2024 15:12:03 +0000
From: Simon Horman <horms@kernel.org>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next v2 12/22] ovpn: implement TCP transport
Message-ID: <20240305151203.GL2357@kernel.org>
References: <20240304150914.11444-1-antonio@openvpn.net>
 <20240304150914.11444-13-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304150914.11444-13-antonio@openvpn.net>

On Mon, Mar 04, 2024 at 04:09:03PM +0100, Antonio Quartulli wrote:
> With this changem ovpn is allowed to communicate to peers also via TCP.
> 
> Signed-off-by: Antonio Quartulli <antonio@openvpn.net>

...

> diff --git a/drivers/net/ovpn/tcp.c b/drivers/net/ovpn/tcp.c
> new file mode 100644
> index 000000000000..d810929bc470
> --- /dev/null
> +++ b/drivers/net/ovpn/tcp.c
> @@ -0,0 +1,474 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*  OpenVPN data channel offload
> + *
> + *  Copyright (C) 2019-2024 OpenVPN, Inc.
> + *
> + *  Author:	Antonio Quartulli <antonio@openvpn.net>
> + */
> +
> +#include "main.h"
> +#include "ovpnstruct.h"
> +#include "io.h"
> +#include "peer.h"
> +#include "proto.h"
> +#include "skb.h"

Hi Antonio,

this breaks bisection because skb.h doesn't exist until the following
patch in this series.

> +#include "tcp.h"
> +
> +#include <linux/ptr_ring.h>
> +#include <linux/skbuff.h>
> +#include <net/tcp.h>
> +#include <net/route.h>

...

