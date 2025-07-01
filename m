Return-Path: <netdev+bounces-202892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D453AEF92C
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 14:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D7684A26F6
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 12:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097F718DB27;
	Tue,  1 Jul 2025 12:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQJKVTQe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93001E515
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 12:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751374214; cv=none; b=qH3NE5NJKnTCwElu4JdL4oXummCQ2EfDl+CepDebkZyvbzTcpB7R/HIQ+o4auuBPWkuJ1EOpighrB9L5xkfyN0xY1hFOG31rJePVeSMcwr4rDOi1dmk3u7KYswDhNmOADVkQezlCTyYTJATeOQVg+d3p7RX3yEZFWW3wIYGW16o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751374214; c=relaxed/simple;
	bh=BG1gTBZXgf+EQIjAnAdvj39qCVM+cDiy04QR+WLx1CU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CCgzbmtzxi3F3ez4/Zt2c8hVm3c4DktuC3gHDRTuxNCg5D1Y0GcmScArdePqbdJ50se8N5YZN9hycu2fTL8zhpOfReMwoZgGBYATOb63JkdZVzAWqXEYupG4HsjphXR5UPF6+Sg9crf96OO9PqMPOD8gE6Mc3kdWuYtYOt/3rBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZQJKVTQe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C3A3C4CEEB;
	Tue,  1 Jul 2025 12:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751374214;
	bh=BG1gTBZXgf+EQIjAnAdvj39qCVM+cDiy04QR+WLx1CU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZQJKVTQeHoA7r0kNUxz6avtUVxnrROsYqMJgUiy1q83r3+a06ZpqHDh9sD1lsCaKJ
	 NOyU6alhVj75qovngWWYDcyJsRuYGOJUQdi4m/f6iZWg2s25cRTzdslJ2C0Am5rXAi
	 0TkkXZ8KiSaAQDrDM8inh6olB5i3bN5SNm6G4bcqm+uPHxnQVzAM2a2jF/Z8m4uG9i
	 XgRAkmrsqXlpj2Q58248TlRwqAvrnivrzP3H5c113Ho/Rmk+SJ9YWwxnaG4An4/e5H
	 Rn7yWIMX9aYeFwmoaDdviT979hOsUG20xJl5yL594F2J8KI+zSg2uKFUc4rXxD0qRa
	 qUT/iKZPCp1NQ==
Date: Tue, 1 Jul 2025 13:50:08 +0100
From: Simon Horman <horms@kernel.org>
To: Aurelien Aptel <aaptel@nvidia.com>
Cc: linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
	sagi@grimberg.me, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
	chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org,
	aurelien.aptel@gmail.com, smalin@nvidia.com, malin1024@gmail.com,
	ogerlitz@nvidia.com, yorayz@nvidia.com, borisp@nvidia.com,
	galshalom@nvidia.com, mgurtovoy@nvidia.com, tariqt@nvidia.com,
	gus@collabora.com, edumazet@google.com, pabeni@redhat.com
Subject: Re: [PATCH v29 02/20] netlink: add new family to manage ULP_DDP
 enablement and stats
Message-ID: <20250701125008.GP41770@horms.kernel.org>
References: <20250630140737.28662-1-aaptel@nvidia.com>
 <20250630140737.28662-3-aaptel@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630140737.28662-3-aaptel@nvidia.com>

On Mon, Jun 30, 2025 at 02:07:19PM +0000, Aurelien Aptel wrote:
> Add a new netlink family to get/set ULP DDP capabilities on a network
> device and to retrieve statistics.
> 
> The messages use the genetlink infrastructure and are specified in a
> YAML file which was used to generate some of the files in this commit:
> 
> ./tools/net/ynl/ynl-gen-c.py --mode kernel \
>     --spec ./Documentation/netlink/specs/ulp_ddp.yaml --header \
>     -o net/core/ulp_ddp_gen_nl.h
> ./tools/net/ynl/ynl-gen-c.py --mode kernel \
>     --spec ./Documentation/netlink/specs/ulp_ddp.yaml --source \
>     -o net/core/ulp_ddp_gen_nl.c
> ./tools/net/ynl/ynl-gen-c.py --mode uapi \
>     --spec ./Documentation/netlink/specs/ulp_ddp.yaml --header \
>     > include/uapi/linux/ulp_ddp.h
> 
> Signed-off-by: Shai Malin <smalin@nvidia.com>
> Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> ---
>  Documentation/netlink/specs/ulp_ddp.yaml | 172 +++++++++++
>  include/net/ulp_ddp.h                    |   3 +-
>  include/uapi/linux/ulp_ddp.h             |  61 ++++
>  net/core/Makefile                        |   2 +-
>  net/core/ulp_ddp_gen_nl.c                |  75 +++++
>  net/core/ulp_ddp_gen_nl.h                |  30 ++
>  net/core/ulp_ddp_nl.c                    | 348 +++++++++++++++++++++++
>  7 files changed, 689 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/netlink/specs/ulp_ddp.yaml
>  create mode 100644 include/uapi/linux/ulp_ddp.h
>  create mode 100644 net/core/ulp_ddp_gen_nl.c
>  create mode 100644 net/core/ulp_ddp_gen_nl.h
>  create mode 100644 net/core/ulp_ddp_nl.c
> 
> diff --git a/Documentation/netlink/specs/ulp_ddp.yaml b/Documentation/netlink/specs/ulp_ddp.yaml
> new file mode 100644
> index 000000000000..27a0b905ec28
> --- /dev/null
> +++ b/Documentation/netlink/specs/ulp_ddp.yaml
> @@ -0,0 +1,172 @@
> +# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
> +#
> +# Author: Aurelien Aptel <aaptel@nvidia.com>
> +#
> +# Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES.  All rights reserved.
> +#
> +
> +name: ulp_ddp

I think that the name needs to avoid using '_' ('-' seems ok)
in order for make -C tools/net/ynl/ to run successfully
on current net-next.

...

> +    name: caps
> +    attributes:
> +      -
> +        name: ifindex
> +        doc: Interface index of the net device.
> +        type: u32
> +      -
> +        name: hw
> +        doc: Bitmask of the capabilities supported by the device.
> +        type: uint
> +        enum: cap
> +        enum-as-flags: true
> +      -
> +        name: active
> +        doc: Bitmask of the capabilities currently enabled on the device.
> +        type: uint
> +        enum: cap
> +        enum-as-flags: true
> +      -
> +        name: wanted
> +        doc: >
> +          New active bit values of the capabilities we want to set on the
> +          device.
> +        type: uint
> +        enum: cap
> +        enum-as-flags: true
> +      -
> +        name: wanted_mask

Likewise here.

> +        doc: Bitmask of the meaningful bits in the wanted field.
> +        type: uint
> +        enum: cap
> +        enum-as-flags: true
> +

...

> +      name: caps-set
> +      doc: Set ULP DDP capabilities.
> +      attribute-set: caps
> +      do:
> +        request:
> +          attributes:
> +            - ifindex
> +            - wanted
> +            - wanted_mask

And correspondingly, here.

> +        reply:
> +          attributes:
> +            - ifindex
> +            - hw
> +            - active
> +        pre: ulp_ddp_get_netdev
> +        post: ulp_ddp_put_netdev
> +    -
> +      name: caps-set-ntf
> +      doc: Notification for change in ULP DDP capabilities.
> +      notify: caps-get

...

