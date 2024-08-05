Return-Path: <netdev+bounces-115789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9B6947C67
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 16:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDA211F21BEA
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 14:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163E939FD8;
	Mon,  5 Aug 2024 14:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gcQgztMj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439A44D8D0
	for <netdev@vger.kernel.org>; Mon,  5 Aug 2024 14:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722866560; cv=none; b=GqXdKfZ0UhR5e1HzvN/I4lLOnLKdO9OEzmt93Eq2NUmxiWo+OXY8kw/1itvq+NmaUDnk174cTT8oEtWlrO/uEgMxMRBfIxwok28usKK/k15bxQaUTwJAdHB6PCeMBa/+7XGvkVYxeD/iX9LTORGVt0Z4pI/S+oj2a5mKktnDy9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722866560; c=relaxed/simple;
	bh=t6Zn8RtLcAqzJ9PYGhOYoM76mP8FCPiSpumbICwEiLE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZoQUP5/vNaArDVHzG2LFdAFXT8+ZQsQAjhwdtUIQMoORvUzmn5ntS3G3NyAUbQ69J4cX96Dk0CLBxWgadrbzdmieW5rwh34OrYAOUpAxHHXfZdiBblKmhgpMewtXEoLn6dAmXRC/Fy+Lkv9INCFI5FBtNHrU27j0zByPfQL34t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gcQgztMj; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5a18a5dbb23so10023a12.1
        for <netdev@vger.kernel.org>; Mon, 05 Aug 2024 07:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722866556; x=1723471356; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6y01yWkEDbZfw9f+QWJOKA+Cd/TeN/xK4SHxLNZG3RU=;
        b=gcQgztMjQxewk8U1n1UVbbekHI3a9fUOqEzbTn9jeq3lW8jZmgr5IPvPx5KwVS8WKg
         ZN15VGFngPg8sXWF0fApwGYGQJJyXBwCLX607OpxVjIQLHLQu9o1FymKhteeZRvYkgkG
         UHfxYpaBL5D0NpnpSDb6p08/wJ3IjbDBMBENuD5CW91XKbKulOoBBTeVoAkL3zpey0bZ
         Vha+GL8r4+NztwNI+EswzhBdwgETmtUIKgldCY9nZxBlkpUT/LWuUpnCPy/0B2+51kQ4
         MlIIOXuor17uwcUpaKEhGdSOkQCAzOlZKU3eXEio/bOsbBay9dbHbVU39zRPe7npZnKZ
         SdaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722866556; x=1723471356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6y01yWkEDbZfw9f+QWJOKA+Cd/TeN/xK4SHxLNZG3RU=;
        b=jacWdnawjCD/nN35jbf0Wyf2vGNNR/IngFRfEobSpUuKC5sR8VfZREnuUFBNPh+0h4
         GoXwXPCJbhrELnktScl8V78CabMnKYqMQGsCuysu5p1kJCjlKmtTQcKIbXSQAHDzyBDE
         dai9PVN1jX+LBZjRGmWyN76yB8TYXidAc4ZLwKVhhS3pu35YMdGlWkEeLfqjXnxCsnw3
         gY6zdKBdfSlWCTARCmn+Wg2GSmFVSeQohOcV2I5oWbP4EMn1TGeKFK0xTkGs2ZBzApT5
         99wDyoEB/rpVGcv4Uv7FI4E92wL6W/iCa1IR7tk/GIMUsrOKy/RAojcnEOpQu5Ow/JOS
         Mb0g==
X-Forwarded-Encrypted: i=1; AJvYcCWwFozJOoAh1jzQVDF/NYoVnEhVbbqwCTal60Y2OScUtLbzqS1oP4AmwOfSg+5ZuL3rhZUbpEQsQdnD0rzB+IhCuUYt2hE5
X-Gm-Message-State: AOJu0Yw6t3S92LRr2bVo5T3G/9jK9KqN+s2CbN9337sjp9QawgMYZbiv
	vIifk2w8DKOwg6YCIeaYqmNEfyJjc91HEcg1LaPISyTcgWtMI05XGy+jAcOp/HWqxSUyVmlSZRR
	5JWxGDou7fU+/+IZONPrv1DVMKfZmhnNEHYdSWNntWpg8fZ4IsA==
X-Google-Smtp-Source: AGHT+IFkEMjaj60hhY6B/rb+geUkIpPhFCX/6hd3cDvLNye5/nfj2De9A1x6RnwQ7iGwXRYuX4KFjezpt6TlzML7lAM=
X-Received: by 2002:a05:6402:26cb:b0:57d:436b:68d6 with SMTP id
 4fb4d7f45d1cf-5b9caf072d4mr227844a12.7.1722866556221; Mon, 05 Aug 2024
 07:02:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <BLAPR16MB392407EDC7DFA3089CC42E3CF0BE2@BLAPR16MB3924.namprd16.prod.outlook.com>
