Return-Path: <netdev+bounces-227984-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F3FADBBE9E3
	for <lists+netdev@lfdr.de>; Mon, 06 Oct 2025 18:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D9F0A4EDA25
	for <lists+netdev@lfdr.de>; Mon,  6 Oct 2025 16:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7EF1F4625;
	Mon,  6 Oct 2025 16:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="glXwE8TS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BF11F1921
	for <netdev@vger.kernel.org>; Mon,  6 Oct 2025 16:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759767581; cv=none; b=S7r9XvGlf2pTDPxN0Nna4S82tHLR/ae8aoEMv8zwtxqLKuoAcYdVt6TfElLXDSvo44XKeaFa7FtDJF1cemTeVRFT8a1Sv9TXSQHvdFN+NsKjDarO0sfWg5NEF0qyMuFAhYkBWnq22rgVBqJgyFPcaIAv19sIyRNup6YTrkk6mi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759767581; c=relaxed/simple;
	bh=ilQLZBd6Iw562q61xBjSjhOvv2dstXz6kwD00scDbX0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=btgYzuzZx6ds1qPgkp2st2zD5n+RxxxE5e9QEX4ocpSCL8t/6FwUBpNDzVGfXI6faFumm5ZV552otlGeaf4x7iPbHdIDP6DIHvdPTR/gZ+kL2AX/+tsaL/TzsBPMab9+Uf6g+Qc0+1Amz0i+mIPf+myU3uYuqRHq2pIKQUE4ScI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=glXwE8TS; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-62f24b7be4fso9363943a12.0
        for <netdev@vger.kernel.org>; Mon, 06 Oct 2025 09:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1759767578; x=1760372378; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TTyUjRqJNWM7omsm7yhQtvnjFIwOU00+n+cJwl4in/w=;
        b=glXwE8TSJznJIHG9Wg5Aqw2xApX3nturVnmkmu5MJUl66WuImBArYsxTfQ1Ei/o4Py
         /TOIadaM8dvrOysoISWDrjCxnvTbZ7dpxGmVREwkdMhmgrnl+K955Gq14AM5F/m2DqxA
         UcVgeUzovfz+FRB6YtkVHoOZ8pl39WmEPuvTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759767578; x=1760372378;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TTyUjRqJNWM7omsm7yhQtvnjFIwOU00+n+cJwl4in/w=;
        b=nBRD9z81brTn3850kyuBL0a5iHh3xJNl+mhYOv2TglycSeBAFzAdP8n99TEryS1Dqm
         ngFjsDKC/hU+GKETNnGQUKnCsqYFo9yIzz8FK812YpN1u4KeHhEQFbloM3ecEWiQOrhr
         PsZDKqHgstZLyZ/sbpTcxUq1qJDTzA8LToiZatkiCAc03kqAD8GoYiNBEKx2//Rz5Sax
         hxNSrUWkdlliOql9qbmCMp/h2+IUJZypp8Gw2jzHEiMgSj6TZIz7uc1+VpWKJgvnNlvz
         Au1FQ6rXSwLDA+Pi2nI7uXUFFYF0DdKMmnY4tXGGFeuJ0mg70bSGMFCt2KJdG5kWBElI
         gUmA==
X-Forwarded-Encrypted: i=1; AJvYcCVzcLnWZnKR9K99B3eer8jWdDGHT+b0zH70duT3ZTb/MMhfFf9vIDrE5FMa3XObVSwKrxwrieU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZspVrHpQ47LmP1tLYKXJM8U2Hv0FJtl//DwwXjg1TftE1G5XM
	c9rbFgFHH0Z9vZYUoxf28CAteVvQtTplLDTvK9e/fHgd32Oiql2xssXMHOLobYE/+IEW75ypIl2
	ApmT17EE=
