Return-Path: <netdev+bounces-154599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 607A19FEC01
	for <lists+netdev@lfdr.de>; Tue, 31 Dec 2024 02:03:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E5653A1FFA
	for <lists+netdev@lfdr.de>; Tue, 31 Dec 2024 01:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6796C4C76;
	Tue, 31 Dec 2024 01:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hzlu31/j"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7B7C8C7;
	Tue, 31 Dec 2024 01:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735607030; cv=none; b=bpqddAvK83+m+MP4uRAKWq+jX/p+2msDUS2xnpXLNrU4RftvxL1HD8hXG8d+vFEFK4SyVmWBO9TTOAKORktbnHilDjYcNQ+ri+fZw/YHA12EmiWAfdXSyH39fNUP48UeNsVrDD7hDFE1fkjzXzRh+PX3s9+cWV6JjGtpa38kPb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735607030; c=relaxed/simple;
	bh=SLxVkcGz5+P4J5d9OZXZNHaIHpMJMKM6U+t5J5uXOlU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ifnWXatK+uS7bwIOMaM5CmrsdgSqsxJsS8u37YarXAzSDerX9/S6m8uP+bzj1kDrq3D1EasVJynFbWpZvI7gI8CRrizMVztdhIouJy+qVkNTRsIoxrvg1XkojmawqqpOjGRVZHFMDh5kD4WuPGrjKKvkJOiiLDgaM0FNJTKbFjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hzlu31/j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68679C4CED0;
	Tue, 31 Dec 2024 01:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735607029;
	bh=SLxVkcGz5+P4J5d9OZXZNHaIHpMJMKM6U+t5J5uXOlU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hzlu31/jwQayZ+6h16cV9QCGnBLyML0qXHeAdr0dzUvQWfXyMYdfJtupRRqI4tfQS
	 yGcmMtJcRKXM9M8sCZzjsOQawmQ4GXWYxSHU1a1GyCqmlmK4sLKd127Aq1fB//2iT2
	 RQDiO85C43tqGgMdndYJ/07ypdYuL5Nwiq+31P2sGvzd20lZZzXddyoA0FBHMiinBX
	 cmaH/FPHNNO1I9m35mZM+yCh15/DeZqfdLXGOlqHLLfdC9JtazvU78caF7+QU7nqjn
	 r91WIQFDeAUL+ozLoT7oe68FW9Mzt5F4Xjl10hRTl522swAEsucTZvNRA5c5fBiEi2
	 RJMqASaIdbSwA==
Date: Mon, 30 Dec 2024 19:03:48 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Joey Lu <a0987203069@gmail.com>
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, openbmc@lists.ozlabs.org,
	andrew+netdev@lunn.ch, schung@nuvoton.com, joabreu@synopsys.com,
	netdev@vger.kernel.org, kuba@kernel.org, richardcochran@gmail.com,
	alexandre.torgue@foss.st.com, pabeni@redhat.com,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	mcoquelin.stm32@gmail.com, linux-kernel@vger.kernel.org,
	ychuang3@nuvoton.com, peppe.cavallaro@st.com, yclu4@nuvoton.com,
	edumazet@google.com, davem@davemloft.net,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v5 1/3] dt-bindings: net: nuvoton: Add schema for Nuvoton
 MA35 family GMAC
Message-ID: <173560702701.2856960.545232938075412224.robh@kernel.org>
References: <20241218114442.137884-1-a0987203069@gmail.com>
 <20241218114442.137884-2-a0987203069@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241218114442.137884-2-a0987203069@gmail.com>


On Wed, 18 Dec 2024 19:44:40 +0800, Joey Lu wrote:
> Create initial schema for Nuvoton MA35 family Gigabit MAC.
> 
> Signed-off-by: Joey Lu <a0987203069@gmail.com>
> ---
>  .../bindings/net/nuvoton,ma35d1-dwmac.yaml    | 126 ++++++++++++++++++
>  .../devicetree/bindings/net/snps,dwmac.yaml   |   1 +
>  2 files changed, 127 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/nuvoton,ma35d1-dwmac.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


