Return-Path: <netdev+bounces-188586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A00AADA1C
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 10:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B7564E8735
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 08:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41D2221D9B;
	Wed,  7 May 2025 08:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OUIMMkv/"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C217D221725
	for <netdev@vger.kernel.org>; Wed,  7 May 2025 08:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746606385; cv=none; b=r0eVrv8NMs8L11cITv2JAx/zWRqaoOTdb7J+uV7V1qerO/668OS0TNq1SsKkJkyinGZ3RxlaINYx41XgeYkyh95P3e2/Pvrh1Tazv/57njVyfzk++v2j6fNyZ4q1yThetF/B3cM2Rx2HQrLkIgPj4XcbdzD42+OlclV1d7G+4FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746606385; c=relaxed/simple;
	bh=kI/+C74UWcLguN5EGGJ+R2TAzXqsPpk/1uAJ5swPJvk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DvTDWKC1jtjigBqFKH4lC0ZEXYOnbbVfiTcr/SOKpnQ/lYVS/AafDrrSrKvCVRWF5uJKRhDZX8PWbXaXqqCNsheQ6K30Kp3OprA7dSCZXYtkDXh8dSrFiS3gB3DIdbA8XzoWz7qbmGSjcpJKpv4rEuKHSlkQDH0L1io/Jf17fj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OUIMMkv/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746606382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kI/+C74UWcLguN5EGGJ+R2TAzXqsPpk/1uAJ5swPJvk=;
	b=OUIMMkv/AI/inIuYqMfpEOWMKmjIPo4i7q5DNbYsGAOzOsOD5Cxe6qgBIZpdwch152Qmqb
	dpXz7RGfoi346E6/NZrGs1qBSxdtgM56E0LS/NFbtxgpwZX8QbjdRCK08mrUPkpRAfL3mc
	ZE451nfX4aK/RMg7sQQ/kAuGX6XbCGw=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-cgJy9eFbN_K1QZCrxR4Wfw-1; Wed, 07 May 2025 04:26:21 -0400
X-MC-Unique: cgJy9eFbN_K1QZCrxR4Wfw-1
X-Mimecast-MFC-AGG-ID: cgJy9eFbN_K1QZCrxR4Wfw_1746606381
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-70552c16b9cso66045297b3.3
        for <netdev@vger.kernel.org>; Wed, 07 May 2025 01:26:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746606381; x=1747211181;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kI/+C74UWcLguN5EGGJ+R2TAzXqsPpk/1uAJ5swPJvk=;
        b=mVUsD9Q5ANhhL//FCheYyrVw4fdOXvWnz9CgUhqxFRVGNhrZnGifgvB5icdSzMTvte
         gyPOtKwxc2prM+n2WYkvC38gakp/vsPomiuMbzJ4AqyTzLADJiFEcN7FQpfcHs2s5FFH
         ZYUHSJMoiuw+ro4aWB4iW1n4zvIzyHV1kScwFd2dzWV/cct1xZ4QWK6daJSUMW18YRH3
         6tx6HaBXSSQ8+irV/iXgGDG9CA/RpOfLNe06/iV85JGVjS26UvHqrfvnkmTbS3nKLtcG
         Bu5peOIRSoJWRYW2fYmExQFI1JwPFUks68MOZ2zNqeZUEMlxzS0cV9APGOyxhdzSQ1UI
         4yOg==
X-Forwarded-Encrypted: i=1; AJvYcCUU/QchTV7dxQxRsaeG1SjinGo8fQekvU15BBxSKEjSFsqzSPsV69GkqFbI5jTrGhej5EeT6Fo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDi060+FCKRrIxfhv7syXQ/BUHpmYlfVG51fTqSU/BPW1x4TDx
	pKgaqMsiAEY88HjMLeKU55d/+WuWA5wL6A51mcS161MbYvP5HCe5IPGS1Nvf2T6THVHChizJpbs
	yqtHo2rcvBEI0WaOw/CboyEPy48wV8JlcWKUJqqyudePAcGUuDgy++TFit7+Ofv1cNNgHJk0vMR
	C2rUiI8H9MYNlbp4+dftpYYTpjA+7j
