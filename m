Return-Path: <netdev+bounces-211514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66491B19E4E
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 11:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBC64189AC30
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 09:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9FF246768;
	Mon,  4 Aug 2025 09:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LN0P8mM0"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6C62472AA
	for <netdev@vger.kernel.org>; Mon,  4 Aug 2025 09:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754298374; cv=none; b=kbTo4qU6YRWJlFk3RkQYTVx7hXkQq2Oddc+CrAu7j9r8Do+ICNoBoJAXJMYthm3/oyvjiGU5NFH+5zfXAezAIbZ0iLvVKvFPK2hftllDnIx+DdDci8OLELHTRp5AXM14lzPXrbNHRqTSoXN/6Cal0YSuCHAJJUb1rKGLayR9DPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754298374; c=relaxed/simple;
	bh=FC2gKnlK0tlH4AVIjMhG/aH0ST923yLbY61/gTdaWtU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nTwIGtJbEVYDeDpFYiYXP3G8/QCbQrol4nxHgFgeWq18B7YXVYYreiP2pK3uth9tbmg/urgRq9eF+93AIE2BWTnWsVxjoUkWdYKFcxeIkDN8bc7BJq5qk15H8PGwgNYl53NeyCRQRSFmbIQ/bJlqIulN8eP5/JJ5/OT3h5DJFPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LN0P8mM0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754298371;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FC2gKnlK0tlH4AVIjMhG/aH0ST923yLbY61/gTdaWtU=;
	b=LN0P8mM05fuXxVG3KM7mnua5lUZVv3dAPqEojOA+pleWq6Ec7Hr0RCspmUMKJ1NvW4ZNLS
	7/LnuqrwNV+Ws2s9TDhtGMsMVz1my3B2taDjw8+z4HpiTkcA1LpVsX2SfoF/XQMR+ioEXI
	g0VUT+y0fwiZ6JzPcvSy2PtfwrLcHto=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-29-2aJlVT95PWCrI98e4_lRJg-1; Mon, 04 Aug 2025 05:06:10 -0400
X-MC-Unique: 2aJlVT95PWCrI98e4_lRJg-1
X-Mimecast-MFC-AGG-ID: 2aJlVT95PWCrI98e4_lRJg_1754298369
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2420cfdafcaso32221515ad.0
        for <netdev@vger.kernel.org>; Mon, 04 Aug 2025 02:06:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754298369; x=1754903169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FC2gKnlK0tlH4AVIjMhG/aH0ST923yLbY61/gTdaWtU=;
        b=cRnXezbOiyRgfZtyavcIJoP6HBQtLzds4b9aczPV9YoujSoiwFnKcjXkwXsxmSpq4P
         /mEUOSHbwP8HE3az/wJ8SLFtElQlwmoy5yoxzTrrEWjNWHCnEp/VeE0zFGT7CYmTNmib
         nLNFqZVQ2X5tSD0tFoICTmkFwYNgzo904+bRxG7uW+/RJMpGM2CjcuRnAb1Jw3P0Ms2e
         h9/rsM16CSzR7lXBWpryF5YhxdoyrT6SDwtNsm4t5GkzkxsGprAmquUE/1UPI0EDBKTk
         8u7tGjahgOgwpPDEzZ594E1BxKx4IRVaRT35F3mXmJO18BragP8efjB/39+y9eXtGnT4
         w28Q==
X-Forwarded-Encrypted: i=1; AJvYcCVUuMRVAG2/xRRw2MJBQIpbYKa3J+swFO7Lz4ZdQU2GmTSczQZjSHdw3ct1OwcleSAO+mIoLLc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYbsGQaTUZcOZoT6en7HgdRjbnhqw9eyguB3Dnfpn0R75//7qZ
	SNFdGQlg/13wpz/ji618AWpb/3ULupGXk1oVrEeq/E08T99FJPBwZujKi1ZT55ACTbSJpl9REJi
	2PanvsW1LkJceZb5qYmzzHXyq/AeGrJNdqdKAXKiHM4Hp/hD+cDOPjGH5NiJsO58yMhwX6KI5PD
	Nb5tDJ5H9uo/DllWzRW95T6d8+EmaEToQR
X-Gm-Gg: ASbGncsFc42LWjMhy3z12pGt5tLVNRHq1YxbWSk6HOF37+th4rcnJG4x+SG/qEoZsHT
	9f5zMBupygbrAfdNDSl8RfRWRiHaiV87U4UQro3a9EQmvofdPRVRlXE7j+PvP2YZL2YZpzQXxZb
	PaJm6KhRmDJtc8lCCEgupgXw==
X-Received: by 2002:a17:902:f552:b0:23f:f983:5ca1 with SMTP id d9443c01a7336-24246f5dfb2mr132550085ad.12.1754298369506;
        Mon, 04 Aug 2025 02:06:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEcYXd+G3MrEs13nVvxY8yeK+0iPt6uzM6BT+j7IwyIkqouuxJCmX+aT/C268Bf+EzVOioFJTajAeAVP8Oj2U=
X-Received: by 2002:a17:902:f552:b0:23f:f983:5ca1 with SMTP id
 d9443c01a7336-24246f5dfb2mr132549655ad.12.1754298369069; Mon, 04 Aug 2025
 02:06:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250729073916.80647-1-jasowang@redhat.com>
In-Reply-To: <20250729073916.80647-1-jasowang@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 4 Aug 2025 17:05:57 +0800
X-Gm-Features: Ac12FXy2PpNcxx7Wuo6WWD9onNx5D2Zc4zo6EJWLkWuf_3KiHYfBpugk7fN5otM
Message-ID: <CACGkMEuNx_7Q_Jq+xcE83fwbFa2uVZkrqr0Nx=1pxcZuFkO91w@mail.gmail.com>
Subject: Re: [PATCH] vhost: initialize vq->nheads properly
To: mst@redhat.com, jasowang@redhat.com, eperezma@redhat.com
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, sgarzare@redhat.com, 
	will@kernel.org, JAEHOON KIM <jhkim@linux.ibm.com>, Breno Leitao <leitao@debian.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Michael:

On Tue, Jul 29, 2025 at 3:39=E2=80=AFPM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> Commit 7918bb2d19c9 ("vhost: basic in order support") introduces
> vq->nheads to store the number of batched used buffers per used elem
> but it forgets to initialize the vq->nheads to NULL in
> vhost_dev_init() this will cause kfree() that would try to free it
> without be allocated if SET_OWNER is not called.
>
> Reported-by: JAEHOON KIM <jhkim@linux.ibm.com>
> Reported-by: Breno Leitao <leitao@debian.org>
> Fixes: 7918bb2d19c9 ("vhost: basic in order support")
> Signed-off-by: Jason Wang <jasowang@redhat.com>

I didn't see this in your pull request.

Thanks


