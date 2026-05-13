Return-Path: <netdev+bounces-287448-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qOnpBp8cBGpyEAIAu9opvQ
	(envelope-from <netdev+bounces-287448-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 08:39:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B444152E2A5
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 08:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F0C1305EA99
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 06:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0233D45DE;
	Wed, 13 May 2026 06:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="vpMyG/0T"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4653D45E7
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 06:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778654271; cv=fail; b=C0aEIcXyI37hRcDD1VkFhSFj6Deji2wPxjbaGlvhrgtbFMCbO0xbjpzXiAn+4d/U57Z4V3n9M8/aZLXghKHUDpKIurUa683D4JbIeUoiHkBX12zkck9na9vbZZEBPuHMuyiu0suhLCuWu1t3eCE2EN7Q212+HSxuszhlrTI8DhY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778654271; c=relaxed/simple;
	bh=ldUUL5LvKKg8pO0Cs/L34kXovzIocX5yA8E+TJKLni0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bk2AtVdccZERNT7nRIYBlouOzIKvBuuqHqO66OXkehdSDnORcv6c70ap7MSZYeOn/SfAfzlfvsyjIv55sVEy1ABCYL52q6amOiZgDKBKGYwr9DlJaBYUyEsZLF0XVbojvadOfeLf8DZUt4RQyFjl75uk77OKowgqREO8r7RbVDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=vpMyG/0T; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0528008.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64CFdwhI1926981
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 23:37:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=LAM65dsmKstrNrOI5lpRjp6+6YUiNRddRB1paFn5Tj4=; b=vpMyG/0TqYlK
	FWur0gKHVAvJLoyN0BSGdH/as0387H96++tNCUt3QXLPzIH8p4iQVhoAWfqG5rIL
	PJ8R14LbD6TgPnBJVBKbPpbdVILQkJgwZKS+0j92/oMcMMWJ6YSQw55sVRvWsjnv
	BK/NZREMWIfqkQkozj9BcGNXRWm9pg4/DgAPmrQfwhM3YcV7+5PrtgRlcs0tQ6Iv
	2sv9r9VJfHH/yIJi1TSk1Tg8YBNDS6675+5PvwhHEKsVCveXe4BTBOJndjzhI9G3
	GBkVoYXXxprMnmmG/IdN4YW+qAjnw0hImptu3z2Tk3hWF9aSB5AQvuc7ytezl1l/
	OsvLiBRgJQ==
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4e3nw1p46v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 23:37:48 -0700 (PDT)
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-482abfeea78so1690566b6e.1
        for <netdev@vger.kernel.org>; Tue, 12 May 2026 23:37:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778654267; cv=none;
        d=google.com; s=arc-20240605;
        b=fn6/obP8gTPi6xCa4QemBfUtZ4ClJYhWFI6sAVZYwGNQgpP9zsmRxc70Z7t4J+64ah
         xsZ1rDsJaA9yG/orR1MsEMsZ9lQbiXv5tS05iz9qu0qDvbIGw3EzfEWeAgWFyWrAh7Fy
         aXoiiEkVWhhH/TQRKJ137OZKKvThu8KNAk2QnPLQHOQR7GSmUv7GJQm3U8BwApWf19fj
         TV1UFuDiB8HoPuBKnK7DR8ouKmhUHzq+6CQsnVxSFo/2b7MHYe2w5DNkQu/gK+uHW59a
         mmQGS1FjSAa/nVUIEJs3Zi/dyBHgdxJ8r9VgXxZfV5Trhcc/OzDCyorvGyE+Ny5Nr8na
         Vxjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=P9w2oPSXP1dmZeF210Jp6h9CK0SajjpVEjMBSbv21rw=;
        fh=0xD/O83F4mDi3PNkHyc485y9B85dj5ve4dzfs03cJU8=;
        b=DE8ZfKQb/+n6CNudxRts+37vgp+Iu0IxQob/eCIm6a9xKDsPKM7Rv0THyJA46g/SvY
         qKLmlHE4Pi2oqm5u2w2JZvLIMfMbWUSzn5UIf3tdDMJjGqZ7ThPDLRk0l+C2ZpRSIMr+
         wdpgPY0/322MJscXI/L5bbIRxMgA+SO2bJdzHcpXJp/bWE2ERMWToXiSjHnr6WALvToz
         gdF5FNC4jc3V0a9/0VTRTOTK7zNS8QmCTl2vHXp4yfo6iJZ9/f6B8pJVEfBs0pxjN2/E
         emNqtDpYHjQmzLnZq72zUMLbY3W9Peyi/sKR5gQSrKGpQDmVnvTBfplxk1HCbJkd+8OH
         WbXw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778654267; x=1779259067;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P9w2oPSXP1dmZeF210Jp6h9CK0SajjpVEjMBSbv21rw=;
        b=Gej73QdB3qfAur/Lgmqlb0aDfa2xjwXGcfhP9YIgR1Ktx7kYWVxwBtrMn+NBFTZoFU
         HiR8Nw5a3Fqv224JhRT/ZMxoo/FQ7Ci7PrrgGagyL6ToymxoUgq48QOWUqeUfg3qB6b3
         syfhTfox+hgmxlXflOosQHHV4DuBvVLgRv7zk13geVOeSbVG9BRAI42HnFvaYJxtN96q
         Guo+Cck3yaldtWntPnZ4ltCuKgeB8a48nU/Prwu+XnEQEoXKDu5xFzcrKOMPv+AGPJNV
         huSa5hPSsLFVIiZyYp1q+o5z3ZAf/un2ZrV/SAG8kJ+hH+PmdY+lqQCCo1nIiGXIqGKk
         3BcQ==
X-Forwarded-Encrypted: i=1; AFNElJ9N0yKeCE5B1KNJEj9zutdlZKdl9YKWMAS7u0OjS1e9k/KbopDCgc96Zd9xVe2knUDfN5/nBU0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz2qNhZWifn91c9uOLmFON3wtW0gcYIFCqENZwOVaQG4pWb2nl
	fMtdB2t2DheWFpjGonIXHqcc2BYl9i3Fj7PDuzQrWkbGpxxEZdOVBQwytns6+96F9qi3BAcXUBQ
	x8RJ36IWN+/C0I+3/waLvCzSLirUNH9lQRlALhwNr9vhrjgbP1W0EF9zGzkZ4x2QIauyTq/qj7u
	8LmuuOJ8VmLl4n/P82wxmjICih+QlNl+iPqkGMCVo2gw==
X-Gm-Gg: Acq92OFMULxPfyh7xCQdZCJjFAo82cew5dy4uB7bMJ35yi60Q0IcLs/QLbejvK1Vw1A
	TAHJUL2E8T8/8KO8SK4B8TKBLZuiAr77G83rhPQo4lpduH7WBGNF7LThRy0E9EWEEy09TsoDPXO
	ruagFhAPSqMgmBIXKXs5HUdSoNe2OCyWkZqL99N1NtjBV9YGM93KcV4nC3uPIjwgxrDsxp1AE2S
	cqDX/kNTc+RUi7tx6/1GPs0NQQfjNo75w+J18j8
X-Received: by 2002:a05:6808:1492:b0:45f:13fe:4a3d with SMTP id 5614622812f47-482b28c375cmr1554319b6e.7.1778654267588;
        Tue, 12 May 2026 23:37:47 -0700 (PDT)
X-Received: by 2002:a05:6808:1492:b0:45f:13fe:4a3d with SMTP id
 5614622812f47-482b28c375cmr1554304b6e.7.1778654267114; Tue, 12 May 2026
 23:37:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512184755.4137227-1-zhipingz@meta.com> <20260512184755.4137227-3-zhipingz@meta.com>
 <d5b26695-f1fd-4cb6-8e19-201f689eceaf@huawei.com>
In-Reply-To: <d5b26695-f1fd-4cb6-8e19-201f689eceaf@huawei.com>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Tue, 12 May 2026 23:37:36 -0700
X-Gm-Features: AVHnY4KQd48YcOfbXPjFCGlTijSz26BhC9fVFq41RkqL4K2-2maS91GmCZxuWQI
Message-ID: <CAH3zFs2V_EENYzq+MRbSV_XPqz99xzA1V=Yc_GpgjGxxt41quw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] RDMA/mlx5: get tph for p2p access when registering
 dma-buf mr
