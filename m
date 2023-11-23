Return-Path: <netdev+bounces-50458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C60A07F5DE7
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 12:37:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BECC31C20D3A
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 11:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F541224F8;
	Thu, 23 Nov 2023 11:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b6AN8USd"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD25EA3
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 03:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700739447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cNU0lJ4bqwRQlxt9Wpe1IHAIeheCW8RuRwLK6Qt/j8Q=;
	b=b6AN8USdQ/hIDfY4CzP9w2haBB9DOAOm+G+vOlLCowz04hI96214Txug8jzLmQgGl6zunM
	visLJF2/ziqbKZ2tyxCDR6DFZMFWdmZILAafvRVUIYdckt6Eq7ILedHGqFlWXu62gzwzud
	RTUxeBDYaYq6KhJzysBv4Z8280tzjWM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-33-XsJeOZqWPIaAkYTXrWYZ7Q-1; Thu, 23 Nov 2023 06:37:25 -0500
X-MC-Unique: XsJeOZqWPIaAkYTXrWYZ7Q-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a02344944f5so15155366b.0
        for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 03:37:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700739443; x=1701344243;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cNU0lJ4bqwRQlxt9Wpe1IHAIeheCW8RuRwLK6Qt/j8Q=;
        b=dtWZeYRGH1/iW5dfBEgD6YXxPGNG6Wkdn7HxrNjkr6tSkCf1PdjswYLxqpQXacSZY9
         Zf6nWp+2ubC+wfEq2/TeeKuGmwsA3U8FGURJk7ovL3ZPpoKx+E4pHaiZNOEnLIHwRbUQ
         1yTAVuTSgDDgHUdcR1zrHcA2mY7GUiy3tchfmzODJYJwP9LigR5fAlxPZZdDmROUsVAl
         yJjubkSe78W5bh+STZhSx1b/Y4iNqQdGr3eOA3P0DqyevDkae1IUDXrX8MSzZaMcDZHo
         1K1b81YW1HabJcWC21x5ciaOxdYSfmLdO+5ch1TMcYeW/eEOiVVmCXXqjpt51L2mBz/m
         IrFw==
X-Gm-Message-State: AOJu0YyQU7EMNqCk6Weg3+O8JSRF49xqlDasXqgQSStJ3JasCI9kguzu
	P6imLWXXw70niQNtuYCaqgzriHX5pt80lxS3sQZ5dPSj4eANieT9jqq1ROLaLmIkrdCVNdMDD/P
	PMANxkE6d8z3HIJHD
X-Received: by 2002:a17:906:cb:b0:a02:a2fb:543 with SMTP id 11-20020a17090600cb00b00a02a2fb0543mr3401951eji.7.1700739443552;
        Thu, 23 Nov 2023 03:37:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH/qhXeu1lxpefrtiQ6p1bXy+gUpUMSWogFKiIjUP9coMkMwyY1B5XPnDJWqosDbagW70xJxA==
X-Received: by 2002:a17:906:cb:b0:a02:a2fb:543 with SMTP id 11-20020a17090600cb00b00a02a2fb0543mr3401937eji.7.1700739443239;
        Thu, 23 Nov 2023 03:37:23 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-241-213.dyn.eolo.it. [146.241.241.213])
        by smtp.gmail.com with ESMTPSA id jx19-20020a170906ca5300b009fc9fab9178sm669800ejb.125.2023.11.23.03.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 03:37:22 -0800 (PST)
Message-ID: <a24433f86e39cbb45a9606621e01446e7ad6fa53.camel@redhat.com>
Subject: Re: [PATCH 2/4 net] qca_spi: Fix SPI IRQ handling
From: Paolo Abeni <pabeni@redhat.com>
To: Stefan Wahren <wahrenst@gmx.net>, "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>
Cc: Lino Sanfilippo <LinoSanfilippo@gmx.de>, Florian Fainelli
 <f.fainelli@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 23 Nov 2023 12:37:21 +0100
In-Reply-To: <20231121163004.21232-3-wahrenst@gmx.net>
References: <20231121163004.21232-1-wahrenst@gmx.net>
	 <20231121163004.21232-3-wahrenst@gmx.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2023-11-21 at 17:30 +0100, Stefan Wahren wrote:
> The functions qcaspi_netdev_open/close are responsible of request &
> free of the SPI interrupt, which wasn't the best choice. Currently
> it's possible to trigger a double free of the interrupt by calling
> qcaspi_netdev_close() after qcaspi_netdev_open() has failed.
> So let us split IRQ allocation & enabling, so we can take advantage
> of a device managed IRQ and also fix the issue.
>=20
> Fixes: 291ab06ecf67 ("net: qualcomm: new Ethernet over SPI driver for QCA=
7000")
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>

The change makes sense, but the changelog is confusing.=C2=A0

qcaspi_netdev_close() and qcaspi_netdev_open() are invoked only via
ndo_open and ndo_close(), right? So qcaspi_netdev_close() will never be
invoked qcaspi_netdev_open(), failure - that is when IFF_UP is not set.

Cheers,

Paolo


