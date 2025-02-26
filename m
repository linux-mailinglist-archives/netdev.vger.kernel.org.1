Return-Path: <netdev+bounces-169945-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83BF6A46993
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 19:25:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86780171F3D
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 18:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768A0235368;
	Wed, 26 Feb 2025 18:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b="AFPfr6hc"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC68C22540A;
	Wed, 26 Feb 2025 18:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740593859; cv=none; b=Ht5l9oH2qGLFeGf8t7sE6SWMV+bMrUimBAhBbSBSC/Pgj9IybeivjSqkltHdQwzuP9z6bB2T0ugM7IjLniad1HLlC3TakVJlbXQIknpY/l6Fx9ri1AqcUr2DVpo4Paj+0aUK1xQuAyZpHzV8cAb11V+MeJCg3oLHdz+nVZADvMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740593859; c=relaxed/simple;
	bh=7SPYnAXBwd09mqrgJKm3M4GdXzEp3OFKfWGQm31sLMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L1s3wsLJw/M4I+B/T0e3QgPJnuW0Fgg4J05khIQ2VICbYUq7WDa1Y66d5o9ztpWARG9R0E0Zg44cGV4MbulPsHNww4c3dalJ+Kr5hE1nfZQSFkRdk36jSgjAxHh568133AS0w7Jr04WXa1qmMWun5FJ21OCFcL25KtNgI0Dkzsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b=AFPfr6hc; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1740593845; x=1741198645; i=ps.report@gmx.net;
	bh=ukU3KmpIwMHvG/ytdZW/bBTC6zT6SMO7B8X4f4buLc0=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=AFPfr6hcBztfz+NmL0B7stmiWF39iG0UeDKGr/YkwrCYTH9m6BM/KXupSrVqjjEa
	 JRdP+687kJBC3zA+Pt5V02kTa/fxY9EAf8g21ZhABR/dh44XhRPKDsRAlyibcHVy7
	 xbHWBecoxxPN5JmCFgIuLfE2CuEgBvyNFKReUHDCWTaY4/k6+3B9qe8Yr6DWzUEwl
	 9uHXHs4eIBCOUBYFpIrH344Pyv/M7YaUQK9r8y1b/N57IpDeot0DziWow2CPm0twJ
	 o1BmoXLfm8URn6xaCNM+s+Xe92AI8hOTrjOw1MNd19xA37UMPK3L68D6A0/Le+IAJ
	 BZEoxama76MmT2dcVQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost ([82.135.81.93]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MEm6F-1tX8Xe0d6h-00DWHH; Wed, 26
 Feb 2025 19:17:25 +0100
Date: Wed, 26 Feb 2025 19:17:23 +0100
From: Peter Seiderer <ps.report@gmx.net>
To: Arnd Bergmann <arnd@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Simon Horman
 <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pktgen: avoid unused-const-variable warning
Message-ID: <20250226191723.7891b393@gmx.net>
In-Reply-To: <20250225085722.469868-1-arnd@kernel.org>
References: <20250225085722.469868-1-arnd@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ilihWn6XSUXka8w4Opgx5nIzQpScpD4HwXJtjdcb9/251tDTrXj
 JpzqKlACqH6sGBWWsvOh1jNdQKqj/IOnr7Ar/pHaQQY4HPU0hFwd9hKNiuLzEWFzFe5i/9f
 g/0C4+V+vC5bBL9IIN0arPoKZgwbKoi9tgaSieXFYCYR+DM39XzePbvX1UGb8FGZ0QF2YbB
 JYEAWTMshD0rApFd7C9IA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:gQi6RG8KjxU=;aTnVN3p7RJX35+JhVMF/chgdJvW
 reT/KTUm6O5rRZXERB9xrD/fX9oCcIYkkSbpljIkSlaI/gnbnDNMgiLDwyE76YO7IO4HI+ApW
 Sf0bMe/s+KlJFIGcvWFR2OFP+T5i12tUykwU2zM/mK8y6q50NrWPw5HAq1lA150telttH752y
 0YymL3foKuQTmGp6nSSs+7OVl/EPscZIUQ11EIPs7CLKt0DeWr6LKGIQ9oB20QVCHtibL6chp
 b9VnmAgOBmGpDF1Vj4ZOPwKmUMFs5RZLKTFUqKQblgOw7UqSBxneWKX7qrhufqlHCkNvioKxu
 sDXk/D6MtlfvTLgRjtJ4MbrYy6FGmMFRGqtlabFSw8DQSd8tV0DngJZomNcgFr8SwlnLkDvT/
 v6QfdpLRvQPd1zgTBulWKsxR8JLiTC1Ztz0CspfAzbLEX5P8XVXSx8B3AiO8vZ9KmGcQz0sYx
 5cR/aWhkgOfQvktW4vlROQ0HFdqOgQ5+RFh/VMbaD3qjNWGtvyvGY05n0ywr2HCfwY7+1jLfO
 ZTSUSeIXEy/KR8MeJ5+Mtv5A0tjCvxvYIyxU9b1HOCWc0/b2C1eiwsFewOrBpMA3iRX7ATJb9
 hFfR6qJNMnRKdSC2MoGCrsWJDWD1kEweV7LmMAlwoR/sHt+H5oxUVcBS+NtYHDGjzFVqE8u3h
 b/42Rufc1D9yphlczebnksZ0qvYVKeRkmn6uUaUqU2T4gmA2ckSJAbSpFgAm4wOeM6MYF4xrG
 +UZXxsfakGtb3uRQG72wUrcQ3Ob/kjXP+FdAyNaoXtYEPT4LNn2G6aBMjqfotzG5hiYSzIUVM
 ouSKQCpVsdxrz34btWVWyq1RneySDZeSXMwvjm6fWqvVJkkndFSMAds01XzFmTShggbq0uVVA
 NOxglmJfzAaLDW1N7uvdaX7cWpf1CZ5bxPtmTKNg+7qB25dzo3dV156o0i6e5xRjc0trzAUmv
 Sw8EBL2EPyi5fyCd5XxW9Q9k0atJ0hXBgFz8JJC+zO2TfyZa151aJQHT+HkIw/GqjDbwJOU27
 1ZuSBRV8j9lV9+blkzBo66ddESVDVJce5kl2wjyzUq9BHKm0GvXaQYvX26akJx8jPyZz6sIRR
 WEKDy4Yzld0IZew+/NhEbWv24Nmfj8MsJaxL7Q9qn7YZ+5TgEmoxWCg9EzL+EzsjLKaaLO0wI
 DmB2nACYU49XVpmybkxpp71hfRDCVQJxpOftQY+VHDVFTrtQo1AoO0ra+bdwsHyWMM4agrSQJ
 wQSBuxKGEXbtP2vxKWJtTXP9FJXBJ+A1C8RevLvtLwXoo6AnuertAQlzCvV45rEAsGOKaVz7s
 9R4IicY7Ac6KEk5PmNYSE9f3HxF8pnPTIWcuLuVUKUY7SHYNjDfp1y1QbfZWxgoPrJxVkiCUb
 pWoByLIEbUt4kM/ltzdZETvh4j/OpiI0dwOeu4OEPA9kPE/DDzlYYHcyWy

Hello Arnd,

On Tue, 25 Feb 2025 09:57:14 +0100, Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
>
> When extra warnings are enable, there are configurations that build
> pktgen without CONFIG_XFRM, which leaves a static const variable unused:
>
> net/core/pktgen.c:213:1: error: unused variable 'F_IPSEC' [-Werror,-Wunu=
sed-const-variable]
>   213 | PKT_FLAGS
>       | ^~~~~~~~~
> net/core/pktgen.c:197:2: note: expanded from macro 'PKT_FLAGS'
>   197 |         pf(IPSEC)               /* ipsec on for flows */        =
        \
>       |         ^~~~~~~~~
>
> This could be marked as __maybe_unused, or by making the one use visible
> to the compiler by slightly rearranging the #ifdef blocks. The second
> variant looks slightly nicer here, so use that.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  net/core/pktgen.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
>
> diff --git a/net/core/pktgen.c b/net/core/pktgen.c
> index 55064713223e..402e01a2ce19 100644
> --- a/net/core/pktgen.c
> +++ b/net/core/pktgen.c
> @@ -158,9 +158,7 @@
>  #include <net/udp.h>
>  #include <net/ip6_checksum.h>
>  #include <net/addrconf.h>
> -#ifdef CONFIG_XFRM
>  #include <net/xfrm.h>
> -#endif

This ifdef/endif can be kept (as the xfrm stuff is still not used)...

>  #include <net/netns/generic.h>
>  #include <asm/byteorder.h>
>  #include <linux/rcupdate.h>
> @@ -2363,13 +2361,13 @@ static inline int f_pick(struct pktgen_dev *pkt_=
dev)
>  }
>
>
> -#ifdef CONFIG_XFRM
>  /* If there was already an IPSEC SA, we keep it as is, else
>   * we go look for it ...
>  */
>  #define DUMMY_MARK 0

