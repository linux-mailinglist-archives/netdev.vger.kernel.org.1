Return-Path: <netdev+bounces-12714-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 770617389EC
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 17:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F5B11C20EE1
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 15:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12B31953F;
	Wed, 21 Jun 2023 15:38:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E683319520
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 15:38:48 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D731BC6;
	Wed, 21 Jun 2023 08:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=UNTcJ7CGT1Lez3ibsb1q0hENK9CgDCucVIYKxGl3TOA=; b=kX5Xr6VI87reS7/GA49etmzzJa
	8UkZZawMQsboaJaBH0eNpIzk1bR3EcbBbU0KF6jAsbQhofPO8pHw+ovgkoxLGGJjfHxE1vVFC+buE
	dyHRIxHy1ZMVaryyek2UvdEHqUuLiwmWXnN8UhABnjwmxx9ilAZZaPSduE0A55vaKMZ8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qBzsX-00H9mp-GK; Wed, 21 Jun 2023 17:36:17 +0200
Date: Wed, 21 Jun 2023 17:36:17 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Evan Quan <evan.quan@amd.com>
Cc: rafael@kernel.org, lenb@kernel.org, alexander.deucher@amd.com,
	christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
	daniel@ffwll.ch, johannes@sipsolutions.net, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	mario.limonciello@amd.com, mdaenzer@redhat.com,
	maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
	hdegoede@redhat.com, jingyuwang_vip@163.com, lijo.lazar@amd.com,
	jim.cromie@gmail.com, bellosilicio@gmail.com,
	andrealmeid@igalia.com, trix@redhat.com, jsg@jsg.id.au,
	arnd@arndb.de, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH V4 1/8] drivers/acpi: Add support for Wifi band RF
 mitigations
Message-ID: <3a7c8ffa-de43-4795-ae76-5cd9b00c52b5@lunn.ch>
References: <20230621054603.1262299-1-evan.quan@amd.com>
 <20230621054603.1262299-2-evan.quan@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621054603.1262299-2-evan.quan@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jun 21, 2023 at 01:45:56PM +0800, Evan Quan wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> Due to electrical and mechanical constraints in certain platform designs
> there may be likely interference of relatively high-powered harmonics of
> the (G-)DDR memory clocks with local radio module frequency bands used
> by Wifi 6/6e/7.
> 
> To mitigate this, AMD has introduced an ACPI based mechanism that
> devices can use to notify active use of particular frequencies so
> that devices can make relative internal adjustments as necessary
> to avoid this resonance.

Do only ACPI based systems have:

   interference of relatively high-powered harmonics of the (G-)DDR
   memory clocks with local radio module frequency bands used by
   Wifi 6/6e/7."

Could Device Tree based systems not experience this problem?

> +/**
> + * APIs needed by drivers/subsystems for contributing frequencies:
> + * During probe, check `wbrf_supported_producer` to see if WBRF is supported.
> + * If adding frequencies, then call `wbrf_add_exclusion` with the
> + * start and end points specified for the frequency ranges added.
> + * If removing frequencies, then call `wbrf_remove_exclusion` with
> + * start and end points specified for the frequency ranges added.
> + */
> +bool wbrf_supported_producer(struct acpi_device *adev);
> +int wbrf_add_exclusion(struct acpi_device *adev,
> +		       struct wbrf_ranges_in *in);
> +int wbrf_remove_exclusion(struct acpi_device *adev,
> +			  struct wbrf_ranges_in *in);

Could struct device be used here, to make the API agnostic to where
the information is coming from? That would then allow somebody in the
future to implement a device tree based information provider.

       Andrew

