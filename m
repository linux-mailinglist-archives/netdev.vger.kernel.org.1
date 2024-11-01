Return-Path: <netdev+bounces-140893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F4B9B88FC
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 02:59:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C80BF28346F
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 01:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4219583CC1;
	Fri,  1 Nov 2024 01:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ji1b5eCZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8A213B792
	for <netdev@vger.kernel.org>; Fri,  1 Nov 2024 01:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730426369; cv=none; b=YTHmh6rLvymMrjxVsrvnsMpoptiXepes/3Q3WPoRLVvMW2vH73mSo8EyRH7FuYly8y45mEm8dhM792p8UGmk1aI2tjztkAf43aR9jaIiL+prsG7VgaZOlceqR1NVcc3xsrKp9eOK6KINEKFxtTTMT+2IWhUvEYDB8Nq4tIsLtV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730426369; c=relaxed/simple;
	bh=9aEaV/6b+IX9k7iAXD5zd7qk1El9sacQULRn2SlaCks=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=SJPa7AA7G4ezcKUMrYyCkIabjQ04UCAp1nLY33xn99ZKBao/ic9ziLa8/tOBLodUHW0K7Dn+RJBPhFsE/TEQLZKIbqdhFcTHrIkBMdfsJyrKseM0rMR9WZTOMYkhZXTOOiKuOoh0yTKEpPK4QxBWClobJfH+iIFwruZdZFm/9Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ji1b5eCZ; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3e6005781c0so903774b6e.3
        for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 18:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730426362; x=1731031162; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o8B8BHA6cl+U1knPFdsUIlZoDGjiLcgihmnz8z6ulj4=;
        b=ji1b5eCZb6umN+rgQVV8McGdb1gRiPSAU27x8t5LOd2e5WWiU4ZYjSeBY5gsmlIA8W
         81ei47xjXaIHJ9qJAexMdJFnA8f2mRdmsP/xYNvpsP6Yh8Biry46QER0r7zC7xhLrLqw
         ePr7Ubr9p0oVl6bhlSkOwg6kFkbgOfeG6T6zq/rTVeGF+ZXj4rDWiik/dBwE4+tbahGD
         3B8w8JCIvVt5OerWfcmbkuc8RmT+PIWbvijjAIj4icJUEk/AUe03FjfdTm3gDPpU2t9T
         JBJPqYkEUZswRaQ3fnzWFaKVAz6GqShWFsshWIF9bktP5BptyGMtDv43/KPqO7uVXSwY
         Cyhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730426362; x=1731031162;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o8B8BHA6cl+U1knPFdsUIlZoDGjiLcgihmnz8z6ulj4=;
        b=AHiSF4I3LeNRnoDeAJTOfkvm64cjvHMLjRjlprLW+VLwgIJBTAVPAoz8FS62c040ay
         gLEndYNyaBcyBixA5Ls9JTeRC2/9XnOiKAc7YWxmNuaNIskKreFpIZBhZ7xkYf5yz1qX
         SvKgJhNhNo+uKgzp7dEBzYHS6uv+2QNkRYOtn/vxWZ09gONcjfPlOms8b1JJYfsjaLuD
         5VQv5jIIWNb5GBj1vy1QYAf38MIsOsxP4UWZNxMy+XatW6AexHuTGcWAFRYLNOrPkwHG
         FSj9+GTsTWng7Cs4w3Y0vll+rO4EUdFZVeEpQylBwjfiCpwJb0O8fIcqEBL/y6W8PuqY
         FtUg==
X-Gm-Message-State: AOJu0YynaN4LE0xp6nPihceaYwVEQz0EBgiAmqnc1yoz+69DjtojekwA
	Q8f6BT8/DcJa6EZZ5/sVLj61RKN53S5KtY80Tp9D0WMuDzddL+MwdWIFHA==
X-Google-Smtp-Source: AGHT+IFJHd2AP0pBvePwL59VFXJ6pUPLnuWqpsSeA42Z7ig9QXpc3a4bYtn4JF2HH8wBVa1/zUgCqg==
X-Received: by 2002:a05:6808:384c:b0:3e6:255:165b with SMTP id 5614622812f47-3e65837af58mr10385376b6e.27.1730426361824;
        Thu, 31 Oct 2024 18:59:21 -0700 (PDT)
