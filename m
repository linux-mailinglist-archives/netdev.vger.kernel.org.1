Return-Path: <netdev+bounces-211391-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE4FB1881F
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 22:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F6C77A4FCB
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 20:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02BA121CC43;
	Fri,  1 Aug 2025 20:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WfeXK+oY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C47184524
	for <netdev@vger.kernel.org>; Fri,  1 Aug 2025 20:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754080162; cv=none; b=GJed9OQt9GoaHEC7bn+k9N1+Tf86EBhiuYN5Wsf0T00kc555NdldtwxjNeDWKxRC1W725j+lFWAo7TRQLrOtD787LLzqRXT+VOaowyE+UXNNgzZL5p4+iZ3KfmjpMNvM589q9SlzVuoLs4Cj72WrfwQzM382LZszvyWod1Lh7WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754080162; c=relaxed/simple;
	bh=ft1GtVlHTumH5n9zAoqypec1LBFsX5MTL+yaj3JjcSc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ALrNcwvVrYvEbTlPh7Xi/tE6G34sfzZ5hhcv5L+LnwBZ0iCXUbFFzg+GJOt+gvmy5B4IvYeMaFvTzv+vY1SJliAD8wVJ2Fv3/X0hbhK17vig1+CPPU5kVrFa21aGU4VCQ/A5iLzRqY2jzoZjVVYEm8zwzJDECQagnJqz6ZxDAiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=WfeXK+oY; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ae360b6249fso465111566b.1
        for <netdev@vger.kernel.org>; Fri, 01 Aug 2025 13:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1754080159; x=1754684959; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QXkdEcm3dcCFEHiiyHz9se6bX6iRUxFV0EivrOFS6/U=;
        b=WfeXK+oYRn6j5R2iAmMTFgJ1Ahhv77nVJEhICqjrQZO5VIqUMdCs5h+qtyyK8lDzcu
         TTy2Pt6c4lmSKtJt+Hh8fXb7zdDSFSe2d3bS22JZAVu3k0jb8A3ZynqvJwqFKA8mG/Oi
         EgjtDI08AMIjjtMopBspUDGL2tuYUM9ZRIZOQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754080159; x=1754684959;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QXkdEcm3dcCFEHiiyHz9se6bX6iRUxFV0EivrOFS6/U=;
        b=X+7HMtvPfAPCShVETMNPlPNwy13G5xLIdPoNlsaYxVJJfYg8SBUeRf5xnmU5CYCA3d
         ASRcnzyOaGp2TVgI8xrsUsTDzAatSjsO4c07aPGtz3m9vCh/Qs1vs4EUsl4h9seB/thR
         HQdtWoHU2WU3OgBodRQQ65CgJHjJeaQci9wbNd2ngF4+UR1cSEwy6RfcrtC86+3kXQle
         j+dogtxKBF0kzgewrHwsrywyvAxaL99T4ao8EO8XA883RUhbMhPyi1bHVWIByfKosbVF
         UXVRzNCB7nh8E085jYVqPCW6mOvZwUZAFi7FsOSYqQxMqaIhjBuZajP4Z/lfLfLCHqdi
         vikw==
X-Forwarded-Encrypted: i=1; AJvYcCXmvl1nYwYbZn0gTft1Y1LZW6qQT+mzGP2al4Ea8m1KVz+mdOEs2y1Zpy+B/fGDQD5GBLYrQoU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMH4JtjfED7gVwzmRJzBKO2yu0oBoVSrjvb8BMcXbIhgHnoKys
	av9Nsl18qt4E5Yef4yQLUpe0/Co0djQ6gvFWpP5HwCAD6/GlRNFXhjryLdKCNof15aIGtOaP0sI
	ru4NZ8Xg=
X-Gm-Gg: ASbGncvNkNSmUbOcr7gWOWNm1GDQ+YSQ14r/yFBwzh43UmkPj8KXbHGzBSMG70X/QmF
	2HosKy+dRse/GLpZ5jedkoXg92mch53UMX9wsPk61/a2tE3SKzn6QTNwD9SwGJmRIQukkb0HAsc
	mhQIjCxXgWEBhDnn80+xXyqMu0DsF33tq4cDjg/Vwfp4YwfJGPBW3qcYS6jajBx+bkiYG7E3QaM
	YMDAct3ZDBcA2QySny3TyMcRV8i/ActwIxCm9drxqvK5cApTuEAYUROOHjql7ke6Nar0KgzogDU
	oXSISSslFPfcpC0x2s3gWHT3b+3Brgx58P2X+qzHOf3JlAoX7s3VF7O5x7jsk1G1eGU0YN8qKCC
	VRJFwAyAO9PMerGl45O5NpsTmvLhQuknXI4fpFQoDcPDnSYr5dThqx37fy6uQg5ZILaMhWbYs
X-Google-Smtp-Source: AGHT+IGWKietm515PWOtaTlKun8I8Lq2cwVfsBoQ+0E7Cctz71ElaVuz93cr61W1DqDdPydMrBmpJQ==
X-Received: by 2002:a17:907:1ca7:b0:ae3:6f35:36fe with SMTP id a640c23a62f3a-af94020a38bmr127449966b.47.1754080158954;
        Fri, 01 Aug 2025 13:29:18 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a218ab4sm333456066b.92.2025.08.01.13.29.18
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Aug 2025 13:29:18 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-61592ff5ebbso4333194a12.3
        for <netdev@vger.kernel.org>; Fri, 01 Aug 2025 13:29:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVrtmFrkAhw0Eo2uLQNbNpS2v2Z6uUH4usAPEF6deLdxkGxlV53j+V814Rk46eQe4G3XdjBGBQ=@vger.kernel.org
X-Received: by 2002:aa7:cb0d:0:b0:615:8012:a365 with SMTP id
 4fb4d7f45d1cf-615e715f7a6mr469886a12.25.1754080158122; Fri, 01 Aug 2025
 13:29:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250801091318-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250801091318-mutt-send-email-mst@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 1 Aug 2025 13:29:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=whgYijnRXoAxbYLsceWFWC8B8in17WOws5-ojsAkdrqTg@mail.gmail.com>
X-Gm-Features: Ac12FXxywlhxHC92NneGnmmt5Hm9rlPrKO5mJOfIsb2I5ZMf5olIOr9KL1pDLfc
Message-ID: <CAHk-=whgYijnRXoAxbYLsceWFWC8B8in17WOws5-ojsAkdrqTg@mail.gmail.com>
Subject: Re: [GIT PULL v2] virtio, vhost: features, fixes
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	alok.a.tiwari@oracle.com, anders.roxell@linaro.org, dtatulea@nvidia.com, 
	eperezma@redhat.com, eric.auger@redhat.com, jasowang@redhat.com, 
	jonah.palmer@oracle.com, kraxel@redhat.com, leiyang@redhat.com, 
	linux@treblig.org, lulu@redhat.com, michael.christie@oracle.com, 
	parav@nvidia.com, si-wei.liu@oracle.com, stable@vger.kernel.org, 
	viresh.kumar@linaro.org, wangyuli@uniontech.com, will@kernel.org, 
	wquan@redhat.com, xiaopei01@kylinos.cn
Content-Type: text/plain; charset="UTF-8"

On Fri, 1 Aug 2025 at 06:13, Michael S. Tsirkin <mst@redhat.com> wrote:
>
>         drop commits that I put in there by mistake. Sorry!

Not only does this mean they were all recently rebased, absolutely
*NONE* of this has been in linux-next as fat as I can tell. Not in a
rebased form _or_ in the pre-rebased form.

So no. This is not acceptable, you can try again next time when you do
it properly.

            Linus

