Return-Path: <netdev+bounces-213526-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA70EB25850
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 02:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 153B87A601F
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 00:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3002FF674;
	Thu, 14 Aug 2025 00:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bWwXvqJd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F240463B9;
	Thu, 14 Aug 2025 00:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755130989; cv=none; b=W4T1o3kbdIp32Axp7aqsVy7dL8XJeq/o366eigq+7ScKS1KUALBfLTlPW/DuzHQ8tlkfkgZZ16AbR+C3BOpFac00vcDwBH8RXeY9xkeIdA9GPQPisecUuNKF2fqzSvjptagynvt34AKS/6UDDFnOv0aA+aCmqdfYWozVquoHetI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755130989; c=relaxed/simple;
	bh=NOYIe5fIq0ZW0wP4ciZ05r1N3+F+Cu1olPCew4z+46M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BXN8iDUPLBpQl7IqpRICckRKo3+KDNbmN87/U3rszi0Vbv3P4viMId0EhMEuDNeKYgHCuWTJB6PeRrrL4vs7BdCpFENo0hWfMogw5ps1LewBwNBttpzyIHS1nykmgCGrLR15BbB+qfjJGYH4rhLAXhDFAQq08hXtTNjwRI4FFKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bWwXvqJd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2978CC4CEEB;
	Thu, 14 Aug 2025 00:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755130988;
	bh=NOYIe5fIq0ZW0wP4ciZ05r1N3+F+Cu1olPCew4z+46M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bWwXvqJdW4O7UxRN/w7HR6j8jAxZJx0K4lOciF1ilBZScH6GoHhLOnrMiNWCzwQ0c
	 qYCb7a48kA67DJ9Rv95JlXfXAPwPY80HFFgUE22/+v12hiMIT03ldrOaXx05E3FNDe
	 uAvdrkx3eNqhVt+W8Ba6hYSE69YcmW2jZ7jeHf5RfxacZPUzqTCcLULXY0mLbCPHfM
	 pFJyzYHpDM0tSHkF1sYA2ny0BgaxTcKzsvBGF5DVbc6OxCx1Wx0zpoUuJP4STAoIcq
	 EKPYeo5MAfPWk2E33CRJ9alRaHDHUS6SE6IE1XY/a81woOjbRJ0kOusggoZfSmXIop
	 kMfNMO833CKUQ==
Date: Wed, 13 Aug 2025 17:23:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Junnan Wu <junnan01.wu@samsung.com>
Cc: mst@redhat.com, jasowang@redhat.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, ying123.xu@samsung.com,
 lei19.wang@samsung.com, q1.huang@samsung.com
Subject: Re: [PATCH net] virtio_net: adjust the execution order of function
 `virtnet_close` during freeze
Message-ID: <20250813172307.7d5603e0@kernel.org>
In-Reply-To: <20250812090817.3463403-1-junnan01.wu@samsung.com>
References: <CGME20250812090805epcas5p25ba25ca1c5c68bbdf9df27d95ccae4f5@epcas5p2.samsung.com>
	<20250812090817.3463403-1-junnan01.wu@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Aug 2025 17:08:17 +0800 Junnan Wu wrote:
> "Use after free" issue appears in suspend once race occurs when
> napi poll scheduls after `netif_device_detach` and before napi disables.

Sounds like a fix people may want to backport. Could you repost with 
an appropriate Fixes tag added, pointing to the earliest commit where
the problem can be observed?
-- 
pw-bot: cr

