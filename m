Return-Path: <netdev+bounces-106398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 216CC91615F
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 10:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D00562813FA
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 08:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D39E149C42;
	Tue, 25 Jun 2024 08:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VAgvPNBt"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97047149C41
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 08:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719304385; cv=none; b=J042V8+TwLDoiXP8xEqUjhzM7UYCULe1E5AfGXRxMdxDaOMl7Kn1SvjhKKvkptxIq128SswByOM1wa/1FUEe3Eb6qV+dBXYbmr0SHjiRjEBOUb7qVPWWkf7t9EG8AcIlh0ysDP89q/oJ5WGv9xZuP/0+7B0uo3iCWv/T2j3HnOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719304385; c=relaxed/simple;
	bh=RWnZq6/e1o8ODqj7cwxxBBd2E4goPZtqioAyVQQcqSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OWTu58SCh31BStH8RO6Dlz3Vd+zQ9VTARESg/QLakDB36j0LhGNY8lP9oo40qe97SW7bSjoD3czSeh6YDCXwRZFabKHyz2XatKMAMgjl8dT2gIOX8nhTKjGU/zjCcdba9tCgcz3hjqKPhZGeETQhxjAQ44OvTJn7wAHSW28nO3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VAgvPNBt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719304383;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kmuQcBhqdbQliLKyKkeXS3WXDCp2XThxY79yU+S5CmA=;
	b=VAgvPNBtHt+rH1WmH5Z37TJT4t0g92i+oBWvm4+760JONmVQSWpxwpDafcukAP9i6/2VSa
	ZI9wjptsPgH83ZnKak93O/PBUE2EeNI+N0ADMj158CFP5pR4USMzmjD0mb4fnd00qMevWT
	ucbb5jFwIizF7ghAfVvo7VqJYvfXzZs=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-heqZe4Q0Os2Yr6Y7qpNy4w-1; Tue, 25 Jun 2024 04:32:52 -0400
X-MC-Unique: heqZe4Q0Os2Yr6Y7qpNy4w-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a72423fa3dcso136888266b.3
        for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 01:32:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719304371; x=1719909171;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kmuQcBhqdbQliLKyKkeXS3WXDCp2XThxY79yU+S5CmA=;
        b=tap4emsQchBfu9GFcZ3ne0LTu2ea3CP8uDbLqpccYR+rXgsQp1HptCjhDLk4kth3RB
         wBjkCP8QJiEX9RH0js38imgaDiic0oaiQhTcIg/0z+SngOvfyP7ks4EpeH82yiD8PdQ4
         Ld9/vEZcIeTRuD4KwO26wpIn2dRvp+3cRI4p9WqWXrVYkgovZ1yhPW12ruUKTKNw2f+m
         anPToQJ81YSCaWt/n9T1xLQZcUtMuzlxP3AFfl42+zxWzhCa7E/1gAIVGhvnKtoTPi+j
         CkXxtUiBQLHRqFJilMchyMiz9n33NXMWAq2OGQxGGxCKNCzXV2gfqGx92S1cpLEhnsWt
         EMfA==
X-Forwarded-Encrypted: i=1; AJvYcCWesOmazr9DroBcBJvmpShGZXvJtJpExYyZbgOV5lfEPFHuNPrVIcsEVcdwVze2CVoGz9X2sg8L2hPAyzQ0uLvtjE3nBbrI
X-Gm-Message-State: AOJu0YyIqZiIAkvWUi/2/vcM5VaF+5cphrte/5FeJQMbmEA2uIDmatXg
	XC1wembVHxGJ/KOBOm9mINr0RNhr7rCvsowXGreQzrNK9wJ2aIOz8rIa8gvhnLQSx/8cDWnT9Zo
	sam985UGD31NYhmHF31Ns8nfV1HPiejwe20FjiPETqy1gpyJQ0rpwnA==
X-Received: by 2002:a17:907:a4c8:b0:a72:5fd5:ea02 with SMTP id a640c23a62f3a-a725fd5ec00mr300909766b.10.1719304371446;
        Tue, 25 Jun 2024 01:32:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKGLvgEEpYliYHX2+LzsnrTLSKm1BWp3FNYDFymgqiF0mmHfghVSDUyJ+9zJAMv1pBABF97A==
X-Received: by 2002:a17:907:a4c8:b0:a72:5fd5:ea02 with SMTP id a640c23a62f3a-a725fd5ec00mr300906066b.10.1719304370721;
        Tue, 25 Jun 2024 01:32:50 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:342:f1b5:a48c:a59a:c1d6:8d0a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6fe779bc80sm366832266b.174.2024.06.25.01.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 01:32:50 -0700 (PDT)
Date: Tue, 25 Jun 2024 04:32:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, venkat.x.venkatsubra@oracle.com,
	gia-khanh.nguyen@oracle.com
Subject: Re: [PATCH V2 3/3] virtio-net: synchronize operstate with admin
 state on up/down
Message-ID: <20240625043206-mutt-send-email-mst@kernel.org>
References: <20240624024523.34272-1-jasowang@redhat.com>
 <20240624024523.34272-4-jasowang@redhat.com>
 <20240624060057-mutt-send-email-mst@kernel.org>
 <CACGkMEsysbded3xvU=qq6L_SmR0jmfvXdbthpZ0ERJoQhveZ3w@mail.gmail.com>
 <20240625031455-mutt-send-email-mst@kernel.org>
 <CACGkMEt4qnbiotLgBx+jHBSsd-k0UAVSxjHovfXk6iGd6uSCPg@mail.gmail.com>
 <20240625035638-mutt-send-email-mst@kernel.org>
 <CACGkMEtY1waRRWOKvmq36Wxio3tUGbTooTe-QqCMBFVDjOW-8w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEtY1waRRWOKvmq36Wxio3tUGbTooTe-QqCMBFVDjOW-8w@mail.gmail.com>

On Tue, Jun 25, 2024 at 04:11:05PM +0800, Jason Wang wrote:
> On Tue, Jun 25, 2024 at 3:57 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Tue, Jun 25, 2024 at 03:46:44PM +0800, Jason Wang wrote:
> > > Workqueue is used to serialize those so we won't lose any change.
> >
> > So we don't need to re-read then?
> >
> 
> We might have to re-read but I don't get why it is a problem for us.
> 
> Thanks

I don't think each ethtool command should force a full config read,
is what I mean. Only do it if really needed.

-- 
MST