Received: from smtpclient.apple ([2600:100f:b075:3e3e:c60:539d:da91:f5dc])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ee45a12ab3sm1634641a12.92.2024.10.31.18.59.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2024 18:59:21 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: namniart@gmail.com
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: Duplicate invocation of NF_INET_POST_ROUTING rule for outbound multicast?
Date: Thu, 31 Oct 2024 18:59:09 -0700
Message-Id: <0A676E07-BD16-492A-8C10-4FC541525F73@gmail.com>
References: <20241031215243.GA4460@breakpoint.cc>
Cc: netdev@vger.kernel.org
In-Reply-To: <20241031215243.GA4460@breakpoint.cc>
To: Florian Westphal <fw@strlen.de>
X-Mailer: iPhone Mail (21G93)

Thanks for the quick reply; I will work through our build process and try to=
 get that tested in the next few days.

I was thinking the fix for this might be more substantial; call NF_HOOK with=
out a callback at the top of ip_mc_output to determine the fate of the packe=
t, and then make and loop back copies of the packet only if the packet passe=
d the postrouting chain. That=E2=80=99d prevent the nf chain from being call=
ed multiple times for the exact same packet, could apply to multicast and RT=
CF_BROADCAST, and would solve the cgroup issue at the same time.

If you think that=E2=80=99s a useful approach, I am willing to write and tes=
t the patch.

-Austin

> On Oct 31, 2024, at 2:52=E2=80=AFPM, Florian Westphal <fw@strlen.de> wrote=
:
>=20
> =EF=BB=BFAustin Hendrix <namniart@gmail.com> wrote:
>> I've been staring at the linux source code for a while, and I think
>> this part of ip_mc_output explains it.
>>=20
>> if (sk_mc_loop(sk)
>> #ifdef CONFIG_IP_MROUTE
>> /* Small optimization: do not loopback not local frames,
>>   which returned after forwarding; they will be  dropped
>>   by ip_mr_input in any case.
>>   Note, that local frames are looped back to be delivered
>>   to local recipients.
>>=20
>>   This check is duplicated in ip_mr_input at the moment.
>> */
>>    &&
>>    ((rt->rt_flags & RTCF_LOCAL) ||
>>     !(IPCB(skb)->flags & IPSKB_FORWARDED))
>> #endif
>>   ) {
>> struct sk_buff *newskb =3D skb_clone(skb, GFP_ATOMIC);
>> if (newskb)
>> NF_HOOK(NFPROTO_IPV4, NF_INET_POST_ROUTING,
>> net, sk, newskb, NULL, newskb->dev,
>> ip_mc_finish_output);
>> }
>>=20
>> It looks like ip_mc_output duplicates outgoing multicast, sends the
>> copy through POSTROUTING first (remember how the first copy didn't
>> have UID and GID?), and then loops that copy back for local multicast
>> listeners.
>>=20
>> I haven't followed all of the details yet, but it looks like the copy
>> that is looped back lacks the sk_buff attributes which identify the
>> UID, GID and cgroup of the sender.
>=20
> Yes, skb_clone'd skbs are not owned by any socket.
>=20
>> Is my understanding of this correct? Is the netdev team willing to
>> discuss possible solutions to this, or is this behavior "by design?"
>=20
> Its for historic reasons, this is very old and predates cgroups.
>=20
> You could try this (untested) patch, ipv6 would need similar treatment.
> We'd probably also want to extend this to RTCF_BROADCAST, i.e. add
> skb_clone_sk() or similar helper and then use that for these clones.
>=20
> diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
> --- a/net/ipv4/ip_output.c
> +++ b/net/ipv4/ip_output.c
> @@ -396,10 +396,16 @@ int ip_mc_output(struct net *net, struct sock *sk, s=
truct sk_buff *skb)
> #endif
>           ) {
>            struct sk_buff *newskb =3D skb_clone(skb, GFP_ATOMIC);
> -            if (newskb)
> +            if (newskb) {
> +                struct sock *skb_sk =3D skb->sk;
> +
> +                if (skb_sk)
> +                    skb_set_owner_edemux(newskb, skb_sk);
> +
>                NF_HOOK(NFPROTO_IPV4, NF_INET_POST_ROUTING,
>                    net, sk, newskb, NULL, newskb->dev,
>                    ip_mc_finish_output);
> +            }
>        }
>=20
>        /* Multicasts with ttl 0 must not go beyond the host */

