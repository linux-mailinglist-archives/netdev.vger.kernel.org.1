Return-Path: <netdev+bounces-134424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 146F9999501
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 00:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A6081C22C9F
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 22:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BB419F430;
	Thu, 10 Oct 2024 22:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i2/On2LH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5269F148301
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 22:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728598577; cv=none; b=S4COfkfHpzb5IalViyRUTeWO0wDRNArFIbQXJR8yTqDn7o5tVt6Wktj/u20Jo9ulOehtTIf9yZ8WQwSHPnOFjNIdVjHsWC7eRaChLETW9rWVsBihJaU3AWEeXVKgs5XqlAqrg3d/Kb57p31HHKeshOCHLsPBBGSSXtcfgYxrU/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728598577; c=relaxed/simple;
	bh=bUz6GE7OEfWIPzhqttFgJFLeajgD2f7cjFXMkC7xGmM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YueKjRd7qB/iR/S4dqLCFz/ErK2PYQueBYdcMvbJWF53xQnxOP/0xRUlJ0GCD27BgHkpLGRiEEW17IdYANow7GQlguNKowZ0r0WYbOijw0T47fL3ddwoR77EKvuEJTmwp6NZlGcB4U8tLnVu/ySRlFmdfWC8s71ltoLxEVmHbpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i2/On2LH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73340C4CEC5;
	Thu, 10 Oct 2024 22:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728598576;
	bh=bUz6GE7OEfWIPzhqttFgJFLeajgD2f7cjFXMkC7xGmM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=i2/On2LHP/etBIZagNTInNXxVrSGhENgPEcZH2ySiUiKSaO2GBV3RAPI3wHIIqJ3r
	 +LknF1cjSSJwL3dZ/kB1xEXupzfLwLvVKHnqIS9TGNGSG0u13u2fnIaX3wuObMEDad
	 yUle8NpAS8ruy+lYx0mYthqJ3Isy5MFJyzG4FZnq7VMV754gh9XOWrKXpnLlfmnxV0
	 IaW+/AUDMLjkxToGnBPOWCKdKz0ncx4Smd6EwB5iNrVvG2ItJEufQoXGQmVy/qiFkq
	 0+SujDbzD5ALec7iWbVCnMbeBZoqwIBy9OGcGtvubvxHDYMJ0NygWamzC40Vt1vsyV
	 H9L9ZNDX8CaWA==
Date: Thu, 10 Oct 2024 15:16:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 sdf@fomichev.me
Subject: Re: [PATCH net-next] selftests: net: rebuild YNL if dependencies
 changed
Message-ID: <20241010151615.2b11f579@kernel.org>
In-Reply-To: <20241010220826.2215358-1-kuba@kernel.org>
References: <20241010220826.2215358-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Oct 2024 15:08:26 -0700 Jakub Kicinski wrote:
> +	$(Q)rm -f $(OUTPUT)/libynl-*.sig
> +	$(Q)touch $(OUTPUT)/libynl-$(YNL_GENS_HASH).sig

I forgot about .gitignore :(
-- 
pw-bot: cr

