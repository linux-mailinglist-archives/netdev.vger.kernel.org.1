Return-Path: <netdev+bounces-157569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F20CA0AD68
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 03:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87F2F162559
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 02:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7231C433C8;
	Mon, 13 Jan 2025 02:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hz4M6JW7"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC67ACA6F
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 02:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736735570; cv=none; b=mho1+1ojcd/sOM4MzwJzlQj5VYYJqqO4hFl+eveoTSPrCvUnN4zmzRKLnh++xLKE4djkFT74NMoMtAYzPE+nswYvTMSTqkuOYGi+lbl8o2L2s0ekh87WxkVhEOfXonXQ5HlGV+CeEkMz8O+s256VYdL+crQFAYkp4XDPTBuKOGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736735570; c=relaxed/simple;
	bh=iJBXhSEUXil9nzcleAa3rLf5fXsjKbI4577NtFmRmCw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XyWRoZOvdh402S1KEK0lrhl2M4ltuiekes34ohxDRuxcXI5V2ogSmn0lQfnJGfsfPkiyq8Dq3hYAAqJDxOJEX61WEGFm6gdfDeTFgnh0u8GEYMipmRw0/BIlKyryirsDmbeGsr9F78EVrFI1sh643nLmLoKFe8DrWE3VB1VGbtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hz4M6JW7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736735567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ogh4yUdSverGfA2nr1La7HZqI96ihmOqtA9BI3+NwGU=;
	b=hz4M6JW7wa76o8tvgod+oT8vgtsnW13n5pgAabGXr90ARYwppmk+7ERsX7czVAQyMLvZtv
	FeyLcaebcc7W77CFVIRgWQNj09G6KeRwYzGShEgjjJlvDX9lBKYuj0YN8JwySziG1HnBvQ
	rmh9M3QUd3fxQfJgI8Db0DIN5QynUpg=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-ZKdVfpLkMsuNhid08lwAig-1; Sun, 12 Jan 2025 21:32:46 -0500
X-MC-Unique: ZKdVfpLkMsuNhid08lwAig-1
X-Mimecast-MFC-AGG-ID: ZKdVfpLkMsuNhid08lwAig
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-aa67fcbb549so482730366b.0
        for <netdev@vger.kernel.org>; Sun, 12 Jan 2025 18:32:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736735564; x=1737340364;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ogh4yUdSverGfA2nr1La7HZqI96ihmOqtA9BI3+NwGU=;
        b=JuHt85j33/Ibmc+Z8mQnSV965kN5jmWnpxS4+5P1T89euzdqWbwtLkSxyAzpGimhwt
         TeXmDGH3fR4hEOzEHRsa6xf+9/3CEhDQnxrisFdaI6PaGVK6bCWplp8an94sJohk1jbz
         vnxgmzph3pvhHDTWOgiEOSCcbQgqs4hAyGbt2/lPN+r9OlQc1c/FN0pX6HFHsv/T/+R+
         0ZZeYnnwtYATmjtvBzhDTt5ZTKr3y+ZNesOgc7POm9HYbmf7vsUdDyxVl/UV8borUqeP
         l1dwF9FECSylhnx2CJ4jjG3cul8puPl5xodJCrrmex2zULErcQVW1Bevw2Ci3wKblhX6
         EjeA==
X-Forwarded-Encrypted: i=1; AJvYcCXJ6d6h9Mox5e5FqRdOTHbj7zVlNfNhmCKe578bB78Lj5wSSTYadGEC4qqG+IzSCgzRTldMHrc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx35kmr5WdrBWKFPFZ7ETGmOYrlCV7VWgRQl3knjxAdV3zjBe1T
	egIOjIp2pCKnhAjz58jbIIi1doboGiNr2L0VET5wMnAtKTClMk8eG+Hlx6TekfXwFiy31uKxmSA
	sQjP6j3XGhbaeIdsqH/wJBHlitv5mkGTKvbouklII3FYRnvsJsPYzio4yumfbHkhiZvSnRoluQr
	FxebMkbyiSLAN9urkHU6SXNyzhn7WJHHQQdf6/
