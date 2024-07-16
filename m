Return-Path: <netdev+bounces-111741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 842139326B9
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 14:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3975D1F22FFB
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 12:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272CF19AA58;
	Tue, 16 Jul 2024 12:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UwV6h0sP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B3E4D8A3
	for <netdev@vger.kernel.org>; Tue, 16 Jul 2024 12:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721133683; cv=none; b=N4hRSM6V1h7us7bPC4ixvuSwyUXieh2wzLITpS6zl5K93mgE8iyymkBgbA6tyUshDxmhsUTT1abK+njL6aql9nOwa6F7/LpWDqaxUblNwBoungccUH9Zgj96a8Rs4GcW8uZAtDgeQdORL1IrzCP1H5nwqdaxmjtSpALE/dTdThI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721133683; c=relaxed/simple;
	bh=g/4Akut5VXNatHaPEmlQvnIpv9zI/MvKV96Vz/5Uz74=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nhiu/myH3mtsliYQ9t16GXzIvMEcwTJ/Vq8EeK3+nJU0j09wwNO2t5NALtudDOPfEENT7/bD5MLJp28+I2XM7i6AUhxEPvFHZ5GNnyVMxGcOrpatbMGfHmpojIcaZffvYJ++tuH9yUO0ojckvpGehuq0bE7T9sOwoFxS4pgr2wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UwV6h0sP; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5957040e32aso3578776a12.2
        for <netdev@vger.kernel.org>; Tue, 16 Jul 2024 05:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721133680; x=1721738480; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=40FsxvUJ1AT1p9/HLeH/DEoxUCK7clmkGVHWoNGVLkw=;
        b=UwV6h0sPkUsXJf431PVVRN69gB8v9h26CVWSXptHGKDSkuGPK1uZR4JvUQXQ7v8qcq
         QEdk02rXDXbevMwp5LcnnkO1lwoqsUzSiwDDkjv5axBu0da0/cZp73yO9eyOqdk566++
         hreH+m9aA+zBvoUqR2bmLctdyLA61/SBRDVKxXw9yY8BJFP7vSTyU9uke/J/lOX+g1lC
         +RO1mJv7uYeNL7aiFCPrmrHV011Ud1mLSzcfijfjp5MPMn/blttqxurocNAkd0xqNXEc
         6iZiCYQzBj38xQFsK1WiJ9as//Go3ESm2urwklHQCyAnBd0fKALR4eNpojuKuE/JQted
         zgQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721133680; x=1721738480;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=40FsxvUJ1AT1p9/HLeH/DEoxUCK7clmkGVHWoNGVLkw=;
        b=KYXYDwBB5DTgoD3jepkkdqt8/SMOE6gONbGjga/nFtTPg6g7uepyu8s1ZzKusPtdqS
         KHAlwXNIK9ukJEOXkvESak/UnUpcI3rBNh/R2F9tKLuZ457/52cS//878LZLsRbsczcr
         vxAlr0Iox36ezOzVXMHWsXdBwDjo2/YwjpX0tkTXkJJ9PwDHoAHxA25dYKfvE77Nqphv
         4avT0Gw092+TVXYl/1qvUFroDUpAPfmSnGkDWyNptz2EIQIa1xmK9Fxlb0RrDSGmBVPu
         YYavT0p4dib+5pGGNd90PxQZRlGcbDT+/0hfVgHQU+Bvd4PN9ejbMxHVQflbBoVenBsl
         dhvw==
X-Forwarded-Encrypted: i=1; AJvYcCXEnHAvybMOOe6Qtcp4kGowGmO4UKLZQmQzZ2S2tP3WdrXN3+Xdhbx2R9W5Ycf+n8D1Zo/y+gC7xsyZEdivNQDST+Yv7uCz
X-Gm-Message-State: AOJu0YzljhumromAYhdP9yknBUYkUvVhrOrRXhOQsmX+1N2Bbe4sWn4K
	fuxQHLwszTebkRZUPZiFLnHcLEWqM38WzhYiqI8B3olVHMEkXMcA+BJwsR73MlSnUGQAkBHpOnN
	Bq/jo8FpvDMLYrORPIGolPsXEEMY=
X-Google-Smtp-Source: AGHT+IFWdb2GwTR8EDTLDplbii5gjk3NNX4+iMYFyhzigv0NFP9VhRVg0It+UIqcU2XUEHJ3hWupszP3MIC2JjYF9gQ=
X-Received: by 2002:a50:9f8f:0:b0:57d:f84:11aa with SMTP id
 4fb4d7f45d1cf-59eef9a5455mr1433684a12.31.1721133679425; Tue, 16 Jul 2024
 05:41:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240716015401.2365503-5-edumazet@google.com> <20240716111012.143748-1-ojeda@kernel.org>
In-Reply-To: <20240716111012.143748-1-ojeda@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 16 Jul 2024 20:40:40 +0800
Message-ID: <CAL+tcoDVJK_J+ZGs=b94=A+3ci0uD4foZ4JQRmVa8+44udeUxA@mail.gmail.com>
Subject: Re: [PATCH stable-5.4 4/4] tcp: avoid too many retransmit packets
To: Miguel Ojeda <ojeda@kernel.org>
Cc: gregkh@linuxfoundation.org, edumazet@google.com, davem@davemloft.net, 
	eric.dumazet@gmail.com, jmaxwell37@gmail.com, kuba@kernel.org, 
	kuniyu@amazon.com, ncardwell@google.com, netdev@vger.kernel.org, 
	pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2024 at 7:10=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> Hi Greg, Eric, all,
>
> I noticed this in stable-rc/queue and stable-rc/linux- for 6.1 and 6.6:
>
>     net/ipv4/tcp_timer.c:472:7: error: variable 'rtx_delta' is uninitiali=
zed when used here [-Werror,-Wuninitialized]
>                     if (rtx_delta > user_timeout)
>                         ^~~~~~~~~
>     net/ipv4/tcp_timer.c:464:15: note: initialize the variable 'rtx_delta=
' to silence this warning
>             u32 rtx_delta;
>                         ^
>                         =3D 0
>
> I hope that helps!

Thanks for the report!

I think it missed one small snippet of code from [1] compared to the
latest kernel. We can init this part before using it, something like
this:

+       rtx_delta =3D (u32)msecs_to_jiffies(tcp_time_stamp(tp) -
+                       (tp->retrans_stamp ?: tcp_skb_timestamp(skb)));

Note: fully untested.

Since Eric is very busy, I decided to check and provide some useful
information here.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/com=
mit/?id=3D614e8316aa4cafba3e204cb8ee48bd12b92f3d93
>
> Cheers,
> Miguel

