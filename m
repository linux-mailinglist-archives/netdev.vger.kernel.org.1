Return-Path: <netdev+bounces-105526-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A535F911918
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 05:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 684192836F4
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 03:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6C185C5E;
	Fri, 21 Jun 2024 03:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rOJUC3K8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDE729A5;
	Fri, 21 Jun 2024 03:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718941227; cv=none; b=QjDIahb2mqaXdYML3OBnqpwsOv4Li4RiX1Y6quW1yZgsVH0f+s0/trYYcmJ+OvtBkhiG44zxTBQkvp3V+fisanAOqGQA+y/rmZuCnW/x7XA+klZiyS9xsm3WNQkVN88UIgu/YjAk66P29nUfWv1uhTWIwZT2vTp/KBgkNEcapjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718941227; c=relaxed/simple;
	bh=ciZ1lTmXuCBgi9Fj501lnOOEXx/p7Csk/oTxyudousw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pxuvkUo2MwY8y91j1f3ibzS7XOxkC6WGkZl2mbj1pkHCL8xXvEMaIdpSKHFT7iqJQgGjlUeaA6X3SmQd78MXX0vcu34U7HU2B0+e1a5UWSqS3MsgXgHrJFJpAFm8ZK+WNAdzKQrDJrOCgjIve0CqY0x6TCxz95g5mbFzQ0MUxTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rOJUC3K8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14E3BC2BBFC;
	Fri, 21 Jun 2024 03:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718941227;
	bh=ciZ1lTmXuCBgi9Fj501lnOOEXx/p7Csk/oTxyudousw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rOJUC3K8bMHnklqkeEv2ssBbwS8khhSSgGf4JOF6Wr3p/HUgvI2L5ialVz5P/E/Lg
	 OYs95ZGMlUt8uHN4gClLS+YBTXhQ0H5oI/7gYQPCxD1dwFQkZYGzaxuzQcb2cE5MSu
	 NBCdSvfCmKKuMXVU+MKk7BbGsk61CM9XkmSYF/XvObGSAHYcd/i7VH+49xoP19aJSk
	 h9l/DuT3/sJiL414uOkCxZ/N2o5uDIEI0jRRE6/4wY9tl+AGeGJvOR3YWYW05O2NaX
	 P2QCZ0HmpRJH5khR2HqZlfwFO1/a81XrGX4vtt5DLsfA7EZrfJxDdAP7JHPn9UAApt
	 rQuB3SV9MJhbg==
Date: Thu, 20 Jun 2024 20:40:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, "David S .
 Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Eric
 Dumazet <edumazet@google.com>, Jason Wang <jasowang@redhat.com>, "Michael S
 . Tsirkin" <mst@redhat.com>, Brett Creeley <bcreeley@amd.com>, Ratheesh
 Kannoth <rkannoth@marvell.com>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Tal
 Gilboa <talgi@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Jiri Pirko <jiri@resnulli.us>, Paul
 Greenwalt <paul.greenwalt@intel.com>, Ahmed Zaki <ahmed.zaki@intel.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Kory Maincent
 <kory.maincent@bootlin.com>, Andrew Lunn <andrew@lunn.ch>,
 justinstitt@google.com, donald.hunter@gmail.com, Eugenio =?UTF-8?B?UMOp?=
 =?UTF-8?B?cmV6?= <eperezma@redhat.com>, Andrew Morton
 <akpm@linux-foundation.org>, Dragos Tatulea <dtatulea@nvidia.com>, Rahul
 Rameshbabu <rrameshbabu@nvidia.com>, Heiner Kallweit
 <hkallweit1@gmail.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 awel Dembicki <paweldembicki@gmail.com>
Subject: Re: [PATCH RESEND net-next v14 0/5] ethtool: provide the dim
 profile fine-tuning channel
Message-ID: <20240620204025.625f759c@kernel.org>
In-Reply-To: <20240618025644.25754-1-hengqi@linux.alibaba.com>
References: <20240618025644.25754-1-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Jun 2024 10:56:39 +0800 Heng Qi wrote:
> The NetDIM library provides excellent acceleration for many modern
> network cards. However, the default profiles of DIM limits its maximum
> capabilities for different NICs, so providing a way which the NIC can
> be custom configured is necessary.

Could you give an example in the cover letter of a type of workload and
how much a new set of DIM values helped?

