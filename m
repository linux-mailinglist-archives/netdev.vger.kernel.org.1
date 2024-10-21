Return-Path: <netdev+bounces-137544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8359A6E0A
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 17:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21B541F22EEE
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 15:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362FE12F588;
	Mon, 21 Oct 2024 15:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.fr header.i=benoit.monin@gmx.fr header.b="Sh0R6xTu"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68968BE5;
	Mon, 21 Oct 2024 15:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729524354; cv=none; b=X3Yr4YzGsLMnSFbGoFRo/lY6OEozJu/sSlN25jS9wRslFUcvDr6AEG65sno5V+QAP+2R/tTDm5TWcg7v1NLVv23J1EblEnFVkh3sSrRHTpIdHE7uAheqL3po5xseWsv7M6Xze034VFaEsHoDPkVqohu9ka5uwA+1cTzz5e+Ielo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729524354; c=relaxed/simple;
	bh=vIwIavf4ScAQVzdq4hZstzaeo0UwWL3Q5dmfrvtSX6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=arBY74bOruuEbUD2OH4YL4GMWS+7hPlMOMNy4+VZPxJfc66QRzku9lwagFGnkewOGIxXzo25Te5zgaG+hO3LAVFcmqI8OwBFeOSS8iz6fNBlfLcRz8NeDbwDtz4mCS46p5khJO1T2AwCUXwZfiwr5FZzQke6DT1QW0ceU4F58DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.fr; spf=pass smtp.mailfrom=gmx.fr; dkim=pass (2048-bit key) header.d=gmx.fr header.i=benoit.monin@gmx.fr header.b=Sh0R6xTu; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.fr;
	s=s31663417; t=1729524327; x=1730129127; i=benoit.monin@gmx.fr;
	bh=yUuthWwupxa6phQatChwq29DzW+mOPO/hf6lg0/2bCI=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Sh0R6xTuBYMutY9IJT/WiQX12yaK3SDBCHpJW+GhXgRw5ri9ZtAtZJwqRKDoILk0
	 WVbm2keRLhHsRQbl/xqEq/G/3HIOx9f9ULRraOqxHbA0cHEbquqA74z13GuJphyiN
	 ftrcnMoQqNUcYtiiYXL+HAZAF4sd4W4r0dBfM4OhfIwRQI+7nn/xwJ9ouL/i+vfsV
	 xSxERnxh8PsZxcxHE+AmDxZsUCndTLtJL0tKZcqmSfKuhi9MjjNqtFcVGaWN4R360
	 BupW5eADZD32HQ7nft/HpBpB1uQvi6XVx2rJdYGkblIqcTKTE5HcARntsXp6WqPp0
	 d7RRaBy1IGXEI8Yb0w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from pianobar.pianonet ([176.145.30.241]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M7b6l-1szsYE2dMz-00DSyS; Mon, 21
 Oct 2024 17:25:27 +0200
From: =?UTF-8?B?QmVub8OudA==?= Monin <benoit.monin@gmx.fr>
To: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH net-next] net: skip offload for NETIF_F_IPV6_CSUM if ipv6 header
 contains extension
