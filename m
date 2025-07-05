Return-Path: <netdev+bounces-204306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DDEDAFA060
	for <lists+netdev@lfdr.de>; Sat,  5 Jul 2025 16:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 599193B33B3
	for <lists+netdev@lfdr.de>; Sat,  5 Jul 2025 14:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C79192D97;
	Sat,  5 Jul 2025 14:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="Z5JYXROO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E60A17BA1
	for <netdev@vger.kernel.org>; Sat,  5 Jul 2025 14:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751724193; cv=none; b=t7KXb+D7S2ly994t+6IOgUuNFOjCMh8zOcCjaOTGdYfPkdfybjxQJ5xsPmaQdTDfzIUzFGVSLlTXD10INjVQ1GCejnlxE3icSostujFEq/qLnwJ1ZES7E7yN8V6IVNz9RNIehOYh12M3CJsywSg3yKAwOi3oBcqma9ScmwJjjOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751724193; c=relaxed/simple;
	bh=QDoSXmn++2DYZA+XXDJ8e7cbvdCPxr22UuJ2fFIIp64=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jLqj+S0t90nZsw3l4ZIAzdCYsXbe4KcDRgX/irC6ccO7z5FVkZ6K9+xdIwSSH3OdBBpMSv0aePVEyY5fcTCw3oT3M+lp+aMO/wJQs/7GjFGzkmb7rj0Ztf93zoAtGBRNiKAMXT2pT2Rv/7/sAPNYQpOl1e43ftCIjN58Ni3J4qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=Z5JYXROO; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-749068b9b63so977167b3a.0
        for <netdev@vger.kernel.org>; Sat, 05 Jul 2025 07:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1751724191; x=1752328991; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L+BExu2AJZhCqWTRL678knREcLDHHxulZ1eN9KwYoZs=;
        b=Z5JYXROOLdcpYRshi9d2ILhNBfBkd4u/jBptJRcESZclwIkmdhID+tLl7D1ZXObZ7p
         hQjEDtn+PIn+qJHZL2mwFIzrPbP8Emm7RbEyZFV5STnyKJE2z5y9prLaNgI2eCoEx1Hq
         ndV+61E06iYjyWIc82wxp9K3+1ohQ5gccfaGAsV5O8hJQfiR3KNxOgo7lqPzNHIwr6/a
         MrLXfPinRAffdGZgzAko/6g7+dbm3zP2e1gJ4KolYHRxyLxtxb7LcjJqZbjMagCP7rOz
         HRr9bZM+dWrycRaQnjpNoycX9VqXBq8Hvtug6MSRJTN/Q+1ZO4hiZbxFo/BwSS6G9BjU
         GT0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751724191; x=1752328991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L+BExu2AJZhCqWTRL678knREcLDHHxulZ1eN9KwYoZs=;
        b=Aas3OM85GwvdyFlEMmkirx6c/Rmph203piK6FNxCcHadne3Do6PLTPEq7K5fn3LNCC
         7c9wKyC6kDvUYXFSGVU8lxrddATiFKEouB0BZ1C/v6t1fMmovq8RfI/pDfgYYbsaWe/B
         Z6/QvHuv1IGqAHURVq5PLMyPtK4/NnlHFJDW5LvPg4NWXLyEeCclahOiY1TUg2MMBPv7
         cMDaGv1JlSXiTy+ZElpyv7oqqD4B0X/FSqeuXhSKYt48MNiiXwDnvchx6zrvlcgfErVn
         lwcky4dV88yrnE+2pYdl2ftyVFPZSsaXtaIz8/AF7A4UFhFLs/7uq3U6aVSanMIrjzZl
         h1rQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpgVmzxdOj9Y1EXEuc86XKVNKvKR3lBl0vrzNe6aJKPljrEU1B3BcS6aEkApab+m2tHc9Xrxo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4LS8k/qT1EW2WTBe2lTZyqM7kwp6iV/rn/l85Tc9y23anlbYJ
	CyKUIjN2jL5SqiW6ITnXS22UYDo20cAOzCkLUdvMXLASIlXB16yhfLjYaUBnMzWfdjhe1PTtW+p
	G+zUBHnMOIs/BJTBdUr6F+Piaje62Bl+SHvh9sD6z
X-Gm-Gg: ASbGncuAZboNlkIEd9CJyPdfW1n27d4gVMcRvH9wpFhPxy70sTVFP3ze7oER1NeLl3N
	bhxt0f/Ei15D7ecti4vvEnHISm87rh0x6i8gevIKu7ft2f+lMMP7sCbG8LCLGFo5suSt2NVHFlH
	K8E3PC7kQ/gTY1xMpsWOwIWmEXaCYDchD6O0gUx5y3CqEr1jdUFrou
