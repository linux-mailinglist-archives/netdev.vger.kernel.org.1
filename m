Return-Path: <netdev+bounces-162617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 029D6A27643
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 16:43:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DA85163C0A
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 15:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A0E2144C4;
	Tue,  4 Feb 2025 15:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v6U6XHBl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0DE213E90
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 15:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738683778; cv=none; b=GRGz0JTlsLszmXZQTlpAiDjWDOPCYWQ2W9hWPHkKiOryYlZwwtFDJ+G2FtQz0F0weeZf1BuTRZisTaHrxO+vuJkgdOveuWyQj7qXOyG0xnt/sLgYP4ZjK1jiH4O+0MkEbenyob+yz4fv3YcKcQDH/l43U1R2JBCKDPl+/z923ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738683778; c=relaxed/simple;
	bh=WKYxvB29KoPpY2ZJLlKPPlneZlee3VS4ImWVkGJCcUU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pOKVJjUbYxp8AJKrm/e22xr3c6S5uz7gJrbNIMvXhhuOz2e4CDNyBZFgt4uSrvOw4KTTWccg168aotG0sEr74rTRO7cq2f63yQLNib4j6/M4QhIKbFtiyuJBP2pfjo4hEdvzSyFZylidFz1xRaKR7YY8R99rWyEWU4BWCnrlt3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v6U6XHBl; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5d3bbb0f09dso10153685a12.2
        for <netdev@vger.kernel.org>; Tue, 04 Feb 2025 07:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738683775; x=1739288575; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WKYxvB29KoPpY2ZJLlKPPlneZlee3VS4ImWVkGJCcUU=;
        b=v6U6XHBlje3til8JGs+Tj6Gv2OW0tlgSMXy3tkL5v68Vaw5FXeshqKUS2DWj1j5GYK
         jau3Kwbrkhxd3tsgOUzWbE5MKXO6mGQyKO+EFDdNx9bMhSCjP0FFw3Cf9kVmqvo92vUv
         45JiDLxZwqC9azkmGGXgm/ShaET4oKrdSOQ/BdpbxXaQQtogbh/sQp09tU6sfFB7LeBm
         MMABgN1SAzJA+10PoQieD3mVxJh0Azg/kB/0fdH8sdRe0gbfpssIbth/qaK4sKBzWLt9
         K03q7PLjY7YnxK1dj9locXgKO7cSXjHRwcoM8o/x5CqdRkNAC74g/8Wasg1vmrA5IAD/
         gpWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738683775; x=1739288575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WKYxvB29KoPpY2ZJLlKPPlneZlee3VS4ImWVkGJCcUU=;
        b=Cxx3iqHjdBanLpb6ETyhpww2QzehPBSW820BZ7w27L/HF+VcSpPacXf7Z9mYUsPzH/
         3a7tQrP86+/HFx/NBR9iQLUnkQBGYlBnw3l7HX18IC1WtpIS/uTe8slomjHeAppph5kF
         jS274NXbOVWixIGMvGQVQgEbG0SrT5wnzJA7jSYzKuT5X6pb8m+vheTcibicd3UxxbyF
         Z26xlUxujyOMBz0CkZBookdOTSAiL/EF5LH9WBukbQzt3q3jmbhZHaWyMVRQ+sbVhAw7
         PVP1/qyWabcr6Sx4CvBfqpMsX1gL2l22bcBgGrHu+yKzi9FUfcft9jQMih0wIILt9rl3
         Ki7Q==
X-Gm-Message-State: AOJu0YwntS4Z0H2h/ewcKT9tjK9G5Tns2e4jOYt9n+XjN0ASm2lI3YxP
	KQTKpNbbiC3RQncDp4yAnhG/jpumD50exUbHfC97gmbuFJHVsFUHBZYYVtcs6096V5k55ljRMoa
	H7xoA42fC1s5yG45c6wDQNmM3b7feqRrkGPGV
X-Gm-Gg: ASbGnctCmt8w4npnqT2yV6zWaUPQhYDE2h9kgXcOn7e/7ivsVXq+zphDyAANRFQk6kY
	LXdooxV0XMWtRIaHxhg7MYYcgLlwEGuovGBsAqj5goGkdGDiOZ+fLMG6Sc01qHSOtuAbSVjk=
X-Google-Smtp-Source: AGHT+IFL5FYNfb8KalkQOKKrKm6fSHl2cEYzmtWIdURCcfwK7zG/lEfzCxs5xRMzvy3AG9mPF4Tle49FAQcodezyweQ=
X-Received: by 2002:a05:6402:2692:b0:5dc:c9ce:b028 with SMTP id
 4fb4d7f45d1cf-5dcc9ceb11cmr2659948a12.1.1738683775163; Tue, 04 Feb 2025
 07:42:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250204145549.1216254-1-idosch@nvidia.com> <20250204145549.1216254-3-idosch@nvidia.com>
In-Reply-To: <20250204145549.1216254-3-idosch@nvidia.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 4 Feb 2025 16:42:43 +0100
X-Gm-Features: AWEUYZm8thjELbhHqvCMtNRvHs3lTWOS35Z-QOVP2u6fzl_KEZcSfv8MoT3yUeA
Message-ID: <CANn89i+V2F1xQiW=suF_1DnYcZyAucd9EP47G5RxATG7G-zF5A@mail.gmail.com>
Subject: Re: [PATCH net-next 2/8] vxlan: Read jiffies once when updating FDB
 'used' time
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, petrm@nvidia.com, 
	razor@blackwall.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 4, 2025 at 3:56=E2=80=AFPM Ido Schimmel <idosch@nvidia.com> wro=
te:
>
> Avoid two volatile reads in the data path. Instead, read jiffies once
> and only if an FDB entry was found.
>
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

