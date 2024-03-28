Return-Path: <netdev+bounces-80438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1977187EBBE
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 16:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 779C9280E1C
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 15:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3FC4EB55;
	Mon, 18 Mar 2024 15:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rmi688oO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432E74EB3D;
	Mon, 18 Mar 2024 15:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710774649; cv=none; b=OGlAhCU31iqC0sMAZv0/jul4jcv3cOhI73qAwHAC1wPwhkAUsXOituiojj/WJ5j1Kmz9RZrWynU6Q22hRGjikVynVl2WuabIK4pahGV9RjqK4O9aKIJpAYZrEqq0cEtcGMIqMPYTcP5dtGJBKZpacVg+qCVBGod0pjI/jQX0Y8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710774649; c=relaxed/simple;
	bh=fH+FYiniWHx5rmlrXtlHSdr1Cwr9tIkFEC+J1fMVSjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LoMlG5v+NOMdosKjpIv/Z2eENIbdHLBfdtXaL1EXbddk0YKKuU1yOFYX6p5fM7Gi8SpEsnNzu59I5gInNDC1tVWnIWpPw6KNmwXLaFDv4CgwYUiEdFGWG92+c8qpVudSkQS/FGlpAe7Tov7UtkG2jQU3llY83BS8sSnuwMwK3wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rmi688oO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B450DC433C7;
	Mon, 18 Mar 2024 15:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710774648;
	bh=fH+FYiniWHx5rmlrXtlHSdr1Cwr9tIkFEC+J1fMVSjc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rmi688oOG4+pYCoMikOks7rpgzB0dDwAOCBbcgM61JlGKzFAsgEfLLi7LP5gwap7I
	 rHNOymOVlw8I3sn6yaduBTJruXER9LnV/zubbnRMVyYxT+dHkZD8oOsEUtrIxNpwvS
	 9uYvrPmGeqXoDf4huBQVBBrLjGFmM/wpGR+0mFJrKhjlLUYDUbwSD8xW02fPyfetLy
	 D/S+FLMpQPmK+4i9DssiN6CxDQEnQ0vddnJ7yxIVwGYv//CuVaSpHeXwp7bzsVyYcE
	 IwJ4dVLKzp7VELuXD6nejfqJ5h+lHoB1zrWwZC2B1Lkmm01ygwyuwEK/AL99ogjo9Z
	 4NjGn9muE5DIA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rmEdZ-0000000035w-3rpp;
	Mon, 18 Mar 2024 16:10:54 +0100
Date: Mon, 18 Mar 2024 16:10:53 +0100
From: Johan Hovold <johan@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Matthias Kaehlcke <mka@chromium.org>,
	Doug Anderson <dianders@google.com>,
	Bjorn Andersson <quic_bjorande@quicinc.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-bluetooth@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: bluetooth: add new wcn3991
 compatible to fix bd_addr
Message-ID: <ZfhZffrZXwtKgZ13@hovoldconsulting.com>
References: <20240318110855.31954-1-johan+linaro@kernel.org>
 <20240318110855.31954-2-johan+linaro@kernel.org>
 <CAA8EJprywWbdoyfAbys=0WzEdAkp0UK1fzzCPzxKRjyk9DrC6Q@mail.gmail.com>
 <Zfg--2_NMPSPTxK-@hovoldconsulting.com>
 <20240318144806.GA3963554-robh@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240318144806.GA3963554-robh@kernel.org>

On Mon, Mar 18, 2024 at 09:48:06AM -0500, Rob Herring wrote:
> On Mon, Mar 18, 2024 at 02:17:47PM +0100, Johan Hovold wrote:
> > On Mon, Mar 18, 2024 at 03:00:40PM +0200, Dmitry Baryshkov wrote:
> > > On Mon, 18 Mar 2024 at 13:09, Johan Hovold <johan+linaro@kernel.org> wrote:

> > > > The only device out there that should be affected by this is the WCN3991
> > > > used in some Chromebooks. To maintain backwards compatibility, mark the
> > > > current compatible string as deprecated and add a new
> > > > 'qcom,wcn3991-bt-bdaddr-le' for firmware which conforms with the
> > > > binding.
> > 
> > > This compatible doesn't describe new hardware kind. As such, I think,
> > > the better way would be to continue using qcom,wcn3991-bt compatible
> > > string + add some kind of qcom,bt-addr-le property.
> > 
> > No, you can't handle backwards compatibility by *adding* a property.
> 
> But you could add a property for the not broken case. That's a bit odd, 
> but so is your compatible.

Sure, we could have a property that we only add for wcn3991-bt going
forward.

But we can't go back in time and add this property to all devicetrees
and say that 'local-bd-address' is big endian unless that property is
present (as that would leave all the non-wcn3991 devicetrees broken).

> > I wanted to avoid doing this, but if we have to support Google's broken
> > boot firmware for these devices, then this is how it needs to be done.
> 
> Don't Chromebooks update everything together. So maybe we don't care in 
> this case?

That was my hope, but Matthias seemed to suggest that we need to
continue supporting the current (broken) binding because doing such a
coordinated update may be easier said than done:

	https://lore.kernel.org/lkml/ZcuQ2qRX0zsLSVRL@google.com/

A new compatible string (or one-off property) would allow them do make a
change when they are ready (e.g. by only updating the devicetrees after
all boot firmware has been patched and pushed out).

Johan

