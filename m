Return-Path: <netdev+bounces-102963-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AD56905A4F
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 20:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B20A282583
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 18:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD4B17E8FF;
	Wed, 12 Jun 2024 18:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OvL0fYQ5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0742D613
	for <netdev@vger.kernel.org>; Wed, 12 Jun 2024 18:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718215345; cv=none; b=V3Zz+Ro5gDERmrthLQggcH5V9A8+VSizWRlhG7rPkGsl7PWK42JDtK0pV7ZEMTjFuUFJZ13WNQIrPWEGjde462xHQmnCEK5i9U4CAukr+st0CI9kZJ6uRBiqkva8TCgMx6D3ir9UFvBBuWnf6kQ6qbkt/S3emZ+4utNsjeTUqQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718215345; c=relaxed/simple;
	bh=3uL79Vj/I39QIKPUr5AHehfS4BhbbjILNwjNbnbErTU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IUewnjxYyb+S+WFcOXbovniNtKJBhCHR0k4tQ1o3KsOk4TIbHKvPyC08zRLL9GFI0FQ0mGf0Xbpe0akFxE8pG+75O0tmrr0vKe14TPQvz//3uOdk/v1b34JtJCoWFFniEPhKNfTJ4ciu3I8u5ep/jt94ZtPzvbKpXjj8Oa/EFK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OvL0fYQ5; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2c195eb9af3so67512a91.0
        for <netdev@vger.kernel.org>; Wed, 12 Jun 2024 11:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718215343; x=1718820143; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Ufu0W91jnsNezwewI2l9W+821zBoZ5SoHwqtrU6i9c=;
        b=OvL0fYQ5kgpCFP8wZ9U/eQvjOahAf6up5hvx8ib13wVovTLyhNhJwwdc/eqXNBSgrF
         Wyn6zAiKypf9vGY91RTymZDUtY+qbAxn/YQjDuxNWTl9kfPxRfv0bUnIVgB1nLr+cYdV
         1Ey9Iw3Jm/H+zrGYgdU6CzE1Uu9YiUizRGbxNfW7NIj3GoD8MSZaFlKh+5qgYBydF/ql
         3LUK9Ra45OOWhMZzs7tQn5spj/nzLixRGs6djRlvVmfHDa9q9rFy/i+P04m2p6ONmAXu
         xnWechJxUbUgl09dqv56ooXJ2/XNO262rNkpEdqOeuc5GvB8XCc7BqAWy/v4Ros6e/mN
         Nnaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718215343; x=1718820143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Ufu0W91jnsNezwewI2l9W+821zBoZ5SoHwqtrU6i9c=;
        b=amPDILUb+ug8bpGOOKNRGV1pJJju9e880WVU6pQ4we3+2FEP4K1cFi/2HLNq7nc/qX
         qkWnJMoNe3HsSPT/wO1bwqstZhg8PD/UFA9iA1hbwjDs2bbOZ5RjyJQ9pcYVo1kI48Zj
         f08pVq4lnWWfd6NfzhobqzsfbWAgzSI/eEhrpfS3LUW7WFpSsIt8KR6eKHU16hdswffw
         wqv6X08TkwU1i2Axhxrz0tNlvpveRsgY0XgVNouYyud5BNI/qNPvMCCEn9ivrTJQj6i5
         kONbI5cWOk+letl7jsDb5cvANWcTzM/32rPnLxTbK07eqGEdzAwWy6iLEgeAMqf0J8MK
         s1Eg==
X-Forwarded-Encrypted: i=1; AJvYcCWD1YVHtcLFRBVvKwaWYwSsnLxIP9qax2N/tPhgZIGGz/8mYAIh8zOimjVa/47SBrqMGet9rLhbRHQLXwVdoSV1ByJMTnK4
X-Gm-Message-State: AOJu0Yy43PPAW6gz8zoSDe1iCO8/n2uZ+SzxsqKCBqdPOK6/O3dXvIaH
	tIaXTYky1lTDn2wz1MR5wWLdAkequle5ncG3hn9fDl9g5Q6N8K7wAaI7r5xmLWahkrB7j11Q+h+
	bExaxuy9PoD/e2bffa6E+GUcZT968Ynuj6LyD
X-Google-Smtp-Source: AGHT+IEQwSzrDmLBTYPaHrIuq3cIAvrEiVTrsKcSF+fDe6ObdM1YZpL6g0QOq5B1PpcsbHjvxfYSIj3EXYa3aj1ShS8=
X-Received: by 2002:a17:90a:f197:b0:2c2:7e0e:4cba with SMTP id
 98e67ed59e1d1-2c4a770390cmr2462768a91.49.1718215342412; Wed, 12 Jun 2024
 11:02:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240603184714.3697911-1-joshua.a.hay@intel.com>
 <b30f34a1-48d6-4ff4-b375-d0eef5308261@gmail.com> <cc76768c-d8d4-4c07-93c1-807f3159b573@intel.com>
 <641b439b-2bc0-4f2b-9871-b522e1141cd1@intel.com>
