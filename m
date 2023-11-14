Return-Path: <netdev+bounces-47593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B9BC57EA959
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 05:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B4B4B20923
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 04:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A26C8F76;
	Tue, 14 Nov 2023 04:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Id+2PNl+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7FC8F70
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 04:09:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1940FC433C7;
	Tue, 14 Nov 2023 04:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699934944;
	bh=KEzu8CMPHLdHv9I7MdibYZjeRPhS5mvEErnmSoIuKJw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Id+2PNl+tT1IdBMVKMvcyK63kgBWz0H1jqDw75nhE2q+NG9B697d0uazKOJx+1qOv
	 GxJZQ9tmrpOvjTgW1pw5QoKhGlcgUkEjSUA5DMJMZHovjAHGhDZlGWg3mbiZZ+kvnj
	 dPqJC8+AuDDzilej/0W8RvyCFsb1dPIuA/0OI/TJvoWGWeCRYtBPruXH0NJ7+ZlBB3
	 X9YlfENc3fsl0/SrqCmnTVCxMKh6FA3VypiaYp5k6M4eG++j22aEQ7G3yzvEjXJ4XF
	 EtRF603ufMmqHNFvNYi4ecQCEsRDFoXzy/WD/mTmaEifa/i9ELWyunbILwHODCa6YP
	 VLCRAu0ZmXMzQ==
Date: Mon, 13 Nov 2023 23:09:02 -0500
From: Jakub Kicinski <kuba@kernel.org>
To: Gal Pressman <gal@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>, Vlad
 Buslov <vladbu@nvidia.com>
Subject: Re: [PATCH net] net: Fix undefined behavior in netdev name
 allocation
Message-ID: <20231113230902.7f342501@kernel.org>
In-Reply-To: <20231113083544.1685919-1-gal@nvidia.com>
References: <20231113083544.1685919-1-gal@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 Nov 2023 10:35:44 +0200 Gal Pressman wrote:
> Cited commit removed the strscpy() call and kept the snprintf() only.
> 
> When allocating a netdev, 'res' and 'name' pointers are equal, but
> according to POSIX, if copying takes place between objects that overlap
> as a result of a call to sprintf() or snprintf(), the results are
> undefined.
> 
> Add back the strscpy() and use 'buf' as an intermediate buffer.

It may be worth mentioning that it is fairly common to put the format
in dev->name before device is registered, IOW this condition takes
place a lot? IIUC once we cross into 3-digit IDs we may crash?

With that and the right fixes tag:

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

Thanks!
-- 
pw-bot: cr

