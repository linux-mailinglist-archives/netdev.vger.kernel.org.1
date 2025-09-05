Return-Path: <netdev+bounces-220191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F3CEBB44B5F
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 03:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51F3D7AEBEB
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 01:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104FE20296C;
	Fri,  5 Sep 2025 01:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZXfTEnvb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D631D1E8342;
	Fri,  5 Sep 2025 01:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757037391; cv=none; b=oQDnVvMO4Gd7jsz0CEdTll40SbXY2kxpDo4IjifF7gN3IKkV5yXpdH+wJ14sGSNwoGxlb3ZCDW5XyHkwuw2uKMsVPd2TwFRYdYcAqnLImHqHRdr01jg6UZvhx8eEqz49NtiHiKx+4+nsRfeu7uzH4oAXZUo4GKj1pIdASkv/lbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757037391; c=relaxed/simple;
	bh=Xcn+I+kMYJB+u+tv1XD+EFcjTYldh08BKwhM60y/8E0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S1P5OFgpnenFhos5bEyZJ7c9RaXiEhdvjsUo/VQLPkGc59YEmeLWWvowzupoST1WxpZh75WYWrHttMiYvA/sRByWpabTeOwmHbHORpIKAl4K+ECHf5AD3dlIeTlgv/9etVaMjjd/jqKMcupnqfnAKAvUM6n+7IvpHHRwLyVj8Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZXfTEnvb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D057AC4CEF0;
	Fri,  5 Sep 2025 01:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757037390;
	bh=Xcn+I+kMYJB+u+tv1XD+EFcjTYldh08BKwhM60y/8E0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZXfTEnvbwXuSMFbjorLIGqEyLXaaUZmSiUjjAV7YcCN0klbARxYqI5ez4nWya6UgS
	 WFqadB42tQlbl/Jex5QJqNkVBfpnbkmrriSTx1YaA6fNerL2HuC3bTAtcaW+Ozmwbd
	 5QfHpCUhrrmMWqSrCc6xVIRwJK8IuR9TQOkmMboXH1u7wbCwsP1GxXwO0jFjh75KHK
	 fRob6P3T6OK4OPUg2iW2fbRY2l1JqfaJvfcTJZsFb6x00s0h2uAuTUqEcMQb7ypxwF
	 2a7Ed53ton6FayNdd4vSg+WxpWz+rdirz9hm7NxfvE0nQmrvAGX3tdENBAkdoYtdEE
	 nsiFdX+FR15ew==
Date: Thu, 4 Sep 2025 18:56:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sebastian Basierski <sebastian.basierski@intel.com>
Cc: Konrad Leszczynski <konrad.leszczynski@intel.com>,
 <davem@davemloft.net>, <andrew+netdev@lunn.ch>, <edumazet@google.com>,
 <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <cezary.rojewski@intel.com>, Karol
 Jurczenia <karol.jurczenia@intel.com>
Subject: Re: [PATCH net 3/3] net: stmmac: check if interface is running
 before TC block setup
Message-ID: <20250904185628.0de3c483@kernel.org>
In-Reply-To: <e1e9c67e-04c7-4db4-9719-25e5d0609490@intel.com>
References: <20250828100237.4076570-1-konrad.leszczynski@intel.com>
	<20250828100237.4076570-4-konrad.leszczynski@intel.com>
	<20250901130311.4b764fea@kernel.org>
	<e1e9c67e-04c7-4db4-9719-25e5d0609490@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 4 Sep 2025 21:01:49 +0200 Sebastian Basierski wrote:
> On 9/1/2025 10:03 PM, Jakub Kicinski wrote:
> > More context would be useful. What's the user-visible behavior before
> > and after? Can the device handle installing the filters while down?
> > Is it just an issue of us restarting the queues when we shouldn't? =20
>=20
> Before this patch driver couldn't be unloaded with tc filter applied.
>=20
> Running those commands is enough to reproduce the issue:
>  =C2=A0 tc qdisc add dev enp0s29f2 ingress
>  =C2=A0 tc filter add dev enp0s29f2 ingress protocol all prio 1 u32
>  =C2=A0 rmmod dwmac_intel
>=20
> in effect module would not unload.

Makes sense. Could you also confirm that the offload doesn't in fact
work if set up when device is down? I think block setup is when qdisc
is installed?

ip link set dev $x down
tc qdisc add dev enp0s29f2 ingress
ip link set dev $x up
tc filter add dev enp0s29f2 ingress protocol all prio 1 u32 ...

If it doesn't work we can feel safe we're not breaking anyone's
scripts, however questionable.

