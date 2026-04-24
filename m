Return-Path: <netdev+bounces-281017-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNQZJh2Y62m7OgAAu9opvQ
	(envelope-from <netdev+bounces-281017-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 18:19:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 120C74613F5
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 18:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8FAA130143C7
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 16:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79AD3E1235;
	Fri, 24 Apr 2026 16:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="j+EbScnJ"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C2C3E123A
	for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 16:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777047576; cv=pass; b=IKtoRRr++FvvoiMbX1+DZDuORgPvNHUSCgUPB6MXcgQGU3iztWUKMoDwPh1yFSOT9/u+JfQT38sP9yQ5PRDameRpuJOW53qL8EnaIsW/cG8E16yIEZNWl57X3zAD7SNWwBgF36DFeW2wYwkdTN2hs+rVL4lOnH5qyexq2btisWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777047576; c=relaxed/simple;
	bh=rYDLTILzoZXXiTETUhnTrI2U/NCHMkY04igp9fZaqJ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eWS25BwJkpokMDa3adR8iCJ8n0qZrj0hAlz1N/cZTEAtmhFRkW9akbDqtszrfD5ZJzqsS3oblI1RCAj31xr2uvpzL9bpf/iC17qKyIacNIYEEmdzoa/pt9NtDlt9T1vXs4FGUSmgzdArpbNTZ4aFvA3+ZGgvMfN/OZyrIBRaxnA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=j+EbScnJ; arc=pass smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0528006.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63O4wZfS4131196
	for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 09:19:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=PPqYNegI9usH9d/38PpPwMxC8ZvnotzcXAblroD5KNw=; b=j+EbScnJplPs
	JdlpwfHp5p/hNnRLiQv/l0tYcEttKh4DPWWuzd1odKdUk8zJZ+y7aLEdlpQ7zRxZ
	nF9uJ9De33AQDXlI2YW+fmyiIIaebUSpQyx7OhLLkSexG0WRsBm4toe6q6DZa8dl
	xXBAVG+zYMps2F1xRr0MH3t0nlmT4xXpk2LRS2mQFG7BDhsEpAVoXUh4I4ANWiay
	fAST4G7bINs9MUXlOvy8XHajgh8HM8FNJV/I70j6Unqh7J2U3W6THKD+Z37eo58Y
	GQQI2svYYkDy1r/JCeDPb13LvKbgE+NIFIXWEA1CmTojV9aGBv+Gj0lCMADlE5bl
	CPm25Bho0w==
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4dpepafg6u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 09:19:32 -0700 (PDT)
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b8f5bce308dso730736366b.1
        for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 09:19:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777047571; cv=none;
        d=google.com; s=arc-20240605;
        b=lleuQOQ/wvKEqhBh56e9t1h/exGv5ctkUjqagEctgkmztkEYCBZyHpdoHRgLSbJCyV
         61soZRHWm39uqdg2jHKGVfl3/2E2YopR9MeQW0Hw+aH0XKaiu7IAxTtlmHRWYflse3Yk
         s7qFsU/NMZw7B4HKmIM6FdQPyBvDJeUT02T+xER+pEZbxDiH91JP+dhPXqNu0w2pfyyL
         0feB+wVpdlJxr1+2EH5RIbWhUCLzZYzepgOK/VzbYlESh0hOkOcLE9JycI3n08gu2+DT
         UrSYU9tjDh6O+QoSQitZJhSOM8/c1HVeRgc0TOl72W8Yu2aM1cLZSSeIjnmfbAff85Tu
         Jj/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=PPqYNegI9usH9d/38PpPwMxC8ZvnotzcXAblroD5KNw=;
        fh=biAuHMD/AD0dQ3R3QzGzmyXNeXgC90wcWbNf3Rs20R0=;
        b=GOzkmMQipNrsMChImsjcXnqFVFToJd8TgSssFJi3IDcLw24eJg4aTSEHXoPhlYh9ki
         VaUJH5kGEyXTCbMLTVSsWUQQUgq8HMcsVi96a2CTjfruFQJrjQAG8yqUAtfz88xulhYN
         mJbKVGfIUIOt1rQj8zBbIuY14AMbriJM2XdZVQ3WNqFq1XuvW/Lji/pB5+5qY0L7vEYy
         c7dzDAq3DQ1BQfA275dIRB8i1nAsbuF5eZ1RhyTw1FgDhzktsxg6l6YD+R5HsI7PtrAW
         3NHrdvjI/SxBpyZmcSccmanDq7cjCz4jaObebO5RQNvxI8ArpVOg/3HVG7E0qdEzPv4u
         iQHQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777047571; x=1777652371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PPqYNegI9usH9d/38PpPwMxC8ZvnotzcXAblroD5KNw=;
        b=WoY0CoZiAJM3hzd/tJuqBS5uGlCC5z6zy/jDsEokaU3iWuuzYqfSL5IGyDI1lKckUU
         x4s2ObOVGLY+OEYTCXrXulh+9CVtEmD6Vr18X5iqMXwIHuxZwCLVS81eVzp+L5q7pnSV
         wBOzfr04Og3N5HcP4AmULR+mUqcI1mE4wzMPKF3hpB7M30KQTPnAeWC34IC4zfcN4lyf
         XDqNAKhhH/b8CsuyNHWucjYYpsIpZGgm0aIjIV2dtmPDOdJ+6AGBTL7FjpwBAXZ6hoLM
         DNU/MuUJouzaVXsHCpqxYDUXPYFAiJzJffiEHyzUEqAm1d/XVwxSxxPsspE8D1DX7f3v
         xE4g==
X-Forwarded-Encrypted: i=1; AFNElJ/Ls62ku5IriyI6J4FKuOKC1yT7u6g+RPVo3oy8RJpyDRyMfm/FHZce/omwTTwRCM6sXel8c4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5t6OE5iUfNIjaYdyAltXAvDEJlYDg9eOZjf4qonXIjrl1R5wM
	inaeg9Yjt8eomVf4+5iDcxRNI1omkhPsC5u0AugSPo4ihwH6f9ONneWUMv7KevUbWXlye9wima4
	y+TmJGWbH9LqSPiw7Smg9BsddVnGoLi2dKvCOXMRjXgt09idclGH4hABqt8bN75vYCTs8/v5yd0
	Wo9SZi8OC8DPCuUmmtlja68stwMfG9+cc=
X-Gm-Gg: AeBDieuvk/F+GReQWLet/Mrx+q0ecQZArFi19OpdIGg1MBGQlBm85KmTQtsQPYad/a5
	L+NG/20wjoUD3NKhqnWMKmUFOlv1rmSXxk4NcLI14Ev4bFpIDr0JIn7eQXriPwrg+ZUGIasxmLi
	IJMWrlu0VgVrfP5d5MQM47LMSEUmOATx4HlDXWkJ7QSRefrDg7WwD8Att0H0/bG6PMDeu1we2od
	NWmEAzhg8yfo4Du
X-Received: by 2002:a17:907:1c96:b0:b87:173f:61b with SMTP id a640c23a62f3a-ba41bacff3fmr1412962866b.9.1777047571258;
        Fri, 24 Apr 2026 09:19:31 -0700 (PDT)
X-Received: by 2002:a17:907:1c96:b0:b87:173f:61b with SMTP id
 a640c23a62f3a-ba41bacff3fmr1412960166b.9.1777047570660; Fri, 24 Apr 2026
 09:19:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421221016.2967924-1-ameryhung@gmail.com> <DI0Z4SJ0TXOA.2N0IY94AF254F@gmail.com>
 <CAMB2axMg=Y5q=9CEFs=8rHLQJipT-5rYkg3wp2BhWgDwVvOUQw@mail.gmail.com> <DI1FPX3685EI.3QPD29NY965FO@gmail.com>
In-Reply-To: <DI1FPX3685EI.3QPD29NY965FO@gmail.com>
From: Amery Hung <ameryhung@meta.com>
Date: Fri, 24 Apr 2026 09:19:19 -0700
X-Gm-Features: AQROBzA5YX-DRt-31x1bYiwHU3hSYgUaI4xAICCiBNdcKd5XFtq986xHrU4yI0s
Message-ID: <CAP17u3MmGy-k06C=COaJqvohk-ghTJ562AE5Cs4LKXL1-pRPSQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 0/9] Refactor verifier object relationship tracking
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        eddyz87@gmail.com, memxor@gmail.com, martin.lau@kernel.org,
        mykyta.yatsenko5@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=VYjH+lp9 c=1 sm=1 tr=0 ts=69eb9814 cx=c_pps
 a=jJvPsHQLKLf2UdvVr97r4g==:117 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=kkcUborcUVj0H7zxAXTl:22
 a=pGLkceISAAAA:8 a=38rVSPPHnL7GY0vxgvQA:9 a=QEXdDO2ut3YA:10
 a=q7aydO1c4wibL4nb3gNS:22
