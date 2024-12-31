Return-Path: <netdev+bounces-154637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E3D79FF02F
	for <lists+netdev@lfdr.de>; Tue, 31 Dec 2024 16:24:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8F1D161A9C
	for <lists+netdev@lfdr.de>; Tue, 31 Dec 2024 15:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F320213AD1C;
	Tue, 31 Dec 2024 15:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.fr header.i=benoit.monin@gmx.fr header.b="qtLHTU2L"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A53E19BBA;
	Tue, 31 Dec 2024 15:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735658691; cv=none; b=EsoJzzf6d284z4Muak5bZiLlqX2bu5H0VKRqWlODAxjq9LVf60NYygxmbOhKwgfozPR0OCANMkvUH9EEq+Ugat9NSeUCXOosKSJb8i7RBJyPsi7LFi5y2406WKW7+hMHvZI54BXvKkv+6YAWmfG0dyO/1PqB9nLX0XaChJUpZOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735658691; c=relaxed/simple;
	bh=LmqxIiUQySVlNDOl0i/ms33WuC6llVzMNXvRtMaTaBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bZtxnO14nSE0ThqWfnwt0gqNGfx2ckA+E2e9Q/jAcMgq1n1P9Qz4hWUS6MIWbzPucfdVM0Tgew6SVd/k6MJ8+ILuzvIOFMSAUC6FBMWCXLPe8+nbDMliRJ6GuLUqShvy1oCkGEpcy+Yyy8joCGkbewmnb/Z+XnNoHFZYpnfadPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.fr; spf=pass smtp.mailfrom=gmx.fr; dkim=pass (2048-bit key) header.d=gmx.fr header.i=benoit.monin@gmx.fr header.b=qtLHTU2L; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.fr;
	s=s31663417; t=1735658668; x=1736263468; i=benoit.monin@gmx.fr;
	bh=5s4qH9Se7byeQA8Islfd0Ot1r6B/y+vge7kyJWSzA3U=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=qtLHTU2L9XpGU8FDhPV8C8Z5wm6wF9M1FWNE2YS2sZ6vskO3wHtIS1R8IeK9Io/M
	 bklmjhbBgEZ2VnPabKg93BfDM+H0XO+J/WSGg0u+T+LQs765KUgtsog19tLWWvA3+
	 XvI3BX9zIHrIQYC96WVH/BGHCPXWZt2NcvxAGUqwxT/0anh67uookgW/TKXclL+D9
	 mWVklSF4g+xZp7K/ZJLp+T8NItVeSmPGkAEvPpdjEExKI02dba8Pgtiw5A4FmEEUY
	 PqKnfXTr//p9rA4Svo24oDiZ1HDPNZWsJA6GEXy3bwz10g/IkocR17XvqKTVU3z5H
	 000DX/YbFZAb/gIu7w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from pianobar.pianonet ([176.145.30.241]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M26vB-1tV74v1W2L-001lHb; Tue, 31
 Dec 2024 16:24:28 +0100
From: =?UTF-8?B?QmVub8OudA==?= Monin <benoit.monin@gmx.fr>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Lorenzo Bianconi <lorenzo@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH v2 net] net: skip offload for NETIF_F_IPV6_CSUM if ipv6 header
 contains extension
Date: Tue, 31 Dec 2024 16:24:26 +0100
Message-ID: <4919277.OV4Wx5bFTl@benoit.monin>
In-Reply-To:
 <CANn89iK1hdC3Nt8KPhOtTF8vCPc1AHDCtse_BTNki1pWxAByTQ@mail.gmail.com>
