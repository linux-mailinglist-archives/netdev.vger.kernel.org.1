Return-Path: <netdev+bounces-154668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 258339FF5B9
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 04:19:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3ABC16160C
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 03:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F13B67A;
	Thu,  2 Jan 2025 03:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J1y594Y+"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60171364D6
	for <netdev@vger.kernel.org>; Thu,  2 Jan 2025 03:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735787991; cv=none; b=RSu9EHloDV/Km9EvUOWunp3D+o4ChusIcSUpuJ7vzyMxa5Zvb0e8Cgv9jB2L+ApgvCd+/9gGAoYTfXJika2ln+erVzt2P2ZxEh7LgI2B41hCN26VRVQSOk83FBBFq/1KiCimdkz658RshCS7FkAA1wVxwgR1rbA0qCT0fzLxBx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735787991; c=relaxed/simple;
	bh=3txRQoi5B8Te3HvxcxTp/mam15GzErL1GLMNrJqkTGQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sFmeYhZmiwfPLohw/SRZJgwh2JLVeE2ftRDFPzSLJNUC4JUikn0TRtt7IivAfVQUz1yreoFXsSh2jVjfGhpdMfKKqQ6Qxj0K1Ss6B9hsduSbQZqKQ8aDMj+Fz55tx56GqZ1szLrL3uX7+eTY93WZiUUf85slbaREFL8fUC409Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J1y594Y+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735787988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a/DoRCQMoCvL0YhMS7oyxFy6iN1qrB1b7j/dmge1dCs=;
	b=J1y594Y+lSHJIwBZanlY9JBnpN79Y/MKlT2tehJQM3+NFWE8TkN16rfUpcvtmn6bVJMZ70
	id6wMyz+3Qv2+D2GhfL1FA4QjUe6ROjgariTmn1lWnBHgP15ny64zjNoY03prdB6ySxIz1
	HGVliH4ti30X+zdgChztzoUykVvUjyk=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-3jhUYbKzO8egf90roDoPAA-1; Wed, 01 Jan 2025 22:19:46 -0500
X-MC-Unique: 3jhUYbKzO8egf90roDoPAA-1
X-Mimecast-MFC-AGG-ID: 3jhUYbKzO8egf90roDoPAA
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2efa74481fdso15409940a91.1
        for <netdev@vger.kernel.org>; Wed, 01 Jan 2025 19:19:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735787986; x=1736392786;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a/DoRCQMoCvL0YhMS7oyxFy6iN1qrB1b7j/dmge1dCs=;
        b=TsvvynYKLQ0mesKg63HCCUJtsli/SsMVfSS/nJnxiXsV/XzTBCkd+bsXZCAkxR7X8K
         FoKlVIBwWPc9evIdLfLbltWRafT6KE1R805y/gBM2ouYGIJtcsfdrnnulpizzjda4KMw
         AJa/VTwPV7Q1MqZ+yh59aWM3o9YloV6hYstFIu9+FSpHk5JU9DnXCKV38mG0x2bpQkgk
         /DhPaJN2tbgG1Fs6UVvUFuxmZczKJCSHvRWQIXu91Z9UNVJFV4uma4BUDw5hxgTRp3pC
         pzAlMS1Pk8XJXzkpXiQ9BVoAqhDYDFFmWbCMU7engR9PI8SkRC2RdOT+PeAOv3pmymyr
         eJGg==
X-Forwarded-Encrypted: i=1; AJvYcCXlLb8SyIek9PUdYZ6cuuMxt/XQ7lSArbG85BUu4mmdTPA0w/+yt91YTbH5PhIV+3hRiY2aG5U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+/rs6o8plJESthdGt4pIAqiO/WNLsnXvTR6WkzjEhe9kD/QPK
	mD11SWojruHM0T34/dcGIxbMDwtH1GBRmCXDYoVM54H3Va0SLM5DuGRZfqOgF9LZrf+hFjJL8Pn
	QasoJY5A5QVeCAAMa3w78jGfSD46y49+WBcT6F0trrSBGJuGMO6eDEKWX/DoZXQXxzvZ8IsgUvQ
	WuUr/mZnv7Jw6kpZlhCO3/JX6b1ZDD
