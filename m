Return-Path: <netdev+bounces-149256-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A3359E4E7E
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 08:33:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A19431678FA
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 07:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA151AAE09;
	Thu,  5 Dec 2024 07:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nd9jNfSb"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5911B1D65
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 07:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733383991; cv=none; b=IULJx0nYoVdOFJs1yGEa5L7ol1ceAxAzsOQK/ZR12yqk8a0tMjGayn6Cx40wLJ0meEi/fyGO4Pgh5EAe3WdQ+jNtcShpgbpI2WevubdjPPsB013CK8QXSCh9UBxSFKl8czGkglSXDUP0vfiLj3dzY9f40ngyLT33Q7yLdhLn6wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733383991; c=relaxed/simple;
	bh=3vovcjPsrqh8Ljoz6njJUjJy7BIdDFIT/rdglPI+fT4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bk5RBSWcne959Sjzeu2MHcos8sytonqLmXOI4lLblTpl1i2SXYrfR3oeX7GlKj+Wf13rh63t9kZeb5rK2k/aUC7dyTPKRr78JOhLWT9qEGHCY5/Loege+kueqmk28En4om4PV2VKKbHmpOGuyNKEddTF6XhJexd8HdXiTOQgEZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nd9jNfSb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733383988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3vovcjPsrqh8Ljoz6njJUjJy7BIdDFIT/rdglPI+fT4=;
	b=Nd9jNfSbQ0UonuzeStYfyb7x5PYgYiYHeDKs2dib0KCaMP7kG6Mxd5k560CeQKpW4RLTvn
	C/AdY6wDr+wkiPruPn9xQ1b6NOPEyePsP+kLst5fINEdGHrJFEbMvuWZhdelhdwgnwwXNu
	7u+ktFlBkzqLWH6uw4lmX2+5jZqZpoQ=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-445-AnjrOJWmMVqlKYZP7fWAPA-1; Thu, 05 Dec 2024 02:33:07 -0500
X-MC-Unique: AnjrOJWmMVqlKYZP7fWAPA-1
X-Mimecast-MFC-AGG-ID: AnjrOJWmMVqlKYZP7fWAPA
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3ea46b9ddbeso457158b6e.0
        for <netdev@vger.kernel.org>; Wed, 04 Dec 2024 23:33:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733383986; x=1733988786;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3vovcjPsrqh8Ljoz6njJUjJy7BIdDFIT/rdglPI+fT4=;
        b=lyS4fu7sgSMrc6Y5aO/UrcF4Jn2MUAVnfyjpB9V42rJNdZejM5IV4BtHe5O5gBImS1
         GRt5dFQwtyUHJ/EyyQXMj6hVeiCUFJqK9xr+xGK1dCU8R5mXWat18sBcElWgRbfWqGyB
         vDTZexIzXkHv17GkSwwjK6ISOfNP0AD/4i/BSBAk74CxlbzagUnXufykziRndGPR08og
         7zgBVVGKGmk6K+Dxhrh0OnjlXKZcn4mJzXakZujx3lKUev+XUL2+L9Mdm8E6heDXJMmY
         r+etb9+kkhUY1N2H/YxtNnSnhsv/IE9tRk3+FjvwK6S4PmCpuQkJd0hpjlJQ/GLiw4xU
         kVww==
X-Forwarded-Encrypted: i=1; AJvYcCW3o2PSy+B7yMFV4ztFFq1pcIdmoZYmyW8UZDDE6vS9Zgt8rZbmeGIA5t3PD/3poZ+Lbx0+QOM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZRFe8+4/AvqHFQLSH/7LJJJbccdeh6SQYRvPwRKiX045/j+WM
	uTaS4YU9OamybzAkgNRIE3PDb+OW7wj2EtcFErrgTDebKZBPI0ev+SlxqTfT4IyAXzGOF5OfjMM
	ql5X62+IRee6Wpq2rchmefT1olc6vqPQYsRsP5OmjKZiNjJvqXolLJt24v53hxrZevZ+WUlbLmY
	TlzCAOwHMRIQplEqBZnuJUwa/fg4I6TNmTNK5sygM=
X-Gm-Gg: ASbGncvfpcPkDR8F3runWMS245wWuiVg+vtLTPgR8rHhEF0JADzHi/2+9g/ymUrivsW
	6OOYJgv1dENARXyguJ72hhM2QNOBOijUt
X-Received: by 2002:a05:6808:2e92:b0:3ea:6a8b:a40f with SMTP id 5614622812f47-3eae4f8872emr6192182b6e.25.1733383986623;
        Wed, 04 Dec 2024 23:33:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHDtQDoQaqM+3b+ntK9dqohRIca4r56a555HOpzjVOkBG5XoAIkxz5R1IAjDQ0aajFWY1uYgAI/ZNkMsaHUSWY=
X-Received: by 2002:a17:90b:1b4e:b0:2ee:8abd:7254 with SMTP id
 98e67ed59e1d1-2ef012748damr12711858a91.36.1733383974938; Wed, 04 Dec 2024
 23:32:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204050724.307544-1-koichiro.den@canonical.com> <20241204050724.307544-7-koichiro.den@canonical.com>
In-Reply-To: <20241204050724.307544-7-koichiro.den@canonical.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 5 Dec 2024 15:32:43 +0800
Message-ID: <CACGkMEtkabmYmepsx-dyTbTJKq4RUh7fPVT6YubS6RFQD35XMg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 6/7] virtio_ring: add a func argument
 'recycle_done' to virtqueue_reset()
To: Koichiro Den <koichiro.den@canonical.com>
Cc: virtualization@lists.linux.dev, mst@redhat.com, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jiri@resnulli.us, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 1:08=E2=80=AFPM Koichiro Den <koichiro.den@canonical=
.com> wrote:
>
> When virtqueue_reset() has actually recycled all unused buffers,
> additional work may be required in some cases. Relying solely on its
> return status is fragile, so introduce a new function argument
> 'recycle_done', which is invoked when it really occurs.
>
> Signed-off-by: Koichiro Den <koichiro.den@canonical.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


