Return-Path: <netdev+bounces-130177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BAE2988EAC
	for <lists+netdev@lfdr.de>; Sat, 28 Sep 2024 11:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C0CD1C20C02
	for <lists+netdev@lfdr.de>; Sat, 28 Sep 2024 09:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0411E15885E;
	Sat, 28 Sep 2024 09:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y4oRrIVy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7447C2AF15
	for <netdev@vger.kernel.org>; Sat, 28 Sep 2024 09:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727514084; cv=none; b=tbhByYAHHpyJx9ZwwfknZqZcsreHBQaNoPHo86VE9lRcpKRX2zNW+Ro+j1YW2NVMVdr4gdVQqXjRb1JzVjQfRcmlAlcLPAVfDF7WUme/SV5uP/eKFYym2Vq5eB13TuVzJw0xb+kNoKD+1LHKvgUYP064RH1OJNA913+hL3A1OcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727514084; c=relaxed/simple;
	bh=OULonLISAgdVGCzt9ViD5K6mwJYRNWoJH/BkhkShwX4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ui2iMKEb1Jfe0WdMCb4Xidv8Aw3nb9bMcyhB+tl1Chtfmrsbrw/74Z2p8vkG8gif8/rf0liKlb2gVEItwrTYG3c8syN6cr5JW8d4Ahz5rWM2YmU0oHCEILa1Q2iE0BU+rMqrM6H8lixHdf7ZVG0rjttgFsksDBKyp41P9oxMfa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y4oRrIVy; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3a0c8c40560so12730255ab.2
        for <netdev@vger.kernel.org>; Sat, 28 Sep 2024 02:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727514082; x=1728118882; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C82j8i8DudgFlocAA9uyYY0RuPrrdYGKyorPH6baa5o=;
        b=Y4oRrIVyGky6O7x43OA8+UVIFsfTxuvfsGZbdHgEBpJYLGvTKnDl3NYSnfEnI+gMv2
         JAYk6vG9eWVkroaFlFaU9JabjjOsPzVY+ltNQzz6XFnI0erEkKGlzy4/ibON1DxCXhM9
         hTlfsu8Pq9Keb22/3x424Jv4aB0ybXw9GLyYuyo5l7H9Wbgs50ALH0yvoOI/Ds43MY3d
         r4zteO2aNNEpJNj53iKeSq5JjAwUz0MT62ePTQPWOP71cBZnYOTH3n3tn+r6dUzM5d/Y
         lEAmVonBMv15XWPcCoyzUmAmnHZc0MCkUteufuS6OKsC8bV18RO+bCHwS/lWOdr69iny
         OyVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727514082; x=1728118882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C82j8i8DudgFlocAA9uyYY0RuPrrdYGKyorPH6baa5o=;
        b=aDfgC7/CqXA/uvlSmZWPUR38w2Um5ISS+C9pcNF++SRqiFfiBTB+al6owkqjMt0CBJ
         uJhBBHsS2tMjDt1J8c+KRzSLHjvsYQsKftH8AKwlrDBU7IvsEBsL3AQgo8MHbTQC4cC0
         TRk/UTsup+f0nC8YaVxcF72U94R9IANb82DYn9DdJVamcbd4n6hQwtiHOpl6+4L0iQot
         y/4htLdJJHexwLYBFBW9BIvu3WqX1NIfgkyqZrrQPbMT/jMqS2GvvX4SThDU0wHDwh3i
         Ji5a/pdu/3JWmA65Vt+UOUmRtCRLji0idGd1Tb1kaYffTe6UPU9GZ4gvYYBDtNB7gEv6
         ZDZg==
X-Gm-Message-State: AOJu0Ywtu1UAlm+NF2eB74jIEn2NtV3fmr9xC+OXgO/9CSDlOeTxSkeU
	OgO2rTY6wODKzZO9mjyQXhk69/wRksb22uPipkAnPweO0HGYJ7Raob465zwb5TzrE5sOSHCVn0K
	r9vzEzJE1cdom1YnETvH6YedYRRBLmlnI
X-Google-Smtp-Source: AGHT+IHjDOdcoPePA1RISXa+1K3pIp1A8kMMWI+9PuzZhhSbQIZV/Pp++MQVbOfwGKNbP3Xxr3sskMGj6FwYPnW7fNw=
X-Received: by 2002:a05:6e02:216e:b0:39f:60d7:813b with SMTP id
 e9e14a558f8ab-3a3452bf4damr48248085ab.22.1727514082378; Sat, 28 Sep 2024
 02:01:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADVJWLXQ--JKJzRX6JiEdzq5zPwN+qB65B9j7DTRGJpsTh1eDQ@mail.gmail.com>
In-Reply-To: <CADVJWLXQ--JKJzRX6JiEdzq5zPwN+qB65B9j7DTRGJpsTh1eDQ@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 28 Sep 2024 17:00:46 +0800
Message-ID: <CAL+tcoBTk8Bs1vEX=cAKfaN+qrVptkqJH74FE6=VD89nXh2QGw@mail.gmail.com>
Subject: Re: skb_shared_hwstamps ability to handle 64 bit seconds and nanoseconds
To: Greg Dowd <dowdgreg@gmail.com>
Cc: netdev@vger.kernel.org, Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 28, 2024 at 12:36=E2=80=AFAM Greg Dowd <dowdgreg@gmail.com> wro=
te:
>
> Hello all,
> I am not sure if this is the right list but I posted this in newbies
> and got referred here.  Anyone have any insight?
>
>
> I had a question regarding kernel timestamping.  I see definitions for
> SO_TIMESTAMPING_NEW in networking options to allow use of time
> structures containing 64bit timestamps.  However, I don't see any way
> for skbuff timestamps to pass around structures with 64 bits as the
> skb_shared_hwstamps use a typedef ktime_t which stacks the seconds and
> nanoseconds into a single 64bit value.
> I am not sure who maintains this section of the code.  Any ideas?

I don't know what the real question is, either. But I think I can help
you somehow:

1) try to understand Documentation/networking/timestamping.rst
2) try to run and test tools/testing/selftests/net/txtimestamp.c,
which is good for you to understand the SO_TIMESTAMPING feature.
3) I guess that you're looking for how the sk tsflags can be passed to
each last skb in one sendmsg()? If so, I recommend that you read the
code following this call trace:
tcp_sendmsg_locked()->tcp_tx_timestamp()->sock_tx_timestamp().
4) I also guess that you're looking for how the hardware timestamp is
passed to the userside during the report phase? If so, please see
sock_recv_timestamp() and skb_tstamp_tx().

For now, Willem is the maintainer of the SO_TIMESTAMPING* feature. Let
me CC him here.

Thanks,
Jason

