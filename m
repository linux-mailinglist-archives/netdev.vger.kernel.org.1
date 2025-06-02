Return-Path: <netdev+bounces-194583-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A77ACAC23
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 11:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB41D17BBCC
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 09:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82421EB9FD;
	Mon,  2 Jun 2025 09:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tJS4Ixnh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607321EB1BC
	for <netdev@vger.kernel.org>; Mon,  2 Jun 2025 09:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748858178; cv=none; b=DYOmneeLB+ntI9QGZR512QMZPOup3eKlXloiwuLbFiL/EcbL0FviWZrhGstx/f51xFBp12PbeGhr5p2EHYxSokjEzJLTDI7C55eMU6175ycWvbbQG5XLEMguTeG+1LDa7e9u6q1jxy88KjXg+3sRNGRfTdjtt1DGFWBTasTlYIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748858178; c=relaxed/simple;
	bh=I5fhIcX9R5LzAmpupA2doeAUw0q6Egg1zDl0/wS0r10=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f0kNdHwIG9wcH3bRnOr9G9oc0DynqKnuGdMvntrbzGZgmlDWMt61b/rl+sJXQXOsAagr1zLOufQ55N6rcfeHdXrjyAF0cBySod17F6QHtvQE2lbbXqLBvP8Z8Hv73T8wbPpurv0qLqNdll+b5/Av7IrOazoeTEIUB8f+A6HjfFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tJS4Ixnh; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7c922169051so208016785a.0
        for <netdev@vger.kernel.org>; Mon, 02 Jun 2025 02:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748858176; x=1749462976; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I5fhIcX9R5LzAmpupA2doeAUw0q6Egg1zDl0/wS0r10=;
        b=tJS4IxnhZVLPuRCSlcvZ5MsISx3ym21vfQ2Z6wl9Etaxg5vBWnbEnXNt8fZndy74hn
         6lNuvxmQHSvnXvjmiOHzdN4ibvrhpx2a3vleg447HY9vAy1xLEM2jTAofB7VIfOm604o
         lq/s7cFhqnfIUaACw43RW4wWU3rohWnmC0ALFPwveCyAMEf01lopOqyepppxvvzmVkQn
         7tY3LwUDfvowBisLLwEHsdcf+c9yb/fuVzYHnjhbyFN6aXK0VfKsE/DI1wO2dBOPQ4OK
         8bPepC5IdQv5849Vj+8K4qRfyBfHjHW2fBlJdppNDXLzQQU7ArzIrG7cTIqRLV2NBc0g
         MNYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748858176; x=1749462976;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I5fhIcX9R5LzAmpupA2doeAUw0q6Egg1zDl0/wS0r10=;
        b=mA7Pc6DSWlZgzFgAtOZVmFUaWnUPfp2BD764nk5jBXD+sh1KXzkI8qO1mKGe9oedsY
         V0HGZVdS7bMCGSZKKVupcuzRvoGrttv24/IjOUVHE5ggnJh9y1m6fZy0NEPgEipPOK0a
         7khmR238kCtwYJAk3myuDKDG6FWXwDqAuDdEXceyI7nePVfmyWpw7vqLmK5oBdx8Geog
         gup8hdYzgTA3/PaHtsELvDl3tGb5ZbhFJL2uX02zCvrDCl71ukPwsxyqIS38OrV0s1If
         wej2JLcqh5ppvyDLaPqygLJjGVTssGe8g4RznYRc5XWs6Ub+5KFuGISebT9ysHr4RgTX
         BdPA==
X-Forwarded-Encrypted: i=1; AJvYcCUWT5vwlSMxmEmh+ImO7ypaU2KRbZqp459CxWri9AB+VTyEI4rG+Or6a0oWhTvd6X6Q767W4KY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeWbWYvlkqh1KRfK5urMm1jqeWjushB7cOzlaJHKDKqsHXWMk+
	zff/dEO/TLG7NoQEEq+kgVrtrJ1Z89/KeiWskYH5kDZFADEsnaV3eQrzsojJD7cpj05JHbovisl
	20BAqkRHV5GXVnAOrMIHROvnXO/g0vOG5nj0wqR4W
