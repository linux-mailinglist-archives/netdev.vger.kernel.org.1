Return-Path: <netdev+bounces-213119-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 359A0B23C5F
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 01:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 773561B63A02
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 23:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D33F2D839E;
	Tue, 12 Aug 2025 23:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hnEKyl+b"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80DF260583
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 23:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755041972; cv=none; b=UtWp9/Pk5xBrA1cjdpeNA5R470rEkBFBI4b84JCAI86zzm/wPoMQjtuUUfPSbd1N4uNqIqXznZJ61Uh1SD3xPH3Bnv4WP3fhQ1f4YWBWga3Q77eJu5GulQfU8A67hwVtOhCR3tkanKi6AmBYKLXhiU4PJfp1cQvJv73DGXqGkq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755041972; c=relaxed/simple;
	bh=2u0XX36G8WUr1qtUBpFR9KxbLHQzWOunOZrdURtwG8s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CWOh8UB1pVUMUDjN1yIvygYXf6gFTUNngwa7C/fWGD8Zqc/md1OoQi5lE6CW59iot1vqnCZ6WLZcOS+6hamWm0E+WB5s0Ioy4majUkBJojjCu1/YMJW1w3t3j38uUqommCdpBzzfJl1U1EjXYaayJQEzWp7SiwYh3bW/7iGiSMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hnEKyl+b; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3e55cdc7dfcso7302925ab.1
        for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 16:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755041969; x=1755646769; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lDa4RY/A4zLXKrwMbGuWS/YhifwvrF5CC3sik7v3i/4=;
        b=hnEKyl+bHG7t++H52/huPPE1fNo+qcNr+ClzlRJ0H60oEeqPyDH3tMAYqkELZMyxtE
         aLHCFPhoGhsxoYQLZ47zk2n+KwKmIDVoyjkEA5yanor21JOwtBJa6a74oxQ/89XInE/g
         6Qg28FTt/KTmW3HZ6kK6Dbb6o9T5PDXu1mCH85lFDhVGc4NBeAf34GKJX/rFPwxhY4xW
         hmFUhrPGvPLT4u+VPCFZxWJLHp67S59Sxvf/LBBWtJN7GpZ434W75YvPxZiIMbeRam71
         PCnGext0gnfSRTPqI/4XZKFKAzlyzdU+8YjBQyzklHLRrFihrLK9/aYXhs9dLMzOHWiT
         7isA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755041969; x=1755646769;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lDa4RY/A4zLXKrwMbGuWS/YhifwvrF5CC3sik7v3i/4=;
        b=nj0aRjfU242r0Okc83iejNVsTIzTNHEvyNBmBnYQjfk3pOxoYE3LKl+iLsQyWx/XkA
         Ha/SzYg4KG8dUabl5u6/KeREuBN7ofJFnHEL/cDhVfGsjf7+0gmESmfDg18+Zy9VJYOx
         dzPWPDnEUC4EVMYgjP27g9THjp8GCVefGi98yPkW51DAlj/N81jZP/QaUAT/oiBMJOuv
         LirRukEZVyOmL0Mymy/i4o3YUS7CGwr/7/rqdHjU/wbmaQUx1a9eVfE/Lw7dWhY3Yu4T
         ZEycXWQQA9QZXQ8au19CIXN70qvGYWtNQ6AKqGfXo0CT7nHSW+yzhRI6XrzkrLy4vPFv
         guBA==
X-Forwarded-Encrypted: i=1; AJvYcCXkRjKnc3WSNU8blroj2Aq5m2uBsbs+KK+emsQpvmpyPn6zDH2o1WgY1/tQ7yq2r+WEMbtQdOA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDguuziEeeLMIADDOwnETypzuDOrbHvdX7Viz7WOXR+fsQJowC
	YZ4jzzN5Avb15fufIS2uBZ3Wzld5lVeefq7wYI5zSPaBck3vBtTiUie7UEB/7rDGk0nWA0eYILM
	nqKTNYpqgk2hrFKcvhfGBNWlyeIEwprk=
X-Gm-Gg: ASbGncuWPx/mFEYfaj4WCEMuH44GRMxCNego7aRgmOjvIRfvTDhKVSbDZiwDyHOcm86
	6GRWLoxQZ+XZmQIpvKOeRZdwh21yFVtYCHAt2dkr2cOzy8jNKQyQyJ6nitVkQVERt8ynEVB7C+u
	M2Wg1DRF0pN0Esn33gsQbLZdaqh7K2ZYNTAhy07rTAywIuJI3WK2XEKvEc6Esu2/1HnxUXDVeYv
	UgniEc=
X-Google-Smtp-Source: AGHT+IGqjRsX8X8VePGuyeTdO0SC3QZ/PbAflQYbw1LnOTFGxXJikVsAfMeWuHZVnOAd2dBjLaT4jm3d2Yl42+s386E=
X-Received: by 2002:a05:6e02:12ca:b0:3e3:cc1b:2b5e with SMTP id
 e9e14a558f8ab-3e567486b72mr17128315ab.15.1755041969512; Tue, 12 Aug 2025
 16:39:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812075504.60498-1-kerneljasonxing@gmail.com> <f2ed5bd6-f3b8-4529-b9c9-28e05aae83f7@intel.com>
In-Reply-To: <f2ed5bd6-f3b8-4529-b9c9-28e05aae83f7@intel.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 13 Aug 2025 07:38:52 +0800
X-Gm-Features: Ac12FXyth5ETOMaNKWpIUd0SmauW4_ghf3VdfX476ya0B1enFigQFZ-hwsIPHPw
Message-ID: <CAL+tcoBk57evHp+H+A=VcFWfuT5DfD+ywW51Tg86s6KH5OgQuQ@mail.gmail.com>
Subject: Re: [PATCH iwl-net v2 0/3] ixgbe: xsk: a couple of changes for zerocopy
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, andrew+netdev@lunn.ch, 
	przemyslaw.kitszel@intel.com, sdf@fomichev.me, larysa.zaremba@intel.com, 
	maciej.fijalkowski@intel.com, intel-wired-lan@lists.osuosl.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 4:45=E2=80=AFAM Tony Nguyen <anthony.l.nguyen@intel=
.com> wrote:
>
> On 8/12/2025 12:55 AM, Jason Xing wrote:
>
> Hi Jason,
>
> A procedural nit:
> iwl-net is for net targeted patches and iwl-next for net-next patches; I
> believe this should be for 'iwl-next'.

Hi Tony,

I see. Thanks for reminding me. I will change the subject. (This
series is built on top of the next-queue branch as you pointed out
before.)

Thanks,
Jason

>
> Thanks,
> Tony
>
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > The series mostly follows the development of i40e/ice to improve the
> > performance for zerocopy mode in the tx path.
> >
> > ---
> > V2
> > Link: https://lore.kernel.org/intel-wired-lan/20250720091123.474-1-kern=
eljasonxing@gmail.com/
> > 1. remove previous 2nd and last patch.
> >
> > Jason Xing (3):
> >    ixgbe: xsk: remove budget from ixgbe_clean_xdp_tx_irq
> >    ixgbe: xsk: use ixgbe_desc_unused as the budget in ixgbe_xmit_zc
> >    ixgbe: xsk: support batched xsk Tx interfaces to increase performanc=
e
> >
> >   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   2 +-
> >   .../ethernet/intel/ixgbe/ixgbe_txrx_common.h  |   2 +-
> >   drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c  | 113 ++++++++++++-----=
-
> >   3 files changed, 76 insertions(+), 41 deletions(-)
> >
>

