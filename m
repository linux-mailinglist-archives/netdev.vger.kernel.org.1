Return-Path: <netdev+bounces-259295-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yLn3HAOYlWk1SgIAu9opvQ
	(envelope-from <netdev+bounces-259295-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 11:44:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 085BB1559B1
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 11:44:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5E325301628A
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 10:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F1D2FF662;
	Wed, 18 Feb 2026 10:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="F/CcDDcT"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB162299A84;
	Wed, 18 Feb 2026 10:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771411455; cv=none; b=DgEISI/o63ModoIVTDOj7Iw864sZMF0Teiue3Vn6CH81RRznAMppu63KbJz2uAz/y3A6so4qJHtrNnsxokhk0M1zB5/Je+SO+uIY2Cxlt1UfieaNvhd3kxI00fAvHumYvPf0qRfQP07PivPW95ueMaLF+Um8w4+W5AnxTV/jYcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771411455; c=relaxed/simple;
	bh=a8HICPT4itUNVb4ozmNp/B0igy5o9dgDPEwOlFdkd/w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bN38VOSPwrRZKOMPifx+cZorKEhA2jOyHUgwNHmv7D/lb7tw21CQczFraKazMzKE2K6WwYjejOSoubK4T7CBx0irVzw7rPL6RKnl5LZkZyIoNI+MfFmXoVnzicwCzbDW0Ck0fOpqUDIb9afjwedmWdbApTvuQlequyw5dy4wkGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=F/CcDDcT; arc=none smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Received: from pps.filterd (m0354653.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61I3X7R72985266;
	Wed, 18 Feb 2026 10:43:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=klMVeU2EoRJtpwl0kImpp5z2CkGr7gsQ7+/yyuwpRuc=; b=F/Cc
	DDcTcR7cBooauPuTB2VdOaKSD4ZS1NCa31B1YwYdH5lk7ug3xhKLBBMZ/G0+GeP4
	WLFMrLeDTEW8LMxJzCP93e1zCFfJzxk//2IU8ALZPvbi4mnNbujcCXuEdmz25FZs
	aRL39L7JmauC+KrqFMhpjR13PUPKf9G9pqEqW/g+ft4cOqCgef9z/CRT4qcgNnJ1
	iHST+EUjMQoKT9/FKNhOvBH/PsjfCaGZAc9QVPSfe/JmAdDm0X+lUGFedzy3lA5h
	y9hgbKPnSmphYXaY1HLb+FuDyYUkXWzSk4j7hh4/tp+JLW5AfZhGNG3LNAa6hSAB
	IuKjLztjNU+5TvuYzA==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4cd06ca947-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Feb 2026 10:43:43 +0000 (GMT)
Received: from ML-CTVHTF21DX.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 18 Feb 2026 10:43:36 +0000
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
Subject: Re: Re: [PATCH bpf-next v2 0/2] bpf: Add multi-level pointer parameter
Date: Wed, 18 Feb 2026 21:43:28 +1100
Message-ID: <20260218104328.14341-1-slava.imameev@crowdstrike.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <bb4bf5fe648ac71c969c6228ac6e72ea85cbc64b.camel@gmail.com>
References: <bb4bf5fe648ac71c969c6228ac6e72ea85cbc64b.camel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: 04WPEXCH011.crowdstrike.sys (10.100.11.81) To
 04WPEXCH006.crowdstrike.sys (10.100.11.70)
X-Disclaimer: USA
X-Authority-Analysis: v=2.4 cv=UfxciaSN c=1 sm=1 tr=0 ts=699597df cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=H0qDomdnsbD56h0TScUA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE4MDA5NSBTYWx0ZWRfX3Srx+ioQsDqV
 0jC/0wPwKQ8mhy+rhGpLVUeYxahxlT1JGdmpydQX/Hc5SfZFb4k695nFbgDP5EAzamAivllSkX2
 LQRsaBEzYEBCqO5bHeGbiWJ1P2IOtvtrzBsXrpxUBGb/1N84urCNFUI9Kn9eC3/CvF4LZPZzUNC
 0XlSoIRhk7nVavpxowcUiIUNXBx8T0CrP9/FSo+pQs7IbRxr3zuJ4jqjX2deRub1d8Bv4s7soY2
 kdcgOpS2sAiE+ndrGnjEtifUviLgTGqzQROV2ljGlrpYa4pF1VJcqwK5PDxjhJG2aDT+cKgMDCf
 4O+paE3PpKHeNxOP/V9Cz9J12hAhChVJZE7iw9yrkrYCxc27giHxINfRHAWkImhB7HaLQw4eoSU
 +iZyc662CB1FxvHd518IDiWA768u074SvSgW/twaV31HL4Ajf3VosqhUHvoLf6C0ZbVpRB63tUX
 YQkgdbA+hY/y1EkBYLw==
X-Proofpoint-GUID: RALuzazVZ2uQ8v73WefunJGodwe9y-dj
X-Proofpoint-ORIG-GUID: RALuzazVZ2uQ8v73WefunJGodwe9y-dj
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11704
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 suspectscore=0 impostorscore=0
 phishscore=0 bulkscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602180095
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[crowdstrike.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[crowdstrike.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,iogearbox.net,davemloft.net,google.com,gmail.com,crowdstrike.com,linux.dev,redhat.com,fomichev.me];
	TAGGED_FROM(0.00)[bounces-259295-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[slava.imameev@crowdstrike.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[crowdstrike.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,crowdstrike.com:mid,crowdstrike.com:dkim]
X-Rspamd-Queue-Id: 085BB1559B1
X-Rspamd-Action: no action

> > The verifier assigns SCALAR type to single-level pointers (void*, int*).
> 
> So, the simplest change for pointers to pointers would be as below, right?
> 
>   --- a/kernel/bpf/btf.c
>   +++ b/kernel/bpf/btf.c
>   @@ -6906,7 +6906,8 @@ bool btf_ctx_access(int off, int size, enum bpf_acc=
ess_type type,
>            * If it's a pointer to void, it's the same as scalar from the ve=
rifier
>            * safety POV. Either way, no futher pointer walking is allowed.
>            */
>   -       if (is_void_or_int_ptr(btf, t))
>   +       if (is_void_or_int_ptr(btf, t) || !is_ptr_to_struct(btf, t))
>                   return true;
> 
>           /* this is a pointer to another type */
> 
> Except that loaded value would be marked as scalar() and one would
> need to cast it using e.g. bpf_core_cast() to obtain an untrusted
> pointer.


I considered using a scalar as a simpler solution, but there are some
disadvantages with casting to scalar and using bpf_core_cast:

 - Casting to scalar removes nullable and trusted properties
 - bpf_core_cast cannot cast to multi-level pointers without
  introducing a new typedef or a wrapper for a pointer

Let's consider the following LSM program which has trusted parameters, and
logs the value for (*mnt_opts):

SEC("lsm/sb_eat_lsm_opts")
int BPF_PROG(sb_eat_lsm_opts_1,char *options, void **mnt_opts)

With this patch:

- This program is valid:

SEC("lsm/sb_eat_lsm_opts")
int BPF_PROG(sb_eat_lsm_opts_1,char *options, void **mnt_opts)
{
    bpf_printk("%p\n", *mnt_opts);
    return 0;
}

- This program is semantically invalid as mnt_opts is a trusted
parameter, so there are no run-time checks and the verifier rejects
out-of-bounds access:

SEC("lsm/sb_eat_lsm_opts")
int BPF_PROG(sb_eat_lsm_opts_1,char *options, void **mnt_opts)
{
    bpf_printk("%p\n", *(mnt_opts+10));
    return 0;
}

With casting to a scalar and following bpf_core_cast:

- This programs cannot be compiled as bpf_core_cast cannot cast to a
multi-level pointer:

SEC("lsm/sb_eat_lsm_opts")
int BPF_PROG(sb_eat_lsm_opts_1,char *options, void **mnt_opts)
{
    void** ppt = bpf_core_cast(mnt_opts, void*);
    bpf_printk("%p\t", *ppt);
    return 0;
}

- There is a workaround, which requires introducing a wrapper for
a pointer or typedef:

struct pvoid {
    void* v;
};

typedef void* pvoid;

SEC("lsm/sb_eat_lsm_opts")
int BPF_PROG(sb_eat_lsm_opts_1,char *options, void **mnt_opts)
{
    struct pvoid* ppt = bpf_core_cast(mnt_opts, struct pvoid);
    bpf_printk("%p\t", ppt->v);
    return 0;
}

SEC("lsm/sb_eat_lsm_opts")
int BPF_PROG(sb_eat_lsm_opts_2,char *options, void **mnt_opts)
{
    pvoid* ppt = bpf_core_cast(mnt_opts, pvoid);
    bpf_printk("%p\t", *ppt);
    return 0;
}

- This program passes verifier, though it is semantically invalid
as logs an invalid data using a trusted parameter:

SEC("lsm/sb_eat_lsm_opts")
int BPF_PROG(sb_eat_lsm_opts_1,char *options, void **mnt_opts)
{
    struct pvoid* ppt = bpf_core_cast(mnt_opts + 10, struct pvoid);
    bpf_printk("%p\t", ppt->v);
    return 0;
}

The similar examples can be done for nullable annotation, which
is ignored for a scalar allowing semantically invalid BPF programs to
pass verifier.

> > For multi-level pointers, I selected PTR_TO_MEM to enable memory access
> > through a single load instruction for the first level of dereference,
> > with subsequent dereferences becoming SCALAR. This design eliminates
> > helper call for parameter dereference, replacing it with a load
> > instruction (e.g., void* ptr =3D *pptr).
> 
> If going this route instead, is there a technical reason to limit this
> logic to multi-level pointers? Applying same rules to `int *` and
> alike seem more consistent.

I decided to address only multilevel pointers as this is what we
encountered in practice and have to use BPF helper workarounds.
I think there are no technical restrictions for treating single
level pointers as PTR_TO_MEM.
However, there is some cohesion between multilevel pointers being
PTR_TO_MEM and single level being scalar, as verifier infers a scalar
for PTR_TO_MEM dereference, so:

foo(void *ptr1, void **pptr)
{
    void* ptr2 = *pptr; /* verifier infers a scalar for ptr2*/
    /* both ptr1 and ptr2 are scalars */
}

