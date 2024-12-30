Return-Path: <netdev+bounces-154555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB919FE922
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 17:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 585867A13C7
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 16:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03561AAA2C;
	Mon, 30 Dec 2024 16:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EdOtk+Xs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC4F18C31;
	Mon, 30 Dec 2024 16:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735577571; cv=none; b=qWGPDPzCjBvadOlAGG8Fbp3Owbhe+SJD/eKzqOsSHLXpGSMkjMpeB+p5j57jbJX3EB75/orS7JcSCaIZO0Lo7JAv5oBXl32VbEsRzSoSKNU9sYNAO6V6Vqp8UMkrvBUqCHs+At35BEXbf6JUTpFHwT1IRyTOJKC8/q9vy1K43Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735577571; c=relaxed/simple;
	bh=+T98hUKL0uN2wtcho15mudm4zA3YNCHO9D3dBBsnwm4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dlr0ES26iFgSjhMf5wn1RFW+crj5/1JgbePpDnf4cA3pFAmARA0i4snArP8xI4AwCgLoOq2AjdZ+HqTIHrFx5uYf1aXOEf0qcm59lqlK1vXZMGzhOfSWBF3x+WLhGrLI+HC6BjYFbAUm8DXN+GCpgKouw9gck5IkBGWreOkUajw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EdOtk+Xs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F1C5C4CED0;
	Mon, 30 Dec 2024 16:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735577570;
	bh=+T98hUKL0uN2wtcho15mudm4zA3YNCHO9D3dBBsnwm4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EdOtk+XsXBnCbq84XKtOOgdyTzbiVuQlA+llheunQyrflfp8HqZ2A9R1SapNL9s1o
	 gZfnm8PX8rm9uGRayrp41LNkBuEj6Aw4HL5b9lAW08F7Oh7ooHmR3PZp3uQRxFSEAJ
	 VorkZItSN6e805KSQfN3rnt9NbsegoAteGBr0N4EcmM0pLcvVBG665s3VlWxU586nM
	 w0OeQo3lp9j0QNTNUGdsZCbst6apTBTIjMnnTcNt/ejt7Oba0/pJ6Eh0/6OkIjIF6l
	 c/NfBU48YFC0q3sp5EQvEwOM7zcr+oy6GgfQjiV/Gh+YK557BCfJ8rGqxUz8/1aZzv
	 EKx7BoZ0XE6hw==
Date: Mon, 30 Dec 2024 08:52:49 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: Su Hui <suhui@nfschina.com>, alexanderduyck@fb.com,
 kernel-team@meta.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 mohsin.bashr@gmail.com, sanmanpradhan@meta.com,
 kalesh-anakkur.purayil@broadcom.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] eth: fbnic: Avoid garbage value in
 fbnic_mac_get_sensor_asic()
Message-ID: <20241230085249.4aa68872@kernel.org>
In-Reply-To: <Z3JTFJgbzX4XGHwG@mev-dev.igk.intel.com>
References: <20241230014242.14562-1-suhui@nfschina.com>
	<Z3JTFJgbzX4XGHwG@mev-dev.igk.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 30 Dec 2024 09:00:20 +0100 Michal Swiatkowski wrote:
> > @@ -688,23 +688,7 @@ fbnic_mac_get_eth_mac_stats(struct fbnic_dev *fbd, bool reset,
> >  
> >  static int fbnic_mac_get_sensor_asic(struct fbnic_dev *fbd, int id, long *val)
> >  {
> > -	struct fbnic_fw_completion fw_cmpl;  
> Probably it should be:
> *fw_cmpl = fbd->cmpl_data
> but it is also never initialized.

The other way around, the completion declared on the stack should be
the thing that gets assigned to the pointer in fbd :S

> > -	s32 *sensor;
> > -
> > -	switch (id) {
> > -	case FBNIC_SENSOR_TEMP:
> > -		sensor = &fw_cmpl.tsene.millidegrees;
> > -		break;
> > -	case FBNIC_SENSOR_VOLTAGE:
> > -		sensor = &fw_cmpl.tsene.millivolts;
> > -		break;
> > -	default:
> > -		return -EINVAL;
> > -	}
> > -
> > -	*val = *sensor;
> > -
> > -	return 0;
> > +	return -EOPNOTSUPP;  
> 
> It is more like removing broken functionality than fixing (maybe whole
> commit should be reverted). Anyway returning not support is also fine.

I defer to other maintainers. The gaps are trivial to fill in, we'll 
do so as soon as this patch makes it to net-next (this patch needs to
target net).

