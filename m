Return-Path: <netdev+bounces-168397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36FA4A3ECB9
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 07:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B36317EED6
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 06:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BDBF1FC7EF;
	Fri, 21 Feb 2025 06:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TWzAMWcN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837531FBEA6
	for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 06:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740118383; cv=none; b=hsxKA7PMOMEsKRLbJTRDkmdA8z8XiIj61BQsOT5dJQKCFeSbNfR+978/GMCxIKIgMlsR8949W//R960oVPwDTecwfx594RgtbkiWz9v46SH7DCBL53C+KHI9zQkc/9LQKm/kfUrlGXNOZzGIolqtJIP6lM2x2ODb/rO/qvFVuE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740118383; c=relaxed/simple;
	bh=/SnOrdsImDGYuVbBgE7r2rrLBRe/+t8p2SY0klArvlI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oz5Io9joUPvhQVDXtNYJoWHKHBjD/c0vAB6sh/Wn819n3GjyHboWpsQl5eUbc9qzakPfav4yVfAXyPRV7ZqTg/Sd45vKCbTKfybpILUn/V16tSNXMhFqr5M7eLTzRG48pWS/aCHiofEhCcM4s3DLsMEtcWJb3GgAUK7ZD0dFVLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TWzAMWcN; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3d18bf1c8faso4839245ab.1
        for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 22:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740118380; x=1740723180; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dGZ3mV6VOeeNrAqQkhXfcAOvmcA5MAbcI3IGk7WyYZM=;
        b=TWzAMWcNnXdXduXu1zslCkXPiYoj59sAX/oUNzamb2Tb0pPtDO8SKpVgySq/PAqqk7
         eDv+zbnTQgE65EF8zsGa9RPChTLz/tZID9aDtONQfPdnd5Yetdonxk1sdHKVXbzedoLA
         m4ykkCWfv5VBL+vJuK+KxNpc9MtpFDJHION4lN6sBkaWxjeT1H76bd6jXwcStTWWRQo7
         4g2rUM6LNEcIpA/IvcIzjFd2dFtQFtLgL4+NcGvSgmatWpyYYGbrLu0q8Hark/Pv75hU
         t1Niju4ZSXaeC70Yw4W/UFNM7wGbN9xFQ5oz7r7oPMniRNrHU4jcfr7iEwwaYmwFpE/Z
         PS8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740118380; x=1740723180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dGZ3mV6VOeeNrAqQkhXfcAOvmcA5MAbcI3IGk7WyYZM=;
        b=INSsGp71P8DZ95/l9b3DTElRT5SUxF3IUD6u0GYm0Oo6n2B6U1sUCK3Kjuv67zm3at
         eMIGTTooE2SM42+y9GbZXiUFMwgqQWqxXOnIs68fEq6PmWQjZgkLYCofmCpfDw3B79rZ
         JaXdQ0MIeik1STkJ/eGzNnaWe1OQl0J0IVtNZJBA9UyG7N1x1Pew+EfXJtZf1Nr4sXWN
         u9oCkMsV1qkNIHorS1YWIKHc6VgHxtBYkNc1GHNw6gifz/w9NSvVl+Dwp7o/9kkmehoK
         OsiA99pjnp12ATxMNoQvQU33sGsfSH6CIpihpj72shnQ2/ir/nzBB3OGFXpjiXISX50Q
         HXPg==
X-Gm-Message-State: AOJu0Yzq4HgJtw67meh2FOb68pi8gNNCaTwrMe+KffztCyNQ1jSpmuot
	3solft7/7tqXN4uQ0CuHa9CbewIUQasEBcKYC1moiCh3MmOk3Z77flurCTXiASRAaNfy6edIv5f
	uUvuB6Ku3HF9KBdTuKsGKVj9hnRM=
X-Gm-Gg: ASbGncuDhhH/Eg0kGyU+bWXHIWmL3ZwB+QposWz9956FcHoSKESFqgNXi/wZm+hxmx5
	5nmpIFPxzEQsjQUSxBD1uKCTpxTBmCOVA8pQ3AhyIAUCA6bP88qcEEkyjLm/awziLtmW55xJC8R
	AU4Q7BFKc=
X-Google-Smtp-Source: AGHT+IHPsb12vvAQIRYEZuAzp2j7JHt2TK5sFWerRz3yr+3P1RczX/WnI7CF9btuVa9hPfZeHI1aUSxi4Clyol/hCcs=
X-Received: by 2002:a05:6e02:170e:b0:3a7:87f2:b010 with SMTP id
 e9e14a558f8ab-3d2cae46bbcmr21151415ab.5.1740118380497; Thu, 20 Feb 2025
 22:13:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250221035938.2891898-1-willemdebruijn.kernel@gmail.com>
In-Reply-To: <20250221035938.2891898-1-willemdebruijn.kernel@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 21 Feb 2025 14:12:23 +0800
X-Gm-Features: AWEUYZlWwpJF38rLvNM50zHSefnEe_iW8aIYXqySO6vKShYoEQzX8FoaYFRg-a0
Message-ID: <CAL+tcoD4Y2XEZfSk2KNu_MXo-T4gRxBwveLqFc=mNV7utyDQaQ@mail.gmail.com>
Subject: Re: [PATCH net-next] net: skb: free up one bit in tx_flags
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	edumazet@google.com, pabeni@redhat.com, pav@iki.fi, 
	gerhard@engleder-embedded.com, vinicius.gomes@intel.com, 
	anthony.l.nguyen@intel.com, Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 11:59=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> From: Willem de Bruijn <willemb@google.com>
>
> The linked series wants to add skb tx completion timestamps.
> That needs a bit in skb_shared_info.tx_flags, but all are in use.
>
> A per-skb bit is only needed for features that are configured on a
> per packet basis. Per socket features can be read from sk->sk_tsflags.
>
> Per packet tsflags can be set in sendmsg using cmsg, but only those in
> SOF_TIMESTAMPING_TX_RECORD_MASK.
>
> Per packet tsflags can also be set without cmsg by sandwiching a
> send inbetween two setsockopts:
>
>     val |=3D SOF_TIMESTAMPING_$FEATURE;
>     setsockopt(fd, SOL_SOCKET, SO_TIMESTAMPING, &val, sizeof(val));
>     write(fd, buf, sz);
>     val &=3D ~SOF_TIMESTAMPING_$FEATURE;
>     setsockopt(fd, SOL_SOCKET, SO_TIMESTAMPING, &val, sizeof(val));
>
> Changing a datapath test from skb_shinfo(skb)->tx_flags to
> skb->sk->sk_tsflags can change behavior in that case, as the tx_flags
> is written before the second setsockopt updates sk_tsflags.
>
> Therefore, only bits can be reclaimed that cannot be set by cmsg and
> are also highly unlikely to be used to target individual packets
> otherwise.

Agreed.

>
> Free up the bit currently used for SKBTX_HW_TSTAMP_USE_CYCLES. This
> selects between clock and free running counter source for HW TX
> timestamps. It is probable that all packets of the same socket will
> always use the same source.
>
> Link: https://lore.kernel.org/netdev/cover.1739988644.git.pav@iki.fi/
> Signed-off-by: Willem de Bruijn <willemb@google.com>

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

Thanks, Willem!

