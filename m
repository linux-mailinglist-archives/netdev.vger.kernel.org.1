Return-Path: <netdev+bounces-94003-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FFB38BDE27
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 11:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A02701F2124A
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 09:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C018B14D716;
	Tue,  7 May 2024 09:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FmON90Og"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2040314D705
	for <netdev@vger.kernel.org>; Tue,  7 May 2024 09:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715073977; cv=none; b=rnmtY44KjZudpQSle6Gyau8sDfxyuIaNp3EOVxNkDRpZJO/pKmmFTPOiHCEn4Lkisb5qlc7QtF+J3/CroUR5qUvKWc+CYkOLOhDa6VPgqWvA9MReOMmqjdM2SIrwe7fcC9dTm/fokkxHwvEMZJWcSWlpqzwxsmMNf7eYunEqJ0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715073977; c=relaxed/simple;
	bh=kBYE1Jc9EL+Lvp6dzrDvSFBT6lJSp+HFOny/0PXqM80=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TvkGwyI/bJ8jPoeICb1Yyhvxh1W+nmstrhrN+XK6sVc+JahASPny4k/ZoWpW8tt7PmCJXTF/QSdom5jsu1BvBFAUuo+iafGPjZMBWEZmE47FbkolaYIe1z38JUjcH04yR/5FvaondRXFtg73ZNMFNJ1ZZcSHN0ePAz2/KnKyYZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FmON90Og; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715073975;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=kBYE1Jc9EL+Lvp6dzrDvSFBT6lJSp+HFOny/0PXqM80=;
	b=FmON90OgjgPkUHnqGBQAFnPFqbiIM+/tO5H9KKJrx5zSHkAi0kCwxWoKOVqt9Ie+yU7HoY
	1f6PdRb3PW7vHp4nTur+pLeX36BaSglRd0NDy2JF3+Jj1EaHCIVJ8GTDUCRm8m6ow1/XRQ
	WR2oyV5k0B4NRS5rLKXMyiBat3D5ius=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-104-YDrtVfrkPiOPiH1YW2kAjA-1; Tue, 07 May 2024 05:26:13 -0400
X-MC-Unique: YDrtVfrkPiOPiH1YW2kAjA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-34ef7d11a78so252073f8f.3
        for <netdev@vger.kernel.org>; Tue, 07 May 2024 02:26:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715073972; x=1715678772;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kBYE1Jc9EL+Lvp6dzrDvSFBT6lJSp+HFOny/0PXqM80=;
        b=E1wuj3m9GvCbNAelQGtNik2M3ac2hlxRmNxAgQbWqlTA/O4zsWAZ0jbv+Se3XcWVTh
         4oQRB4RJ+YP1pJY8z6VOxV6jFZDvqFjJ6yxsx5bR431yD7SvLpVH5O9zBYkbAzM+K6yM
         F7Tkxn16cIrr9IczVUgItszkqzdAuCcjVTj1abGXcT8qIAUFhVwPwDMbpG9MttZFPUXo
         yycikpOm1O8tho4TRpx4IRNMnodcrD7dtQ1F487lxC4sNvxxbes/q37ySwqcP/Pb2VAd
         7z2SV9pIHSlQYmEl6uz8El5Mvo0JtqtWxaW6MDGB8lqvaESmMd1xHd1NdcVqpJ8cIW6K
         fM9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWA7cm4bTle95vVyIHE+BcMU+TgsSNgs4TqtSz/Hsuo5wMCXQsIWBaSYDiqSMWnvTdtpkRgdNXc91fmlkWjDZkUM3a9s8S6
X-Gm-Message-State: AOJu0YzoEXXqhz4ZAbpfSyTYHi8NprzeMNJPRZnbt9NCts17yQmThKQh
	EQKx02rDnkh5FjCRBDfOK4Mft5zSQ4kXMbEa4lCZADHzzUSRNEVP41+PFjI6dAjklbPScKSnxhJ
	YoftffK8KIguqzRIDtltcRYVuhDRkALukOgo9a1f+mdFqAmb3CxCoJA==
X-Received: by 2002:a05:6000:1e85:b0:34d:707c:9222 with SMTP id dd5-20020a0560001e8500b0034d707c9222mr8067094wrb.2.1715073972545;
        Tue, 07 May 2024 02:26:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmWF4Zlvsdk9zMF6bVCUbpJSefWMonUomkf4F3VkdPenUbVTYlJVMQlDaWGFJLz+S8dJzOHQ==
X-Received: by 2002:a05:6000:1e85:b0:34d:707c:9222 with SMTP id dd5-20020a0560001e8500b0034d707c9222mr8067079wrb.2.1715073972154;
        Tue, 07 May 2024 02:26:12 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3341:b09b:b810::f71])
        by smtp.gmail.com with ESMTPSA id n13-20020a5d420d000000b00346f9071405sm12539067wrq.21.2024.05.07.02.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 02:26:11 -0700 (PDT)
Message-ID: <89e0117a970a56bc2de521bbc6f13dfe03b33373.camel@redhat.com>
Subject: Re: [PATCH net-next 3/8] rtnetlink: do not depend on RTNL for
 IFLA_TXQLEN output
From: Paolo Abeni <pabeni@redhat.com>
To: Simon Horman <horms@kernel.org>, Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>,  netdev@vger.kernel.org, eric.dumazet@gmail.com
Date: Tue, 07 May 2024 11:26:10 +0200
In-Reply-To: <20240505144334.GA67882@kernel.org>
References: <20240503192059.3884225-1-edumazet@google.com>
	 <20240503192059.3884225-4-edumazet@google.com>
	 <20240505144334.GA67882@kernel.org>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2024-05-05 at 15:43 +0100, Simon Horman wrote:
> On Fri, May 03, 2024 at 07:20:54PM +0000, Eric Dumazet wrote:
> > rtnl_fill_ifinfo() can read dev->tx_queue_len locklessly,
> > granted we add corresponding READ_ONCE()/WRITE_ONCE() annotations.
> >=20
> > Add missing READ_ONCE(dev->tx_queue_len) in teql_enqueue()
>=20
> Hi Eric,
>=20
> I am wondering if READ_ONCE(caifd->netdev->tx_queue_len)
> is also missing from net/caif/caif_dev.c:transmit().

I agree such read is outside the rtnl lock and could use a READ_ONCE
annotation. I think it's better to handle that as an eventual follow-up
instead of blocking this series.

Thanks,

Paolo


