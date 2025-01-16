Return-Path: <netdev+bounces-159006-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6603A14176
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 19:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B3D33AA89F
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 18:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1E522D4D5;
	Thu, 16 Jan 2025 18:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CHIdAXgu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71DB1482E8;
	Thu, 16 Jan 2025 18:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737051043; cv=none; b=btYRo6cDMwwKrY+Axv5K8q7qIzPeT0I6raRM2Q/odI4vgqC75sy7SqcOnuz7P+s1lEDXSbEnDZM23+PE8kjFmvBy6HAJhp1ovJ9z0X6CpmHaXflP/7fcepNJXvOLZZdc/GzS5+y0ZQNRmG55eBEb7znoSnm6xalHO5/ZCqvMAxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737051043; c=relaxed/simple;
	bh=3NPNVC/E+a5ogmqsDrO+ad+5/SAxzcsOqBJ6RdfKlRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qWe+vucq8Q2Y6rqUuVAQKcQOQJOyU5nxHTbAlj1ono1asupWsoUW0TZRL9X0W1bjv0YeimxBb44QidcSWt38d4I7lFOz+L8arSNIzi8l7Bzpr1jSDnBQ/ekovkBoK2LtHYB9BqwQw+idG2KppITcPHfC0BMCjZ0d++oXcGtUjDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CHIdAXgu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CBF1C4CED6;
	Thu, 16 Jan 2025 18:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737051043;
	bh=3NPNVC/E+a5ogmqsDrO+ad+5/SAxzcsOqBJ6RdfKlRw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CHIdAXguuoXK7Vj6gWR/Z4V/vKlBvj2HVoBMVtKiKn0WOGCaQPSHzmEGPebTFOdun
	 AS2ImwmzDume/LULoK2oJBea/fnoPDeQeGxKWTu/z0oCHINZdOqc9PQAU97Vy4mrgN
	 QV5s67/cvf+glaD8loqDD48KmpXi8AEERTjFh6P022HVu7wVWS2g7xuzFJDGBlgpiC
	 2rwAwvm7ubem9vcPeyXupP+i1YZ8w8tPSLOoZJAzoCIVV6nDjf3dq+d6dNL2SBAtPr
	 MLXaZibUVXYVtpO4/PNFFdaToV2vrQPJurJhmq+RYkqDnQnw81rqo8Tdc2IWue3D+x
	 u9dk+K41ncx3A==
Date: Thu, 16 Jan 2025 18:10:37 +0000
From: Simon Horman <horms@kernel.org>
To: Gur Stavi <gur.stavi@huawei.com>
Cc: gongfan <gongfan1@huawei.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, linux-doc@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Cai Huoqing <cai.huoqing@linux.dev>, luosifu <luosifu@huawei.com>,
	Xin Guo <guoxin09@huawei.com>,
	Shen Chenyang <shenchenyang1@hisilicon.com>,
	Zhou Shuai <zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>,
	Shi Jing <shijing34@huawei.com>,
	Meny Yossefi <meny.yossefi@huawei.com>,
	Suman Ghosh <sumang@marvell.com>
Subject: Re: [PATCH net-next v04 1/1] hinic3: module initialization and tx/rx
 logic
Message-ID: <20250116181037.GE6206@kernel.org>
References: <cover.1737013558.git.gur.stavi@huawei.com>
 <992e332acb3743df9898eebba05934c2775862b5.1737013558.git.gur.stavi@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <992e332acb3743df9898eebba05934c2775862b5.1737013558.git.gur.stavi@huawei.com>

On Thu, Jan 16, 2025 at 09:51:53AM +0200, Gur Stavi wrote:
> From: gongfan <gongfan1@huawei.com>
> 
> This is [1/3] part of hinic3 Ethernet driver initial submission.
> With this patch hinic3 is a valid kernel module but non-functional
> driver.
> 
> The driver parts contained in this patch:
> Module initialization.
> PCI driver registration but with empty id_table.
> Auxiliary driver registration.
> Net device_ops registration but open/stop are empty stubs.
> tx/rx logic.
> 
> All major data structures of the driver are fully introduced with the
> code that uses them but without their initialization code that requires
> management interface with the hw.
> 
> Submitted-by: Gur Stavi <gur.stavi@huawei.com>
> Signed-off-by: Gur Stavi <gur.stavi@huawei.com>
> Signed-off-by: Xin Guo <guoxin09@huawei.com>
> Signed-off-by: gongfan <gongfan1@huawei.com>

...

> diff --git a/Documentation/networking/device_drivers/ethernet/huawei/hinic3.rst b/Documentation/networking/device_drivers/ethernet/huawei/hinic3.rst

...

> +Completion Event Queue (CEQ)
> +--------------------------

nit: the length of the "---" line doesn't match that of the line above it.

...

