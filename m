Return-Path: <netdev+bounces-132092-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 986F99905EF
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 16:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F59B282F59
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 14:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7ED02178E8;
	Fri,  4 Oct 2024 14:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EW5tXoz/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9338217338;
	Fri,  4 Oct 2024 14:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728051838; cv=none; b=K2gQ85pXHTeQs3UvsTtGDrwdmkHG7+MTRPek2pZNRc2tMHSxgPLDyEkLp71yUit8XsOTDNNgNsZnfUrHkkg81Zl8hfdbp180mMdBm29gy+sl11w7b+QxSpzPJIbl1NN6+rJUd/04VH8F7u+gXwhT12/RlEPTSe5vdca2bSsp5Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728051838; c=relaxed/simple;
	bh=XlcQ35UDL4Ddq3O7GDIWM1FWw0FdIbvAByQr3gyc5YQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hBu8RR/UIFcMJivqRVK4sKLqk3ymBD43k0784FDM7LglBtTrh/6Nx/rvqSAEqGxoPk51eOcjTs/UluiLSZN1hNvreoRDt1jr08v0pzfQttf67hLxue/+sZ+Jn/oKpNQKLrwS7cjlVNDQ2MF+6W23DYXHn0FkPgF/ol56AoDFYXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EW5tXoz/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EA08C4CEC6;
	Fri,  4 Oct 2024 14:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728051838;
	bh=XlcQ35UDL4Ddq3O7GDIWM1FWw0FdIbvAByQr3gyc5YQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EW5tXoz/DI26Mb4DC6u+NEA1D5nJPnJnxF6+HUeQ9K0vfPfcsM5L1PwlCt7RTWXId
	 8FZAsjYKIIG3FQ6T2f56dQ4lMsrKcbA6EM0lZW5NEaHYxQkaqVckP2D6H0oNly5pDH
	 tPgaYC71CTZicKhci8PS+pYOEwVPmhfNLipOtKvlRKyB6OcomxMwGNhMQuiEoFQ7K/
	 BWbJMmMhi+BO/Jfv/imHy7pXZ7nbW+ZPB4lk7m5zer/FKy5K364OozDnZ75fpTvJeI
	 Cl6MFlCcot0YzCQ5e6hrhoMD6zKm1nm5fnXJTobHxjf9PSA7RMPGahIsjuBmbPOjkq
	 /76XwOVwcD6+A==
Date: Fri, 4 Oct 2024 07:23:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Shenwei Wang <shenwei.wang@nxp.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, horms@kernel.org, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, Ong Boon
 Leong <boon.leong.ong@intel.com>, Wong Vee Khee <vee.khee.wong@intel.com>,
 Chuah Kim Tatt <kim.tatt.chuah@intel.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
 linux-imx@nxp.com, Serge Semin <fancer.lancer@gmail.com>, Andrew Lunn
 <andrew@lunn.ch>
Subject: Re: [PATCH v4 net] net: stmmac: dwmac4: extend timeout for VLAN Tag
 register busy bit check
Message-ID: <20241004072356.5905e684@kernel.org>
In-Reply-To: <20240924205424.573913-1-shenwei.wang@nxp.com>
References: <20240924205424.573913-1-shenwei.wang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 24 Sep 2024 15:54:24 -0500 Shenwei Wang wrote:
> Increase the timeout for checking the busy bit of the VLAN Tag register
> from 10=C2=B5s to 500ms. This change is necessary to accommodate scenarios
> where Energy Efficient Ethernet (EEE) is enabled.
>=20
> Overnight testing revealed that when EEE is active, the busy bit can
> remain set for up to approximately 300ms. The new 500ms timeout provides
> a safety margin.
>=20
> Fixes: ed64639bc1e0 ("net: stmmac: Add support for VLAN Rx filtering")
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>

FTR this was merged to net as commit 4c1b56671b6.

