Return-Path: <netdev+bounces-178831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01056A791E3
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 17:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 640713B1C45
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 15:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0EE723BD0C;
	Wed,  2 Apr 2025 15:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KnRp00h3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1313F23770B;
	Wed,  2 Apr 2025 15:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743606546; cv=none; b=sIzuAZw93qdZBLcfecSqaVIZ6PsAetlxF32Ja+BvEjvAm/8Tn55MKG4ACaechPz/BoYgwO13TNPP5QQVaQvJPOczzSLp0uyikZw5cid9bndeB13oJaq1FfwNK+9YLwotKlyhs151ZUOSN36yq2wKvkTOMz3yIC1U1xNdRR4HXfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743606546; c=relaxed/simple;
	bh=M1nbXxP7ZDOg8LGHon8qFT2bH+6w0kHD3NMR+VR5fqo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qC5g53e2iurSUuI/Rioldm4sn2YuKCW8QTe06+2K8zWHgH6/aJZsLDElHty70NvvdlJYuCZ5Fzisro5xuXoxbOSwUXabOb5XnxQPYIvU0IuE5lItscy4BPvTCrJtCh7VsO4Ka1cpjkEmLeul6r/191/gdBS+AA/C1lrRQCkRtZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KnRp00h3; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-476a304a8edso62896791cf.3;
        Wed, 02 Apr 2025 08:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743606544; x=1744211344; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=M1nbXxP7ZDOg8LGHon8qFT2bH+6w0kHD3NMR+VR5fqo=;
        b=KnRp00h3pkiFGzgaNyY8H3wDc8esnzY3i6EtvJLkZgAZ3FA9wzblp25znCrjN8G9Im
         hspTWvk531AW11TEOzMVLYetZDiLviZ6geyvNGHnrvKi8c69Mm/UECq9WqULnXIVXJFl
         ne/bHGrous5x9lIufAelY3h5XJ7uo05BoKyly/V4N7ilzRZQHgCVXz3/O/S/m4gpuMne
         Wk2yKvr/GiNubBuAUD5rb/BQxorLpe0iel1psOEeIDlG/dSXBfcNbiZlj+mzwbSv2h/j
         1dKcF5OXFwqaPbY/Aj+c50wAOZofA5KHtteAXshshIfUPQ+cQYj4X2wU94YM6hmhXTwn
         C1uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743606544; x=1744211344;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M1nbXxP7ZDOg8LGHon8qFT2bH+6w0kHD3NMR+VR5fqo=;
        b=lJUWPNXxCu1uPBfbQz/4+m00S26VzTc+0NJboNeFoDi+jtBOVDyBZG2cTn7+hFAQ5J
         hNnymtOaPUUWUa7Y7o5oEOikb/YuKQfosVHB0N8z90PHadPOE17RE6iBB3xlPCteLvfm
         Jpulzk/1K8faapuzCA/d5MmkV2addBg0YqjVPc9m6m2nMPYyUQ1hI4EwhSd1KiAnSzwk
         GICwhJ5suaTejrRWE/5tF+xpC13cEGpSP5R1sCspaRd1vUtDs9M+hieLB8vyxeagHYx/
         UH9UAtRsaG0Xka0Bnees+JpkZ32zIVhzFZ+14uHWow0rtrDrGhNseWrpyJv3jbndwB5P
         +Lqw==
X-Forwarded-Encrypted: i=1; AJvYcCVAHaULDmOXMOg0AePQZ9UBZ+gwxSHxGfu2I3ziL1V0eiV/eyTp5DY8z4zTNaXCrs7loEEuTs1UzorZ@vger.kernel.org, AJvYcCWAwxjriwh8aztx7iTB4KowKrr3/iL8kHM/jjtpo/OWgpUOtWgVDRb0cl2ZsUWy13OZMEgx+U2y7838bX6V@vger.kernel.org, AJvYcCWNnQwBN/XdESaf6jyELUt0DhPX0ejbUZ3fq1qRpWTagwXbaBTE4oeBaZR3A/mspKYVqZm1cfJ+@vger.kernel.org
X-Gm-Message-State: AOJu0YwM/zEO+M53qsL5p5rb2tIhP60ZmhW8iLTaqnjY4fiAmT/T6gxS
	ch0uafpuStZT0eaTV+4SRJuH1aLjBTh2xHBxqR2lXVKKCIRrNj3gNOuq2g6eZf4cBDTYZteS3jI
	51pYzOTeiMFC+oFvrV9dYB5VFjug=
X-Gm-Gg: ASbGncvB08znuuuWs+I1eEXDfeqZ8qqTOcHCE8aWOfYl65zW0maPf4utTCoTyhfIJaI
	kkI62B22z4V8r9mcX5PT1Q6BSqBVOacUPM1X/6JgS75AuYyzPTy74C4XnuqD65qt1jlyFoTJqI7
	sKI5VVjpCTuVpTBmZyEMathmRk
X-Google-Smtp-Source: AGHT+IGWVDgFlvuUmKG9XR+fZ9Ddp0TAEC8BmYmrT6SGDuTFk1wXspzl4CjuSDoqYA9uPhtP87kVds/20z6TbbnWld0=
X-Received: by 2002:a05:622a:1aa5:b0:472:1d98:c6df with SMTP id
 d75a77b69052e-4790a034c6dmr43677261cf.52.1743606543883; Wed, 02 Apr 2025
 08:09:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250318235850.6411-1-ansuelsmth@gmail.com> <ac525337-7d5d-4899-8c9a-90b831545d88@seco.com>
In-Reply-To: <ac525337-7d5d-4899-8c9a-90b831545d88@seco.com>
From: "Christian Marangi (Ansuel)" <ansuelsmth@gmail.com>
Date: Wed, 2 Apr 2025 17:08:52 +0200
X-Gm-Features: AQ5f1JrJw-qfrf_9BYfe5-47TrLxUsgbD_vACwlUrqn1aquYAkLqhr6tksjtdeo
Message-ID: <CA+_ehUxXbzhkKeQhc70_DvSX65MN46LCb1YihVCDY6CV=R=p=Q@mail.gmail.com>
Subject: Re: [net-next PATCH 0/6] net: pcs: Introduce support for PCS OF
To: Sean Anderson <sean.anderson@seco.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, upstream@airoha.com
Content-Type: text/plain; charset="UTF-8"

Il giorno mer 2 apr 2025 alle ore 02:14 Sean Anderson
<sean.anderson@seco.com> ha scritto:
>
> Hi Christian,
>
> On 3/18/25 19:58, Christian Marangi wrote:
> > This series introduce a most awaited feature that is correctly
> > provide PCS with OF without having to use specific export symbol.
>
> I've actually been working on the same problem on and off over the past
> several years [1,2]. I saw your patch series and it inspired me to clean
> it up a bit [3]. The merge window is closed, so I can't post it (and I
> still need to test the lynx conversion a bit more), but please feel free
> to have a look.
>

I'm working hard on v2 of this and will have major change, so I feel it's better
to wait for v2 before adding more ideas on the table.

