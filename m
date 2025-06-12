Return-Path: <netdev+bounces-196937-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3844EAD7023
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 14:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1D051BC5B8C
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 12:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5786B1EBA09;
	Thu, 12 Jun 2025 12:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dBODiaWE"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFE821FF5B
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 12:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749730846; cv=none; b=NGOTV+OwtqAswM+kbZjY9oQNtrA8iqNxySVCjWpvKR7UPMwM2L0AB4wTNC6aDQgMEcBRJIfEg70x66qLiZNVHoY1uus/5yCiZ+5SzFKv54hBU8bglGFCht1MuhKz7WVj5Jdk1jOLDeH+zmzl5UoxJ8fdx6k516p4ofhL9MgpPhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749730846; c=relaxed/simple;
	bh=5bRrnNEVmzlKHFuvGJz829HCaC9P8gvdVF/SVBGl75A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H9TBRp3i/XlyEjOBn0FHNT5UpjiEwDjsJePKIf3SINJsTMinZE6Uhlv+dCeZDpDf/PXUVQeMtjgvG4UuHZdf+jpxXTrm8xJs99N/f9VFP1rsicv8OG9B/904h906ciFoFbIsXXZbz4+xrvy5UrZJuD98TSPOtsBFI2Xxb2vX9do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dBODiaWE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749730843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wPfKLRrYHfLESVYSuhn1tsLnMTuW/HBaOWGxzDd/vYM=;
	b=dBODiaWEVYwzbH9j7tym8UlUM1ad3Es7n3KxV9/IUeAJ9OI2XJrMNKwJAZbJSipq8ERWzY
	7BNOqFbsdAUWK4znZ2XOS2tsdafjfhv9MGfMg5h+jPMemOhqsACq5SHYNUr2y5JW7bGYgP
	/LFObWn+VRlkTvC9CdFtMp49Gmi3PiI=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-275-ULE3w67jM3uOTOiIZzN9Aw-1; Thu, 12 Jun 2025 08:20:39 -0400
X-MC-Unique: ULE3w67jM3uOTOiIZzN9Aw-1
X-Mimecast-MFC-AGG-ID: ULE3w67jM3uOTOiIZzN9Aw_1749730837
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-32add2506abso4682361fa.0
        for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 05:20:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749730837; x=1750335637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wPfKLRrYHfLESVYSuhn1tsLnMTuW/HBaOWGxzDd/vYM=;
        b=V/719JdBC7+pqd94i8+WM6Zhu1+PENoK9q4NjgS3dgWT6RSb0B3s8OGSi++5qwg0VV
         K6ZB75UVVRsK+ZM/7hUHeqSJulHLvlVKbIyol3zko9HTiSLpoNI4HXg4vQ6MREQuAe2d
         YNbS0RDeNrwNyMJFM1P+RFR51Tn3dvSZzMlHtD4q6cuFmt9SaIW6KXr+/XGP6vVGU8Pw
         cg2QvAy/ZEF0WXKttGJxm+k3InkqhRph9BXC+ujK2TKpAy1/DNlBLg52nb9uhWQao3dH
         QUZ8wg4x1Dr7nktG3DiPT7KGPGaSuHX3DU4y2e4Yq+bLIUBLRySk6tfiF5oZFuw4JkGm
         iEbg==
X-Forwarded-Encrypted: i=1; AJvYcCW4yQBtoZ9CLhrCOt/Rv+PLWKq1R10v6QaWl8Wkqq6U8fhzTBP6+iKpEckwLLHf4WuXB2s3sow=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAnLSi8A6MuSbUf1VHZjiiYAMF0AkWJeODbrysIiQnprw0z88H
	fGeCXJAjHZjNyQxqfcyKDLOqCdHZZPBJizd85oo9/U2aP8Bbs6G4ljRQC78smI4VOEFmMhsueba
	bE6Di80gaXJCMJQDmZTW+Dot2pwHT0iZ+3urF1YaPkt7JG37YhVw/1meD3hp+6momsBDlQ7PDou
	wKolMYuA3vXkQxATmDkGENoIEWBed+Tab6
X-Gm-Gg: ASbGncuaIXeYUXEjtWVMkXcyG4L0w+AAsvssDQiAl5kcsXXTiIqg1Zn9CSqm84RHZjM
	tzRpZsxTaxvtIfEkjJ3YYeINwwvBaEYwvaYw6bU3yuBbxyLBb7icDMf8SJcBrGf9Fix3dHP2ae+
	qEzF8Wcf49mS7Q0rZHNEdIwsheICODd1hx1U75
X-Received: by 2002:a2e:bc06:0:b0:32a:8764:ecf1 with SMTP id 38308e7fff4ca-32b305a2930mr8945111fa.4.1749730836611;
        Thu, 12 Jun 2025 05:20:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/BRLhB+dI1MyJZUrONMgznWLw3sFvTM95ZQN6Otaa7RRDpDwmHoTs3n884g8T5EAi+/5hXHBR3+PFLpM5qLc=
X-Received: by 2002:a2e:bc06:0:b0:32a:8764:ecf1 with SMTP id
 38308e7fff4ca-32b305a2930mr8945001fa.4.1749730836240; Thu, 12 Jun 2025
 05:20:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250610105338.8166-1-ramonreisfontes@gmail.com>
In-Reply-To: <20250610105338.8166-1-ramonreisfontes@gmail.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Thu, 12 Jun 2025 08:20:24 -0400
X-Gm-Features: AX0GCFt_G8IDREkiLGFZvfp8ckIRZQKTzQ1w2HU0-HtCyraui5l54w_Y5s2s7H4
Message-ID: <CAK-6q+jDa4=DFndeQVzpaWemDPxf5Pr6Mrimm8ruDSsTriOmSw@mail.gmail.com>
Subject: Re: [PATCH] mac802154_hwsim: allow users to specify the number of
 simulated radios dynamically instead of the previously hardcoded value of 2
To: Ramon Fontes <ramonreisfontes@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	linux-wpan@vger.kernel.org, alex.aring@gmail.com, miquel.raynal@bootlin.com, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jun 10, 2025 at 6:54=E2=80=AFAM Ramon Fontes <ramonreisfontes@gmail=
.com> wrote:
>
> Add a module parameter radios to allow users to configure the number
> of virtual radios created by mac802154_hwsim at module load time.
> This replaces the previously hardcoded value of 2.
>
> * Added a new module parameter radios
> * Modified the loop in hwsim_probe()
> * Updated log message in hwsim_probe()
>
> Signed-off-by: Ramon Fontes <ramonreisfontes@gmail.com>
> ---
>  drivers/net/ieee802154/mac802154_hwsim.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/ieee802154/mac802154_hwsim.c b/drivers/net/ieee8=
02154/mac802154_hwsim.c
> index 1cab20b5a..bf6554669 100644
> --- a/drivers/net/ieee802154/mac802154_hwsim.c
> +++ b/drivers/net/ieee802154/mac802154_hwsim.c
> @@ -27,6 +27,10 @@
>  MODULE_DESCRIPTION("Software simulator of IEEE 802.15.4 radio(s) for mac=
802154");
>  MODULE_LICENSE("GPL");
>
> +static unsigned int radios =3D 2;
> +module_param(radios, int, 0444);

this needs to be uint, and I think you had that in the last versions
as I said in the last version.

Sorry but letting that through there will be the next bot detecting
this and somebody else fixing it and I kind of was aware of it.
(Now I have some half of an idea to maybe get rid of that parameter).

- Alex


