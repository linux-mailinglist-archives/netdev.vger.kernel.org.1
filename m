Return-Path: <netdev+bounces-179066-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA16A7A526
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 16:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D08A188E30F
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 14:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960A924EAB1;
	Thu,  3 Apr 2025 14:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e37LRQeV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C394124BCF9;
	Thu,  3 Apr 2025 14:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743690420; cv=none; b=ZJFQsWyK/PFwcDBqNBmc6dRyESLc3PyIeVITyPmF3d44uupx+p9nicC11XspNLMQ2ZW/vCdb5IYad6yrraKKk0GQyKvV6WVoNv03yaz5gtZBlzPDCE8XDRNFENcKW/nhTVE04TZY4vKBBKYMXRxALn9AjtbXWHRFpqP8UP0ocz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743690420; c=relaxed/simple;
	bh=3H/q3VCbKUvTmxT5KHpB3sPOrrtaG+j/5ZoBSAeRGAk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Tqcq4Oh7zYxZ0sxf3kE0qQSwUZxsKCq2k4ko78kY0Pe56NvEU/GKQg/NRAX/Le+XLeRc5GCqx5VnZIE+qRL7SI0cmyKEcXyqmp+Arcd9erJ6UmDsgIL+6xJLGTG6GGo+W06Od2khjFqertxN140Z8cL4Asq3xizjv2N2Z607cJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e37LRQeV; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6e8f94c2698so5775796d6.0;
        Thu, 03 Apr 2025 07:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743690417; x=1744295217; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1CZAmNn5KUIQDDBuM8wsmsl+fKPlZ/xNdDm5B7P8SPg=;
        b=e37LRQeVR4EO1+wvB7v342uUP+UYlXPtsHMWHQvx6b7yrq8YM5gY/ZQ2i+peJtcg4Z
         yc1097wsAH4Sv9E6z/zOPF7ksUK7egKhu0NcsFwVz2OmNUabPwadH/aQuoWFcSUkpDFF
         DJSR+6Qawk6qol5g170yJTaV4N/6CMs8U5Y0gAD49gYvzu3Cn/OGqBZL0JR1gEbnhVLm
         3kZln9/GHYj9w8mjb9L9tHg7KDA3fDhVO9fd7nnjkBSzAdFgyTpxnQ8tDuZ/4snp+1z8
         7/VvweiNpLLmrevFe4rtk8TFMMX+kXqAmZfg/0TcPVMvpmKsS61lp5U+WOpGbi7NCsSZ
         R3wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743690417; x=1744295217;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1CZAmNn5KUIQDDBuM8wsmsl+fKPlZ/xNdDm5B7P8SPg=;
        b=l9ImyEVuTkIwOKoNA34OfctvalO1QqSDpgjwEpf9iZAqY5AiglxK80tIoNXzT2MCdB
         oENF8I+ygywtAfYnTh3zjcmu2ZSuAU3i5f1QMYvfrfI5igNwXqMunepHpYvDTmzvcl1i
         SeiCBXCx+cYcmQcX3MdWO4LJDQEZSf75q+HwCdsYuSsYX0t+dFhnmywwX16r6I7ui8h1
         1LCsQx7RZA4a7ymLLwfEoXJx3lRff4Hc2etsdebLa9iwvUe8Lz1rasnDcOn/sNYFUIPL
         Ih/e8RRz0SmCCcBL6ux6aRPR8JXN+jipAnH+513AVHZKE3O10ND4NxuN0ZEVG/zOZ0oa
         1dBA==
X-Forwarded-Encrypted: i=1; AJvYcCUpfkswZNtAWSXjGn71bjVF9wm8bKibJz3ULO6RdSMYEilz0cNohn0I1EuFELZ7NaP8ySXci/e+@vger.kernel.org, AJvYcCX484qhorCThZo4DLiD4tecoMX0hv7TdNe4TlHzDXDrd7oSIbT8XDx6XBfkvB7V5RscD2bNNBGzqjB9ELM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQLYbP/K+ciubeNG2J8h6wgkbNOzqd88caCiaWLY31WaW5TPhJ
	DAdG8NvsZae03NL67vlxqX5tWvRtYQ2RMlMZAxQAU76LCzfZnPUpscGYHA==
