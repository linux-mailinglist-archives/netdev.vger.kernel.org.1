Return-Path: <netdev+bounces-292733-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qAChFbVUGGoQjQgAu9opvQ
	(envelope-from <netdev+bounces-292733-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 16:44:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E2F5F3DFC
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 16:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 336B830EDEA1
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 14:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC9A3F1648;
	Thu, 28 May 2026 14:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="n2Wr1sUO"
X-Original-To: netdev@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447703B9937
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 14:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779979051; cv=none; b=uTcAl8M8HLA/WW7maBaWFa2MsMq0xgguG4VXAc3FAmSIuSMSswO90PjaQL4sQGG5GNYwedVC9qeNR6LVD115qED0r49V7u8eMX28ddABuazJYKpSMm4gFUsjNetJTQPKXFey3HVeZnct1+kgDrk5REw6oKsuG6M/O+F2sSfotUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779979051; c=relaxed/simple;
	bh=dZTxUiogj1aR3Uf/uHGWoQaxcjeR2QGtvyYDBQdUOac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S31qrz7DYy0ZPY4dLzUgrv/K9tA9uypPkUf85Rk6/P/fgESthIqya+5sCRUlEmviyCGwQxmLFNUKcDbqv2U/SfZm8IylLSAeAdHphC1fjm9vNKXeiVRdsLF9syNnX1QAthUKJhnyNF1RpEuH0tpZIm32RX+AxYRUe9OP/C0Uq/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=n2Wr1sUO; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6083831a-dc6d-42e4-a1c8-8b7f6b966650@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779979038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BvpeIQqkHEsnrCmygdg5gmFmZfNCIRWaXmGR3V8Uu3s=;
	b=n2Wr1sUO3Jaiyc/aAXsK2vEYjliWdOM9bOCPTPYFe9J8ZEkyTNy8hxJWitkq7tkxZd66iu
	SJUfHJmPmDV/vU8EBTDfZ+c/yHx1QUnaL/4Am49NHyj+jqJemLRnp4eX76k6idgHnO9Y4r
	XwMGqpIM2qTuFDl+sn9+sfrQdyhtFOQ=
Date: Thu, 28 May 2026 22:36:57 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/2] bpf: align syscall writeback behavior with
 caller-declared size
To: Yuyang Huang <yuyanghuang@google.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Daniel Borkmann <daniel@iogearbox.net>, bot+bpf-ci@kernel.org,
 Alexei Starovoitov <ast@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Nikolay Aleksandrov <razor@blackwall.org>, Paolo Abeni <pabeni@redhat.com>,
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>,
 Song Liu <song@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 Network Development <netdev@vger.kernel.org>,
 =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>,
 Lorenzo Colitti <lorenzo@google.com>,
 Martin KaFai Lau <martin.lau@kernel.org>, Chris Mason <clm@meta.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>
References: <20260515071504.2054786-2-yuyanghuang@google.com>
 <2e08eb1ca27a9a2f8ad29e1c24f779b579621b0a648589f7044799d91c5e00f5@mail.kernel.org>
 <CADXeF1GVtFHNZJb8xwFh6aadR=H19S+kja8rF185XB5=fg0D0Q@mail.gmail.com>
 <CAADnVQ+42+Th6OFGq2KawzvyKUAykazb4fXh2_uqss-T+R8VCg@mail.gmail.com>
 <CADXeF1F=7RcxAsW38w_mpFeKCLxTAh5p_XYHd=x2Ru+oajoN3Q@mail.gmail.com>
 <34b18a3e-50c0-4b0c-8ee6-d7a291619231@linux.dev>
 <CADXeF1HRe=U7aWx2yx6RFZ_uH-mMbdsxMheofr2tMD9wae46oQ@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CADXeF1HRe=U7aWx2yx6RFZ_uH-mMbdsxMheofr2tMD9wae46oQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,iogearbox.net,kernel.org,lunn.ch,google.com,linux.dev,blackwall.org,redhat.com,fomichev.me,vger.kernel.org,meta.com];
	TAGGED_FROM(0.00)[bounces-292733-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon.hwang@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,bpf-ci];
	RCPT_COUNT_TWELVE(0.00)[30];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: A6E2F5F3DFC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026/5/28 21:20, Yuyang Huang wrote:
> On Thu, May 28, 2026 at 1:43 PM Leon Hwang <leon.hwang@linux.dev> wrote:
>>
>> On 25/5/26 15:21, Yuyang Huang wrote:
>> [...]
>>>
>>> Feel free to let us know your thoughts.
>>>
>> I believe this is a user space issue instead of a kernel bug.
>>
>> I tried to use mmap() memory as uattr that got -EFAULT instead of crash.
>>
>> [................] /* mmap() memory */
>>              ^ tail 40B as uattr
>>                     ^ 56B offset for copy_to_user()
>>
>> Thanks,
>> Leon
>>
> 
> Thanks for testing this!
> 
> There are some discussion in the original thread:
> https://lore.kernel.org/all/CANP3RGfZTXM_u=E_atoomPZXutoQJ02nOMkCCR-YBZbOm2suWA@mail.gmail.com/
> as follows, which might answer your question
> 

It seems you haven't convinced Alexei in that thread.

