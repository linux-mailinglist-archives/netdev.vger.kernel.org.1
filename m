Return-Path: <netdev+bounces-158278-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C80A114EC
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 00:06:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D06561695EE
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 23:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF4B22489E;
	Tue, 14 Jan 2025 23:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fr.zoreil.com header.i=@fr.zoreil.com header.b="eV411Wd8"
X-Original-To: netdev@vger.kernel.org
Received: from violet.fr.zoreil.com (violet.fr.zoreil.com [92.243.8.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFB7215798
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 23:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.243.8.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736895690; cv=none; b=KrcQWWvISnXELvwXW9tH3bqNykq6B9UywYOHJ2ld7AMdXBvxvuoJDDpxPgqhHQt1DrK8CriReOS2Lxvl6qxVz9hFr7UIGADF1W+RnlKnpqhL8uRHUN1BXAa9oaFavCsf0vQOz5SkqQPfvjTKGJ51lOzSzZSUoEqVK0fCzC7zLwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736895690; c=relaxed/simple;
	bh=rd4Tnyfz8LSnzRSPds0qO7hOsBpNdqkYaYIFHlZ1jgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T991Cnq0oEGJqh99M3HoK7qCRWZommmjDAemd0o6WjmZ/sDCkZ6dla6kHsq63gzN54/cULsRPyiEs0zez+wBSh3jqQZXBunpFb0HnWDDckCtxWeK4PKefk6sfujGmhssKufE2xR3SMfnYlydcGwONiGnjbnsgto2zeQoceg8NGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fr.zoreil.com; spf=pass smtp.mailfrom=fr.zoreil.com; dkim=pass (1024-bit key) header.d=fr.zoreil.com header.i=@fr.zoreil.com header.b=eV411Wd8; arc=none smtp.client-ip=92.243.8.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fr.zoreil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fr.zoreil.com
Received: from violet.fr.zoreil.com ([127.0.0.1])
	by violet.fr.zoreil.com (8.17.1/8.17.1) with ESMTP id 50EN0bpP1770579;
	Wed, 15 Jan 2025 00:00:37 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 violet.fr.zoreil.com 50EN0bpP1770579
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fr.zoreil.com;
	s=v20220413; t=1736895637;
	bh=XWZTbSUiGbCiLrlI7Wy4sn1odnJ9biGAm2xia2tf8C0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eV411Wd8lWchAqMOc7hYPN/E2aHrAb8bSQa9V6admogCB2grWICvNhC7cmgkzwSO4
	 Ukcd6uryds/wf+ugc+ZOTNhgu7zFSImP1ITxpvj2Gpwwmo/Vq0PZZBrz7p3Uz3PZ8x
	 2AzWwNgGEVa2Ca1OhY1l9quQmSyni8jbJXT/yjyQ=
Received: (from romieu@localhost)
	by violet.fr.zoreil.com (8.17.1/8.17.1/Submit) id 50EN0aTa1770578;
	Wed, 15 Jan 2025 00:00:36 +0100
Date: Wed, 15 Jan 2025 00:00:36 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
        pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
        jdamato@fastly.com, pcnet32@frontier.com, anthony.l.nguyen@intel.com,
        przemyslaw.kitszel@intel.com, marcin.s.wojtas@gmail.com
Subject: Re: [PATCH net-next 06/11] net: protect NAPI enablement with
 netdev_lock()
Message-ID: <20250114230036.GA1769770@electric-eye.fr.zoreil.com>
References: <20250114035118.110297-1-kuba@kernel.org>
 <20250114035118.110297-7-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250114035118.110297-7-kuba@kernel.org>
X-Organisation: Land of Sunshine Inc.

Jakub Kicinski <kuba@kernel.org> :
> Wrap napi_enable() / napi_disable() with netdev_lock().
> Provide the "already locked" flavor of the API"
> 
> iavf needs the usual adjustment. A number of drivers call
> napi_enable() under a spin lock, so they have to be modified
> to take netdev_lock() first, then spin lock then call
> napi_enable_locked().
> 
> Protecting napi_enable() implies that napi->napi_id is protected
> by netdev_lock().
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
[...]
> ---
>  include/linux/netdevice.h                   | 11 ++----
>  drivers/net/ethernet/amd/pcnet32.c          | 11 +++++-
>  drivers/net/ethernet/intel/iavf/iavf_main.c |  4 +-
>  drivers/net/ethernet/marvell/mvneta.c       |  5 ++-
>  drivers/net/ethernet/via/via-velocity.c     |  4 +-

For the via-velocity part:

Acked-by: Francois Romieu <romieu@fr.zoreil.com>

-- 
Ueimor

