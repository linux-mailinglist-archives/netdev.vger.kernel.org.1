Return-Path: <netdev+bounces-145242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B20009CDE5F
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 13:39:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A50A1F2319D
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 12:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2DE558BB;
	Fri, 15 Nov 2024 12:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hQ9uF404"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795061B6CF1
	for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 12:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731674302; cv=none; b=DVlRTCPQQMBRexwEh/iDDlACpcfWSDjpMAVFYGsrSxavZhmw7RA/vD+2m/NgDDJWvOaMq8jrqb2IGrD33uTCKTfcHbUnBZ78F9knOPZeC+53StOq024zB9XaW5FAzl7bXqr3Bh44NMwBy7A2hWPtsXTW5QBTelDQ5LAFfKlheio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731674302; c=relaxed/simple;
	bh=wF9ZmkatT4npVqnDubQ5KfN4GgDfZfCVqUvTI3bcGlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lm2lnbOJtaiSZTKu3ZXj2P62h+ocNBJ1YYcZI9iY2+Bj8lWJl+VYuamRqHbzQ/WYxdFh8X5nhdEN3ZIYlMmFRveJiQb48EHY65j85z5uHHLrmCcpNLFMf5HnThieq7xowhVKqARGOvd2vdoKOEgtvh7zAsYzTFItAtVgZ2RIGko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hQ9uF404; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF5E4C4CECF;
	Fri, 15 Nov 2024 12:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731674302;
	bh=wF9ZmkatT4npVqnDubQ5KfN4GgDfZfCVqUvTI3bcGlI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hQ9uF404Rb8Fe30AtvBpJe7uvw0z8coYGXcY38WXEKq0/eGiOARc953oLR3/8efZJ
	 XcI/BNaKhMSuK8FMO1zJXlzny7p9QSyQAe97b4DESuAiPamlBqQ5adnKwPu5TSBeAm
	 3VrDJbyPDzdS8k1GQZ57TfUJPaBTals0e5xIRX2xVFDlfq+8yM9xE5TZ4IlAly4myV
	 l6Kc7xA3l8s0o3NeFwSRKkCgR3ZrXile4sA0cC6qUNqrKJQshdZk2pK6BKChtbJ2ot
	 O1DpRzvuATqR4BqaLZ8NIwa6xom+fLLy6hmlH0fEQD1VlETF21FNCMYbXi+cCSFB+r
	 BD7l9G3fBrH2A==
Date: Fri, 15 Nov 2024 12:38:18 +0000
From: Simon Horman <horms@kernel.org>
To: Milena Olech <milena.olech@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	Alexander Lobakin <aleksander.lobakin@intel.com>
Subject: Re: [PATCH iwl-net 01/10] idpf: initial PTP support
Message-ID: <20241115123818.GM1062410@kernel.org>
References: <20241113154616.2493297-1-milena.olech@intel.com>
 <20241113154616.2493297-2-milena.olech@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113154616.2493297-2-milena.olech@intel.com>

On Wed, Nov 13, 2024 at 04:46:09PM +0100, Milena Olech wrote:
> PTP feature is supported if the VIRTCHNL2_CAP_PTP is negotiated during the
> capabilities recognition. Initial PTP support includes PTP initialization
> and registration of the clock.
> 
> Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Signed-off-by: Milena Olech <milena.olech@intel.com>

...

> diff --git a/drivers/net/ethernet/intel/idpf/idpf_ptp.h b/drivers/net/ethernet/intel/idpf/idpf_ptp.h
> new file mode 100644
> index 000000000000..cb19988ca60f
> --- /dev/null
> +++ b/drivers/net/ethernet/intel/idpf/idpf_ptp.h
> @@ -0,0 +1,32 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/* Copyright (C) 2024 Intel Corporation */
> +
> +#ifndef _IDPF_PTP_H
> +#define _IDPF_PTP_H
> +
> +#include <linux/ptp_clock_kernel.h>
> +
> +/**
> + * struct idpf_ptp - PTP parameters
> + * @info: structure defining PTP hardware capabilities
> + * @clock: pointer to registered PTP clock device
> + * @adapter: back pointer to the adapter
> + */
> +struct idpf_ptp {
> +	struct ptp_clock_info info;
> +	struct ptp_clock *clock;
> +	struct idpf_adapter *adapter;
> +};
> +
> +#if IS_ENABLED(CONFIG_PTP_1588_CLOCK)
> +int idpf_ptp_init(struct idpf_adapter *adapter);
> +void idpf_ptp_release(struct idpf_adapter *adapter);
> +#else /* CONFIG_PTP_1588_CLOCK */
> +static inline int idpf_ptp_init(struct idpf_adapter *adpater)

nit: adapter

> +{
> +	return 0;
> +}
> +
> +static inline void idpf_ptp_release(struct idpf_adapter *adpater) { }

Ditto

> +#endif /* CONFIG_PTP_1588_CLOCK */
> +#endif /* _IDPF_PTP_H */

...

