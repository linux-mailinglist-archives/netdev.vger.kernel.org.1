Return-Path: <netdev+bounces-198132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D18ADB591
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 17:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 042513AB4DC
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 15:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 168E0238C25;
	Mon, 16 Jun 2025 15:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GqI3TPa7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E455221B9FC
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 15:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750088083; cv=none; b=sbni61RTiknGMAvQ4p0ejDVe9gecEQVSvnwUChgwKn220Rp3R4yYyuuywwlJz5oLO29z2QdvtGQfm91Dw1tjoiEiN+CJX3vv5sP5S31attHurtSE2fIYtpVJuFJ47xKM1yO8ELhLuUrXs4tzeyvHPygjXyuj6zVtq+4g77kci+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750088083; c=relaxed/simple;
	bh=pBPC5AeMxJGt+qCESw9r/rTxC1MhGK+GI5i5cMTUies=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PJtEkWz1iCJIhb1xEfzTnN2RsKoAiZsXmdHLFWJyCu3BVNYuMMTISs9otfMBpCByOOLxcxzwTkZEf5lUcaRRjPAh1v/zQxxVXNUazx+vl98h16gcN5nAkGa4AQHERRn0ZbvgKQCOpeAL82yF6j+Quz6P6oa+/UbO6S6ccItdEos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GqI3TPa7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82F3EC4CEEA;
	Mon, 16 Jun 2025 15:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750088082;
	bh=pBPC5AeMxJGt+qCESw9r/rTxC1MhGK+GI5i5cMTUies=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GqI3TPa77kSLmzGTkyyMvc7R3kU9n2JRYL77BaQn63tkNt9dKpvRCRut+K6+WrMTS
	 ejxRDIdqka27EW4N7tpVkycv8nVkdTDkJqXYlIaJ843Pe1xyyq7iCGzTYNmQNWMjEw
	 CxvuhZLMPxrgZwmdkPDkAqptA22efI9CB6XPlbKiFMQlTh6mQUDslL5mD5LYlPs1pB
	 gMhpr9uRwQMFwNHE7MYAAI1nYFfL0wvlWNdQO257MvYCNkSLw1GjEqwuTXKvlWWwi6
	 IOPG8/ix9e/VJQZYlrALQk2rA0g1U4k91B5LVwaXmczAkqCNCFCPb4OPYrallfO/wx
	 Ds0MNWUaZ4I6w==
Date: Mon, 16 Jun 2025 16:34:38 +0100
From: Simon Horman <horms@kernel.org>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: netdev@vger.kernel.org, linux@armlinux.org.uk, hkallweit1@gmail.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, pabeni@redhat.com,
	kuba@kernel.org, kernel-team@meta.com, edumazet@google.com
Subject: Re: [net-next PATCH v2 3/6] fbnic: Replace 'link_mode' with 'aui'
Message-ID: <20250616153438.GE6918@horms.kernel.org>
References: <174974059576.3327565.11541374883434516600.stgit@ahduyck-xeon-server.home.arpa>
 <174974092054.3327565.9587401305919779622.stgit@ahduyck-xeon-server.home.arpa>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174974092054.3327565.9587401305919779622.stgit@ahduyck-xeon-server.home.arpa>

On Thu, Jun 12, 2025 at 08:08:40AM -0700, Alexander Duyck wrote:
> From: Alexander Duyck <alexanderduyck@fb.com>
> 
> The way we were using "link_mode" really was more to describe the
> interface between the attachment unit interface(s) we were using on the
> device. Specifically the AUI is describing the modulation and the number of
> lanes we are using. So we can simplify this by replacing link_mode with
> aui.
> 
> In addition this change makes it so that the enum we use for the FW values
> represents actual link modes that will be normally advertised by a link
> partner. The general idea is to look at using this to populate
> lp_advertising in the future so that we don't have to force the value and
> can instead default to autoneg allowing the user to change it should they
> want to force the link down or are doing some sort of manufacturing test
> with a loopback plug.
> 
> Lastly we make the transition from fw_settings to aui/fec a one time thing
> during phylink_init. The general idea is when we start phylink we should no
> longer update the setting based on the FW and instead only allow the user
> to provide the settings.
> 
> Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>

Hi Alexander,

This patch is doing a lot - I count 3 things.
Could you try and break it up a bit in v3?

