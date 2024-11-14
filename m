Return-Path: <netdev+bounces-144768-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 367449C866E
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 10:48:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 362BFB20F60
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 09:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D91A1632F2;
	Thu, 14 Nov 2024 09:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="l4awCVXA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13D71D86CB
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 09:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731577728; cv=none; b=lVmK8CT3bHMIdIh6QI65iMmQhZBVIh9SfLnxAoHoQ7SoZCm5gbRREqFCHRMN86miEbvZomMV009BYQSlN69WALFkIceXRnmTItlqJLkIoIMchs+/akISBfIo/Ow2OESeu7+9LRTU31oPMnusRe04l3oZcyaM9fFNuaus3oJ6Vzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731577728; c=relaxed/simple;
	bh=2eVGFsEwFxEzguo5PUsgTmIOQvDSHg7dQJKbqTZ5exg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pDdgKxVayEkgxE7D8UFi3bIFPmoZnkll9qvcJ0gKtCa4Ia4DdlF8ank4h6+YOXh8putgZff9p5stqRJyhAncn0+NHds6xiuAPnMzPyofchfFiBHU0LgKxigBwaQCje0RVYoJR3JwZlj5jS58lkwT3uVu7bA7q2pF/WqTIq8l1Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=l4awCVXA; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2fb4af0b6beso6395801fa.3
        for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 01:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1731577723; x=1732182523; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MF+LB5vY5XN5DJWkiO2TCoHnqOIilOeORHcXsi/4JV4=;
        b=l4awCVXApv2bYldEHW8JXdXS8Y0vWMfEBFTGkAS5XzF0HGC3GThYbgpekdxCsZsF29
         tcqLfpBh9l5z1UcPY9VGWFZCaOEMOmpj9ZIM1XJurSnqpFs/RHC44SwbQxNVTVxEwfrw
         8nxrCWUPYtIONJN0IiyDhvRMIHyrfBvmrm6JyRpEOELEPS4Qrc61KHWsI7VADePQP7Ae
         bycIEGVne6baZAt3/zQBz1jMhbiKAmimgKndhOP8Bsl//mI/bDAX49Oji8/65S8jFgxb
         YkGzWiKCeAp+Xm+WCzlwZCA1V8EAnR7ItN0KA7/BEPML8d03l5IBaZoH4znhyBcxTEVw
         yQ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731577723; x=1732182523;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MF+LB5vY5XN5DJWkiO2TCoHnqOIilOeORHcXsi/4JV4=;
        b=V/s2+ipcNNiYxtdZsLwLbogyWHEcnKYqAEfQPnntXt+BCsQ8lS+aFxDyeCQy9X2+Aa
         7mFvIenVt3Cwk/BIUg3olSWB0+NvSw3ZNNOra5Dyr1tLpC7u9GaufkY2MZWLWvA1mYBU
         oGvry31MKuyzO11F0MEV9nN5X1cwCLWJnYMMYsxzMbDAowg9+kCl1z0psNkxs+Tl7Es1
         v4Ab0BOoTAP8kdSRJLHhWM6Wg0PJ1bpfWeu8z9Y3bf5LwIdxitaNoIdFbKg8BqSviHOX
         XeuylPc8Pq9khasRNv5uET+EQUdsdteDTdgmOi3oEnALlPNaToeaEc8EEa26pbvwfU3C
         Xq9w==
X-Forwarded-Encrypted: i=1; AJvYcCWSbzpd566++j0MGc6Ybb3nNUE2TtriMYleXdRPzYsRrFvRAJbaldOKpSVlfKP5pgE3pHDWpgA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5GrD3WurAFX6xkJ6l288EuvVaFhkcYQHTNMxMZwYGoiuwE32H
	zeDfqIH7gYlg6+L+2r9TRVAle7x9VGm8WFrf+mAnZylxZKRYDQWbRLXLUgvzZLk=
