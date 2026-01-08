Return-Path: <netdev+bounces-248064-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B53D02A7D
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 13:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 40A9030B1C49
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 12:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AAB44DC55B;
	Thu,  8 Jan 2026 12:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WAHJgCsb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F14F4DC54E
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 12:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767875165; cv=none; b=PEoL3ZFiyeOcQWjdyr3nfFK4wDESW7FTNWwwC9UJJEN0i8nu5Ga/TZTAtoSGDuCDeO3odYgua8f2UB6hBi5UNWi3+9RQdhs7zFM88GJftuBgNjgX7oyPxxu4M9y6Ulm1SNVrqwo3T8GzmoczJ1G+ryNlvPinP2z87Vw1gDfPe98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767875165; c=relaxed/simple;
	bh=C/PxTgSERqJ6ILqTgSVsU+Sj2XkQpUudhpR6A9+mc9k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RQTppofHbjVQ59pJersIPniC5ay0vRiiK2JCEaEqBM3FID+gofKCwPbBDKVtBiARM4B3ef9BnpJft1f8GYMfhB/hR6No/TALu5d3je8lcn9Oc1wE6ryVr4t1T40jWjoKu/2pzcoOtAG5sYvhLV4oZFI475IlLzoyASGxLJfJVmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WAHJgCsb; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-78f99901ed5so33433577b3.3
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 04:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767875163; x=1768479963; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XQbP6K4LtPm/3Bomj038VWToPwF1ZlmXIxpj9oFDKbg=;
        b=WAHJgCsb05DN3q1CdpQz8DYDn3sRhH/hTCvrrYAKm/6sLDKBDNBI9G261T7ujH5CeB
         5Bvnk9Q8WRC+Gl4v2/c6BRxOWxviaHNT0GVmUw26G1uszDXOWoZGjM8QCtBQL1//WPTm
         fEv2XnzzDj8VhFekJiHO22xNmgx003o/XZbKWhdVX6SU2XEELInl6GxP8vv/tXxzPQrC
         YvE4legYXB5EwDUwVS250WYSgLCsSCmWXXp0beSzyKaqYEwCJYjB7QLGk/LaNjGB3X0e
         Ws3hCh0jtlo7CCnbpJ1bVnDGahzYj9oST7lcErARQIQA4DXsNbOjRc5YUo4jL0KI4Ayu
         SuxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767875163; x=1768479963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XQbP6K4LtPm/3Bomj038VWToPwF1ZlmXIxpj9oFDKbg=;
        b=cKqMqQGXCfemYHDZOtiR4E0D93W6SxIQfWXtOWPh5kra7LIgLV4byAslCH9bUrtjs/
         9R6AXKICqES8UrMhv0vHBVK7TPc776IedLAXwc5olTeLFA+mmaOPylzpgGc/bseBqqnT
         ca31bCPpb6gmdQ+EA9HFxhrum2TlTYywWMNPW7c+9J8w6gRJToUUpcVAfrlTn1t6nwFv
         nKWLDMCWPdd5wrjd+bI3idGrc+LM0wWXAS6C730mTj0ZSFdQ56JmJv+ERjOkR1AWdsrb
         hsbJ3Z3HpMWrro50HKJAYSr+IYgm2KJNxwe3VpK4sgYuNvk1dA5kj4FWelp631zSYKi1
         WZMw==
X-Forwarded-Encrypted: i=1; AJvYcCX3hXZ+Hh5XT2MTK5+gSVo5XSt/fz2yZBzOII1wjGDmSTetIINOJf3QA4066Y+NtJ5nM90/63Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy90yHymkFC3DcHBhluYp2aubip8c+GSstTjAYOUgdXG0jF3yHr
	8RCXRpy02iCCTCWEY6rGFBfq6GXXdff70zzCqWf3domLspgZS8L6j/J8jcwuRCh0zgIN1ObnPAS
	1hZvpcAiW//sQvh08yj/UKVCoMdCpUA8=
X-Gm-Gg: AY/fxX7gFr1H8ohvjTbp9Mgg0RdUe/vTOD6SKyriiSCo0BGjMpMs6TGZvdb0+rRz39B
	+S8RTfsioAHMMnORK1gz//9IWPyY8JfpW9tBRf+71oYVJn8pR2gIUbwtnD2HelcEQSf9A6yOKHy
	FgfYN2i3vqbMMWE04bWkmdkasUTEiQlktDga+qK+SqxSlju0PXSBWXKVycNxnWyo9K956wxQTwn
	PuvZW0RPfyN10LlTX6gUAeiEM5p99EEYFU0mVzYfz0E5I3camDeYew7L6cYVe6GBr5jeQ==
X-Google-Smtp-Source: AGHT+IE2yzRR9td4dYr8beCMOnr5E8Sv8b+0e37MZp8Y0hPbwVCOnvmprBO2NLzwb4jJvdl1Q3MsdWRhtLD5I5wdK+g=
X-Received: by 2002:a05:690e:1183:b0:63e:1df9:c895 with SMTP id
 956f58d0204a3-64716c50a58mr5519645d50.66.1767875162887; Thu, 08 Jan 2026
 04:26:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108101927.857582-1-edumazet@google.com> <851802c967b92b5ea2ce93e8577107acd43d2034.camel@sipsolutions.net>
 <CANn89iLxDc9viP0Pmj3uC01s46eUR2xu4XAUEo=he-M84aCf9A@mail.gmail.com>
In-Reply-To: <CANn89iLxDc9viP0Pmj3uC01s46eUR2xu4XAUEo=he-M84aCf9A@mail.gmail.com>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Thu, 8 Jan 2026 13:25:51 +0100
X-Gm-Features: AQt7F2pvm4NEm6VrnYq0Y5B6J_pXuAY_73yxlKUTPRwclpCUkgoqjALp_DmIhpM
Message-ID: <CAOiHx=mWrizoJAOU=40NWk6A1+b99WCM1EkxVwLfiJ8Sv4pDKg@mail.gmail.com>
Subject: Re: [PATCH net] wifi: avoid kernel-infoleak from struct iw_point
To: Eric Dumazet <edumazet@google.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	syzbot+bfc7323743ca6dbcc3d3@syzkaller.appspotmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jan 8, 2026 at 12:28=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Thu, Jan 8, 2026 at 11:29=E2=80=AFAM Johannes Berg <johannes@sipsoluti=
ons.net> wrote:
> >
> > On Thu, 2026-01-08 at 10:19 +0000, Eric Dumazet wrote:
> > > struct iw_point has a 32bit hole on 64bit arches.
> > >
> > > struct iw_point {
> > >   void __user   *pointer;       /* Pointer to the data  (in user spac=
e) */
> > >   __u16         length;         /* number of fields or size in bytes =
*/
> > >   __u16         flags;          /* Optional params */
> > > };
> > >
> > > Make sure to zero the structure to avoid dislosing 32bits of kernel d=
ata

In case you do a V2: dislosing -> disclosing (I assume)

> > > to user space.

Best regards,
Jonas

