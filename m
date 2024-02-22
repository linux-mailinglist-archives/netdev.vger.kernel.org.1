Return-Path: <netdev+bounces-74085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A184585FE21
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 17:34:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4BF01C20FF6
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 16:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330B541A8F;
	Thu, 22 Feb 2024 16:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XLe4cFPg"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B5A28370
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 16:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708619690; cv=none; b=ekVFc666TWrlY1c9pjwZs0aw9Z8mrp9uZIqWCvtqyz8GsHODzWpxgPXTv8r1wJDvMH3WoOcVUfhwlzFvLeThFMpIYAgYVOD1vvt/ateQo3Ccq+Fz/kITb/mvNsVC9pajrRzawleMVHd/vOf7zckxkQMZm17RIf4bDZbbM5wTBg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708619690; c=relaxed/simple;
	bh=7DyanLwX8CUDBgT8244Z9wf2hd3zlbJpEZudRedvpC4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FnYPdd5vveh6z/FLyY+5npK96wusl91rdft86txH0+aINT4zSOESFXIzFJQmc9QVeqAdRwfIchLhN0lO5lE4JtGIexPjY0pqGnw6jWftNjIK4hPQfSf0NBS8FEUZlv1l1hXXgcR5hD8mOcTWE3WTdIvsjy2f+7c619ZV44cmlTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XLe4cFPg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708619687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7DyanLwX8CUDBgT8244Z9wf2hd3zlbJpEZudRedvpC4=;
	b=XLe4cFPgkXZsMDMHaImi5ydFcqZLibQTIPhRsdlct/wMPeyYpyAUJRCMKzndG9KOMTc8KH
	xkd0QhsFAmSvCjUHwNjSe3F8bpRfLiHThjcomh0Gla2DVG2CUvK8Ptf+so7lCRlYnXCcsz
	60XTVIarqrpw3Y9zVl1noyQ4cTizC6s=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-X_5pRAUqPiaRPL7w1uB2ww-1; Thu, 22 Feb 2024 11:34:45 -0500
X-MC-Unique: X_5pRAUqPiaRPL7w1uB2ww-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2d25a6cc0d7so5715801fa.1
        for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 08:34:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708619683; x=1709224483;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7DyanLwX8CUDBgT8244Z9wf2hd3zlbJpEZudRedvpC4=;
        b=bkCRtuS+QrOHvBL9Dva9LNXdW0iuTgQlrR08JPB+K3oZWkxbHTcP98NK1ksmbPuD2y
         h0MvfdGkeLj8EOuGk0iTgldr4ZB1gRsVSiux3OAYkbYlZh+ta59GT8Cez8GZdAv3us4C
         J8GSUeBzVyiWONiwHpVVK3EvhOoAUtWD+xfS2pqgYwd75hTtB9l5QViTMPlp5l7sux+4
         z8m3aAKMjYYptNQ++sZpZEfdgLBbDwCa23Z4JD6KdgmF6Hx4mopC0SiEHyx0tj9C8QCj
         1yFiS9m/eC60CPvG97QhCw8bjnKEk1iGhMZn0Pe9qq8eVf4Kq3Q1gmzfLKIOIeR6Tqil
         B9ow==
X-Forwarded-Encrypted: i=1; AJvYcCW9FCmjlO2eGomLKtpf99v4Psw1KLF79JMsKca5CcGNvp7gXOnOFi76m+g0Ju9+ZumD08C75uEqMPDYT5HyPx2PFU1vPZpy
X-Gm-Message-State: AOJu0YxH6cWpoSI4jiScv0VFUd19hnyR4xhJXwiIN22wGnRFDr6G2pce
	E1tH8MGcut/2B1eaxS72kSAc5ul1+jaLlyNeUunawgxrLQI5LjgcXhfiQFO6e5vKkMYsprI/m4b
	VMfylfVneUfI7FVdDtzXcobBtknV66vdrb2MWMh8hvqMxUcTaSmYKaA==
X-Received: by 2002:a2e:9097:0:b0:2d2:3b8b:ae76 with SMTP id l23-20020a2e9097000000b002d23b8bae76mr7371417ljg.1.1708619683279;
        Thu, 22 Feb 2024 08:34:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFakRI9R/IWPrgXGerRttOlSPH7r39VEi1O3pCNOqyXr50GwXtCUcLhINYebOWXBT5qOqaguw==
X-Received: by 2002:a2e:9097:0:b0:2d2:3b8b:ae76 with SMTP id l23-20020a2e9097000000b002d23b8bae76mr7371402ljg.1.1708619682887;
        Thu, 22 Feb 2024 08:34:42 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-224-236.dyn.eolo.it. [146.241.224.236])
        by smtp.gmail.com with ESMTPSA id t17-20020adfe111000000b0033d56d43fbesm12470518wrz.115.2024.02.22.08.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 08:34:42 -0800 (PST)
Message-ID: <267fedf547e8434e0ae638ed79e8a882e9c136d8.camel@redhat.com>
Subject: Re: mpls_xmit() calls skb_orphan()
From: Paolo Abeni <pabeni@redhat.com>
To: Christoph Paasch <cpaasch@apple.com>, netdev <netdev@vger.kernel.org>, 
	Roopa Prabhu <roopa@nvidia.com>
Cc: Craig Taylor <cmtaylor@apple.com>
Date: Thu, 22 Feb 2024 17:34:41 +0100
In-Reply-To: <9F1B6AC3-509E-4C64-97A4-47247F25913A@apple.com>
References: <9F1B6AC3-509E-4C64-97A4-47247F25913A@apple.com>
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

Reviving this old thread, as I stumbled upon it again...

On Fri, 2023-12-08 at 13:06 -0800, Christoph Paasch wrote:
> we observed an issue when running a TCP-connection with BBR on top=C2=A0
> of an MPLS-tunnel in that we saw a lot of CPU-time spent coming=C2=A0
> from tcp_pace_kick(), although sch_fq was configured on this host.
>=20
> The reason for this seems to be because mpls_xmit() calls skb_orphan(),=
=C2=A0
> thus settings skb->sk to NULL, preventing the qdisc to set=C2=A0
> sk_pacing_status (which would allow to avoid the call to tcp_pace_kick())=
.
>=20
> The question is: Why is this call to skb_orphan in mpls_xmit necessary ?

I guess the skb_orphan() call initially landed into mpls_xmit() to
provide isolation in case such xmit would correspond to netns crossing.

We had a similar situation for most IP tunnels before commit
9c4c325252c5 ("skbuff: preserve sock reference when scrubbing the
skb.").=C2=A0

According to such commit changelog the skb socket reference is handled
carefully WRT netns boundaries elsewhere in the net stack, the
orphaning on TX is not required.

TL;DR: I believe removing the mentioned skb_orphan() is safe.

Cheers,

Paolo


