Return-Path: <netdev+bounces-73590-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA6685D3BF
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 10:35:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BC981C21CFA
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 09:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4FC3D54C;
	Wed, 21 Feb 2024 09:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4PvvNl0d"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E743D3A7
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 09:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708508130; cv=none; b=OvrJSvUreKDT8bXOO7j8Q9h8igGokEXfAOsazffH3hmwghIkIoXpITzqn/YSmU66lnWgdPSQ7jyvoxfob7I7vR55vwNctK27hV/ZAbR7D/YJukXa3tP6CKsIuK+Wbk6324K2MbSed7oeYU4SxZmfAQY36aGencFX0m1zW70PGzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708508130; c=relaxed/simple;
	bh=3uIQ5E7SmcqnZ1Vr4PlESEMfoBFeFZvyKIdGghvWtGg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SupIunnbBKDGVhxstBy6YO6cIH/aKmVpKWHx1NiJuBlPXg7DzPciT1SH3x9uTcrPzUhQAe9v0wdh4HFIsrsjoRjoucfuopjP+SXiBbEReBs8MXRMYUnr9fVZlAf/A2cFjdmfj2Lz58OaNpxt95fYSzu2G8z2MoPfuC1QtlgzffU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4PvvNl0d; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-561f0f116ecso6048a12.0
        for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 01:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708508127; x=1709112927; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3uIQ5E7SmcqnZ1Vr4PlESEMfoBFeFZvyKIdGghvWtGg=;
        b=4PvvNl0deKE1ZDmW4yRTaHl1s4iYzcWc5ScxD/WdhOnCek9f7neXJVPKnD8y9kPGz4
         rHDAiQzhddFM66whi5VAPNkRaMokkSbv9MJRfjZaZXxqzO0XpgS+MklM5c58378yeLqZ
         cJdxA73c1Q42cUQHNV+mCrGsFkxEg+Oy6l3YmdSdR6IdO7SY2U4skeZKxjw2pqYiujfy
         vZCHzJFI/+Ao6WXOYd7mDPtpXphRcpFTBE67qvO5NFIxfaTuCFqzjF/xnSUfVDynzDw4
         sOyh7QjfpgaGsuLN0AlQA07SAXVIuBSh0mV4xmmO9JkRrw9H2hsnGeiUXU0wtbrLFLgQ
         PiJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708508127; x=1709112927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3uIQ5E7SmcqnZ1Vr4PlESEMfoBFeFZvyKIdGghvWtGg=;
        b=BRgx0yW5/hv9J0nCSSCTQjVIZvJD1dm3qPdN8YUZacsuM2PhIT6f4Omr674iSf/CoL
         P3bJOQBf2LW0ytSYaIzK/GanODn8AsdKMs7o7QjG8ZbOas8IN+Cezl5ZZBWzbVfKUv2S
         7FZAMPN1dC/Cc5paEp6EsHL97xcQhRv6ueWrTHbXOoklelH8MIoKj2G655QTZVzRtZaN
         t6xmKbYY3E4/n6fck4XT9BWidwTbm2A/FDv+K0+9Fz7aJ/TEYxCFF2OoQ8CWry9trRYn
         3BIVHxdjy3zg86XQXHHBcfkERvkVaLMTnozzrQdZtAOgVqsOOOKpY7/5Mhw9HeBetqjk
         OsZw==
X-Forwarded-Encrypted: i=1; AJvYcCXW+4b3mzziTAaFtRKhEAs5wUCFD4ehxvyG/ifM8YzMquO4UfpIHx3eHxIL/VLEZUR1nUr3o+Uy/746dgH99/Ja37qzxkPq
X-Gm-Message-State: AOJu0Yzzj0Yx+e6cbkU0pdUUFHxbHTSmmLRbcYiFpfGDYBTLHabiRTic
	x1eIRY0XheEy/IbsE/72iQ/fo6R3q8Z1InJg0DIrKJvjmiYW/DW3U8oCTjxruTVVND18jI46ecw
	xL1CXIkZWNwiW3zbW160hxPCNt6jxPyPSfU5Y
X-Google-Smtp-Source: AGHT+IGXcHMt3ShTb1PthVGoZWcgqisgPU8aPi1WQblP+YYwtRbClhZ0yOyowxQ6UkIMTqAatTJjxT6OzVBMYs5HCIo=
X-Received: by 2002:a50:bac2:0:b0:563:f48a:aa03 with SMTP id
 x60-20020a50bac2000000b00563f48aaa03mr140701ede.2.1708508127058; Wed, 21 Feb
 2024 01:35:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221025732.68157-1-kerneljasonxing@gmail.com> <20240221025732.68157-2-kerneljasonxing@gmail.com>
In-Reply-To: <20240221025732.68157-2-kerneljasonxing@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 21 Feb 2024 10:35:16 +0100
Message-ID: <CANn89iJ3gLMn5psbzfVCOo2=v4nMn4m41wpr6svxyAmO4R1m6g@mail.gmail.com>
Subject: Re: [PATCH net-next v7 01/11] tcp: add a dropreason definitions and
 prepare for cookie check
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	dsahern@kernel.org, kuniyu@amazon.com, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 3:57=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> Adding one drop reason to detect the condition of skb dropped
> because of hook points in cookie check and extending NO_SOCKET
> to consider another two cases can be used later.
>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