X-Gm-Gg: ASbGncvtfkTCbC8FK2XsSIYBOXoEExqCWrwIxHOtqmOg++LVAcMHHYj6oyaBCVYT9au
	pLk4YNTOgsmLX50q/qtjpSWPxItlf/I3LTyjb8vkC97k04BFwduX6dl5U6jTTJqXGK+uB9c7WSF
	dKlgOP/xx595/W258mrsistMSB8xC89ieZwPH677uniHvTZVvN5CtOs8gLlRxy324qvHdJDyF/z
	j3uONYt4f5xH+zTV5GmBO5iEpnp6FqgqgcYhcsnELj6O1dgCkivzRC3W1sOsf+Y30FsRIkUPfz0
	/LFGN98u7FH7fwxDfZ6lE0Ami5xB40X2tC59Px1vSP37rEGGH4OY/8vaH8sZJyC7J4PbaDfjRjH
	92+UJuY/RlCEun95XQphLRA==
X-Google-Smtp-Source: AGHT+IFlRHBw2ikpgIutCACR/qwVGVZnnXg5ZN0d8jVb1lzRGOGU/wMd718oZ4+RUAzNMauzG0xZww==
X-Received: by 2002:a05:6214:20c3:b0:6e8:955b:141e with SMTP id 6a1803df08f44-6eed6023f5bmr348001696d6.21.1743690417447;
        Thu, 03 Apr 2025 07:26:57 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ef0f00f2e0sm8170696d6.36.2025.04.03.07.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 07:26:57 -0700 (PDT)
Date: Thu, 03 Apr 2025 10:26:56 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Markus Fohrer <markus.fohrer@webked.de>
Cc: virtualization@lists.linux-foundation.org, 
 jasowang@redhat.com, 
 davem@davemloft.net, 
 edumazet@google.com, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <67ee9ab0a1665_136b7c29412@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250403100206-mutt-send-email-mst@kernel.org>
References: <1d388413ab9cfd765cd2c5e05b5e69cdb2ec5a10.camel@webked.de>
 <20250403090001-mutt-send-email-mst@kernel.org>
 <f8909f5bbc2532ea234cdaa8dbdb46a48249803f.camel@webked.de>
 <20250403100206-mutt-send-email-mst@kernel.org>
Subject: Re: [REGRESSION] Massive virtio-net throughput drop in guest VM with
 Linux 6.8+
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Michael S. Tsirkin wrote:
> On Thu, Apr 03, 2025 at 03:51:01PM +0200, Markus Fohrer wrote:
> > Am Donnerstag, dem 03.04.2025 um 09:04 -0400 schrieb Michael S.
> > Tsirkin:
> > > On Wed, Apr 02, 2025 at 11:12:07PM +0200, Markus Fohrer wrote:
> > > > Hi,
> > > > =

> > > > I'm observing a significant performance regression in KVM guest V=
Ms
> > > > using virtio-net with recent Linux kernels (6.8.1+ and 6.14).
> > > > =

> > > > When running on a host system equipped with a Broadcom NetXtreme-=
E
> > > > (bnxt_en) NIC and AMD EPYC CPUs, the network throughput in the
> > > > guest drops to 100=E2=80=93200 KB/s. The same guest configuration=
 performs
> > > > normally (~100 MB/s) when using kernel 6.8.0 or when the VM is
> > > > moved to a host with Intel NICs.
> > > > =

> > > > Test environment:
> > > > - Host: QEMU/KVM, Linux 6.8.1 and 6.14.0
> > > > - Guest: Linux with virtio-net interface
> > > > - NIC: Broadcom BCM57416 (bnxt_en driver, no issues at host level=
)
> > > > - CPU: AMD EPYC
> > > > - Storage: virtio-scsi
> > > > - VM network: virtio-net, virtio-scsi (no CPU or IO bottlenecks)
> > > > - Traffic test: iperf3, scp, wget consistently slow in guest
> > > > =