X-Gm-Gg: ASbGncvn2LRQLctUMy4t6LKXyrmBs8xMt+Iz9rbdMWav6zJOVDInUw+Zh5uz8efxndJ
	xUNBu8mAAmvf6izyGA6diLieqs2rYzfQv7hNQKQOIGwix+f3cggwgh+NlDaYDpGQYhiTjgw==
X-Received: by 2002:a05:690c:370a:b0:6fb:1c5a:80ea with SMTP id 00721157ae682-70a1db49713mr32558657b3.32.1746606380968;
        Wed, 07 May 2025 01:26:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpSC+1ia23pV+uJD2D52bGeABFvUueMfJwumFcd11s+v7+rdS8w8k4nrnN2Jgii7JxOzEH02Xj8URwB0gtc2E=
X-Received: by 2002:a05:690c:370a:b0:6fb:1c5a:80ea with SMTP id
 00721157ae682-70a1db49713mr32558377b3.32.1746606380608; Wed, 07 May 2025
 01:26:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250501-vsock-linger-v4-0-beabbd8a0847@rbox.co>
 <20250501-vsock-linger-v4-3-beabbd8a0847@rbox.co> <g5wemyogxthe43rkigufv7p5wrkegbdxbleujlsrk45dmbmm4l@qdynsbqfjwbk>
 <CAGxU2F59O7QK2Q7TeaP6GU9wHrDMTpcO94TKz72UQndXfgNLVA@mail.gmail.com> <ff959c3e-4c47-4f93-8ab8-32446bb0e0d0@rbox.co>
In-Reply-To: <ff959c3e-4c47-4f93-8ab8-32446bb0e0d0@rbox.co>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Wed, 7 May 2025 10:26:09 +0200
X-Gm-Features: ATxdqUFUbB7EP5EYdD3-nw2ShhvzgoAnjnkJi00OTnfe2xCzejcrLy_1225Kq5I
Message-ID: <CAGxU2F77OT5_Pd6EUF1QcvPDC38e-nuhfwKmPSTau262Eey5vQ@mail.gmail.com>
Subject: Re: [PATCH net-next v4 3/3] vsock/test: Expand linger test to ensure
 close() does not misbehave
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 7 May 2025 at 00:47, Michal Luczaj <mhal@rbox.co> wrote:
>
> On 5/6/25 11:46, Stefano Garzarella wrote:
> > On Tue, 6 May 2025 at 11:43, Stefano Garzarella <sgarzare@redhat.com> wrote:
> >>
> >> On Thu, May 01, 2025 at 10:05:24AM +0200, Michal Luczaj wrote:
> >>> There was an issue with SO_LINGER: instead of blocking until all queued
> >>> messages for the socket have been successfully sent (or the linger timeout
> >>> has been reached), close() would block until packets were handled by the
> >>> peer.
> >>
> >> This is a new behaviour that only new kernels will follow, so I think
> >> it is better to add a new test instead of extending a pre-existing test
> >> that we described as "SOCK_STREAM SO_LINGER null-ptr-deref".
> >>
> >> The old test should continue to check the null-ptr-deref also for old
> >> kernels, while the new test will check the new behaviour, so we can skip
> >> the new test while testing an old kernel.
>
> Right, I'll split it.
>
> > I also saw that we don't have any test to verify that actually the
> > lingering is working, should we add it since we are touching it?
>
> Yeah, I agree we should. Do you have any suggestion how this could be done
> reliably?

Can we play with SO_VM_SOCKETS_BUFFER_SIZE like in credit-update tests?

One peer can set it (e.g. to 1k), accept the connection, but without
read anything. The other peer can set the linger timeout, send more
bytes than the buffer size set by the receiver.
At this point the extra bytes should stay on the sender socket buffer,
so we can do the close() and it should time out, and we can check if
it happens.

WDYT?

Thanks,
Stefano


