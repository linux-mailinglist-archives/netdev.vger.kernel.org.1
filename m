Return-Path: <netdev+bounces-253002-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBWRBC0ddGkW2QAAu9opvQ
	(envelope-from <netdev+bounces-253002-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 02:15:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D677BE77
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 02:15:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 91C7B304808A
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 01:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F4D1E834B;
	Sat, 24 Jan 2026 01:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="gb0uiZMy"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9851D6DA9
	for <netdev@vger.kernel.org>; Sat, 24 Jan 2026 01:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769217284; cv=none; b=MI7rZbpmArOdzTcRQh032sS1nhpKv8yJs6udF58I00qV930Z1Ka5G1wHWC3k22KIEt+h3qyKe6wxRRdMYJsJ08+JXFvycRabvA7f0PmFuzP/uJwxrgAPDuBLaIM99E/96VeMHk9bTsSeRd1Vkf/pB0NMiPjhuFa1b+mKm23aq+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769217284; c=relaxed/simple;
	bh=LWbEQ6Qb58mba99fQT7Bo/qzaqprFSHHlGLGlnboiA8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LlZFYAe0+zNS2/CVcVChZ5HUCwRk/H9DPLI9xnQOasIQRB2WUyolHK2qts6FYonfXg3ro4ZYcoACd9v81jX3rF8s8br55fZhUZSDSsPpVE8UGx36Oma0Fwzrrs9f17/EMEBWuPq1FreTv+5l6kFdNFPK14juUcgm+5sQA7YU9D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=gb0uiZMy; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 60NN8D0L2798914
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 17:14:41 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=YdlSP3kPdploWJS5aUMnMwLO0/mqjo3Jlr7WAS5cl7E=; b=gb0uiZMy98B8
	CFSsITssaKCwAC6SVh6xqW/32q1ZrO0ZgEI+xA3QOSDqHzvIl8zovPc0C81FAyw4
	Z0lIdKYOvxXvfSo/E52n+wBO3lktItLxqZNJxeTFkagXBk3Gq0LnumMeb3iOh6Q1
	oXBGvvi5YwJZFXQfNcYnBMQ/RMjyEOqTzTkHu0xZ/vXegWeJobOd0R211do/+i0h
	2f7Ua4zWqN74xmkjvhM1FJUVgQFUvbUig/sFK6S65KE3kH/4BO2U/0TupBOEk73s
	7/YWyICV79oCSncBBrt6Cdg1CrxqrNATF7Cs5qA0nhtabB384HB5sLoYQbuzWE0P
	Tolyr6sfGA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 4bvdcg3va8-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 17:14:41 -0800 (PST)
Received: from twshared26141.04.snb1.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Sat, 24 Jan 2026 01:14:40 +0000
Received: by devbig259.ftw1.facebook.com (Postfix, from userid 664516)
	id D15DAF2FB2F3; Fri, 23 Jan 2026 17:14:36 -0800 (PST)
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
Date: Fri, 23 Jan 2026 17:13:19 -0800
Message-ID: <20260124011436.172058-1-zhipingz@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260113164923.GQ745888@ziepe.ca>
References: <20260113164923.GQ745888@ziepe.ca>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
X-Proofpoint-ORIG-GUID: bg3HlO6JKCdn7FpwL_zBCZWhL_U1ckFa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI0MDAwNyBTYWx0ZWRfX2egofQQhpIF8
 iQWuQj9XnRvp12wE8Kb0QyCEWg/tnLSoIta9YDtUOUR4zaigCieHYqfJPbM5+adHgorg2b5YcSN
 aD8il+K3KA94VHUm4hrTTRZgWWlW2RwIjK4+loBuh1bVuWrb9wfX/0Lilkz78o8ISn88hJPKPRq
 CRNk+NC/BC6Nhazqv95ZTyF1iX7lDmn6AZHPZ8crleIVA8fKxvSxpvlnS89EtFrm0WnocGcCz7N
 0pMZyxNKrtzfrlwZorWEQfrHK1Z+3WWoKUdG9qdZt2pgBZFWfhOWI4FADpWL+eKMwYfcdmSx+Vr
 0IXxN38juP4c47ez8a3WLAx1kyzsoXp7q1+1HiCndVtGpLpCCqMQrkKmkVHG3ztzJE2c1oPUT8s
 muZhov0tBS+XY2KNBj7lk69hTSpGn+24al07fa9yy+V/5JNR0vKkz3gQI2WE8nPa3D6TrpN4dVK
 RS4rmDfsKuSTAzbHvDQ==
X-Authority-Analysis: v=2.4 cv=K88v3iWI c=1 sm=1 tr=0 ts=69741d01 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=zHM-U5WPLxhMletD85EA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: bg3HlO6JKCdn7FpwL_zBCZWhL_U1ckFa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-23_04,2026-01-22_02,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[meta.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253002-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,meta.com:mid,meta.com:dkim];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhipingz@meta.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 91D677BE77
X-Rspamd-Action: no action

On Tue, 13 Jan 2026 12:49:23 -0400, Jason Gunthorpe wrote:

> On Mon, Jan 12, 2026 at 11:43:13PM -0800, Zhiping Zhang wrote:
> > Got it, thanks for pointing out the security concern! To address this=
, I
> > propose that we still pass the TPH value when allocating the dmah, bu=
t we add
> > a verification callback in the reg_mr_dmabuf flow to the dmabuf expor=
ter. This
> > callback will ensure that the TPH value is correctly linked to the ex=
porting
> > device=E2=80=99s MMIO, and only the exporter can authorize the TPH/ta=
g association.

> That still sounds messy because we have to protect CPU memory.

> I think you should not use dmah possibly and make it so the dmabuf
entirely supplies the TPH value.

> Jason

Thanks Jason.

We already have an end-to-end workflow around dmah (perftest =E2=86=92 rd=
ma-core =E2=86=92 kernel)
to carry the TPH hint, across multiple patch sets. References:
  https://github.com/linux-rdma/perftest/commit/98bfb3679a1e71ec96df6a6d6=
c8124ac66ebce25
  https://github.com/linux-rdma/rdma-core/pull/1623/commits
  https://lore.kernel.org/all/cover.1752752567.git.leon@kernel.org/

Given that, I=E2=80=99d like to minimize churn and use the existing dmah-=
based flow, while
addressing the CPU-memory protection concern you raised. Would you be ope=
n to
reconsidering this approach?

Zhiping

