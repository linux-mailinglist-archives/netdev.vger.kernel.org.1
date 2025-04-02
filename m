Return-Path: <netdev+bounces-178912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E6FA7987D
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 01:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 489543ADAA0
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 23:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1128E1F4C8F;
	Wed,  2 Apr 2025 23:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HlPQSsCO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97261C862C;
	Wed,  2 Apr 2025 23:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743634964; cv=none; b=pjzMGWAL8qoM+++q/sdPIq3BIglikHdlSRS5CUMqz9adApPVdEJR0KYUHDmXb71o4yJkiSaTye6W9nDY9q6RNPDCQKZWcuCP1oOsuYjr9zGc2uQr0Z8oBa2NOTyO+WMFlEJ4j8n7wqC+SaH3jDLuf6CnVgQVuZywhJxPaqnoS64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743634964; c=relaxed/simple;
	bh=aUT47vd47WIPHCRffCk/Ja3q/2Jm8B8zttzqokMd4/U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MPb9P+sFL3tikmQfX04w2x04JXaDwkbPqqYS5DGtlz3z7Wy4DXrUD4RFEELDMHbwIGtYfXOM9B3LRpX61lpur6SdypUpZMC6lcxauyS1Z3JL4SoytB5l6+/tSvkqAeJsNEy4h2wD5jK8ERH6gG93PnOHlDzZ6F2MkCJeXi1WSW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HlPQSsCO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11541C4CEDD;
	Wed,  2 Apr 2025 23:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743634963;
	bh=aUT47vd47WIPHCRffCk/Ja3q/2Jm8B8zttzqokMd4/U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HlPQSsCOWx4bT65rxMh3+/oCaHa3GunT0dUQwASQJsU4rG/zC6D0dWe7fJevigfNO
	 EKQe5IkTHy/rMRKeHOI+DOBAIbfIXDZTXN7KEJvCmAyp3+LWZCM+ctUE2Cm4QuQujm
	 dTzy/eAo31dqhNdWR4zV6qPfYMcKch1MLBzZTOdbhU6GMc7bBsrf7sM5iV6SWWMOU6
	 QXIwWKwx8Pn1gnL/RGv0saK8AVG4fJjXw6diyp3an44a/Egl2r7oj8zC65uTNEbEZN
	 h3McGzjzASTMT51oE1Li1DlzLyM424gKhYnq28YPZsjbO7LIlHYm51gHlyEifbM2Zt
	 SM3DcpJx8Vp9A==
Date: Wed, 2 Apr 2025 16:02:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paul Moore <paul@paul-moore.com>
Cc: Simon Horman <horms@kernel.org>, Debin Zhu <mowenroot@163.com>,
 pabeni@redhat.com, 1985755126@qq.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH v3] netlabel: Fix NULL pointer exception caused by
 CALIPSO on IPv4 sockets
Message-ID: <20250402160242.3a22f9fb@kernel.org>
In-Reply-To: <CAHC9VhQAdxADGrqEDH4kUuoXsUS_E92UtTDcf+uF7J=QavkP3g@mail.gmail.com>
References: <2a4f2c24-62a8-4627-88c0-776c0e005163@redhat.com>
	<20250401124018.4763-1-mowenroot@163.com>
	<20250402093609.GK214849@horms.kernel.org>
	<CAHC9VhQAdxADGrqEDH4kUuoXsUS_E92UtTDcf+uF7J=QavkP3g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 2 Apr 2025 14:28:40 -0400 Paul Moore wrote:
> Not sure if the netdev folks are going to pick this up or if I'll end
> up taking it, but if I end up taking it I'll update the tag while
> merging.

Fixed and applied to net, thanks!