X-Gm-Gg: ASbGnctl+neZTxw4WJSxS7dKEGsvdOMHxXQxmAZpUArkpDOZLt7DvmvKDWllSrO3o8r
	O7ujFy4T8Ka18ftFu5Lxy1memJR+1eoIhTgboKEE=
X-Received: by 2002:a17:907:7288:b0:aa6:73ae:b3b3 with SMTP id a640c23a62f3a-ab2ab5f6f1cmr1637286066b.32.1736735564389;
        Sun, 12 Jan 2025 18:32:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFnuGt8CxE+gRSzYVi8MUlepoHGla7JG4/2R+e3nAiZqyvY650WJaTCzM5NsO1xJzfzWq/2khQ/lBupx9fZUEI=
X-Received: by 2002:a17:907:7288:b0:aa6:73ae:b3b3 with SMTP id
 a640c23a62f3a-ab2ab5f6f1cmr1637285266b.32.1736735564092; Sun, 12 Jan 2025
 18:32:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241230124445.1850997-1-lulu@redhat.com> <20250108072229-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250108072229-mutt-send-email-mst@kernel.org>
From: Cindy Lu <lulu@redhat.com>
Date: Mon, 13 Jan 2025 10:32:07 +0800
X-Gm-Features: AbW1kvZSxc6vxEyyMbRsiKZHQLXzHErZjYxUy89i7uHx6o2XOjUFvAUYnAHvGsE
Message-ID: <CACLfguUjnJxvv2iuu2ASX7ZKiWbk48wWQTAVoOfZegLXJij=9w@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] vhost: Add support of kthread API
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: jasowang@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 8, 2025 at 8:23=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Mon, Dec 30, 2024 at 08:43:47PM +0800, Cindy Lu wrote:
> > In commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads"),
> > the vhost now uses vhost_task and operates as a child of the
> > owner thread. This aligns with containerization principles.
> > However, this change has caused confusion for some legacy
> > userspace applications. Therefore, we are reintroducing
> > support for the kthread API.
>
>
> I briefly applied this, but there seem to be a bit too
> many nits. So I will wait for v6 with everything addressed.
>
> Thanks!
>
sure, I will rebase this to the latest kernel, Thanks
Thanks
Cindy
> > In this series, a new UAPI is implemented to allow
> > userspace applications to configure their thread mode.
> >
> > Changelog v2:
> >  1. Change the module_param's name to enforce_inherit_owner, and the de=
fault value is true.
> >  2. Change the UAPI's name to VHOST_SET_INHERIT_FROM_OWNER.
> >
> > Changelog v3:
> >  1. Change the module_param's name to inherit_owner_default, and the de=
fault value is true.
> >  2. Add a structure for task function; the worker will select a differe=
nt mode based on the value inherit_owner.
> >  3. device will have their own inherit_owner in struct vhost_dev
> >  4. Address other comments
> >
> > Changelog v4:
> >  1. remove the module_param, only keep the UAPI
> >  2. remove the structure for task function; change to use the function =
pointer in vhost_worker
> >  3. fix the issue in vhost_worker_create and vhost_dev_ioctl
> >  4. Address other comments
> >
> > Changelog v5:
> >  1. Change wakeup and stop function pointers in struct vhost_worker to =
void.
> >  2. merging patches 4, 5, 6 in a single patch
> >  3. Fix spelling issues and address other comments.
> >
> > Tested with QEMU with kthread mode/task mode/kthread+task mode
> >
> > Cindy Lu (6):
> >   vhost: Add a new parameter in vhost_dev to allow user select kthread
> >   vhost: Add the vhost_worker to support kthread
> >   vhost: Add the cgroup related function
> >   vhost: Add worker related functions to support kthread
> >   vhost: Add new UAPI to support change to task mode
> >   vhost_scsi: Add check for inherit_owner status
> >
> >  drivers/vhost/scsi.c       |   8 ++
> >  drivers/vhost/vhost.c      | 178 +++++++++++++++++++++++++++++++++----
> >  drivers/vhost/vhost.h      |   4 +
> >  include/uapi/linux/vhost.h |  19 ++++
> >  4 files changed, 192 insertions(+), 17 deletions(-)
> >
> > --
> > 2.45.0
>


