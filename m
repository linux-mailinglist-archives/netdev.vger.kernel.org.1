Return-Path: <netdev+bounces-121073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB71A95B8EE
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 16:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64DEC1F219AA
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 14:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1A11CBE89;
	Thu, 22 Aug 2024 14:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fbWtXZBg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AB81C8FC9;
	Thu, 22 Aug 2024 14:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724338127; cv=none; b=QE4+7PDpJJFUuHu+DwwGXyEF93wD7tOHgPYfIn8purV8xDJH5qo580P6s1OPA6UKI+2NfBGpQVcHW3vpbvnUwBwAEKwDfGVK4W67R7z++xiqSEYZHCMAZvXiZRXzqZgE8n0Z19+EQLkWlQPlUWLGuM8rSh/8KjuxCj0KFqL66YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724338127; c=relaxed/simple;
	bh=i7GOlKNXxs8vjXkkE8U7/f9oHLQWaMMv5jIyvsOPIf4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aCPyyHlqmRQDBI7Gy+GCHgnBxyJBTIaoL+H7jTtjLxTO/gP2CmpJgwiNJLQp3R/m/uSfkRkknun48O0wKv3o8txJOyXSAdltBy+uH7LVmqbvp6Lfy3Fx1R00HhQoByiM52nKIE4M8vKYiLA8IY0k/TL0MFWD+mxcydTPSyJgWIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fbWtXZBg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7708DC4AF0B;
	Thu, 22 Aug 2024 14:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724338127;
	bh=i7GOlKNXxs8vjXkkE8U7/f9oHLQWaMMv5jIyvsOPIf4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fbWtXZBgWPhFJGaPQ0jvDplYBadVg3Fm1KeUk3x1phafoXhfJNEtDbGgYTgtcC5gM
	 jMcY72coxCbLCUyhTW9oFmDgUiaPSRKDOlw+wdcMFUPI/suyZrrp9M8e7mKfmIp7Ql
	 Y9TfSIGHhfxaO5NAg39Os9A4vxym0tGSPI3wcp8cf8Q7o1DDpnAvQXb7Oie6eWkZJu
	 0wjucczBkFPnF8ERolHBhUMIDN8mJ9JUZ6U4XVwCFy7JG2Y2rEQk79pGe3LiFZyPUw
	 GE2R19z4epAKowwXht9ZbLDiSXOd1zP2MA3pjkUFekGYC2/iPIpXooOSN44f+Td/dZ
	 mQ+pjTsInsPkw==
Date: Thu, 22 Aug 2024 07:48:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Bharat Bhushan <bharatb.linux@gmail.com>
Cc: Bharat Bhushan <bbhushan2@marvell.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, sgoutham@marvell.com, gakula@marvell.com,
 sbhatta@marvell.com, hkelam@marvell.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, jerinj@marvell.com,
 lcherian@marvell.com, richardcochran@gmail.com,
 b@mx0a-0016f401.pphosted.com
Subject: Re: [net-next,v6 1/8] octeontx2-pf: map skb data as device
 writeable
Message-ID: <20240822074845.5f932d6d@kernel.org>
In-Reply-To: <CAAeCc_=Nmh25RDaY4SA2CHsu2mqgdtKEo62b4QKSV4V8icHMMw@mail.gmail.com>
References: <20240819122348.490445-1-bbhushan2@marvell.com>
	<20240819122348.490445-2-bbhushan2@marvell.com>
	<20240820153549.732594b2@kernel.org>
	<CAAeCc_=Nmh25RDaY4SA2CHsu2mqgdtKEo62b4QKSV4V8icHMMw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 22 Aug 2024 09:15:43 +0530 Bharat Bhushan wrote:
> On Wed, Aug 21, 2024 at 4:06=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> =
wrote:
> > On Mon, 19 Aug 2024 17:53:41 +0530 Bharat Bhushan wrote: =20
> > > Crypto hardware need write permission for in-place encrypt
> > > or decrypt operation on skb-data to support IPsec crypto
> > > offload. So map this memory as device read-write. =20
> >
> > How do you know the fragments are not read only? =20
>=20
> IOMMU permission faults will be reported if the DMA_TO_DEVICE direction f=
lag
> is used in dma_map_page_attrs(). This is because iommu creates read only =
mapping
> if the DMA_TO_DEVICE direction flag is used.  If the direction flag used =
in
> dma_map_pages() is DMA_BIDIRECTIONAL then iommu creates mapping with
> both read and write permission.

The other way around, I understand that your code makes the pages
writable for the device. What I'm concerned about is that if this
code path is fed Tx skbs you will corrupt them. Are these not Tx
skbs that you're mapping? Have you fully CoW'd them to make sure
they are writable?

