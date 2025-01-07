Return-Path: <netdev+bounces-155685-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B6DA03573
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 03:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 001521886C8A
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 02:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878D578F59;
	Tue,  7 Jan 2025 02:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bz7KT+ek"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEF018C0C;
	Tue,  7 Jan 2025 02:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736218136; cv=none; b=WZwOiuWUaXAUO1ACaoE/ONM8C/qy6wdTASUGyDVXw5xVy2xX0HDuKaQH9rcKrhwB3fxs99aOxgztpt+pvSq5KbpZ5hyFBe3BzEQsyH2KSGQuEn+ugz5leh5bXZXmwAwTb0gahXjv4k1yKlBi5PPQvwpMEYQET4YIoumHHPGC7b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736218136; c=relaxed/simple;
	bh=Br6oU1kRRpFM+1QOHH/MTQhAn3UdicbftXFU4AaOTOo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M0ed0gcLmQbX97MHvyVRyWv6ZKMZn0p+eV9fjvMaROp5vV9mtmoJBLVlxvV/XyNdaCsEGbnNh27HPEkAiAQXsikZLSvDk48p9I2AVYDnJZb8YSETejscdRl7LdoV96AKhktUgTOHk2qfUatUEOoXa5cAqephTJqspAVCq6ynMwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bz7KT+ek; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3FEFC4CED2;
	Tue,  7 Jan 2025 02:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736218136;
	bh=Br6oU1kRRpFM+1QOHH/MTQhAn3UdicbftXFU4AaOTOo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Bz7KT+ekiCPXAK/Z+aVKQmZ38vqfehKuYkf3+HT73cUQQ2T7qujiF5CAS6gTG0fEn
	 p2wRSb/n816obJbBZzkx+XClS5oLdpQ3CAVkfonxYHweTpAYgIsqCVJquZZny1M4QT
	 Mc/Upqqd6TpbH3FnE2y0HEfArSRw/aGKCFXy463hgkyKEuL1pRZFdyIcqsZgiGdd99
	 kl7u0RZRPDbKHEv2bC7qZs8kNjOU9huU7WvgSxOaBEknCiDO+h/fo9iyOix3CKZxfs
	 wyHqmcSQCLyYjDVgJuMXhHvsb5a45TsgAmOOdXHKgyILERA7nIRN16VWPnyYzaHQvG
	 iAVZUQOfQ3pWQ==
Date: Mon, 6 Jan 2025 18:48:54 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 almasrymina@google.com, donald.hunter@gmail.com, corbet@lwn.net,
 michael.chan@broadcom.com, andrew+netdev@lunn.ch, hawk@kernel.org,
 ilias.apalodimas@linaro.org, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, dw@davidwei.uk, sdf@fomichev.me,
 asml.silence@gmail.com, brett.creeley@amd.com, linux-doc@vger.kernel.org,
 netdev@vger.kernel.org, kory.maincent@bootlin.com,
 maxime.chevallier@bootlin.com, danieller@nvidia.com,
 hengqi@linux.alibaba.com, ecree.xilinx@gmail.com,
 przemyslaw.kitszel@intel.com, hkallweit1@gmail.com, ahmed.zaki@intel.com,
 rrameshbabu@nvidia.com, idosch@nvidia.com, jiri@resnulli.us,
 bigeasy@linutronix.de, lorenzo@kernel.org, jdamato@fastly.com,
 aleksander.lobakin@intel.com, kaiyuanz@google.com, willemb@google.com,
 daniel.zahka@gmail.com
Subject: Re: [PATCH net-next v7 02/10] net: ethtool: add support for
 configuring hds-thresh
Message-ID: <20250106184854.4028c83d@kernel.org>
In-Reply-To: <20250103150325.926031-3-ap420073@gmail.com>
References: <20250103150325.926031-1-ap420073@gmail.com>
	<20250103150325.926031-3-ap420073@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  3 Jan 2025 15:03:17 +0000 Taehee Yoo wrote:
> diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
> index 4e451084d58a..8bab30e91022 100644
> --- a/include/linux/ethtool.h
> +++ b/include/linux/ethtool.h
> @@ -78,6 +78,8 @@ enum {
>   * @cqe_size: Size of TX/RX completion queue event
>   * @tx_push_buf_len: Size of TX push buffer
>   * @tx_push_buf_max_len: Maximum allowed size of TX push buffer
> + * @hds_thresh: Threshold value of header-data-split-thresh
> + * @hds_thresh_max: Maximum supprted threshold of header-data-split-thresh

supprted -> supported

Maybe let's rephrase these as:

 * @hds_thresh: Packet size threshold for header data split (HDS)
 * @hds_thresh_max: Maximum supported setting for @hds_threshold

>   */

>   * @module_fw_flash_in_progress: Module firmware flashing is in progress.
> @@ -1141,6 +1148,7 @@ int ethtool_virtdev_set_link_ksettings(struct net_device *dev,
>  struct ethtool_netdev_state {
>  	struct xarray		rss_ctx;
>  	struct mutex		rss_lock;
> +	u32			hds_thresh;

this value is checked in devmem.c but nothing ever sets it.
net/ethtool/rings.c needs to handle it like it handles
dev->ethtool->hds_config

>  	u8			hds_config;
>  	unsigned		wol_enabled:1;
>  	unsigned		module_fw_flash_in_progress:1;
-- 
pw-bot: cr

