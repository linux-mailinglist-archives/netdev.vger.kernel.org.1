Return-Path: <netdev+bounces-26709-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F78778A08
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 11:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B7BC28103C
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 09:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D9A5697;
	Fri, 11 Aug 2023 09:35:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FCD3FE1
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 09:35:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D312C433C8;
	Fri, 11 Aug 2023 09:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691746499;
	bh=6nDL0utgw9wol8LbIsinlH77MMHM0gseUrwwE+1ZLyU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EeG1NLe583ovTo1ZKn2ViOlb2z0+MIv6z8INw8IouAdVmkw4jEAlxtWA55ZI/rENV
	 2JS9IQHwBpdxSeezxRH21OyWoY/KJXJzAtUk71UgGeUvVJmNvJiUnbMra0c19t+tyy
	 XFVZZFQkrjbB+G7hfjPPq1lwkJq/npA8LYbO3LXS7x5GJJSw8tWGDsOU1d/5QOZG9R
	 7MLbnKt2uSes8rpWROYaRfjlziiS9cHmBz97Ys/d8kolTTgcs9NQO0Hi/7mZjE2xQH
	 j2eWboyoeIujLA8u9+EMXQZvZS4hpGDbBOtDFLKIValNbUrgKMFqu+MLcm+CtFycfK
	 z04vFqqVFQPsA==
Date: Fri, 11 Aug 2023 11:34:51 +0200
From: Simon Horman <horms@kernel.org>
To: Evan Quan <evan.quan@amd.com>
Cc: rafael@kernel.org, lenb@kernel.org, Alexander.Deucher@amd.com,
	Christian.Koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
	daniel@ffwll.ch, johannes@sipsolutions.net, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	Mario.Limonciello@amd.com, mdaenzer@redhat.com,
	maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
	hdegoede@redhat.com, jingyuwang_vip@163.com, Lijo.Lazar@amd.com,
	jim.cromie@gmail.com, bellosilicio@gmail.com,
	andrealmeid@igalia.com, trix@redhat.com, jsg@jsg.id.au,
	arnd@arndb.de, andrew@lunn.ch, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH V8 6/9] drm/amd/pm: setup the framework to support Wifi
 RFI mitigation feature
Message-ID: <ZNYAuyrEWbRiHm55@vergenet.net>
References: <20230810073803.1643451-1-evan.quan@amd.com>
 <20230810073803.1643451-7-evan.quan@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810073803.1643451-7-evan.quan@amd.com>

On Thu, Aug 10, 2023 at 03:38:00PM +0800, Evan Quan wrote:
> With WBRF feature supported, as a driver responding to the frequencies,
> amdgpu driver is able to do shadow pstate switching to mitigate possible
> interference(between its (G-)DDR memory clocks and local radio module
> frequency bands used by Wifi 6/6e/7).
> 
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

...

> +/**
> + * smu_wbrf_event_handler - handle notify events
> + *
> + * @nb: notifier block
> + * @action: event type
> + * @data: event data

Hi Evan,

a minor nit from my side: although it is documented here,
smu_wbrf_event_handler has no @data parameter, while
it does have an undocumented _arg parameter.

> + *
> + * Calls relevant amdgpu function in response to wbrf event
> + * notification from kernel.
> + */
> +static int smu_wbrf_event_handler(struct notifier_block *nb,
> +				  unsigned long action, void *_arg)
> +{
> +	struct smu_context *smu = container_of(nb, struct smu_context,
> +					       wbrf_notifier);
> +
> +	switch (action) {
> +	case WBRF_CHANGED:
> +		smu_wbrf_handle_exclusion_ranges(smu);
> +		break;
> +	default:
> +		return NOTIFY_DONE;
> +	};
> +
> +	return NOTIFY_OK;
> +}

...