To: fengchengwen <fengchengwen@huawei.com>
Cc: Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
        kvm@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-pci@vger.kernel.org, netdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Keith Busch <kbusch@kernel.org>,
        Yochai Cohen <yochai@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=HuZG3UTS c=1 sm=1 tr=0 ts=6a041c3c cx=c_pps
 a=4ztaESFFfuz8Af0l9swBwA==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=_1IyUuN4QrATX339ibzo:22
 a=i0EeH86SAAAA:8 a=VabnemYjAAAA:8 a=xwbcgjOLmlna_7dmNJkA:9 a=QEXdDO2ut3YA:10
 a=TPnrazJqx2CeVZ-ItzZ-:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: MwbwvD8o88kRvp6c8r9mE7ZEfbUdSq3c
X-Proofpoint-ORIG-GUID: MwbwvD8o88kRvp6c8r9mE7ZEfbUdSq3c
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDA2NiBTYWx0ZWRfX+CV8eIzGw0VL
 4MCYvYHDZxGJGZnYpNQGCsTh7DIXcfOjz4+V4aWzjUSyZgZU+PpcS3peO5HGVAICnY1FG71vY02
 VvkcBplt9XVXb/FSOxMKjUhYM1ikPAm2A4My0rDSSqlzSbDTV/0NBMUCtfbGJj/Yoc57AR/EVhu
 ryr65NAlfj1nW3sM3pEiqSf69CYVrIYhJP5j00ijLUADhJW6DRsz1M0EhV7M1859dVODuz/77pa
 1JiC0hPiW8nYhd9Wrl/Gp46XsPCbu8Ora0QBDiNp7lzPwiMHby3Kw/XIb5EBILoAO7AGFGGaEWW
 ZQ/F4pJu4dfrJUf6Fad3M5AcKG9b7ZJPyWzZCSDwh6CouRVV2lg09qzqkIQgIMgSrBxoeF8DFf4
 6LlR2hgXr4CySqffK8Pnjcsoj+6yOfsbLLGOMEzMfqdSwwPSFs0XlfGG5aOh5vWOiHpbhVsdIHs
 cw6RXBuM9FFZ5PlbDCw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Rspamd-Queue-Id: B444152E2A5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287448-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[meta.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhipingz@meta.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:email,meta.com:email,meta.com:dkim]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 6:49=E2=80=AFPM fengchengwen <fengchengwen@huawei.c=
