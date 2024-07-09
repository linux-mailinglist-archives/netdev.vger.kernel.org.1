Return-Path: <netdev+bounces-110164-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06BFE92B233
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 10:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A26D1C21631
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 08:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B85915250A;
	Tue,  9 Jul 2024 08:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dNIGnZgA"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6042327462
	for <netdev@vger.kernel.org>; Tue,  9 Jul 2024 08:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720514104; cv=none; b=HSiz6D+EL0C89TJzshYeYEJCU1wiqut707CoQkVx0/9F+PQpqjLj/IErMlhjjVseUKdcL1tVnksQp9bidwuSl9kbzPYn0WTmrRTaqPjOodlRfJg5x4NdMVnR718N6APnxlV6Qj1BXbT2v25CbH6ZFbj74J1yFLqEIjMs2xTmN6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720514104; c=relaxed/simple;
	bh=DG9rCxhCwbStHk+MslBqrJkCywgdt6JqcE6YhliXnHA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ULxoDKBjAeSGXuBO8bbYAOMyiTEahgqjoGooQUAwnFoVIwxIAf+kiAISPCV+nVR/v05z0+ucGS6c1LCogmEfCFWR8q/zInhRR+4ku+XfMtf1wFukBPxoNl8wlxlF71ZI7iEDyFSbCA8Gv5emXOztTRPbq8tYPyxk5Qd2r4IuJBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dNIGnZgA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720514102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=DG9rCxhCwbStHk+MslBqrJkCywgdt6JqcE6YhliXnHA=;
	b=dNIGnZgA4lAHmK79v08GyTqHhtacCsqKxBz8BGHCVyA21PzuhzSfGkJKM0eUXkJIlwcTh2
	I7dHDON1RtBgTUdkMPXZdoTspP1tMjtfgWKoi/yZKT66Sw20O0wSXgSRBWcHFo0MhBBScZ
	6QTGhb6eAQLFip4x1qdRiHzGvw15Ot8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-ldIsfkhrMPuB6De_w822jw-1; Tue, 09 Jul 2024 04:35:00 -0400
X-MC-Unique: ldIsfkhrMPuB6De_w822jw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-367bdc0e0b0so154299f8f.1
        for <netdev@vger.kernel.org>; Tue, 09 Jul 2024 01:35:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720514099; x=1721118899;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DG9rCxhCwbStHk+MslBqrJkCywgdt6JqcE6YhliXnHA=;
        b=FhDXu6B18AFKC40ZKrfvs11HzVzOHqorIbDB9a0e3r4uQQQE5EYV9ptBzLOd24FAP2
         MWfxwB6b7ZXb72B2K/ZONncycR70ThNjkWvNzon+wPkM48pAz5oelo+IMGUqAGPDdH0k
         /aqJtIxtfhXi1jN1Ib3LIitJtYglPjK1OZXuq6Py0HXCXE2k4NWFWIU8Ah4KI1b1eUIf
         CKjy3Z5KQMuBU1+BhJLnER7r/NjOc0j2lCxk9MC1966y0far/259miFSIsi77+rROg4j
         U8GgLCbgW0iby3XZ0lI60OhThQuLjS7qgfi2o/kgDJLSwNd15DgnEqlli+sGgaFKT4c5
         k27Q==
X-Forwarded-Encrypted: i=1; AJvYcCVxdmQ62vM0myo/c7bpr7lyp2kY0uuH90Sqcdj1iV9ypwKf/C8eNZPkFO1p9+lV5ArTtSxWCs2MdUbqn8ecyU2VIqalrDDO
X-Gm-Message-State: AOJu0Yz7iG4oAWptR8o+hZgvFC9PyPq7glkpD6i266ShZdUVi4RdeWN5
	ZOrA4nKeAcT5mR8LSlWefzRI6gTbTX68e6hC0uaE5+gUnsY9LvobVHAnbRc2w2YeZZyTKr6skfS
	5bpL0HFCdQeoDfIZCoT8a++rpdufWEWj7GX+f45uay7fZqhxbb8fR+g==
X-Received: by 2002:a05:600c:35c8:b0:425:7ac6:96f9 with SMTP id 5b1f17b1804b1-42670081862mr12037275e9.0.1720514099665;
        Tue, 09 Jul 2024 01:34:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbHUFShpWDqVC/iXoaB83+FNJ0Ugkyu72KYIYZxA0budzUHM+msC/YYqBXCo9/2uaMWdZ8WQ==
X-Received: by 2002:a05:600c:35c8:b0:425:7ac6:96f9 with SMTP id 5b1f17b1804b1-42670081862mr12037145e9.0.1720514099268;
        Tue, 09 Jul 2024 01:34:59 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3344:1710:e810:1180:8096:5705:abe])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a2fc49fsm196127595e9.39.2024.07.09.01.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 01:34:58 -0700 (PDT)
Message-ID: <6124782dffadef83707edc7fd4d87a327d5cba1b.camel@redhat.com>
Subject: Re: [net-next,v1] net: phy: phy_device: fix PHY WOL enabled, PM
 failed to suspend
From: Paolo Abeni <pabeni@redhat.com>
To: Youwan Wang <youwan@nfschina.com>, andrew@lunn.ch
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Tue, 09 Jul 2024 10:34:57 +0200
In-Reply-To: <20240704123200.603654-1-youwan@nfschina.com>
References: <20240704123200.603654-1-youwan@nfschina.com>
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

Hi,

On Thu, 2024-07-04 at 20:32 +0800, Youwan Wang wrote:
> If the PHY of the mido bus is enabled with Wake-on-LAN (WOL),
> we cannot suspend the PHY. Although the WOL status has been
> checked in phy_suspend(), returning -EBUSY(-16) would cause
> the Power Management (PM) to fail to suspend. Since
> phy_suspend() is an exported symbol (EXPORT_SYMBOL),
> timely error reporting is needed. Therefore, an additional
> check is performed here. If the PHY of the mido bus is enabled
> with WOL, we skip calling phy_suspend() to avoid PM failure.
>=20
> Thank you all for your analysis.

Please, use an incremental version number (in this case: 'v2') when
sending a new revision of this patch, it will make easier to track the
previous discussion. Even when the changes affect only the
changelog/commit message.

> I am using the Linux kernel version 6.6, the current system is
> utilizing ACPI firmware. However, in terms of configuration,
> the system only includes MAC layer configuration while lacking
> PHY configuration. Furthermore, it has been observed that the
> phydev->attached_dev is NULL, phydev is "stmmac-0:01", it not
> attached, but it will affect suspend and resume. The actually
> attached "stmmac-0:00" will not dpm_run_callback():
> mdio_bus_phy_suspend().

It looks like the underlying issue is still under investigation.
As noted by Andrew, the NULL attached_dev hints at some other root
cause issue, possibly elsewhere. Please reply to Andrew's questions:

https://lore.kernel.org/netdev/b61cae2b-6b94-465e-b4e4-6c220c6c66d9@lunn.ch=
/

before posting a new revision. At very least the replies should be
reflected in some additional info in the commit message.

Thanks,

Paolo


