Return-Path: <netdev+bounces-180116-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF4AA7FA3B
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 11:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08F6E3A7359
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 09:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB2526656D;
	Tue,  8 Apr 2025 09:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PkA6KqER"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B515F265CD7
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 09:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744105610; cv=none; b=Vh5lxpdoTLQFSCwKgkfAJhZ1RJBZg/Uk3LUnyVx92IV6XvyZOLN6FFhkaY6qPLTixUEli5+zX9WMUUnnoV5w2BSFPkkBsfTBe1bDHZcSxoUPcWVeIYpgUy1GEU4l6QgR5YyitxYOql4QgJ349aZY+p3xOh3eXqxKYqmuWP6l8DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744105610; c=relaxed/simple;
	bh=kFJHApLzkjjQTZd748UbOGNjaj3R6uugruxTfXbZkHU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IcS6vcJqpkegQvysJJ0DPnq7MRDbrdrT57rLvwfMnitRY59XymfS88cE4Lh98OmlEgh2b0a62aUGcZWiFcmqs5EvEtCAWIDoLghvp2fsNxobGV1GGt4J7G8QLH9vAYNpgX7yFxehDdf1uk24esCI1t6y7s0dAuTtxC7C2DWoTeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PkA6KqER; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744105606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kFJHApLzkjjQTZd748UbOGNjaj3R6uugruxTfXbZkHU=;
	b=PkA6KqER8YJkXNODKomHLkiuSyNXmuuEhloqMqqb9n18Hd6LQoXUEW0nqzn2m5RBzj6ZPl
	frrhwOIZRTtQiML9ZngGhmPLoBWiehrSPIrb9n3QByp9pXQE6xtKGCI2S78R0NixYRXXCy
	LZfT/eZQalOyzYNF8K/yOnGVPm50Rgg=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590--Vv2dSXlNqqdTnJHjBvSmw-1; Tue, 08 Apr 2025 05:46:45 -0400
X-MC-Unique: -Vv2dSXlNqqdTnJHjBvSmw-1
X-Mimecast-MFC-AGG-ID: -Vv2dSXlNqqdTnJHjBvSmw_1744105604
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-47693206f16so87683131cf.1
        for <netdev@vger.kernel.org>; Tue, 08 Apr 2025 02:46:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744105604; x=1744710404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kFJHApLzkjjQTZd748UbOGNjaj3R6uugruxTfXbZkHU=;
        b=S3GSLncrNFSL68l9IDe7e88ju0fqq3r5ZcuZkufaAyWtYPo44IK6z12TzqtIfiLyDd
         86p7Sg/U2SUUNnz99uBlsEbfd9iVaV24X7wvf9Qkqw64zcXXvQH0LRbWgNA6Jys4xdP+
         PnIjAW0hjheOQGJsU7pRUFmQDGq50XYgXKZeu+lE9LESUGT49ADgLGcRbuwg7ca/w43I
         Y2fWLXy6mIvCHM+tNplbAkf8lcnc6kllj8alVcpCEAoCQJiVIR7/WcHgON/gLljY75/8
         Fo/2LLABUUdYriDIWF+3JjAZ8Qnj/tHOH17g4GGazcnHjlPqrebzA7rOQ+Qq7OUeV2A4
         L4WA==
X-Forwarded-Encrypted: i=1; AJvYcCXScszUYI/7uj4wOa3BFfKwSuCqXfixDpTneBAVl32jIAswjKJax7THHHmu78WtRt8Su4eSSHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzufcLDvlWAfqirVwBLnT2S3+kYCX5FxT/bsttTL+w8d5jxGuUG
	N3P2LzAWWhCPoEgQbLqQY5yCm2/hcSuWiE/wqJ0cd95+lXkS+ZRmbg4ftlKCJUfJ6eLvcT6NdOK
	xsuLHAGwiUH75XGXE86lV/L2lrE8I2uiKMXBVhQSB43RBXXIU1fRlUNAypnskUpaERj3AN8VKYX
	xl+lw/HESaTJg4CC8uCh7cQi5jTb3f
X-Gm-Gg: ASbGncv7cu/oy+ARp7kA7Dqal1CzrVbhsDI6U4iq7Sot8sLVsEcL/Y+gweu9Bm736LN
	zWT45v8nX0vH7/kAwKUWeZvIYvB3LrylsI5kVv1gA1tCDFfNtZP/nWcbFMLx/xpdNsJ968kW4lQ
	==
X-Received: by 2002:ac8:5987:0:b0:477:4224:9607 with SMTP id d75a77b69052e-47930f92246mr194565651cf.12.1744105604569;
        Tue, 08 Apr 2025 02:46:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUGe1WMgdw3266Ixamciimi7c04VwM13sorCvBAziX4GsTGnRMZpS8YF7Y0r3w9ErgRv4v1FDTdG6BwI33w3U=
X-Received: by 2002:ac8:5987:0:b0:477:4224:9607 with SMTP id
 d75a77b69052e-47930f92246mr194565531cf.12.1744105604319; Tue, 08 Apr 2025
 02:46:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250328100359.1306072-1-lulu@redhat.com> <20250328100359.1306072-5-lulu@redhat.com>
 <20250407041540-mutt-send-email-mst@kernel.org> <76a7e782-6a7c-4704-b7c1-2459254c1362@oracle.com>
In-Reply-To: <76a7e782-6a7c-4704-b7c1-2459254c1362@oracle.com>
From: Cindy Lu <lulu@redhat.com>
Date: Tue, 8 Apr 2025 17:45:58 +0800
X-Gm-Features: ATxdqUEdI-_9frRvmATT_TQ83vcEeyygOtNToq3q3kw5ZPITDti5dWdb32chlc4
Message-ID: <CACLfguXfRvLLiCF7ysidPLcn7GftU1Jyuem2Q9xr_SMGnP_16A@mail.gmail.com>
Subject: Re: [PATCH v8 4/8] vhost: Introduce vhost_worker_ops in vhost_worker
To: Mike Christie <michael.christie@oracle.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, jasowang@redhat.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 8, 2025 at 12:06=E2=80=AFAM Mike Christie
<michael.christie@oracle.com> wrote:
>
> On 4/7/25 3:17 AM, Michael S. Tsirkin wrote:
> > On Fri, Mar 28, 2025 at 06:02:48PM +0800, Cindy Lu wrote:
> >> Abstract vhost worker operations (create/stop/wakeup) into an ops
> >> structure to prepare for kthread mode support.
> >>
> >> Signed-off-by: Cindy Lu <lulu@redhat.com>
> >
> > I worry about the overhead of indirect calls here.
> >
> > We have the wrappers, and only two options,
> > why did you decide to add it like this,
> > with ops?
> >
> That was from my review comment. Originally, I thought we
> could share more code. For example I thought
> vhost_run_work_kthread_list from patch 2 in this thread and
> kernel/vhost_task.c:vhost_task_fn could be merged.
>
Hi Mike
I guess you mean function vhost_run_work_list and vhost_run_work_kthread_li=
st?
sure, I will try to merge these two functions in next version
Thanks
Cindy


