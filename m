Return-Path: <netdev+bounces-176365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26AF1A69DB7
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 02:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C994B3ACA5E
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 01:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088E61CAA63;
	Thu, 20 Mar 2025 01:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tf9ghmXw"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583631B85C5
	for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 01:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742434966; cv=none; b=ldK6/0eugZalCdKMln/D4ZEO5F+MqyrHTxCWdg7Cam8fQHeOZvgphE/EwN09/8RBZ+sQtERZvRtp4zY6hL1EKKI+e79eKhqYgqxQiwVX9K+lxcHRjHzOUHoiNvCoDM3PWueplXS+0iAnmg0Dn1dh/k/odmWBoPzQ86ScE6Q/6yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742434966; c=relaxed/simple;
	bh=SGrH1u360HKGfwUkB5OQl0M0A4QLRKrf61IPTLVqChc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L8Qd95JU4JlMMQKqudPcxc5k3o+KQoCg0wFX3dgP5EnRycO3q3T9xEgwVaohXEBCFcRZ6ElIjsNpAnajl/z/o4g7WAzUu2zYkU4ln15hI0RjQkjhJzFw82fqrhWJPXrZtFGwLExX7rrtfRiLBL1Rlw32rb9F/I7iWDj7F5gRXpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tf9ghmXw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742434964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SGrH1u360HKGfwUkB5OQl0M0A4QLRKrf61IPTLVqChc=;
	b=Tf9ghmXwJ23G4LWVoUJMsX/NyaV+ULvrl7eSgrtuqxQc0xo9WkxmJQ6QN5xQ5BUFeXg/yN
	zdjCVj2USs1ZfO6fx30pqvAyCvO10Slz+/40lwQ9Dr2G+xT/bnguNl4RxjUEapbbAmfPZf
	74+C8TSmnZ8GDrEwlcUT2lEXseOkX04=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-265-UtEWyLABPxGhIDBJnPubPQ-1; Wed, 19 Mar 2025 21:42:42 -0400
X-MC-Unique: UtEWyLABPxGhIDBJnPubPQ-1
X-Mimecast-MFC-AGG-ID: UtEWyLABPxGhIDBJnPubPQ_1742434962
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ff798e8c90so459166a91.1
        for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 18:42:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742434961; x=1743039761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SGrH1u360HKGfwUkB5OQl0M0A4QLRKrf61IPTLVqChc=;
        b=jRyO1Kd5xzo9Xyj8SI7CvwvjvxBI6maqTmApkV8maXoT8mLEejIXQUh8LY3CLU8Kpl
         Emu3cAMT42gVA86aNHJtHRmd8cYNg9Pjp5F8RQ02R6w7S5VH9UTtcW8uCRdPvRn/FN+T
         +BUY8DYQr08otYD3LLXLRobNRpEdzEq+pKn9ohnJl8qSzL9xW9ss85QOlncW1/bxpemt
         aTdKPaVgzh34Xa8wJ//h+P5bPQvaHHN+/hxO+AeHQIGBADZ3NKrl6ceH6+pHiBm0gFcK
         4KHlX1RpIMP2siH917Q7IxtDunrTv0muwChLo41SYRGxINBIQkrYpU6baT8MNJv6pQMb
         FA3g==
X-Forwarded-Encrypted: i=1; AJvYcCUlA7Z4H44MtOFJAFzSKw5ytqqXKn4jtTW84Wm/8Mys/SUfun59dY0ZcoCIGHrdj20DvaseRww=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkCWra2YV3ZLEzG57Wx0n9IRKeV5vzd/AK3sQp8J5LpqS+islq
	ww0cbNeu8lNeQE81WB8WnaojaP4XsNJf0StIZ0BaOACgNEU/yCLz9i8XI3E7HYeuVmJ1wS2X+s8
	9ZiJf5/nKoPGUE3+uuTeINH3l1Ya8lhIdq05UASErhi4Oi3JZJHO8/bai5kqlSaN9EZS+peKfNx
	umrZUq4RmsjufDex7J3oAwGiRifn7b
