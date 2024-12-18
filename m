Return-Path: <netdev+bounces-153044-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5EB09F6A3A
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 16:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EF0616CCE7
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 15:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA851F191B;
	Wed, 18 Dec 2024 15:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TWRJUd1P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398E91E9B3B
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 15:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734536395; cv=none; b=ZHlNkIgFCXLMxJdjq5NlPPOi6rSd64CCkEDfvbCzr9rAuQURRuPBmgZItzyvVu+zhULJNGuBBxIAVk6cckPBKbIrC1NUVwUL79rMmfHf4iBLPasi1fixlnwra548eHKP57eOS3g/K/74B3/lugvXtH6WpL1sy9lCYxOMGn2n0aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734536395; c=relaxed/simple;
	bh=DBsiqWEoGya7gvm4Ery+2cBjWZxM7gH0AFDQMIznTjY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KcHxmGTBK80T6M+f2Qfdf522iQwWPQ8YyozoOKOAJ21oUaid+DP2KZHBV1sYjL0KcN7YlAI+nWUX17OcHLXvPWg0jdkcEau6vr1MK6fslr72rXOtZfjgHLekqauaEYyLRgTAMDT7+oq3BGR8AE8jXRLE1kYyt3gwa/1iZrSOhBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TWRJUd1P; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aa6b4cc7270so896421766b.0
        for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 07:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734536392; x=1735141192; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DBsiqWEoGya7gvm4Ery+2cBjWZxM7gH0AFDQMIznTjY=;
        b=TWRJUd1PxMX19p8MG2xPjk7eaaAmdnHkzaLGRO5zEHebaCr2NDWWPd/iLBwCrCuPz4
         elNngXzjTWX0pfR/70TzUNTyt/GINP+pxYSoA2Z3u8Cke0ruw8QzSZmE8JiEpJ7RLZBI
         qJO63KbeP+BgvsfA7BPtO89jL0IolHuvBQoH0uc7D9b8uuCxqOAouEfJ01deNctoSMxF
         HRDjIXCOoKU8zzZP+/cIrdIpI9xyxu2MLATHLGHnjHMe+fSKi4EKbB8tBH9AyLMX2PCX
         nXkKluEQp0YXYMXNnE19Ob/DpYLgYDzaAxeuJP5FlVFTWO2+2MxyIO9LAWyh8WgT5Tiw
         lNEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734536392; x=1735141192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DBsiqWEoGya7gvm4Ery+2cBjWZxM7gH0AFDQMIznTjY=;
        b=fN6VPePMh8PNLC5DX7LWd7zLsgxIzVI0SW2DlSoMyHGK0dwUawMAi0DPEaUUKHpBv7
         lsxZfkoU6cmetsYIgT6jV8qxhdixoqwj3d5giZg1bsjMqGc6IqffzWgAbtJaepQskAtI
         LRxg0n5Ds6kG7/pYjEr6X11PqqVe6NiQOjukTecArpVYuU/ZsQcqDF0tQkOTsF2Ty04F
         6swFrIFLGxDIWhqYbaVHrnDi9twgrQSTIl4TFqIKFj9msI2YrTAu+LrZ6+vFgtDemZYS
         rvBa2UbJTpS+1e95cyi8dWERrZeFBpqRqeh0mIpQ1FVXhXlCtTr/up1B0P6Am+t+MKSY
         f9ZA==
X-Forwarded-Encrypted: i=1; AJvYcCWXg2p+KfCAwW2wSjrbjxAxKaH0Vv754qA5zW4WrxX4nX0eZUvx5vAJGzBdSA1yP43PBpOpxhI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhFmsvGmRVl6066tuCqmW8fDTbwulxrcWX+RXR+1cm8qMAaq2W
	HL89uRu05hS0eI0uWgVWAIrRmqeMqLI57bZcOwfC85F+CFlLt+BoRWzQup9VM0jv044YYGPNL9a
	SvUZvl+Wzma/9K1ef5F3BIW6eZUCEhT0st907
