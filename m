Return-Path: <netdev+bounces-122516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B1296190C
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 23:16:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94F7EB21678
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 21:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C2C158218;
	Tue, 27 Aug 2024 21:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="unaU0H5K"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDDB1F943
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 21:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724793374; cv=none; b=rqgenYpnKnw5nH75djmqeDxS7pQ4nwnN97PPAJEK/oBozffkw+IWBRaXlU6huVHNDeisVno++dKIkiljfQ83gOHLiE9EYOM6KF+jowRkmmEdSlycrhkCeUlq7fzyWwNgpl9uQgFnQ5G3BLIwNnxdoRZ74Ztc62hGgZCSn2/ACDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724793374; c=relaxed/simple;
	bh=b3BpQhRD4K9Z4aw7hzwFChLah9iymSqWlV3qWrv2bEo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LifpdNqG/5pH04rCK2TJf2stto9r+cexKnAPZsHDABGqq9f35PoMhBc/9F6h75jN04Vp0bs3sK5WwtFCxlLqkLdpKVP8IPkOKT7GzlTVJ8qZWL0KbqiMPWAS0maBcefcGwK001PzuKhgpDX6fU4Q/Ee5U/s626ANARvPyw6nSLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=unaU0H5K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99CA3C4FE94;
	Tue, 27 Aug 2024 21:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724793374;
	bh=b3BpQhRD4K9Z4aw7hzwFChLah9iymSqWlV3qWrv2bEo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=unaU0H5KpKB8P0yFl3pzA4tnDEU6uYvp0Ewer50du/p/8YgtMYUt0M/e4nTfBjcz/
	 vbgeehOb9RXotFZDFOOK1GjrY0N1vaGHpzWwlLuOm0icHtdcfph3V+AzoDxLARKYqq
	 ECpwDsuPKgs2ipMpihXNYc3jTN9Cu16mM7utlUeQmWH67Hvr/Sd8ZSQ8XQssjd7wh/
	 LHfn6PcjxirRCCLebhiiIlYXBps1+9lnxapst2hNvHLa/klh2NAo+L9A+ncsdOgK7a
	 PSDnNg0BvId6nMxASBvNbTQkEBFoyXRv9hVN3O4MSM+4WpnqxTA06ykksXpn1Jq0JF
	 qpxE1t+6QQFsA==
Date: Tue, 27 Aug 2024 14:16:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, pavan.chebbi@broadcom.com,
 andrew.gospodarek@broadcom.com, horms@kernel.org, helgaas@kernel.org,
 przemyslaw.kitszel@intel.com, Hongguang Gao <hongguang.gao@broadcom.com>,
 Somnath Kotur <somnath.kotur@broadcom.com>
Subject: Re: [PATCH net-next v3 9/9] bnxt_en: Support dynamic MSIX
Message-ID: <20240827141612.2edc92eb@kernel.org>
In-Reply-To: <Zs2A8wvFUoZfjPzQ@mev-dev.igk.intel.com>
References: <20240823195657.31588-1-michael.chan@broadcom.com>
	<20240823195657.31588-10-michael.chan@broadcom.com>
	<Zs2A8wvFUoZfjPzQ@mev-dev.igk.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 27 Aug 2024 09:32:03 +0200 Michal Swiatkowski wrote:
> > +static int bnxt_add_msix(struct bnxt *bp, int total)
> > +{
> > +	int i;
> > +
> > +	if (bp->total_irqs >=3D total)
> > +		return total;
> > +
> > +	for (i =3D bp->total_irqs; i < total; i++) {
> > +		struct msi_map map;
> > +
> > +		map =3D pci_msix_alloc_irq_at(bp->pdev, i, NULL);
> > +		if (map.index < 0)
> > +			break;
> > +		bp->irq_tbl[i].vector =3D map.virq;
> > +		bp->total_irqs++;
> > +	}
> > +	return bp->total_irqs;
> > +}
> > +
> > +static int bnxt_trim_msix(struct bnxt *bp, int total)
> > +{
> > +	int i;
> > +
> > +	if (bp->total_irqs <=3D total)
> > +		return total;
> > +
> > +	for (i =3D bp->total_irqs; i > total; i--) {
> > +		struct msi_map map;
> > +
> > +		map.index =3D i - 1;
> > +		map.virq =3D bp->irq_tbl[i - 1].vector;
> > +		pci_msix_free_irq(bp->pdev, map);
> > +		bp->total_irqs--;
> > +	}
> > +	return bp->total_irqs;
> > +} =20
>=20
> Patch looks fine, treat it only as suggestion:
>=20
> You can save some lines of code by merging this two function.
>=20
> static int bnxt_change_msix(struct bnxt *bp, int total)
> {
> 	int i;
>=20
> 	/* add MSI-Xs if needed */
> 	for (i =3D bp->total_irqs; i < total; i++) {
> 		...
> 	}
>=20
> 	/* remove MSI-Xs if needed */
> 	for (i =3D bp->total_irqs; i > total; i--) {
> 		...
> 	}
>=20
> 	return bp->total_irqs;
> }

> > +	} else if (irq_change && !rc) {
> > +		int total;
> > +
> > +		if (irqs_required > bp->total_irqs)
> > +			total =3D bnxt_add_msix(bp, irqs_required);
> > +		else
> > +			total =3D bnxt_trim_msix(bp, irqs_required);
> > +
> > +		if (total !=3D irqs_required)
> > +			rc =3D -ENOSPC; =20
>=20
> and here
>=20
> if (bnxt_change_msix(bp, irqs_required) !=3D irqs_required)
> 	rc =3D -ENOSPC;

=F0=9F=91=8D=EF=B8=8F that does look cleaner