X-Google-Smtp-Source: AGHT+IFbEFi7wKOyacHXcK5qJ340hGGYhfuVJE486BCEI2CXeLafwnsrvYKTLLl4Df+a1PTHSPucNuc6yE1eIV5mLSc=
X-Received: by 2002:a05:6a00:2d96:b0:748:e149:fa89 with SMTP id
 d2e1a72fcca58-74cf6f2fcbcmr3720070b3a.8.1751724191447; Sat, 05 Jul 2025
 07:03:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250704163422.160424-1-victor@mojatatu.com> <aGhpq58BI8mFpCEs@pop-os.localdomain>
In-Reply-To: <aGhpq58BI8mFpCEs@pop-os.localdomain>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sat, 5 Jul 2025 10:03:00 -0400
X-Gm-Features: Ac12FXxiK7JYPJuw8_FABXtMPU7Bkc4OfN6EHnMFbFmoYbWnHt8Xvf1tT2qtoB4
Message-ID: <CAM0EoMkkQc+ZwEyY19oZMo_zuhTR-w2gCYdjhrvReNzcuQs9CQ@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: Abort __tc_modify_qdisc if parent class
 does not exist
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Victor Nogueira <victor@mojatatu.com>, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, edumazet@google.com, jiri@resnulli.us, 
	netdev@vger.kernel.org, pctammela@mojatatu.com, 
	syzbot+d8b58d7b0ad89a678a16@syzkaller.appspotmail.com, 
	syzbot+5eccb463fa89309d8bdc@syzkaller.appspotmail.com, 
	syzbot+1261670bbdefc5485a06@syzkaller.appspotmail.com, 
	syzbot+4dadc5aecf80324d5a51@syzkaller.appspotmail.com, 
	syzbot+15b96fc3aac35468fe77@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 4, 2025 at 7:54=E2=80=AFPM Cong Wang <xiyou.wangcong@gmail.com>=
 wrote:
>
> On Fri, Jul 04, 2025 at 01:34:22PM -0300, Victor Nogueira wrote:
> > Lion's patch [1] revealed an ancient bug in the qdisc API.
> > Whenever a user creates/modifies a qdisc specifying as a parent another
> > qdisc, the qdisc API will, during grafting, detect that the user is
> > not trying to attach to a class and reject. However grafting is
> > performed after qdisc_create (and thus the qdiscs' init callback) is
> > executed. In qdiscs that eventually call qdisc_tree_reduce_backlog
> > during init or change (such as fq, hhf, choke, etc), an issue
> > arises. For example, executing the following commands:
> >
> > sudo tc qdisc add dev lo root handle a: htb default 2
> > sudo tc qdisc add dev lo parent a: handle beef fq
> >
> > Qdiscs such as fq, hhf, choke, etc unconditionally invoke
> > qdisc_tree_reduce_backlog() in their control path init() or change() wh=
ich
> > then causes a failure to find the child class; however, that does not s=
top
> > the unconditional invocation of the assumed child qdisc's qlen_notify w=
ith
> > a null class. All these qdiscs make the assumption that class is non-nu=
ll.
> >
> > The solution is ensure that qdisc_leaf() which looks up the parent
> > class, and is invoked prior to qdisc_create(), should return failure on
> > not finding the class.
> > In this patch, we leverage qdisc_leaf to return ERR_PTRs whenever the
> > parentid doesn't correspond to a class, so that we can detect it
> > earlier on and abort before qdisc_create is called.
> >
>
> Thanks for your quick and excellent catch!
>
> Reviewed-by: Cong Wang <xiyou.wangcong@gmail.com>
>
> Just one additional question, do we still need to safe-guard
> qdisc_tree_reduce_backlog()? Below is actually what pops on my mind
> immediately after reading your above description (before reading your
> code):
>
>
> diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
> index c5e3673aadbe..5a32af623aa4 100644
> --- a/net/sched/sch_api.c
> +++ b/net/sched/sch_api.c
> @@ -817,6 +817,8 @@ void qdisc_tree_reduce_backlog(struct Qdisc *sch, int=
 n, int len)
>                 cops =3D sch->ops->cl_ops;
>                 if (notify && cops->qlen_notify) {
>                         cl =3D cops->find(sch, parentid);
> +                       if (!cl)
> +                               break;
>                         cops->qlen_notify(sch, cl);
>                 }
>                 sch->q.qlen -=3D n;
>

Sorry, meant to respond to this in last email: there's no need for
this extra piece because with the patch posted by Victor this code
will not be hit anymore.

cheers,
jamal

