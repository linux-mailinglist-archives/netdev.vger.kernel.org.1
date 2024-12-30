Return-Path: <netdev+bounces-154500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F6C9FE3AC
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 09:26:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0E2E3A1EEF
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 08:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF6419F49F;
	Mon, 30 Dec 2024 08:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UNdARLkf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935AE19F430
	for <netdev@vger.kernel.org>; Mon, 30 Dec 2024 08:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735547202; cv=none; b=IPmjN8te+W2fDXL1mQv7t+ToUMsnBIm7eiygEmGxc4VKSnaEuyPlzycJI4q+WcQ5X4al5sgjv0rNKPdvSr8vfHB8NDb2VSZQ0GT/2ePo7OnhGOz/0d521OPOt00gH5m3XPiYCs94+NVSrpSE4/HcmxvwPwSaMu7B2i+j/IwYtCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735547202; c=relaxed/simple;
	bh=oLpY0WeNT2QVs1o+elIRGMHxw5Zx40xVTSDyWba2AEY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rp9hgKBvUqYiJ1nXguClzAl54BrBXMZ/aqKhk6AKzxsOXygpSgD8ZAdgDi+QmjmiQy8o3er3eOJ5vMSDs3E3Vg4ihdEVFLsnIPdAwJP34xPlJcrj4Ziq+2QpX2pD3unKNyBjZTe9R2S7U4XDKPZN7/P/K8yFBaexh1S0EJqfE3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UNdARLkf; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aaf57c2e0beso125508766b.3
        for <netdev@vger.kernel.org>; Mon, 30 Dec 2024 00:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1735547199; x=1736151999; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SYWDqbCVxqpgLpSkS3aSPn9TjcnUNwwAt1qCVcarwRA=;
        b=UNdARLkfyXXrS6VxnN1tfZpuqwZkZ3dpP/GX77zC7co6oou408bHAYe3nPa73yEvdf
         M+Ohr+Xwlykht6vryte8LSa0GPQ5aiNoAgkcd+674Ernq0mpUStq+yXG/A+jl/x1jjt+
         1XsAXYiMjpsoKbe8Tyd32FDl10Nl5TJ8gJDbQRJv5XRfxIkcAKpvHcr42AVDBQAJ86QH
         Nh0rvwzAy5Jhys8TRzwe+dWIquMHuDCJPEbAsGqWwCj+uVU+O/7qQ7py0xr3d1CPCwuF
         cToGihMe5QBY5hKEGVyFN5kfUTHkjXidrxMZSa9bx3BvrC+/wbdKvNUixMDs7/TthSse
         nXNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735547199; x=1736151999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SYWDqbCVxqpgLpSkS3aSPn9TjcnUNwwAt1qCVcarwRA=;
        b=NDzzhuEztSf0XIe06xbyjZkw8PtfnmTCj9VsQP6s8/XS3sk4+8iFu9n2mKlhrttvNm
         NrWX9dQc1e6wSULL6nR1DIahrAXtlzPRIAtZmhsH/89rXQ6r07rhun3RAwrDvkfVW+Oh
         WB/1S11ek9v77EAxEmWzhlvD2z5h8zIrugmEFHuUbzaXqX0vuLyPR1CFQ+S4//ZzUDIJ
         Eu8N7klZXRvA/fs6MTo8FVKPOJIF5JR247oRNc0fwEwAvhKN0iKcivT/nHDINBh7jnbs
         xdXXnpVM0rouOdTqrVuIC3o0MYHPRyLjCfqhK+ypudKK5iG0aZjeRaNxdORLCV0ota+P
         Ec9A==
X-Gm-Message-State: AOJu0YwjOSk87ZJgDcSXBgtdyG/WMhcWP7tEPOZAXAZHX6zXvbSfaMIv
	m7HXLL8PXGRPjfgW+bXknpi9zh++tHzgTDftV3JqbObHptK57WNxLhU2sT4/QrBF5N20qNtK79U
	2RkqAhQhO9dh62yTSVcZzNdk1LRKf0r9JBZRZ
