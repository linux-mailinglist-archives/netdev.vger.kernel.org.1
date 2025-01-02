Return-Path: <netdev+bounces-154703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 488E59FF846
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 11:35:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2571162B40
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 10:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD481A8408;
	Thu,  2 Jan 2025 10:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d31alXSk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAC51AC88B
	for <netdev@vger.kernel.org>; Thu,  2 Jan 2025 10:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735814082; cv=none; b=lARs/WDvJg/J1D8cyTa4YxG3FtPZCHitlGT7uFAId1k/3XsyWrJxfc66Yk8IuxUz2dR+X3m29vKWMpRYdEvPLxkQ2cm4TQZR7AgJzh7fZagK7o8P5iVyiDVoEWPT7JmyTcyj9Wp2h6bsbi6SbG2GMLAcW8y2QoBJT61WZpl8/O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735814082; c=relaxed/simple;
	bh=ElrQSrfAo4NnIHqCBIL7YhgBC1VfGfuSsFxvwvVMkjg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Las+bPncycFFuk43aKOqIgFT7d5dAdY2FfhAOAJ0xPfTsv5hJCmQyKbeEq5tsjoZztb/6m82UEq/8f36/18VL1breTracKisNqPa+oXYEXkRxQfkKCqyI9MNXBx9kVCkpEbfIOqm39fO7g7pftpq90DGv1cr3AJuCbC5Vgg4eK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d31alXSk; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5d3f65844deso18423966a12.0
        for <netdev@vger.kernel.org>; Thu, 02 Jan 2025 02:34:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1735814079; x=1736418879; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sks17qciHddqHWfnM40Qn+F3GdiHrxZMi6A0V5O0rPY=;
        b=d31alXSk9qVDc9zqBv3Sn0gAv538fl3fLCPlmFv47v5f9E5JBUVP2nV55Pxqg0lTBz
         jZND1xeGNQwL+UXQH/1Pi3Op7cJkhHpC7d9hbi8T3Z8448p4NJCaHj+/Jkeuxl/Wy6LP
         yrxSi5kzBedCQfFOyuYHSpu+RSCnNao3bkN6rD37QfrE3ENZqdQW0Hl/F1c3QGeTxrDI
         VhFQaGAiQIiJns+9VUFigGXJyz/l/q1r0sUKeAQqcd2EGXKX+vkgwTVDCNSPlQYsq6z7
         r7QQt0N+PAwfg862S40Fi57sYG5v8H98KqlI/jA3iaAW9Kg2d3zDC8Pp2AzXfh8QFFya
         6HAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735814079; x=1736418879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sks17qciHddqHWfnM40Qn+F3GdiHrxZMi6A0V5O0rPY=;
        b=fHOixiRKUfRhnFKUuaDQztzQCwE9qM3EfW6zuqB1fJ6S08uUU5MBhiVoJfuQQW+s8B
         BZd2bYYJGxeBxC+wnGflOgCfQVC7GF65WG/PMu3ZYFV3Cv6w9huGhgLmmrmO3fKbX7yp
         zuLXpZxEDqpx26fCVuvh4HLExpP6B3ALxaWc3H0W71xygRE06Pzq9py8INlViesbGslj
         uicT+qEDqvc9eNqk6MIgUvdzLO7hu42gyYuWWbMdUG9TwEjm5aePokR7kiiduJVnO5iZ
         CzHTIi+JYHDcmKSFlY1okRpejuoaku+2sjIAm2GRCsNLbiT09Uiii6Uw+AWk8Bv1H6Y+
         Aa5w==
X-Forwarded-Encrypted: i=1; AJvYcCW0l+YrTZLdA+A4ZP18m2ARVSzP/0WPZ+5beXBkwpZgp+iBBtFcuSMLFqZaKCRiILMWsQcud8s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWbBsYb2IE2NxG7wbHs9Z3rcHimD3nFiUBJeYlc5Oc/Mwkbn+W
	6/gvnPxz3zNva09KMKsL/4mm1T5xqw2nTNg8r3ExsX68IfsXLtlPaP9kCsb0kpbtvqiKyjxNou0
	kvyMKjX2U0KvuOrCODqa6anVelqK1Lb5VJgd8
