Return-Path: <netdev+bounces-209707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C5DB10796
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 12:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2746917D4F8
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 10:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB67263C75;
	Thu, 24 Jul 2025 10:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r+YDDSEo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CC52417C3
	for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 10:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753352308; cv=none; b=G+lq4j8rx67+kNdf3i5Rpy7Dd3y7F6ueU4wLgUrEvBXXtmvjRg4CVhGVcR9QusUu1O06dR002Oilkmy//C0D2jZW2gDSAxRwiBajCmetc9GLKX4NMuULAXA6X+nTMZQQuI78J5vIJLP5Hsh8anRb4yLTjVg9ItIQlrFQMTvtgCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753352308; c=relaxed/simple;
	bh=W9gNEhoVeDO0+lPhw8q8/9fzFQaBQrh13p320sJbSEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UaVT1YNJ8MBq3wFKbruHICwm9sr5YAMFSIECdkUbpVntCA0LDDVzsG6CW3wWBBpwZeHQCb5+D6kG9aKOiBMryi3avMuAeGWCmlPSRO1Z0Bd+PukW12cn/nh9KolSgPoNxzfbA3hCqGrbGpJw0xmpvtZUpcUzdx2+JMjxyP2H7ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r+YDDSEo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1321CC4CEF4;
	Thu, 24 Jul 2025 10:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753352308;
	bh=W9gNEhoVeDO0+lPhw8q8/9fzFQaBQrh13p320sJbSEg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r+YDDSEoXwfOPsos3/StAiWpMXECGyp12ErW/VtnIa95aJEc53Lq7I58uWvatqsoU
	 oRXJV4R4VRZdTLJHE2Z9u5KJYDOnVvdWoAcfuJr8TdR8jmWgSKheO5WtOu2qZ/b6tL
	 N/bKjnSEs1TWxaspTf/ph02TrGkcHVHhZOQYpI3MXRZR0hy+ngr2BgWXMeV/MyRZaz
	 4tj64kyR9XHmk/821ki8LFWQa37SUE41Ym9gwfBgXQ8UCMBNTnIrfEvFD5SXVwwbjk
	 z8fLokzi6pG5lAnLwSOu3qz5jL4PFGKrNkvecZP3SrJWggjUrGofJPhGAjjbQVvejt
	 2UjSgk50xSJoA==
Date: Thu, 24 Jul 2025 11:18:22 +0100
From: Simon Horman <horms@kernel.org>
To: Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, alexanderduyck@fb.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, vadim.fedorenko@linux.dev, jdamato@fastly.com,
	sdf@fomichev.me, aleksander.lobakin@intel.com, ast@kernel.org,
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com
Subject: Re: [PATCH net-next 8/9] eth: fbnic: Collect packet statistics for
 XDP
Message-ID: <20250724101822.GJ1150792@horms.kernel.org>
References: <20250723145926.4120434-1-mohsin.bashr@gmail.com>
 <20250723145926.4120434-9-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723145926.4120434-9-mohsin.bashr@gmail.com>

On Wed, Jul 23, 2025 at 07:59:25AM -0700, Mohsin Bashir wrote:
> Add support for XDP statistics collection and reporting via rtnl_link
> and netdev_queue API.
> 
> For XDP programs without frags support, fbnic requires MTU to be less
> than the HDS threshold. If an over-sized frame is received, the frame
> is dropped and recorded as rx_length_errors reported via ip stats to
> highlight that this is an error.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
> ---
>  .../device_drivers/ethernet/meta/fbnic.rst    | 10 +++++
>  .../net/ethernet/meta/fbnic/fbnic_netdev.c    | 30 +++++++++++++
>  drivers/net/ethernet/meta/fbnic/fbnic_txrx.c  | 44 +++++++++++++++++--
>  drivers/net/ethernet/meta/fbnic/fbnic_txrx.h  |  1 +
>  4 files changed, 82 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/networking/device_drivers/ethernet/meta/fbnic.rst b/Documentation/networking/device_drivers/ethernet/meta/fbnic.rst
> index afb8353daefd..ad5e2cba7afc 100644
> --- a/Documentation/networking/device_drivers/ethernet/meta/fbnic.rst
> +++ b/Documentation/networking/device_drivers/ethernet/meta/fbnic.rst
> @@ -160,3 +160,13 @@ behavior and potential performance bottlenecks.
>  	  credit exhaustion
>          - ``pcie_ob_rd_no_np_cred``: Read requests dropped due to non-posted
>  	  credit exhaustion
> +
> +XDP Length Error:
> +~~~~~~~~~~~~~~~~~
> +
> +For XDP programs without frags support, fbnic tries to make sure that MTU fits
> +into a single buffer. If an oversized frame is received and gets fragmented,
> +it is dropped and the following netlink counters are updated
> +   - ``rx-length``: number of frames dropped due to lack of fragmentation
> +   support in the attached XDP program
> +   - ``rx-errors``: total number of packets with errors received on the interface

Hi Mohsin,

make hmtldocs complains a bit about this:

  .../fbnic.rst:170: ERROR: Unexpected indentation. [docutils]
  .../fbnic.rst:171: WARNING: Bullet list ends without a blank line; unexpected unindent. [docutils]

Empirically, and I admit there was much trial and error involved,
I was able to address this by:
* adding a blank before the start of the list
* updating the indentation of the follow-on line of the first entry of the list

Your mileage may vary.

diff --git a/Documentation/networking/device_drivers/ethernet/meta/fbnic.rst b/Documentation/networking/device_drivers/ethernet/meta/fbnic.rst
index ad5e2cba7afc..fb6559fa4be4 100644
--- a/Documentation/networking/device_drivers/ethernet/meta/fbnic.rst
+++ b/Documentation/networking/device_drivers/ethernet/meta/fbnic.rst
@@ -167,6 +167,7 @@ XDP Length Error:
 For XDP programs without frags support, fbnic tries to make sure that MTU fits
 into a single buffer. If an oversized frame is received and gets fragmented,
 it is dropped and the following netlink counters are updated
+
    - ``rx-length``: number of frames dropped due to lack of fragmentation
-   support in the attached XDP program
+     support in the attached XDP program
    - ``rx-errors``: total number of packets with errors received on the interface

