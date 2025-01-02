Return-Path: <netdev+bounces-154669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A8259FF5C7
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 04:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58BEB1882DBF
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 03:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D98521106;
	Thu,  2 Jan 2025 03:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eWfua1+0"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF5D11713
	for <netdev@vger.kernel.org>; Thu,  2 Jan 2025 03:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735788566; cv=none; b=I0qe24RNP15sNEwU9rpi44GbsuGIZ60Pr96W/krJWfhgLyAaDiLzVNyv19g0bpphTMo8tjVh6D+laT/CYj40sse65hTk6tpynlpJBbwHBzx7tlMC0n1o4jesk6KHXDnf/VOVnEGQp2+Mna3nUG5ziG/5Dyo/BpENuKjgYemgzfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735788566; c=relaxed/simple;
	bh=yBccCS82jh7ovGObzBDk9jbyc37dC8PGynna4j5nJek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aSpRdwIyUCq/YCZ3kVUizu8xCFRH0EewMZZECLwrLvyF6e0hYCtxFQPP/h2QGISMWyowEJxOJVp2pM7RRLBwZ18oMDCTg4cGiTdRAr6dqfUhrcayfZCVLNCJi9b8fojEEhVA+YZc9bmVMqVcd0ZzjmcRd/EHjEICEdSX8c2nHZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eWfua1+0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735788563;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NN6AyzPMDSUlUsPWjiPfTwpmHUglS8cLZ/Ty6brF+N0=;
	b=eWfua1+0PtZnmQE04FyEmwPYE09SXejjf34zMXUwjINpvjTnvOjP4/F82CyT+q0RPQV6Ln
	mD1Bv4BSn5kBhPAbllaVBVfiHOnBWvONoCO5yZM70y/lsqV/0C8jm32OxJTlv9wTusH7kX
	xLlqRv3NVYaQq076EiQboWxWr4wGTEU=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-942aMOLdPzmcec6I0Xj-LA-1; Wed, 01 Jan 2025 22:29:19 -0500
X-MC-Unique: 942aMOLdPzmcec6I0Xj-LA-1
X-Mimecast-MFC-AGG-ID: 942aMOLdPzmcec6I0Xj-LA
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-216728b170cso148467605ad.2
        for <netdev@vger.kernel.org>; Wed, 01 Jan 2025 19:29:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735788558; x=1736393358;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NN6AyzPMDSUlUsPWjiPfTwpmHUglS8cLZ/Ty6brF+N0=;
        b=ebLpbWwZYhD4vcaKYZSgrjkAN9kMEv+BjhuLDBe+zjWxXrbC+5UfLSsxPoLEaUQQcJ
         IeezOhWr9QxIcRDQ11ajaV9s0zi8zUXGxJcJzgkossboT0DdiajK6tZeSisthaSJqoAx
         BhGazjXjHVZz/S5FaTJtXZAUjujZOT18vaRpGriRedqQv9e9GA6PmGGfPHp6lJrVu25L
         VyEZkqD6zZwptkfuKUIjUbwVFUpPLeUJmq0tP3uufEdZTuZLKJrpAvwXELqKm5Zh6YS1
         ftxZ7dBVo0JVd2wU5m7eGTbVpBYNl8VV3zWddYSAedPnMll7mdf6JV1D9FkdX/6kpPW2
         4htA==
X-Forwarded-Encrypted: i=1; AJvYcCXedg34H7VFYfspCquyFleo5ItrM5unZiszlCelJ5/AHzVtlaZXw5rcLVv/6R8+sJfvanccubQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3AesXI/g2n9e7c4p/5btMHIvn53hX7xcZLhph2/Jhu5XnHL34
	EegvTJvkDsIFwVLE358XOekXi3DXJ0nUZiHt9hLBTqJTs+/qCTutW43WaD8yvukE/kuyAod+3yE
	4oK9qMnt+d4fD5zAwOETQe3rMIbl7V9PoDnZGhiz/5lJKrhq1PS6sJzBAjM+XBPOveTI6hZbvuq
	QSzirpVgy70Kf+2r1D9SKVSlGOMgH1
