Return-Path: <netdev+bounces-258001-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GOY2L7ltimlHKQAAu9opvQ
	(envelope-from <netdev+bounces-258001-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 00:28:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF19115642
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 00:28:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6DD8B301E3CB
	for <lists+netdev@lfdr.de>; Mon,  9 Feb 2026 23:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DFB732ABCF;
	Mon,  9 Feb 2026 23:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="fYocgLEN"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8600327783
	for <netdev@vger.kernel.org>; Mon,  9 Feb 2026 23:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770679727; cv=none; b=rK+7O5ophgzPhdv4c9huJVezGjLFnnBJutFUfXzUEI/t3FhlUVZmw0IjN5YD6Tzu67Lvkua+ZZG1DF1ubj4uYnWmEZlzLrHd/abVnJCH8Lvtjx6IWQVTF/88OKwX6LFOwgbqoQAQiL+sDk9wvDU8Dz2ta4chGAtb5odo5nEVV80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770679727; c=relaxed/simple;
	bh=4NQ3u7S2HVKAQx7TWVmyCHklXZFGVPOW8H6mAomwl90=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=clqi9512kS72OkzRTDK099tAkXIK6ZUEnOo5BB3GbtO/zxby4cVdwgd50qdtha28vWp6PCQrYWBu1iAi42wSucZkX2FS8QPL8xiYY+Qb698zp4EQa16l2WWA4OPZMycTZBhA0OnOQOdIbXL2Shdca6440G18taa1kkI6su1/ARo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=fYocgLEN; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 619LEMgE1057354
	for <netdev@vger.kernel.org>; Mon, 9 Feb 2026 15:28:45 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=4NQ3u7S2HVKAQx7TWVmyCHklXZFGVPOW8H6mAomwl90=; b=fYocgLENwgUg
	uq6TnsOJzeVCiR69fRm/WdNoar89z9uTDBMT6uwqfYQ0TbU+IO4XFq/PR16A/oWU
	wzdqXBncuPtYnh7LyXhRCLfpfvc9l9SisqJ8R9xc5MFZo18du1c2Yp95emYgODsZ
	wq0rs6tZtvc+Gkr/wMELArLvWzmnQC/1ldIsoA81uQNVaeXimF0GQys0KybstbLB
	NcNPTPqBByykiibLadkPPztjoiAX52Z6rZu8JR2w/mYThbGutge/k4LMdWOWrCo8
	ZvYoes1Gehx/2YlaMtvGwq08yLSz+TfzV6WS6m65bN2U3C6LG2V+uSe4o++y0kWM
	B7F1iTjhFw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 4c7qathdxt-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 09 Feb 2026 15:28:45 -0800 (PST)
Received: from twshared41309.15.frc2.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Mon, 9 Feb 2026 23:28:43 +0000
Received: by devbig259.ftw1.facebook.com (Postfix, from userid 664516)
	id 2ECB11011CDA2; Mon,  9 Feb 2026 15:28:26 -0800 (PST)
From: Zhiping Zhang <zhipingz@meta.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        <linux-rdma@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <netdev@vger.kernel.org>, Keith Busch <kbusch@kernel.org>,
        Yochai Cohen
	<yochai@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>,
        Zhiping Zhang
	<zhipingz@meta.com>
Subject: Re: [RFC 0/2] Retrieve tph from dmabuf for PCIe P2P memory access
Date: Mon, 9 Feb 2026 15:28:24 -0800
Message-ID: <20260209232826.3567769-1-zhipingz@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260209181303.GB943673@ziepe.ca>
References: <20260209181303.GB943673@ziepe.ca>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: tQO79kv7D3d1WzxZhdJCGbKMWNzRoCuN
X-Proofpoint-ORIG-GUID: tQO79kv7D3d1WzxZhdJCGbKMWNzRoCuN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA5MDE5OCBTYWx0ZWRfX5wYQ6fVJhDgr
 30FguqhD2zThKQbTVYSCCAnSkbgS4d11ASHacQ36Vuf5yC6B4lpmSze3YRDJXh0Ktv0djrdgU2K
 ObPw2ZGDa2FAwaynoE8nMHy5h+PA1i5UC3+btUCTyskITC5K/pmGwBFKFkY3qH3DsIQpCeBr0Ks
 RFFNJuTmyCv7KvIDQdmFLbf4CUkrG9BB1tvAPvhKtvcWQO1sKKV5obfZefnJN/xzzPE5F7L+pvK
 nZSGH9LcQqqLOh6/jTq8HscrBCzvHaDSorUoOEa/GIuG4XHd5chU/mdKU0eiEc/2YghZDUIdL8y
 i4T6SLk6RdBp/VPBnPFMJx0pEwKFmtaSpuuB9cFF23k7YfffGNNbd1MtlWSSB8oA0ZnkTOUc+A6
 iqnMF+bguDdlaf/hNwfAhX9LljdoDJFc5rP0JbdRrgAMnnXjm46jZt9PgcpMBNJs5uo4MynMkw9
 FFGLSgwbn2S5nofP/EA==
X-Authority-Analysis: v=2.4 cv=UOzQ3Sfy c=1 sm=1 tr=0 ts=698a6dad cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=e5mUnYsNAAAA:8 a=P0N4maTJ8gqIai-TwVIA:9
 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-09_01,2026-02-09_04,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258001-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:mid,meta.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhipingz@meta.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	DKIM_TRACE(0.00)[meta.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 5DF19115642
X-Rspamd-Action: no action

On Mon, Feb 08, 2026 at 10:13:00AM -0800, Jason Gunthor write:

> On Mon, Feb 09, 2026 at 09:53:10AM -0800, Zhiping Zhang wrote:
> > Currently, the steering tag can be used for a CPU on the motherboard;=
 the
> > ACPI check is in place to query and obtain the supported tph settings=
. Here
> > we intend to use the tph info to improve RDMA NIC memory access on a =
vfio-based
> > accelerator device via PCIe peer-to-peer. When an applicantion regist=
er a
> > RDMA memory region with DMABUF for the RDMA NIC to access the device =
memory,
> > the tph associated with the memory region can be retrieved and used t=
o set the
> > steering tag / process hint (ph). The tph contains additional instruc=
tions
> > or hints to the GPU or accelerator device for advanced memory operati=
ons,
> > such as, read cache selection.
> >
> > Note this RFC is for the discussion on the direction and is not inten=
ded to be
> > a complete implementation. Once the direction is agreed on, we will w=
ork on the
> > implementation or a real patch set.
>
> you didn't cc the DRM people who really need to look at any changes to
> the dmabuf contract.
>
> Jason

Thanks, let me submit again including the DRM people via the mailing list
dri-devel@lists.freedesktop.org.

Zhiping



