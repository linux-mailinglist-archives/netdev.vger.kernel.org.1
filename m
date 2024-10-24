Return-Path: <netdev+bounces-138515-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF959ADF74
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 10:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15502280F48
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 08:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000A61AE001;
	Thu, 24 Oct 2024 08:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jMyNhAuR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07036F305
	for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 08:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729759691; cv=none; b=jJaqFJHOu62uvHVPTZBNJOWj3EMlG2LirEn43FJKFmV2jBNI0ZRUh7Ifah0emAnuvvOntBmqS+FtsCnc9o7K7hZLmH8BL68Tjh4lgafFB20B04GuMGmSPLqVjGl8OnZUqWPCEUSk2/ZCymP7P5E5Kwf/qkGMklyPNniTgw0mptQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729759691; c=relaxed/simple;
	bh=0mAs+dj2aMhXa0tkBs92oIB1EBDeAPVctb1kO6zOQmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OyIMWXpmi7e2kfjkOZTaPzgZFAMRpPJ4AISM7hDm7AgPCik+ZZkuVCoslfqdljBE30J3ennD6SQNMVAVWXqMGUZ+Lb+cDIseOlcK9x6I6dQ/IEDnrLoRvh+EGFcCkl/5xmB3XT6IDAUqRmeMFD1EoeRta4FwoKsCbaUhWTXfJIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jMyNhAuR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F19DC4CEC7;
	Thu, 24 Oct 2024 08:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729759691;
	bh=0mAs+dj2aMhXa0tkBs92oIB1EBDeAPVctb1kO6zOQmM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jMyNhAuRjJXsy0Dc/Li/AHt84El1J8VbWRHP95b19VvPTnxe03VCc6+F90/QB1cND
	 MIBi16O0Jk+VXydY0wkCBrgOHU2V4ZCVh4ZMtj+bNlU3HDAlPWgtAlC2efVRHFf7bX
	 8ydYbwWgbU3XVktss52kGRH9q9FoBAdmU5Q7myVJmxJfxGj6JyGYiNfUYwEdB/93+I
	 iTx3+XfcC6BjzZEoemcW9o/aLHL5PEP3S83+z1Uw3Ga/a+Lb+PXFcQaUIILjQGJwbD
	 Ycgfnn8E/SdWBs+jp4FFnSgcwGZhiIWP87kMxX1nTjKzTlQjVcfgmbzHwjsr90UxuQ
	 awI6hAvTfwwCw==
Date: Thu, 24 Oct 2024 09:48:06 +0100
From: Simon Horman <horms@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jeff Garzik <jgarzik@redhat.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Piotr Raczynski <piotr.raczynski@intel.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Milena Olech <milena.olech@intel.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Michal Michalik <michal.michalik@intel.com>,
	netdev <netdev@vger.kernel.org>, Jiri Pirko <jiri@resnulli.us>,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: Re: [PATCH net 3/3] ice: fix crash on probe for DPLL enabled E810 LOM
Message-ID: <20241024084806.GG402847@kernel.org>
References: <20241021-iwl-2024-10-21-iwl-net-fixes-v1-0-a50cb3059f55@intel.com>
 <20241021-iwl-2024-10-21-iwl-net-fixes-v1-3-a50cb3059f55@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021-iwl-2024-10-21-iwl-net-fixes-v1-3-a50cb3059f55@intel.com>

On Mon, Oct 21, 2024 at 04:26:26PM -0700, Jacob Keller wrote:
> From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> 
> The E810 Lan On Motherboard (LOM) design is vendor specific. Intel
> provides the reference design, but it is up to vendor on the final
> product design. For some cases, like Linux DPLL support, the static
> values defined in the driver does not reflect the actual LOM design.
> Current implementation of dpll pins is causing the crash on probe
> of the ice driver for such DPLL enabled E810 LOM designs:
> 
> WARNING: (...) at drivers/dpll/dpll_core.c:495 dpll_pin_get+0x2c4/0x330
> ...
> Call Trace:
>  <TASK>
>  ? __warn+0x83/0x130
>  ? dpll_pin_get+0x2c4/0x330
>  ? report_bug+0x1b7/0x1d0
>  ? handle_bug+0x42/0x70
>  ? exc_invalid_op+0x18/0x70
>  ? asm_exc_invalid_op+0x1a/0x20
>  ? dpll_pin_get+0x117/0x330
>  ? dpll_pin_get+0x2c4/0x330
>  ? dpll_pin_get+0x117/0x330
>  ice_dpll_get_pins.isra.0+0x52/0xe0 [ice]
> ...
> 
> The number of dpll pins enabled by LOM vendor is greater than expected
> and defined in the driver for Intel designed NICs, which causes the crash.
> 
> Prevent the crash and allow generic pin initialization within Linux DPLL
> subsystem for DPLL enabled E810 LOM designs.
> 
> Newly designed solution for described issue will be based on "per HW
> design" pin initialization. It requires pin information dynamically
> acquired from the firmware and is already in progress, planned for
> next-tree only.
> 
> Fixes: d7999f5ea64b ("ice: implement dpll interface to control cgu")
> Reviewed-by: Karol Kolacinski <karol.kolacinski@intel.com>
> Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


