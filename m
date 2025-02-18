Return-Path: <netdev+bounces-167337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77078A39DA5
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 14:37:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77F303B35EE
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 13:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B3F26AAB7;
	Tue, 18 Feb 2025 13:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QRkY5wkh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B49E269AE3;
	Tue, 18 Feb 2025 13:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739885283; cv=none; b=p1jSTeLAmrmZxuwZ5+pkTv99kE4vh++7G22xXvLdSCX7cUSpsO5vVijdqIUd18/w2Nac3GgoWqBMS+8SaUSzTE5bmgX4g2eDLcwfldFD5L4e7SOe3jhrinf24aKrgffOAQ9KgLVooBHX1BVa+oT7aMndcYU5snlUtqpsZxjANgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739885283; c=relaxed/simple;
	bh=WUKim6I0GIa7OB0lKVP3eWVJgzUnm9e3oqomWqD2WwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I+v41yGds+6xiNbbG9x5mrGEv+i5hanXTfAcVV2OwzLoupVgV6GKfpLS6fi190ciqQYde7EXeW9h2pucBJW4ViaU9oGFJzPEoxzi5iDPNrsVTGpipztSYda+EEkWets61FsaHD6J4SmAC4u42W4MXiw2RY4ruejci3EjtAVF8/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QRkY5wkh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0B20C4CEE2;
	Tue, 18 Feb 2025 13:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739885283;
	bh=WUKim6I0GIa7OB0lKVP3eWVJgzUnm9e3oqomWqD2WwE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QRkY5wkhLUTZa8Vgk9CcWZJea74bEM97C45lbFLORkAUB5t+VRmdEfU71ySeA/yxW
	 5NMqAIX9A0mbShZ+R0dswW7gak2vOJLFcxXy6KrkdB5sPzBqsEpf3AzkIGxXnIhi1j
	 jMtH7ZgyYxe6ZU5hCKKLmDtFA4fD/bK+9C7rBVuEwPMl03ASmv8RMDMtUK75L5AGBj
	 gSoA+Q3PlsZPfztif70R0TpNPtuuu2NmOTlfjkyJlRXepDS0ZzSBdQ9hWCbfFthAl9
	 QZaaiqQDwFbj7B/EIHbZFOtv1qiyrmUw8WSerUvHwo6E8JULcreHVOo51tozIV+s6t
	 eXpiL0Mo+Wqbw==
Date: Tue, 18 Feb 2025 13:27:56 +0000
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	DENG Qingfang <dqfext@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [PATCH net-next v4 13/16] net: airoha: Introduce Airoha NPU
 support
Message-ID: <20250218132756.GU1615191@kernel.org>
References: <20250213-airoha-en7581-flowtable-offload-v4-0-b69ca16d74db@kernel.org>
 <20250213-airoha-en7581-flowtable-offload-v4-13-b69ca16d74db@kernel.org>
 <20250217183854.GP1615191@kernel.org>
 <Z7OMv-7UBVtKaEFb@lore-desk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7OMv-7UBVtKaEFb@lore-desk>

On Mon, Feb 17, 2025 at 08:23:43PM +0100, Lorenzo Bianconi wrote:

...

> > > +	err = devm_request_irq(dev, irq, airoha_npu_mbox_handler,
> > > +			       IRQF_SHARED, "airoha-npu-mbox", npu);
> > > +	if (err)
> > > +		return err;
> > > +
> > > +	for (i = 0; i < ARRAY_SIZE(npu->cores); i++) {
> > > +		struct airoha_npu_core *core = &npu->cores[i];
> > > +
> > > +		spin_lock_init(&core->lock);
> > > +		core->npu = npu;
> > > +
> > > +		irq = platform_get_irq(pdev, i + 1);
> > > +		if (irq < 0)
> > > +			return err;

...

> > Should this return irq rather than err?
> 
> are you referring to devm_request_irq()?
> 
> https://elixir.bootlin.com/linux/v6.13.2/source/include/linux/interrupt.h#L215
> https://elixir.bootlin.com/linux/v6.13.2/source/kernel/irq/devres.c#L52
> 
> I guess it returns 0 on success and a negative value in case of error.

Hi Lorenzo,

Sorry, somehow I completely messed-up trimming context and managed to make
things utterly confusing.

I've trimmed things again, and it is the platform_get_irq() call
not far above this line that I'm referring to. It assigns the
return value of a function to irq, tests irq, but returns err.

It is one of (at least) two calls to platform_get_irq() in airoha_npu_probe().