In-Reply-To: <BLAPR16MB392407EDC7DFA3089CC42E3CF0BE2@BLAPR16MB3924.namprd16.prod.outlook.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 5 Aug 2024 16:02:22 +0200
Message-ID: <CANn89iL_p_pQaS=yjA2yZd2_o4Xp0U=J-ww4Ztp0V3DY=AufcA@mail.gmail.com>
Subject: Re: BUG: UDP Packet Corruption Issue with stmmac Driver on Linux 5.15.21-rt30
To: "Oleksandr Makarov [GL]" <Oleksandr.Makarov@qsc.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-stm32@st-md-mailman.stormreply.com" <linux-stm32@st-md-mailman.stormreply.com>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 5, 2024 at 1:40=E2=80=AFPM Oleksandr Makarov [GL]
<Oleksandr.Makarov@qsc.com> wrote:
>
> Hello all,
>
> On my MSC SM2S-EL [1] there is an Ethernet device driven by the stmmac dr=
iver, running on Linux version 5.15.21-rt30. I've encountered an issue wher=
e UDP packets with multiple fragments are being corrupted.
>
> The problem appears to be that the stmmac driver is truncating UDP packet=
s with payloads larger than 1470 bytes down to 256 bytes. UDP payloads of 1=
470 bytes or less, which do not set the "More fragments" IP field, are tran=
smitted correctly.
>
> This issue can be reproduced by sending large test data over UDP to my El=
khart Lake machine and observing the data corruption. Attached are two pack=
et captures: sender.pcap, showing the result of `nc -u [EHL machine IP] 232=
3 < pattern.txt` from my workstation, where the outgoing UDP fragments have=
 the correct content, and receiver.pcap, showing packets captured on the EH=
L machine with corrupted UDP fragments. The contents are trimmed at 256 byt=
es.
>
> I tracked the issue down to drivers/net/ethernet/stmicro/stmmac/stmmac_ma=
in.c:5553, where the data corruption occurs:
>
> ```
>                 if (!skb) {
>                         unsigned int pre_len, sync_len;
>
>                         dma_sync_single_for_cpu(priv->device, buf->addr,
>                                                 buf1_len, dma_dir);
>
>                         xdp_init_buff(&ctx.xdp, buf_sz, &rx_q->xdp_rxq);
>
> ```

Hi Olek

Do you have an active XDP program ?

If yes, what happens if you do not enable XDP ?


>
> After the driver finishes synchronizing the DMA-mapped memory for consump=
tion by calling dma_sync_single_for_cpu, the content of buf->page is incomp=
lete. A diagnostic message using print_hex_bytes shows that buf->page conta=
ins nothing (or sometimes garbage bytes) past the 0xff mark:
>
> ```
> [  606.090539] dma: 00000000: 3000 29d6 c48d bf08 30b8 6280 0008 0045  .0=
.).....0.b..E.
> [  606.090545] dma: 00000010: dc05 b373 0020 1140 25af a8c0 6d58 a8c0  ..=
s. .@..%..Xm..
> [  606.090547] dma: 00000020: 7a58 13c2 1309 ca05 4e6c 3030 3130 203a  Xz=
......lN0001:
> [  606.090549] dma: 00000030: 6f59 7275 7320 7274 6e69 2067 6568 6572  Yo=
ur string here
> [  606.090551] dma: 00000040: 300a 3030 3a32 5920 756f 2072 7473 6972  .0=
002: Your stri
> [  606.090553] dma: 00000050: 676e 6820 7265 0a65 3030 3330 203a 6f59  ng=
 here.0003: Yo
> [  606.090555] dma: 00000060: 7275 7320 7274 6e69 2067 6568 6572 300a  ur=
 string here.0
> [  606.090556] dma: 00000070: 3030 3a34 5920 756f 2072 7473 6972 676e  00=
4: Your string
> [  606.090558] dma: 00000080: 6820 7265 0a65 3030 3530 203a 6f59 7275   h=
ere.0005: Your
> [  606.090560] dma: 00000090: 7320 7274 6e69 2067 6568 6572 300a 3030   s=
tring here.000
> [  606.090562] dma: 000000a0: 3a36 5920 756f 2072 7473 6972 676e 6820  6:=
 Your string h
> [  606.090564] dma: 000000b0: 7265 0a65 3030 3730 203a 6f59 7275 7320  er=
e.0007: Your s
> [  606.090566] dma: 000000c0: 7274 6e69 2067 6568 6572 300a 3030 3a38  tr=
ing here.0008:
> [  606.090567] dma: 000000d0: 5920 756f 2072 7473 6972 676e 6820 7265   Y=
our string her
> [  606.090569] dma: 000000e0: 0a65 3030 3930 203a 6f59 7275 7320 7274  e.=
0009: Your str
> [  606.090571] dma: 000000f0: 6e69 2067 6568 6572 300a 3130 3a30 5920  in=
g here.0010: Y
> [  606.090573] dma: 00000100: 0000 0000 0000 0000 0000 0000 0000 0000  ..=
..............
> [  606.090575] dma: 00000110: 0000 0000 0000 0000 0000 0000 0000 0000  ..=
..............
> [  606.090577] dma: 00000120: 0000 0000 0000 0000 0000 0000 0000 0000  ..=
..............
> [  606.090578] dma: 00000130: 0000 0000 0000 0000 0000 0000 0000 0000  ..=
..............
> ```
>
> I would appreciate any insights or suggestions on how to resolve this iss=
ue.
>
> Best regards,
>
> Aleksandr
>
> 1 - https://embedded.avnet.com/product/msc-sm2s-el/