A now unused define...

>  static void get_ipsec_sa(struct pktgen_dev *pkt_dev, int flow)
>  {
> +#ifdef CONFIG_XFRM
>  	struct xfrm_state *x =3D pkt_dev->flows[flow].x;
>  	struct pktgen_net *pn =3D net_generic(dev_net(pkt_dev->odev), pg_net_i=
d);

Maybe better this way here?

	const u32 dummy_mark =3D 0;

>  	if (!x) {
> @@ -2395,11 +2393,10 @@ static void get_ipsec_sa(struct pktgen_dev *pkt_=
dev, int flow)
>  		}
>
>  	}
> -}
>  #endif
> +}
>  static void set_cur_queue_map(struct pktgen_dev *pkt_dev)
>  {
> -
>  	if (pkt_dev->flags & F_QUEUE_MAP_CPU)
>  		pkt_dev->cur_queue_map =3D smp_processor_id();
>
> @@ -2574,10 +2571,8 @@ static void mod_cur_headers(struct pktgen_dev *pk=
t_dev)
>  				pkt_dev->flows[flow].flags |=3D F_INIT;
>  				pkt_dev->flows[flow].cur_daddr =3D
>  				    pkt_dev->cur_daddr;
> -#ifdef CONFIG_XFRM
>  				if (pkt_dev->flags & F_IPSEC)
>  					get_ipsec_sa(pkt_dev, flow);
> -#endif
>  				pkt_dev->nflows++;
>  			}
>  		}

Otherwise works as expected, you can add my (with or without the suggested
changes)

Reviewed-by: Peter Seiderer <ps.report@gmx.net>

Regards,
Peter


