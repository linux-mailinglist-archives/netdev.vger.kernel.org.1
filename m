Return-Path: <netdev+bounces-214849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF61B2B6FA
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 04:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 956361B65EFB
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 02:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8587629D27A;
	Tue, 19 Aug 2025 02:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MiizOzQU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A2F13A265;
	Tue, 19 Aug 2025 02:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755570586; cv=none; b=e6+C/elAOTeLZjiDYT9PW/ZWTZAoSVnetfbM5hMfkJiFmI+EU2agx8iXQblYVy1UMUx+XbC1U849YaV7Ey2L5SCK5Pv/OeYEAj8cQRGXak3eORCYb8f5XFLfmDZTzHKY4+qegupt61gACMVgeZKEDncbE+M2pE3c4N82/D2glvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755570586; c=relaxed/simple;
	bh=pnbIGffi+m0JiaoTE1u58BWNGkLr6BjTzLhLMx6GpIM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dIgilfNMEQr9+K9sQO8avBfjaCK2GJB+yyJXdjyocNi4myHN0RFcIDuhdV/gI0nF10PePAqNO+Hy9pTzj9kStX9HOH6GayGpu2wTTONkeFI8n0B545IDUCrRbItp37w0P9YPNDEd4UoiF/Bf5nSv/JIdlFEFGy5T2PfXugudloQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MiizOzQU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80979C4CEED;
	Tue, 19 Aug 2025 02:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755570584;
	bh=pnbIGffi+m0JiaoTE1u58BWNGkLr6BjTzLhLMx6GpIM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MiizOzQUjbCkSIxwlHYSR8zVbvom7LhEBydxrRrbUgRz9NFA+rPRnUdc740pB+o4x
	 NmGpHReKVnQUmwkuKaf+/aNF+H9N7zgE9dMz9B7ZGrQjZG5etdWoRNJ7Nq4R/ILzol
	 fVe6+7I1xeAwBjm+oNVGEiOjfCbGkB1TRjcD7Agx9geoR61hjQn7ahxM1Po4YX6hYu
	 5rnOYfEmOFIKRy3esHKsSP6ZcbPnK+ZhsNm+K65+N8e0hEOG2V/IVbpPomDkxwnVcB
	 xS6OCXqRN18W0EqkN+qGndEvjH6/nskq5B9e9fUtLeiHdrbt0D8XEonDxis1ovwwWf
	 CvddQnpGFchcg==
Date: Mon, 18 Aug 2025 19:29:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Prathosh Satish <Prathosh.Satish@microchip.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Michal Schmidt
 <mschmidt@redhat.com>, Petr Oros <poros@redhat.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH net-next v3 5/5] dpll: zl3073x: Implement devlink flash
 callback
Message-ID: <20250818192943.342ad511@kernel.org>
In-Reply-To: <20250813174408.1146717-6-ivecera@redhat.com>
References: <20250813174408.1146717-1-ivecera@redhat.com>
	<20250813174408.1146717-6-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Aug 2025 19:44:08 +0200 Ivan Vecera wrote:
> +	struct zl3073x_dev *zldev = devlink_priv(devlink);
> +	struct zl3073x_fw_component *util;
> +	struct zl3073x_fw *zlfw;
> +	int rc = 0;
> +
> +	/* Load firmware */

Please drop the comments which more or less repeat the name 
of the function called.

> +	zlfw = zl3073x_fw_load(zldev, params->fw->data, params->fw->size,
> +			       extack);
> +	if (IS_ERR(zlfw))
> +		return PTR_ERR(zlfw);
> +
> +	util = zlfw->component[ZL_FW_COMPONENT_UTIL];
> +	if (!util) {
> +		zl3073x_devlink_flash_notify(zldev,
> +					     "Utility is missing in firmware",
> +					     NULL, 0, 0);
> +		rc = -EOPNOTSUPP;

I'd think -EINVAL would be more appropriate.
If you want to be fancy maybe ENOEXEC ?

> +		goto error;
> +	}
> +
> +	/* Stop normal operation during flash */
> +	zl3073x_dev_stop(zldev);
> +
> +	/* Enter flashing mode */
> +	rc = zl3073x_flash_mode_enter(zldev, util->data, util->size, extack);
> +	if (!rc) {
> +		/* Flash the firmware */
> +		rc = zl3073x_fw_flash(zldev, zlfw, extack);

this error code seems to be completely ignored, no?

> +		/* Leave flashing mode */
> +		zl3073x_flash_mode_leave(zldev, extack);
> +	}
> +
> +	/* Restart normal operation */
> +	rc = zl3073x_dev_start(zldev, true);
> +	if (rc)
> +		dev_warn(zldev->dev, "Failed to re-start normal operation\n");

And also we can't really cleanly handle the failure case.

This is why I was speculating about implementing the down/up portion
in the devlink core. Add a flag that the driver requires reload_down
to be called before the flashing operation, and reload_up after.
This way not only core handles some of the error handling, but also
it can mark the device as reload_failed if things go sideways, which 
is a nicer way to surface this sort of permanent error state.

Not feeling strongly about it, but I think it'd be cleaner, so bringing
it up in case my previous comment from a while back wasn't clear.

> +error:
> +	/* Free flash context */
> +	zl3073x_fw_free(zlfw);
> +
> +	zl3073x_devlink_flash_notify(zldev,
> +				     rc ? "Flashing failed" : "Flashing done",
> +				     NULL, 0, 0);