X-Gm-Gg: ASbGncuy2LwDo2YZJ2P4HftPyGKL6lKA7btk1jf8GW46Z+0kYd8tPB93VUnWnJqgfEw
	IFM56wREI1X6pE+jaEsO6tm2p4Ij4t79p9zg=
X-Google-Smtp-Source: AGHT+IGgQHIubZz9WKPEN01Itgy6ZOa0RLc/RmUbuVXnyvSBqUOgs3feFnquGIhI1nDuR/S+wXVSu36GHKEraNevemY=
X-Received: by 2002:a17:907:9805:b0:aaf:117f:1918 with SMTP id
 a640c23a62f3a-aaf117f1d51mr2433837866b.5.1735814078395; Thu, 02 Jan 2025
 02:34:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <da83df12-d7e2-41fe-a303-290640e2a4a4@shopee.com>
 <CANn89iKVVS=ODm9jKnwG0d_FNUJ7zdYxeDYDyyOb74y3ELJLdA@mail.gmail.com> <c2c94aa3-c557-4a74-82fc-d88821522a8f@shopee.com>
In-Reply-To: <c2c94aa3-c557-4a74-82fc-d88821522a8f@shopee.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 2 Jan 2025 11:34:27 +0100
Message-ID: <CANn89iLZQOegmzpK5rX0p++utV=XaxY8S-+H+zdeHzT3iYjXWw@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BQuestion=5D_ixgbe=EF=BC=9AMechanism_of_RSS?=
To: Haifeng Xu <haifeng.xu@shopee.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 2, 2025 at 9:43=E2=80=AFAM Haifeng Xu <haifeng.xu@shopee.com> w=
rote:
>
>
>
> On 2025/1/2 16:13, Eric Dumazet wrote:
> > On Thu, Jan 2, 2025 at 4:53=E2=80=AFAM Haifeng Xu <haifeng.xu@shopee.co=
m> wrote:
> >>
> >> Hi masters,
> >>
> >>         We use the Intel Corporation 82599ES NIC in our production env=
ironment. And it has 63 rx queues, every rx queue interrupt is processed by=
 a single cpu.
> >>         The RSS configuration can be seen as follow:
> >>
> >>         RX flow hash indirection table for eno5 with 63 RX ring(s):
> >>         0:      0     1     2     3     4     5     6     7
> >>         8:      8     9    10    11    12    13    14    15
> >>         16:      0     1     2     3     4     5     6     7
> >>         24:      8     9    10    11    12    13    14    15
> >>         32:      0     1     2     3     4     5     6     7
> >>         40:      8     9    10    11    12    13    14    15
> >>         48:      0     1     2     3     4     5     6     7
> >>         56:      8     9    10    11    12    13    14    15
> >>         64:      0     1     2     3     4     5     6     7
> >>         72:      8     9    10    11    12    13    14    15
> >>         80:      0     1     2     3     4     5     6     7
> >>         88:      8     9    10    11    12    13    14    15
> >>         96:      0     1     2     3     4     5     6     7
> >>         104:      8     9    10    11    12    13    14    15
> >>         112:      0     1     2     3     4     5     6     7
> >>         120:      8     9    10    11    12    13    14    15
> >>
> >>         The maximum number of RSS queues is 16. So I have some questio=
ns about this. Will other cpus except 0~15 receive the rx interrupts?
> >>
> >>         In our production environment, cpu 16~62 also receive the rx i=
nterrupts. Was our RSS misconfigured?
> >
> > It really depends on which cpus are assigned to each IRQ.
> >
>
> Hi Eric,
>
> Each irq was assigned to a single cpu, for exapmle:
>
> irq     cpu
>
> 117      0
> 118      1
>
> ......
>
> 179      62
>
> All cpus trigger interrupts not only cpus 0~15.
> It seems that the result is inconsistent with the RSS hash value.
>
>

I misread your report, I thought you had 16 receive queues.

Why don't you change "ethtool -L eno5 rx 16", instead of trying to
configure RSS manually ?

