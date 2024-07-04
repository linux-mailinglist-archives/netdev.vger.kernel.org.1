Return-Path: <netdev+bounces-109171-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4EE927341
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 11:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60BF62813EC
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 09:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F361AB514;
	Thu,  4 Jul 2024 09:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VaEGGAK0"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE119224D7
	for <netdev@vger.kernel.org>; Thu,  4 Jul 2024 09:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720086129; cv=none; b=P18s41RHK2ITRF7dWv7crILO5OURjzTB2WOrfaF+zo9nzLfNsf5gwoOBOLD+5LN1yhqAc51FZ/ECUwBDa6ZnZzWYZmta6xcXreP7a30VYJr/7DpSWTTvYlmTWInnUQ+idYhndOReDmpY4JUO5jOOtH0m6iiI10M4eya28tsew4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720086129; c=relaxed/simple;
	bh=by/P7ek/G1+1pP2GiQ9ZIY5V4Tbnh4AI7R7ZhNI9RGE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oqowvlK6ISEqXba56GP/JaL7du2jGZ7Vc4JuEV366zklAjGX6kGHf8MV0fW9ZZWLcxtYewpzo0at3K5otDVuuBAXSEF0koD4zypj3LoEz1vCIuMlet4IWG0qHKFppOJNoI1XuS1vHq4PHjJ4HFcVHjSaEZdg99rabfnZqyc5TeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VaEGGAK0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720086127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=by/P7ek/G1+1pP2GiQ9ZIY5V4Tbnh4AI7R7ZhNI9RGE=;
	b=VaEGGAK0Ks2GwaHrNaxGvpScFahl4aOpfr3QbPcnfGUUeTpy8EGiU2YAx5zjNe8PZ80O79
	VhW4DkAlzlGDu6aDoSoF7BbcFUtSNoBGNSYlUNYzxBA8QuoUypSGCPr2wq+ArBgOaBSfPo
	t0ct9Esd5njBO1TMU9y9AuOvICl2bS4=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-DGH0ooSWOgGkjuqWf_Fhdw-1; Thu, 04 Jul 2024 05:42:03 -0400
X-MC-Unique: DGH0ooSWOgGkjuqWf_Fhdw-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2ee855d0761so779391fa.1
        for <netdev@vger.kernel.org>; Thu, 04 Jul 2024 02:42:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720086121; x=1720690921;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=by/P7ek/G1+1pP2GiQ9ZIY5V4Tbnh4AI7R7ZhNI9RGE=;
        b=vdRHDohZlI6Cga17yU5EXe/QdkcNp2EvtMp52Jb7s+NVat8Bj+JDLdi5KK1KTWMZEz
         y13DrEFuwpnMsApttHKQ0SCREBsvaaovJj28yrt9nNSKz4A3ew7OTiMszbV4s2C5SSQH
         +gnmoHMGrzHiFT9AMxf94Wg/1oTuOwKdZ+gj8jEd2yi3D6UUfDKCTxqGXNiFcjthq+xB
         LQiI/Q/T/eT5HKOH31ZqjVeb2k+6eiUhn6vFmokXcCWsVBcyQgkK9B2wIDznMPSTJzs9
         6er7AHjFeWob7snKcJ4vTSPh6FGSTs37M2uXvgcsk/MKtTwTz/MTrZUqj7LUw/Y1jeuA
         r2oQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNiEbKoN/ySgK7bDhtnFbdOxCa9+e4lxEIKQOam7ypnDobAAUjIjh6zSr5Beh+FXLQ8J8sCA7i0b144lcIIX4wOtpB0lqh
X-Gm-Message-State: AOJu0Yx3QMaiGqbr03WNZwuXuSBGTtYHAsd/86rwvaMFiAZHwWjXhoIL
	NoS9f7z06/yASipYwVv1OFRn5Gs9s17zkdHcyq6GCjBqh4zLlxG3xcmVytAbqiHblGsqNh2piTm
	suv2DWiWOc/LYS0OWpc/SbhFBbhzKx3qZ+V4KOnuhDUS5rJ2bFd5vmg==
X-Received: by 2002:a2e:8ed9:0:b0:2ed:59fa:551e with SMTP id 38308e7fff4ca-2ee8edff698mr6755371fa.4.1720086121610;
        Thu, 04 Jul 2024 02:42:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2D9gun8gCFnzvaVbgqOam2osyWZTKA2Va2LmGhSx8n8+rUrprx4KMf8DzJJHjmE1CvzPfnQ==
X-Received: by 2002:a2e:8ed9:0:b0:2ed:59fa:551e with SMTP id 38308e7fff4ca-2ee8edff698mr6755291fa.4.1720086121225;
        Thu, 04 Jul 2024 02:42:01 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3344:172b:1510:dd78:6ccd:a776:5943])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36798e435c3sm2036101f8f.72.2024.07.04.02.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 02:42:00 -0700 (PDT)
Message-ID: <b30c7c109f41651809d9899c30b15a46595f11ef.camel@redhat.com>
Subject: Re: [PATCH net-next] ntp: fix size argument for kcalloc
From: Paolo Abeni <pabeni@redhat.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>, Chen Ni
 <nichen@iscas.ac.cn>
Cc: oss-drivers@corigine.com, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, louis.peens@corigine.com, kuba@kernel.org, 
 davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
 yinjun.zhang@corigine.com, johannes.berg@intel.com,
 ryno.swart@corigine.com,  ziyang.chen@corigine.com, linma@zju.edu.cn,
 niklas.soderlund@corigine.com
Date: Thu, 04 Jul 2024 11:41:59 +0200
In-Reply-To: <65153ac3f432295a89b42c8b9de83fcabdefe19c.camel@redhat.com>
References: <20240703025625.1695052-1-nichen@iscas.ac.cn>
	 <5cafbf6e-37ad-4792-963e-568bcc20640d@intel.com>
	 <65153ac3f432295a89b42c8b9de83fcabdefe19c.camel@redhat.com>
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

On Thu, 2024-07-04 at 11:36 +0200, Paolo Abeni wrote:
> On Wed, 2024-07-03 at 11:16 +0200, Przemek Kitszel wrote:
> > On 7/3/24 04:56, Chen Ni wrote:
> > > The size argument to kcalloc should be the size of desired structure,
> >=20
> > xsk_pools is a double pointer, so not "desired structure" but rather yo=
u
> > should talk about an element size.
> >=20
> > > not the pointer to it.
> > >=20
> > > Fixes: 6402528b7a0b ("nfp: xsk: add AF_XDP zero-copy Rx and Tx suppor=
t")
> >=20
> > even if the the behavior is not changed, the fix should be targeted to
> > net tree
>=20
> This patch is IMHO more a cleanup than a real fix. As such it's more
> suited for net-next. For the same reason I think it should not go to
> stable, so I'm dropping the fixes tag, too.

Thinking again about it, this patch has a few things to be cleaned-up.=C2=
=A0

@Chen Ni, please submit a new revision, adjusting the subj and commit
message as per Przemek and Simon feedback and dropping the fixes tag,
still targeting net-next.=20

You can retain the already collected tags.

Thanks,

Paolo


