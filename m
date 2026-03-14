Return-Path: <netdev+bounces-267673-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YHixOZP9tGkAvQAAu9opvQ
	(envelope-from <netdev+bounces-267673-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 07:17:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6602E28BDA2
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 07:17:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 12078303CED2
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 06:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0958003D;
	Sat, 14 Mar 2026 06:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="x/BDMSS9"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE23218B0F;
	Sat, 14 Mar 2026 06:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773469068; cv=none; b=uoGaxFuE0GhSDughn2AEHI+EHUEVXavAT/1hFsGxfTARfZG6ZckNkuV7YT1pwtMJ+cHftq5ofbFn0AeEe1gxoS0i+YGJ1qbeRAKYnB6nSqcF5ILY8KQxdeIUykRQ7NynsLbLZPNPOvx3Yl1VGFVxdwYSxIo6fLxVqIs7mwL0jcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773469068; c=relaxed/simple;
	bh=exSq1+nyMdnVYrdoedu76d6IsOt5pNWn9a7vuf+Cq18=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=prsy6iS4zJolPi7Y7HkH8OA3HeuBEo0IqjLTExNWqGOM0fRwaKzl3YlKKdRyT8dj9L2gYpdJDY4fvpxZQ8LCNQXZMFTMTnALwNdZqpfWL2bhRCsxn7YPDWw2Ea0dNhnS4ISIAqDDBQEBjOn2pH6ekQpxcUGwt4NcbyOlezOEf78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=x/BDMSS9; arc=none smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Received: from pps.filterd (m0354652.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62E3x0Lw3051533;
	Sat, 14 Mar 2026 06:17:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=PW0Y12woatit9y13BzrGbqEQrxprAIQiZw7ZpldBc/8=; b=x/BD
	MSS918ZkuLpiKfe8kuTdv1qrkrMzh5t1dfNqaXVYTVLt8vtIlQL0leKr/zwfRY2A
	Qg9q59cxCx4NGs3om3xPqNI8b6nCvdsa04ZuDZ8rceudRMj5gTp5BWc0r8uUVCMP
	SAlP4oKorXpDqTgak8HrZLRFKZABGQtDG/bVM/cuftWirIamm3kVf073ghBr/jiv
	UIpS+TWXFl6zMHNCy7qFuUGEEAdlxK3L1pAYrn/aVfGGXrWxldWHfjW7CpOkPIYZ
	9f1yyo1qraVwxrDAs5wgAERBQhtNeUPuznfeefJLJx13zKsyGEagAZFvIV0qSizT
	YZ7Fu7zhfut0z5XKog==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4cw08eg904-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 14 Mar 2026 06:17:03 +0000 (GMT)
Received: from ML-CTVHTF21DX.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Sat, 14 Mar 2026 06:16:56 +0000
From: Slava Imameev <slava.imameev@crowdstrike.com>
To: <alexei.starovoitov@gmail.com>
CC: <andrii@kernel.org>, <ast@kernel.org>, <bot+bpf-ci@kernel.org>,
        <bpf@vger.kernel.org>, <clm@meta.com>, <daniel@iogearbox.net>,
        <davem@davemloft.net>, <eddyz87@gmail.com>, <edumazet@google.com>,
        <haoluo@google.com>, <horms@kernel.org>, <ihor.solodrai@linux.dev>,
        <john.fastabend@gmail.com>, <jolsa@kernel.org>, <kpsingh@kernel.org>,
        <kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <linux-open-source@crowdstrike.com>,
        <martin.lau@kernel.org>, <martin.lau@linux.dev>,
        <netdev@vger.kernel.org>, <pabeni@redhat.com>, <sdf@fomichev.me>,
        <shuah@kernel.org>, <slava.imameev@crowdstrike.com>, <song@kernel.org>,
        <yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v5 2/2] selftests/bpf: Add trampolines single and multi-level pointer params test coverage
Date: Sat, 14 Mar 2026 17:16:54 +1100
Message-ID: <20260314061654.3858-1-slava.imameev@crowdstrike.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <CAADnVQKcutn9QO4UjfcnPw+Tnv2pmHavXCa-BC083rrgP8w_ng@mail.gmail.com>
References: <CAADnVQKcutn9QO4UjfcnPw+Tnv2pmHavXCa-BC083rrgP8w_ng@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: 04WPEXCH014.crowdstrike.sys (10.100.11.87) To
 04WPEXCH006.crowdstrike.sys (10.100.11.70)
X-Disclaimer: USA
X-Proofpoint-ORIG-GUID: ZMTuJ3E3jwqQugIzRAMkUAe_Ok94aS14
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE0MDA0NiBTYWx0ZWRfX9okSR4b0OCKa
 awFeTYZwiyKmgfIoHONfTvPibTe31XIi944+vaBk53kEIhFK95ngo2YD5BPSPERM7w0xVon+DbB
 I41hupbyIbrZGkm4IgefdlcCEedKbf3MljYhfczuL5ovHy0MqKMLkrnERRHL6dKKkJHH/I3mkGg
 f/w/i8lWHPdmfNT65vbGgfS1HoRAUAitFPX0BXuHTBYT+pDyZb68ZZtAJG6idNCoQhCpOLR4Kkf
 Z2xwztIhCaBLjIvpFEpt0xYLw6EpMXAUnUps78M82HQzOatRwWqTtkUCqUvvCFdv4y0U9rTEfoi
 WQ+CMgKxBtVhmpTFeaIJHrqsQBK+inHacJM7Rb9NA/bAd6vWejCyCFRFm7GOQEKkNLwFlBxDKyr
 cZSU90dxwcGEEWOaOTPeigWKLXQHNZ0slWV2Vd1PBrTQTTiCNfU194aEi7XWTaJEFHe5L90spKL
 Yi9GNv9ETpjhI/b7u3w==
X-Authority-Analysis: v=2.4 cv=fsfRpV4f c=1 sm=1 tr=0 ts=69b4fd5f cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=2KvRFfd_T_-xjmS8C1aD:22 a=VwQbUJbxAAAA:8
 a=DICdAnnu9tm1VdgAv38A:9
X-Proofpoint-GUID: ZMTuJ3E3jwqQugIzRAMkUAe_Ok94aS14
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11728
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 bulkscore=0
 suspectscore=0 spamscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603140046
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[crowdstrike.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[crowdstrike.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,meta.com,iogearbox.net,davemloft.net,gmail.com,google.com,linux.dev,crowdstrike.com,redhat.com,fomichev.me];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-267673-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[slava.imameev@crowdstrike.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[crowdstrike.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	TAGGED_RCPT(0.00)[netdev,bpf-ci];
	DBL_BLOCKED_OPENRESOLVER(0.00)[crowdstrike.com:dkim,crowdstrike.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6602E28BDA2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, 14 Mar 2026 02:42:28 Alexei Starovoitov wrote:
> On Fri, Mar 13, 2026 at 6:55=E2=80=AFAM <bot+bpf-ci@kernel.org> wrote:
> >
> > > diff --git a/tools/testing/selftests/bpf/progs/verifier_ctx_ptr_param.c=
>  b/tools/testing/selftests/bpf/progs/verifier_ctx_ptr_param.c
> > > new file mode 100644
> > > index 000000000000..b507dc850543
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/bpf/progs/verifier_ctx_ptr_param.c
> >
> > [ ... ]
> >
> > > +SEC("fentry/bpf_fentry_test_ppfile")
> > > +__description("fentry/struct file***: struct file *** inferred as scal=
> ar")
> >
> > The description says "struct file ***" (triple pointer), but
> > bpf_fentry_test_ppfile() takes a struct file ** (double pointer):
> >
> > net/bpf/test_run.c:
>     noinline void bpf_fentry_test_ppfile(struct file **ppf)
> >
> > Should the description be
> > "fentry/struct file**: struct file ** inferred as scalar" instead?
> 
> Pls don't ignore bot reviews...
> Do you agree or not?

I'm not ignoring the bot - I'm in Australia and pushed this
patch late at night at 12:05 AM Saturday. The bot replied 50 minutes
later at 12:55 AM Saturday, and I was already not at my desktop.

I will make the necessary changes to the test description. The bot is
correct that it should have been "struct file **" - I mistakenly
carried over the triple pointer description when copy-pasting the
comments.

