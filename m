Return-Path: <netdev+bounces-201337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A3FAE90EF
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 00:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37F141898BF8
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 22:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11CC2F2C5A;
	Wed, 25 Jun 2025 22:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MT2kPDja"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1D035280
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 22:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750889908; cv=none; b=pGBnmj79WWG/nuVZ2HPWalmBxwEyOp3wUAVEO9qkgczwSboSFDl8fl6ni4aQk7blauZb9SjjXLDRVfIcixOHgW/POsGSrHDQ3Ai2+d1ffpEbbrEKJFdksDUS/wm8w1KNonbHdOtxdSPGgRT7DuBlTs5yN5/749FCDQpa/72hzvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750889908; c=relaxed/simple;
	bh=5vth//wMCKfJW+u426ptA7F1lfRfH32dFxUCxS3NQjM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hsCxYmXe5W1I4EEFnZ8g8sAMh4d9G0rA56z25+lOroNXVEeloPnJYZ4yKOds75fWqoY6L8isF9dPnLgZP4M0FYLBG51vsbssdgXc3VkWND3TzpzXSGlAimODfdlObJlvQ2Mir5J0ZVJNfDu12VIsJyDe9De5JK9UNDGl0NkBryM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MT2kPDja; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8728BC4CEEA;
	Wed, 25 Jun 2025 22:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750889908;
	bh=5vth//wMCKfJW+u426ptA7F1lfRfH32dFxUCxS3NQjM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MT2kPDjaBOgpSaNhq4C+2cKRj8KFlJv1N/v2jP8/8NXPWYslhK4z4b4/qWGFZT9X5
	 d/4cSALXJmt31i/tsalCqKuKOV5aLzvI9IE8VObfAbU+8JHtvqbgNeDsKdOMc00XAD
	 bQGRjpblvtZ5fD5Naxxe+m+Bfz2AG2P85P+0OyXaRRSFGv4lE3aSnL+eKpxoKyz7UM
	 jUMRN26hLLpXwOGd/gJnnydle5aOtq4AcsCu3zj1rDeQlQeiihdeOZKa0avHdqw2im
	 5xNUtUEVlom78MJ1lU6EfulSIY9M8ldh+hLLBgnAmrfpYeAb7IE5FxELWnqWjmUPK0
	 0WIj+YNquRiIQ==
Date: Wed, 25 Jun 2025 15:18:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Zahka <daniel.zahka@gmail.com>
Cc: Donald Hunter <donald.hunter@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, Saeed Mahameed
 <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq Toukan
 <tariqt@nvidia.com>, Boris Pismenny <borisp@nvidia.com>, Kuniyuki Iwashima
 <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, David Ahern
 <dsahern@kernel.org>, Neal Cardwell <ncardwell@google.com>, Patrisious
 Haddad <phaddad@nvidia.com>, Raed Salem <raeds@nvidia.com>, Jianbo Liu
 <jianbol@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, Rahul
 Rameshbabu <rrameshbabu@nvidia.com>, Stanislav Fomichev <sdf@fomichev.me>,
 Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@redhat.com>, Alexander
 Lobakin <aleksander.lobakin@intel.com>, Jacob Keller
 <jacob.e.keller@intel.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v2 08/17] net: psp: add socket security association code
Message-ID: <20250625151826.48cc600b@kernel.org>
In-Reply-To: <20250625135210.2975231-9-daniel.zahka@gmail.com>
References: <20250625135210.2975231-1-daniel.zahka@gmail.com>
	<20250625135210.2975231-9-daniel.zahka@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 25 Jun 2025 06:51:58 -0700 Daniel Zahka wrote:
> +enum skb_drop_reason
> +psp_twsk_rx_policy_check(struct inet_timewait_sock *tw, struct sk_buff *skb)
> +{
> +	return __psp_sk_rx_policy_check(skb, psp_twsk_assoc(tw));
> +}
> +EXPORT_SYMBOL_GPL(psp_twsk_rx_policy_check);

This is just for IPv6 right? Let's switch all the exports for IPv6 to

EXPORT_IPV6_MOD_GPL()

> +void psp_reply_set_decrypted(struct sock *sk, struct sk_buff *skb)

And this one needs an export, too
-- 
pw-bot: cr