X-Gm-Gg: ASbGncsBE4jspxCb5i/dZrFnUnO2yfE7vKtAC1OtRfOgAs4NZ04OAgDK8L33qCIqMoW
	efRkgxLgscDQuZPNtAkzTMWKcDdZmfuDgJbZ5vpm0ZvvZeD/rC9hJPiLgtRtWHsiM5rKDpdGzTA
	==
X-Received: by 2002:a17:90b:3b8d:b0:2ff:702f:7172 with SMTP id 98e67ed59e1d1-301be22004bmr8335516a91.33.1742434961584;
        Wed, 19 Mar 2025 18:42:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHL8OOunCev/pL9yVKVD54yPvvXy/UMUfGTvOvKDcF+K+NIjug+q9W+WWL+a2DVKRNK9ypCK2PuGfDdKa5c2c=
X-Received: by 2002:a17:90b:3b8d:b0:2ff:702f:7172 with SMTP id
 98e67ed59e1d1-301be22004bmr8335480a91.33.1742434961230; Wed, 19 Mar 2025
 18:42:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317235546.4546-1-dongli.zhang@oracle.com>
 <20250317235546.4546-4-dongli.zhang@oracle.com> <CACGkMEsG4eR3dErdSKsLxQgDqBV55NUyf=Lo-UUVj1tqQ-T8QA@mail.gmail.com>
 <f3939e10-3953-4be4-bd92-2ae891f6d67e@oracle.com>
In-Reply-To: <f3939e10-3953-4be4-bd92-2ae891f6d67e@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 20 Mar 2025 09:42:29 +0800
X-Gm-Features: AQ5f1Jog19Stpw5ZwXnl2LZ0a3rRd5bIs46de4Ks1-qbsvRNWnVK_fE3aiW_X5c
Message-ID: <CACGkMEs3O2B0fAifAki9GdDiP-SX4pMviEOjqCsAkkzCyx90gg@mail.gmail.com>
Subject: Re: [PATCH v2 03/10] vhost-scsi: Fix vhost_scsi_send_status()
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	netdev@vger.kernel.org, mst@redhat.com, michael.christie@oracle.com, 
	pbonzini@redhat.com, stefanha@redhat.com, eperezma@redhat.com, 
	joao.m.martins@oracle.com, joe.jin@oracle.com, si-wei.liu@oracle.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 1:54=E2=80=AFAM Dongli Zhang <dongli.zhang@oracle.c=
om> wrote:
>
> Hi Jason,
>
> On 3/17/25 5:48 PM, Jason Wang wrote:
> > On Tue, Mar 18, 2025 at 7:52=E2=80=AFAM Dongli Zhang <dongli.zhang@orac=
le.com> wrote:
> >>
> >> Although the support of VIRTIO_F_ANY_LAYOUT + VIRTIO_F_VERSION_1 was
> >> signaled by the commit 664ed90e621c ("vhost/scsi: Set
> >> VIRTIO_F_ANY_LAYOUT + VIRTIO_F_VERSION_1 feature bits"),
> >> vhost_scsi_send_bad_target() still assumes the response in a single
> >> descriptor.
> >>
> >> Similar issue in vhost_scsi_send_bad_target() has been fixed in previo=
us
> >> commit.
> >>
> >> Fixes: 3ca51662f818 ("vhost-scsi: Add better resource allocation failu=
re handling")
> >
> > And
> >
> > 6dd88fd59da84631b5fe5c8176931c38cfa3b265 ("vhost-scsi: unbreak any
> > layout for response")
> >
>
> Would suggest add the commit to Fixes?
>
> vhost_scsi_send_status() has been introduced by the most recent patch.
>
> It isn't related to that commit. That commit is to fix
> vhost_scsi_complete_cmd_work()
>
> Or would you suggest mention it as part of "Similar issue has been fixed =
in
> previous commit."?

I'm fine with either, they are all fixes for any header layout anyhow.

Thanks

>
> Thank you very much!
>
> Dongli Zhang
>


