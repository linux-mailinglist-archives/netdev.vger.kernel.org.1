Return-Path: <netdev+bounces-77732-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4638D872CCF
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 03:38:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25D961C257E1
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 02:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0989279DE;
	Wed,  6 Mar 2024 02:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q82RwLIM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A9817F5
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 02:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709692697; cv=none; b=qrrYImNvwo0RdRyCxGTu9aiB3ouQnB7GmvUDn2ZSgWbzdl8lTKE/ii6aiJn/S1/odqeNXm61DSYCXOA/JoU/pKCiS+1lcoBnmQzFEipBLZvOX/ck3u1JHOf50/dr9r/PhCEpelLaw+q9O+m1PjV7kVdZ3eFMX7B35R87h8bhgz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709692697; c=relaxed/simple;
	bh=c/FhbTDPzaGUQRCYEfZTVqw8VSTOgPDsmPfO3HRKMXk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VmcOZZNEOln1IlQyCyC54kQokeGeUFXytKuecPXR7ppF1chwTk30bxCie80n9bqmvVRbKC9vt+MS4yYL5421xjhP20CM5o/x/f6ZRI5SK0sMDIqt9EFB6/GTECqKeUKcvjBnoIkwxuLzPeJ99KhDoJjKLiyH4KCRE9B29FUt7EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q82RwLIM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00252C433C7;
	Wed,  6 Mar 2024 02:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709692697;
	bh=c/FhbTDPzaGUQRCYEfZTVqw8VSTOgPDsmPfO3HRKMXk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=q82RwLIMBbKtx6MAPerhkGx+bnpwcooCDwcUeWLtCfDZE1KJ+jDvOqwUjA8zHO+wQ
	 DiOJ4t4azFx3UrL9CFm8PrbEFqY3VfKLSriVkaRo8wqCfSwzBE3HhEb4Kmm2EbirzF
	 xDoti3Rw+RV76XleWIjquL0zoTPGs0gipRuG0/CWFd+mtFUM2QdDl9Y/1G0G7ZXgNn
	 GdfkJBU8xDTqq/DAxVbDTLlZWqKHHilS266pS2QIVB01cJJvxgE367OFBMm2OZGzwm
	 pCpLqsXDp5JGfFg1ceHuewQuQdXUt2NFSSCaklg9k2uh5/BXLIwgh20EoJTXSbzgaZ
	 eg7Q2Yh+BO1zw==
Date: Tue, 5 Mar 2024 18:38:15 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, Geert Uytterhoeven <geert@linux-m68k.org>,
 vadim.fedorenko@linux.dev, arkadiusz.kubalewski@intel.com
Subject: Re: [PATCH net v2] dpll: move all dpll<>netdev helpers to dpll code
Message-ID: <20240305183815.1b23ab51@kernel.org>
In-Reply-To: <ZebMG4gDnX4Wuh-B@nanopsycho>
References: <20240305013532.694866-1-kuba@kernel.org>
	<ZebMG4gDnX4Wuh-B@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 5 Mar 2024 08:39:07 +0100 Jiri Pirko wrote:
> >-EXPORT_SYMBOL_GPL(dpll_msg_add_pin_handle);
> >+
> >+static struct dpll_pin *netdev_dpll_pin(const struct net_device *dev)  
> 
> You may add "dpll_" prefix to this helper as well to be aligned with the
> rest while you are at it. Take it or leave it.
> Patch looks fine.

Fixed when applying, hope that's okay. I want to make sure it sits
in net for a few days before we submit it to Linus.

