Return-Path: <netdev+bounces-177534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E9C7A707A0
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 18:04:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26A32188633B
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 17:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A0725D209;
	Tue, 25 Mar 2025 17:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gqgp0GAc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620821A0712
	for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 17:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742922260; cv=none; b=qasEF84V0KlVdI8ZWgcU/zMTdl3Fg0OQZ/xqzppAIiJ/3Mn2Q2X9K/srhkkY02QBLgnfmnwHZkadduUv36LEs9Ku8sGm4Fw1rWutviFs7Y5N0cuUbGXX5XOSzi007zqZOk0v7H8VSuMxPiIDXqDUTULg3F/oxFuktOR3JkdLhQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742922260; c=relaxed/simple;
	bh=rtuiFQwbX8f3mWULtdpBdIoW+29mipyFqmH/njLvTkw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iqLPWh4Nqh/NP+JUO5fOqg4910dXzNgIA0L/Be+u8VtyLCxTmBrsd94KoOYlh1qlt460R5swtnJ3Zpo3Mds2BcoWbPXjvWCxd0h3fHG7lgv99oHw8scwjk4SBhJ2CYOjD1j9RLejwFAT2D3sc6oVOl9Zt2gpRbftI0dQ3VSquJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gqgp0GAc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB32BC4CEE4;
	Tue, 25 Mar 2025 17:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742922259;
	bh=rtuiFQwbX8f3mWULtdpBdIoW+29mipyFqmH/njLvTkw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gqgp0GAcNKdFxZ6WpeyonBsBMQOnZR1mzn5C3Dh1wJiwJqlUG4X+KCI3brMOlDknp
	 c5tGMsAjGCLMlm5/YJ/f6PJEM1HU6D+Y4t6FET746Xb2dkZ0zr9SsCsG3NwQOiTIQd
	 HKgYclZF7W1GrGe8lpYqvXvgpSgIV7o2jkirfCrBR6gMo0HSrzZsvSBc6LexasFyfA
	 cTG+fjhKqflQl2I1yhvpH6JyrmLCuWciiynuEKTeRmqbhjbPyNYF9x0n7Xf2OPQvOT
	 kWOIZ39v/Jgz9GwB4J+rHvm7wpY49R1Vv7A2WPNZHMMYrZPsqnceo5r85FqZVODzbK
	 lFcDtbWYC8nxA==
Date: Tue, 25 Mar 2025 10:04:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: "davem@davemloft.net" <davem@davemloft.net>, "sdf@fomichev.me"
 <sdf@fomichev.me>, "horms@kernel.org" <horms@kernel.org>,
 "edumazet@google.com" <edumazet@google.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "pabeni@redhat.com" <pabeni@redhat.com>
Subject: Re: [PATCH net-next v2 08/11] net: make NETDEV_UNREGISTER and
 instance lock more consistent
Message-ID: <20250325100412.73b49ded@kernel.org>
In-Reply-To: <0be167ba394a9485c78c67d187ec546131a5cbe1.camel@nvidia.com>
References: <20250324224537.248800-1-kuba@kernel.org>
	<20250324224537.248800-9-kuba@kernel.org>
	<0be167ba394a9485c78c67d187ec546131a5cbe1.camel@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 25 Mar 2025 12:17:15 +0000 Cosmin Ratiu wrote:
> > +	netdev_lock_ops(dev);
> > =C2=A0	call_netdevice_notifier(nb, NETDEV_UNREGISTER, dev);
> > +	netdev_unlock_ops(dev);
> > =C2=A0} =20
>=20
> This introduces a potential deadlock when changing a device namespace:
> do_setlink already locks the instance lock and
> call_netdevice_unregister_notifiers will then deadlock.

Thanks for catching, the notifiers need a closer look.
Let me apply the earlier patches (most importantly the fix)
and we'll see what shakes out as we address the outstanding
bugs in notifiers..

