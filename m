Return-Path: <netdev+bounces-92941-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F0EC8B966E
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 10:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 663731C216E5
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 08:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63B33A260;
	Thu,  2 May 2024 08:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VD6/PtaZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B5F171AA
	for <netdev@vger.kernel.org>; Thu,  2 May 2024 08:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714638547; cv=none; b=WRv/WyBm0kRyEh6MIN8MqcsocjX0YAJEfQSbhU4ZZ+asrWYwPMjQgb3x5eWQecOj6+UGEqTTdqiuhNbKveBPXN+JzYER5Hw1NA8l3y58IJRTtrw3f0GkYHVf7VSREHNfOpn2ZEAEi1zwm7sOToF7l2USwH7tQMlYa/FKTIWXeyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714638547; c=relaxed/simple;
	bh=Xcde/V51s4EBPFg8d9hKo6qIzmPvYAM06fBAWG2hLig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lCIV/nmv+wXQoEf2Wfuc8J/+Ufn+dxT43nYq7bsVaARpsEPx+FRjGTno71p6nPQLfG1g+p+4uMykcEBEQ2BP5RKN10l5CqgP6ONA6qICUlXOY6akiFXiWMvcARjXRhJBg5qSTnpF1yGGkjAikombSRZTj3QkSE7iSUiWUr7LkAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VD6/PtaZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E22BC116B1;
	Thu,  2 May 2024 08:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714638547;
	bh=Xcde/V51s4EBPFg8d9hKo6qIzmPvYAM06fBAWG2hLig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VD6/PtaZFKG4sVUhqq4rC6ZQ2+ji6ibVDxfvb3D3tWkPn8/Gamc26iaXoibynvBTh
	 8TgmogZzodAVR1zP2MOKENaQaQ4wX/dtYUFnKDQWc7tEe77oD+J5me45ELAgslX6kY
	 fgBrGlLKsuXiEihc0JmQEgsNGw1c8O2RSl/Czczpetjnsv19EndT//7BbrRV/lLgFC
	 wPXqnW5AlbGceSG81bL+dVhAowZlIdPvVFKBU9CUBrQctCGUIIqXP1c/hOwyeOITdv
	 ca3fILuh+/j3Frm5VGpQJGwJdO9KfZgJ5fQ0hEVLoebTJF8JPqkzZF8lkEGYUVo+mq
	 NR12WewNJtvuw==
Date: Thu, 2 May 2024 09:29:02 +0100
From: Simon Horman <horms@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, rmk+kernel@armlinux.org.uk, andrew@lunn.ch,
	netdev@vger.kernel.org, mengyuanlou@net-swift.com,
	duanqiangwen@net-swift.com
Subject: Re: [PATCH net v2 3/4] net: wangxun: match VLAN CTAG and STAG
 features
Message-ID: <20240502082902.GB2821784@kernel.org>
References: <20240429102519.25096-1-jiawenwu@trustnetic.com>
 <20240429102519.25096-4-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429102519.25096-4-jiawenwu@trustnetic.com>

On Mon, Apr 29, 2024 at 06:25:18PM +0800, Jiawen Wu wrote:
> Hardware requires VLAN CTAG and STAG configuration always matches. And
> whether VLAN CTAG or STAG changes, the configuration needs to be changed
> as well.
> 
> Fixes: 6670f1ece2c8 ("net: txgbe: Add netdev features support")
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>

Hi Jiawen Wu,

Thanks for addressing my review of v1.

Reviewed-by: Simon Horman <horms@kernel.org>

...

