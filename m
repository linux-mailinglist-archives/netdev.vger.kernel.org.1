Return-Path: <netdev+bounces-20281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8AAD75EF08
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 11:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AFF9281492
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 09:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26AE26FBB;
	Mon, 24 Jul 2023 09:23:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF872113
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 09:23:36 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079D8FD;
	Mon, 24 Jul 2023 02:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=nHwERRNohuUhZsb3fsbGJZNV/wqpb0sJjOXJGxj/gFU=; b=0eTCGmkFvYRanCjqIruUc+gFHD
	eb0YjlozDEULA37j7v5qY4zn7oNzSJHyKS6Mu3lubDRF2RaMczkF4f0lJh//Gw6lfNr0hipZSgCGS
	JIWlEQVkw7RyvqjD3Uxd4RuJG7sAceLde0p86r2jFr/kdLPlkftX1hnSBOxxVBlLMicc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qNrmC-0026m1-D4; Mon, 24 Jul 2023 11:22:48 +0200
Date: Mon, 24 Jul 2023 11:22:48 +0200
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
Subject: Re: [PATCH V7 4/9] wifi: mac80211: Add support for ACPI WBRF
Message-ID: <9b1f45f9-02a3-4c03-b9d5-cc3b9ab3a058@lunn.ch>
References: <20230719090020.2716892-1-evan.quan@amd.com>
 <20230719090020.2716892-5-evan.quan@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230719090020.2716892-5-evan.quan@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> @@ -1395,6 +1395,8 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
>  	debugfs_hw_add(local);
>  	rate_control_add_debugfs(local);
>  
> +	ieee80211_check_wbrf_support(local);
> +
>  	rtnl_lock();
>  	wiphy_lock(hw->wiphy);
>  

> +void ieee80211_check_wbrf_support(struct ieee80211_local *local)
> +{
> +	struct wiphy *wiphy = local->hw.wiphy;
> +	struct device *dev;
> +
> +	if (!wiphy)
> +		return;
> +
> +	dev = wiphy->dev.parent;
> +	if (!dev)
> +		return;
> +
> +	local->wbrf_supported = wbrf_supported_producer(dev);
> +	dev_dbg(dev, "WBRF is %s supported\n",
> +		local->wbrf_supported ? "" : "not");
> +}

This seems wrong. wbrf_supported_producer() is about "Should this
device report the frequencies it is using?" The answer to that depends
on a combination of: Are there consumers registered with the core, and
is the policy set so WBRF should take actions.

The problem here is, you have no idea of the probe order. It could be
this device probes before others, so wbrf_supported_producer() reports
false, but a few second later would report true, once other devices
have probed.

It should be an inexpensive call into the core, so can be made every
time the channel changes. All the core needs to do is check if the
list of consumers is empty, and if not, check a Boolean policy value.

     Andrew

