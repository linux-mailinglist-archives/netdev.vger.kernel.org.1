Return-Path: <netdev+bounces-249348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E0507D170DF
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 08:43:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C7CFA3043A76
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 07:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988A5369995;
	Tue, 13 Jan 2026 07:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="ohjM0ON+"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D0234AB06
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 07:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768290216; cv=none; b=haITC0OANPlyLTxOQtcYgeQs682CA/UZDW4E0Nl9V8ztrr22QxpucaMlHpLPH36R0eRojVSvQVfwrFsdr3ZVWVDG/XwhediQi6bkBsdPPXGdfxr2VBWNr7K656W6UQwC01yZBYsbwjnPQWy3E3Z+P/JnrmUUTtEIGJHI2Jrmve8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768290216; c=relaxed/simple;
	bh=zGn0pKvA6OgenKsHspBMNJAwi9Bqv9Oox/+s44htSXU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ehdv4J52dtSL1K2DyTss+BTRWgUZlgL3FDR2j1Cv+cc9PAtPCJnbgl4drkLxuTdAUYqQYIfsOyue6XfcZ6TWniFXKxL4viM6TC/QyMSVwrpeaduwURUPzoYZutfoIj0hWFoUp+ukOT+ahnmjD/ppfxa6jo8sf3UNBwYxRu5vaLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=ohjM0ON+; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60CKZDmd1344277
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 23:43:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=gzg8mht3uEfEsB9mpcmWCqr+Nv9gXmUj0rK/ycGTSVg=; b=ohjM0ON+m8SJ
	TFKeNst2jL76j6wu+B6YngSPsIlyzLRaSeA96f8fIzGS2ANz1Mht5ua2hUfDY0GZ
	JMiBMTNhgHSQ70e5GoXEjEx9Qz5CmMCydw0Shb1XCxXYgniFtOXQE2lCaXuThgdW
	LlNRUOZ5QcroXks2kCxYONhEB+VITGE3OZWfZjBht4nnZEhdr2c9sm6D6EFZo0FI
	XfROt/WbY9Ontb4jV1e545Hb28+KEwdmF3yPJv3Znh5q9VRyMnP7bWv2L1YmUoZz
	gwjMMIjz6e2J9BXh5DQYRo4VDTs4GjFsN2XdvX5/6dn6GYMUKOqKs9jscy7lmBX5
	SVG2tkSWVw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4bn84akra5-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 23:43:34 -0800 (PST)
Received: from twshared13080.31.frc3.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Tue, 13 Jan 2026 07:43:32 +0000
Received: by devbig259.ftw1.facebook.com (Postfix, from userid 664516)
	id E214CEAF9B0B; Mon, 12 Jan 2026 23:43:18 -0800 (PST)
From: Zhiping Zhang <zhipingz@meta.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        <linux-rdma@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <netdev@vger.kernel.org>, Keith Busch <kbusch@kernel.org>,
        Yochai Cohen
	<yochai@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>,
        Zhiping Zhang
	<zhipingz@meta.com>
Subject: Re: [RFC 2/2] Set steering-tag directly for PCIe P2P memory access
Date: Mon, 12 Jan 2026 23:43:13 -0800
Message-ID: <20260113074318.941459-1-zhipingz@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260106005758.GM125261@ziepe.ca>
References: <20260106005758.GM125261@ziepe.ca>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
X-Proofpoint-ORIG-GUID: WXCQvbWpqUye2j3rh7N32HAhbV9fnh2n
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDA2MyBTYWx0ZWRfX34s5TWuDpa49
 vu73R1OG6bZSXZ4XSvSq/zLPZ7TtTmbuX1CGviVx2ZimsIo5cpv77fJAuCYPj7Kve7GZ5qe9TG5
 ixGEK+CzOOKyCQeJtCXDVXSZ7OAtYi1Vm2VJZZXelU0B6hbxGnhyohaHXqM1uKva9OuKvNvDHvM
 PtFBgaT9oyGGcxgA1S7M4H5VPAc9ICBeoTe1tk8pqFU/3b4CcP6HyzMm12OhdNh7+9BxljDp458
 P7eVS0v9DQNDZq+WQersGNuY2kPAUbdVOQCp9XWTHXdyPG8tOEVf7cAN0p3XOEuRQFrXDilc5b5
 4GUMLksSgAHCVoUmZ1JkjlLbPcz8PL3RYQaquG9/QoX0nVA+Hh+wZDz49T+fqbfIeag89jy6An5
 TWv7r8FYE/ZIE8O6Z78r+LvbzPCuqQC3tIcJqoxmtFg68c0HHxFSK3UmP8gk6/BlINnBNeO2VtW
 qXcpqxYg8jVHkNGZjKQ==
X-Authority-Analysis: v=2.4 cv=AMcN/8bb c=1 sm=1 tr=0 ts=6965f7a6 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0C_WzUsgh5R8F8g28p8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: WXCQvbWpqUye2j3rh7N32HAhbV9fnh2n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_01,2026-01-09_02,2025-10-01_01

On 2026-01-06  0:57 Jason Gunthorpe wrote:

> On Thur 2025-12-04  8:10 UTC Zhiping Zhang wrote:
>
> > Happy holidays! I went through the vfio-dmabuf patch series and Jason=
's
> > comments once more. I think I have a proposal that addresses the conc=
erns.
> >
> > For p2p or dmabuf use cases, we pass in an ID or fd similar to CPU_ID=
 when
> > allocating a dmah, and make a callback to the dmabuf exporter to get =
the
> > TPH value associated with the fd. That involves adding a new dmabuf o=
peration
> > for the callback to get the TPH/tag value associated.
> >
> > I can start with vfio-dmabuf and add the new dmabuf op/ABI there base=
d on
> > Leon's patch. Pls let me know if you have any concerns or suggestions=
.
> >
> > Zhiping

> Ah, hum, that approach seems problematic since the dmah could be used
> with something that is not the exporting devices MMIO and this would
> allow userspace to subsitute in a wrong TPH which I think we should
> consider a security problem.
>
> I think you need to have the reg_mr_dmabuf itself enforce a TPH if the
> exporting DMABUF requests it that way we know the TPH and the MMIO
> addresses are properly linked together.

> Jason

Got it, thanks for pointing out the security concern! To address this, I
propose that we still pass the TPH value when allocating the dmah, but we=
 add
a verification callback in the reg_mr_dmabuf flow to the dmabuf exporter.=
 This
callback will ensure that the TPH value is correctly linked to the export=
ing
device=E2=80=99s MMIO, and only the exporter can authorize the TPH/tag as=
sociation.

Please let me know if this approach aligns with your suggestion!

Zhiping