om> wrote:
>
> >
> On 5/13/2026 2:47 AM, Zhiping Zhang wrote:
> > Query dma-buf TPH metadata when registering a dma-buf MR for peer to
> > peer access and translate the raw steering tag into an mlx5 steering
> > tag index. Factor mlx5_st_alloc_index() so callers that already have a
> > raw steering tag can allocate the corresponding mlx5 index directly.
> > Keep the DMAH path as the first priority and only fall back to dma-buf
> > metadata when no DMAH is supplied.
> >
> > Add pcie_tph_get_st_width() so the mlx5 IB driver can query the
> > device's negotiated ST width without poking pci_dev::tph_req_type
> > directly (that field is gated by CONFIG_PCIE_TPH and would otherwise
> > break !CONFIG_PCIE_TPH builds). Pass the width to the dma-buf
> > get_tph() callback so the exporter can return the value that matches
> > the consumer's capability.
>
> 1\ Recommend the PCI/TPH modification be committed separately.
> 2\ How about rename it to pcie_tph_enabled_req_type() ? so we could
>    use already defined macro:
> #define   PCI_TPH_REQ_DISABLE           0x0 /* No TPH requests allowed */
> #define   PCI_TPH_REQ_TPH_ONLY          0x1 /* TPH only requests allowed =
*/
> #define   PCI_TPH_REQ_EXT_TPH           0x3 /* Extended TPH requests allo=
wed */
>

Hi Chengwen,
  Thanks for the great suggestions.
  1. Splitting the PCI/TPH helper change into a separate prep patch
sounds reasonable.
  2. I see your point about exposing the enabled TPH request type! I
want to take one
      more pass over the overall flow and switch to that if I don=E2=80=99t
find any issues.

  Zhiping

> >
> > Pass the dma_buf pointer that the umem already resolved into
> > get_tph_mr_dmabuf() instead of re-resolving the user-supplied fd.
> > Re-resolving opens a TOCTOU where a concurrent dup2() can substitute a
> > different dma_buf between umem creation and TPH lookup.
> >
> > Track the per-MR ownership of the allocated mlx5 ST index on
> > mlx5_ib_mr (dmabuf_st_index / dmabuf_st_owned) and release it once the
> > firmware mkey no longer references it. Both the cached path
> > (mlx5r_umr_revoke_mr_with_lock + ib_frmr_pool_push) and the
> > destroy_mkey path call mlx5_ib_mr_put_dmabuf_st() so the ST index does
> > not leak when the MR is reused from the FRMR pool.
> >
> > Initialize ret in mlx5_st_create() so the cached steering-tag path
> > returns success cleanly under clang builds.
> >
> > Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> > ---
> >  drivers/infiniband/hw/mlx5/mlx5_ib.h          |  6 ++
> >  drivers/infiniband/hw/mlx5/mr.c               | 72 ++++++++++++++++++-
> >  .../net/ethernet/mellanox/mlx5/core/lib/st.c  | 27 ++++---
> >  drivers/pci/tph.c                             | 20 ++++++
> >  include/linux/mlx5/driver.h                   |  7 ++
> >  include/linux/pci-tph.h                       |  2 +
> >  6 files changed, 124 insertions(+), 10 deletions(-)
> >
>
> ...

