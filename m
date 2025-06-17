Return-Path: <netdev+bounces-198400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35CE8ADBF66
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 04:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDD7D1742B0
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 02:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE221B4236;
	Tue, 17 Jun 2025 02:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BADB5sX6"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED0284A3E
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 02:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750128993; cv=none; b=h6Sg2x3Sducrx0TlQHQzmTL6PWZ29rPre1u67CdMcFeWRext1e35vnhLRr4GRHZkayJFQ38w6PqMULhy9orq9xCSQ8eZ198Ct6m9OLjMPIobbh9U6/9AtD8dSEc1p9lCuaTG2Q7W/h0ca7W+VBug5YTgMIWRQFOp+ZdiqJHYi7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750128993; c=relaxed/simple;
	bh=8em4A7pq4zkoxl4+SoHoK3gZ7HSL3iI/ptfiQrTcddg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l4cY6K29ypGS+g/1AhuipDKrG3kHQzEv7HLhT/eRxpvyM1rGWWcX1wBmdoZs97fLOAiQXcMQ1Da7DDcWm6OXwrvFrovIis3NwmprH78rPNy7PMYDK8V0S5WPoix8BnaFoql5S6dAnAUjrSDy5rsijYDjsw5VjoON6Xr3LrH6nqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BADB5sX6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750128990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8em4A7pq4zkoxl4+SoHoK3gZ7HSL3iI/ptfiQrTcddg=;
	b=BADB5sX6V7oWdC+GSV4qR58gSGj6kTFcCVhNp2sYFrWT5YmSiVD26iahmbyFH3EvBWyYma
	WOGvADuT1bbm90ODRERnIs7uE68g/H/Nqgop9mTjtVtx+VeG/nSIiUCVo6I43TvqrXso1A
	5wv3nt+AeKmA+z1aixLlW9B55HMW4qk=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-240-BS_sTFIuN2iuhU_9-c2lAA-1; Mon, 16 Jun 2025 22:56:29 -0400
X-MC-Unique: BS_sTFIuN2iuhU_9-c2lAA-1
X-Mimecast-MFC-AGG-ID: BS_sTFIuN2iuhU_9-c2lAA_1750128988
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-748b4034b42so2692796b3a.3
        for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 19:56:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750128988; x=1750733788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8em4A7pq4zkoxl4+SoHoK3gZ7HSL3iI/ptfiQrTcddg=;
        b=nHSeHaICl0RT2FjUEvGmPP1xe4oNbAm+prA8T5o8k1J0C/jE8qYMvugJFfxbN/QjiF
         jy5ZpDwidgqRUzkyXAqGsZe1XlhrvL4DgP7dLEDpYpkRg78Xs2gUgDxLvvNSBTA6IeSp
         OWpdf8zVq3myxNz4joqv2qLnRVKKZfT/7tOhvRgcEUU0ZlqVNeYDifUBH/q1hbHi29Zl
         Cx+tsBmkLXvkotHDr4XmfIpoUutLlx3tFXZMm+q6LN2TseeXdtemeThgH0trkOIk6Z0x
         WHmoGaYkMfo3ulncUazMPxJIRc5pVMTcgORjsfH144BIbcN7fAVh1fo6mJhNg2PjP12e
         doPg==
X-Forwarded-Encrypted: i=1; AJvYcCVnUA52JJs8rJeEK9Kt/vApNCbqFDy286FQumE0lEPeeWu0e8VljhkVcKZ/xa0xT7rHHhlqJMg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjNYt7nZLn2rvjPzwqAsUydkX9c6Pv4f44JQVKgYSuYsh6E77J
	SCHN8N1/+74FYijaWOukNKCqofoJ1i9P+ocBt0/lof8E4wPsbxq4wC6tBCkZqvUgboqWxvhAf58
	psK+B2KdLNWMjuKLKQwHONGnBei+EvbvzMx4aSUGlR4i8NIblY7Ptq7fIHBkphRMgkOxhC6Io0C
	VzL87xSUDerrUi4eWKAx+sFBwr+OiXQnKB
