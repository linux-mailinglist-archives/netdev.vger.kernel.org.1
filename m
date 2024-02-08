Return-Path: <netdev+bounces-70122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7374F84DC20
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 09:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D41CC1F222B4
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 08:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F776E2AC;
	Thu,  8 Feb 2024 08:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AuavEVwN"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B472E6F06D
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 08:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707382506; cv=none; b=R/vwEC6xG95LWpQQOKuRvOvJUxBq+a2hT1qzFkuaRzBvBNMWJU2TyLmxgMQH4R5k0xY/ciTcMPgpAYvSyqFRG8ht6xbyfeM9w8skBr4qtl9riHsXxz2dpyNvwtJEM2CfThiZwLn2INVgaaPNVQ9qWRh2ckAEiuRmTQsbDM9nM9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707382506; c=relaxed/simple;
	bh=YDqj+16dWvP7pAZuq/8i/vaNBaTolsWS6I+28VFEPmA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UEXzlWiMuloNcCSjgP4X6fbirobatuhE3vgydd/PnuQL3wCwvK0xnji0DmFwknrIFdcbCHZronwQqLp/3d5V50pM6Dg8d4zpRMFGI5ywcGHB3Gmhg81YMleY1F+WKFPnFYIoZ/VP25qqc72vglxU0riR+oh/W2YX6ZenrRKR4QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AuavEVwN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707382503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=YDqj+16dWvP7pAZuq/8i/vaNBaTolsWS6I+28VFEPmA=;
	b=AuavEVwN5CPohTimd7mwJLQwAYYq+hS0Q8wHIZEokWApukfTeO9FUDdpN3Z5O+wSRNUk7r
	ld6eVKvUNB6HT/+3OsWssjsM+lXiDFWgSg++LrUGC+Q6RRNDHoTdrfv3Lq8syukWUQoS0N
	oQ+BEmAbYl6lzLhF6FEAJORsbSrAzBg=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-383-dbisEwQ5NdS6eP9AU_pRjg-1; Thu, 08 Feb 2024 03:55:01 -0500
X-MC-Unique: dbisEwQ5NdS6eP9AU_pRjg-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-51161bd080aso449198e87.0
        for <netdev@vger.kernel.org>; Thu, 08 Feb 2024 00:55:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707382500; x=1707987300;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YDqj+16dWvP7pAZuq/8i/vaNBaTolsWS6I+28VFEPmA=;
        b=sX1aC76Hq6eIBvl1tNXNIc3fkFTqemRT7+IP7PW2bI+083BGFvYKw6NKn1xWWGRhAY
         COj46GfOo6aFyY/jztK2p39I3fpROYP4IeDWBuSUVeRunVJYehlb3H8dr6oDMP8QRX6F
         2QEL7OhC4rQplGOcm7ZtLpGXipuSqFS+L/0DgbkbPQVtSJyUS4GtOJznZcUJ6n1wyilK
         Aw2NveSEubomG9pkYy0d092/taqG1Kll3LFr29EhttWWCESkMLqvie34foZTOWrY1D9W
         bb4YHnu1RB3tJOuyQc7ZFRxJ1MUSga/AhfIdS92QaCd6NS3vSvRFahyGtSQq48yLMMHy
         yEJA==
X-Forwarded-Encrypted: i=1; AJvYcCUtUXK9q3HqzLT2okH4Mh8oOjaXR1807lEo7o4BM14rP1hyHdYNv0RwBkTRbetrraYV/huDEtSZ5y8DzH0h5R4/IzBF1Eqw
X-Gm-Message-State: AOJu0YwQADjaEZuZe40htzArbNePIXBftSKWxOqMAmVvVW+iqXffH+nv
	7PZEum2S74muMvfPS3M3J+L20o6hQv1UwZx2zcRE/RidzyFV6nVM79/XaHfC0lzNeJkhU4GRZjd
	T9pWse3K1WwYJgtSOBVRRuuKeUznXj7Ic61LUXxj1ZJN3y9zHqxXoPQ==
X-Received: by 2002:a19:2d44:0:b0:511:68e4:63e4 with SMTP id t4-20020a192d44000000b0051168e463e4mr2067082lft.0.1707382499851;
        Thu, 08 Feb 2024 00:54:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEkvNjAvY21SHsn5NTxoZvMRX4W3ccgrEXCovZD3BxBrNWmm66NR27I7LYZa8MpEM679Joxmw==
X-Received: by 2002:a19:2d44:0:b0:511:68e4:63e4 with SMTP id t4-20020a192d44000000b0051168e463e4mr2067070lft.0.1707382499487;
        Thu, 08 Feb 2024 00:54:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXYo5M8sLPt7smcr960cYOI7bkfgWnq+2HxzWh8Tgz+xWp8kh50LiJdZkSeBQ1AFNQsoP+ohzzDzbbbHtXSupV1Yk6NDu/Ib+T8SVvi6el697zRd7BGvq5SxPAjbCFGwWgU+dSHJeI2Fbz3wbkI7Idcz++K7ag2RgnRJ9Y5PB+lPiAagHd1CV6Dwezx+VDkVFY0yAsKogjjozLDDw==
Received: from gerbillo.redhat.com (146-241-238-112.dyn.eolo.it. [146.241.238.112])
        by smtp.gmail.com with ESMTPSA id az6-20020a05600c600600b0040fdc645beesm993431wmb.20.2024.02.08.00.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 00:54:58 -0800 (PST)
Message-ID: <f27d0d460f92456910aa9318ec76f0c9ffd9d9d0.camel@redhat.com>
Subject: Re: [PATCH net 04/13] netfilter: nft_set_pipapo: remove static in
 nft_pipapo_get()
From: Paolo Abeni <pabeni@redhat.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>, netfilter-devel@vger.kernel.org
Cc: davem@davemloft.net, netdev@vger.kernel.org, kuba@kernel.org, 
	edumazet@google.com, fw@strlen.de
Date: Thu, 08 Feb 2024 09:54:57 +0100
In-Reply-To: <20240207233726.331592-5-pablo@netfilter.org>
References: <20240207233726.331592-1-pablo@netfilter.org>
	 <20240207233726.331592-5-pablo@netfilter.org>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-02-08 at 00:37 +0100, Pablo Neira Ayuso wrote:
> This has slipped through when reducing memory footprint for set
> elements, remove it.
>=20
> Fixes: 9dad402b89e8 ("netfilter: nf_tables: expose opaque set elementas s=
truct nft_elem_priv")

(only if v2 is coming) A space is missing in 'elementas'

/P


