Return-Path: <netdev+bounces-225806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74551B988A3
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 09:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34B953A9F5A
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 07:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA3A27586C;
	Wed, 24 Sep 2025 07:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LM+TB0dE"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B1B275844
	for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 07:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758698992; cv=none; b=JFv252xGdM988sv2L7+7xmIJXJWYLVKTUG4z7qyuM7Da1YTsi7/Xq0Bsej39A174oFbMFR87+2MWK5DfVWhYEt4gGfbaZeQCn+StZNFEl+skpgf25rhASGH1cqZsbZBrZCdgt636kJWpeO37TQl8kXP6fkBSrYYDGiItwebgNs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758698992; c=relaxed/simple;
	bh=+ltkTg/qYuz12Npm1+IkSO1GP/vwhIlTbRT4zcfie0o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TPOWma91G9zXanQbejpHZJd1ZGnN2Iao0ygITs9XFttJrkLGyu4u7qgIsIYJllBU2U6oHXmc8OikiCaNJK9d7eYWrCbMZn5nJLJjpNxGiYZ1RECyNsd+qhOFe0SoGe6nejtGZpAfanh4+A+Eh+qMWuQ/aXahNH/OvsUCixMnQak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LM+TB0dE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758698990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k97RPLu4lhetxoSMAV6Rjn5/VeR9VdPfkMhWA4K+Jy4=;
	b=LM+TB0dEEFr5cwVYk5xodVPpLqgkIeTit4Xye4Iom9MFsBSRZqwgXr1K4F5ZqaqDlACWIP
	ELXQ9W/EJcZycWPmvnePlbqeQVoOyO9LdyN4dOHKrh7aAqM2J/N1qfCwu9So9lsZ6cEHJr
	UurvpeCnSfnfL+F7MuxyO8XH5AXAgZc=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-nzGHOshsNPqGYEtu2memnQ-1; Wed, 24 Sep 2025 03:29:48 -0400
X-MC-Unique: nzGHOshsNPqGYEtu2memnQ-1
X-Mimecast-MFC-AGG-ID: nzGHOshsNPqGYEtu2memnQ_1758698987
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-32eae48beaaso6145161a91.0
        for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 00:29:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758698987; x=1759303787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k97RPLu4lhetxoSMAV6Rjn5/VeR9VdPfkMhWA4K+Jy4=;
        b=qoguaveZAzTwMngxvPDF5vSntApmd+uQHvOWTzBQc3//NEhD2pvaJtQghX/O39z2CW
         2GPRoji+tQsPCLSqkgyLZih4bDeHQfOvOPjgnGmqRqdZByxIH0o9bl5gt7xjhRkIqh6C
         5nJU1ja0VQvD/dgAdn32USYa8LLQun1JLZRcDxwnG+NDIY993GUTIXCE1qJxDMdr0s29
         Xub4R6gwNMu2b2SapQ2WqwPYU8Rd3oE87G7oXXRo2pCc8EzYXLQDTB4977Mlf/YUtji0
         wy8NUCZYPgyIvfDDLZ9fYKcwQmxBtyBwEbRHW2GeWdyPEDAblKaO2giIVYvUg4Jj4tRS
         /T0A==
X-Forwarded-Encrypted: i=1; AJvYcCXCAnfFEjIRmeGyjIwJEyfwTXvr34WpMzmawoYvzmJvcNVT4syOkXGkhjAL4mniI0zKmZQMKHw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXRmWR5Rpdf7TIE9CubhgBAkHjVCVbxoLiCmbtkSUpN9mJKoyS
	SwSd2CLmufhrhIWW91lQzBEAUpLDC/EIhT++zjmHr57efTn+QEhhi/Scl9Bf14Cs0zL38Ftg4Ig
	aKOWlT4r8RtrqpSEmWBEHwhH37uyrQBX1WCbTbQMaRClc6uJOaxd5Y0dzfnwZBZozVIinF5tSL9
	VDVskHot0OXHOvf4csrx+/nfgc1rSJLV90
X-Gm-Gg: ASbGncvz8UiPiQ/+jTwgtNch+YQP2iASdbi8OdxS4royGW5Y9HG0cIyNyNmOhtyPirr
	AiDf42u0qBmzbiDgWtS4fElUszGbGZ4raQ7tXn8TMpNp08PEvliXbAtnYYpSzw+dn664bqhFGA2
	OmGKtgweeeALn7UjrrtA==
X-Received: by 2002:a17:90a:ec84:b0:32e:8c14:5cd2 with SMTP id 98e67ed59e1d1-332a95e8f03mr5846289a91.28.1758698986993;
        Wed, 24 Sep 2025 00:29:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGiixCjQrnd4k7/vmpHG8JajCewvZIwdVQKFhy3Yph/jz+2559GWojk5kG0BnpLkgPt+lW5N69NnocLrGW1VrY=
X-Received: by 2002:a17:90a:ec84:b0:32e:8c14:5cd2 with SMTP id
 98e67ed59e1d1-332a95e8f03mr5846271a91.28.1758698986538; Wed, 24 Sep 2025
 00:29:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <adb9d941de4a2b619ddb2be271a9939849e70687.1758690291.git.mst@redhat.com>
In-Reply-To: <adb9d941de4a2b619ddb2be271a9939849e70687.1758690291.git.mst@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 24 Sep 2025 15:29:35 +0800
X-Gm-Features: AS18NWA2kZUD543CoVRumWkWdeRo9-rPqFcB1IcNJpagZJKVnA-A13nUez3lg2U
Message-ID: <CACGkMEsaHh-gM=hksgo+Ti4ppB7fP7xT1XHve1F_rxR-w5aGMQ@mail.gmail.com>
Subject: Re: [PATCH net] ptr_ring: drop duplicated tail zeroing code
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 1:27=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> We have some rather subtle code around zeroing tail entries, minimizing
> cache bouncing.  Let's put it all in one place.
>
> Doing this also reduces the text size slightly, e.g. for
> drivers/vhost/net.o
>   Before: text: 15,114 bytes
>   After: text: 15,082 bytes
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


