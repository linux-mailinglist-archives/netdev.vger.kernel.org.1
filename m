Return-Path: <netdev+bounces-184330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1AD3A94BB3
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 05:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F98B18910E7
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 03:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1BC42571D9;
	Mon, 21 Apr 2025 03:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MlLg05Fa"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D0C1D9663
	for <netdev@vger.kernel.org>; Mon, 21 Apr 2025 03:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745206876; cv=none; b=TMMTApbsxChFY/u2qQMbVNEo5nzp2EJfvTefNyuHWSKHUqLvwBiRhQWRYuaoyFR+qfUuEIwSHi6fbBqG9tJ3v6xMAi5aK7KbH2bj0dM+mrq1TB0uL4u4GYTs35sblI+Y4JXi8tSoLU6E51TITHGr3S3QAEil9UyXKU+L0/lEhOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745206876; c=relaxed/simple;
	bh=HuyJ5ZjeMDNi0MDOzVYBUraDwK2NWuFkveGRKSzNHA0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EpCoK9YVLgRkhIFIhY5ou3cmbv2FnNvOQT96iQm8CH7XpFp8Xgq1wk3FZvkokCnihgBj0pMhuTBbM3RK++AelwncZ2Ukzy525t22aIIx2819xwbovBz4RlFCdUe6wv6xQR1pP+MDsDF+eA0EQ7Sh60xYb3lvBpGghOoadTMUvws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MlLg05Fa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745206873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HuyJ5ZjeMDNi0MDOzVYBUraDwK2NWuFkveGRKSzNHA0=;
	b=MlLg05FaTKiR83on1L5+T/5KptpOFqYn2uMdp+MLz4sTlFDYkNkcXczZXuQYhsxBhLILSg
	7JDNceejhOIDDK8D9aDm00YyD9sLjq1J34m/Pzi+8F1HOjADjZ2OEYVXaDV+A2HAzviMtx
	VJU4AlBIs4+0mUUtuX/gFYVBHm/QJSM=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-184-MqWvPUGCMyO9xeDSMUCX1A-1; Sun, 20 Apr 2025 23:41:11 -0400
X-MC-Unique: MqWvPUGCMyO9xeDSMUCX1A-1
X-Mimecast-MFC-AGG-ID: MqWvPUGCMyO9xeDSMUCX1A_1745206871
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-736a7d0b82fso4333629b3a.1
        for <netdev@vger.kernel.org>; Sun, 20 Apr 2025 20:41:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745206870; x=1745811670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HuyJ5ZjeMDNi0MDOzVYBUraDwK2NWuFkveGRKSzNHA0=;
        b=EWAVWD/HkySCs3sZy9viDihyYMlm2kcPUMnQ7CaM3iugmdcpGO6rM2DSkJjRC/r9NW
         fuzpglYrQoBf0IFvwPXHUNxnDJHf7skbDa5gbl/SKWQ7vR16BbLl8GmK6sr7M24sDIXA
         hjer71PWNxEyS311s8oW1XOaFdnHzXdN2m8vng8MIvZhYP015AIUG7svRX1Dmrx6kVgy
         69DfXJ2WQ0NeM/5jW/iNa27RKVxPxHfV/f7WJfremDIeqTPw2iI1p/pP7nr9f6xp+Rzi
         bwE5Hk2F1P9kTusfQ36QgKe7eA4rBTkMtZwdh1RG9XqIAegqyVUkqCVsjZN4R3/5Gv94
         sMpg==
X-Forwarded-Encrypted: i=1; AJvYcCXMSBvYlM58p4bB3mx5i9erw529IUhEjxo9DHL+QEI3wN32No/Dc8xZn1QD241q93GxQlCUqsg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuDgwhXhXuNXy184swfuoie9ljmhN7M2kWPEZ9DsEyNUvg2ntU
	mv56OW5/LNN8Uu/4dHfgVfdwxb6LOskXI21Dc6dPFwsEBAekBseqa2z2YXrrA/nAGx4Ovh/fa/U
	oqPDKlYTQLisMzFlYF2r1GAh7DeUDkGjH1ySNe3Pobs26DGyXP27O/y3kJoTauB7EClCZRmGgtR
	U/iLIjgBT/CAN8VYXlgEgX0YfXl4I1hiNThKxVOs8=
X-Gm-Gg: ASbGnctalbI/kJoOxj26GyS6mLwkgdK6QF6xy16SZbu8HdYngkbErBAhriJN+R4cimY
	bhkSOizB19IzGL0xFVIlCerCfUjImQVIkhjwJGRGTQ2JbivgBjnWR8qXYfgwamG9EYYZfaw==
X-Received: by 2002:a05:6a00:4648:b0:736:4704:d5da with SMTP id d2e1a72fcca58-73dc15c68a2mr11228285b3a.22.1745206870368;
        Sun, 20 Apr 2025 20:41:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPYgkzH0aAPS+m4dDNwD+hG2inZ9iE8RfSuLcGM/dEyykWwol5iEf/2EDadmje8TzWTiGr0IGa9NVDmTX+rBc=
X-Received: by 2002:a05:6a00:4648:b0:736:4704:d5da with SMTP id
 d2e1a72fcca58-73dc15c68a2mr11228267b3a.22.1745206869974; Sun, 20 Apr 2025
 20:41:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250421024457.112163-1-lulu@redhat.com> <20250421024457.112163-4-lulu@redhat.com>
In-Reply-To: <20250421024457.112163-4-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 21 Apr 2025 11:40:57 +0800
X-Gm-Features: ATxdqUFUXQU0YTwg1cIJfTuwIr6bdYeh2bbILXsoZ4BkBC1HqGU1qls5XtUYx_4
Message-ID: <CACGkMEuki8JnD-5OGk15nhzrthdb78refcDUv2EeKgejSCQfew@mail.gmail.com>
Subject: Re: [PATCH v9 3/4] vhost: add VHOST_FORK_FROM_OWNER ioctl and
 validate inherit_owner
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 21, 2025 at 10:45=E2=80=AFAM Cindy Lu <lulu@redhat.com> wrote:
>
> Add a new UAPI to configure the vhost device to use the kthread mode.
> The userspace application can use IOCTL VHOST_FORK_FROM_OWNER
> to choose between owner and kthread mode if necessary.
> This setting must be applied before VHOST_SET_OWNER, as the worker
> will be created in the VHOST_SET_OWNER function.
>
> In addition, the VHOST_NEW_WORKER requires the inherit_owner
> setting to be true. So we need to add a check for this.
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