X-Gm-Gg: ASbGncttrnpnm9SpAtJQXDQpjvgJYEHQLnhEUDW7ge2+rcZAeO85EvVaVOyBo1HgUfP
	Xq9n0ka0idmXWM8G6iy8vKKKIsZkybEpAs5XDSYC5W8nU/WgcQh4o2WiqP2Ks8SPqLTKsWEvJYc
	huaBEKxs/uo65/bEtCkP6c4JphSe/8JgEXXqOJsTG4RYqpQImERcEahc06rN9Mgu6emZNNaqq2W
	XzGIgVv9tVmQr+ApAOSnQvdVkOTnt+osahkK8+Y3OskZERdK0B4U9kT4CYwt2hx/dRQK5DRmL7L
	om8kejjpjIMWdUmtYZ6xsz7C1mtZjM6GQvNxkh3TT/OYF6WfE1VRI27DxmG+25PhizT0ajkR6xS
	q9DAnGHNL28jJ3qjkQrY20uf4LYrAgXmlLcKgq34XCsi/AYWRcEwoKS4TP1jltCq4IBPUZTJrlW
	O22ydc0BQOLEpFMCtavbOFiqZOaw2Lcf0=
X-Google-Smtp-Source: AGHT+IH4NutzORj4UQJCgii4/cYjs0Itve9vs5nv63TXQIPPlyUfkSgs+TIH2uyIMEal/Tz7X4ZKGA==
X-Received: by 2002:a17:906:4e8e:b0:b4e:f7cc:6346 with SMTP id a640c23a62f3a-b4ef7cc8de4mr121658966b.15.1759767577857;
        Mon, 06 Oct 2025 09:19:37 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b48652a9ffbsm1171843266b.10.2025.10.06.09.19.35
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 09:19:35 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-637a2543127so9268521a12.1
        for <netdev@vger.kernel.org>; Mon, 06 Oct 2025 09:19:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXOzhRGDWFJlfbEYFdAr7OIR49mBjrMcQ0QqYxKrw4oGaIymDy45l5zU/4kytkvjAqxdZo1Cdo=@vger.kernel.org
X-Received: by 2002:a17:907:96a9:b0:b46:1db9:cb76 with SMTP id
 a640c23a62f3a-b49c3350413mr1708289066b.39.1759767575015; Mon, 06 Oct 2025
 09:19:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aIirh_7k4SWzE-bF@gondor.apana.org.au> <05b7ef65-37bb-4391-9ec9-c382d51bae4d@kernel.org>
 <aN5GO1YLO_yXbMNH@gondor.apana.org.au> <562363e8-ea90-4458-9f97-1b1cb433c863@kernel.org>
 <8bb5a196-7d55-4bdb-b890-709f918abad0@kernel.org> <1a71398e-637f-4aa5-b4c6-0d3502a62a0c@kernel.org>
 <f31dbb22-0add-481c-aee0-e337a7731f8e@oracle.com> <20251002172310.GC1697@sol> <2981dc1d-287f-44fc-9f6f-a9357fb62dbf@oracle.com>
In-Reply-To: <2981dc1d-287f-44fc-9f6f-a9357fb62dbf@oracle.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 6 Oct 2025 09:19:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjcXn+uPu8h554YFyZqfkoF=K4+tFFtXHsWNzqftShdbQ@mail.gmail.com>
X-Gm-Features: AS18NWDoHsGA-jRDtJnK1_zO_N3TBkB3duq0d2_Pl_53b0GJS8ieGMah2y3ZACw
Message-ID: <CAHk-=wjcXn+uPu8h554YFyZqfkoF=K4+tFFtXHsWNzqftShdbQ@mail.gmail.com>
Subject: Re: 6.17 crashes in ipv6 code when booted fips=1 [was: [GIT PULL]
 Crypto Update for 6.17]
To: Vegard Nossum <vegard.nossum@oracle.com>
Cc: Eric Biggers <ebiggers@kernel.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, netdev@vger.kernel.org, 
	Jakub Kicinski <kuba@kernel.org>, "Theodore Ts'o" <tytso@mit.edu>, "nstange@suse.de" <nstange@suse.de>, 
	"Wang, Jay" <wanjay@amazon.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 6 Oct 2025 at 04:53, Vegard Nossum <vegard.nossum@oracle.com> wrote:
>
> I'm pretty sure the use of SHA-1/HMAC inside IPv6 segment routing counts
> as a "security function" (as it is used for message authentication) and
> thus should be subject to FIPS requirements when booting with fips=1.

I think the other way of writing that is "fips=1 is and will remain
irrelevant in the real world as long as it's that black-and-white".

             Linus