In-Reply-To: <641b439b-2bc0-4f2b-9871-b522e1141cd1@intel.com>
From: David Decotigny <ddecotig@google.com>
Date: Wed, 12 Jun 2024 11:01:46 -0700
Message-ID: <CAG88wWaQaCf1rZAdh-5iWLYWOMfj3o6jtc0J=0_3pPDzP0Cyww@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] idpf: extend tx watchdog timeout
To: Josh Hay <joshua.a.hay@intel.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>, intel-wired-lan@lists.osuosl.org, 
	netdev@vger.kernel.org, Sridhar Samudrala <sridhar.samudrala@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 11:13=E2=80=AFAM Josh Hay <joshua.a.hay@intel.com> =
wrote:
>
>
>
> On 6/11/2024 3:44 AM, Alexander Lobakin wrote:
> > From: David Decotigny <ddecotig@gmail.com>
> > Date: Tue, 4 Jun 2024 16:34:48 -0700
> >
> >>
> >>
> >> On 6/3/2024 11:47 AM, Joshua Hay wrote:
> >>>
> >>> There are several reasons for a TX completion to take longer than usu=
al
> >>> to be written back by HW. For example, the completion for a packet th=
at
> >>> misses a rule will have increased latency. The side effect of these
> >>> variable latencies for any given packet is out of order completions. =
The
> >>> stack sends packet X and Y. If packet X takes longer because of the r=
ule
> >>> miss in the example above, but packet Y hits, it can go on the wire
> >>> immediately. Which also means it can be completed first.  The driver
> >>> will then receive a completion for packet Y before packet X.  The dri=
ver
> >>> will stash the buffers for packet X in a hash table to allow the tx s=
end
> >>> queue descriptors for both packet X and Y to be reused. The driver wi=
ll
> >>> receive the completion for packet X sometime later and have to search
> >>> the hash table for the associated packet.
> >>>
> >>> The driver cleans packets directly on the ring first, i.e. not out of
> >>> order completions since they are to some extent considered "slow(er)
> >>> path". However, certain workloads can increase the frequency of out o=
f
> >>> order completions thus introducing even more latency into the cleanin=
g
> >>> path. Bump up the timeout value to account for these workloads.
> >>>
> >>> Fixes: 0fe45467a104 ("idpf: add create vport and netdev configuration=
")
> >>> Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> >>> Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
> >>> ---
> >>>    drivers/net/ethernet/intel/idpf/idpf_lib.c | 4 ++--
> >>>    1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >>
> >> We tested this patch with our intensive high-performance workloads tha=
t
> >> have been able to reproduce the issue, and it was sufficient to avoid =
tx
> >> timeouts. We also noticed that these longer timeouts are not unusual i=
n
> >> the smartnic space: we see 100s or 50s timeouts for a few NICs, and
> >
> > Example?

a sample:

drivers/net/ethernet/cavium/thunder/nic.h:#define
NICVF_TX_TIMEOUT                (50 * HZ)
drivers/net/ethernet/cavium/thunder/nicvf_main.c:
netdev->watchdog_timeo =3D NICVF_TX_TIMEOUT;
drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h:#define
OTX2_TX_TIMEOUT                (100 * HZ)
drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c:
netdev->watchdog_timeo =3D OTX2_TX_TIMEOUT;
drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c:
netdev->watchdog_timeo =3D OTX2_TX_TIMEOUT;
drivers/net/ethernet/amazon/ena/ena_netdev.c:
netdev->watchdog_timeo =3D msecs_to_jiffies(hints->netdev_wd_timeout);

> >
> >> other NICs receive this timeout as a hint from the fw.
> >>
> >> Reviewed-by: David Decotigny <ddecotig@google.com>
> >
> > We either need to teach watchdog core to account OOOs or there's
> > something really wrong in the driver. For example, how can we then
> > distinguish if > 5 sec delay happened just due to an OOO or due to that
> > something went bad with the HW?
> >
> > Note that there are several patches fixing Tx (incl. timeouts) in my
> > tree, including yours (Joshua's) which you somehow didn't send yet ._.
> > Maybe start from them first?
>
> I believe it was you who specifically asked our team to defer pushing
> any upstream patches while you were working on the XDP series "to avoid
> having to rebase", which was a reasonable request at the time. We also
> had no reason to believe the existing upstream idpf implementation was
> experiencing timeouts (it is being tested by numerous validation teams).
> So there was no urgency to get those patches upstream. Which patches in
> your tree do you believe fix specific timeout situations? It appears you
> pulled in some of the changes from the out-of-tree driver, but those
> were all enhancements. It wasn't until the workload that David mentioned
> was run on the current driver that we had any indication there were
> timeout issues.

Some issues were observed with high cpu/memory/network utilization
workloads such as a SAP HANA benchmark.

>
> >
> > I don't buy 30 seconds, at least for now. Maybe I'm missing something.
> >
> > Nacked-by: Alexander Lobakin <aleksander.lobakin@intel.com>
>
>
> In the process of debugging the newly discovered timeout, our
> architecture team made it clear that 5 seconds is too low for this type
> of device, with a non deterministic pipeline where packets can take a
> number of exception/slow paths. Admittedly, we don't know the exact
> number, so the solution for the time being was to bump it up with a
> comfortable buffer. As we tune things and debug with various workloads,
> we can bring it back down. As David mentioned, there is precedent for an
> extended timeout for smartnics. Why is it suddenly unacceptable for
> Intel's device?
>
> >
> > Thanks,
> > Olek
>
> Thanks,
> Josh
--
David Decotigny
--
David Decotigny

