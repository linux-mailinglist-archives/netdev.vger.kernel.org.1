Return-Path: <netdev+bounces-180072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A85A7F71C
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 09:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1226D173183
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 07:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776681FECDF;
	Tue,  8 Apr 2025 07:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z0rQnJuF"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B3F20A5CA
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 07:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744098922; cv=none; b=f+PbG96DobQy4OGabJ/dNlYStHAtu1dpYOqu+rsrhgfSf6NAkUwG8HJ5i757oS7Pm80S3F00Mx54oe+cMC/x8D+k2p+a0XMoA/I8P33tB9Aldxwi8A0GeAfQNfn7rzomNCZyOoUHT0FHa/z9wHR1pdBvoWsq58A0CwxfPUMmrB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744098922; c=relaxed/simple;
	bh=A8OsWXAueBE0PuEQC4ic4IQiibJGAlkVcpHSS3VZ8iE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QgPA5tkF1NYxytZycUZQJ5Kw/bFOACSHRVVFlR9ZwuICtq9YmKFpfrROdmSIFgUBuAFD19D7F+G39vx+/D1VJkL/SAdhVW0elmmdDaJfaZjRqFjr4ZzqNrfpr464rk883gMstg8mFl1u4YGVSurix6Xj77Q+LGFMH273YzvoDOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z0rQnJuF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744098919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x79QHpIfsA+l7691cd5z+VO+/jgiyth1028qKXbzGKk=;
	b=Z0rQnJuFphvtXmoGngJgvbsRcLH90ZkUew5biWjqFf5XXxpKLyba3UsM+ufRLgWotF7q6r
	DgbMqCqwqeLOv7r3WBFfQTuAQ/Y5Gw6HhRfRskIaONWeqyRfMSvjU7/SUYuzLijj2ALg1q
	7pY55fap6OlgXXftmY4gTsDV9ju0aC8=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-6GESCJWlOOS9Vn1BfyDhbA-1; Tue, 08 Apr 2025 03:55:18 -0400
X-MC-Unique: 6GESCJWlOOS9Vn1BfyDhbA-1
X-Mimecast-MFC-AGG-ID: 6GESCJWlOOS9Vn1BfyDhbA_1744098917
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ac3e0c13278so501905566b.1
        for <netdev@vger.kernel.org>; Tue, 08 Apr 2025 00:55:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744098917; x=1744703717;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x79QHpIfsA+l7691cd5z+VO+/jgiyth1028qKXbzGKk=;
        b=pZALpm6tDt9BJ0F6MLyft8MvgXHsjzJtoo5wlfoOXiTk2IASIBhlTCcnH5VHcigFJJ
         nQ65b/ph42EUnvNMTxQTLFa1G6q4ZWivn5eL9MYHXI7t1+wJ0QLY03pilegw8MJ1yu2i
         06FwedamFMkmwK06WrtXs+feAlYF3ZJZnCknr8jrWLhWjw0zo7OuoSP2dKHFCYihD1AC
         SPNDEYSqpemcAfi7ZuV1vnzx7//7Y2QVeZT7R+f947du04f/97E5eMsf9QjD/7761iJf
         qGcaMdDQux36nDtV2qaYE6wZBcM9cpKITBeTk0a19leK+8IaDCAAssLpzccQ968LLDvC
         jbGA==
X-Forwarded-Encrypted: i=1; AJvYcCUpb3P9MIJYlKDY57h4iE5wJ6EPmZaV8y52mX3D0xf+XAiaU+qsn2YfgXEVirwd4LkI2lLxv+8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqC+j0iaxnbsNto7izT9NCHJPRd+JBFFk3NKmcJrvEs/crrAA/
	0j/+A8qdb82Q37scHU4QFZr2P1PGumEhffBIE0Sox5wP2VsDB9dBVd9fc/N2hbbIvTC1qweVa5f
	Jf5G1QUC7S1jTPKc1I7ngZptGPq1RsMfkQl05EAUmFBdrhZjuKWCRxsv7JjelDWPZptSr3fwr8k
	v8sju9DIy6IOZmmmAFJQX9Q7D9Eb2z
X-Gm-Gg: ASbGnct1km9nLPkvBX/URGCQLLO7+c44KTosdJ8HAnUshXR+wcV9Vw3slS6fCe0goDN
	N3L0UBqnDQTk5nG7V+m9X83rtmb4sWtAkB3IDPlJOwMd745osVefOoJ4/AvhsaaJINhGmei4Nyw
	==
X-Received: by 2002:a17:907:970b:b0:ac6:edd3:e466 with SMTP id a640c23a62f3a-ac7d6d03dc7mr1243224466b.19.1744098916908;
        Tue, 08 Apr 2025 00:55:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsrjWeGBerTieJ+ttyB1gK4msQNk0ahMdt0piWop09SNP4zpG8Otx87xRRHmyaRFy0Bq4LVDJzBGSQoM5E+Po=
X-Received: by 2002:a17:907:970b:b0:ac6:edd3:e466 with SMTP id
 a640c23a62f3a-ac7d6d03dc7mr1243221566b.19.1744098916535; Tue, 08 Apr 2025
 00:55:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250328100359.1306072-1-lulu@redhat.com> <20250328100359.1306072-6-lulu@redhat.com>
 <8c87752e-bffe-4cc0-b838-cb6486b6261d@oracle.com>
In-Reply-To: <8c87752e-bffe-4cc0-b838-cb6486b6261d@oracle.com>
From: Cindy Lu <lulu@redhat.com>
Date: Tue, 8 Apr 2025 15:54:39 +0800
X-Gm-Features: ATxdqUFbbN4Q5UKXqEkcU4pBHlwr8BYd3yOQUAtnTFpNUfmJCvAF1MhDr_dM47Y
Message-ID: <CACLfguWQD5yMBOQLhMh1rt5FoqdfJtmBiHaC3y9g7p1f5q9zRw@mail.gmail.com>
Subject: Re: [PATCH v8 5/8] vhost: Reintroduce kthread mode support in vhost
To: Mike Christie <michael.christie@oracle.com>
Cc: jasowang@redhat.com, mst@redhat.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 8, 2025 at 12:04=E2=80=AFAM Mike Christie
<michael.christie@oracle.com> wrote:
>
> On 3/28/25 5:02 AM, Cindy Lu wrote:
> > +static int vhost_kthread_worker_create(struct vhost_worker *worker,
> > +                                    struct vhost_dev *dev, const char =
*name)
> > +{
> > +     struct task_struct *task;
> > +     u32 id;
> > +     int ret;
> > +
> > +     task =3D kthread_create(vhost_run_work_kthread_list, worker, "%s"=
, name);
> > +     if (IS_ERR(task))
> > +             return PTR_ERR(task);
> > +
> > +     worker->kthread_task =3D task;
> > +     wake_up_process(task);
> > +     ret =3D xa_alloc(&dev->worker_xa, &id, worker, xa_limit_32b, GFP_=
KERNEL);
> > +     if (ret < 0)
> > +             goto stop_worker;
> > +
> > +     ret =3D vhost_attach_task_to_cgroups(worker);
> > +     if (ret)
>
> If you go to stop_worker here, it will leave the worker in the xa above. =
I
> think you need another goto to unwind that.
>
sure, will fix this
Thanks
Cindy
> > +             goto stop_worker;
> > +
> > +     worker->id =3D id;
> > +     return 0;
> > +
> > +stop_worker:
> > +     vhost_kthread_do_stop(worker);
> > +     return ret;
> > +}
> > +
>


