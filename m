Return-Path: <netdev+bounces-248588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B07AD0BFFB
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 20:05:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C6A323007DB0
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 19:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A922DC789;
	Fri,  9 Jan 2026 19:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XPhTTg2l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9304F2D7386
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 19:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767985535; cv=none; b=c0NXcJ9umvNDQVpo/E1Wz4iilklKuKwRLqHNobShk35EkARUXxl/HJA5JGs03o2rvsvs/LDFmvvHQCaPkOd4BdxmFtuZVwbUqPjVQyMwkN5tPUmHQlLs4kKCiWV3KmlJ0TZk1XbUVNqMWHMBt+9u3C+P9z55BndLCbEU1vXmgnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767985535; c=relaxed/simple;
	bh=BpzeoHHYKMmfGrl9VUBSonutC2NLg+BT01AmZyB0hsc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Es4PqWdnquJCAM5AqCAMKsz/IBm0QQQ/ZYmg9nrxkWEKQj6vFqLxF5xLFjEMkNc5jsaWFquBBADUvtRHn4hoaTissWBiEQayZi/5827UMr9QwTomYIzqThhtUBoz+xmUcf93yq+QjKTXRy8tRezmViJAwQlRNYZFJ/X9K4CFZpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XPhTTg2l; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-34f634dbfd6so3072225a91.2
        for <netdev@vger.kernel.org>; Fri, 09 Jan 2026 11:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767985534; x=1768590334; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hk8t+oMn8JgP263Oj/HPzKAFZbYWW++klxyDKEng6ts=;
        b=XPhTTg2lql38cALQhH95sfL10ba0xqzlRl+X21gKh6dLNwi7pM5qU0UeiuWwfBcEbq
         uxD2QUVF2cQsP+F165lu9nGXYmMI7AUCBD5LakC1tdt/V1lbvGsS6ZEKwwKsbozangkJ
         XCJGsqxXoxbXrPkYa9qrMJjt6QH+c+GAd2byZG+ySpIs5V+U5v/roITxmvTWwEhfKc8v
         5+MV6TnHMs7WGT6zd7CEoyOUk4fhB9LTKrSVRvkyGA661UsHOLaTXMcGhgwfvNuDydQG
         +uSRBW5dL+rTp8Lgm1p/2yVYM6+aKitx1IHry1owwqqBscXU1L+fpFP1+dEILTjyG33U
         f4Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767985534; x=1768590334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Hk8t+oMn8JgP263Oj/HPzKAFZbYWW++klxyDKEng6ts=;
        b=Qiou3PwmRDCMIJbi7KiQAM9kBh6K1c2OAmJLkPDoaMM38+5LnS+Gpp/TAcTBLe+EPC
         JIcoA6zynTump3orh54xX188RnLOOEIthhfrH7fr6Kc/fd2BGbMlB30IqyfkllvKOVp4
         eqgqEP13Fiw4mI4OHcKuPPNt9lf1dIDWc40if0qPdTGvT7ip0l6tV6wbzRhNWQnrYaOw
         641wVd0LhnTdhC1hHNHMsQ4sb2D7eP3r13GVkxx/Cp2RSYRGPv9I+9t4YoOiCJFY2BLY
         3wa+WmiV7zFamXuejD/mbx0PldISxikd7jgUoFXp5GtXVUK37VMkkMNNMddAXIx7nM8V
         912A==
X-Forwarded-Encrypted: i=1; AJvYcCVDDPGi1xHGugynZf4dyZtz/9ytvIV8d8Wyzv0ZTYZ4AT3J1XXtNcrr01za6EmI03KERIYoO3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4DYGP3MvmXnx72y9bx9eXrf5MOddUNapbfS11YY1WQy8sL2kG
	OA6F+Kun5CRXlVQIXsN/0hc4/pkZFFv4ZYDG/leW5SovUQ9s560haS1PeojBF5tGfWvvU3iaqKE
	L2Tnj1LkdNbUMculR84c3Dd/i7MbUrhw=
X-Gm-Gg: AY/fxX6JuOMDipia8VKzOolPStgMAlKIc1gj9UdrpgPOBtka4WoGdCwNEY2Upi6cXeC
	FsnPO5+aZmwkA/bHAfTKMbcDCrL58Fw9oApA20wU8r6LnJSDT3DDk5xew50S7xYclUic4vWMQZa
	squ3Zl0YfHU37TzmiV6N39zk0HWwvUBANqXTBoV5r6PgLS6jAlyq2m6TQBx8j3jv1S8q5FYtBzO
	gXFz4WKEj4d2paw92qoC7o9TXmLrIVc/UjZoFAIE7P0mA/u7RqHnRTThAVYHAEvaeWh07wnTkMV
	dhNXA8K1
X-Google-Smtp-Source: AGHT+IEyuSLJhh7+0+zY/kyVGTk70wFqTLuefzbj1VcnRKySBq6TNuMRGO29K84toixf4U3fJmjQ1p4JfyO7Pm51xy4=
X-Received: by 2002:a17:90b:4ece:b0:341:ae23:85fd with SMTP id
 98e67ed59e1d1-34f68c4cde9mr10435722a91.11.1767985533804; Fri, 09 Jan 2026
 11:05:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260104205220.980752-1-contact@arnaud-lcm.com>
 <CAEf4BzYakog+DLSfA6aiHCPW0QHR-=TC8pVi+jDVo27Ljk5uuA@mail.gmail.com>
 <3c22314c-a677-4e59-be51-a807d26e7d33@arnaud-lcm.com> <962121a5-e69a-4c66-b447-6681da0827aa@arnaud-lcm.com>