X-Proofpoint-GUID: _xEbwPo1NUB6SY9Em7dkTPqrLveG78mX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDE1OCBTYWx0ZWRfX7FjGGJ3m1rJG
 6fdzNYHuzYLkTxr+lFN11RtQghkTkSd1PjBQQg+wpEV1pC82VsWaNYTyM5xDUgLQmp952QxxLRF
 Zcu0MkbPAeNx74CoDa3bGxv1gqD9/Bbh+aOduzw3PC/0sUWDjNHny08rZLK2rjbqhQf7/z8Yosy
 43jqHbcG8jto9hBlx3TKVrrrv89wj8dJmm9dn6tEE4gKf1FrMQzFY7aZReemg70PQXWSofzjemT
 zeNDas17kbGQ0PUHdeN6kAX7BequqifKHpfvHeIh05XvFZ5T55+93jgii1kQbFHw+h2SFwU6cIa
 rd6PT/GX2ZP3EkKLbQkfLaTVNWvTc/QBNpyYtb3E/6dJjLmiNzJfD//XjLF6T/yaTjOy93A8SmR
 qTC2nDW+zPguABISQH5uniOJTn9cNpqHcOpC1DMD+oYmWpyUvhBZnZYN5pq8CPsFDQ91yl1LI3R
 6FhuuAX4ZagbiE2vuMQ==
