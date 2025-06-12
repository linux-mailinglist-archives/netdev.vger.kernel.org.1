Return-Path: <netdev+bounces-196997-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE259AD73FA
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 16:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38F353A6955
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 14:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD9D2472BD;
	Thu, 12 Jun 2025 14:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="akSDlnxc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A982142048
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 14:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749738892; cv=none; b=HkjJW61jTOaGht+/gFGjOP3Mwk6wEc8nzwFkoY6w8RxnRbKcFP6Y5ZsBT99Ppu9Ipn2nJWHRD8Q9oGanBnRbhK/PuxWD9O0Jkm9Ast4e+X00LIXBFST3SiOhmd50ZreMQjMYLE2/vKbUXLUim65A18BW1lSsLNeU1VxqWHmAino=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749738892; c=relaxed/simple;
	bh=/CK2DlECBo8upGduGAmeDrXlJSPz9NwccMM/Gg5QXEU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bqeVKbHMfXVVnK8mOx5/CTxSeojLpZK10tnSQaLV+RCi50HvGDMP6lN3CxLaYZghb2+4LlM2EnwzhOPbqnb5vtYqFVy1F2lHnvL2Bjjg7zGMDffHjg1y8F26iwWDE6OyeUKequ5u/FsdqWYw62gex7cucwXavKVjNAW6jP3/UBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=akSDlnxc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3427C4CEEA;
	Thu, 12 Jun 2025 14:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749738892;
	bh=/CK2DlECBo8upGduGAmeDrXlJSPz9NwccMM/Gg5QXEU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=akSDlnxcCR7nFiPBUdcCa7XhLitZ4VKpXv6BJ5F2InaQdUmc0zW97A0loKZfWj7Ro
	 HZ0i+zYxiBuYzl6RaPE3mmWZJgCwC0SiZmmNPrFi3O6Xjpz66BiJRUufxk2xTPJyMo
	 yQHIcA4KLwbYyPguvvz2uhdY9/bMiQmGRcl2CUPm6CIzHEn3tdgE802I5FY9D85NC5
	 YqfyccY8uG7RGhFtENc9Uu39gnszKvHUeU6OSQWAIe6soLt+dPi4sHsBVsSSXSFEb9
	 2UEMd5Tm6d6LV8FYQDFvcBYaxuGtRvPWhw9Xhz3XX2U1ehc1m/E5EOoIXuHdnhobC/
	 D8VoN5shsHS3g==
Date: Thu, 12 Jun 2025 07:34:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Gal Pressman <gal@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, Alex Lazar
 <alazar@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH net-next 1/2] net: vlan: Replace BUG() with
 WARN_ON_ONCE() in vlan_dev_* stubs
Message-ID: <20250612073451.7f53b559@kernel.org>
In-Reply-To: <611fe2fd-d826-4ffb-9f5b-5eb7ba99ae62@nvidia.com>
References: <20250610072611.1647593-1-gal@nvidia.com>
	<20250610072611.1647593-2-gal@nvidia.com>
	<20250611171540.27715f36@kernel.org>
	<611fe2fd-d826-4ffb-9f5b-5eb7ba99ae62@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Jun 2025 13:32:33 +0300 Gal Pressman wrote:
> > This should let the compiler eliminate the dead code completely,
> > assuming it truly dead. We can still replace the BUG()s as 
> > a of cleanup but I think the above is strictly preferable as 
> > a solution to your problem?  
> 
> Makes sense.
> 
> If we're going in this direction, maybe just provide a stub
> is_vlan_dev() for the !IS_ENABLED case?

I guess it's a question of whether we prefer simpler expression
or fewer ifdefs. I picked fewer ifdefs, but no strong preference.