X-Gm-Gg: ASbGncs/yOIG4qM1FyLoKlj1YXMF7GnncmD/DavZTfhP2jcIF+C0OpJnbn8o4GnTEee
	COfhaJDYnLl5MEPoicDJpMk3dA4t7OLqjBVAe
X-Google-Smtp-Source: AGHT+IE8WqhWQY5xX4BJGXl9VSU8tyqz9aPbsQ6qI0aG0n0rd5Y76uJLSfePHazT0eZs9DmRdJQ9eZyfkAgJme5o6CY=
X-Received: by 2002:a05:6402:524d:b0:5d1:1064:326a with SMTP id
 4fb4d7f45d1cf-5d7ee3b5370mr8253615a12.15.1734536392259; Wed, 18 Dec 2024
 07:39:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241216075842.2394606-1-srasheed@marvell.com>
 <20241216075842.2394606-2-srasheed@marvell.com> <Z2A5dHOGhwCQ1KBI@lzaremba-mobl.ger.corp.intel.com>
 <Z2A9UmjW7rnCGiEu@lzaremba-mobl.ger.corp.intel.com> <BY3PR18MB4721712299EAB0ED37CCEEEFC73B2@BY3PR18MB4721.namprd18.prod.outlook.com>
 <Z2GvpzRDSTjkzFxO@lzaremba-mobl.ger.corp.intel.com> <CO1PR18MB472973A60723E9417FE1BB87C7042@CO1PR18MB4729.namprd18.prod.outlook.com>
 <Z2LNOLxy0H1JoTnd@lzaremba-mobl.ger.corp.intel.com> <CANn89iJXNYRNn7N9AHKr0jECxn0Lh6_CtKG7kk9xjqhbVjjkjQ@mail.gmail.com>
 <Z2Lg/LDjrB2hDJSO@lzaremba-mobl.ger.corp.intel.com> <CANn89iJQ5sw3B81UZqJKWfLkp3uRpsV_wC1SyQMV=NM1ktsc7w@mail.gmail.com>
 <BY3PR18MB472105E5D09B8FE018DBFC15C7052@BY3PR18MB4721.namprd18.prod.outlook.com>
In-Reply-To: <BY3PR18MB472105E5D09B8FE018DBFC15C7052@BY3PR18MB4721.namprd18.prod.outlook.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 18 Dec 2024 16:39:41 +0100
Message-ID: <CANn89iJ-vz8dfrHv2QChiQWUk14bQJfykTTYLMmOuHejgii4nA@mail.gmail.com>
Subject: Re: [EXTERNAL] Re: [PATCH net v2 1/4] octeon_ep: fix race conditions
 in ndo_get_stats64
To: Shinas Rasheed <srasheed@marvell.com>
Cc: Larysa Zaremba <larysa.zaremba@intel.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Haseeb Gani <hgani@marvell.com>, 
	Sathesh B Edara <sedara@marvell.com>, Vimlesh Kumar <vimleshk@marvell.com>, 
	"thaller@redhat.com" <thaller@redhat.com>, "wizhao@redhat.com" <wizhao@redhat.com>, 
	"kheib@redhat.com" <kheib@redhat.com>, "konguyen@redhat.com" <konguyen@redhat.com>, 
	"horms@kernel.org" <horms@kernel.org>, "einstein.xue@synaxg.com" <einstein.xue@synaxg.com>, 
	Veerasenareddy Burru <vburru@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Abhijit Ayarekar <aayarekar@marvell.com>, Satananda Burla <sburla@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 18, 2024 at 4:25=E2=80=AFPM Shinas Rasheed <srasheed@marvell.co=
m> wrote:

> Hi Eric,
>
> This patch is not a workaround. In some setups, we were seeing races with=
 regards
> to resource freeing between ndo_stop() and ndo_get_stats(). Hence to sync=
 with the view of
> resources, a synchronize_net() is called in ndo_stop(). Please let me kno=
w if you see anything wrong here.

We do not add a synchronize_net() without a very strong explanation
(details, not a weak sentence in the changelog).

Where is the opposite barrier in your patch ?

I am saying you do not need this, unless you can show evidence.

If your ndo_get_stats() needs to call netif_running(), this would be
the fix IMO.