X-Gm-Gg: ASbGncu+bv6mhOHRquR0trXmeA8hd3+O+l/H7Wz3nWX3tgYMLSa79YGA8Jlmsxi4Tsz
	9DNih4tbjbflSeQBujhmJ67KJRdPUU2tDaR95XdE=
X-Received: by 2002:a05:6a00:4090:b0:727:3cd0:1167 with SMTP id d2e1a72fcca58-72abdebbdc0mr65315628b3a.21.1735787985828;
        Wed, 01 Jan 2025 19:19:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH2171JpQ46+MxTGlz4zxRUIpsAvCuxG2nbGnlOfZhQxL1sDicIzSkAmy7KNxeYz1rotHsWKMAbsdwlqtLYru0=
X-Received: by 2002:a05:6a00:4090:b0:727:3cd0:1167 with SMTP id
 d2e1a72fcca58-72abdebbdc0mr65315612b3a.21.1735787985497; Wed, 01 Jan 2025
 19:19:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241230124445.1850997-1-lulu@redhat.com> <20241230124445.1850997-3-lulu@redhat.com>
In-Reply-To: <20241230124445.1850997-3-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 2 Jan 2025 11:19:34 +0800
Message-ID: <CACGkMEuA_O5bgwLNz47sWJTQGqqOvq==_vNnhqrH-eGtbg-Fuw@mail.gmail.com>
Subject: Re: [PATCH v5 2/6] vhost: Add the vhost_worker to support kthread
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 30, 2024 at 8:45=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> Add the previously removed function vhost_worker() back to support the
> kthread and rename it to vhost_run_work_kthread_list.
>
> The old function vhost_worker() was changed to support tasks in
> commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads")
> and to support multiple workers per device using xarray in
> commit 1cdaafa1b8b4 ("vhost: replace single worker pointer with xarray").
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>

I think we need to tweak the title as this patch just brings back the
kthread worker?

Other than that,

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  drivers/vhost/vhost.c | 38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index eaddbd39c29b..1feba29abf95 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -388,6 +388,44 @@ static void vhost_vq_reset(struct vhost_dev *dev,
>         __vhost_vq_meta_reset(vq);
>  }
>
> +static int vhost_run_work_kthread_list(void *data)
> +{
> +       struct vhost_worker *worker =3D data;
> +       struct vhost_work *work, *work_next;
> +       struct vhost_dev *dev =3D worker->dev;
> +       struct llist_node *node;
> +
> +       kthread_use_mm(dev->mm);
> +
> +       for (;;) {
> +               /* mb paired w/ kthread_stop */
> +               set_current_state(TASK_INTERRUPTIBLE);
> +
> +               if (kthread_should_stop()) {
> +                       __set_current_state(TASK_RUNNING);
> +                       break;
> +               }
> +               node =3D llist_del_all(&worker->work_list);
> +               if (!node)
> +                       schedule();
> +
> +               node =3D llist_reverse_order(node);
> +               /* make sure flag is seen after deletion */
> +               smp_wmb();
> +               llist_for_each_entry_safe(work, work_next, node, node) {
> +                       clear_bit(VHOST_WORK_QUEUED, &work->flags);
> +                       __set_current_state(TASK_RUNNING);
> +                       kcov_remote_start_common(worker->kcov_handle);
> +                       work->fn(work);
> +                       kcov_remote_stop();
> +                       cond_resched();
> +               }
> +       }
> +       kthread_unuse_mm(dev->mm);
> +
> +       return 0;
> +}
> +
>  static bool vhost_run_work_list(void *data)
>  {
>         struct vhost_worker *worker =3D data;
> --
> 2.45.0
>


