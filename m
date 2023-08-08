Return-Path: <netdev+bounces-25269-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A037739E4
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 13:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BF3C2816FC
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 11:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE57F9D0;
	Tue,  8 Aug 2023 11:17:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665B6F4FE
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 11:17:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0351EC433C7;
	Tue,  8 Aug 2023 11:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691493427;
	bh=9be7C7VRcsXmVLtPGofQ+yEEGpTnOvkp00uKoeWeBHI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JVKTd0auOwA4PErhCSACQgxE5juOP8gGEgzvJnYd0LMA6lV4CUSX1GMSNeD/XzCXf
	 8GhMT6sq2mc7MrYHMzK7hyA6IXD7brO0N6Z1mSd2iK8H8TXPQDmd/rIs40ZXF5uDbU
	 Dr3fmZ/y3wyZ0Wv7D0Q6Wph0ryOeohL4XZFes40Hm6rE1a+D+b8bwkDMD8QCnZWj8f
	 v8X9jrdb10ecVSCYbwgp5y8ccVPLZQgzADzdzBGhcDAzSdGX0E1hogq3x/EC9Ir4MZ
	 dwbh5j9134h1jcZ2hrQ6uRHtsOQlypNkZW22DtQM9vOxxT29Fgjfccb3o4iWGiPvg7
	 QtS41OEjtnFng==
Date: Tue, 8 Aug 2023 05:18:10 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, gospo@broadcom.com,
	gustavo@embeddedor.com
Subject: Re: [PATCH net-next 2/2] bnxt_en: Fix W=stringop-overflow warning in
 bnxt_dcb.c
Message-ID: <ZNIkcmR10HlELEqp@work>
References: <20230807145720.159645-1-michael.chan@broadcom.com>
 <20230807145720.159645-3-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230807145720.159645-3-michael.chan@broadcom.com>

On Mon, Aug 07, 2023 at 07:57:20AM -0700, Michael Chan wrote:
> Fix the following warning:
> 
> drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c: In function ‘bnxt_hwrm_queue_cos2bw_cfg’:
> cc1: error: writing 12 bytes into a region of size 1 [-Werror=stringop-overflow ]
> In file included from drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c:19:
> drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h:6045:17: note: destination object ‘unused_0’ of size 1
>  6045 |         u8      unused_0;
> 
> Fix it by modifying struct hwrm_queue_cos2bw_cfg_input to use an array
> of sub struct similar to the previous patch.  This will eliminate the
> pointer arithmetc to calculate the destination pointer passed to
> memcpy().

Thanks for fixing this. :)

> 
> Link: https://lore.kernel.org/netdev/CACKFLinikvXmKcxr4kjWO9TPYxTd2cb5agT1j=w9Qyj5-24s5A@mail.gmail.com/
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

--
Gustavo

