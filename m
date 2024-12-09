Return-Path: <netdev+bounces-150112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A6EC9E8F58
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 10:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6A92165CB4
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 09:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A004216E31;
	Mon,  9 Dec 2024 09:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PxB+omHl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE6C215F60;
	Mon,  9 Dec 2024 09:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733737939; cv=none; b=EPB/aaZNemI67ZIMYjs7UudcX8oevUn/m2xRoK6s7+G1AX9VcoSYtT7lIaSv2TdZy9F87SfaZNPfwr+vdViooVm8a/0E3cW9xF/sVctpkG2A6B5bvMBZvkTxgU3gMUlZJhRTeZ1SnJ7pJILP4DV6aslBl8O+9a+9RWI4fJvjChA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733737939; c=relaxed/simple;
	bh=17cYCIB8pmf0RVDzrkvPvsOzy3tMjOSzBdNQ+E6TpP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V4lj9wCFjvT6Yj2c2vmmWrOk910F/yYz2o2bNeTBzHMezukq8K7OCc4mMflfyuGxgR1mv0YKAuZI+1/nBNFEpOyTFWAjycUvpXgTj9DHXx6JevTtSElYfDrlPY2ctoFQFUo/Dn46rWvZhrmL8kxwl/mVqLm56jL+9NZ4e0UO+VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PxB+omHl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D684AC4CEE0;
	Mon,  9 Dec 2024 09:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733737938;
	bh=17cYCIB8pmf0RVDzrkvPvsOzy3tMjOSzBdNQ+E6TpP4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PxB+omHlAp8wbBIiBVweI06BjBfn+YExbWhsmzSyG9Ug/M5iTZom1qyT82b0/RuYj
	 MJl08rjhCilpe+8OIchsmSo+myoiDCDI3U+O5dwLZGRi0cf8ddXBjOpdZya8lygnfi
	 /9BdLvYZUVV9JriJRYosDlynIhxfmAkzXruelmzoECB1RvW4XgQgYvG5sOsLkRyMuG
	 xcc6k8t9IxT0MAHcj2tLSt6BdH4KUc3E+PCdl7yX190TqPlZOZFlKp7vciMXhUnEIG
	 VuIhnm4rSA3+v9ygrT+MQNxQ/i4mqaety6MerE/cIw+bi+MVgonj1IqeJGqS0dqOlz
	 JPenRZ/aeSRnA==
Date: Mon, 9 Dec 2024 10:52:15 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Woojung Huh <woojung.huh@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>, kernel@pengutronix.de, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v1 1/5] dt-bindings: net: Add TI DP83TD510 10BaseT1L PHY
Message-ID: <bz5ybgnpkjwqde6kfq6oiyme34gthvnyz5rcfwojqq2aquwjle@aypks6sf45wi>
References: <20241205125640.1253996-1-o.rempel@pengutronix.de>
 <20241205125640.1253996-2-o.rempel@pengutronix.de>
 <20241205-immortal-sneak-8c5a348a8563@spud>
 <Z1KxZmRekrYGSdd4@pengutronix.de>
 <20241206-wrought-jailbreak-52cc4a21a713@spud>
 <Z1QAoAmXlBoixIS4@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z1QAoAmXlBoixIS4@pengutronix.de>

On Sat, Dec 07, 2024 at 09:00:32AM +0100, Oleksij Rempel wrote:
> > > > > +properties:
> > > > > +  compatible:
> > > > > +    enum:
> > > > > +      - ethernet-phy-id2000.0181
> > > > 
> > > > There's nothing specific here, can someone remind me why the generic
> > > > binding is not enough?
> > > 
> > > The missing binding was blamed by checkpatch. Haw should I proceed with this
> > > patch?
> > 
> > Does dtbs_check complain when you use it in a dts? What you have here
> > matches against the pattern ^ethernet-phy-id[a-f0-9]{4}\\.[a-f0-9]{4}$
> > so I think it won't. checkpatch might be too dumb to evaluate the regex?
> 
> dtbs_check didn't complained about it, only checkpatch.

Checkpatch is not a reason to add bindings. Missing binding would be a
reason (e.g. pointed out by dtschema), but I understand this is not the
case here, so drop the patch.

Best regards,
Krzysztof


