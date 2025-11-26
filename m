Return-Path: <netdev+bounces-241790-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1861C883E3
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 07:18:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B076E3ABAE7
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 06:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC3E314A73;
	Wed, 26 Nov 2025 06:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KhpkS86S";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="swFWGOBn"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77AA347DD
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 06:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764137926; cv=none; b=XSxrFXZyotXFHgsgnbFXMx3q+KSTEyvaB1hLnomBmDOZHjpv8FLXjqrrRKLkU5NUn2oTO+9E+rZX5dDVM5v9AGDntHX7qXZFMMLXTiN93OIdLwC9yNQCxl+hT/uPzEHRqImFbfXkrKGId6mzyknpfrcMO5/UML778pUp79J0lu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764137926; c=relaxed/simple;
	bh=9IyvSK4NGPHO4fuFRUIAoekh2Pyy3yq0MdSh3GgP3u4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nIDSqj1sEansxKV5mJtD4p/BWwiN82WYMWJ04t4xtvQyuuMTGX7kSSEesWHZu0FWgqVJvtH72pK6QulkHEcNiemwOqYYlWX2BE8v9r5cL6kvww2/FObIAr/o/TIlWT3e5Kf29YSgp6KaV+3yqocphfKPj/E7pI7lCa2ATNPyA4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KhpkS86S; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=swFWGOBn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764137923;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k4EAaBQUbKXStRQ2aorpN5sb6DcjtPj0E0lOttGJD0E=;
	b=KhpkS86SpXMOQwDakh5xuiTAgRaFKn1SXBcz5FFqObgXkfvfKoL0T2XddwdF7nWbIL2XNh
	6vFUB4G1d3VXK9sHQxulc63bdK+rWu7F5k/DQHKzmTdV7O/EwG10/vzZ62xnMl88wxuzrf
	yr0Ki7opZUYsqv1p9bToTC2x8+blICc=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-w-dXtEW0OmSFMzdzvYKgxw-1; Wed, 26 Nov 2025 01:18:40 -0500
X-MC-Unique: w-dXtEW0OmSFMzdzvYKgxw-1
X-Mimecast-MFC-AGG-ID: w-dXtEW0OmSFMzdzvYKgxw_1764137920
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3438b1220bcso6780021a91.2
        for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 22:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764137919; x=1764742719; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k4EAaBQUbKXStRQ2aorpN5sb6DcjtPj0E0lOttGJD0E=;
        b=swFWGOBn3vVHCYFwL35fL63bcPfobOWfrFQUJOpORH8m+T09XEy87gHcD4eiN5C+0j
         qf2ouvR56rldegVgXkc28VVQmPX7k1i74DXw3U8HhOjzWmRnrfYfjiRolKPvPjgIm1O5
         KRwcOo57HxgA2W4ZKSRCrUh1GJOC5IJM7vd/IyUOn4z2hiBFbloOqXVon94yBg2qgefR
         eFwns6zD+vbxwzwhYXyf/POCVrytjKyZxllaRvdJqw8o50aFTIouCPcZ0SXDY9epn0zy
         dK617O4bOk+wfgn8FcMp7YD1C/RZLZWS+Sq9Q6YVVCvI9uVCpfpxIwwyMtTKfu6NnV4c
         ztZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764137919; x=1764742719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k4EAaBQUbKXStRQ2aorpN5sb6DcjtPj0E0lOttGJD0E=;
        b=nNI4dHDhv478hoP/J9x2rlaVImoAXRBlVAjYyxwvjyYozO3/MDfeJU57b5WeuQNeWn
         4k5AO7fqXIJWg+bbESqwKsFKYAiIffjzY6EhZBsMDmE2BSPBj5CUzEx9f7Z+VI5NJXJc
         I0wSyxeNc68X0EUZ/Q0dfMG9Nz2A47+Re3VaZ0ZPDx90X679NPkw8jSg5E7ifZAQ0tQz
         /1iSV5u1IIl7PpAHz6HmeLEAJq4u4hizgmqWZtLD8Y2k1/WQ6w6wQDoFDwrAKQatxMcF
         8hosuuEzZe9UwAABiD38kUOEotoo2bCx5+bfAgvtfZIV9WFcBuATqjvEE+Odnkna2Oen
         j1ZA==
