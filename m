Return-Path: <netdev+bounces-85958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B061589D05D
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 04:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 402E81F2159F
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 02:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27533537EF;
	Tue,  9 Apr 2024 02:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KVI0ywAk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3A94A2C;
	Tue,  9 Apr 2024 02:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712629937; cv=none; b=HhRQvC/V53C8Cp+2vESnsBoN5CtNqEmQsch4aw8lvKeu3KtlDu6F53tVHVrkVMUlbqXJ/OuupuUpETL9ztaSZ8XMBmbgi7ztIlYT3B8vsxVNdLZ6lYXXxU74n/ZaMCw4EXuT7qoxV0aKGSWYPGb2/wVq+936ujm/eQJZCPHtqsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712629937; c=relaxed/simple;
	bh=44/bo/zJNa2xBIWh1J+QvFA0Y8nbDSwJdgCjWIPt71M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RIyQ8/jUZDlOTLxhlnMD8W/6x6ka9Q/E+Nr8pSrs6hIvmH6xDH3uZOQvizc2MYxo/LCfPcDqYQq3oE4GW1SD/mx1A6G8bEhIkHKhF3pYnHTZBgsZuZho9elf/0T8rQJdipiqeEZXpZkEfKvixgN+P0dHscklUwnxWKmFFpcLDX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KVI0ywAk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8F3DC433F1;
	Tue,  9 Apr 2024 02:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712629936;
	bh=44/bo/zJNa2xBIWh1J+QvFA0Y8nbDSwJdgCjWIPt71M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KVI0ywAklEILkb0JEnmry/Z0wKg2ePYrL20ErvVBP5Egez0+Iq+6j9VabhTQqnh2k
	 UcgMso4kmmHOjSV6n9brP/coyxsqfBRkmszjrU76JkLg8jh9Nz3vKg+qCI6KdZW6Na
	 Yg/H90slNnUZx1OnB5d7TR7uxIW/R4Lp1DkjX3SjOSZsALU7CgGrLJnLa53J5kYPoP
	 aUplTHKRHdnlEoweTiepFcO+sjzja1OyhGpF0FS2/q/YDmvYk+i7R2b+0OV6w9KbO1
	 lklRgke8aFheg1rEbObxVnMBt8fadosj6PlFynu3nMI+xGiCgtrJgNZVsOneVr8o83
	 IHpLBmBY77zPw==
Date: Mon, 8 Apr 2024 19:32:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, David Ahern
 <dsahern@kernel.org>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Andrew Lunn
 <andrew@lunn.ch>, nex.sw.ncis.osdt.itp.upstreaming@intel.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net-next 3/7] netdevice: introduce IFF_LOGICAL as
 (IFF_NO_QUEUE | IFF_LLTX)
Message-ID: <20240408193214.20df8d40@kernel.org>
In-Reply-To: <20240405133731.1010128-4-aleksander.lobakin@intel.com>
References: <20240405133731.1010128-1-aleksander.lobakin@intel.com>
	<20240405133731.1010128-4-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri,  5 Apr 2024 15:37:27 +0200 Alexander Lobakin wrote:
> + * @IFF_LOGICAL: combines @IFF_NO_QUEUE and @IFF_LLTX, used by logical
> + *	interfaces to avoid overhead from locking and Qdisc.

=F0=9F=A4=B7=EF=B8=8F=F0=9F=A4=B7=EF=B8=8F=F0=9F=A4=B7=EF=B8=8F

