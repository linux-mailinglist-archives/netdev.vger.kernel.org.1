Return-Path: <netdev+bounces-224462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B718CB85487
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 16:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A71151897D59
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 14:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D05304BCD;
	Thu, 18 Sep 2025 14:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y3YLy2kg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DB5223324
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 14:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758206153; cv=none; b=s/MsUDGli+TaxIbveRL2NPI3yMRiCRS8nmcPrvJi+K+e1lyOmAY5OLiBGpqEw45bfMjkZvLYU2ThO7Dp+f3ZbOekQSyoCSjAg5WqkfGP4p2e7phOikskqhV/pdUvXULj65MNqX10GnRsVBa6F1NjlpPfpfxFo9h66VbjC037FEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758206153; c=relaxed/simple;
	bh=NG9Iy41L3OlERbb6D3HvOfX8MkhsXZHvsfHT7rh7Otc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=If8W3n8lvKNZhuqNP6NCiVG9qG6sAJ9yOM5sz8/xq8YdeVfjgOvhOhbfw0iB8az+NOlQbNdgzLxbj87U00HexUOQklrb25iPt3/MUI/b9ZlebgIwrXeI+c+cKbdwnGnuevjC8wl7uP7UoIWoi0U4f764tewlq39vPQRVu8bF1zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y3YLy2kg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1925C4CEE7;
	Thu, 18 Sep 2025 14:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758206152;
	bh=NG9Iy41L3OlERbb6D3HvOfX8MkhsXZHvsfHT7rh7Otc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Y3YLy2kgJBY35maajYaDE6E3dGQ/Sg7FLvWUreos9FEhi2BiFG/sFw6F4YtZscda1
	 LwZBTXf7ONLAS/wJ4646i0E155J4kZPVDzIBgkPZQ2/hHiJxwS0ZPCClXi84Ej7xhv
	 GSOuXtjGUSETN7wuyE6Y5CHRSZwzVc86hxAafylEFRSF0P3FR5KQrenXc18zlmMisr
	 JDTTn1YaISp0NoRx/dc7FutAPqRZRrQrxON8pkBc2M0nFtdGIG7ONisDAKUybyPeNY
	 wLXLeSeptK8Ffg4gtxUnuO3PebbWTgSdb/fdZTP5oqjRyvHYcEsnXPFsuNnwb5Nqkj
	 wWrJbBGOL/huQ==
Date: Thu, 18 Sep 2025 07:35:51 -0700
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
Message-ID: <20250918073551.782c5c25@kernel.org>
In-Reply-To: <4d3a0a08-bda4-483f-a120-b1f905ec0761@nvidia.com>
References: <20250916191257.13343-1-vadim.fedorenko@linux.dev>
	<20250916191257.13343-4-vadim.fedorenko@linux.dev>
	<20250917174638.238fa5fc@kernel.org>
	<4d3a0a08-bda4-483f-a120-b1f905ec0761@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 18 Sep 2025 17:25:40 +0300 Carolina Jubran wrote:
> > why does MLX5E_FEC_RS_HIST_MAX exist?
> > We care that bins_cnt <=3D ETHTOOL_FEC_HIST_MAX - 1
> > or is there something in the interface that hardcodes 16? =20
>=20
> My intention was to keep mlx5 capped at 16 even if ethtool raises its max.
> We=E2=80=99ll only increase this once we know the device should expose mo=
re than 16.
> Since our HW has internal modes that can report more than 16 bins, this=20
> ensures we don=E2=80=99t accidentally expose them if ethtool increases it=
s max.

But why?

