Return-Path: <netdev+bounces-214497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12CDCB29E7F
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 11:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 747C77B3C2E
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 09:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02C130FF08;
	Mon, 18 Aug 2025 09:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="08h65qCK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADAD30F81B
	for <netdev@vger.kernel.org>; Mon, 18 Aug 2025 09:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755510868; cv=none; b=mI7b3S19jwYQ0vS2JFtPkBaAwZ/2f4rE9RfPSa3GCgT6n5xgLRCcQfdPjMF6g00paKCjSUa5fnH2EScwHpY8N83a2I3EW1N0Nvzxa/nnZETocx/jS1YGmc7WfXnwge3be9gk+mgEcM3GH5vj1t+1Cpv71ntcIpOTzTjYv5k5ULE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755510868; c=relaxed/simple;
	bh=u+YXx08VN3XTpTU+8hdLWH1fWVfGIXErudbo91lX4/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LhCFeucLU0n/diJL/lnINKGzB/tZPAyGxj2u2qJO3w4hf8ONOdMk3mf6CDxHon1e5p+9PQ+DULEeKPxGz6IzuOIZ/598XeVyDQ8Y8C9z5kstlQazTd5RrTDI3GL7ZNdAhizEsp8RzBsVRatzfwbhsdrn1kuXLTTGyECQH1AibEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=08h65qCK; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7e87063d4a9so461124085a.2
        for <netdev@vger.kernel.org>; Mon, 18 Aug 2025 02:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755510866; x=1756115666; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nXFpdyF2ihcBczfWPOQt9tgTh1SkHG2vojtMXtRogyM=;
        b=08h65qCKNK8Sd13g+LWT5fEKHOlM96i0GfJXv3gTWwK4jrvQRSX/cEqxRWjtVdSEk1
         p63uPMPQ8W8GYge5w6gggAnJHhGa5aW8PMXzBg/H0PYLspq3ZuPl6wllv5afTcVAT5vu
         C0HZYFS6OpmBx2Rzs5vJKypeK5UtQdQS88rQX6SzVCvwRZkC7jLiu4BeZkm3lYwusa4q
         eE0/K2QspltQmSn4p2Afhas7VnZuVWAD7cOTDkYK53PtsdNdu7GiS7Gg0laNxhfn3UgK
         wLpYrGil7aQ3f3aTu8ZEewN3UpThYY3MphygECSMrEBei42JY1aOBttLdNY1FI0UXZLR
         ru3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755510866; x=1756115666;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nXFpdyF2ihcBczfWPOQt9tgTh1SkHG2vojtMXtRogyM=;
        b=K9GyrD/bcCkWM9+ZAZWr74bvijGm1xxN23vQGjS/FOOjRc/qnauUqXMgGL61bhynsM
         yZeQKiHduf0agAO6+fzZTgWLS+aTM7iz7RoZwv9TAuYgQS/U49fSeH72fSdjVnZWskMx
         lbRrQUr1nxyS/87W1ckAlZX/tBdV934Glc0r3uHgpyClYSpqUlXZWoRCeUf4Hl2mXMBE
         dpmVYRDFUv59MEEtvtzjHbHOXyNE804rRe0DoxfQ1VaCl9+IyBZ0C2Es2UDiL6y1Ihyo
         Zpnj5T6QKQXyo8HP9PnqIo8JD6rZjVb/9IbhxHZhjLqIB3Mw+r1xNcLw1A9I56ziteyH
         MycQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlc8QuF/4vjhCWVQwFoPOSwtguVZv091wh4WuDHSEAnCZhBVnhq5amnblS5KVIG+dBtctusKc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxoc6OfXh/9NM8rdP6BWFQGC4AZaGENJZl3bLsg8D3Rc5efBDik
	dlW75tqP6VOXAD+PuBtZCOC6cne5XBmRUD+f85GqhxToT87VsKCduVJ5YgYZxJmqCJEBM58Iu6g
	rjqmLAV2wd8jiO+Vx1gAu0pxokA/BokSzcczZYy0Y
