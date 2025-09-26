Return-Path: <netdev+bounces-226589-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D3C5BA267D
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 06:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DEC2740515
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 04:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191BB274676;
	Fri, 26 Sep 2025 04:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SAa0cxoD"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D54827381E
	for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 04:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758862169; cv=none; b=GC/BQp+JwWmgoIv4Iki3OoCfPTUmeNQvfMH34n6p0npaFi8ojtQtF0sl7A4E7gTLiXXLB8aX/zt2+nTySXwNhY+3WTtrqMjaRkm2+OWyy9REnfApRR5VWYpRdfSyDUhdwuXQMwuKLDJxw6RjRuZLMduJws3+ZcjzGKwIvXC+FUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758862169; c=relaxed/simple;
	bh=UIhcWvqxRIRycbeTshnZg2xOAxTIkwI70kvcP3YynVk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cdUmuTdkod6ZbIURC+bKNKStSbUvN87LUwHZwiUGoUov117PCbKnO4wABTV1krRPKg97re0o0YZmRrUiBg/mndVc+pMlXEEVCTIDv0OBtYwJZG+LhL1QRaTggJMfW9d8s6PzH7giOSobnzpO7grlN8+kOtQDEzH6XzgFyOrwrlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SAa0cxoD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758862165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UIhcWvqxRIRycbeTshnZg2xOAxTIkwI70kvcP3YynVk=;
	b=SAa0cxoDiQpubh2WdJKbyQ9gh6z+B+hJZf7wbCzi7wDDR0c72+ejagnyycs76/4vnurYGH
	5gevkYRK6w3feBKPBDgn9v15m9rnt2Dc9ZNoyJ7IhKchYlqOTauTfbVYunHCePSk0u6HDD
	CMqw8/0y72b0+jf5N/UMUxs7A5pAbJI=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-9tFyVq1wPJyI3IaULknsTA-1; Fri, 26 Sep 2025 00:49:23 -0400
X-MC-Unique: 9tFyVq1wPJyI3IaULknsTA-1
X-Mimecast-MFC-AGG-ID: 9tFyVq1wPJyI3IaULknsTA_1758862163
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-33428befc08so3574217a91.2
        for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 21:49:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758862163; x=1759466963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UIhcWvqxRIRycbeTshnZg2xOAxTIkwI70kvcP3YynVk=;
        b=r2fHflT81lsqp6WNKEIcG18VxLutOLUc2o8DU2geAojW0Gd62i4h8Qd/CpNWbPC3K/
         OcsG/rJn5fpPfFn0EADL/XqYIUqWixvL5wncPsqfYz5Eu8zruUxcxErJWS5fuVjJUJzo
         XLlOOgxG56NdH5JCgW+OJhSZGoL5UiGfVNP0kAW9QND1kje9WNSmiFAMK6AfTCozwBhV
         zv6NUpHNitdWLeNfQvwG3KFNKPuv3ctZ7gTyWGbrLSjQwhwXrnNmAh0aUUHrjBMbFrbj
         g2mO6gQ4jhj1+m9V005ljg3ACLIX2OKpO6Hazy2lKNu/m4yvcLXWRwwJC+uCYXzx1qJM
         n8EQ==
X-Gm-Message-State: AOJu0YwSsXU6M0AbKAbWKQJrTvo5is9quwO5PhUQfpnyp5+tREsSnQ0e
	L/Mz/MdWwIZIeLG51IptTNnp5q/zmcmCU05GDznFs0FQDZUZ9rebcpjTai6SrrSKvyUadCJOp1F
	qWuWlRPyykpEuYW2M4Al2DXnpt5bp3KJP+ntb9LiTweVJkEgwxOVvoEL61t6C9/DsM5gI41PV2s
	PDKdbH/TZREg7UO1vI1ZTsPBGMnH3cJ2fm
X-Gm-Gg: ASbGncvA4OK82V9eg324Ci+h4w2dR4RLPwzyIcHZm9sHwrHL//3zkTUFzz4BEbwmJKc
	HgjL1gIfBk3/rHl5eytq+xtgw087eRuuElqqtXzwk/lYGmDEDOY0sWUioDrn3d6YwnMIIbYz7JT
	ueeDmy4Wi9pTBjlPdeHw==
X-Received: by 2002:a17:90b:1d8a:b0:335:2eef:4ca8 with SMTP id 98e67ed59e1d1-3352eef4edcmr785207a91.33.1758862162746;
        Thu, 25 Sep 2025 21:49:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEn6k3kq9sVVva4dN1McfeOpleDDrCstJDmgNlanrCdFV4h/Y47Fetlu+ZhZyYwuS98kkIwPmYbSl6J5Ec8fR4=
X-Received: by 2002:a17:90b:1d8a:b0:335:2eef:4ca8 with SMTP id
 98e67ed59e1d1-3352eef4edcmr785170a91.33.1758862162271; Thu, 25 Sep 2025
 21:49:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925022537.91774-1-xuanzhuo@linux.alibaba.com> <20250925022537.91774-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20250925022537.91774-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 26 Sep 2025 12:49:10 +0800
X-Gm-Features: AS18NWAknuXvqmH17Roh3DbojuU3mFxgOLBnnEOYJvvtgv3NlblLdhapB8Zi7n8
Message-ID: <CACGkMEuBOzXQghp_nGt2t+cm6Ph3SVpjXyuBL0hfdw-3dreAmw@mail.gmail.com>
Subject: Re: [PATCH net 1/2] virtio-net: fix incorrect flags recording in big mode
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Jiri Pirko <jiri@resnulli.us>, 
	Alvaro Karsz <alvaro.karsz@solid-run.com>, Heng Qi <hengqi@linux.alibaba.com>, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 10:25=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba.=
com> wrote:
>
> The purpose of commit 703eec1b2422 ("virtio_net: fixing XDP for fully
> checksummed packets handling") is to record the flags in advance, as
> their value may be overwritten in the XDP case. However, the flags
> recorded under big mode are incorrect, because in big mode, the passed
> buf does not point to the rx buffer, but rather to the page of the
> submitted buffer. This commit fixes this issue.
>
> For the small mode, the commit c11a49d58ad2 ("virtio_net: Fix mismatched
> buf address when unmapping for small packets") fixed it.
>
> Fixes: 703eec1b2422 ("virtio_net: fixing XDP for fully checksummed packet=
s handling")
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