>>>> If the uattr indeed has less than needed space, then for
>>>>          if (copy_to_user(&uattr->query.revision, &revision, sizeof(revision)))
>>>>                  return -EFAULT;
>>>> the kernel will return -EFAULT to user space.
>>>>
>>>> Maybe userspace didn't handle the return code properly and causing
>>>> user space corruption and segfaults. This shouldn't be a kernel issue.
>>>> Maybe I missed something?
>>>
>>> That's not how that works at all.
>>>
>>> copy_to_user() will only fail and thus EFAULT will only be returned if
>>> the memory area copy_to_user() is trying to copy into isn't
>>> owned/mapped by the user (or perhaps is read-only protected, not sure
>>> about this last one).
>>>
>>> Because memory is mapped in (at least) 4K pages, the memory after a
>>> user buffer is almost always still valid memory.  It might be unused,
>>> or it might be something on the stack - like a return address, or it
>>> might be on the heap - metadata tracking, or a different memory
>>> allocation perhaps entirely.
> 
> You might hit the same case as maze@ mentioned in the thread.
> 
> To trigger -EFAULT, you likely positioned `uattr` at the very end of a
> mapped page immediately followed by a protected page
> 
> Could you share the test program you created so we can verify?
> 

Attached below.

> Please check the test program I shared earlier in the thread (where
> uattr is stored on the stack); the BPF syscall returned 0, but stack
> corruption occurred.
> 

To avoid such stack corruption, you should reserve enough space for the
query, e.g., by extracting union bpf_attr from kernel BTF vmlinux.

Thanks,
Leon

> If you think my test program contains a bug, feel free to let me know.
> 
> Thanks,
> 
> Yuyang

---

Assisted-by: Copilot:gemini-3-1-pro-preview

// SPDX-License-Identifier: GPL-2.0
#include <uapi/linux/if_link.h>
#include <sys/mman.h>
#include <sys/syscall.h>
#include <linux/bpf.h>
#include <net/if.h>
#include <test_progs.h>

#define loopback 1

#include "test_tc_link.skel.h"
#include "tc_helpers.h"

#define SHORT_QUERY_SIZE	offsetofend(union bpf_attr,
query.prog_attach_flags)

/*
 * test_tail_uattr_out_of_mmap:
 *
 * Places uattr at the very tail of a 1-page anonymous mmap so that the
 * mandatory fields (target_ifindex..prog_attach_flags, 40 bytes) fit
inside the page
 * but query.revision (+56) falls in the unmapped page immediately after.
 *
 *   mmap layout (1 page, e.g. 4096 bytes):
 *
 *     [0 ............ page_size - SHORT_QUERY_SIZE - 1]  unused
 *     [page_size - 40 ................. page_size - 1 ]  uattr:
target_ifindex..prog_cnt
 *     [page_size ..................................   ]  UNMAPPED
 *               ^
 *               uattr + 56 (revision) lands here
 */
static void test_tail_uattr_out_of_mmap(void)
{
	long page_size = sysconf(_SC_PAGE_SIZE);
	LIBBPF_OPTS(bpf_prog_attach_opts, opta);
	LIBBPF_OPTS(bpf_prog_detach_opts, optd);
	struct test_tc_link *skel;
	union bpf_attr *attr;
	void *mem, *tail;
	int fd, err;

	skel = test_tc_link__open_and_load();
	if (!ASSERT_OK_PTR(skel, "skel_load"))
		return;

	fd = bpf_program__fd(skel->progs.tc1);

	err = bpf_prog_attach_opts(fd, loopback, BPF_TCX_INGRESS, &opta);
	if (!ASSERT_OK(err, "prog_attach"))
		goto cleanup_skel;

	/*
	 * Allocate 2 contiguous pages then immediately unmap the second one.
	 * This guarantees the page following the first is unmapped, regardless
	 * of what the runtime placed there beforehand.
	 * Place uattr at the tail: last SHORT_QUERY_SIZE (40) bytes of page 1.
	 * uattr + 56 (revision) therefore lands 16 bytes past the page end,
	 * in the unmapped region.
	 */
	mem = mmap(NULL, 2 * page_size, PROT_READ | PROT_WRITE,
		   MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
	if (!ASSERT_OK_PTR(mem, "mmap"))
		goto detach;
	munmap((char *)mem + page_size, page_size);

	tail = (char *)mem + page_size - SHORT_QUERY_SIZE;
	memset(tail, 0, SHORT_QUERY_SIZE);

	attr = (union bpf_attr *)tail;
	attr->query.target_ifindex = loopback;
	attr->query.attach_type = BPF_TCX_INGRESS;

	err = syscall(__NR_bpf, BPF_PROG_QUERY, tail, SHORT_QUERY_SIZE);
	ASSERT_OK(err, "syscall");
	ASSERT_OK(errno, "errno");
	ASSERT_EQ(attr->query.prog_cnt, 1, "prog_cnt_written");

	munmap(mem, page_size);	/* second page already unmapped above */
detach:
	bpf_prog_detach_opts(fd, loopback, BPF_TCX_INGRESS, &optd);
cleanup_skel:
	test_tc_link__destroy(skel);
}

void test_mmap_uattr_corruption(void)
{
	if (test__start_subtest("tail_uattr_out_of_mmap"))
		test_tail_uattr_out_of_mmap();
}


