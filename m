Return-Path: <netdev+bounces-107182-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3389291A3A1
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 12:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE2AB2839D8
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 10:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF3B13D262;
	Thu, 27 Jun 2024 10:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BKa0zumW"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE8B13AA31
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 10:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719483609; cv=none; b=oLgaL5Ya0SaOsMSmQoKCbRmiMppCXgu56UcnI4wdy1rncTzf6rLxi4OR6ReZhjmG5R8qe36Ws1rTOhOTyxJqB6A7SRWB4owRUJtTKSy87kaYYepSYlUSpWFAdWMTxcTFnJ4L1IBKIF00iOTgpHGdFwE2Is3cqBPegpaZJK7tWPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719483609; c=relaxed/simple;
	bh=G9fttLbf6Vo0TGpHjb5exaCDJAEjV0jxOsFOT6Lu5VU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Cl3rrHzLyrz42KjrvzNp4l9xFfsm4ABF4uOAO1Xp6GAUx2mrRHrj+dl2zNfAdsGB4DEDBQXjUIhPY1sEx4itX2ivyrkejWAv7RgzMUrA1xjAcM1ixz7t5ctJgBg7AjRjrC2HEMmAsCZGCJ+74qLZlSCdc55E4L4nC9/REvKa+3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BKa0zumW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719483607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=G9fttLbf6Vo0TGpHjb5exaCDJAEjV0jxOsFOT6Lu5VU=;
	b=BKa0zumW7zlJBwz6QtpuhZGdEur60XfiaT2QyDTUUuJpvEhs1frmJTDP/cOyVAkz/aZgbH
	DrpI6r0Oombvbmyi9AuV1VROq8AJthj2VEV4d4RfMATzFKiZgA/yB/nJPYMBKVXF9GAihI
	2YlThBMExSzy2+ZgCHMpBqWfW7q16jY=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-2JAZH2K_MVCBVydEVCKTbA-1; Thu, 27 Jun 2024 06:20:05 -0400
X-MC-Unique: 2JAZH2K_MVCBVydEVCKTbA-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-57ca47c6814so161905a12.1
        for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 03:20:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719483604; x=1720088404;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G9fttLbf6Vo0TGpHjb5exaCDJAEjV0jxOsFOT6Lu5VU=;
        b=N/jZ2AtXlVkXSasBkBQDZ4072Yrdkz9uqI49SRdgmZ0uX3xuz35r4kuh2NjLkikbWL
         RJjkQU1aD05Hy+fOr5MNu1Toh8nJYU+IoUF5ne0FBuSeuJ0fg1DQeVv832ZFW2QFYFxX
         pDPPNH69Ml/rt79m6aHItSV9GZ6+sXkK88EZGGfAMKGCEaHoz52n9rI4Y4xO2FYvwMIv
         HTMSc0qUvYP6ac3Qesu6Io3csj6C1NKGaOwP7WKvulbauYO4I8YP/RGiKuGrN8263Bkl
         AkpL/Fo5rTXq3mfj3VwBrGSJ8JxguxRCBy8p+aJG0MWA7hQRY1eP0Dq53cCMi1k/o8eQ
         +yJA==
X-Gm-Message-State: AOJu0YzQn+0fnAE37JQzEFb89GMofCcQDDUJO8/V+J+mSJhU2NoB5Oqa
	odXvqfj0MLEhAhmtLoN6i20VDX1FNfIUvJJ/NebWmBiWqrHDVe86muFmTO3w0u4LXHvabzpREpk
	4cXCxqYTe48UiRY3bySoOgzOjvBVDVczXB17lsAgGCtQ7I2iGg0qt1aiXLAAocQ==
X-Received: by 2002:a17:906:13c2:b0:a6e:f419:5456 with SMTP id a640c23a62f3a-a6fe780aa4dmr822961366b.6.1719483604155;
        Thu, 27 Jun 2024 03:20:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGf4dR/93E12MPj3Y0tPjygrjhBXPcWnPUZlkAR7ZmQKTTg5n4EYYXRhnfUcOzTg/Cj2xn1kw==
X-Received: by 2002:a17:906:13c2:b0:a6e:f419:5456 with SMTP id a640c23a62f3a-a6fe780aa4dmr822959866b.6.1719483603774;
        Thu, 27 Jun 2024 03:20:03 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3344:2716:2d10:663:1c83:b66f:72fc])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a729d778afdsm45385866b.104.2024.06.27.03.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 03:20:01 -0700 (PDT)
Message-ID: <8942458c0cb74b25cffedf975f8a37d7ed572765.camel@redhat.com>
Subject: Re: [PATCH net-next v2 0/2] net: flow dissector: allow explicit
 passing of netns
From: Paolo Abeni <pabeni@redhat.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 willemb@google.com
Date: Thu, 27 Jun 2024 12:20:00 +0200
In-Reply-To: <ZnypC7iOx_qtUH37@calendula>
References: <20240608221057.16070-1-fw@strlen.de>
	 <ZnypC7iOx_qtUH37@calendula>
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

On Thu, 2024-06-27 at 01:49 +0200, Pablo Neira Ayuso wrote:
> This series got applied to net-next.
>=20
> But I can trigger this splat via nftables/tests/shell in net.git (6.10-rc=
).
>=20
> As well as in -stable 6.1.x:
>=20
> Jun 26 02:19:26 curiosity kernel: [ 1211.840595] ------------[ cut here ]=
------------
> Jun 26 02:19:26 curiosity kernel: [ 1211.840605] WARNING: CPU: 0 PID: 702=
74 at net/core/flow_dissector.c:1016 __skb_flow_dissect+0x107e/0x2860
> [...]
> Jun 26 02:19:26 curiosity kernel: [ 1211.841240] CPU: 0 PID: 70274 Comm: =
socat Not tainted 6.1.93+ #18
>=20
> I think that turning this into DEBUG_NET_WARN_ON_ONCE as Willem
> suggested provides a workaround for net.git until Florian's fixes in
> net-next hit -stable.
>=20
> Would you accept such a patch?

FWISW I think it makes sense.

Thanks,

Paolo