X-Gm-Gg: ASbGnctwMmXWP15TktWxzDq/RJPJxANTslJVoivupWD2t3rHCHagXmfes3BJlh/joqw
	182LTyrjqGnZt/dnrGxp1XThTo4xNuQw9U4tgwdGy9Mqg5RIxquSVE1UEOxa9hqUe5CVuUUxtzq
	yhAS2yV0pU2J3vz07NeEyxsO1+dvYXsmYn+7sb1PrpZhixAgciiglh
X-Google-Smtp-Source: AGHT+IGmwhaOBW7VbwSOv1WMBKd6SlJI+wIxiB0zoKBYNRY6n8byD9lTOYsYwTbeAUBOkAF9KY/tvnaFVR/Hn7bYeIU=
X-Received: by 2002:ac8:5391:0:b0:4a5:912a:7c64 with SMTP id
 d75a77b69052e-4a5912a7c9dmr19160701cf.30.1748858175900; Mon, 02 Jun 2025
 02:56:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250601193428.3388418-1-alok.a.tiwari@oracle.com>
 <CAHS8izOqWWdsEheAFSwOtzPM98ZudP7gKZMECWUhcU1NCLnwHA@mail.gmail.com>
 <cc05cbf5-0b59-4442-9585-9658d67f9059@oracle.com> <bf4f1e06-f692-43bf-9261-30585a1427d7@oracle.com>
In-Reply-To: <bf4f1e06-f692-43bf-9261-30585a1427d7@oracle.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 2 Jun 2025 02:56:04 -0700
X-Gm-Features: AX0GCFvShUBo8WbtS-wLZUcQnyH6CFG5ESUmItrjErL_sH8T6UjJdi1uunrIFUE
Message-ID: <CANn89iJS9UNvotxXx7f920-OnxLnJ2CjWSUtvaioOMqGKNJdRg@mail.gmail.com>
Subject: Re: [PATCH] gve: add missing NULL check for gve_alloc_pending_packet()
 in TX DQO
To: ALOK TIWARI <alok.a.tiwari@oracle.com>
Cc: Mina Almasry <almasrymina@google.com>, bcf@google.com, joshwash@google.com, 
	willemb@google.com, pkaligineedi@google.com, pabeni@redhat.com, 
	kuba@kernel.org, jeroendb@google.com, hramamurthy@google.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, darren.kenny@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 2, 2025 at 1:50=E2=80=AFAM ALOK TIWARI <alok.a.tiwari@oracle.co=
m> wrote:
>
> Hi Mina,
>
> On 02-06-2025 01:21, ALOK TIWARI wrote:
> > Patch itself looks good to me, but if you can, please designate it to
> > the net tree by prefixing the patch with `[PATCH net v2]` as mentioned
> > in our docs:
> >
> > https://urldefense.com/v3/__https://docs.kernel.org/process/maintainer-
> > netdev.html__;!!ACWV5N9M2RV99hQ!JPpnRT9itx84rhzAaeGelVD-
> > bnJR8vFksx2OjGzAKZWf_A6o8hEY0CUMMUO_NuSStcCyBGnvhoJAJlADszR4D_aj$
> >
> > Also, if possible, add `Fixes: commit a57e5de476be ("gve: DQO: Add TX
> > path")` to give it a chance to get picked up by stable trees.
>
> I believe commit a6fb8d5a8b69 is a more natural and appropriate
> candidate for the Fixes tag compared to a57e5de476be
> What=E2=80=99s your take on this, Mina?

Mina is right. Bug was added back in 2021.

Fixes: a57e5de476be ("gve: DQO: Add TX path")

