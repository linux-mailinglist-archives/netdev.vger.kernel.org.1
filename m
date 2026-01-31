Return-Path: <netdev+bounces-255339-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qMtRNRV6fWlDSQIAu9opvQ
	(envelope-from <netdev+bounces-255339-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 04:42:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4255BC0907
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 04:42:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 65275301739F
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 03:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0022B34A76B;
	Sat, 31 Jan 2026 03:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="u+2+N6w3"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2C033439F
	for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 03:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769830927; cv=none; b=YUO9ENb83xqoFm0F7F89KW3MoV65hXGvB/qnuu8YCFGj8FvJvLqg39TFo0UpYb5lSyK9hXwSm2bJAqAsKjg9cTKj3kjGXTE1j3xJ5Aon//aESYR4Q1zRVUiDfle53KuFHt741qx6Ic7b/9vAW9jFiNLWl+na38nc8F5QY6oeVDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769830927; c=relaxed/simple;
	bh=WWQSJ5dEaX6KA13RinvYczKiYBwAZZdrVUHIct1ZIC0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bn/11V9i6O3chuoryUztnRFvQ0vz5BS5Us/iQ8f4dSPBn2xbO0ceV3tiWbtvAX7kRVeh84dWp2RZQiKvlhY9/T47ZhzM9KN3XysbreiAQ1AWHIzsyoevlsfuNnzHhRPKoCbU8o3NjGmFmbKPSH31o3ebHSHTG0UrJyli0/S4DkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=u+2+N6w3; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60UM8K1I3981407
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 19:42:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=s2048-2025-q2; bh=WWQSJ5dEaX6KA13RinvY
	czKiYBwAZZdrVUHIct1ZIC0=; b=u+2+N6w35RCdA9U7dk20mP1r4RY8ZGL7u9TJ
	MQrClz2pWHJDxRdy0Bgrzj0IH04ijVR9wQuGGgEJSHAIGSxaXh6+OLVkR9ijNRKH
	IADpOxZyB6//YbcFFHzRjK/JLMQJL5vBMobZ5YRu9GsMCrks4eDO0wuV4RHj2D6+
	WanbWtrt7BjlJ83gEEvWXi7jqsPbgWD/HZuj5+sR4WHUk7FnZJAL1rN36n2GDZZC
	58hebxWOuR+rEAG2OefQtok9G623QfP12lgEQbWCiHVAKr7fTskMp14ZZ3ejRgiO
	XJpBcDw8TwFnTGelu12qqowLZTZoiGQez15b9xmO6KIWU0kQxg==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4c1561jae0-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 19:42:05 -0800 (PST)
Received: from twshared108366.16.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Sat, 31 Jan 2026 03:41:50 +0000
Received: by devbig010.atn3.facebook.com (Postfix, from userid 224791)
	id 941BA6F28CD; Fri, 30 Jan 2026 19:39:25 -0800 (PST)
Date: Fri, 30 Jan 2026 19:39:25 -0800
From: Daniel Hodges <hodgesd@meta.com>
To: <netdev@vger.kernel.org>, <@fb.com>
CC: <jmaloy@redhat.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
        <tuong.t.lien@dektech.com.au>, <tipc-discussion@lists.sourceforge.net>
Subject: Re: [PATCH 1/3] tipc: use kfree_sensitive() for session key material
Message-ID: <aX15HnlN8B_JOpMC@fb.com>
References: <20260131032508.4158256-1-hodgesd@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260131032508.4158256-1-hodgesd@meta.com>
X-FB-Internal: Safe
X-Authority-Analysis: v=2.4 cv=KfPfcAYD c=1 sm=1 tr=0 ts=697d7a0d cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=Vxa4KF3gbYEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=jJJBXcr-l-UN6h5ZWhYA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMxMDAyOSBTYWx0ZWRfX4NFjWUF+TWYT
 qr1lMRiclg8AOEd6rqjhhXBTQelOLTAW9/rE5/wx/TNBaGUNn/3eQfVQ45ge+0pZzcRGTk/6kTh
 ucHDA65ZkW0F+fkMOAXqSjhJqgnfmEU+BX5hARy7KcvaMck4rDRFJ060ez8lcjlNJF4FLWioPCr
 VOWxFjnsaKhDi1VaLYfNF/7WFqWGPdEMyVhQOgkFGfwAxCGTdzbZS+hFgsEgGomatgTASyeRL4L
 3YZ93mvHzoqbBMw2PByYNoWepiu+pceNNrwOAGeG6esjzfdlryWG7pzz0vmhTwE+reHnkM0j9Ir
 OfZ8agqYJskyY+voBGpeDjhmIBxz0nSKZfMcEzjFjYY+qUIZlPZyXiKmuBwA72DLSNOpw+5fpto
 LV7uYMd5ELCnRlfW44jneFFn6oCQygfMFURtAl1A5YOAbYFMK/rqlWfDtTvqnaL1HlN2CZtZUNu
 i1ndj7zIBBhAr2/gxmA==
X-Proofpoint-GUID: 0icjYOAjinO9vPeeiMfeOPoXU6pyDM54
X-Proofpoint-ORIG-GUID: 0icjYOAjinO9vPeeiMfeOPoXU6pyDM54
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-30_04,2026-01-30_04,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	TO_NEEDS_ENCODING(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255339-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[meta.com:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,fb.com:mid,meta.com:dkim];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NEQ_ENVFROM(0.00)[hodgesd@meta.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 4255BC0907
X-Rspamd-Action: no action

Whoops, this should only be one patch, I messed up when separating this
patch out.

