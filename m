Return-Path: <netdev+bounces-189971-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7552AB4A59
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 06:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66D77170F42
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 04:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1AE1C84A0;
	Tue, 13 May 2025 04:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ieFYV1q6"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDC1188596
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 04:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747109349; cv=none; b=bGfbS0ZX2Fq3dUqjwn3J+ynoPgT40pESX5jqwQfRKk0+UBFWlOr+XzBtMiQZcxHho4bY+4IPRdS+2bKbrcokgh4J67CAn1G96Qkz88IhizNoNFvxVe0Q7GhIzmYhua0tAn7AtIJxRkm87lqSRZFfU9pIhcLgsTL8l9UhOlmN2lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747109349; c=relaxed/simple;
	bh=/7PexB5fSgQlaIRo7HZc5/n/QHKjEqlW3Nl3Mba+2fU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FWpVDBLucl90I2OitoAfSonFNZ1ocuzLisOrD5rbm1kXGvQNuhujnbL/tqCblrmAlHMJ3SugpgbSAw96eZj5iGykWjbUFIXFvfkjqJ3uEtio3samkSXX75xBtoAarJWUypwVRPNW99q5swquv29tkU3ps/B+zvtklzNZayRotek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ieFYV1q6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747109346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/7PexB5fSgQlaIRo7HZc5/n/QHKjEqlW3Nl3Mba+2fU=;
	b=ieFYV1q6wMxvubB7WWpbCprv9pNx8LueksFHtFLFB3ZJNIH/w3ClxQYwuZZ+EAF7La8WRM
	AXwbNXYog91u/PLqP9TwtCcfp2N63YcsFc9bGUjXOTAiidSeF7/y+r0QgTaR4ADU0FCUbH
	wH/bKp1otwso9VNVVP6TZLMe9Zmi3UE=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-47-80PvJ_MEMeCK0NgB7cG5Vg-1; Tue, 13 May 2025 00:09:04 -0400
X-MC-Unique: 80PvJ_MEMeCK0NgB7cG5Vg-1
X-Mimecast-MFC-AGG-ID: 80PvJ_MEMeCK0NgB7cG5Vg_1747109343
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-30a39fa0765so8405061a91.3
        for <netdev@vger.kernel.org>; Mon, 12 May 2025 21:09:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747109343; x=1747714143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/7PexB5fSgQlaIRo7HZc5/n/QHKjEqlW3Nl3Mba+2fU=;
        b=XSEBYsAqQ5PkrukoLFRISELRNCtCrATI+eGzvkc0gSXLZEl6HBksVFZdyWytYU3aEn
         mTKji3kMdbO9VQxgjDxzJNDtgq+lXq0zgzMGgmllSviHmA8GLmG6aZiUQGeFK7c82Qyo
         QYNUO1dlDvrqQEOaj8hUHBd2ttjmE2mz2ST2q6iAKqEP/FpeiaQ61DA7Z7X7biLhdvxA
         g105znBfK/fC3ORdqStq5MSDtEqKoThHKscmD5RT8CFyCsL75NI8BNfYjsK3PM+V7xNd
         fmGSGzCaJHAug7SNcSTsX7qL+q22d3QEjx9PZF4ObC5MqEoRXFGlYOwhIswWc70IvD6u
         q9cg==
X-Forwarded-Encrypted: i=1; AJvYcCXp/Vl/nmYSFPvDKBeY9b7FVX34v2uXxmpSFhnPcYIDgycvGgrYKjLxqy5cHD1/fxVaVeK8Y3o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxybObQ22b15S804pfleht7l8aFpwL/AKs87ZfLQEGNYA1QCiEr
	qOJ+f+87OHi/EiDeyXttx5U9VLw3GoYSefUeArE3r7pSs3vPwdumgQbsV+YVYfpqjMVvmOXWHIw
	64yljEBi5xI2bq0/eAIO0KLAf792S/W1YCkHESkEiCc7hzpoBFJGIwdvswVRvZb1IAw3iXJXngw
	tLd7HeKZt78bEbsc74TREtLOydHNgQ
X-Gm-Gg: ASbGncupmEUkh9lz0fj1RTsvAKoa4A8YuvaahGsDw3M9mMeRVca7FQK2iJO8j6PHgzN
	GXEGhgSxxh5Dyf1kNS78ZkQBUBD5T0Bt5+c6g2cnvdMAowSjkqHjSD+jabaFCoayP2w==