Date: Mon, 21 Oct 2024 17:25:26 +0200
Message-ID: <2704514.lGaqSPkdTl@benoit.monin>
In-Reply-To: <4411734.UPlyArG6xL@benoit.monin>
References:
 <0dc0c2af98e96b1df20bd36aeaed4eb4e27d507e.1728056028.git.benoit.monin@gmx.fr>
 <6704483c31f9c_1635eb294a0@willemb.c.googlers.com.notmuch>
 <4411734.UPlyArG6xL@benoit.monin>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Provags-ID: V03:K1:xIsSPC2hBvp0nuXoFbb+mszY6SyXceaFWDrxVgC9w6etN7OX5gT
 wJLMEKOFL3aCf1aihm26sHADEauIWgCPdAkrcrSIA//J0zyqmXHiu/O192u3kTwITSzAiNL
 XD7b7AzXh9pzByI4UGMwLDiThILkKFTgTGZD9StgTRMGekM+8Fnq5n5lHXN9phKAW0oZaUy
 5+ka+EEfkMfwxsZh1y7Zw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Ap+ixU/B5qE=;Ng7MCYlJz/Pr1QDD1m60+tbcr17
 dvixiU9xj+VvDmy1rOX2dGBrpG2hWwa9UTOQ8bZJH2lQSYUMoPdHIX5PUHiKXj5lV1Oo2rqBd
 sqX2F6siWkxQmMt6Yx4ipPHSxw9jtZDd2P0xNQPXkQdiLIG0W2RMUYBHyrVc45SAVzL2+t8BT
 SNilpL1LFYk6PQH9OGVLuOeSnrHP8PziHjAg0Polh4BUD3ZyLm0PNgwokbfhMlTUavymSuBnJ
 tSe/xn2Qxz78dxeA22N9I0qUsgdB4YJUnt7HuxPWlGnnHPmfhnDKm6Rk3ss3s5KlW7zCsIKYQ
 YpuG39mtyHuawTcw8nkXHO97fUPCoA7Cv0sP3AXn9NyuFeqyNxHjbGcMfVvwKnadvUMoT6jUT
 QizUuARWmTXrri7Nt7ApugjQrC2GFIZg4eNG6EeQF8ArOOjzEAEoocfI9QfdNHAy/FmEDAin1
 s9zB+TOZ8umJ72Z7UajMd3TKp4vaILvENhZNNt/2ra9eJCXzJ0UlbjVsUNXVEw2tT2t9kM/Zv
 h3quUzZMHWtk3zU3stnBJwPKTwW7wQa7xTxsKSr1bOX7VGT9uUyPKyX3q+mpfQ33LUFR+xQGb
 Ekd7dQkHxbj/8kPMvHAZ29yMqX1iFtdAR0DmeoFF+jDXcnYrS9CL45eqA8TXItW6plB5l5L4H
 IrFsvarfxo97iU2u8mdT8xlC9ZDEzW6GxgqVjCxRCGi3FCtuswHJsyzgOxFNai52GwRCOIFTN
 spmQPUig6cmE9aGVw8Iemgecet6ehqTuSWpRjjK34HBoYpYXYoyrSlEjAmokZqp0QcMO6zopG
 DS96Rn+WnRvqJqk6efh28rvthT9U3QB4fb53Cscre3rcg=

10/10/2024 Beno=C3=AEt Monin wrote:
> 07/10/2024 Willem de Bruijn wrote:
> > Beno=C3=AEt Monin wrote:
> > > 07/10/2024 Willem de Bruijn wrote :
> > > > Beno=C3=AEt Monin wrote:
[...]
> > > > > Signed-off-by: Beno=C3=AEt Monin <benoit.monin@gmx.fr>
> > > > > ---
> > > > >  net/core/dev.c | 4 ++++
> > > > >  1 file changed, 4 insertions(+)
> > > > >=20
> > > > > diff --git a/net/core/dev.c b/net/core/dev.c
> > > > > index ea5fbcd133ae..199831d86ec1 100644
> > > > > --- a/net/core/dev.c
> > > > > +++ b/net/core/dev.c
> > > > > @@ -3639,6 +3639,9 @@ int skb_csum_hwoffload_help(struct sk_buff =
*skb,
> > > > >  		return 0;
> > > > >=20
> > > > >  	if (features & (NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM)) {
> > > > > +		if (ip_hdr(skb)->version =3D=3D 6 &&
> > > > > +		    skb_network_header_len(skb) !=3D sizeof(struct ipv6hdr))
> > > > > +			goto sw_checksum;
> >=20
> > This check depends on skb->transport_header and skb->network_header
> > being set. This is likely true for all CHECKSUM_PARTIAL packets that
> > originate in the local stack. As well as for the injected packets and
> > forwarded packets, as far as I see, so Ack.
> >=20
> > Access to the network header at this point likely requires
> > skb_header_pointer, however. As also used in qdisc_pkt_len_init called
> > from the same __dev_queue_xmit_nit.
> >=20
> > Perhaps this test should be in can_checksum_protocol, which already
> > checks that the packet is IPv6 when testing NETIF_F_IPV6_CSUM.
> >=20
> You're right, moving this to can_checksum_protocol() makes more sense. I =
will=20
> do that, retest and post a new version of the patch.
>=20
Looking more into it, can_checksum_protocol() is called from multiple place=
s=20
where network header length cannot easily extracted, in particular from=20
vxlan_features_check().

How about keeping the length check in skb_csum_hwoffload_help() but using=20
vlan_get_protocol() to check for IPv6 instead of ip_hdr(skb)->version?

=2D-=20
Beno=C3=AEt



