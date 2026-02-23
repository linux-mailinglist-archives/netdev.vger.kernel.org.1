Return-Path: <netdev+bounces-259999-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGNXF44wnGkKAgQAu9opvQ
	(envelope-from <netdev+bounces-259999-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 11:48:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F5C91751DD
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 11:48:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 866AA30266DF
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 10:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D4E3612E2;
	Mon, 23 Feb 2026 10:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="r7i4Wj3i"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8444A35CB60;
	Mon, 23 Feb 2026 10:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771843711; cv=none; b=YQGZPuum7Dfvr2KxmPHFqCIdkPgTuzBNIwA5UZJP3PuAFGEYPlqrL3EqF4Tmlktl1ywezwQoxpW47OfzJNiHiVE3n3qHYP6hxhw8hqbhuRvglJN1dsytSMPhC9Mlxl885clad0HoH9+sczGZRQoUGzg68mf9/7ksc4fgMTqRBDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771843711; c=relaxed/simple;
	bh=B4k9gRkg71PnsXufZ2xYa5mMfTFkRd2QdwpI5OBgPQk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rpD7bPA3C8ednsvs2GvG9PmuUDc9IFH93wwHKh77qXyhK5TtkKBTMKYWhRjtFPeNFwIJtRjaYMpWe/r2zg1Hwl++2JEIhaJQ5ky+Kxf4Tm+O47QEyQFSJ86FZ3ngVepNZgCUoYISAsPx1qRbFZbnVcK1hRFFOIJNpmXumkJK3EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=r7i4Wj3i; arc=none smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Received: from pps.filterd (m0354651.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61N9Ogk0853227;
	Mon, 23 Feb 2026 10:47:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=UVyLOI3z8vWqmLKu0cEzyVJ9p5zsfe+0kMQ3yPY7dlo=; b=r7i4
	Wj3iJztaMll+kb1E3oDWnRm6MlurDnIZeuQ9qX84fMc598gS6ZEU1w7dMGZoZqVJ
	sOsG3kNY4m2O6Lh5n88gURdRUr3qiEV5wnTZuDU/JQVln8DpB1IXRRoYlrdjTwQC
	FCnkV4XNtzA/KBdx4C6IRhLKA9eoKC+aNc0yT5dUDOcaBrEEFK150AgfTjARttgk
	GiLRWH0lbZQ/4ceeS5EoXp3FmPfLIA/bOowbxevpRI8/RK2Sxd4S5xMzr/0RIo/I
	DvaSxCmKv4YL+PdN8uI2awQDpROYhWnYpiPJ3fG/tip/6bFoXvxFQSEp+GVbvssL
	kV2AvfBM9LD1bTVayg==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4cfqxwcake-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Feb 2026 10:47:52 +0000 (GMT)
Received: from ML-CTVHTF21DX.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 23 Feb 2026 10:47:45 +0000
From: Slava Imameev <slava.imameev@crowdstrike.com>
To: <bot+bpf-ci@kernel.org>
CC: <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
        <clm@meta.com>, <daniel@iogearbox.net>, <davem@davemloft.net>,
        <eddyz87@gmail.com>, <edumazet@google.com>, <haoluo@google.com>,
        <horms@kernel.org>, <ihor.solodrai@linux.dev>,
        <john.fastabend@gmail.com>, <jolsa@kernel.org>, <kpsingh@kernel.org>,
        <kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <linux-open-source@crowdstrike.com>,
        <martin.lau@kernel.org>, <martin.lau@linux.dev>,
        <netdev@vger.kernel.org>, <pabeni@redhat.com>, <sdf@fomichev.me>,
        <shuah@kernel.org>, <slava.imameev@crowdstrike.com>, <song@kernel.org>,
        <yonghong.song@linux.dev>
Subject: Re: Re: [PATCH bpf-next v3 1/2] bpf: Support multi-level pointer params via SCALAR_VALUE for trampolines
Date: Mon, 23 Feb 2026 21:47:43 +1100
Message-ID: <20260223104743.37713-1-slava.imameev@crowdstrike.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <692c1f3c4b95e9b8a2bbaf333f4618f1ca1c3cc36fc8b0246b094cd67ed62dbd@mail.kernel.org>
References: <692c1f3c4b95e9b8a2bbaf333f4618f1ca1c3cc36fc8b0246b094cd67ed62dbd@mail.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: 04WPEXCH008.crowdstrike.sys (10.100.11.75) To
 04WPEXCH006.crowdstrike.sys (10.100.11.70)
X-Disclaimer: USA
X-Proofpoint-ORIG-GUID: u83RgyQRo6YQuztzaIMjK3jEhrRMTO4m
X-Authority-Analysis: v=2.4 cv=TJhIilla c=1 sm=1 tr=0 ts=699c3058 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=b3B37AjAgz0HnGB3MuNd:22 a=6Gbh3OEyIFFArXis12EA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDA5MyBTYWx0ZWRfXwY+XXO95NKDb
 5upXSOhNQb8bSY8jYzonOWR8axJ09OYOOGLPBYJJWbP4Wf9PdosW0k2nUnKi2sRY7ihnjVASwdI
 PgGjkbQ9yMXdfyZi8VXugsB3AfoMG4pgt015ly7ZTFF8ccmlSa4NJeu1PrU9qng03H6zNGlnyZm
 sTGVbTVig2NpzmDxH4DwSDit0Ty7Jk/whDFshWZIjpfR4U71if0C3i9mXZAlzF1UMRpGx1NJnyf
 2PXzSR0CeYq3SVDKO7+K14boa5QLzAHvcRIYuAwvPZT+Uwvn9gg3eL3brHk1ZZI0MZGS1wfq/O+
 CRsnLVnSbCgBIbNe5YRQ0E87k2f2pqEaWKbiRfZpkkgVzDw5VSfUT3fwkNyKVU4y7s6QK97gU95
 UOl3FQZiQ6SuahY/shSOHoPFK/vvkeHM33Qxb5ArcsmhpYTfgpHCv8Zp+lfxyD8D/LB+LCGzSat
 GXMAuYCQzQ9OYvOIfhA==
X-Proofpoint-GUID: u83RgyQRo6YQuztzaIMjK3jEhrRMTO4m
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11709
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 adultscore=0 clxscore=1011 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602230093
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[crowdstrike.com,reject];
	R_DKIM_ALLOW(-0.20)[crowdstrike.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-259999-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,meta.com,iogearbox.net,davemloft.net,gmail.com,google.com,linux.dev,crowdstrike.com,redhat.com,fomichev.me];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[crowdstrike.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[28];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[slava.imameev@crowdstrike.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev,bpf-ci];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,crowdstrike.com:mid,crowdstrike.com:dkim]
X-Rspamd-Queue-Id: 3F5C91751DD
X-Rspamd-Action: no action

I think support for broader types can be provided in a compatible way
with future annotated support, as I explained in my reply to the v2
review:

"
  > so I suggest treating 'void **' as a scalar as Eduard suggested.
  > This particular sb_eat_lsm_opts() hook
  > doesn't have a useful type behind it anyway.
  > I'm less certain about 'char **'. If we make it scalar too
  > it will be harder to make it a pointer to nul terminated string later.

  > So I would do 'void **' -> scalar for now only.

  I changed to scalar in v3, keeping broader scope for pointer types.

  We encountered double pointers of various types that required
  workarounds, such as:

  int __posix_acl_chmod(struct posix_acl **acl, gfp_t gfp, umode_t mode)

  Adding support for void** alone doesn't address the broader issue
  with other double pointer types.

  When annotated array support (including char**) is added in the
  future, it should remain compatible with the scalar approach for
  legacy (unannotated) parameters. Unannotated parameters will
  continue using scalar handling.
"

