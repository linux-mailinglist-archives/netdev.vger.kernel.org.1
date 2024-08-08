Return-Path: <netdev+bounces-116768-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ACF694BA28
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 11:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 983A4B20EAF
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 09:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0481B1474B9;
	Thu,  8 Aug 2024 09:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DMAvC3dt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6C91DFD8
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 09:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723110941; cv=none; b=YXGLH+y+iMiwgIoltM9pyuJGEdYeeuSKICaRSloC1HvP0TVLGuw9EQvNNO03Lwm4vO3BU/xyyAch7Ze40D5kbVFP8XGzsVOAV7tgtiAD484j9Pan04nYqctuVlgf/6z7H+3Xs29aROntLcqcaS8SjCgpHLi4rbLq+gKt3DPuYYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723110941; c=relaxed/simple;
	bh=d/bpV68MaCY0vion/jTz5HkYTl0T+Zm/GfMeiGYQ4wg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mAYgw3M6cKemBnpB3Kw27VM6Tf+lqs1hBINcXwmQ9cBpCgqxAIyqEHzfjzXeDvzzyfT+ZCfk1JyH+AMgHiUcYjkRlu9QHU8NEBL0jOJgRNM3OTdg4XxwePLDMnRdFKd2ucR/7C6skRd8RoeIA/x2tQewuXQC6YhMtKxYygmwVYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DMAvC3dt; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a7ac449a0e6so74039366b.1
        for <netdev@vger.kernel.org>; Thu, 08 Aug 2024 02:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723110939; x=1723715739; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d/bpV68MaCY0vion/jTz5HkYTl0T+Zm/GfMeiGYQ4wg=;
        b=DMAvC3dtksJloklXGai284n9kluh4CZuZGImo6k4AYzceBpWhqjnlqkniJx1ZSYCJw
         cH2/Fy8fKWGhd0tcMxHrNIIDHcDx6dnbijMdw+p81KrwaRjqb4My6hkHNmW+Y/9MIBU0
         0JzjzuekkpU81oUU6PwSBSQHazXh6L/AWMbU6KYkkYdOC2eZwq3vkGiiijCtZwVkxxaP
         6A7GBvwkxOhsXJRQj4i3XiigjHtRsvszXK5Ty3NhxFXNaE6PjrRB1U6fuRegf922I4/C
         qHuLaOf67HAvNdoeViW1dPfKAgNcSewuWrnL6hTRVhRfuyhi5IuB1uDOa9gLInMDW8Ku
         TUiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723110939; x=1723715739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d/bpV68MaCY0vion/jTz5HkYTl0T+Zm/GfMeiGYQ4wg=;
        b=YBnPZid+9U1bHKkF9jBNHukWKFQrC8D29eJUkgaWClkw3gfk8TGOJAT9F1cvNs7rpC
         XnhsDge4vP5GQtWvQ0Ic79xnfvU/+6AE4kQr0SETEep/KaXpPVUq8hCT+/yWRuHJdau9
         Qw8CUlVZjg5381h4GFJUX0xkwBEtxdf2K2oFvht9mN7ON5FN3KyRyCaf/DxqrbQ5jznU
         O6So8dUOSh28QaFCRUVSwzn45LutgNZf9AyuQPJTuXUgFb1DvjjDqXpSUR+SHXr84U4L
         gPNTYek0D4xjwKh1newVeklEnxtSjX5rLXd2KBxWGix3J1UDS1i0V8giPuy/ni1LDFmX
         2kdg==
X-Gm-Message-State: AOJu0YywIIYuARdumNl/9vvWIY69bHA1p4W9DcAX7dNr6vMfMw+2nHcT
	uHriHG8v7cuOjxBrDBDIGRtyhHclmQXvpxiloa7LpPL/ZMfeLqsytWc0x08zRml5jU0uYa+p2qr
	A26dKYSdhHdHjuFZpU0bw5ND15QJ5CSHdXzw=
X-Google-Smtp-Source: AGHT+IH6ej/ZTzO+hOvkzfMaQw15ZXRho6TH+R/jjSLIVgI4G2RxSac4lW++dpmpV2NjheEE2yZwoWR1njrSFtVCskI=
X-Received: by 2002:a17:907:f190:b0:a7a:b73f:7582 with SMTP id
 a640c23a62f3a-a8090c2222amr92941866b.2.1723110938482; Thu, 08 Aug 2024
 02:55:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808070428.13643-1-djduanjiong@gmail.com> <87v80bpdv9.fsf@toke.dk>
In-Reply-To: <87v80bpdv9.fsf@toke.dk>
From: Duan Jiong <djduanjiong@gmail.com>
Date: Thu, 8 Aug 2024 17:55:26 +0800
Message-ID: <CALttK1RsDvuhdroqo_eaJevARhekYLKnuk9t8TkM5Tg+iWfvDQ@mail.gmail.com>
Subject: Re: [PATCH v3] veth: Drop MTU check when forwarding packets
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@kernel.org>
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Now there are veth device pairs, one vethA on the host side and one
vethB on the container side, when vethA sends data to vethB, at this
time if vethB is configured with a smaller MTU then the data will be
discarded, at this time there is no problem for the data to be
received in my opinion, and I would like it to be so. When vethB sends
data, the kernel stack is sharded according to the MTU of vethB.

Toke H=C3=B8iland-J=C3=B8rgensen <toke@kernel.org> =E4=BA=8E2024=E5=B9=B48=
=E6=9C=888=E6=97=A5=E5=91=A8=E5=9B=9B 17:23=E5=86=99=E9=81=93=EF=BC=9A
>
> Duan Jiong <djduanjiong@gmail.com> writes:
>
> > When the mtu of the veth card is not the same at both ends, there
> > is no need to check the mtu when forwarding packets, and it should
> > be a permissible behavior to allow receiving packets with larger
> > mtu than your own.
>
> Erm, huh? The MTU check is against the receiving interface, so AFAICT
> your patch just disables MTU checking entirely for veth devices, which
> seems ill-advised.
>
> What's the issue you are trying to fix, exactly?
>
> -Toke

