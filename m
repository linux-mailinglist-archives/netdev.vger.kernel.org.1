Return-Path: <netdev+bounces-87770-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8AB8A488B
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 08:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE83C283D75
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 06:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F2420315;
	Mon, 15 Apr 2024 06:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CPfoXfsn"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B56200BF
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 06:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713164303; cv=none; b=tg7C/W8A8eAn/PdeKcuP4uQFhWm4QdKe0yB4WYmAklKBmfLaFNI7rL4uV4W3zTbGf2dsHHLCNg0MeCBXJkx0rGFgdge3nkNR2TVk2LEplS2FtByt6IwRf+W7zOwFeKp580EcP99NZAiczyiUruk+xsE7Cw7F2Q/pT2BfKq7mCtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713164303; c=relaxed/simple;
	bh=8zRocQO/rRgL1qKa5DTF7pfCxE7+mgM0HcYZDkfYtek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u3URCIMbSr44uRV5o2niP75POfuFLBedr7rLVxhn/ARNC2rhC5ApyDa5tsBNY88rOf+5M5zMT0m2W5bwh3HyliIHHVLbVzlCv87XZe6SVSUf+2YzQzmX3IFIhGXHAxWtg0kz1IlDOHKNwtPlNZvqVkqvy2GA2iiiTSfulPbLwjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CPfoXfsn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713164300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8zRocQO/rRgL1qKa5DTF7pfCxE7+mgM0HcYZDkfYtek=;
	b=CPfoXfsn0SmyrpHVAW+tBvMWI/siVaRNiB5bWz2yt2cD7q9WuusDG2ealHOf7q+83ld8R3
	BhxfGsBqLbJ1AiIlLa3VoNLAVpZaJYcTeJVWuxYSPumY2ZqOQJY2MqEOEhryv/W700tmc4
	ZBsS4WU+VqPQPyPsUIwE4wx4+SbgxvI=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-375-3gt0HA-0MWamHdzVhtfGMg-1; Mon, 15 Apr 2024 02:58:17 -0400
X-MC-Unique: 3gt0HA-0MWamHdzVhtfGMg-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5ca4ee5b97aso1550841a12.1
        for <netdev@vger.kernel.org>; Sun, 14 Apr 2024 23:58:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713164296; x=1713769096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8zRocQO/rRgL1qKa5DTF7pfCxE7+mgM0HcYZDkfYtek=;
        b=e9wGMw7N7LDJzsq73DVgDb3dYmnO8pv4xaIgsq0Ctd6VAlBWCW6o7p+aMswmuz6Tvp
         7ssHgh4uC2znNfNH9/I69jcGZglimwnjsBCK/PgUaxIbIAFepj9Kt/9Mc5ldxW3boJ6l
         Taj0RhzMtbQ1K4dNz7/pLormaEGmpOOoBzdlgCBpVevek74WOaDSnXFy4A6UTxIY+D/u
         zvzQ+IU/kG285QczOjgYhN5T99C5GvHdfTI/42bs6XYXUREPhnR+NI/l/3t0CHIn2Wff
         8m3RsQa8Qm4oUG1O56dGEZDBKzDmQ/o4oh5uhOjOBFP6FWGT/fam7HPR2GfXFnKBmMlL
         bmGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZgnbDFoUPOdsmT1JYctUYtbxE98lQP1sZ981NnNdsWK7tFf9Pq0QA6shC97b1WGfocG+bgqCEN4iwQtm1X6Nw0BAC5i+F
X-Gm-Message-State: AOJu0YydKnmDk4CW2RTZvTjVfLWy5Dx3eBuxFKqCOs2ykw8jslIv3xMV
	z0liAYtB4t4SYs/dDb+UR772M3Ic2bKOBiwtfyHh3MDgMBsGE2KYT3nNoYP8MtKj9H+PaTr2CP4
	kIqF4O2exA24IOyvAnzuxuDVD4Mf2GOzi1P7Tgc2o44basyCN2YgjY0nY3bAb+9y2XcM8FGnOBp
	CZTuZw/KSbfr9k7s1LC+5uuk/zxkl4
X-Received: by 2002:a05:6a21:191:b0:1a9:6d96:c700 with SMTP id le17-20020a056a21019100b001a96d96c700mr8932591pzb.48.1713164296261;
        Sun, 14 Apr 2024 23:58:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfCe10Cxttrxe8F4OkPc7KjxC+SFTe/Z0SKvR0xbdRbE8/iQQiMdWF3kDr6DPf/3wtsnu4W5Rb/yh0o2uaUZk=
X-Received: by 2002:a05:6a21:191:b0:1a9:6d96:c700 with SMTP id
 le17-20020a056a21019100b001a96d96c700mr8932578pzb.48.1713164295965; Sun, 14
 Apr 2024 23:58:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <67c2edf49788c27d5f7a49fc701520b9fcf739b5.1713088999.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <67c2edf49788c27d5f7a49fc701520b9fcf739b5.1713088999.git.christophe.jaillet@wanadoo.fr>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 15 Apr 2024 14:58:04 +0800
Message-ID: <CACGkMEtufa6MqWkcsZqHW8eQzj4b2wCh8zFMSAuHkxpWowLmdQ@mail.gmail.com>
Subject: Re: [PATCH v2] vhost-vdpa: Remove usage of the deprecated
 ida_simple_xx() API
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org, Simon Horman <horms@kernel.org>, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 14, 2024 at 6:04=E2=80=AFPM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> ida_alloc() and ida_free() should be preferred to the deprecated
> ida_simple_get() and ida_simple_remove().
>
> Note that the upper limit of ida_simple_get() is exclusive, but the one o=
f
> ida_alloc_max() is inclusive. So a -1 has been added when needed.
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Reviewed-by: Simon Horman <horms@kernel.org>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


