Return-Path: <netdev+bounces-149953-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B019E831F
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 03:24:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ED192812D3
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 02:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73DC1BA4B;
	Sun,  8 Dec 2024 02:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r3O/vGUy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E04522C6E8
	for <netdev@vger.kernel.org>; Sun,  8 Dec 2024 02:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733624655; cv=none; b=MXOrDbw+dUO2b9+u7Lsk/q1snIMULQHicNq0UhL0FcUlLQhcujhyEyqauirCclDT5GkkWuIwhsg8/U2CiQH2N5g6LQisq5vVdy51fWHWTQpdXhIYHyk9rkayEhnW9/wpjL54mAssrNB+e1/kxZjtqg4NbUOfrm5L6v53Vj5HPS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733624655; c=relaxed/simple;
	bh=AP9IbIDHT7HAYOGY3SZ9b0nWQ5jRlK8jajBDP/U5cEk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lbhrijSrn6fssu9DlBr6JsKtxyK8WKVSQgj8232AwFheL68NlCKadyzk1Gi1si2fHXGpDVIaxOR1Ph+LTZYPNwmlqfr+9MhsdYy2JdQCxSGH9fSzTppsbTX9I5ILwqJ4mQakxPJBW5+w+kMZfo4xpkk7vtnULVH9pUcTiK2TlrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r3O/vGUy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B67BCC4CECD;
	Sun,  8 Dec 2024 02:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733624654;
	bh=AP9IbIDHT7HAYOGY3SZ9b0nWQ5jRlK8jajBDP/U5cEk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=r3O/vGUyIE3O6AYIpekpcP7f3m02tOJzGqg9UjOShkCoNzVc/x487e+zDQxgVAGJv
	 DG5pDURkg72PodiWaxSasHMuuAMkaIiEuRES0NFX++xX5YWJ53qglnmpvqcseS/baD
	 BlrAQwgpcosr/o67ZSBwPdxl/5uFDCrzZjylgV96N2qRY7yPXQRxzBAtCqFFfxACyV
	 c1E8MM1o38lcGPOrirQ6qfQIgbVPW5Y5MDa2inP8a5wgmVPMPl8ro9T6TGkgRkYTF+
	 0fZPU+reNwp4JlG7PAuJJSDKG7uA1BOL8v34/BH9aEUNHfBFrGILVwvQsg90kI7O6j
	 jc48sLPbM0YVw==
Date: Sat, 7 Dec 2024 18:24:13 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ahmed Zaki <ahmed.zaki@intel.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH RFC net-next 1/2] net: napi: add CPU affinity to
 napi->config
Message-ID: <20241207182413.63a2c11a@kernel.org>
In-Reply-To: <20241206001209.213168-2-ahmed.zaki@intel.com>
References: <20241206001209.213168-1-ahmed.zaki@intel.com>
	<20241206001209.213168-2-ahmed.zaki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  5 Dec 2024 17:12:08 -0700 Ahmed Zaki wrote:
> +static inline void
> +netif_napi_affinity_notify(struct irq_affinity_notify *notify,
> +			   const cpumask_t *mask)
> +{
> +	struct napi_struct *napi =
> +		container_of(notify, struct napi_struct, affinity_notify);
> +
> +	if (napi->config)
> +		cpumask_copy(&napi->config->affinity_mask, mask);
> +}
> +
> +static inline void
> +netif_napi_affinity_release(struct kref __always_unused *ref) {}
>  
>  static inline void netif_napi_set_irq(struct napi_struct *napi, int irq)
>  {
>  	napi->irq = irq;
> +
> +	if (irq > 0 && napi->config) {
> +		napi->affinity_notify.notify = netif_napi_affinity_notify;
> +		napi->affinity_notify.release = netif_napi_affinity_release;
> +		irq_set_affinity_notifier(irq, &napi->affinity_notify);
> +		irq_set_affinity(irq, &napi->config->affinity_mask);
> +	}
>  }

Nice, thanks for following up!

Let's move this code to net/core/dev.c or a new file, it's getting
complex for a static inline since there's no perf implication.

