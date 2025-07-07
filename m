Return-Path: <netdev+bounces-204457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E630AFAA50
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 05:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17A7B7A50ED
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 03:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9944525A2BF;
	Mon,  7 Jul 2025 03:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F+hz+iNq"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96374259CBC
	for <netdev@vger.kernel.org>; Mon,  7 Jul 2025 03:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751859544; cv=none; b=DaJcMct7R8FvIxt0oX/ml6dfzd/bIOIep53aLxLyt65hZjTv06ERRN0hBm4FCMAi6UtqZv0r9lu7cEblnxuuHT/mK2aUbgDKIWHXsIyPyBctAnJadBzTmZfyb28e35bpGNruPZb5UMiQe1JFzQdnklFeJeLdLGe3URdKTZPoU94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751859544; c=relaxed/simple;
	bh=cToKybjXtrPshKXsvriTLIFQT34mAn7DrvDWsf8sYmc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Coo+OrZHJ8PQtK+NfUa8DPDWKTL9lEk6pooLr8cP50J0rvqy3mrnY/09JkdurM3sHVHIvEBkE98gHIEti8mWP8ZFhK71/umIuu8HRLnljvEijpl5VmTqDLkYEy+Ag5U1PXV2uchW6pkXylPGR9D1VHq4Pe/2OcsGzLQ2BErRhCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F+hz+iNq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751859541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cToKybjXtrPshKXsvriTLIFQT34mAn7DrvDWsf8sYmc=;
	b=F+hz+iNqpFR5zX+hdW73Rq2Gwj3fxSQZJQZJvCrL+isfNclNnQZzXwWy3FNURADIUE+EsY
	UefGbU0+1OJml6CGotDFumULj6ImhDiUapE5VbndRmlwWycbpL7JGth53xhb+NIdAguV7t
	4Kp2YW/xOzKDcoZY/13LpZjbuj9R64c=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-zl8yllJCNKKraoAOj61mLg-1; Sun, 06 Jul 2025 23:38:59 -0400
X-MC-Unique: zl8yllJCNKKraoAOj61mLg-1
X-Mimecast-MFC-AGG-ID: zl8yllJCNKKraoAOj61mLg_1751859539
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-315af0857f2so2572565a91.0
        for <netdev@vger.kernel.org>; Sun, 06 Jul 2025 20:38:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751859539; x=1752464339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cToKybjXtrPshKXsvriTLIFQT34mAn7DrvDWsf8sYmc=;
        b=i08CYSUrMfx6oOMNPgZSpF3+TQRHiGoI6jBvDcIqzKXrZRBP/Je422Yj/mze6FjAII
         to1KaSdYI0pbhWZq7q2gR0FzpO4b0/lWFVsjt2Fb00aCPz3Qjl+v5SKPy05WX3xT9eBc
         Ja4JYVXnpRcaK6iRsyJCrN1vSLfzDfzDKq0+7IOYN15zpM5KYBAr1S6jTUKfEOAib0rE
         XrWrMa1WqEwlwkcrIMACb3L+OYG1o+6RYDiltFLsEsvdKj/y18CV+UxmG3XUOAL/YEic
         zTasNdDccIvepoRSBBuY+0pGokcZZ18/Shb0VFQyXQAw5+lkRBA7poy3+lEUGqQnpKd0
         MC6g==
X-Forwarded-Encrypted: i=1; AJvYcCWLzJwhbdHVlOaXJlo6vrBdn27gZdpKaQlwDO+jD7puf0ZrfjrJ2Sy8CyNBxEExt0dKiS7ogqE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwSMa4I/i8yPJk6BbEDmwxUdKa9Lva0BGdmBRv13I5OEEYbJ+3
	vHAzrcBKDrAb24GjceKAia17nIfEduiFpPKx+Q82UfitsBGPyAdwmgdcgodkRwODSXjWstXsjLf
	WW8pVmD3QfTpFTpCtxnW0Zar3863ms6EjIuZFGjH/NSPdQj5kzu0YXDIv7Z4zV2o3NsVnxzSlEu
	NPeOuR7CKsIt5hy3rw+/asDpdAP73cFMcP
X-Gm-Gg: ASbGnctPA2zi8eRppg4EuHkZqnDEwsFzTRjxm+S12+uTmSy7U6DEHq0bTK7PX5HRxy4
	nl3ABZZzF+tNTIhZvUtp9P/JFESFIQXcsX1AA+xf6dPp6tYLKhT5J9s4Elnkl+LPdkBmBmvO1hD
	+hQ/VK
X-Received: by 2002:a17:90b:55cb:b0:31c:15da:2175 with SMTP id 98e67ed59e1d1-31c15da23cemr1276677a91.9.1751859538653;
        Sun, 06 Jul 2025 20:38:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/OScOfzxvN6ffL+e+JM/H+J3/JdD4csUZUpOcHgC06UuyYVCjZh3kPiyRl4cX84Tq+BwKAeQqS9ePIWOt/tw=
X-Received: by 2002:a17:90b:55cb:b0:31c:15da:2175 with SMTP id
 98e67ed59e1d1-31c15da23cemr1276643a91.9.1751859538244; Sun, 06 Jul 2025
 20:38:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702014139.721-1-liming.wu@jaguarmicro.com>
In-Reply-To: <20250702014139.721-1-liming.wu@jaguarmicro.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 7 Jul 2025 11:38:46 +0800
X-Gm-Features: Ac12FXzRSQJDauDNVYKvCZUnjp7a1__tIs86dizLjOKq_h5WbWMweaIbaRJmiis
Message-ID: <CACGkMEuxSsJVkvNnGGZtrK=MOyzc1ajW+SNR-xP_XzO5=R25jA@mail.gmail.com>
Subject: Re: [PATCH] virtio_net: simplify tx queue wake condition check
To: liming.wu@jaguarmicro.com
Cc: "Michael S . Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, angus.chen@jaguarmicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 2, 2025 at 9:41=E2=80=AFAM <liming.wu@jaguarmicro.com> wrote:
>
> From: Liming Wu <liming.wu@jaguarmicro.com>
>
> Consolidate the two nested if conditions for checking tx queue wake
> conditions into a single combined condition. This improves code
> readability without changing functionality. And move netif_tx_wake_queue
> into if condition to reduce unnecessary checks for queue stops.
>
> Signed-off-by: Liming Wu <liming.wu@jaguarmicro.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


