Return-Path: <netdev+bounces-190101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE628AB52F6
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 12:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C4F198596D
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 10:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E3026FA6C;
	Tue, 13 May 2025 10:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HBi5Pj+A"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30E626A0E3;
	Tue, 13 May 2025 10:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747131898; cv=none; b=Oz18f7+YMSkrfx7MbkRClpBumbcRCIl/CaO9BDJysadopkx5sYD7dPanwKronWLIA0wk3qB+PKKKlOhXWf/4YNRp1YnZiwoPYzb2b7OSDgc9nuFru0grJ3rg5aoODMobJahg3ul2nB4ulyRcNTTSpvW/rnBgO7TLKLFdjsmRfFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747131898; c=relaxed/simple;
	bh=Rzy/aSrQ5qPTke3jA3lx1Ow+aIJkGCNaJloJY0vpuZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TvMOsT6vmiPKCZCrskMHxjjTsb0BkAnZH7iYC/1CvIU7eP/MNU9K8wUzfD3JcOf0OLpfFsE0umTfJcUPqq+FzaOpJsq7YAnzBueFIQjkK87USybMUnfI1deINd/FU51obitRjjtb/mmhywRi3Nowwnyz405g+55WXmJoix7vYYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HBi5Pj+A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8048C4CEEF;
	Tue, 13 May 2025 10:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747131897;
	bh=Rzy/aSrQ5qPTke3jA3lx1Ow+aIJkGCNaJloJY0vpuZ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HBi5Pj+ArRJTr5m9mWEccYUptEK4hu4fK/P47jL7upy1zXHtPwdbBRUc+1ktydFYz
	 W9COYhRqrwE1d2ayJ5tcskKWnSDkif0qlsSITCODnE8HePeLtuzcBJepCu22QJP3an
	 VPJrOGhegeNzxRiOS+qwmMANgvZqRtvS5FK1poo8rDvXnzBDF1rQj5GBE1vosYLc5d
	 CyEqXmr+4BRv/3n6Afk4J1FHAq/fn6BWKhZXk2QoMU22kHDi2kXu2oRHE6Cqc+XmFk
	 vFfbssBatn2o7O0+wUTsJ729K+KmKrPQ1es0XSdydhoN8xs44+IVy4zrv78ESNC28b
	 S4Jzk+I123ZdQ==
Date: Tue, 13 May 2025 11:24:51 +0100
From: Lee Jones <lee@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Andy Shevchenko <andy@kernel.org>,
	Michal Schmidt <mschmidt@redhat.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next v8 1/8] dt-bindings: dpll: Add DPLL device and
 pin
Message-ID: <20250513102451.GI2936510@google.com>
References: <20250507152504.85341-1-ivecera@redhat.com>
 <20250507152504.85341-2-ivecera@redhat.com>
 <84410317-6f83-46a9-aa5c-a84947b89f00@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <84410317-6f83-46a9-aa5c-a84947b89f00@linaro.org>

On Thu, 08 May 2025, Krzysztof Kozlowski wrote:

> On 07/05/2025 17:24, Ivan Vecera wrote:
> > Add a common DT schema for DPLL device and its associated pins.
> > The DPLL (device phase-locked loop) is a device used for precise clock
> > synchronization in networking and telecom hardware.
> > 
> > The device includes one or more DPLLs (channels) and one or more
> > physical input/output pins.
> > 
> One patchset per 24h. You already sent it today and immediately send
> next version without giving time for any actual review.

I just came by to say exactly the same.

There is no rush.  Please slow down.

This is not going to be applied for v6.16 and there is much to discuss.

-- 
Lee Jones [李琼斯]