X-Gm-Gg: ASbGncsBiLFPjN+X8/PpESUz5npvRlmezmC3hO4jaPLAvqpXtYaeUdu/1ljJ9j/ZAnu
	Q7mlo/Eo7WcfqUxd+vxknzoftvr0GUhZ6C82kXvPr0KClO5KC5ZVAWOL5yP7tERimId3ykL3Wa+
	1s5xDcg0L4epgGaLMb0K8zLI6DKZRJiwiLiewMCu7MSY6OC5E+RFYrAy9PkEXn8LZwVIBsQ5g9Z
	a3grXH7P5pLpdQ=
X-Google-Smtp-Source: AGHT+IEVeerWNxTXKvofEguqGvAGkFIeVi/aO/Zg1kJmEZaMKn2LKAeqFjVcEDwdXrPJyGJ3eMakTRZgV/oSSl1F8rU=
X-Received: by 2002:a05:620a:4591:b0:7e8:324e:ba20 with SMTP id
 af79cd13be357-7e87e104704mr1507578885a.48.1755510865815; Mon, 18 Aug 2025
 02:54:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250816-nexthop_dump-v2-0-491da3462118@openai.com> <20250816-nexthop_dump-v2-1-491da3462118@openai.com>
In-Reply-To: <20250816-nexthop_dump-v2-1-491da3462118@openai.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 18 Aug 2025 02:54:14 -0700
X-Gm-Features: Ac12FXxWAsxubDibEYoSnC5BOyIiCoQHU-uUNqNVPZYZ1Wn9p-fwbCFspDRp5D0
Message-ID: <CANn89iKBky8z-duf1ygOsqD1kWX-kTL3bXEmt7RYz8YAWD1P9w@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/2] net: Make nexthop-dumps scale linearly
 with the number of nexthops
To: cpaasch@openai.com
Cc: David Ahern <dsahern@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@idosch.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 16, 2025 at 4:13=E2=80=AFPM Christoph Paasch via B4 Relay
<devnull+cpaasch.openai.com@kernel.org> wrote:
>
> From: Christoph Paasch <cpaasch@openai.com>
>
> When we have a (very) large number of nexthops, they do not fit within a
> single message. rtm_dump_walk_nexthops() thus will be called repeatedly
> and ctx->idx is used to avoid dumping the same nexthops again.
>
> The approach in which we avoid dumping the same nexthops is by basically
> walking the entire nexthop rb-tree from the left-most node until we find
> a node whose id is >=3D s_idx. That does not scale well.
>
> Instead of this inefficient approach, rather go directly through the
> tree to the nexthop that should be dumped (the one whose nh_id >=3D
> s_idx). This allows us to find the relevant node in O(log(n)).
>
> We have quite a nice improvement with this:
>
> Before:
> =3D=3D=3D=3D=3D=3D=3D
>
> --> ~1M nexthops:
> $ time ~/libnl/src/nl-nh-list | wc -l
> 1050624
>
> real    0m21.080s
> user    0m0.666s
> sys     0m20.384s
>
> --> ~2M nexthops:
> $ time ~/libnl/src/nl-nh-list | wc -l
> 2101248
>
> real    1m51.649s
> user    0m1.540s
> sys     1m49.908s
>
> After:
> =3D=3D=3D=3D=3D=3D
>
> --> ~1M nexthops:
> $ time ~/libnl/src/nl-nh-list | wc -l
> 1050624
>
> real    0m1.157s
> user    0m0.926s
> sys     0m0.259s
>
> --> ~2M nexthops:
> $ time ~/libnl/src/nl-nh-list | wc -l
> 2101248
>
> real    0m2.763s
> user    0m2.042s
> sys     0m0.776s
>
> Signed-off-by: Christoph Paasch <cpaasch@openai.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

