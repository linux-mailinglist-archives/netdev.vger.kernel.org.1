Return-Path: <netdev+bounces-231167-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2968BBF5EFE
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 13:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA6E318C1CB2
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 11:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3E62E7F11;
	Tue, 21 Oct 2025 11:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ltTJAwUu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7422D8DD6
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 11:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761044565; cv=none; b=bwkj0nfWim0HdeVLvS3GQXSvpKQrU73hajyZPhYoQrxb01xi8p72hjhM/ihrGzW6iGOgtNYp9xT1y7q6baVpNHxQTC5VJVv8yjHoAdx0sxHluWgYHu4yRwDvu4QzXBt+LxAN38fOuDTtoCQ9F1uKM8Eu/Am1EigpGFn6FhtmzbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761044565; c=relaxed/simple;
	bh=Cmlt8NumtSJsa31SmZDdXrhoNC6ZwQkLlZeCoQNExr0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jd38jgqwTkYxTvjiLXfWTsUhoKR5ObufaHxLtfGYl7/Rmhvo9FqNYUOQ1Gm9la6ccSLvL9sIdXkcxz4cv0tVsH5lo3MbHlBlmcwc38hxcS7Q7Gx3uynyZBsz3zmGsMMhmC59MyyWzuFXJMr+kP29Hdmba9b43qfUDyocH+LhDAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ltTJAwUu; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-93e7d3648a8so173436939f.2
        for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 04:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761044563; x=1761649363; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cmlt8NumtSJsa31SmZDdXrhoNC6ZwQkLlZeCoQNExr0=;
        b=ltTJAwUufV/rwJu+SJ23F3MkB7y5hfoy1+Om0/YBaLUhTfIThIOF4d2cK5cSLEMwLI
         Lys3AVNaAufGGNEzUsd2/VuARMnMgk5B1RlqDBbMhJFKO/O601nFISblNssn6p2TsL8u
         Ni3lVsHDrFcVLG5fkhpTxiycuqGytzAiMgNJgTUO9h1Qk7ktJK0pbsX/4Bln04Diwm5P
         u0IkGs8R8B9UFofpCsTV2/zbYbb43cW7IRuVd/FvX82I32jXKa4OW35dcrZ5MPBHkPDq
         QpCxoiB0CvIqtidP6RhT+5TpfP9l2yoXUB5Ddy3j8CoJT3Z4M3j8MN9+UeEt7hdIfedC
         6UEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761044563; x=1761649363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cmlt8NumtSJsa31SmZDdXrhoNC6ZwQkLlZeCoQNExr0=;
        b=vBUGnFczUOUP9JYiCIHZ5ZVnVxrZ8bv4BPiAPWN+YTjHFYS/TmZxrHWd6v7LfTHWAV
         PE0CjGBhNspZJMFSIaJL5+pNOjIGUroPsevtjS+mCBgtj8mwAcQRX4rB/shWqHeNcPQf
         XAJFo7U3fUDZpWCWlsa/BSVty8UspFm4wGFlW4FtfEbucjPEC1VGL9Mtj/LvZ3Jh8OOy
         8sWwQCXKNTILsmieB2Y/zBBoaKSUmkcw/C6dwBQNrnsvVfSZqHdOm1xnV6m/FP+UHka0
         ZgsVQtkHtfjrw1BPTCtvtyHeBEJ/3X43nUSB9kxlvraMt+WwdvZuKJO2uua17UUzY4gy
         cevg==
X-Forwarded-Encrypted: i=1; AJvYcCXPJbawRHYSosrmdbLYIdntbI7PN1EgKJrPcIaxAcCjHw6s6NvwSdNeABDEFjOWSDF33Up/vts=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqPC3z5c8S6rIqCuUthg1Nh0xxdgp8cS57ZPZo87IlbN9t/Juk
	iWGQTvPHI9j5QTvqjdrUvYbEFiLwEvpC7p8OOShR2j4aP2VYxILrzbQrXg96gwqNKib9M4LBMQ7
	xwj/qZBdEE67YfVmZNYQADpPaaJtFTkY=
X-Gm-Gg: ASbGnctXfbHjk4C5iUp9VL7lgp2RKFCLlIF1KDnM5Ez8M3YDVKdUNDQhmKop/L5fxEc
	Adh3JEo07GRExsccqe4OORP0/3CWDeZL5LXGaV7QRE9LcY0xZ5u8qn6PGE7bXtoQcebQ9Dlg1CJ
	2fKBhfHHQ0GKchLLrig+r3Y1Vin4YYtAugosVlVxrSc5K4HaCKWhK07Mxkn+9zHW/37NaYTnTya
	47Gkh4O4l0oPrDq6bb4ZP2n1l5BbB8XYdmaPD6URe/fKLNw/xACbzzOlrD9
X-Google-Smtp-Source: AGHT+IHDvByBOPVYHIM7/SpMKaHb9J7qIjNeZ2MsVhMaPnXi82oD7w6a2DPK+veb6OO14N7/6t0e3oYgls0HP9mG/KM=
X-Received: by 2002:a05:6e02:1a42:b0:430:b338:e55 with SMTP id
 e9e14a558f8ab-430c53068c3mr258026025ab.29.1761044563024; Tue, 21 Oct 2025
 04:02:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0435b904-f44f-48f8-afb0-68868474bf1c@nop.hu> <CAL+tcoA5qDAcnZpmULsnD=X6aVP-ztRxPv5z1OSP-nvtNEk+-w@mail.gmail.com>
 <643fbe8f-ba76-49b4-9fb7-403535fd5638@nop.hu> <CAL+tcoDqgQbs20xV34RFWDoE5YPXS-ne3FBns2n9t4eggx8LAQ@mail.gmail.com>
 <d8808206-0951-4512-91cb-58839ba9b8c4@nop.hu>
In-Reply-To: <d8808206-0951-4512-91cb-58839ba9b8c4@nop.hu>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 21 Oct 2025 19:02:06 +0800
X-Gm-Features: AS18NWCp3gMZ-vHw7hgTUJk16mOhgcBAjCX7S1cJLh5bN_2YLJL2QzmYE9tiq-s
Message-ID: <CAL+tcoA0TKWQY4oP4jJ5BHmEnA+HzHRrgsnQL9vRpnaqb+_8Ag@mail.gmail.com>
Subject: Re: null pointer dereference in interrupt after receiving an ip
 packet on veth from xsk from user space
To: mc36 <csmate@nop.hu>
Cc: alekcejk@googlemail.com, Jonathan Lemon <jonathan.lemon@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
	Magnus Karlsson <magnus.karlsson@intel.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	1118437@bugs.debian.org, netdev@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 5:31=E2=80=AFAM mc36 <csmate@nop.hu> wrote:
>
> hi,
>
> On 10/20/25 11:04, Jason Xing wrote:
> >
> > I followed your steps you attached in your code:
> > ////// gcc xskInt.c -lxdp
> > ////// sudo ip link add veth1 type veth
> > ////// sudo ip link set veth0 up
> > ////// sudo ip link set veth1 up
>
> ip link set dev veth1 address 3a:10:5c:53:b3:5c

Great, it indeed helps me reproduce the issue, so I managed to see the
exact same stack. Let me dig into it more deeply.

Thanks,
Jason