X-Gm-Gg: ASbGncsumBGy3OSGnCmVhHqxQIBeGXxWDUGSlev4IvJOY1K464Mo5YNsYo8ajgb+w4X
	MdPxeyPDezSlhKR1oGz/SfrGoAN3AU/aomT4q2NmfSmd2b8jTMR2E78aagWNROfyv692/qO7XA+
	G2KA9R
X-Received: by 2002:a05:6a21:9ccb:b0:215:eafc:abda with SMTP id adf61e73a8af0-21fbd4d48f6mr15961883637.18.1750128987948;
        Mon, 16 Jun 2025 19:56:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmKvs3ashIXhvl4F06MUoj1n8XAZ/ED/ywn2cMwN6ojybO/cEkavlGy2xj/Mndplv8WlQ/QcTaM/8HlZf0juQ=
X-Received: by 2002:a05:6a21:9ccb:b0:215:eafc:abda with SMTP id
 adf61e73a8af0-21fbd4d48f6mr15961858637.18.1750128987584; Mon, 16 Jun 2025
 19:56:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1749210083.git.pabeni@redhat.com> <a38c6a4618962237dde1c4077120a3a9d231e2c0.1749210083.git.pabeni@redhat.com>
 <CACGkMEtExmmfmtd0+6YwgjuiWR-T5RvfcnHEbmH=ewqNXHPHYA@mail.gmail.com>
 <b7099b02-f0d4-492c-a15b-2a93a097d3f5@redhat.com> <CACGkMEsuRSOY3xe9=9ONMM3ZBGdyz=5cbTZ0sUp38cYrgtE07w@mail.gmail.com>
 <1f0933e0-ab58-41b8-832b-5336618be8b3@redhat.com> <a1a4b28d-2bc2-4968-9e79-18ced60f8cb0@redhat.com>
In-Reply-To: <a1a4b28d-2bc2-4968-9e79-18ced60f8cb0@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 17 Jun 2025 10:56:16 +0800
X-Gm-Features: AX0GCFsEgxLkE1I9pNuxrbyZcMhLKa2uMUD3aeue1VEZ3tLrshaL1JSUCnhOAdQ
Message-ID: <CACGkMEtA6nHo2abbBjvfMrH-yfDhi1DJ_MXKtvcWumq-XNuu7A@mail.gmail.com>
Subject: Re: [PATCH RFC v3 7/8] tun: enable gso over UDP tunnel support.
To: Paolo Abeni <pabeni@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Yuri Benditovich <yuri.benditovich@daynix.com>, Akihiko Odaki <akihiko.odaki@daynix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 16, 2025 at 6:43=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 6/16/25 12:17 PM, Paolo Abeni wrote:
> > Anyhow I now see that keeping the UDP GSO related fields offset constan=
t
> > regardless of VIRTIO_NET_F_HASH_REPORT would remove some ambiguity from
> > the relevant control path.
> >
> > I think/hope we are still on time to update the specification clarifyin=
g
> > that, but I'm hesitant to take that path due to the additional
> > (hopefully small) overhead for the data path - and process overhead TBH=
.
> >
> > On the flip (positive) side such action will decouple more this series
> > from the HASH_REPORT support.
>
> Whoops, I did not noticed:
>
> https://lore.kernel.org/virtio-comment/20250401195655.486230-1-kshankar@m=
arvell.com/
> (virtio-spec commit 8d76f64d2198b34046fbedc3c835a6f75336a440 and
> specifically:
>
> """
> When calculating the size of \field{struct virtio_net_hdr}, the driver
> MUST consider all the fields inclusive up to \field{padding_reserved_2}
> // ...
> i.e. 24 bytes if VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO is negotiated or up to
> \field{padding_reserved}
> """
>
> that is, UDP related fields are always in a fixed position, regardless
> of VIRTIO_NET_F_HASH_REPORT (and other previous discussion not captured
> in the spec clearly enough).

This is why I feel strange when reading the patches. Everything would
be simplified if the offset is fixed.

>
> TL;DR: please scratch my previous comment above, I'll update the patches
> accordingly (fixed UDP GSO field offset).
>
> /P
>

Thanks


