Return-Path: <netdev+bounces-255482-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UKZVBIBBfmmkWgIAu9opvQ
	(envelope-from <netdev+bounces-255482-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 18:53:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 96864C36BF
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 18:53:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C116A30041D8
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 17:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0BA7363C4E;
	Sat, 31 Jan 2026 17:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="IcWPSRoP"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56899363C51
	for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 17:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769881980; cv=none; b=I7k290gAdyYWlLHtOn+4ZdpbaSGK7xB+0QXojO69wiidLrcttbsQkDPrVwybyUqd36oz3whJB/jKRSv6SMY+6fLWIIoYMcS6g1KTjkTDWWuYFN9pSn1PtvZk2j0OYdNafmLhBxxy7wInBIcBJ205EXKJ7aOFmB4G6O70wjtgiSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769881980; c=relaxed/simple;
	bh=miKWW8d2LJfgdS9VQEaNuueadZBWw2ukzH0t9AVynTQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CyBcWeHjp91312PfvtOXMPmjnz141URWFo0E5LFUmiuampKTqHgVO5n8OzQvVhLGd2gPgXytyX5/DgXRpH95ST0ur8/bUsI/flZ3Ke4yRmdVJKD1f9T/qDG+8zYFk+6onXQVXfyVGb8JO4irfshhT3YOHtcY7pGdXCtka8bwSKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=IcWPSRoP; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 60V8Th1K3718002
	for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 09:52:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=s2048-2025-q2; bh=jfLGiZdEDq9koZwqQ96D
	avFD3c2jFvtmRmUa+PhngTk=; b=IcWPSRoPhf4NkA7z/FyRlPTYzLeomWCzXvU2
	KE1KZkgNptbI4PqaXisUjfPr2rqhWdVVqcF1mQHLIvhnyIPRpYkc8Rl9GjzkJfWV
	N8WwWR8IRha81vXZUcl1q82o3xUJ8QS8PdzEbcEztjH2x0ZbfEmaH/ME0p+xGSw0
	YKh6qIWI715y9It+M4E/gq33Tlty2c7Avrq+lo/gXGxVqRMWistkD7/FlqBm89k3
	IkYPfeafX7cMUuctikan/JnepfesVNUmh3nXBUhjNZD0zzW/42tuMOGfZmgYudTy
	/xHZcHsIKtqYnLnUXrScDmqGVsU23plenwKCOb01y/unh8kGyQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 4c1e9bjq09-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 09:52:58 -0800 (PST)
Received: from twshared18017.01.snb2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Sat, 31 Jan 2026 17:52:56 +0000
Received: by devbig010.atn3.facebook.com (Postfix, from userid 224791)
	id C8A27747EC7; Sat, 31 Jan 2026 09:52:41 -0800 (PST)
Date: Sat, 31 Jan 2026 09:52:41 -0800
From: Daniel Hodges <hodgesd@meta.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, "<?@fb.com>," <jmaloy@redhat.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <horms@kernel.org>, <tuong.t.lien@dektech.com.au>,
        <tipc-discussion@lists.sourceforge.net>
Subject: Re: [PATCH 1/3] tipc: use kfree_sensitive() for session key material
Message-ID: <aX5BT6dFQfLYwPu7@fb.com>
References: <20260131032508.4158256-1-hodgesd@meta.com>
 <aX15HnlN8B_JOpMC@fb.com>
 <20260131090815.73ae7b09@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260131090815.73ae7b09@kernel.org>
X-FB-Internal: Safe
X-Proofpoint-ORIG-GUID: GeNP_a4miQO6CT15NaHSgQR-IzBHygDJ
X-Authority-Analysis: v=2.4 cv=fJE0HJae c=1 sm=1 tr=0 ts=697e417a cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=GCo0v8ZjgIh_7kVUb54A:9 a=CjuIK1q_8ugA:10 a=QYH75iMubAgA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMxMDE1MCBTYWx0ZWRfX2Zx1RXwJkUfV
 PPNmof7195nRF/GFzSTPszBs5WBwa1eyfY5GoGq189Y8FMCPyyz32c3vzn91t5Ayv42kQFVG0LH
 sNZRt3rEanns55nsWvYS7h3BDaKHvyph0atKoRGFOFfByhBdWVZ3tPrDUG2G25gQZm0Y1aIPqD7
 8i+/+0WiVHHZugJjuBdR0ZZZn4aHxqcRRnVbOccff3DsBhxVVo4dW5M/EW23B4FZZmFtHvx3WXy
 nsQrPgcU8hkgP63597+BzVLj6d49WM78XZyUnOqh4lF3qzITTebRn4P8lJElu01dMEUZjstl2aE
 GxOSNYaz5NOqIGWxAHqTOleuuwVLqKSCpwvHkhrKXy5g/6M1MFOiDFHvMYkooljQGcLYQyKIjtr
 xW+6DiN+GNln5vZcTd6mgi5ItilPKzxVkOlkvGdvAxUD3aIQrYpMq9tMUtCVQUzgi77WeAcqjqU
 tLk+aGOIgjj6BNVtluQ==
X-Proofpoint-GUID: GeNP_a4miQO6CT15NaHSgQR-IzBHygDJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-31_03,2026-01-30_04,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[meta.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255482-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,meta.com:dkim];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hodgesd@meta.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 96864C36BF
X-Rspamd-Action: no action

On Sat, Jan 31, 2026 at 09:08:15AM -0800, Jakub Kicinski wrote:
> On Fri, 30 Jan 2026 19:39:25 -0800 Daniel Hodges wrote:
> > Whoops, this should only be one patch, I messed up when separating this
> > patch out.
> 
> You'll need to resend, unfortunately, patchwork will wait for 
> the "other two patches" forever and never kick off our CI :(
> 
Sounds good, sorry about that!

