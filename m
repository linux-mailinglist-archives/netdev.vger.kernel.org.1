Return-Path: <netdev+bounces-68471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB76846FA6
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 13:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A331288EEE
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 12:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCBDB13E215;
	Fri,  2 Feb 2024 12:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="hwDVqkhD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4FA13E20B
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 12:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706875230; cv=none; b=S8TgzLQJ8I/ms3jtdMNHAJ+/Q4KjPlFzd3trnnsVtQOBfj2Ygp2FVvd7PyuKwNrry9qd2hKQYMHjOkHJ02gOl0mGQ6GnNM1xMB7l+eKDU1dZQhP+X3vQzRToaJ7iOuP9NMzBviII4TlptFnCZdJ8BCYDio3Z0sxuihqry/yfWE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706875230; c=relaxed/simple;
	bh=Xr1DXbAvTDaR865LAL/0PwG1Pwk9T4vlzO6plLsxOsI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lpKx7TTehsYBmwcXfSwo8qbUIkPYwMw3xQCKZAXAgzzSm+MLQqjjrtQ6O4Wmg95hvwFJwr4kh3ZV6vEPH5rMtCZpfu0A7GYF1KX1WiDZmn53N8VtvvS8+KdGywvwyohrKJvJOUtAGXi6hhpfDYrxSeqj3JhJTszCq912RU6MRFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=hwDVqkhD; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6041012c81fso20940637b3.0
        for <netdev@vger.kernel.org>; Fri, 02 Feb 2024 04:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1706875227; x=1707480027; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EzLbrSJJ3HMQY02UX2KoRZJkzmC3g7dnGPcxrBeDXSI=;
        b=hwDVqkhDkcKt0ksOQ2MzNGjj8oKqKtGcTEqadeVU3vru9E74WoyVaaKQPqXrBfz4eY
         pbxN7M4oVD1oXc+DwsbbTaX22aQ96b1isN1ntGVKXQlVDVd8pqvpzf4+yG9V8qdMMYiG
         hLqC42AD4wqQdtVGddvF1J2Rnx8YgeZrTqZoVSfcs+s/0uIDTjdb7BBRJyl4QD98hl7H
         ejMNvsNb4/0O4icpqjVW2E1b+/GeBAbwRKpLPAZew8SzMOV8rRYv04A8sxzNsn1AEORj
         jAtExYslHiPP1ke86FsUAfcaYxQgVGB0WPttWLcxY1X58qMwPPIj1Fi09Qs0fvaowMQp
         afqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706875227; x=1707480027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EzLbrSJJ3HMQY02UX2KoRZJkzmC3g7dnGPcxrBeDXSI=;
        b=CdUgjSVrQNr2UAF+exjN/Mz4q5fTrw+P8xHRhgO0R59LVKoKUt2qkSBODW1kySerCL
         ASGHuQgPv9Qcf/aTjL0Ox2/XWyVbGh3LvpddXuXXLDM6Ty5NVIZutUcD0GwcM4e6KgM1
         EKTbEu0sy1ewUZ0rHAJK1I/6Mq24Yy8kgd1BCvYv7ms7EWPro1LsSMAirL6nnEqZh6HP
         +SF/7jJ9D0Mg/suxJWD2yxCvcH8Qpljyz7ZkF96hv24B1LscNE5MsE4c0ijxi6Nt2ytH
         anClAGDMKYiAssX+ZpuOxJpzqFxFu6DjRN5d73JoDenhJdUCUZx5ex2y0ne+RACPwUeE
         CH1A==
X-Gm-Message-State: AOJu0YwHlgpDfDCSq0kbe9caM7OKDBqB68Ga2S04NaY4RWvTkB7sDXQ6
	mapAlmiiJqQQ3gf364k6QtAJGyVMDDpIRoNrMH3UmJQ2+GYuzcvDxAVIpdhCy2mCndipTVTx249
	43H4Ogty03mysSU+Y97hp2Vo4xbBHwDhEQYNQ
X-Google-Smtp-Source: AGHT+IHQ6wzlg9F8HWhoQrUEoJLbXNbanj7A3PlVRUx0Gcct6/Z9FQkJVgMpw7no9GZg5v1QMrcLNSuo1+vtdtEx7A0=
X-Received: by 2002:a25:698b:0:b0:dc6:b974:68cb with SMTP id
 e133-20020a25698b000000b00dc6b97468cbmr5340100ybc.31.1706875226922; Fri, 02
 Feb 2024 04:00:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122194801.152658-1-jhs@mojatatu.com> <20240122194801.152658-3-jhs@mojatatu.com>
 <CALnP8ZaPsOLK-Xc8vkXMO13NT4t52u6PH9v0PcKWX8Yy8gLCXw@mail.gmail.com>
In-Reply-To: <CALnP8ZaPsOLK-Xc8vkXMO13NT4t52u6PH9v0PcKWX8Yy8gLCXw@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 2 Feb 2024 07:00:15 -0500
Message-ID: <CAM0EoMkkQ2tVq7a2ECjkyfWjxLVqvmA2wuN+Su8QUW7TM5tGGQ@mail.gmail.com>
Subject: Re: [PATCH v10 net-next 02/15] net/sched: act_api: increase action
 kind string length
To: Marcelo Ricardo Leitner <mleitner@redhat.com>
Cc: netdev@vger.kernel.org, deb.chatterjee@intel.com, anjali.singhai@intel.com, 
	namrata.limaye@intel.com, tom@sipanda.io, Mahesh.Shirshyad@amd.com, 
	tomasz.osinski@intel.com, jiri@resnulli.us, xiyou.wangcong@gmail.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	vladbu@nvidia.com, horms@kernel.org, khalidm@nvidia.com, toke@redhat.com, 
	mattyk@nvidia.com, daniel@iogearbox.net, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 8:16=E2=80=AFAM Marcelo Ricardo Leitner
<mleitner@redhat.com> wrote:
>
> On Mon, Jan 22, 2024 at 02:47:48PM -0500, Jamal Hadi Salim wrote:
> > @@ -1439,7 +1439,7 @@ tc_action_load_ops(struct net *net, struct nlattr=
 *nla,
> >                       NL_SET_ERR_MSG(extack, "TC action kind must be sp=
ecified");
> >                       return ERR_PTR(err);
> >               }
> > -             if (nla_strscpy(act_name, kind, IFNAMSIZ) < 0) {
> > +             if (nla_strscpy(act_name, kind, ACTNAMSIZ) < 0) {
> >                       NL_SET_ERR_MSG(extack, "TC action name too long")=
;
> >                       return ERR_PTR(err);
> >               }
>
> Subsquent lines here are:
>         } else {
>                 if (strscpy(act_name, "police", IFNAMSIZ) < 0) {
>                                                 ^^^^^^^^
>                         NL_SET_ERR_MSG(extack, "TC action name too long")=
;
>
> I know it won't make a difference in the end but it would be nice to
> keep it consistent.

Agreed. It was an oversight. Will fix it in the next version.
Thanks for the rest of your reviews Marcelo!

cheers,
jamal

