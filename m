Return-Path: <netdev+bounces-159395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0688A156B5
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 19:33:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 261273A19E5
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 18:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4091A23A1;
	Fri, 17 Jan 2025 18:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="khPMctKy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD1D1A0BED
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 18:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737138788; cv=none; b=Qenk1MOlU4YXrGkne4+fsabHDCVg8bLJhPuValTwTLWXgfnzD2jRvd0EVizru1OOnBsTSPDO8rge1T/L719TvzLgzaD/C5LQATKO37/ggmnqIjM4TGk19eu36gMprdjFLEDLJSEY+mL5sN5aDc986cW5IdGd/TU3HMY7QxmkCBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737138788; c=relaxed/simple;
	bh=6CBOkRB6qBd/41Dkwtczu6LnEcyINtBsr65wbYCwx2w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Te+DitFpiWXUPBuDOahd60q8zLkbojaRdQLtCVG9qbZkxrMOb1tM+drt6b+Ke7st9Laq9jyqNw95FvbKC8y+4liif/od5UFB2+HSKwiuTyIN3/oEOpfbln++Y2ZQ4IqVyoSDE8JEfPReJq3DzEzZleowggWw0KaW1yRm/KwubIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=khPMctKy; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3ce7c4115e8so12208105ab.1
        for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 10:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737138784; x=1737743584; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cj5bixpNlO/gi/yB0CEBgSahcL6cuxT5jqyJf8plj7g=;
        b=khPMctKyczaRmXCTe6Bb1oktREPnRZljHyfFxo8uBYhRfAAhcb3zaZZ9x54p1dC7h2
         aDj7vL3NOBcMYYlF7txhCdyLPXiQEDoki9PF/PAW7iMfMUIhES0fJhOsqyFJDiYUFioU
         ewRs3vw95h5b4Uan9k57CSY4DqwV3IHzdUweRIk2CPhhv4Zh2+w7c6HojhHHwgcQN0qp
         0l2GJ//M03hplixtUz1DwIbnVdkdNCJv2n74282keHoKH+Yj/RuPEfwt7+wLD+8ahlOJ
         7FfnOCS6poYSHAJFkA7mVt5RaG/CZTAnaTAtMDyz8PKk+ntLeMmSqJd2ujL0M7ZzAvPl
         T2HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737138784; x=1737743584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cj5bixpNlO/gi/yB0CEBgSahcL6cuxT5jqyJf8plj7g=;
        b=qNa/Ax0ujW6hVegMUjkWZCqrNWj9yvGYAvr3bJEdU21u/F4y/GorWJLaZujShsWqWI
         NXC+j8+jj7p+7h/iiqm51vZyBN/kbl43ER2N02eR4QOcLOoY4DtRvrJFjyqxi3SQ9GzG
         Omk2LO1BGXf3Vc03CTcOzQDjO8zhZwqzGbTaBasggd5sNBUtkQkiOQ3CBYbI5l5okgQA
         t+a1L+BLcF1KaHhMwwWS8q0eI16hVw4Qgtg4bRQrzJ83Fd88wA3n4TY511UoolHB2Wix
         yA81qQwrlR6n4GAW2JI/C8uYWSE/uaNlmkOgtHfDYvKvwNTAIli8e8OLB1ozj2w/CS/j
         4vHw==
X-Gm-Message-State: AOJu0Ywf+F18VnS0ZHMBHNdQxdSCVIxAv12xDczEMIu9R84avAEpSNv5
	x6LhCEhjPNVZ5GfykNHWtZQ+7dKn9YMHRnTdTN/+vTcv3OAPZs3rRxITEshk3TUr1piHXcm+7zv
	N56OaqmbpGG4i9pLYuODQosN3yeM=
X-Gm-Gg: ASbGncvOTcWrSqVHGr3TDxm2sY/TdCCKKEHtyqhJIHiPlittviE/Q8tgkHK2WNlpgk6
	mDZtB854bB+gRA3vfhBA2N9NLdlibfAPy7bMXUpE=
X-Google-Smtp-Source: AGHT+IFOMWPu0Bnlr+kbLFCsHdxqqFWdbbPXszBH2khM7tqJOg0DKveapktfT3XEj04HmdLDjkCZ+IQvDFm3JFhKBwY=
X-Received: by 2002:a05:6e02:218e:b0:3cd:bcbf:1091 with SMTP id
 e9e14a558f8ab-3cf748ba6bcmr26121835ab.10.1737138784565; Fri, 17 Jan 2025
 10:33:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <76c421c64c640f5a5868c439d6be3c6d1548789e.1736951274.git.lucien.xin@gmail.com>
 <741cd05e-e62a-4d72-b85f-ebc627b1e4d3@fiberby.net>
