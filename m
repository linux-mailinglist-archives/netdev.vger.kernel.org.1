Return-Path: <netdev+bounces-263448-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WISKL4Rdp2lFhAAAu9opvQ
	(envelope-from <netdev+bounces-263448-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 23:15:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B4F1F7E41
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 23:15:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5E74309D1A5
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 22:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FBF53932F9;
	Tue,  3 Mar 2026 22:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="Ts5oGFUn"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594EF38F623;
	Tue,  3 Mar 2026 22:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772576129; cv=none; b=SOpE+4Iij1VFfiF7YFO8gR72izh0N2FkXoyQ5aE35N1MWUjGIYw67rjTfC2zM25gImUPVhAghZxDs5tRjILrTQs+Y2o12InMqGPDKsrffokF0fMBdydiIiTVpTAJ1v71Nt25h9cZvDuePIw+9dR9oAuahmcAzuM5wg/X+ArPD18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772576129; c=relaxed/simple;
	bh=QaijYxjSr8EJUbeaCpxb3/c9QXYqw5VFbnRiea9FA/w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DPyQzbmxLCgs4An3KnIWl2JvWHZZbZnLw6kQDtLlZH7K3N0BXLrwveXBZo0DYsSMZhH52kqDk9RmmB0vFRsQAYNDo74edunFNOsDubDMhv5fblcrke6Fx2kEAFm3wMaxH1ck4HFVhvWDkfCg29z2k/2LvP0qYfmRmmGpvyW/jCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=Ts5oGFUn; arc=none smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Received: from pps.filterd (m0354654.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 623LX3211526629;
	Tue, 3 Mar 2026 22:14:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=INba+vz/pEEqU6YIqYKF6zfkmqamjdXUfHxqpRL7gI8=; b=Ts5o
	GFUnTbuK/QlLwWgWz4venulPyl0N3ELHFgQvzPzXeU2VlPvk/qVB5VtPe5fc/HQk
	5QqIJQAF/R0w2TGH8p5mE/ZcK23HrEoF1ESbnler+zQ4+u87+3cRS+gvE0AbbiHn
	1lJYt3kycK505TFMvszpdmLwh2cMvbN61kAcjWpFSd9uzNm9wZn+2jNfX0Tqs3gE
	y/o81+h3vfvjjseE2uTfqBZjZ1M05tVga8mvNjaFRExYsFFxH5OtxMEgZLfNNSpC
	coTsFcrnzt+I7Y9fS75ejZA2wdZUH0zBNxxhCe3zUizS15km3DgHdGshRFBTz0K8
	9SdL/oYwjHhkp4mKBw==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4cmb5v3ktp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Mar 2026 22:14:40 +0000 (GMT)
Received: from ML-CTVHTF21DX.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 3 Mar 2026 22:14:32 +0000
From: Slava Imameev <slava.imameev@crowdstrike.com>
To: <eddyz87@gmail.com>
CC: <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
        <daniel@iogearbox.net>, <davem@davemloft.net>, <edumazet@google.com>,
        <haoluo@google.com>, <horms@kernel.org>, <john.fastabend@gmail.com>,
        <jolsa@kernel.org>, <kpsingh@kernel.org>, <kuba@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-open-source@crowdstrike.com>, <martin.lau@linux.dev>,
        <netdev@vger.kernel.org>, <pabeni@redhat.com>, <sdf@fomichev.me>,
        <shuah@kernel.org>, <slava.imameev@crowdstrike.com>, <song@kernel.org>,
        <yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v4 2/2] selftests/bpf: Add trampolines single and multi-level pointer params test coverage
Date: Wed, 4 Mar 2026 09:14:29 +1100
Message-ID: <20260303221429.8585-1-slava.imameev@crowdstrike.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <24dceff5bf15b6c3e204c69617ac249de497b034.camel@gmail.com>
References: <24dceff5bf15b6c3e204c69617ac249de497b034.camel@gmail.com>
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
X-Proofpoint-GUID: k-wVvcbK6eUlPA_9Sl5PxOmCFCNjoj1D
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDE4MiBTYWx0ZWRfX3DZJkFIYZ4tn
 CPHHL3sKXhuxQmHW2c1+tIxZS62pJKiTjSxQbJgqwuPSz2iNr8kauqbyzi8YXnic+bQpi7XSu7X
 lggkBNvT2yAZfGP14P2kkZNrMPqiUpPNglCL4z75PDZoWug7/AP1IVbe0Y5/VGhXyddfuXwOTWG
 DPf+GdTMxf6wsivX8Mwd9l0Wqp1cUq6DgVGC9Cir+YP8aNLe3/bM3RTwrLiJ48Cj0hS7WUdGK0J
 HoVEZnYnJq3rXtojOCheTPAZT0DB/2JOXFoOeLWezuFZJmK0fwwM1/JIujn1xxPbYsIPUdjVMu1
 h8Re7EAhLXGH7Fxn2Qwcf+QgWhLoaEZLXTIUbagAuQeFEGZsyr1EOd/6xVZHPXr2pHrbYgsrVLm
 LN1zgx+B0YP4Te0fo9fNdxFsr94lJLeVr0ZMlQRfFML4I7pcPNuDDZDi2QDmmeGo7eMaR+Exm+X
 WNmCQ9Sf1XDYFXRz4yg==
X-Authority-Analysis: v=2.4 cv=WN1yn3sR c=1 sm=1 tr=0 ts=69a75d50 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=R_n4Uisa8axJ7jemP0ek:22 a=pl6vuDidAAAA:8
 a=MMaJQ1hOdEb4wZLUPJAA:9
X-Proofpoint-ORIG-GUID: k-wVvcbK6eUlPA_9Sl5PxOmCFCNjoj1D
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11718
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 phishscore=0 suspectscore=0 bulkscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603030182
X-Rspamd-Queue-Id: 24B4F1F7E41
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[crowdstrike.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[crowdstrike.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,iogearbox.net,davemloft.net,google.com,gmail.com,crowdstrike.com,linux.dev,redhat.com,fomichev.me];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-263448-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[slava.imameev@crowdstrike.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[crowdstrike.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,crowdstrike.com:dkim,crowdstrike.com:email,crowdstrike.com:mid]
X-Rspamd-Action: no action

On Tue, 03 Mar 2026 12:08:44, Eduard Zingerman wrote:
> On Tue, 2026-03-03 at 20:54 +1100, Slava Imameev wrote:
> > Single and multi-level pointer params and return value test coverage
> > for BPF trampolines:
> > - fentry/fexit programs covering struct and void double/triple
> >   pointer parameters and return values
> > - verifier context tests covering pointers as parameters, these
> >   tests cover single and double pointers to int, enum 32 and 64,
> >   void, function, and double pointers to struct, triple pointers
> >   for void
> > - verifier context tests covering single and double pointers to
> >   float, to check proper error is returned as pointers to float
> >   are not supported
> > - verifier context tests covering pointers as return values
> > - verifier context tests for lsm to check trusted parameters
> >   handling
> > - verifier context tests covering out-of-bound access after cast
> > - verifier BPF helper tests to validate no change in verifier
> >   behavior
> > 
> > Signed-off-by: Slava Imameev <slava.imameev@crowdstrike.com>
> > ---
> 
> Again, I probably miss a point, but with current implementation it
> seems sufficient in verifier_ctx_ptr_param() to add one or two
> tests accessing void** or similar and checking verification log
> to validate that parameter has expected type scalar().
> Why so many tests are necessary?

This reflects my belief in more comprehensive test coverage.

I can certainly reduce the number of tests if this seems excessive,
but I made 90% of the added tests one-liners to keep them maintainable.

These changes add support for multilevel pointers, so double and
triple pointers need to be checked at minimum. I think adding checks
for any new type support is beneficial. I tried to verify a broader
set of conditions that might be broken by future changes. I tried to
make most tests one-liners to facilitate future modification.

