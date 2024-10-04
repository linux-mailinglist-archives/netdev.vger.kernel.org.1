Return-Path: <netdev+bounces-131920-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEEA898FF15
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 10:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 667971F21020
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 08:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EED2146A63;
	Fri,  4 Oct 2024 08:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="orT21PD+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444771411C8;
	Fri,  4 Oct 2024 08:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728031726; cv=none; b=AN9fDvJE5f6dFpMluj0JEdhPcnbQ1KbbJY6Cx6ardtF2MdNFLWgRey2vOJPw1C8ABALhFttwADPflZ3xgy27fCwenykB4akOWogdsjYzR57gzV6OwHJFfMhogY5OnXLHfUAYhZj2Rje5K+bxbefbv5zFrwr2DVT68rqyE56uI7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728031726; c=relaxed/simple;
	bh=nOrbXvBeg47q7csFbhkTkz/rpJes9E8M63SIdh7belw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kdddrk2UWBSJV5RsTo+9EQNBhJddAPBQoPCviTOusM3wfOl3P+Tf4+bEB76ESbxxab5/c6mME4gaYKcRVqQROfH1wKXLoY0Whlc0wpzu7V6yZ+LxB3+6+4YH54f3aL2mN15wJjoMQj70zAzgtH5JHK5ehApd+4F8k20d0QPe77Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=orT21PD+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEFA4C4CEC6;
	Fri,  4 Oct 2024 08:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728031726;
	bh=nOrbXvBeg47q7csFbhkTkz/rpJes9E8M63SIdh7belw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=orT21PD+TcVNXlgad0+HIF5RG7IZmee6TmyrR7qt+tf0cABCF6frkZNjLkeMPfZtp
	 +DLHulZJTg4XzfAehri0gUrweKIf01RRgbDkRkR1HpIBcWOWTyiNl0zhLsCZqqxQho
	 Fpkxr1Cdf7Xm+L5DPpyI9F3FCcIa3hASkYTRUfvEMdQBI1SNLDQKpt4ICIfUatBZk+
	 kVGAZ9ZPoe7bgc2XJ0ERwVX9zckpPMNx0FXktrKEB869Mnpcx0MjAUTuIotVlSbCx+
	 eLC+5V006kF8nJaumvIoXWt/YhtCd7HPW+f7mQcl4JcUSYL1asEqYrGy6Bfq/zQPSJ
	 cBHCmo1Uhlokg==
Message-ID: <684f3768-fddc-4fce-ad35-3326d06bd4fd@kernel.org>
Date: Fri, 4 Oct 2024 11:48:40 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 1/2] net: ethernet: ti: am65-cpsw: prevent WARN_ON
 upon module removal
To: Nicolas Pitre <nico@fluxnic.net>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Grygorii Strashko <grygorii.strashko@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: Nicolas Pitre <npitre@baylibre.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241004041218.2809774-1-nico@fluxnic.net>
 <20241004041218.2809774-2-nico@fluxnic.net>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20241004041218.2809774-2-nico@fluxnic.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 04/10/2024 07:10, Nicolas Pitre wrote:
> From: Nicolas Pitre <npitre@baylibre.com>
> 
> In am65_cpsw_nuss_remove(), move the call to am65_cpsw_unregister_devlink()
> after am65_cpsw_nuss_cleanup_ndev() to avoid triggering the
> WARN_ON(devlink_port->type != DEVLINK_PORT_TYPE_NOTSET) in
> devl_port_unregister(). Makes it coherent with usage in
> m65_cpsw_nuss_register_ndevs()'s cleanup path.
> 
> Fixes: 58356eb31d60 ("net: ti: am65-cpsw-nuss: Add devlink support")
> Signed-off-by: Nicolas Pitre <npitre@baylibre.com>

Reviewed-by: Roger Quadros <rogerq@kernel.org>