X-Gm-Gg: ASbGncvdJz7RizJ/3W7JX2BmrrwH6L7V8F+wnjpPtXFvsKp1HJbuIQkdA8cyorjC6Ea
	QAx7rfvVYJ9+XsKiw27egyC8ZkVIfSV+Z/tr0fQ0=
X-Received: by 2002:a05:6a21:328d:b0:1e0:f495:50bb with SMTP id adf61e73a8af0-1e5e084326emr65097245637.44.1735788558363;
        Wed, 01 Jan 2025 19:29:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEtn+VAOFvm/mDkS1q8GJ11i0qd0gI5imLGdJDyg/nRuIP8JtT8/NjGx/stu9lZmUQa1g1BqtbPotRqX98ZHnQ=
X-Received: by 2002:a05:6a21:328d:b0:1e0:f495:50bb with SMTP id
 adf61e73a8af0-1e5e084326emr65097218637.44.1735788557935; Wed, 01 Jan 2025
 19:29:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241230124445.1850997-1-lulu@redhat.com> <20241230124445.1850997-4-lulu@redhat.com>
In-Reply-To: <20241230124445.1850997-4-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 2 Jan 2025 11:29:06 +0800
Message-ID: <CACGkMEu29fZxNoyLOytScwFqFSFP+o3-ETSgG8u4Kgq_yEt6Gw@mail.gmail.com>
Subject: Re: [PATCH v5 3/6] vhost: Add the cgroup related function
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 30, 2024 at 8:45=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> Reintroduce the previously removed functions vhost_attach_cgroups_work()
> and vhost_attach_cgroups() to support kthread mode. Rename
> vhost_attach_cgroups() to vhost_attach_task_to_cgroups(), and include
> the implementation of the old function vhost_dev_flush() in this
> new function.
>
> These function was removed in
> commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads")
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  drivers/vhost/vhost.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 1feba29abf95..812dfd218bc2 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -22,6 +22,7 @@
>  #include <linux/slab.h>
>  #include <linux/vmalloc.h>
>  #include <linux/kthread.h>
> +#include <linux/cgroup.h>
>  #include <linux/module.h>
>  #include <linux/sort.h>
>  #include <linux/sched/mm.h>
> @@ -620,6 +621,38 @@ long vhost_dev_check_owner(struct vhost_dev *dev)
>  }
>  EXPORT_SYMBOL_GPL(vhost_dev_check_owner);
>
> +struct vhost_attach_cgroups_struct {
> +       struct vhost_work work;
> +       struct task_struct *owner;
> +       int ret;
> +};
> +
> +static void vhost_attach_cgroups_work(struct vhost_work *work)
> +{
> +       struct vhost_attach_cgroups_struct *s;
> +
> +       s =3D container_of(work, struct vhost_attach_cgroups_struct, work=
);
> +       s->ret =3D cgroup_attach_task_all(s->owner, current);
> +}
> +
> +static int vhost_attach_task_to_cgroups(struct vhost_worker *worker)
> +{
> +       struct vhost_flush_struct flush;
> +       struct vhost_attach_cgroups_struct attach;
> +
> +       attach.owner =3D current;
> +
> +       vhost_work_init(&attach.work, vhost_attach_cgroups_work);
> +       vhost_worker_queue(worker, &attach.work);
> +
> +       init_completion(&flush.wait_event);
> +       vhost_work_init(&flush.work, vhost_flush_work);
> +       vhost_worker_queue(worker, &flush.work);
> +       wait_for_completion(&flush.wait_event);
> +
> +       return attach.ret;
> +}

This seems to be inconsistent with what you said above which is

"""
> These function was removed in
> commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads")
"""

As 6e890c5d5021 had:

static int vhost_attach_cgroups(struct vhost_dev *dev)
{
        struct vhost_attach_cgroups_struct attach;

        attach.owner =3D current;
        vhost_work_init(&attach.work, vhost_attach_cgroups_work);
        vhost_work_queue(dev, &attach.work);
        vhost_dev_flush(dev);
        return attach.ret;
}

It seems current vhost_dev_flush() will still work or the open coding
of the flush logic needs to be explained.

Thanks

> +
>  /* Caller should have device mutex */
>  bool vhost_dev_has_owner(struct vhost_dev *dev)
>  {
> --
> 2.45.0
>


