Return-Path: <netdev+bounces-113020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2DC793C401
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 16:22:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3D4B1C20E2D
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 14:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F8519D886;
	Thu, 25 Jul 2024 14:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HW08Grr6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC103FB3B
	for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 14:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721917350; cv=none; b=LHR79J/ngbxY+njG7C+NQBDkVglm37GLI1FmcFPNfxgwcko6PJNu5VrJB/4NqQM44bzXHep60ayGdjN/dmvUSGN7+LCQh6fM5Ppv+l7SEtu9ipz4xMn/CefwlZQkwJcKgClVFE2EaSyp3WHFZYXwBeCSjef8evazGfbU698ztqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721917350; c=relaxed/simple;
	bh=dL+ncTGj0c7P9TZPCMPPG/bCCf4hnCMnk3zt1HkISu4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I3ZV0sQpR09nS3K5NyqYkWstn9aTfSr08cAftaU+UT5fDtINoNbv3wbZw2KgxiB8f4y1lZhJkCCUUSk15W/m9RDk8wur7DNvYHZl5+asSeAiwHOa1gFsJzCe6gTwLa3ka8vyD3M80IfMDZeq/FWDTSdcgPPS0Ruan9pntr87q+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HW08Grr6; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5d5aecbe0a9so577850eaf.1
        for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 07:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721917348; x=1722522148; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3qIHtU0dTBcBvX7PEaPl4vxMCo7I8tXXeU8cK3cnUGk=;
        b=HW08Grr6bB7Enm/5hOekr9nCpJBEUmOlrBvoetEjxA74HzAgX/KF6yB6b+m5zgKPXk
         7CeqBFOngy6w3FIno2R5DQs2o7/C2cBylUrvaE4xgCjUUdW7tBy7koNdEcDEeKaBnu6m
         VjdjDBvxp8Fivj17/pa67okmObFsOM8nT4VAMP7Qj/BSzddBneuQFhFveKLk46eh8OdI
         FaTPV3w3xuYuknd9OIIq5XGWAv+3VQpXxbDg9ORUCMIsjNFesFSGY5y+QafTOdhai5Y+
         Lb5dXYTMyw3w6uw0VdPj6FbHet2jt5wLQTOI/HLdN8FL5jYlsDJfUsxXMfnTTVu/6u7q
         NFTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721917348; x=1722522148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3qIHtU0dTBcBvX7PEaPl4vxMCo7I8tXXeU8cK3cnUGk=;
        b=KaYDLoCDdCYVecFpvDF20fPnkalKrBjR0sWwp17CIHJlu47A66+Tj/XC89SnYCNAFa
         h/9g7wLxzQsJ8YP9JsMWZYGpfRBb+mVeG6LnoKPC/ZX7PfOrQrjlj9GCFWwE3BDwj5G1
         ocvHSfTEcKvaMjE9V1UpDy8LHf78KrcIClHsTB8QzPhDf5Sx9cafe4R03yGClwC9fHy7
         JGBgSB856ETua0CRUUjDII3DPNW8Uwao9biwLA0StzT7QuixFiikJu/JZ4cNVsVexMVN
         sbopTNpXufTbFFoWdKC5+6HjgTZJmGd6BE4pxKIObKLzkLnXlz+bLerwrGahexAwzr5X
         ihJg==
X-Gm-Message-State: AOJu0YyJAob0No0oI6nUflFTDUIQ8ghadc6Y8GIQGn+iF8gUM+uZX1QS
	vlTl3c34H40gwDrbYnphEGBkGp9srFjohRg1tn+c4jhXcaFSa+5sdgWItiHpTiaXfWz8vUWDpe0
	Ur4HyY1io4O8pYG9fH90yNcTRLuY=
X-Google-Smtp-Source: AGHT+IGD8qq5L2+1BObayoqeXim5P6jiGxmNADkCrzrkriJkJ2MlEjRiG4AB1UZ+XlrJcX8JSEmUvUY8WHtw9oM0mHE=
X-Received: by 2002:a05:6358:33a2:b0:1ac:f109:e248 with SMTP id
 e5c5f4694b2df-1acfb894d4bmr272130955d.2.1721917347739; Thu, 25 Jul 2024
 07:22:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240725-udp-gso-egress-from-tunnel-v1-0-5e5530ead524@cloudflare.com>
 <20240725-udp-gso-egress-from-tunnel-v1-1-5e5530ead524@cloudflare.com>
In-Reply-To: <20240725-udp-gso-egress-from-tunnel-v1-1-5e5530ead524@cloudflare.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Thu, 25 Jul 2024 10:21:50 -0400
Message-ID: <CAF=yD-LLPPg77MUhdXrHUVJj4o2+rnOC_qsHc_8tKurTsAGkYw@mail.gmail.com>
Subject: Re: [PATCH net 1/2] udp: Mark GSO packets as CHECKSUM_UNNECESSARY
 early on on output
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, kernel-team@cloudflare.com, 
	syzbot+e15b7e15b8a751a91d9a@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 5:56=E2=80=AFAM Jakub Sitnicki <jakub@cloudflare.co=
m> wrote:
>
> In commit 10154dbded6d ("udp: Allow GSO transmit from devices with no
> checksum offload") we have added a tweak in the UDP GSO code to mark GSO
> packets being sent out as CHECKSUM_UNNECESSARY when the egress device
> doesn't support checksum offload. This was done to satisfy the offload
> checks in the gso stack.
>
> However, when sending a UDP GSO packet from a tunnel device, we will go
> through the TX path and the GSO offload twice. Once for the tunnel device=
,
> which acts as a passthru for GSO packets, and once for the underlying
> egress device.
>
> Even though a tunnel device acts as a passthru for a UDP GSO packet, GSO
> offload checks still happen on transmit from a tunnel device. So if the s=
kb
> is not marked as CHECKSUM_UNNECESSARY or CHECKSUM_PARTIAL, we will get a
> warning from the gso stack.

I don't entirely understand. The check should not hit on pass through,
where segs =3D=3D skb:

        if (segs !=3D skb && unlikely(skb_needs_check(skb, tx_path) &&
!IS_ERR(segs)))
                skb_warn_bad_offload(skb);

> Today this can occur in two situations, which we check for in
> __ip_append_data() and __ip6_append_data():
>
> 1) when the tunnel device does not advertise checksum offload, or
> 2) when there are IPv6 extension headers present.
>
> To fix it mark UDP_GSO packets as CHECKSUM_UNNECESSARY early on the TX
> path, when still in the udp layer, since we need to have ip_summed set up
> correctly for GSO processing by tunnel devices.

The previous patch converted segments post segmentation to
CHECKSUM_UNNECESSARY, which is fine as they had
already been checksummed in software, and CHECKSUM_NONE
packets on egress are common.

This creates GSO packets without CHECKSUM_PARTIAL.
Segmentation offload always requires checksum offload. So these
would be weird new packets. And having CHECKSUM_NONE (or
equivalent), but entering software checksumming is also confusing.

The crux is that I don't understand why the warning fires on tunnel
exit when no segmentation takes place there. Hopefully we can fix
in a way that does not introduce these weird GSO packets (but if
not, so be it).