In-Reply-To: <741cd05e-e62a-4d72-b85f-ebc627b1e4d3@fiberby.net>
From: Xin Long <lucien.xin@gmail.com>
Date: Fri, 17 Jan 2025 13:32:53 -0500
X-Gm-Features: AbW1kvZMtIjjz_IsvCoGZhHqlrkbMISBTt8P7KB1egBiUVHM5NjPrNAhxMMpfPs
Message-ID: <CADvbK_fkcw4XkT4zhb0Db5qH9q_yFMWmRgKMrHQvmVH+CMY=7g@mail.gmail.com>
Subject: Re: [PATCH v3 net-next] net: sched: refine software bypass handling
 in tc_run
To: =?UTF-8?B?QXNiasO4cm4gU2xvdGggVMO4bm5lc2Vu?= <ast@fiberby.net>
Cc: network dev <netdev@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, 
	Shuang Li <shuali@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 17, 2025 at 10:08=E2=80=AFAM Asbj=C3=B8rn Sloth T=C3=B8nnesen <=
ast@fiberby.net> wrote:
>
> On 1/15/25 2:27 PM, Xin Long wrote:
> > This patch addresses issues with filter counting in block (tcf_block),
> > particularly for software bypass scenarios, by introducing a more
> > accurate mechanism using useswcnt.
> >
> > [...]
> >    The improvement can be demonstrated using the following script:
> >
> >    # cat insert_tc_rules.sh
> >
> >      tc qdisc add dev ens1f0np0 ingress
> >      for i in $(seq 16); do
> >          taskset -c $i tc -b rules_$i.txt &
> >      done
> >      wait
> >
> >    Each of rules_$i.txt files above includes 100000 tc filter rules to =
a
> >    mlx5 driver NIC ens1f0np0.
> >
> >    Without this patch:
> >
> >    # time sh insert_tc_rules.sh
> >
> >      real    0m50.780s
> >      user    0m23.556s
> >      sys          4m13.032s
> >
> >    With this patch:
> >
> >    # time sh insert_tc_rules.sh
> >
> >      real    0m17.718s
> >      user    0m7.807s
> >      sys     3m45.050s
>
> I assume that you have tested that these numbers are still roughly the sa=
me for v3?
Yup, roughly the same.

>
> > [...]
> >   DEFINE_STATIC_KEY_FALSE(netstamp_needed_key);
> > @@ -4045,10 +4045,13 @@ static int tc_run(struct tcx_entry *entry, stru=
ct sk_buff *skb,
> >       if (!miniq)
> >               return ret;
> >
> > -     if (static_branch_unlikely(&tcf_bypass_check_needed_key)) {
> > -             if (tcf_block_bypass_sw(miniq->block))
> > -                     return ret;
> > -     }
> > +     /* Global bypass */
> > +     if (!static_branch_likely(&tcf_sw_enabled_key))
> > +             return ret;
>
> I have tested with both static_branch_likely() and static_branch_unlikely=
(),
> but my results are inconclusive, I don't see a significant difference in =
my tests,
> but it cases a lot of changes in the object code.
>
> $ diff -Naur <(objdump --no-addresses -d dev_likely.o) \
>               <(objdump --no-addresses -d dev_unlikely.o) | diffstat
>   62 |  156 ++++++++++++++++++++++++++++++++++---------------------------=
-------
>   1 file changed, 79 insertions(+), 77 deletions(-)
>
> > +
> > +     /* Block-wise bypass */
> > +     if (tcf_block_bypass_sw(miniq->block))
> > +             return ret;
> >
> >       tc_skb_cb(skb)->mru =3D 0;
> >       tc_skb_cb(skb)->post_ct =3D false;
> > [...]
>
> When I run the benchmark tests from my original bypass patch last year,
> I don't see any significant differences in the forwarding performance.
> (Xeon D-1518, single 8-core CPU, no parallel rule updates).
>
> Reviewed-by: Asbj=C3=B8rn Sloth T=C3=B8nnesen <ast@fiberby.net>
> Tested-by: Asbj=C3=B8rn Sloth T=C3=B8nnesen <ast@fiberby.net>

