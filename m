Return-Path: <netdev+bounces-133319-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5C49959D1
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 00:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1832286C28
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 22:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1625C215F64;
	Tue,  8 Oct 2024 22:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k5U2rcg9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9ACE215F47;
	Tue,  8 Oct 2024 22:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728425316; cv=none; b=jZMa+xqgj0L3G8VUeH+OoKzDQGUKS3OCw9wV/Fj8l+x+6S4Yqr2dBRAUD4UiEdnz35W+QbEXCaZBYjMhiBPh58zbkuLQg/X6+MyaNK6wGgrRcs7vArV3Ia/wnbpcrLxv+B18KIEwsKymwroIIC+Y9cWcalTkLAJpcdbdKLESP6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728425316; c=relaxed/simple;
	bh=jG1CndrXsVGOVLrPEIIVi6Syu8ufJXW4Gso7dXRmJgA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M0adeA4UaXnZM6QU3B+MtQl1eVjuhRtHL/CZGSYKQyijv1VPha6zL+7x9R5DmumdqdrC50VBvowY1YsTIdOwRr7yS14dNEByzfHy1PtXSlkYy0c70bKdXlF3D6nZA36iMTdJ8mCdmu/kw/ULt0i+9YLAcjBbt9OYS/yXwmphywo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k5U2rcg9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D6B2C4CEC7;
	Tue,  8 Oct 2024 22:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728425315;
	bh=jG1CndrXsVGOVLrPEIIVi6Syu8ufJXW4Gso7dXRmJgA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=k5U2rcg9HYME+J9y7JVv+BmqK9dmrau5TL6CnTEnOMWmhRiSkJyM8KcTktvOH7UWE
	 1+gqldSI9qGmVgVhpRkYGomUmKKg07v60EJwS4nkAUerdHV3En0ZTKX7z1P5diSGWf
	 plY+cOHY2LYU2RNpRXA4msCJAjI2fffuePeu3PBzm3lnikQMjqFA9kr8ZY7vmfgB7m
	 LEzP1+ZmsmONEhDFMVDY4gYdDX4po0wXMfCPvcTEkBquc48cp6oHTAwytBBAZSk0cJ
	 M1DVyZ/bdF9y55HGT+RXYneMuIKZ9LBJj9qEyF8PPVTfnWavxNTJPMx26k6xcuHhnt
	 0QvAgnL2qxakQ==
Date: Tue, 8 Oct 2024 15:08:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, mkarsten@uwaterloo.ca, skhawaja@google.com,
 sdf@fomichev.me, bjorn@rivosinc.com, amritha.nambiar@intel.com,
 sridhar.samudrala@intel.com, willemdebruijn.kernel@gmail.com, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Jiri Pirko
 <jiri@resnulli.us>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Kory Maincent
 <kory.maincent@bootlin.com>, Johannes Berg <johannes.berg@intel.com>, Breno
 Leitao <leitao@debian.org>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, linux-doc@vger.kernel.org (open
 list:DOCUMENTATION), linux-kernel@vger.kernel.org (open list)
Subject: Re: [RFC net-next v4 1/9] net: napi: Make napi_defer_hard_irqs
 per-NAPI
Message-ID: <20241008150833.4385ea50@kernel.org>
In-Reply-To: <20241001235302.57609-2-jdamato@fastly.com>
References: <20241001235302.57609-1-jdamato@fastly.com>
	<20241001235302.57609-2-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  1 Oct 2024 23:52:32 +0000 Joe Damato wrote:
> @@ -377,6 +377,7 @@ struct napi_struct {
>  	struct list_head	dev_list;
>  	struct hlist_node	napi_hash_node;
>  	int			irq;
> +	u32			defer_hard_irqs;

This will be read on every unmasking, let's put it above 
the "/* control-path-only fields follow */" comment