In-Reply-To: <962121a5-e69a-4c66-b447-6681da0827aa@arnaud-lcm.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 9 Jan 2026 11:05:21 -0800
X-Gm-Features: AQt7F2p47z8xVJ3PzzhAYy00iQWBTTDv15htuV9dlvLkJmV71Goow--c4Sc2Wis
Message-ID: <CAEf4Bza=OwYhe_tSx0FHB8Bjzq9f2j9nWhmdQAraFAKJqGyj2A@mail.gmail.com>
Subject: Re: [PATCH] bpf-next: Prevent out of bound buffer write in __bpf_get_stack
To: "Lecomte, Arnaud" <contact@arnaud-lcm.com>
Cc: syzbot+d1b7fa1092def3628bd7@syzkaller.appspotmail.com, andrii@kernel.org, 
	ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, 
	haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org, 
	kpsingh@kernel.org, linux-kernel@vger.kernel.org, martin.lau@linux.dev, 
	netdev@vger.kernel.org, sdf@fomichev.me, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev, 
	Brahmajit Das <listout@listout.xyz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 7, 2026 at 10:35=E2=80=AFAM Lecomte, Arnaud <contact@arnaud-lcm=
.com> wrote:
>
>
> On 07/01/2026 19:08, Lecomte, Arnaud wrote:
> >
> > On 06/01/2026 01:51, Andrii Nakryiko wrote:
> >> On Sun, Jan 4, 2026 at 12:52=E2=80=AFPM Arnaud Lecomte
> >> <contact@arnaud-lcm.com> wrote:
> >>> Syzkaller reported a KASAN slab-out-of-bounds write in
> >>> __bpf_get_stack()
> >>> during stack trace copying.
> >>>
> >>> The issue occurs when: the callchain entry (stored as a per-cpu
> >>> variable)
> >>> grow between collection and buffer copy, causing it to exceed the
> >>> initially
> >>> calculated buffer size based on max_depth.
> >>>
> >>> The callchain collection intentionally avoids locking for performance
> >>> reasons, but this creates a window where concurrent modifications can
> >>> occur during the copy operation.
> >>>
> >>> To prevent this from happening, we clamp the trace len to the max
> >>> depth initially calculated with the buffer size and the size of
> >>> a trace.
> >>>
> >>> Reported-by: syzbot+d1b7fa1092def3628bd7@syzkaller.appspotmail.com
> >>> Closes:
> >>> https://lore.kernel.org/all/691231dc.a70a0220.22f260.0101.GAE@google.=
com/T/
> >>> Fixes: e17d62fedd10 ("bpf: Refactor stack map trace depth
> >>> calculation into helper function")
> >>> Tested-by: syzbot+d1b7fa1092def3628bd7@syzkaller.appspotmail.com
> >>> Cc: Brahmajit Das <listout@listout.xyz>
> >>> Signed-off-by: Arnaud Lecomte <contact@arnaud-lcm.com>
> >>> ---
> >>> Thanks Brahmajit Das for the initial fix he proposed that I tweaked
> >>> with the correct justification and a better implementation in my
> >>> opinion.
> >>> ---
> >>>   kernel/bpf/stackmap.c | 4 ++--
> >>>   1 file changed, 2 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> >>> index da3d328f5c15..e56752a9a891 100644
> >>> --- a/kernel/bpf/stackmap.c
> >>> +++ b/kernel/bpf/stackmap.c
> >>> @@ -465,7 +465,6 @@ static long __bpf_get_stack(struct pt_regs
> >>> *regs, struct task_struct *task,
> >>>
> >>>          if (trace_in) {
> >>>                  trace =3D trace_in;
> >>> -               trace->nr =3D min_t(u32, trace->nr, max_depth);
> >>>          } else if (kernel && task) {
> >>>                  trace =3D get_callchain_entry_for_task(task, max_dep=
th);
> >>>          } else {
> >>> @@ -479,7 +478,8 @@ static long __bpf_get_stack(struct pt_regs
> >>> *regs, struct task_struct *task,
> >>>                  goto err_fault;
> >>>          }
> >>>
> >>> -       trace_nr =3D trace->nr - skip;
> >>> +       trace_nr =3D min(trace->nr, max_depth);
> >> there is `trace->nr < skip` check right above, should it be moved here
> >> and done against adjusted trace_nr (but before we subtract skip, of
> >> course)?
> > We could indeed be more proactive on the clamping even-though I would
> >  say it does not fundamentally change anything in my opinion.
> > Happy to raise a new rev.
> Nvm, this is not really possible as we are checking that the trace is
> not NULL.
> Moving it above could lead to a NULL dereference.

ok, so what are we doing then?

if (unlikely(!trace)) { ... }

trace_nr =3D min(trace->nr, max_depth);

if (trace->nr < skip) { ... }

trace_nr =3D trace->nr - skip;


(which is what I proposed, or am I still missing why this shouldn't be
done like that?)

pw-bot: cr



> >>> +       trace_nr =3D trace_nr - skip;
> >>>          copy_len =3D trace_nr * elem_size;
> >>>
> >>>          ips =3D trace->ip + skip;
> >>> --
> >>> 2.43.0
> >>>
> > Thanks for the review !
> > Arnaud

