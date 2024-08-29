Return-Path: <netdev+bounces-123007-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA939636F4
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 02:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D80C61F23E2B
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 00:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A5FB657;
	Thu, 29 Aug 2024 00:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i0dn0C3C"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3B3C125
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 00:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724892267; cv=none; b=syeZQA5flFuAjhBllAEcN1CRzTWkK14+MtVAr+GpDTOp2XUg9eJAP7YLVOFPyjZjIdhnTdo7BJrm5X+P+pbmL3a5xUSPV/rQGNCG+twFG/fr4A7DB18QJXCrWJoURbu2zzCOCofFQBowzk/G5TOfKp26xNU/kfgte/MNj3MjmBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724892267; c=relaxed/simple;
	bh=uuskT8JDoR7x3ExsPnXTMWMtiIgikoPOC9E/6ib2V9A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T0ife0z4HzeZHJEabYi/1Qjv5mQtqEzS1RjKf16dm8CaziCZll9df/+55T23Oj21IM9m6/t2rQrGCuK5qn1E6J9Ztqwp7NCOhJNxkuqhXN7XzMPzVGhi4cWgx636BpoRZWpiUbp0Dj93PBtOYTtMBJdCBFlYIMc6dk88h9KoVrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i0dn0C3C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6DE1C4CEC2;
	Thu, 29 Aug 2024 00:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724892265;
	bh=uuskT8JDoR7x3ExsPnXTMWMtiIgikoPOC9E/6ib2V9A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=i0dn0C3Chy/kqaYUjQuXEMCLYM4ciG/h2QD+PB13JQak876vKzUl9wHamZ9NH0aK8
	 rMFohPP8GmbxAQpn8V++ASMbNKA2uLYv52yUYZeeCbQ+9pibZ1Qo8mu5S0G2M/1lpB
	 7jbO99IBYcUvCD8rHNx51wZsGRD7z2gjvkj5jjRh21XhCzVDnyPH3M+OCoIvEXdwEN
	 EO3T2pV93PaDxdsL4Ttc3JE1jP4cVV8GCmM6PFhOqR8+BGXTLdPgFR8MIo+/TSqZ6V
	 qzELZfzSXq35Jh44tm42JuA9k/5Tq/U9QunO/+MeTiC9c6L2ybk1lhDma1r02ivBG9
	 lGcrbWYll4Ifw==
Date: Wed, 28 Aug 2024 17:44:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: <edward.cree@amd.com>, <linux-net-drivers@amd.com>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>, Edward
 Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 2/6] sfc: implement basic per-queue stats
Message-ID: <20240828174424.69a07137@kernel.org>
In-Reply-To: <d521cec8-a112-48b1-8368-f7ff406502fb@intel.com>
References: <cover.1724852597.git.ecree.xilinx@gmail.com>
	<54cf35ea0d5c0ec46e0717a6181daaa2419ca91e.1724852597.git.ecree.xilinx@gmail.com>
	<d521cec8-a112-48b1-8368-f7ff406502fb@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 28 Aug 2024 15:20:53 -0700 Jacob Keller wrote:
> On 8/28/2024 6:45 AM, edward.cree@amd.com wrote:
> > From: Edward Cree <ecree.xilinx@gmail.com>
> >=20
> > Just RX and TX packet counts for now.  We do not have per-queue
> >  byte counts, which causes us to fail stats.pkt_byte_sum selftest
> >  with "Drivers should always report basic keys" error. =20
>=20
> Seems like the self tests here should be fixed for this?

FWIW - I just didn't take lack of byte counters into account :)
It's probably fine to remove the requirement, imbalance (which
is the main use for the per queue stats) is better tacked using
packets, anyway.

Not a requirement from my perspective to merge the series tho =F0=9F=A4=B7=
=EF=B8=8F

