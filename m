Return-Path: <netdev+bounces-119354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 673239554CE
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 04:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BBF31C215DE
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 02:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED258821;
	Sat, 17 Aug 2024 02:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HAZh5Iqz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D425E7E1;
	Sat, 17 Aug 2024 02:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723861366; cv=none; b=Z8g+ICRja2AsQY3ab590EI0wLDVmJW2BYMSKqgZLyPhG1tkXxnDRNaWFWGOIpMlai9TnWH7YVsIKahEf7nc9u3H7o+PH78rMgyjEDKLL12fJarogByrZgJBIC8v4Y7+1+UcwUESPRATxuDetWXClGiZSkArUx7zJcANFLfLJ1Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723861366; c=relaxed/simple;
	bh=sKxWUnMC0lEetpGQNig71MDmcLcpqNWsx1xra2R9njY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GiYzvR6MWDkr2eRk0j0XHzbNWzHfED7Cz2CHboAFoC/p0Bl9sVmJOSqCTq8++cZQns9leg64zbqMuS4VnI69kwTxc/mXvrL7qOL2cUqR20UmHYR/thrviKtI4jJ0PATPyAX5EXf+NrWEXRSMn+Zve5eTC3l6et7UF1uMp4njfvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HAZh5Iqz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FBACC32782;
	Sat, 17 Aug 2024 02:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723861365;
	bh=sKxWUnMC0lEetpGQNig71MDmcLcpqNWsx1xra2R9njY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HAZh5IqzhBk962YFXFxF0PLKAOJfcvlWxtEnTTWHo5J5Ta5Lcj6LSlincXibOtMdF
	 AM9rkTZoGiiXiVUMVwgzxXdra+R8VQEQ+KrvXTo+N8eftj5oEr577HOKM3fMxuMxu1
	 lNMe9fKQePoKa4KjdNswM8dkgZgM1CJnW+00WTaHwHfn7DxuGInOrnU/xQIUtuIiu1
	 iSgdwGMkFb+SQ8SWQQ/WGlkOc4Z3ZEfyPcmddkvRFCeeJBk+NdxbNTM/yD0HeR1YUQ
	 E36G2y8Kdd3EHeWxoo0m1o5p4YeZitHPPu//86RGjyrW/W1Thm/5YbENSG1U3w2R5r
	 XDmGk3kEKqdRA==
Date: Fri, 16 Aug 2024 19:22:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 dsahern@kernel.org, dongml2@chinatelecom.cn, idosch@nvidia.com,
 amcohen@nvidia.com, gnault@redhat.com, bpoirier@nvidia.com,
 b.galvani@gmail.com, razor@blackwall.org, petrm@nvidia.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 06/10] net: vxlan: add skb drop reasons to
 vxlan_rcv()
Message-ID: <20240816192243.050d0b1f@kernel.org>
In-Reply-To: <20240815124302.982711-7-dongml2@chinatelecom.cn>
References: <20240815124302.982711-1-dongml2@chinatelecom.cn>
	<20240815124302.982711-7-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Aug 2024 20:42:58 +0800 Menglong Dong wrote:
>  #define VXLAN_DROP_REASONS(R)			\
> +	R(VXLAN_DROP_FLAGS)			\
> +	R(VXLAN_DROP_VNI)			\
> +	R(VXLAN_DROP_MAC)			\

Drop reasons should be documented.
I don't think name of a header field is a great fit for a reason.

>  	/* deliberate comment for trailing \ */
>  
>  enum vxlan_drop_reason {
> diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
> index e971c4785962..9a61f04bb95d 100644
> --- a/drivers/net/vxlan/vxlan_core.c
> +++ b/drivers/net/vxlan/vxlan_core.c
> @@ -1668,6 +1668,7 @@ static bool vxlan_ecn_decapsulate(struct vxlan_sock *vs, void *oiph,
>  /* Callback from net/ipv4/udp.c to receive packets */
>  static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
>  {
> +	enum skb_drop_reason reason = pskb_may_pull_reason(skb, VXLAN_HLEN);

Do not call complex functions inline as variable init..

>  	struct vxlan_vni_node *vninode = NULL;
>  	struct vxlan_dev *vxlan;
>  	struct vxlan_sock *vs;
> @@ -1681,7 +1682,7 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
>  	int nh;
>  
>  	/* Need UDP and VXLAN header to be present */
> -	if (!pskb_may_pull(skb, VXLAN_HLEN))
> +	if (reason != SKB_NOT_DROPPED_YET)

please don't compare against "not dropped yet", just:

	if (reason)

> @@ -1815,8 +1831,9 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
>  	return 0;
>  
>  drop:
> +	SKB_DR_RESET(reason);

the name of this macro is very confusing, I don't think it should exist
in the first place. nothing should goto drop without initialing reason

>  	/* Consume bad packet */
> -	kfree_skb(skb);
> +	kfree_skb_reason(skb, reason);
>  	return 0;
>  }

