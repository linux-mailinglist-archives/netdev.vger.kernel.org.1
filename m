Return-Path: <netdev+bounces-207677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE34AB082B7
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 04:03:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B98854E7CA1
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 02:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA791F8677;
	Thu, 17 Jul 2025 02:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cVugw9V9"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5492A1F150A
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 02:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752717799; cv=none; b=k3fued0T/BjwNUmYl6kP+Ep4OIT998ZiQXUen9BOt4bs/7xLoqnYy0ikPXkZi+5Q6P4oaU+w/ORURG6CfW8x/ChfPZfyzh0aKkS17QKZMP11K+MA4jUadcS/uagdUmN+5Kwh6GB4gPMD5PfvGNIl9TyMsbY8QJuLyaypWJgCIMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752717799; c=relaxed/simple;
	bh=nk+vMLXGoyUcWn2gdQ0TtZDnbeL6g7uxU6L7y4/AI3A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fNq1qLd91E9rYAn7/6k87pCtAM1cIdeygcoxZP7MUkt6q2/TkWFZQZtAjQm/k/KGh1aAhqVY+k8DMgh7RHjL6KjXKhw8KzmeNkST38mPhncarR7gtrCo0cq4e2YnusTJ2C/E8MvvoJtM+GpRnmcPf6tE5vlgClu6i83l5JKyUhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cVugw9V9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752717795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nk+vMLXGoyUcWn2gdQ0TtZDnbeL6g7uxU6L7y4/AI3A=;
	b=cVugw9V9vMknb6DHFchGQ6lgpzZ3e3Ub52RlRpsRXIHFpsjITo77bl1zyx/I5ZtsoTvE+d
	5Y6WdF7yyj8kLRBAh6yI9Ll/PMVRtChOssUC9XmGe8fX+eT2G8TDHZK/se4LCTMZXRUvQ5
	Pgjm1ZIHys2EPEUSNNA97bcQWvJta7k=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-350-SwWAZANaOXKTjWZtRdlSZw-1; Wed, 16 Jul 2025 22:03:12 -0400
X-MC-Unique: SwWAZANaOXKTjWZtRdlSZw-1
X-Mimecast-MFC-AGG-ID: SwWAZANaOXKTjWZtRdlSZw_1752717792
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3138e64b3f1so707349a91.3
        for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 19:03:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752717792; x=1753322592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nk+vMLXGoyUcWn2gdQ0TtZDnbeL6g7uxU6L7y4/AI3A=;
        b=Q+mGVcllGsyvUCZZu2WWOR6AI9jFnUZaxvJ6cxO7Td/BQ4sJWv2s51JkLB77bS+Ygz
         NN0jcNmxODMK921wQiqABDDp9e5naHi5uFx2tXKdrYga7VZDTbkIKvGquEGp5oBTjTXN
         QLaRK4pYaZyevM59H0SNp0d6s29SwTH+GEI13sSlpdEY3F+izOXlRyR6AiKCxuJo1CtE
         I80NxV57k9BZDVPzA3jUMxLDHX5I1YugBn4BKzHgtzcGdaufg3JZ3inJ2sAyG1aM4H2g
         /A3Uk5GitWEreQeM7lkS9KkiwzeXC611zyNOFEHvac72ob7m+Ui+yzWHi9Pgmj1Dj9Bi
         OeWA==
X-Forwarded-Encrypted: i=1; AJvYcCUHApb7XSfgESobLY71CQQ0Lr/3HulKpFqRo5i2C625/kZrUjZzPdK/1knPlZTAyercZnPj4Oc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYV+FGgOShvnQLnjUt8rL/BwOjW1iMv+W85PzXRR/ZoCCEtk4Q
	yp2gYyUnkWxLpVHA2fmHfQtrVeU72UyJlO4cPbY8dnopbdITaNROel+ouMPmE2Zvk9FD8yzBDX7
	zK7X1BYJd6DLh76Q45OsVDNgr0SR5zfqQtgd8B0Jyy3BBMrFxh60PeArwYWysp8Ucx4VUr/QXCB
	nLwUGsnpnjlV2cjfMV9ToVidYvIhMYOYv5
X-Gm-Gg: ASbGncs+VwKxLI8r815FACPBh/NJpmbgMLP4lOTlE7nzRzjH375YtOWMoNsfaxG6Ggb
	BfJ2NWuBY+BH0RjjzVtqsK8TH6T/IjAmICweYx281j+LDxrXrxpMAYXQj2MXsDKCARFs+xJR+qC
	JPPiZifF8eMxNMdyqgWUin
X-Received: by 2002:a17:90b:55cb:b0:312:959:dc41 with SMTP id 98e67ed59e1d1-31c9f43747emr6022352a91.27.1752717791917;
        Wed, 16 Jul 2025 19:03:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPKGtWTF3J+7pKYaN1LISu1DbprEzZA/aztw/7OAnQNJPFUO3gk780cKvvzbWsO46X8xOSSRM1m2KLbEldd7Y=
X-Received: by 2002:a17:90b:55cb:b0:312:959:dc41 with SMTP id
 98e67ed59e1d1-31c9f43747emr6022312a91.27.1752717791421; Wed, 16 Jul 2025
 19:03:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714084755.11921-1-jasowang@redhat.com> <20250716170406.637e01f5@kernel.org>
In-Reply-To: <20250716170406.637e01f5@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 17 Jul 2025 10:03:00 +0800
X-Gm-Features: Ac12FXyE_9vIZMY_ERg2TY_jtWvI4UypN_DhHze9LSPtUt7pnoEDW84dnljw5VE
Message-ID: <CACGkMEvj0W98Jc=AB-g8G0J0u5pGAM4mBVCrp3uPLCkc6CK7Ng@mail.gmail.com>
Subject: Re: [PATCH net-next V2 0/3] in order support for vhost-net
To: Jakub Kicinski <kuba@kernel.org>
Cc: mst@redhat.com, eperezma@redhat.com, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jonah.palmer@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2025 at 8:04=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 14 Jul 2025 16:47:52 +0800 Jason Wang wrote:
> > This series implements VIRTIO_F_IN_ORDER support for vhost-net. This
> > feature is designed to improve the performance of the virtio ring by
> > optimizing descriptor processing.
> >
> > Benchmarks show a notable improvement. Please see patch 3 for details.
>
> You tagged these as net-next but just to be clear -- these don't apply
> for us in the current form.
>

Will rebase and send a new version.

Thanks


