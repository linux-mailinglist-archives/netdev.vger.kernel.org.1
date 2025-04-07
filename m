Return-Path: <netdev+bounces-179505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE5FA7D268
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 05:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7A243AB91A
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 03:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41B5212FA6;
	Mon,  7 Apr 2025 03:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z8i7v+Zx"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00134139E
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 03:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743995776; cv=none; b=OOiDRK+NiMclYzVBQcjkKPCTw7Nuhix96m9AXRhavUVxSYRYry5s9znpyCk26Cp9npQMDHVdXUu/Y+uK6a4kPn3cYq1/fI1zDw9z1PXZJoCjA6XGMGAO0Q8Nkh4AhvVpdLCWCpTGWmQotsG1EE2v27pBhAaH2fElT//jdYXrb0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743995776; c=relaxed/simple;
	bh=2Psv4XKwzaxxk54Wxm2NMdJLhP46x/zOj5VLe1kQqFs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uDYJlmF6IPDvTO2AzCSJyKDN5marySi+ejuhNscO2L3MJIVMikv8qVehUa7ktPEHyQPTGOtVnVWm6IkR0OK6h5jvHEpnTgGHzDNYF6lxxaj1n3KbIhlCa4Xg7UUqBod6fsZnQqCRnZItrXjXuNF5WPRZHIRjSErWQUQ+kZILjZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z8i7v+Zx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743995773;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2ByT4VM0mlsPMFV1CM9t8/TNYyL/tLm0jIu9vYemq9w=;
	b=Z8i7v+Zxoybld1mxGl0xwTCcTLoYikUsjhURoIaP4/JsrRv9yHQKOetozYh5sVr8TiDHo9
	KPrtoTbNthsp9m2kvob5ha7S2v+ja5Ph/dcPfsfQrmLjqdBeXwVS5TYWfViY8y82oiCXAA
	UOrRX4as1ysSpgMxfz4r33kWXhEyLSo=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-bpaPYeNXMNy1Q_Mv_AQftA-1; Sun, 06 Apr 2025 23:16:12 -0400
X-MC-Unique: bpaPYeNXMNy1Q_Mv_AQftA-1
X-Mimecast-MFC-AGG-ID: bpaPYeNXMNy1Q_Mv_AQftA_1743995772
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ac3d175fe71so258527766b.0
        for <netdev@vger.kernel.org>; Sun, 06 Apr 2025 20:16:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743995770; x=1744600570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ByT4VM0mlsPMFV1CM9t8/TNYyL/tLm0jIu9vYemq9w=;
        b=pbpUczba+vnnM+gAkJsvB0wnXhHU4XRgWXn9+LQbRbZlIMYUlMCpslU+ivjN3pK9cm
         Xd5JIrdSdDl31uGSZ/qvbqYUVqgMt6bruXf+o9hXJUZmscXj9HUff2CfYw4fguhioZv7
         9qDLQGwFcIxNybxs/RI6tiiSO9hA9UaYXCrCCiZ/fiGYtiZvA+op77gGZOxIO9Kuxs87
         WR1UyoA4DxRryzcA1aTkOOgGiQdByWCHRAe/qIACF47kYSR1qnhosdEBY767IxartljZ
         U9j5eDgNEmQyM0snu+13LeIP8CVwmoVq1kKHRe87CJpprgoZEI8ZwptFdrpogME3Y8el
         HRQg==
X-Forwarded-Encrypted: i=1; AJvYcCWhTUTxgO4NMiQ4bPL9kI06/2ORdbf+KSPooxw+en8l5DxbOnnnGOKibdP1wNfJ+NknJx4WGag=@vger.kernel.org
X-Gm-Message-State: AOJu0YydQmAxidKaNVyHePXHWy7NBC30wg9WVSYm2nUZvbby7mlGUkYW
	W6fR0YYBUCsp7ekr5L0B8IBiTWaVVswTlE0AsUZi2J22qpb3JiXfnK4ZHiijJ8H8MxxAxVshuGc
	Zf2fYlIOYH0nzqMCEztKVFaeZ3nVfyjxugmjZgwrALYqVG6YrsVLTyVIq9T3qT+85jad44vZ6MT
	AM7J53h6JjJGeV908Df68w7EBWkf1C1z/7p6P3