> > > > This issue is not present:
> > > > - On 6.8.0 =

> > > > - On hosts with Intel NICs (same VM config)
> > > > =

> > > > I have bisected the issue to the following upstream commit:
> > > > =

> > > > =C2=A0 49d14b54a527 ("virtio-net: Suppress tx timeout warning for=
 small
> > > > tx")
> > > > =C2=A0 https://git.kernel.org/linus/49d14b54a527
> > > =

> > > Thanks a lot for the info!
> > > =

> > > =

> > > both the link and commit point at:
> > > =

> > > commit 49d14b54a527289d09a9480f214b8c586322310a
> > > Author: Eric Dumazet <edumazet@google.com>
> > > Date:=C2=A0=C2=A0 Thu Sep 26 16:58:36 2024 +0000
> > > =

> > > =C2=A0=C2=A0=C2=A0 net: test for not too small csum_start in virtio=
_net_hdr_to_skb()
> > > =C2=A0=C2=A0=C2=A0 =

> > > =

> > > is this what you mean?
> > > =

> > > I don't know which commit is "virtio-net: Suppress tx timeout warni=
ng
> > > for small tx"
> > > =

> > > =

> > > =

> > > > Reverting this commit restores normal network performance in
> > > > affected guest VMs.
> > > > =

> > > > I=E2=80=99m happy to provide more data or assist with testing a p=
otential
> > > > fix.
> > > > =

> > > > Thanks,
> > > > Markus Fohrer
> > > =

> > > =

> > > Thanks! First I think it's worth checking what is the setup, e.g.
> > > which offloads are enabled.
> > > Besides that, I'd start by seeing what's doing on. Assuming I'm rig=
ht
> > > about
> > > Eric's patch:
> > > =

> > > diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.=
h
> > > index 276ca543ef44d8..02a9f4dc594d02 100644
> > > --- a/include/linux/virtio_net.h
> > > +++ b/include/linux/virtio_net.h
> > > @@ -103,8 +103,10 @@ static inline int virtio_net_hdr_to_skb(struct=

> > > sk_buff *skb,
> > > =C2=A0
> > > =C2=A0		if (!skb_partial_csum_set(skb, start, off))
> > > =C2=A0			return -EINVAL;
> > > +		if (skb_transport_offset(skb) < nh_min_len)
> > > +			return -EINVAL;
> > > =C2=A0
> > > -		nh_min_len =3D max_t(u32, nh_min_len,
> > > skb_transport_offset(skb));
> > > +		nh_min_len =3D skb_transport_offset(skb);
> > > =C2=A0		p_off =3D nh_min_len + thlen;
> > > =C2=A0		if (!pskb_may_pull(skb, p_off))
> > > =C2=A0			return -EINVAL;
> > > =

> > > =

> > > sticking a printk before return -EINVAL to show the offset and
> > > nh_min_len
> > > would be a good 1st step. Thanks!
> > > =

> > =

> > =

> > Hi Eric,
> > =

> > thanks a lot for the quick response =E2=80=94 and yes, you're absolut=
ely right.
> > =

> > Apologies for the confusion: I mistakenly wrote the wrong commit
> > description in my initial mail.
> > =

> > The correct commit is indeed:
> > =

> > commit 49d14b54a527289d09a9480f214b8c586322310a
> > Author: Eric Dumazet <edumazet@google.com>
> > Date:   Thu Sep 26 16:58:36 2024 +0000
> > =

> >     net: test for not too small csum_start in virtio_net_hdr_to_skb()=

> > =

> > This is the one I bisected and which causes the performance regressio=
n
> > in my environment.

This commit is introduced in v6.12.

You say 6.8 is good, but 6.8.1 is bad. This commit is not in 6.8.1.
Nor any virtio-net related change:

$ git log --oneline linux/v6.8..linux/v6.8.1 -- include/linux/virtio_net.=
h drivers/net/virtio_net.c | wc -l
0

Is it perhaps a 6.8.1 derived distro kernel?

That patch detects silly packets created by a fuzzer. It should not
affect sane traffic. Not saying your analysis is wrong. We just need
more data to understand the regression better.=

