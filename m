Return-Path: <netdev+bounces-237883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BA04CC51299
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 09:46:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C3C2F4E9FF9
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 08:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A63F2FD66C;
	Wed, 12 Nov 2025 08:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZRLcyJVA"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A484C97
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 08:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762937150; cv=none; b=ESZ61wIHkJHkl6mXlIVjUm4+Hz/lPEhYzWx/l5ajhid7UKaPUsw+y/2yZBDaSwk5fgS3Qjb86KeljlHz++CIggJruMx1UXQuOgE13+UyL7jJSrQ2ESaly9FDGUlzrilIWjUVov012BWexybcGafR9lrcgCSd2xagbBtGTquKtjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762937150; c=relaxed/simple;
	bh=bMd/5ZCa9EMaSTREEd7iLAxqgvRmN67nkKKHJJi+jz8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uf23hKTX5DF2GwXQDrSg2CDUe6c/qxTt4cOnSeCZxVnVtxbbAQtDXuurgrkG4ezAUpeVlKsQ4QpqT8qjwRiBkz/YhxIRyIhmYGvAG4YdBeoVGam8vaq+xNJV4CLe6DntBAK5XEy3O53BTdDALJfsKsfdAW0lHYpshR6zSfOBen8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZRLcyJVA; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 66822C0F55A;
	Wed, 12 Nov 2025 08:45:24 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 035936070B;
	Wed, 12 Nov 2025 08:45:46 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4FC4310371975;
	Wed, 12 Nov 2025 09:45:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762937145; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Xx9lma/uNuwe8Ol8EXR6l6X/Zl29lmcXdESupmUg7+Q=;
	b=ZRLcyJVAlZkwnw6blito1gQWc+V4oy/WEyWjCCj1oyLX148EAorok0b/07wznJzWidgnFC
	INrMwtcr/yaYDC9fz5b9wmfwUdpNRkBjQKxUPym7IcC0htcpSBkMmG3ec3qlFsUKvXtZBX
	u3an52FI6Tshcl5W40vZK56JwarrkQn166rhPlYBlHihAXuHpa5+sN3QiyTBu3pr7VsAYq
	f/MYu12egS5LgK05i0LIIbi54QtVtIV2Iv2Lb+SSWExFDudr9NoQU1Yc0rR81/t9EIvCZo
	+ULzMQdeeqi41pVjZvGD8Zb0NvCz7G8bLtVaiEG27bwRZ2zgsLCH1qua+9LFZQ==
Date: Wed, 12 Nov 2025 09:45:41 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Jiaming Zhang <r772577952@gmail.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 horms@kernel.org, kuniyu@google.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, sdf@fomichev.me,
 syzkaller@googlegroups.com, vladimir.oltean@nxp.com
Subject: Re: [PATCH v4 1/1] net: core: prevent NULL deref in
 generic_hwtstamp_ioctl_lower()
Message-ID: <20251112094541.5510346b@kmaincent-XPS-13-7390>
In-Reply-To: <20251111173652.749159-2-r772577952@gmail.com>
References: <20251103171557.3c5123cc@kernel.org>
	<20251111173652.749159-1-r772577952@gmail.com>
	<20251111173652.749159-2-r772577952@gmail.com>
Organization: bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On Wed, 12 Nov 2025 01:36:52 +0800
Jiaming Zhang <r772577952@gmail.com> wrote:

> The ethtool tsconfig Netlink path can trigger a null pointer
> dereference. A call chain such as:
>=20
>   tsconfig_prepare_data() ->
>   dev_get_hwtstamp_phylib() ->
>   vlan_hwtstamp_get() ->
>   generic_hwtstamp_get_lower() ->
>   generic_hwtstamp_ioctl_lower()
>=20
> results in generic_hwtstamp_ioctl_lower() being called with
> kernel_cfg->ifr as NULL.
>=20
> The generic_hwtstamp_ioctl_lower() function does not expect a
> NULL ifr and dereferences it, leading to a system crash.
>=20
> Fix this by adding a NULL check for kernel_cfg->ifr in
> generic_hwtstamp_ioctl_lower(). If ifr is NULL, return -EINVAL.
>=20
> Fixes: 6e9e2eed4f39 ("net: ethtool: Add support for tsconfig command to
> get/set hwtstamp config") Closes:
> https://lore.kernel.org/lkml/cd6a7056-fa6d-43f8-b78a-f5e811247ba8@linux.d=
ev/T/#mf5df538e21753e3045de98f25aa18d948be07df3
>=20
> Signed-off-by: Jiaming Zhang <r772577952@gmail.com>

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

