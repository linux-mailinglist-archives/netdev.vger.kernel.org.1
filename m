Return-Path: <netdev+bounces-81168-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9FD8865F3
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 06:19:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B2281F23CA5
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 05:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061D08BE8;
	Fri, 22 Mar 2024 05:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bv3H24bz"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6388915BB
	for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 05:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711084787; cv=none; b=b04eFiuW1ZWwq7sS0G3QfmiH7W62g1neY2SDeaWNYriDkP9HSgReFm1IvE4uYeCL/z+plodkZacC3pD+jCRb7oWVtWNaUucSTwZS9jVuRJr+ugl3ZN/VlCkrSKIo5qJUDVqyChjegn5F/W4CLsAQsws/PpoAk/Thao2YCJXedrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711084787; c=relaxed/simple;
	bh=9WljUklEtnqgFdT0/2aUVbLCn9e8lCLCn5JN6nZDEas=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n2SbuXLk4o3FJBF4ZEMtK0s6+IxfmwT47aVyAbfMnaOBhjDkU8Ou6AgLjFTFwdWGCOpnjfr1zy7f0+0apPQf5KKaG5FheVpq18Xj872OLmf83von/jWJhJM+sP5nZY+vXD7dv91raW9e2Zgi+62sLlPlriblExTpDXLfW2C8Jos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bv3H24bz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711084785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9WljUklEtnqgFdT0/2aUVbLCn9e8lCLCn5JN6nZDEas=;
	b=Bv3H24bzbHnWrow5nl0oPvsJ6+IHidSY0uVJedQ5RBY72QHftQB1hsHPhFNhZVEwOcxUnV
	SOhf8PcRw+gBcL9ocymh9SXIu1vDFWPd59bbj4hMkZOwdXBuc2aPLq4JSjWJQzDX3EjpcY
	3s89PsUGvTyrRjM9/3M4dnWwbEBBNKw=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-BBxO39lqOyeTjqerRkuwfg-1; Fri, 22 Mar 2024 01:19:43 -0400
X-MC-Unique: BBxO39lqOyeTjqerRkuwfg-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5ce12b4c1c9so866716a12.1
        for <netdev@vger.kernel.org>; Thu, 21 Mar 2024 22:19:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711084781; x=1711689581;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9WljUklEtnqgFdT0/2aUVbLCn9e8lCLCn5JN6nZDEas=;
        b=YYVKtIfaZvB3rWaUnGLEFnleBSb/m8JEzvVVTe/nX2g7H0x3odQYthFl95S0rJwNrN
         99vZUGKIvnpGfW/YL/c7YJdsnF9t0zaxDmwUp8Ugk3glLJu14s564gIJohKjNMmIZC/q
         aQ7Mux4NrMvSRmH3jS+J6ZeIkB8/H4CyT0aPX6COB4Bspv3+uknr9uEgVJ//TF4/uB86
         dYIaIZhvOefEuS+5uwBfq5IdUDtZlhzp8d6PJ9ylpzLpBs7hogJfmNBRoI/88uNuclwm
         PX56aWKPcn3l5xKCTE6iDzRNY/ucXsxL2XwPd/1l92v6Zw0Xcr70Lbtf0XDRN9omUVAf
         QeUw==
X-Gm-Message-State: AOJu0YxJbieKOLXlGPs96L8qVvvi82+aMGHb/WgI4XJgnZh+OGsyuBqW
	dnpUkOMc2JMQhKwBRyZbtQHLKFjuc42k6Z+vIDRfeYnLZRpH7QH3aiCEGLtZegOrnC4oBwmnjD7
	C2JB8+fbH32jZ18hNmq8s4ABxXcSlJymc9Clcgsv0YORro7yzFzjLt3vOCqpzFrSuHbwyc98XVX
	ppMl+YtpsxF/K/3SV+YmT8KRreF/brULciGAv6jH0=
X-Received: by 2002:a17:90a:e54f:b0:2a0:39e9:bbff with SMTP id ei15-20020a17090ae54f00b002a039e9bbffmr800508pjb.8.1711084781617;
        Thu, 21 Mar 2024 22:19:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEqlxvXagJuFEUOF4z/T7yo9ZWXfypHCNh8PgRY3CFCwWph4hQ9De6Peq6FbRIVJmZmGRYpZVicf0gqBNYJMI=
X-Received: by 2002:a17:90a:e54f:b0:2a0:39e9:bbff with SMTP id
 ei15-20020a17090ae54f00b002a039e9bbffmr800493pjb.8.1711084781374; Thu, 21 Mar
 2024 22:19:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1711021557-58116-1-git-send-email-hengqi@linux.alibaba.com> <1711021557-58116-3-git-send-email-hengqi@linux.alibaba.com>
In-Reply-To: <1711021557-58116-3-git-send-email-hengqi@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 22 Mar 2024 13:19:29 +0800
Message-ID: <CACGkMEuZ457UU6MhPtKHd_Y0VryvZoNU+uuKOc_4OK7jc62WwA@mail.gmail.com>
Subject: Re: [PATCH 2/2] virtio-net: reduce the CPU consumption of dim worker
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2024 at 7:46=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.com> =
wrote:
>
> Currently, ctrlq processes commands in a synchronous manner,
> which increases the delay of dim commands when configuring
> multi-queue VMs, which in turn causes the CPU utilization to
> increase and interferes with the performance of dim.
>
> Therefore we asynchronously process ctlq's dim commands.
>
> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>

I may miss some previous discussions.

But at least the changelog needs to explain why you don't use interrupt.

Thanks