X-Gm-Gg: ASbGnct2sT1G8s5uuWAoPPtXB7OCxidAR9beEWdnX9NfdG0smADDROwFMBjOAPHY0hQ
	S1zHz1JOzchpVyvQ7sJpVsKrrV/EAD3/J4+ylIA==
X-Google-Smtp-Source: AGHT+IFC95J/ovEPgNYHRhgP6E+szdB/9Ule8Is7R1a9BAmdf34615SvgD78k0ScO9836NKW6lbQsVJZhLcgZgV3u4c=
X-Received: by 2002:a17:907:3e91:b0:aa6:715a:75b5 with SMTP id
 a640c23a62f3a-aac33563461mr2836592166b.46.1735547198788; Mon, 30 Dec 2024
 00:26:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <38130786-702c-4089-a518-cba7857448ca@gmail.com> <20241228021220.296648-1-antonio.pastor@gmail.com>
In-Reply-To: <20241228021220.296648-1-antonio.pastor@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 30 Dec 2024 09:26:27 +0100
Message-ID: <CANn89iKkrZySKRidPLFa=KsM6h6OeO2rgW6t5WNY9OWfJazu8g@mail.gmail.com>
Subject: Re: [PATCH net] net: 802: reset skb->transport_header
To: Antonio Pastor <antonio.pastor@gmail.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, horms@kernel.org, 
	kuba@kernel.org, "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 28, 2024 at 3:13=E2=80=AFAM Antonio Pastor <antonio.pastor@gmai=
l.com> wrote:
>
> 802.2+LLC+SNAP frames received by napi_complete_done() with GRO and DSA
> have skb->transport_header set two bytes short, or pointing 2 bytes
> before network_header & skb->data. This was an issue as snap_rcv()
> expected offset to point to SNAP header (OID:PID), causing packet to
> be dropped.
>
> A fix at llc_fixup_skb() (a024e377efed) resets transport_header,
> addressing the issue. This patch is additional clean up to snap_rcv()
> so that it resets the offset after pulling the skb instead of
> incrementing it to match the pull.
>
> Fixes: fda55eca5a33 ("net: introduce skb_transport_header_was_set()")
> Signed-off-by: Antonio Pastor <antonio.pastor@gmail.com>
> ---
>  net/802/psnap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/802/psnap.c b/net/802/psnap.c
> index fca9d454905f..252006f81afa 100644
> --- a/net/802/psnap.c
> +++ b/net/802/psnap.c
> @@ -58,8 +58,8 @@ static int snap_rcv(struct sk_buff *skb, struct net_dev=
ice *dev,
>         proto =3D find_snap_client(skb_transport_header(skb));
>         if (proto) {
>                 /* Pass the frame on. */
> -               skb->transport_header +=3D 5;
>                 skb_pull_rcsum(skb, 5);
> +               skb_reset_transport_header(skb);
>                 rc =3D proto->rcvfunc(skb, dev, &snap_packet_type, orig_d=
ev);
>         }
>         rcu_read_unlock();
> --
> 2.43.0
>

Sorry, this patch is wrong, it does not fix the potential issue yet.

Note how skb_transport_header(skb) is used in
find_snap_client(skb_transport_header(skb));

The proper way to fix the issue is to not rely on the transport header
at all, only reset it after pulling the network header.


diff --git a/net/802/psnap.c b/net/802/psnap.c
index fca9d454905fe37d6b838f0f00b3a16767e44e74..389df460c8c4b92f9ec6198247d=
b0ba15bfb8f2e
100644
--- a/net/802/psnap.c
+++ b/net/802/psnap.c
@@ -55,11 +55,11 @@ static int snap_rcv(struct sk_buff *skb, struct
net_device *dev,
                goto drop;

        rcu_read_lock();
-       proto =3D find_snap_client(skb_transport_header(skb));
+       proto =3D find_snap_client(skb->data);
        if (proto) {
                /* Pass the frame on. */
-               skb->transport_header +=3D 5;
                skb_pull_rcsum(skb, 5);
+               skb_reset_transport_header(skb);
                rc =3D proto->rcvfunc(skb, dev, &snap_packet_type, orig_dev=
);
        }
        rcu_read_unlock();

