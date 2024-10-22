Return-Path: <netdev+bounces-137791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C97429A9D6C
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 10:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A37E2833E8
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 08:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1076A15574A;
	Tue, 22 Oct 2024 08:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EFIKab7B"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64571A269;
	Tue, 22 Oct 2024 08:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729587058; cv=none; b=Xb2UL2859TQvzAVhaAZZxy3hqd3HMSLjMbB2WZxCvKPJ+PK+gzDv0F8r9bEqTzROSZaMz3O/xOThsEtaWYwR7ypNYSoCxP+LlZqP59dlZrCY1RERsu+z1hu94JtC9o/BlZlodn76VEgaZWBs8dOIouHcRNuouOTa7Fs0vbAy75I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729587058; c=relaxed/simple;
	bh=fm1oRh5NlgVhUYLPOZQY6fogvHoAk2YRBlpCZbweQm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q3j3ArJx0usQeBoe97X8Q0d4fJmpVL9/DveCv/g4XcvElQI9gA6Z+B7xpks/rvISXI4p6oaE/cwojpKKlJq4Cx3JzWAvNU3hZYQaxxHEhTcpIT5JLY6yzZ7QspXchh9i152TKG2fceCPlptODJnVMK0nNzo35RsVcp4tbpIR0YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EFIKab7B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F517C4CEC3;
	Tue, 22 Oct 2024 08:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729587057;
	bh=fm1oRh5NlgVhUYLPOZQY6fogvHoAk2YRBlpCZbweQm0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EFIKab7BVyKXUC4F09Yh6Y9TCEYlpySqN9HecAkPf4+ACQ3ki3lfPdCtxKeJWk/+f
	 MQw8fXHFcwQyaTux60ySQkDvwH8jqKxjbNVoWp2OLURd7WUJU9mqQBYcFK8Lb1gnJA
	 94aHkOtZJu956dt3W//NeAHynXXCA5bPjKZjVE7bRAbp6AYEVBY5BUC4eAwf/fhM7I
	 iLoGLdh1uV2+iUyHVLtzxydgqRO/PSwQ8pUvsLXzqZOTwdFk1SouMG6yl41Z2YJPs0
	 HqUR61LVIJ6bVehl/xr4KNmvO9AjOVI9FlNkCM52szYnIn6A73vrc9gCBSEaIBBcaA
	 rYKmLEkRvnwvw==
Date: Tue, 22 Oct 2024 09:50:50 +0100
From: Simon Horman <horms@kernel.org>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	andrew@lunn.ch, Lars Povlsen <lars.povlsen@microchip.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	horatiu.vultur@microchip.com,
	jensemil.schulzostergaard@microchip.com,
	Parthiban.Veerasooran@microchip.com, Raju.Lakkaraju@microchip.com,
	UNGLinuxDriver@microchip.com,
	Richard Cochran <richardcochran@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, jacob.e.keller@intel.com,
	ast@fiberby.net, maxime.chevallier@bootlin.com,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 14/15] net: sparx5: add compatible strings for
 lan969x and verify the target
Message-ID: <20241022085050.GQ402847@kernel.org>
References: <20241021-sparx5-lan969x-switch-driver-2-v1-0-c8c49ef21e0f@microchip.com>
 <20241021-sparx5-lan969x-switch-driver-2-v1-14-c8c49ef21e0f@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021-sparx5-lan969x-switch-driver-2-v1-14-c8c49ef21e0f@microchip.com>

On Mon, Oct 21, 2024 at 03:58:51PM +0200, Daniel Machon wrote:
> Add compatible strings for the twelve lan969x SKU's (Stock Keeping Unit)
> that we support, and verify that the devicetree target is supported by
> the chip target.
> 
> Each SKU supports different bandwidths and features (see [1] for
> details). We want to be able to run a SKU with a lower bandwidth and/or
> feature set, than what is supported by the actual chip. In order to
> accomplish this we:
> 
>     - add new field sparx5->target_dt that reflects the target from the
>       devicetree (compatible string).
> 
>     - compare the devicetree target with the actual chip target. If the
>       bandwidth and features provided by the devicetree target is
>       supported by the chip, we approve - otherwise reject.
> 
>     - set the core clock and features based on the devicetree target
> 
> [1] https://www.microchip.com/en-us/product/lan9698
> 
> Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
> Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
> ---
>  drivers/net/ethernet/microchip/sparx5/Makefile     |   1 +
>  .../net/ethernet/microchip/sparx5/sparx5_main.c    | 194 ++++++++++++++++++++-
>  .../net/ethernet/microchip/sparx5/sparx5_main.h    |   1 +
>  3 files changed, 193 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/microchip/sparx5/Makefile b/drivers/net/ethernet/microchip/sparx5/Makefile
> index 3435ca86dd70..8fe302415563 100644
> --- a/drivers/net/ethernet/microchip/sparx5/Makefile
> +++ b/drivers/net/ethernet/microchip/sparx5/Makefile
> @@ -19,3 +19,4 @@ sparx5-switch-$(CONFIG_DEBUG_FS) += sparx5_vcap_debugfs.o
>  # Provide include files
>  ccflags-y += -I$(srctree)/drivers/net/ethernet/microchip/vcap
>  ccflags-y += -I$(srctree)/drivers/net/ethernet/microchip/fdma
> +ccflags-y += -I$(srctree)/drivers/net/ethernet/microchip/lan969x
> diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
> index 5c986c373b3e..edbe639d98c5 100644
> --- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
> +++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
> @@ -24,6 +24,8 @@
>  #include <linux/types.h>
>  #include <linux/reset.h>
>  
> +#include "lan969x.h" /* lan969x_desc */
> +

Hi Daniel,

Perhaps this will change when Krzysztof's comment elsewhere in this thread
is addressed. But as it stands the construction in the above two hunks
appears to cause a build failure.

  CC      drivers/net/ethernet/microchip/sparx5/sparx5_main.o
In file included from drivers/net/ethernet/microchip/sparx5/sparx5_main.c:27:
./drivers/net/ethernet/microchip/lan969x/lan969x.h:10:10: fatal error: sparx5_main.h: No such file or directory
   10 | #include "sparx5_main.h"
      |          ^~~~~~~~~~~~~~~

My preference would be to move away from adding -I directives and, rather,
use relative includes as is common practice in Networking drivers (at least).

...

-- 
pw-bot: changes-requested