X-Gm-Gg: ASbGnctyFFFSelJZgFKQLsvbDwrq1FrYRrdBPRFhp+60vBp0J+FOhKDW+FREWWkVOii
	/9ekZtkuZlsJF0csmWgyFKNjCRGlZI7oqNyeRlP5VMRzZHi/aK3Qc3vyzN3GOb1eFELqWet6L4Q
	==
X-Received: by 2002:a17:907:7ea6:b0:ac2:a5c7:7fc9 with SMTP id a640c23a62f3a-ac7d6e93599mr994473566b.51.1743995770476;
        Sun, 06 Apr 2025 20:16:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMJnXbAYIz1U9EXfhPLXDao58wG6UnY/kQ+tnR0/5Lpt/9hn9DGVTkSTF2KUQRBQfoiF3etXQ5fFZKr+LUKAs=
X-Received: by 2002:a17:907:7ea6:b0:ac2:a5c7:7fc9 with SMTP id
 a640c23a62f3a-ac7d6e93599mr994472366b.51.1743995770124; Sun, 06 Apr 2025
 20:16:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250328100359.1306072-1-lulu@redhat.com> <20250328100359.1306072-8-lulu@redhat.com>
 <d35istatjtnr42x4gwpwlgx627pl3ntqua3kde7fymtotl676i@jxxxkrii6rue>
In-Reply-To: <d35istatjtnr42x4gwpwlgx627pl3ntqua3kde7fymtotl676i@jxxxkrii6rue>
From: Cindy Lu <lulu@redhat.com>
Date: Mon, 7 Apr 2025 11:15:33 +0800
X-Gm-Features: ATxdqUHJ6Q-Ip5ecSwCjJr9VIgAypATzgnh9U_7r0L81kSaqxYSAPR91ELbFrEQ
Message-ID: <CACLfguXFeV6aRL+rW9ULWh=gyF8u5vLncMFJhsOrfMWe7PhvTA@mail.gmail.com>
Subject: Re: [PATCH v8 7/8] vhost: Add check for inherit_owner status
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 1, 2025 at 9:59=E2=80=AFPM Stefano Garzarella <sgarzare@redhat.=
com> wrote:
>
> On Fri, Mar 28, 2025 at 06:02:51PM +0800, Cindy Lu wrote:
> >The VHOST_NEW_WORKER requires the inherit_owner
> >setting to be true. So we need to add a check for this.
> >
> >Signed-off-by: Cindy Lu <lulu@redhat.com>
> >---
> > drivers/vhost/vhost.c | 7 +++++++
> > 1 file changed, 7 insertions(+)
>
> IMHO we should squash this patch also with the previous one, or do this
> before allowing the user to change inherit_owner, otherwise bisection
> can be broken.
>
> Thanks,
> Stefano
>
Sure, will do
Thanks
Cindy
> >
> >diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> >index ff930c2e5b78..fb0c7fb43f78 100644
> >--- a/drivers/vhost/vhost.c
> >+++ b/drivers/vhost/vhost.c
> >@@ -1018,6 +1018,13 @@ long vhost_worker_ioctl(struct vhost_dev *dev, un=
signed int ioctl,
> >       switch (ioctl) {
> >       /* dev worker ioctls */
> >       case VHOST_NEW_WORKER:
> >+              /*
> >+               * vhost_tasks will account for worker threads under the =
parent's
> >+               * NPROC value but kthreads do not. To avoid userspace ov=
erflowing
> >+               * the system with worker threads inherit_owner must be t=
rue.
> >+               */
> >+              if (!dev->inherit_owner)
> >+                      return -EFAULT;
> >               ret =3D vhost_new_worker(dev, &state);
> >               if (!ret && copy_to_user(argp, &state, sizeof(state)))
> >                       ret =3D -EFAULT;
> >--
> >2.45.0
> >
>