X-Google-Smtp-Source: AGHT+IGz1VhBKikb5ujuNVw64OLQ91wgkDEC2gE/BTcXmDPZGmmkJm8JJx1d1Y7F3sRXc5D6aKTn4g==
X-Received: by 2002:a2e:a551:0:b0:2fb:5c84:929b with SMTP id 38308e7fff4ca-2ff5909ed16mr12050791fa.36.1731577722526;
        Thu, 14 Nov 2024 01:48:42 -0800 (PST)
Received: from localhost (78-80-20-45.customers.tmcz.cz. [78.80.20.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20e046af2sm42188166b.161.2024.11.14.01.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 01:48:41 -0800 (PST)
Date: Thu, 14 Nov 2024 10:48:40 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Carolina Jubran <cjubran@nvidia.com>,
	Cosmin Ratiu <cratiu@nvidia.com>
Subject: Re: [PATCH net-next 3/8] devlink: Extend devlink rate API with
 traffic classes bandwidth management
Message-ID: <ZzXHeDlsshYCeu73@nanopsycho.orion>
References: <20241113180034.714102-1-tariqt@nvidia.com>
 <20241113180034.714102-4-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113180034.714102-4-tariqt@nvidia.com>

Wed, Nov 13, 2024 at 07:00:28PM CET, tariqt@nvidia.com wrote:
>From: Carolina Jubran <cjubran@nvidia.com>
>
>Introduce support for specifying bandwidth proportions between traffic
>classes (TC) in the devlink-rate API. This new option allows users to
>allocate bandwidth across multiple traffic classes in a single command.
>
>This feature provides a more granular control over traffic management,
>especially for scenarios requiring Enhanced Transmission Selection.
>
>Users can now define a specific bandwidth share for each traffic class,
>such as allocating 20% for TC0 (TCP/UDP) and 80% for TC5 (RoCE).
>
>Example:
>DEV=pci/0000:08:00.0
>
>$ devlink port function rate add $DEV/vfs_group tx_share 10Gbit \
>  tx_max 50Gbit tc-bw 0:20 1:0 2:0 3:0 4:0 5:80 6:0 7:0
>
>$ devlink port function rate set $DEV/vfs_group \
>  tc-bw 0:20 1:0 2:0 3:0 4:0 5:10 6:60 7:0
>
>Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
>Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
>Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
>---
> Documentation/netlink/specs/devlink.yaml | 50 ++++++++++++++++++++
> include/net/devlink.h                    |  6 +++
> include/uapi/linux/devlink.h             | 10 ++++
> net/devlink/netlink_gen.c                | 21 +++++++--
> net/devlink/netlink_gen.h                |  1 +
> net/devlink/rate.c                       | 60 ++++++++++++++++++++++--
> 6 files changed, 141 insertions(+), 7 deletions(-)
>
>diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
>index 09fbb4c03fc8..41fdc2514f69 100644
>--- a/Documentation/netlink/specs/devlink.yaml
>+++ b/Documentation/netlink/specs/devlink.yaml
>@@ -817,6 +817,34 @@ attribute-sets:
>       -
>         name: rate-tx-weight
>         type: u32
>+      -
>+        name: rate-tc-0-bw
>+        type: u32
>+      -
>+        name: rate-tc-1-bw
>+        type: u32
>+      -
>+        name: rate-tc-2-bw
>+        type: u32
>+      -
>+        name: rate-tc-3-bw
>+        type: u32
>+      -
>+        name: rate-tc-4-bw
>+        type: u32
>+      -
>+        name: rate-tc-5-bw
>+        type: u32
>+      -
>+        name: rate-tc-6-bw
>+        type: u32
>+      -
>+        name: rate-tc-7-bw
>+        type: u32

This is very odd to embed index into name of attribute. Please don't do
that. Could you please separate that and have rate-tc-index as a separate
attr?


>+      -
>+        name: rate-tc-bw
>+        type: nest
>+        nested-attributes: dl-rate-tc-bw-values

[...]