X-Forwarded-Encrypted: i=1; AJvYcCXbxpCWn3noOvpISN27hlMuWEj4eovJQNInriJllcyWSbbD1P8NJmTzgiWhnTSo9YMhaGLtouA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM9OnaxJZCMuTVNXLoXn0TVcGSK25Y5QGto0lbYuSJUpZYCUW2
	FoDuAbXzRpKmInI1UEY38NYN8nQAJmnptSZE2Y4caRHlh7KO8JD9TzUNpWroqScjgZ427c3gTce
	mhmVrrfMsVr18heN8T+hI2CA4nHnovG4DftS/Ww57XSHnDvhiZ4TL9FqrcolILCGEGQiddh8+3I
	taho21AniRi4A7Rj78kP2o+rq5OhXBXE6ACs9ea2NM
X-Gm-Gg: ASbGncsS1YG0UvgKSVw17WuQd/3Upv/L0IQ9JF2z+27R/v4NlR5ZrArouO8sCdvXFYa
	h3+qW3d/RsSCVRZ7rzh3mSIBDqV5vhjFAk2y9/hyXFPMvTJ7yxY2jXxPkocqj9ZljIyFSKUws5m
	a2Bok3MrDImHiQz0JEE/eJBS5d0WfbG7vIVs2FpTOhUbKTj8eEiTWm/qWxlNkjUh50GSU=
X-Received: by 2002:a17:90b:280d:b0:32e:3829:a71c with SMTP id 98e67ed59e1d1-3475ec0f397mr5733496a91.16.1764137919249;
        Tue, 25 Nov 2025 22:18:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHhRJldpd1OviU1vEEpkzZI2Tkr6ToasHRbqSGmjMSAi+R/5zZDXEphzASNpDnCWhFCs+nIjE+SnB6J4DOjgAg=
X-Received: by 2002:a17:90b:280d:b0:32e:3829:a71c with SMTP id
 98e67ed59e1d1-3475ec0f397mr5733479a91.16.1764137918886; Tue, 25 Nov 2025
 22:18:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251120022950.10117-1-jasowang@redhat.com> <20251125194202.49e0eec7@kernel.org>
In-Reply-To: <20251125194202.49e0eec7@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 26 Nov 2025 14:18:25 +0800
X-Gm-Features: AWmQ_bn5sM2oyO_hdA7aO1WikB4cbE8JxiHO9Gu_Ovx5iCRUVPSo0zJRLtZg_zg
Message-ID: <CACGkMEuCgSVpshsdfeTwvRnMiY8WMEt8pT=gJ2A_=oiV188X0Q@mail.gmail.com>
Subject: Re: [PATCH net V2] vhost: rewind next_avail_head while discarding descriptors
To: Jakub Kicinski <kuba@kernel.org>
Cc: mst@redhat.com, eperezma@redhat.com, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 26, 2025 at 11:42=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Thu, 20 Nov 2025 10:29:50 +0800 Jason Wang wrote:
> > Subject: [PATCH net V2] vhost: rewind next_avail_head while discarding =
descriptors
>
> >  drivers/vhost/net.c   | 53 ++++++++++++++++++------------
> >  drivers/vhost/vhost.c | 76 +++++++++++++++++++++++++++++++++++--------
> >  drivers/vhost/vhost.h | 10 +++++-
>
> Hm, is this targeting net because Michael is not planning any more PRs
> for the 6.18 season?

Basically because it touches vhost-net. I need inputs for which tree
we should go for this and future modifications that touch both vhost
core and vhost-net.

Thanks

>


