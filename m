Return-Path: <netdev+bounces-223780-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4365B7D856
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D799324D82
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 23:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDFDD2EFDBE;
	Tue, 16 Sep 2025 23:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uXtvWIHn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09A22EFDB4;
	Tue, 16 Sep 2025 23:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758065357; cv=none; b=MaThh1bIg3m8oUXOqRy18yY1uL4A3b9MsyJOLYXEFeT+A8yMngAq0FXa0kG8+76FZLcAU5YY7MsOfAPEcaVhsQ4LUBwc7AullMvqwJDUAT45LAS9x7itoEBAM6OjYef2le7uplaPRHxC0hQsIeTBUyVedF+ojVR6D90lnRZ6xa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758065357; c=relaxed/simple;
	bh=k4X+TDdxYnMFeiG6T5cwCEzF6QBKsVkBdrllZHC7J8c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TcwiilXqMW4/0Pp1yoBFvnLgJK4rLHctTSZXSf4L0+W9v0YFyM5SwAYM+2EjIScnr+p22Usal5hPIBQ3t5mZZKH/N16Wf+tQG9MerLaCWvYvwqcfVbB/Pl59SOwit+AtnBTc1kEhKIjKs1H4OWOCxJs4iXSlymRTf6D9L5/YW5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uXtvWIHn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B45E0C4CEEB;
	Tue, 16 Sep 2025 23:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758065356;
	bh=k4X+TDdxYnMFeiG6T5cwCEzF6QBKsVkBdrllZHC7J8c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uXtvWIHngXq0BPMM7jbfHeKUIqsiopM665pyzyoJJhAJxvkrF34J9BQpfk59mILdp
	 64P+VIhpEqyYM1XmdI2spwp/GUSp6QS8b7OFw9W4sye6xBoUtcppaPnXKrdiqGY799
	 XAB5+F+HEsqTC4gZ/L1QJvWkqPFhWksAuABF9Edz4cpRJlhOYhHVPeD9pyO7oRmih4
	 jr8Eiu+Jl7VnikaC1Llxyp7YFyRJlCWFnchTJiRW/Sg8amnue3mt6RmuzwwUDPNX0J
	 JAerYPbCtrczZVSQ5E/KKGeBJnePhQZ3M38ikhd52M1x9GZnbvfJqv8D1JWVseAqCU
	 tvLviSIccDvLw==
Date: Tue, 16 Sep 2025 16:29:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sebastian Basierski <sebastian.basierski@intel.com>
Cc: Konrad Leszczynski <konrad.leszczynski@intel.com>,
 <davem@davemloft.net>, <andrew+netdev@lunn.ch>, <edumazet@google.com>,
 <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <cezary.rojewski@intel.com>, Karol
 Jurczenia <karol.jurczenia@intel.com>
Subject: Re: [PATCH net 3/3] net: stmmac: check if interface is running
 before TC block setup
Message-ID: <20250916162914.264a1ee6@kernel.org>
In-Reply-To: <c8651cb3-6e54-4542-8523-c56c716bce4c@intel.com>
References: <20250828100237.4076570-1-konrad.leszczynski@intel.com>
	<20250828100237.4076570-4-konrad.leszczynski@intel.com>
	<20250901130311.4b764fea@kernel.org>
	<e1e9c67e-04c7-4db4-9719-25e5d0609490@intel.com>
	<20250904185628.0de3c483@kernel.org>
	<c8651cb3-6e54-4542-8523-c56c716bce4c@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 9 Sep 2025 20:47:01 +0200 Sebastian Basierski wrote:
> >> Before this patch driver couldn't be unloaded with tc filter applied.
> >>
> >> Running those commands is enough to reproduce the issue:
> >>   =C2=A0 tc qdisc add dev enp0s29f2 ingress
> >>   =C2=A0 tc filter add dev enp0s29f2 ingress protocol all prio 1 u32
> >>   =C2=A0 rmmod dwmac_intel
> >>
> >> in effect module would not unload. =20
> > Makes sense. Could you also confirm that the offload doesn't in fact
> > work if set up when device is down? I think block setup is when qdisc
> > is installed?
> >
> > ip link set dev $x down
> > tc qdisc add dev enp0s29f2 ingress
> > ip link set dev $x up
> > tc filter add dev enp0s29f2 ingress protocol all prio 1 u32 ...
> >
> > If it doesn't work we can feel safe we're not breaking anyone's
> > scripts, however questionable. =20
> Sorry for late response.
> I just checked what you asked for.
>  =C2=A0 x=3D"enp129s29f0"
>  =C2=A0 ip link set dev $x down
>  =C2=A0 tc qdisc add dev $x ingress
>  =C2=A0 ip link set dev $x up
>  =C2=A0 tc filter add dev $x ingress protocol ip flower ip_proto 1 action=
 drop
> Looks like with and without patch ICMP packets are dropped.

Aren't you testing non-offloaded filter?
Test with skip_sw, if it works it means that some order of commands may
have indeed worked.

