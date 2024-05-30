Return-Path: <netdev+bounces-99244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C82D18D4333
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 03:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57C4CB234F5
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 01:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62FDD179BD;
	Thu, 30 May 2024 01:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KENeJB5N"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0851798F
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 01:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717034070; cv=none; b=cjHpc78AMHxK71NfVrpRn1Y40KUb4b0H8GIJC0vShzqc3WgDWdLWVPqofuYIIvU/zWSURWpi8gNva/zqEARq3sY39jgFfSTuWDOmUuftuwQK3QeaPueUNvZp80L/m+i+0JKMeiDMmrqaVA2e1HVCiGs9e3+mnMNSfyP9gtbhfAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717034070; c=relaxed/simple;
	bh=M9uNaEDqnMWKqfCMo6I4jINTz3a6Q9fohdYDhxdzFzE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T8txM+hIavEybrGGIH//0VV9Zw4X1aqG5v3ppJ+o6wMdM1JHf2vVE/PIBEzSamHddU8AAjIoijvU5X/BjfioSNTZ+scLoh2adVTp4WXhr+SfU13yJlUz6BfgnIhhtQUNN/W4EqUGobypc0L/mVwI+xB6nqInj9F8ROYyq2JXL8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KENeJB5N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87060C116B1;
	Thu, 30 May 2024 01:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717034069;
	bh=M9uNaEDqnMWKqfCMo6I4jINTz3a6Q9fohdYDhxdzFzE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KENeJB5NBZSP7sp8mYlRwD2dAV/wBtgbMH8o9idtRzns3jBhZsPzUZUPXtpooDNYI
	 CQoMZ/SjaV3Ma/yNn6Ylf8JRlCRwx1pZmyD/x06zaWAuqx5eOdlO6BGkDNn4wrF7Et
	 snH8gDx6lrhLSGRNCB6VPPeyxLZPxWrHBmvYSgxZNfFAUMmjmnHWy34giYapvz4I25
	 NDgBJDn3ItbaqYnfreT5JWkV3zGzM1QDoTFi3Aip5S0w0InyjySFUDQWW0tU+Q0gg7
	 wQQr+Tnyw/aHhQqV4HwjAsxKzydlMBTHej6YPcxhdMykKveZzuJBrTbh68G3ddV2mL
	 8bbTdKqXgil9Q==
Date: Wed, 29 May 2024 18:54:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: David Miller <davem@davemloft.net>, netdev <netdev@vger.kernel.org>,
 Michal Kubiak <michal.kubiak@intel.com>, Wojciech Drewek
 <wojciech.drewek@intel.com>, George Kuruvinakunnel
 <george.kuruvinakunnel@intel.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>
Subject: Re: [PATCH net 4/8] i40e: Fix XDP program unloading while removing
 the driver
Message-ID: <20240529185428.2fd13cd7@kernel.org>
In-Reply-To: <20240528-net-2024-05-28-intel-net-fixes-v1-4-dc8593d2bbc6@intel.com>
References: <20240528-net-2024-05-28-intel-net-fixes-v1-0-dc8593d2bbc6@intel.com>
	<20240528-net-2024-05-28-intel-net-fixes-v1-4-dc8593d2bbc6@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 May 2024 15:06:07 -0700 Jacob Keller wrote:
> +	/* Called from netdev unregister context. Unload the XDP program. */
> +	if (vsi->netdev->reg_state == NETREG_UNREGISTERING) {
> +		xdp_features_clear_redirect_target(vsi->netdev);
> +		old_prog = xchg(&vsi->xdp_prog, NULL);
> +		if (old_prog)
> +			bpf_prog_put(old_prog);
> +
> +		return 0;
> +	}

This is not great. The netdevice is closed at this stage, why is the xdp
setup try to do work if the device is closed even when not
unregistering?

