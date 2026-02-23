Return-Path: <netdev+bounces-259937-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IICoL5QQnGna/QMAu9opvQ
	(envelope-from <netdev+bounces-259937-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 09:32:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BEAA17310A
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 09:32:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A0B0530214CB
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 08:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51496346ADC;
	Mon, 23 Feb 2026 08:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="OifF7AcG"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C235C78F26;
	Mon, 23 Feb 2026 08:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771835536; cv=none; b=QOJzetMesSr3SM6J5mevI8MRV61aP7UHUvi7VqzQTZZoCAmwEtKf/BQom7aBifn2wGa8ISVZG6o00R1/1+YBVNGGETwVfjNuaxewQ2rZCpAY1IDvHTDO4ZpHRH6TX3z1674qe9h3x8uLlqHhIvM0vy2S5Hm5+X0yEv3W4KT8M1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771835536; c=relaxed/simple;
	bh=h8x7tfbxgKI3WKCo9c1YmJnbeHPbTwj37yYi3UrYOyQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=psB+fZr3qDxazNQCCDX/J91z1h6gJa0lVDf3WtL2sd1Y+UTJVtEYz2nNkAkly6AajQpXF+L5S8Ggb2g8IgUmzb4gtsjRqc0Xx0tH70kk90GqZ28tOZZAuNAGO9+uT2Xrr0SBrYwiiqfRl8gUEwPAfzcgbuKqow58PRf2zVcbavw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=OifF7AcG; arc=none smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Received: from pps.filterd (m0354653.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61N4TK2I2920332;
	Mon, 23 Feb 2026 08:31:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=default; bh=IS+R75/r6zVVs
	//GfwEhQiq+hDGhL8rSZLwFni8gym8=; b=OifF7AcGxFYCTYfpvjsC+3ucf8/0i
	VjOddNMOcnu7909uBCm6WfpKqOnLGFaeASUiK2wc4F3wITLUbcUVjwH46KBnGug2
	9DOFVac+Qq5ngNUjH/iv3xuw+D+jkHyle9o8r/wlXVXQnYuLi3fv/RhKQIQJloRw
	2PPGGpbLIBtVardFw22ZkwaMTH0Sejh+kEqrDwtTygjpjk+Q18+1wl+EOL9Zc3/c
	94UxeL0toy6M4pjciAREYJ+fnnM5AdK4HCJ/Y44mJyHZwkEGExbtifUufeSJ+Can
	XR6ePj/jcqGdU4Ft+i/V/kkzcXbF7xf++qjll3s4tCsrw/n6ayEJ6xGRQ==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4cfqnjbwhu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Feb 2026 08:31:36 +0000 (GMT)
Received: from ML-CTVHTF21DX.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 23 Feb 2026 08:31:30 +0000
From: Slava Imameev <slava.imameev@crowdstrike.com>
To: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>
CC: <martin.lau@linux.dev>, <eddyz87@gmail.com>, <song@kernel.org>,
        <yonghong.song@linux.dev>, <john.fastabend@gmail.com>,
        <kpsingh@kernel.org>, <sdf@fomichev.me>, <haoluo@google.com>,
        <jolsa@kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
        <shuah@kernel.org>, <linux-kernel@vger.kernel.org>,
        <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <linux-open-source@crowdstrike.com>,
        Slava Imameev
	<slava.imameev@crowdstrike.com>
Subject: [PATCH bpf-next v3 0/2] bpf: Add multi-level pointer parameter support for trampolines
Date: Mon, 23 Feb 2026 19:31:18 +1100
Message-ID: <20260223083120.23776-1-slava.imameev@crowdstrike.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: 04WPEXCH005.crowdstrike.sys (10.100.11.69) To
 04WPEXCH006.crowdstrike.sys (10.100.11.70)
X-Disclaimer: USA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDA3NSBTYWx0ZWRfX3Jw7IsgGuYka
 0aUQOncboiDOTglH+7el1f1QSZ0xITZryLzuv0zfeR5eQec+xY0r9XbQHGa8GB9JvWo6IFw91L5
 XboFwPQwrjgR6x76w5U61h0PCSEWZc/tSrGJollbm0EP20L/Ak7/E6G7rjAoCyKVWcLJMlLul+I
 Qjc/eJLDVrdONxBCemsiXdTynqroGDLpCTycc88kSJ28NMVLKx5RzuHcU4pMX32eo3NU2Xm/Vcd
 qHV3F51F9iI9Spt90FrAwpoZ41cKxX9VWqRfk95S7cqXCons9ZRYFoto9283mzilvgEyP4EK2+y
 me746vvG+HL/lvEJdjo9P6djhdfHpRymk6s+YrlEbrOqAQSk61IQrD1R3648T0gViLrAkYwcbSL
 HsfB+U+EwPDKkXaLfr8qerrrNda4rRFtCVva4y30clFOCAPVQpXaYGvrRcdXb6Nw1z7moIhUKeb
 eSZZ8HeSwVgtSy1JvGA==
X-Proofpoint-ORIG-GUID: HOfpB4wLN6QKWG72Qf0YFbVc83U4v_mt
X-Authority-Analysis: v=2.4 cv=UoJu9uwB c=1 sm=1 tr=0 ts=699c1068 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=GCXdLZfFv8EKBZhKOxZ5:22 a=VwQbUJbxAAAA:8
 a=QyXUC8HyAAAA:8 a=JRLApV_pkuiehV_KFgYA:9
X-Proofpoint-GUID: HOfpB4wLN6QKWG72Qf0YFbVc83U4v_mt
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11709
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 adultscore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602230075
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[crowdstrike.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[crowdstrike.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.dev,gmail.com,kernel.org,fomichev.me,google.com,davemloft.net,redhat.com,vger.kernel.org,crowdstrike.com];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-259937-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[slava.imameev@crowdstrike.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[crowdstrike.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,crowdstrike.com:mid,crowdstrike.com:dkim]
X-Rspamd-Queue-Id: 6BEAA17310A
X-Rspamd-Action: no action

This patch adds BPF verifier support for multi-level pointer parameters
and return values in BPF trampolines. The implementation treats these
parameters as SCALAR_VALUE.

Background:

Prior to these changes, accessing multi-level pointer parameters or
return values through BPF trampoline context arrays resulted in
verification failures in btf_ctx_access, producing errors such as:

func '%s' arg%d type %s is not a struct

For example, consider a BPF program that logs an input parameter of type
struct posix_acl **:

SEC("fentry/__posix_acl_chmod")
int BPF_PROG(trace_posix_acl_chmod, struct posix_acl **ppacl, gfp_t gfp,
             umode_t mode)
{
    bpf_printk("__posix_acl_chmod ppacl = %px\n", ppacl);
    return 0;
}

This program failed BPF verification with the following error:

libbpf: prog 'trace_posix_acl_chmod': -- BEGIN PROG LOAD LOG --
0: R1=ctx() R10=fp0
; int BPF_PROG(trace_posix_acl_chmod, struct posix_acl **ppacl,
gfp_t gfp, umode_t mode) @ posix_acl_monitor.bpf.c:23
0: (79) r6 = *(u64 *)(r1 +16)         ; R1=ctx() R6_w=scalar()
1: (79) r1 = *(u64 *)(r1 +0)
func '__posix_acl_chmod' arg0 type PTR is not a struct
invalid bpf_context access off=0 size=8
processed 2 insns (limit 1000000) max_states_per_insn 0 total_states 0
peak_states 0 mark_read 0
-- END PROG LOAD LOG --

The common workaround involved using helper functions to fetch parameter
values by passing the address of the context array entry:

SEC("fentry/__posix_acl_chmod")
int BPF_PROG(trace_posix_acl_chmod, struct posix_acl **ppacl, gfp_t gfp,
             umode_t mode)
{
    struct posix_acl **pp;
    bpf_probe_read_kernel(&pp, sizeof(ppacl), &ctx[0]);
    bpf_printk("__posix_acl_chmod %px\n", pp);
    return 0;
}

This approach introduced helper call overhead and created inconsistency
with parameter access patterns.

Improvements:

With this patch, trampoline programs can directly access multi-level
pointer parameters, eliminating helper call overhead and explicit ctx
access while ensuring consistent parameter handling. For example, the
following ctx access with a helper call:

SEC("fentry/__posix_acl_chmod")
int BPF_PROG(trace_posix_acl_chmod, struct posix_acl **ppacl, gfp_t gfp,
             umode_t mode)
{
    struct posix_acl **pp;
    bpf_probe_read_kernel(&pp, sizeof(pp), &ctx[0]);
    bpf_printk("__posix_acl_chmod %px\n", pp);
    ...
}

is replaced by a load instruction:

SEC("fentry/__posix_acl_chmod")
int BPF_PROG(trace_posix_acl_chmod, struct posix_acl **ppacl, gfp_t gfp,
             umode_t mode)
{
    bpf_printk("__posix_acl_chmod %px\n", ppacl);
    ...
}

The bpf_core_cast macro can be used for deeper level dereferences,
as illustrated in the tests added by this patch.

v1 -> v2:
* corrected maintainer's email
v2 -> v3:
* Addressed reviewers feedback:
	* Changed the register type from PTR_TO_MEM to SCALAR_VALUE.
	* Modified tests to accommodate SCALAR_VALUE handling.
* Fixed a compilation error for loongarch
	* https://lore.kernel.org/oe-kbuild-all/202602181710.tEK6nOl6-lkp@intel.com/
* Addressed AI bot review
	* Added a commentary to address a NULL pointer case
	* Removed WARN_ON
	* Fixed a commentary

Slava Imameev (2):
  bpf: Support multi-level pointer params via SCALAR_VALUE for
    trampolines
  selftests/bpf: Add trampolines multi-level pointer params test
    coverage

 kernel/bpf/btf.c                              |  20 +-
 net/bpf/test_run.c                            | 130 ++++++
 .../prog_tests/fentry_fexit_multi_level_ptr.c | 206 +++++++++
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../progs/fentry_fexit_pptr_nullable_test.c   |  56 +++
 .../bpf/progs/fentry_fexit_pptr_test.c        |  67 +++
 .../bpf/progs/fentry_fexit_void_ppptr_test.c  |  38 ++
 .../bpf/progs/fentry_fexit_void_pptr_test.c   |  71 +++
 .../bpf/progs/verifier_ctx_multilevel_ptr.c   | 435 ++++++++++++++++++
 9 files changed, 1024 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/fentry_fexit_multi_level_ptr.c
 create mode 100644 tools/testing/selftests/bpf/progs/fentry_fexit_pptr_nullable_test.c
 create mode 100644 tools/testing/selftests/bpf/progs/fentry_fexit_pptr_test.c
 create mode 100644 tools/testing/selftests/bpf/progs/fentry_fexit_void_ppptr_test.c
 create mode 100644 tools/testing/selftests/bpf/progs/fentry_fexit_void_pptr_test.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_ctx_multilevel_ptr.c

-- 
2.34.1


