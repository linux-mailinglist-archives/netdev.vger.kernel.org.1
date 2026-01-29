Return-Path: <netdev+bounces-254670-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iPCaN/Ije2nXBgIAu9opvQ
	(envelope-from <netdev+bounces-254670-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 10:10:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F0BADF25
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 10:10:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6FACA300879B
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 09:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA79B2DB79A;
	Thu, 29 Jan 2026 09:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S523vRyn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84CF23E356
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 09:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769677804; cv=none; b=IRphlOKszEQ9hoYnrIfneZOkfpCUklmk3kwHFq9jawS4m7Pxxlvn+0F9JJLI7wn0NQIDXrBntwep2u55fwVAaiyqFmEJHi7RNUQnu5MJWLEAjRIMuso4xBWukFAIVjbz9U+RLwsdRdZkwxQM9ZEm0i3CA3T6Gw3t9hRGNaQsc9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769677804; c=relaxed/simple;
	bh=76zIBPU9JUdTpnHC/NoQParoOAOGM2ybYTXpnD4JwwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GOORCOgf3KiYPx2M+eDDXH0qKqmM9moJjzE4bcrUbZZdX1Aa+ArglDTYa2csUo1ncC+bXDKE72EibMuNq1WZcX7h2qj35Z+K/28S94LSZBwYk0erdyEYrw5PFH5etazPwlm64K9Nx43JZl6Os5tbAsJGQQqZcwauX0U0RqjQ9L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S523vRyn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6C37C4CEF7;
	Thu, 29 Jan 2026 09:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769677804;
	bh=76zIBPU9JUdTpnHC/NoQParoOAOGM2ybYTXpnD4JwwA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S523vRyneLWWGOmArkjf+WmU889uJURI1qn208B4p7xI99/ZTXxt0b+ffr72x/dFC
	 gk5UlOgRQswEqh+Auu0cZXlDMOShmcIMuL+XEIsdcB6n0VLY0NNGQx9XBy00J9FTqH
	 b+uepOT+o5jq1kBu6cu9H0ECMS/yWbcGa8+xnGDKOycnmCSYPfYUZWIz1qs4WwV/t1
	 OBPHQPdg/OtaA11pWa+G5saghPgTQAxiuSw9nhjL/xxhrUnL/ql5M0PzqG4dP3GJXU
	 4I0JfZ6nARgdkEaiKfSNKSsgyqgec9VrewaVnByRwf9vToLb8lJF1q10QNlqw+Qfan
	 /pSkOaJxcF50w==
Date: Thu, 29 Jan 2026 11:09:59 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Ilan Tayari <ilant@mellanox.com>,
	Guy Shapiro <guysh@mellanox.com>,
	Yossi Kuperman <yossiku@mellanox.com>,
	Network Development <netdev@vger.kernel.org>
Subject: Re: [PATCH net] xfrm: always flush state and policy upon
 NETDEV_DOWN/NETDEV_UNREGISTER events
Message-ID: <20260129090959.GD10992@unreal>
References: <1de734e2-1da6-4b5c-8e03-66af7f88d074@I-love.SAKURA.ne.jp>
 <20260128102404.GC12149@unreal>
 <83d06aca-4437-4d61-9c99-ac19b797a243@I-love.SAKURA.ne.jp>
 <20260128123546.GC40916@unreal>
 <b91432c3-5ed4-4669-8d7c-02cf7ea6f8fa@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b91432c3-5ed4-4669-8d7c-02cf7ea6f8fa@I-love.SAKURA.ne.jp>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254670-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B4F0BADF25
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 05:06:08PM +0900, Tetsuo Handa wrote:
> On 2026/01/28 21:35, Leon Romanovsky wrote:
> > On Wed, Jan 28, 2026 at 07:44:02PM +0900, Tetsuo Handa wrote:
> >> On 2026/01/28 19:24, Leon Romanovsky wrote:
> >>> I think this can work, but IMHO the more robust approach is to ensure that all
> >>> states and policies are removed when the NETIF_F_HW_ESP feature bit is cleared.
> >>
> >> The transaction will become complicated, for dev->features manipulation
> >> function can fail.
> > 
> > Line above returning NOTIFY_OK, check that NETIF_F_HW_ESP is cleared,
> > and remove everything.
> 
> That answer needs more clarification. I came to get confused about what we should do.
> 
> Question 1:
> 
>   Since NETIF_F_HW_ESP is a hardware dependent flag, not all "struct net_device"
>   support NETIF_F_HW_ESP flag. Is this interpretation correct?

Yes, however any device (SW or HW) should set this flag if they want to
provide IPsec offload.

> 
> Question 2:
> 
>   Sabrina Dubroca commented
> 
>     But the current behavior ("ignore NETIF_F_HW_ESP and call
>     xdo_dev_state_add for new states anyway") has been established for
>     multiple years. Changing that now seems a bit risky.
> 
>   at https://lkml.kernel.org/r/aXd3QjzwOVm0Q9LF@krikkit .
> 
>   Is that comment saying that we have been permitting a "struct net_device"
>   to be selected by xfrm_dev_state_add() even if that "struct net_device"
>   does not support NETIF_F_HW_ESP flag. Is this interpretation correct?

I don't understand what does it mean "device doesn't support offload but
state was offloaded anyway".

> 
> Question 3:
> 
>   Leon Romanovsky suggested that, as a more robust approach, remove all states
>   and policies when the NETIF_F_HW_ESP feature bit is cleared.
> 
>   But I consider that such approach will not work, for (according to Q2 above)
>   xfrm_dev_state_add() can be called even if the NETIF_F_HW_ESP feature bit is not
>   set. Also, I think that there is no guarantee that dev->features manipulation
>   function is called after xfrm_dev_state_add() was called.
> 
>   Therefore, we need an event that are guaranteed to be called.
>   The NETDEV_UNREGISTER event is guaranteed to be called when unregistring
>   a "struct net_device", and therefore a good place to remove all states and
>   policies.
> 
>   Is this interpretation correct?
> 
> Question 4:
> 
>   If Q1 is correct, Sabrina's comment
> 
>     Changing that now seems a bit risky.
> 
>   in Q2 might be applicable to xfrm_dev_down().
> 
>   That is, someone who is using xfrm with a !NETIF_F_HW_ESP hardware might be
>   expecting that state and policy are not flushed upon NETDEV_DOWN event.

Do we have such in-tree devices? If the answer is no, you shouldn't be
worried about that case.

> 
>   If there is such possibility, I think we should avoid changing xfrm_dev_down()
>   and instead re-introduce xfrm_dev_unregister(). What do you think?
> 
>  net/xfrm/xfrm_device.c |   12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
> index 52ae0e034d29..550457e4c4f0 100644
> --- a/net/xfrm/xfrm_device.c
> +++ b/net/xfrm/xfrm_device.c
> @@ -544,6 +544,14 @@ static int xfrm_dev_down(struct net_device *dev)
>  	return NOTIFY_DONE;
>  }
>  
> +static int xfrm_dev_unregister(struct net_device *dev)
> +{
> +	xfrm_dev_state_flush(dev_net(dev), dev, true);
> +	xfrm_dev_policy_flush(dev_net(dev), dev, true);
> +
> +	return NOTIFY_DONE;
> +}
> +
>  static int xfrm_dev_event(struct notifier_block *this, unsigned long event, void *ptr)
>  {
>  	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
> @@ -556,8 +564,10 @@ static int xfrm_dev_event(struct notifier_block *this, unsigned long event, void
>  		return xfrm_api_check(dev);
>  
>  	case NETDEV_DOWN:
> -	case NETDEV_UNREGISTER:
>  		return xfrm_dev_down(dev);
> +
> +	case NETDEV_UNREGISTER:
> +		return xfrm_dev_unregister(dev);
>  	}
>  	return NOTIFY_DONE;
>  }
> 
> 

