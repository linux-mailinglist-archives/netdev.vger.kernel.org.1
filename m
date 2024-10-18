Return-Path: <netdev+bounces-137111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7F29A467E
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 21:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A3381C21609
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 19:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27BCE204093;
	Fri, 18 Oct 2024 19:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vMrTvcup"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFAB17DFF2;
	Fri, 18 Oct 2024 19:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729278533; cv=none; b=uSc12KoOkS/HiuIVOHuzUqxhwhyopVlJ9uKP0GhxFXgsQGOtVCktRgTMBSDUsLPRMC4hTyUJcvkkNgXbDdPydBcsbsX9HQZjtCYNjJRTlUlwAPuuRflrP0l68jNkhB8xq2yZkrIRTafWRTirjVzGiV9Qfjhz0zVQ9Yyvy/JA8rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729278533; c=relaxed/simple;
	bh=Y4tR5vgsgDYFizqilswwrpfpQhq/06nvxX1UE0BDJwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ECNSr+uYDIpEM4au4Ms1Jp/A9NqxzXDygZwXk7Y1vvB8gkzyQHdilD2rHXoCdLjVSPj07sTMOOkyA3mMseaV6bMPM83AvfBKNVt9/Hk7RPXHzkPv8m+SXvX8uAXVR2FJ++TPiLmk0q3AU7+8obDknyXLMowmMgTaDaAMt7Er+94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vMrTvcup; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35F8FC4CEC3;
	Fri, 18 Oct 2024 19:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729278532;
	bh=Y4tR5vgsgDYFizqilswwrpfpQhq/06nvxX1UE0BDJwM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vMrTvcupWKpzuVmmJyeuMRXgQb0fXoAmk1MGKfqhh0xtod5C1loEoWU8Px7z2aqsT
	 mO/oSgu3QAxoS3AcoUyapKfqGtn6WlmA7J6xy96YoOBiN/+ZoEbSyUr9PbmF4y5qRM
	 Ks3HNsqQU1TaLzh2a2TFYEp58z05pyDsC4vYOvh56ZWxzLfMCnDu2mP9JaOt47Gdm6
	 Ou431ohaRUTppTUN8qW9MfGHAflqnbs1wgJ8evw3gqX7KDMRHoKM+ja0DRaARkul2R
	 fQWRom5UTEZ2M+LFlBnumH/4RvK/IjklToLxQdrV+4ssx117qP0qsYNzwLjVxj+aBc
	 pN7cP+mxsQfGg==
Date: Fri, 18 Oct 2024 20:08:47 +0100
From: Simon Horman <horms@kernel.org>
To: Dipendra Khadka <kdipendra88@gmail.com>
Cc: Sunil Goutham <sgoutham@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	hariprasad <hkelam@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.cocdm>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/6] octeontx2-pf: handle otx2_mbox_get_rsp errors in
 otx2_common.c
Message-ID: <20241018190847.GS1697@kernel.org>
References: <20241017185116.32491-1-kdipendra88@gmail.com>
 <20241017185636.32583-1-kdipendra88@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017185636.32583-1-kdipendra88@gmail.com>

On Thu, Oct 17, 2024 at 06:56:33PM +0000, Dipendra Khadka wrote:
> Add error pointer check after calling otx2_mbox_get_rsp().
> 
> Fixes: ab58a416c93f ("octeontx2-pf: cn10k: Get max mtu supported from admin function")
> Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


