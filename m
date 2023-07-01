Return-Path: <netdev+bounces-14893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C88077445BD
	for <lists+netdev@lfdr.de>; Sat,  1 Jul 2023 03:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04E6D1C20B80
	for <lists+netdev@lfdr.de>; Sat,  1 Jul 2023 01:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4ECEDC;
	Sat,  1 Jul 2023 01:02:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA7E15CC
	for <netdev@vger.kernel.org>; Sat,  1 Jul 2023 01:02:42 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544E830DD;
	Fri, 30 Jun 2023 18:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=sJ3VBkhz2c2rPWZ1lo+kvWg61crR7igZ2KfZF/vTU3M=; b=hWUmCAf+ZSjXyHVc7Tv8TU081e
	BJPW5N614euvKV42ljLmBc1WmvJIP9OpqQ8r53Rj+5M58wGSN7/Grj647zMFVXj3Mukb3FGQZXhIc
	6g3bbLmT8F1ykTP1Z5//BS6Ql+QqhtOihJ1DeHvpMOFfXCvo1zqT972VyRmj43qFcYDM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qFP0C-000LTo-Pp; Sat, 01 Jul 2023 03:02:16 +0200
Date: Sat, 1 Jul 2023 03:02:16 +0200
From: Andrew Lunn <andrew@lunn.ch>
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
	arnd@arndb.de, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH V5 4/9] wifi: mac80211: Add support for ACPI WBRF
Message-ID: <3868dbae-79e5-470d-a144-0884659206d9@lunn.ch>
References: <20230630103240.1557100-1-evan.quan@amd.com>
 <20230630103240.1557100-5-evan.quan@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230630103240.1557100-5-evan.quan@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> +static void get_chan_freq_boundary(u32 center_freq,
> +				   u32 bandwidth,
> +				   u64 *start,
> +				   u64 *end)
> +{
> +	bandwidth = MHZ_TO_KHZ(bandwidth);
> +	center_freq = MHZ_TO_KHZ(center_freq);
> +
> +	*start = center_freq - bandwidth / 2;
> +	*end = center_freq + bandwidth / 2;
> +
> +	/* Frequency in HZ is expected */
> +	*start = KHZ_TO_HZ(*start);
> +	*end = KHZ_TO_HZ(*end);
> +}

This seems pretty generic, so maybe it should be moved into the shared
code? It can then become a NOP when the functionality if disabled.

      Andrew


