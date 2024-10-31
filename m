Return-Path: <netdev+bounces-140579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 259639B714C
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 01:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56C141C2107E
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 00:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB6F17C98;
	Thu, 31 Oct 2024 00:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M5z8Y/oU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B118A1DA32;
	Thu, 31 Oct 2024 00:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730335626; cv=none; b=WGgsTHNnCDYfC9eImiLlUesNX7kVWhiUwacRQ3ilz3J8FKbY8XYBFkF4vwtpVxJ7L2l+kH0N5KRpOXIR6ADbzx4eiuuqSoscUu+rUB4aZ2U3FLggwK+K+Q6K5S5Zrc0CES/GvqAkS0Ih1FwQoqKjkeYRFnFuEkNSJ8YVyUM/DSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730335626; c=relaxed/simple;
	bh=N05Dfkxa9QYYJn8JqSvSGddrsV9sUP6hFWRciGpWKz0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WmmNmwRZOl4WzKPk75m3FgMMZiAvnTl2bR0hOw0jXUqSwbsj78Gu0c7y31ASI7rjgav424dL4XjahvZFi98G7NmmD0r6EFESXejwx8X68bDOcBbcqyURJ8+/B2kfEmK1hLA6RGPp++t+in9kIPC0/b5rgNc+l1Ypk/EH/e4BvVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M5z8Y/oU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57B39C4CECE;
	Thu, 31 Oct 2024 00:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730335625;
	bh=N05Dfkxa9QYYJn8JqSvSGddrsV9sUP6hFWRciGpWKz0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=M5z8Y/oUBd5pWPEGf+eBYobX9wCUyyapv3T4qT5zn8oTDlEo0G7X2zT/+tZR7r7W8
	 7Ae5BP/m4+3YgYWxae83UcN0CPuhCjZaK20P6hXJn6A3KAwydTqDE7nzHz1styc8CE
	 4MEq5fERgvk2wlssdjCrUEe16RD0ywUjJc5wpM1oj9V7a4HWfAe3fQrY6C2WG7RxF4
	 XwR7goimKnC+uczqnUwsVeaG7wqZdCHbBqICZfN2KhrqI7ltQfXkpWBLruahgDJZc+
	 5w452qRXfzg71HSh25ZuUuQEcSR9HtGur5dz1yf4omZ1rKO1Efnh0y/6m2uWbiKdPw
	 jNZktjbVlyZrA==
Date: Wed, 30 Oct 2024 17:47:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Petr Machata
 <petrm@nvidia.com>, Ido Schimmel <idosch@nvidia.com>, Claudiu Manoil
 <claudiu.manoil@nxp.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, UNGLinuxDriver@microchip.com, Jamal Hadi
 Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko
 <jiri@resnulli.us>, Vlad Buslov <vladbu@nvidia.com>, Simon Horman
 <horms@kernel.org>, Christian Marangi <ansuelsmth@gmail.com>, Arun Ramadoss
 <arun.ramadoss@microchip.com>, =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?=
 <arinc.unal@arinc9.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 net-next 1/6] net: sched: propagate "skip_sw" flag to
 struct flow_cls_common_offload
Message-ID: <20241030174703.594ac0af@kernel.org>
In-Reply-To: <20241023135251.1752488-2-vladimir.oltean@nxp.com>
References: <20241023135251.1752488-1-vladimir.oltean@nxp.com>
	<20241023135251.1752488-2-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Oct 2024 16:52:46 +0300 Vladimir Oltean wrote:
> The most that the switchdev port
> can do is to extract the matching packets from its offloaded data path
> and send them to the CPU.

FTR devices implementing OVS offload can attach metadata to such
packets, and then the driver does the redirect. The SW TC path is 
not engaged. IIRC OVS has a concept of internal ports which are
"stack facing" ports in addition to the main bridge device.
And in some offloaded configurations people want HW to redirect 
to those.