References:
 <5fbeecfc311ea182aa1d1c771725ab8b4cac515e.1729778144.git.benoit.monin@gmx.fr>
 <CANn89iK1hdC3Nt8KPhOtTF8vCPc1AHDCtse_BTNki1pWxAByTQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Provags-ID: V03:K1:5Fvcchp35lMKswWIVlGk0eoUFvNakd5EopXq9+xBO3KRlm5Rcbu
 hdASSEH/QsOH0KeFRH4MxL8dK7z6BTPTFgBFxXLItVc23jTEiUTBXyOTXgYpsBnIrpKiG3g
 Bj9AW3dOIlcBpgnuWolcPjO08UqQ/g1+hbMPGt03KbMFVehS6Sfzu5bG1uKF7l6EGLy9qp9
 uiIAo/p9ZpOF3o4XDMXtg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:UOvW5sa6HTo=;kFieSgIgIvCQsj30nND0pkqlMH1
 oOvVGO9CnFe7BWLXceHU5az0SkeBRPOLLB+Lb6DL6/vfp90p1lHQXVIKVSYVdNhVXmFrKOGXy
 ZPOdVbhSlaRsNfIo3v0f1+pMD0pwDrS9dxlB3rg7g5T+kQKmuziwf9iF6H3o7YNeDseZyTZxY
 uOt5mcpDbh4CJbxWXqFI5i6B4Y0mAZdIGzYdk5caq9k6Y18L/lKH+cRu6/qY/sxk0YK1aOlzw
 2VlNNSg9vtox/LhPWtidzWYZdpsnoO2AjCfABoStaKk9NpgP7l1apGJbke2tLNcvoV7ITjC9z
 0Wt8RxaW7lWGD7dRLSvOAFDzCAU5Mkn8NIJSzE/uTSutcYKJkxPFJkievAq+MjABL9I4CCH6z
 KaQZ0BhjhGzNgf4SkKORpTVGvbM0gR5n37Gy7oOnoW4p5cXNpgtEHeHDZlpN/Sw1i7xmwqv+p
 WdsSgGUdvbrcnyMtsQ4uV1tCF6pznperKc6rBhE1lGs/ciF0Rruqa19FnFuLmcdkhmluzXVQH
 hZDejtsoZ8IfG77S2pufcBP8fvWz9URNFoxmwZYtYLbFE388LWmQKOktJ0SCVQxC6A2BFUFDI
 hh4JM0F7sj4NsdiV9jQwO040d9Gzaoj/3StYb7fcA/L0+T8Rn79YneQa2zD2Za92iznKdVGS3
 iOO8hJQGn5G41hdLYnF/5h5HQUnuQroGiM5abGXnhpxIUuLlR2bwe6ptnbXQ4wCjBCLtwT60t
 qak2oQZWNAQe7qlgTr87ZyEzb6N660ZS4lA8TliCLfPi8tGf6qsxsw36ju5pUNrHge972LroA
 IrT4axkuofe+097rGxWja6EjXqaNOrUkdy8olt6wmePgopWhJ9rnqCICgOe0mZf7gIkm/pcJS
 Blw2MIeW/2+7KvlPll6DC4IbSNxvFsLkYz70QZzm8TrNGirG8afYjfkiArj+oVB+QGFLj19wj
 IxftQ/1pS/+Qc7DyF/y2rKqPqbIEGYDMnAJUzbiw6XifGcie8Txua+RzLhHjfWa+emHTuuanA
 FgVEwCD3R0mmubdqDDlAgWGA2mEihQ0tGcAgTRolls5cir3AFVoeG/bAKSH1ZbnU8l1Uy0Ugt
 ExprhVGUuRdQtPOazMadJb7ugb4na/

Hi,

23/12/2024 Eric Dumazet wrote:
[...]
>=20
> FYI, this patch broke BIG TCP over IPv6.
>=20
> [  239.698598] Oops skb_network_header_len()=3D48 skb->len=3D67210
> [  239.704122] skb len=3D67210 headroom=3D162 headlen=3D94 tailroom=3D0
>                mac=3D(162,14) mac_len=3D0 net=3D(176,48) trans=3D224
>                shinfo(txflags=3D0 nr_frags=3D3 gso(size=3D1428 type=3D16 =
segs=3D47))
>                csum(0x1000e0 start=3D224 offset=3D16 ip_summed=3D3
> complete_sw=3D0 valid=3D0 level=3D0)
>                hash(0xadf29e31 sw=3D0 l4=3D1) proto=3D0x86dd pkttype=3D0 =
iif=3D0
>                priority=3D0x18020 mark=3D0x0 alloc_cpu=3D46 vlan_all=3D0x0
>                encapsulation=3D0 inner(proto=3D0x0000, mac=3D0, net=3D0,
> trans=3D0)\x00, net=3D0, trans=3D0)
> [  239.704153] dev name=3Deth2 feat=3D0x0000030000114ab3
> [  239.704155] sk family=3D10 type=3D1 proto=3D6
[...]
What is the driver of eth2?
Since it was working before the patch, it means that the hardware is able t=
o=20
deal with variable-sized IP header. So shouldn't its features contains=20
NETIF_F_HW_CSUM instead of NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM?


=2D-=20
Beno=C3=AEt



