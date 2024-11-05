Return-Path: <netdev+bounces-141870-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 153E79BC930
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 10:32:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77D15B2163F
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 09:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819871D0784;
	Tue,  5 Nov 2024 09:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="grX96xee"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE4D1CDA26
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 09:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730799148; cv=none; b=bHdu7DINuZJiYV7f5L8I51N1RoRzvFc6IOI131OMS00JlLYBYYoSMVbgxu0c2P5cBaKDaiVNdw0wukTi3yGTJ/oA185CbdsnMPWi8s0pfmToHvQwVzf7UIKsK3Ig2JCd29/MLcjxLs5/tCG9Hs8uGDh67F1aC4JBr8oG+ftIBss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730799148; c=relaxed/simple;
	bh=3boYlIm7+ysYJZ8hI0p5HudoZgakBgOBlMRjSuXyXRI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mdtUyBYdi650BofTc+HT60Fy8iIY3KiLUQv2zXQemg4qRh2zZcqFBrq7RGIXCqhPlALWqS9KBUZn20r03eZ5CodfgkV8nSr8jpPxHmkcGz4uzffLoy9ybR7f1FpbyDVwzes3mk0VJrvK6VxSVtoLw6TkPXuULudU435kh8ZzxIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=grX96xee; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730799145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CaELkgjNq5yohIp9CDpDpFO7U1TxTr29on+OWubj13o=;
	b=grX96xee7qCq0ye4CSboji+bGs4Yh5jkzkWAwJXm637///8I9S9ts2PAGnS0OCM7s7LUz+
	2WMfKbe2JqQwhz3DYTuePtlHB22Mvdr849Ncc61fCJFgvbsHhebhew6/ISJeRzfKCEPnMr
	WsacZRUZ+h0u8CZNS8ryNbaYsmRp7dI=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-gznQYOl-N2WhefIEMWccRA-1; Tue, 05 Nov 2024 04:32:23 -0500
X-MC-Unique: gznQYOl-N2WhefIEMWccRA-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2e3912db200so6679677a91.2
        for <netdev@vger.kernel.org>; Tue, 05 Nov 2024 01:32:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730799143; x=1731403943;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CaELkgjNq5yohIp9CDpDpFO7U1TxTr29on+OWubj13o=;
        b=escrTuVO+37cuAs+FEgx0ddv5BfsHP9jFIy5xS/nDqwHYFafBE/XaXFDabdQkFP3Nw
         v+NOU2LP/QF39RyaP0M243jWi879kC1+68vkyVULYSHqk8F1mX1GkDFoUkvUVJxRW4WQ
         wpkozdHD3FyiJ1g2oj+V0vA6azRp/011Xxx2WldSQKcdFHs86OoZKDrmWCeE34zC6qRr
         hvThMM+Woz2bjQp1o/4vj3bJLelCOdIqpM5wR2208WDWUT57Gd/RZHZW7Fj1O0UvqxCb
         vM3LbMN7+xklisJlm29Cl7e/O7qi8DWSTzRL0M05BNwRGvZRBpie3VLt3M1t6whM+frm
         067g==
X-Forwarded-Encrypted: i=1; AJvYcCUcDbqM553WSqv4m27B2sp8RlxWDQmWKkINtWZS9lGAmozup+j36lGbOp533pAU8c6xNY94IZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTPU2vbPIKlD+1ZsPjR9F7VHEPC2cr9clWbC8XgLuDQiTxbQ4V
	3K+LdOLnfW8PDdP27wUArx8URa0swVfFWqQE9wErXqjEUMgTMp5Z9oYrIqelVRXb31NPdMigcpt
	I2u3NS7ytqD8+DOsqRixHf6sXeCywAVlcac9V/Ie1JFsEzNmjLLHLp3R2sSbsse77Y1g6B9sEg+
	y+9JB4+tWR0FNksw0GdAoT+0QBlp0l
X-Received: by 2002:a17:90b:164f:b0:2e2:bfb0:c06 with SMTP id 98e67ed59e1d1-2e94c2b086cmr21054742a91.12.1730799142815;
        Tue, 05 Nov 2024 01:32:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFrI2dYkCr6bnvyp62rgLDstJjcAcnHOsb+T5y5D8ck5xShQL7y314TViGgIjvrllU676F8agf4RY2ewZHmgK4=
X-Received: by 2002:a17:90b:164f:b0:2e2:bfb0:c06 with SMTP id
 98e67ed59e1d1-2e94c2b086cmr21054719a91.12.1730799142429; Tue, 05 Nov 2024
 01:32:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105072642.898710-1-lulu@redhat.com> <20241105072642.898710-2-lulu@redhat.com>
In-Reply-To: <20241105072642.898710-2-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 5 Nov 2024 17:32:10 +0800
Message-ID: <CACGkMEveK1uOg=Hq2WuYFW7+DbMoF_g6QjV5cUFkBHUEQXkcow@mail.gmail.com>
Subject: Re: [PATCH v3 1/9] vhost: Add a new parameter to allow user select kthread
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 3:27=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> The vhost now uses vhost_task and workers as a child of the owner thread.
> While this aligns with containerization principles,it confuses some legac=
y
> userspace app, Therefore, we are reintroducing kthread API support.
>
> Introduce a new parameter to enable users to choose between
> kthread and task mode. This will be exposed by module_param() later.
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  drivers/vhost/vhost.c | 2 ++
>  drivers/vhost/vhost.h | 1 +
>  2 files changed, 3 insertions(+)
>
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 9ac25d08f473..eff6acbbb63b 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -41,6 +41,7 @@ static int max_iotlb_entries =3D 2048;
>  module_param(max_iotlb_entries, int, 0444);
>  MODULE_PARM_DESC(max_iotlb_entries,
>         "Maximum number of iotlb entries. (default: 2048)");
> +static bool inherit_owner_default =3D true;

I wonder how management can make a decision for this value.

Thanks


