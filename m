Return-Path: <netdev+bounces-51475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF0F7FAC6F
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 22:16:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50F55B20E7A
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 21:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D2D45C0B;
	Mon, 27 Nov 2023 21:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c3aG6dWL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137B845BEA
	for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 21:16:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51051C433C7;
	Mon, 27 Nov 2023 21:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701119802;
	bh=c6Z70IQzlAjwbN76roiqBRgjUGnHmvbpyHemDhpH6Ow=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=c3aG6dWLlm22sHtC7ql6y2DgXqfJ4ZzFdu0wVKjdpd0QSMpFS7KvDQfrMWEfk0gJK
	 iykKuI07pjJbd3w6DvOljKw1fiB/1PzbGmtEUXUy16nhltgmbMv2ascycBMDXX1hcp
	 cCmO4r3s1elNyC8SBf7gzqKNfVZqf8R+A9REtIEp5JsDfPhMe5qHRnqgXN0ruZgDjk
	 n10hpocdc6VnvMqXq5vU719WFEfH6JTTjWwMVN4WG4zEexlp+ZRnT9xB/82sqyw7rG
	 XK4oycPkYnxhIjeTjhjK++xaIALrKkRYHIln6U3eBJC1fibFP+vS/kEwdZKyNSimeQ
	 4TCQCHbscKbug==
Date: Mon, 27 Nov 2023 13:16:41 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Swarup Laxman Kotiaklapudi <swarupkotikalapudi@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 jiri@resnulli.us, netdev@vger.kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH net-next v4] netlink: specs: devlink: add some(not all)
 missing attributes in devlink.yaml
Message-ID: <20231127131641.320e2a27@kernel.org>
In-Reply-To: <20231126105246.195288-1-swarupkotikalapudi@gmail.com>
References: <20231126105246.195288-1-swarupkotikalapudi@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 26 Nov 2023 16:22:46 +0530 Swarup Laxman Kotiaklapudi wrote:
> diff --git a/include/uapi/linux/devlink.h b/include/uapi/linux/devlink.h
> index b3c8383d342d..ddb689dd3d7e 100644
> --- a/include/uapi/linux/devlink.h
> +++ b/include/uapi/linux/devlink.h
> @@ -248,7 +248,7 @@ enum devlink_param_reset_dev_on_drv_probe_value {
>  	DEVLINK_PARAM_RESET_DEV_ON_DRV_PROBE_VALUE_DISK,
>  };
>  
> -enum {
> +enum devlink_stats {
>  	DEVLINK_ATTR_STATS_RX_PACKETS,		/* u64 */
>  	DEVLINK_ATTR_STATS_RX_BYTES,		/* u64 */
>  	DEVLINK_ATTR_STATS_RX_DROPPED,		/* u64 */

This change unfortunately breaks the kernel build. There's already
a struct called devlink_stats. You can change that later but that'd 
be a separate patch, after the spec changes are accepted.

For now just keep these enums unnamed.

If the C codegen tries to use them as named (which I don't see it doing
now, FWIW) you can add an empty enum-name: attribute to the appropriate
enum definition in the spec, this will make the C code generator use a
bare "int" to store the values.
-- 
pw-bot: cr

