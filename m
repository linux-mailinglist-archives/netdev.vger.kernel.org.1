Return-Path: <netdev+bounces-224507-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8862B85B40
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 17:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E25F854399C
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 15:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF5430FC2C;
	Thu, 18 Sep 2025 15:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IHflm/A+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F3E30F953
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 15:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758210003; cv=none; b=VJqV4py8Zt+NCNmWAEXUzFkars033wQB69WIO/QCbXoCeQr8Rma3tv4d7FFg0IRlgzXxFbMUrCjLcK8I4muDphMT6gs9yQVdEx0MgA22CeJTQlbb04ECcI6onYsfOgZ9kV91Fhn58TUGf4I2+gmomyYDktw4gIHCaUhAb6QYkZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758210003; c=relaxed/simple;
	bh=T6BZ74K7NAO2zW7jZ6vG89Tm0AtcEgvrfsAlTbl3HIo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TDk3PJDfuyE5+twzd6vwJYVFouk/vLQZy6vcYV6wnl6VMFlFqEU4p6I1/v4n2DP85PxoilgSg9B0YaVmfYsklL3OE8SCiyIdvEEwImLF7066A+aaG1ZVCpTJfO88c2143iQnigVcZlTDvDmUlPF3PlNMb5fpXT+FKgK18wRIsYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IHflm/A+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2E52C4CEE7;
	Thu, 18 Sep 2025 15:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758210002;
	bh=T6BZ74K7NAO2zW7jZ6vG89Tm0AtcEgvrfsAlTbl3HIo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IHflm/A+vpAygcZIfolMpJH+YUURnj7y5T6HcWGcDXH64mmV1l/YpMEibtls5X7lS
	 J6cNRah6vwkTIp7m4R1YJaa44DFOBwjZHQMcZ2NviyLqJOi2mpAkNzLGT8VbvFtpOI
	 zDUdQyLdPnezvUNMcb9w6FWtJc3ru6HRszriY3sA/heXQ3/Wj0fCIihYYeJu3345l0
	 1W/rJVUIOLIOj23mavEohQypaXMGCFpBNV5taxSNeATcK+l2nBMGjjeG1UEBTs81Ct
	 qeXTG3ma4u9nA4E8Ay+rTIGVv/Ds8S7NJlfVEMRgb9IOTmuklcxTXhlfUOPsD1RKVq
	 ysR7Rf1nX+aAA==
Date: Thu, 18 Sep 2025 08:40:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Carolina Jubran <cjubran@nvidia.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Andrew Lunn
 <andrew@lunn.ch>, Michael Chan <michael.chan@broadcom.com>, Pavan Chebbi
 <pavan.chebbi@broadcom.com>, Tariq Toukan <tariqt@nvidia.com>, Gal Pressman
 <gal@nvidia.com>, intel-wired-lan@lists.osuosl.org, Donald Hunter
 <donald.hunter@gmail.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, netdev@vger.kernel.org, Yael Chemla
 <ychemla@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH net-next v3 3/4] net/mlx5e: Add logic to read RS-FEC
 histogram bin ranges from PPHCR
Message-ID: <20250918084000.1b4fb4f4@kernel.org>
In-Reply-To: <76611a9c-4c53-40a2-96c1-e1cf5b211611@nvidia.com>
References: <20250916191257.13343-1-vadim.fedorenko@linux.dev>
	<20250916191257.13343-4-vadim.fedorenko@linux.dev>
	<20250917174638.238fa5fc@kernel.org>
	<4d3a0a08-bda4-483f-a120-b1f905ec0761@nvidia.com>
	<20250918073551.782c5c25@kernel.org>
	<76611a9c-4c53-40a2-96c1-e1cf5b211611@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 18 Sep 2025 18:16:14 +0300 Carolina Jubran wrote:
> On 18/09/2025 17:35, Jakub Kicinski wrote:
> > On Thu, 18 Sep 2025 17:25:40 +0300 Carolina Jubran wrote: =20
> >>> why does MLX5E_FEC_RS_HIST_MAX exist?
> >>> We care that bins_cnt <=3D ETHTOOL_FEC_HIST_MAX - 1
> >>> or is there something in the interface that hardcodes 16? =20
> >> My intention was to keep mlx5 capped at 16 even if ethtool raises its =
max.
> >> We=E2=80=99ll only increase this once we know the device should expose=
 more than 16.
> >> Since our HW has internal modes that can report more than 16 bins, this
> >> ensures we don=E2=80=99t accidentally expose them if ethtool increases=
 its max. =20
> > But why? =20
>=20
> Because currently those modes shouldn't be exposed for ethernet.

I understand that the modes should not be exposed.
I don't get why this has anything to do with the number of bins.
Does the FW hardcode that the non-Ethernet modes use bins >=3D16?
When you say "internal modes that can report more than 16 bins"
it sounds like it uses bins starting from 0, e.g. 0..31.