X-Proofpoint-ORIG-GUID: _xEbwPo1NUB6SY9Em7dkTPqrLveG78mX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-24_02,2026-04-21_02,2025-10-01_01
X-Rspamd-Queue-Id: 120C74613F5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,kernel.org,iogearbox.net,meta.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-281017-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[meta.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@meta.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]

On Fri, Apr 24, 2026 at 7:03=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu Apr 23, 2026 at 10:44 PM PDT, Amery Hung wrote:
> > On Thu, Apr 23, 2026 at 5:55=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> >>
> >> On Tue Apr 21, 2026 at 3:10 PM PDT, Amery Hung wrote:
> >> >
> >> > (3) Referenced dynptr with referenced parent:
> >> >
> >> >                      file (1,1,0)
> >> >                            ^ ^
> >> >      bpf_dynptr_from_file  | +-------------------------------+
> >> >                            |       bpf_dynptr_clone(A, C)    |
> >> >              dynptr A (2,3,1)                  dynptr C (4,3,1)
> >> >                          ^                                 ^
> >> >                          |                                 |
> >> >                          dynptr A and C have the same lifetime
> >>
> >> If I understand the proposal correctly above should be:
> >>
> >>                      file (1,0,0)
> >>                            ^
> >>      bpf_dynptr_from_file  +-------------------------------+
> >>
> >> ref_obj_id will be inited bpf_dynptr_clone() as 3 into A and C.
> >> but original file->ref_obj_id will be zero.
> >>
> >> ?
> >
> > This is the existing behavior. bpf_get_task_exe_file() is tagged with
> > (KF_ACQUIRE | KF_RET_NULL). Therefore, file will have id and
> > ref_obj_id both initialized to the same value. Here is the
> > corresponding verifier code:
> >
> > if (is_kfunc_acquire(&meta)) {
> >         int id =3D acquire_reference(env, insn_idx);
> >
> >         if (id < 0)
> >                 return id;
> >         if (is_kfunc_ret_null(&meta))
> >                 regs[BPF_REG_0].id =3D id;
> >         regs[BPF_REG_0].ref_obj_id =3D id;
>
> ok, but the arrow should still point to first '1', since that's
> what parent_id inherits?

Ohh yes. I totally missed the error. Thanks for pointing out.

