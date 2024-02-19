Return-Path: <netdev+bounces-73060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E5485AC21
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 20:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40CCE280ABB
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 19:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3054F481B5;
	Mon, 19 Feb 2024 19:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uwXlpRKQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5BF50A87
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 19:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708371458; cv=none; b=HdWsu7d+qLjS9JKfeO47NbzQbqiUf+xwKv44AMd6OVUNj0IlVJrr2VlLT6L51dHwa2tMRtn/0ML4zj7JR5mnvCJ47QenEY8p1HczH4iT3F+65JTtSkvTUHD2jDAhNejaIFULEiYjmpFDi3uZcm2qAcCnb73U8fhhAC7NI8+DAnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708371458; c=relaxed/simple;
	bh=vm3JuAlcpaHrSK0lshymVQu3C0RKOkXzAyz29VB45ik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tj9/GO3EV75tTYtsjl2/11TAaep9/1wOa7Xyhuq6iWZDdgOf74yb1bPrD3OAnl9UICworRyl9mGHHikMZjycD5GNKLVP52kjP8J95aygiNCCoSSLFH4BppMs6dLj089U/XKB/C94c/gC/xI4bcwBveFMzCfMtQSL/DFBATKrhbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uwXlpRKQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E258C433F1;
	Mon, 19 Feb 2024 19:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708371457;
	bh=vm3JuAlcpaHrSK0lshymVQu3C0RKOkXzAyz29VB45ik=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uwXlpRKQI6P62JMuHqDuZZVOLO4AVI4uau3TV6qUtsSR4CVQtXsyNHmUNHILHM0k5
	 bwTeH5DJ5Cv6GLXvWGswbmm0KmJlktmCrxsDm0iBXoLYKR++C/KiIVK8IzN5pu0uBc
	 S0qfo5ow7eJnHO6fCMR4bcyJBnS3MD4xPSL9n4glVs1FDnT4xuEMItrUglxGrKE9Uz
	 Wr2VSaVx/t7VCjf6X69DCSpj04rAnldRz/0JcpBls/atbRZDzphQyO2fLht7UOlHEw
	 oQq0ijiRXWC+eCXbmBUtPofeNjEBmuL7O7GC08ajIjJfiTZWojI5Ekos81eq790bYa
	 tM3uP3lQEfK8w==
Date: Mon, 19 Feb 2024 19:37:33 +0000
From: Simon Horman <horms@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Michael Chan <mchan@broadcom.com>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] tg3: simplify tg3_phy_autoneg_cfg
Message-ID: <20240219193733.GM40273@kernel.org>
References: <9fcf20f5-7763-4bde-8ed8-fc81722ad509@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9fcf20f5-7763-4bde-8ed8-fc81722ad509@gmail.com>

On Sun, Feb 18, 2024 at 07:04:42PM +0100, Heiner Kallweit wrote:
> Make use of ethtool_adv_to_mmd_eee_adv_t() to simplify the code.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