X-Received: by 2002:a17:90a:d605:b0:2fe:ba82:ca5 with SMTP id 98e67ed59e1d1-30c3ce0470bmr26232820a91.11.1747109343288;
        Mon, 12 May 2025 21:09:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyBWgHCft3k//tAxwx54BhvxIyBUdAIfMV5MOII1cMr/aB5z20Oh2o8khSRERHIdevOIlxT4LnUgaV8ZRyza0=
X-Received: by 2002:a17:90a:d605:b0:2fe:ba82:ca5 with SMTP id
 98e67ed59e1d1-30c3ce0470bmr26232784a91.11.1747109342873; Mon, 12 May 2025
 21:09:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250421024457.112163-1-lulu@redhat.com> <20250421024457.112163-5-lulu@redhat.com>
 <CACGkMEt-ewTqeHDMq847WDEGiW+x-TEPG6GTDDUbayVmuiVvzg@mail.gmail.com>
 <CACGkMEte6Lobr+tFM9ZmrDWYOpMtN6Xy=rzvTy=YxSPkHaVdPA@mail.gmail.com>
 <CACGkMEstbCKdHahYE6cXXu1kvFxiVGoBw3sr4aGs4=MiDE4azg@mail.gmail.com>
 <20250429065044-mutt-send-email-mst@kernel.org> <CACGkMEteBReoezvqp0za98z7W3k_gHOeSpALBxRMhjvj_oXcOw@mail.gmail.com>
 <20250430052424-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250430052424-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 13 May 2025 12:08:51 +0800
X-Gm-Features: AX0GCFv7w4A3XPsR5LhhGFMy4lH1n0jPjulwvckB7Zf4ezIel8xqf6nhTotZRJ0
Message-ID: <CACGkMEub28qBCe4Mw13Q5r-VX4771tBZ1zG=YVuty0VBi2UeWg@mail.gmail.com>
Subject: Re: [PATCH v9 4/4] vhost: Add a KConfig knob to enable IOCTL VHOST_FORK_FROM_OWNER
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Cindy Lu <lulu@redhat.com>, michael.christie@oracle.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 30, 2025 at 5:27=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Wed, Apr 30, 2025 at 11:34:49AM +0800, Jason Wang wrote:
> > On Tue, Apr 29, 2025 at 6:56=E2=80=AFPM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > >
> > > On Tue, Apr 29, 2025 at 11:39:37AM +0800, Jason Wang wrote:
> > > > On Mon, Apr 21, 2025 at 11:46=E2=80=AFAM Jason Wang <jasowang@redha=
t.com> wrote:
> > > > >
> > > > > On Mon, Apr 21, 2025 at 11:45=E2=80=AFAM Jason Wang <jasowang@red=
hat.com> wrote:
> > > > > >
> > > > > > On Mon, Apr 21, 2025 at 10:45=E2=80=AFAM Cindy Lu <lulu@redhat.=
com> wrote:
> > > > > > >
> > > > > > > Introduce a new config knob `CONFIG_VHOST_ENABLE_FORK_OWNER_I=
OCTL`,
> > > > > > > to control the availability of the `VHOST_FORK_FROM_OWNER` io=
ctl.
> > > > > > > When CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL is set to n, the io=
ctl
> > > > > > > is disabled, and any attempt to use it will result in failure=
.
> > > > > >
> > > > > > I think we need to describe why the default value was chosen to=
 be false.
> > > > > >
> > > > > > What's more, should we document the implications here?
> > > > > >
> > > > > > inherit_owner was set to false: this means "legacy" userspace m=
ay
> > > > >
> > > > > I meant "true" actually.
> > > >
> > > > MIchael, I'd expect inherit_owner to be false. Otherwise legacy
> > > > applications need to be modified in order to get the behaviour
> > > > recovered which is an impossible taks.
> > > >
> > > > Any idea on this?
> > > >
> > > > Thanks
>
> So, let's say we had a modparam? Enough for this customer?
> WDYT?

Just to make sure I understand the proposal.

Did you mean a module parameter like "inherit_owner_by_default"? I
think it would be fine if we make it false by default.

Thanks

>
> --
> MST
>


