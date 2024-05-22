Return-Path: <netdev+bounces-97577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6862E8CC2CC
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 16:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 832FA1C21C8D
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 14:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686E713D53F;
	Wed, 22 May 2024 14:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4fGAVY5T"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE420824A3
	for <netdev@vger.kernel.org>; Wed, 22 May 2024 14:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716386957; cv=none; b=Ln4jlHQWzyC9hS48rl8ujsL5MkxA0xsOw7b2eibaSHigWg3SwKXvtESiNTGI9A+1LCeB2bWe/8P3FLagUfgC+iR/8Ib+xtCEyK9Tp+8dg1cMPbpmSqJiviTH5LQWWnbP4ss4MHuN6D3xNQjl6wm6JVTA0ZQFB7tAYrAv3LQbhHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716386957; c=relaxed/simple;
	bh=//MPE+3V0J2zuwxv5AuAp84TbmgJZbrdV+0koeMmzIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z12EFwS6g+jyz6Rp+Hcr+VlLLrobfWeoI/CtW9G6tNIShdgm70kJc5Ypz8O4quXpbujwPUQhOP61UqQAM0FshJG4DrNRNUr27DySPjxNXuH/f3a9mFMcBlNzIXRYm6v0vVGxxkbGMwhP2m5sqweCmx9gDpgEdWOvGjer9HZpsNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4fGAVY5T; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6f72b8db7deso220800a34.2
        for <netdev@vger.kernel.org>; Wed, 22 May 2024 07:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716386955; x=1716991755; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GJPEjFP7TW5C+mBX/q015rve2sh8znZ2+/1K/ZoRYuc=;
        b=4fGAVY5TGK6SdW0XKQxCb3WdUQ38vvhUnjq7VllHAdRICRDPh0EnNQC1q0kLT5sn25
         i3J1lSXIagydvTkrcIn0QphJaXmIjWI3MZ+d5PyKGX/cyk+oYNkQ8MtwbU1Fz1tnazJS
         fWgN17FVhFIVlR2Ye9hFZJKVI/sdm1f0WwAqSRsxNK9dr9oeU6Vd9eN9gJxaztz7HWZr
         fNFe6fB1Ll8kEYCW/PbeDS7IFKFJn+pdaPuMGkFcWQVJy+nm1pxvk6kR6Cdb+zPEQg52
         Lb5H1P8dEuf7ZqojZ28+xRO7Yatd0ZJj8IrlM2V+EMSNabW6IkDlkop6fH5BTc056vGo
         4qPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716386955; x=1716991755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GJPEjFP7TW5C+mBX/q015rve2sh8znZ2+/1K/ZoRYuc=;
        b=CO/zTcm7yQSBf7hpyg2wbNBruuR+KuS3zxLH9/npn+coHhGv+zHS7ZckuyHNAqYEPy
         bEJCp0AUyaOn/c8yJJBSIpA1HkENYv0vv9WXpQ/ezxtTHe28ygaaibLP0x0bgonD/hNc
         xNny9A0dvq3s11wht1kuow4ZHqnzuxMRKNOekU3lxe+4xtkbaVT+xXBGxehh3QdB+g9s
         G+A2RA7sYJcK8Ch6vzN4/24nDHkqF1+ZebYupTqRiyz+bYo1iu1TluEXFlZr5qt2YAu6
         bdZNQUuFSoDwhaKjeDjCUDP3/4IAH1mU/a0JmWKDoCsBSSD6fGNN9os/0yAmB5sUWVE6
         V4JQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRX4v9waGYQX+hV5xA9wZiRcxGCE94OrLAnVs4Aody8i5fc0h1pPnieISRBVDV5r9+0n++zKpaFIam+ihOuqYi4DvEj01G
X-Gm-Message-State: AOJu0YwwpkrhQa9Xfh7Hauj8oJLBI8QMvAOoYwtBqB/7v4velT4eHH6G
	TmnxZN49vCw+ckYhdAVgLiwI3mmRu8B6fypV47R4rRxYTa3KqPAoe3th7Z2wBp1JEt0oOQRNZHa
	xEf3eL/gdzmNYJw4P9l5C75DhLuCh6g0US6oUXxIwFZn7aJh6vq5cMFM=
X-Google-Smtp-Source: AGHT+IGDoW8utOykclz5LxCrBH1XSflIVdVqu+B1dwAHZST8+8lDRfekwwfbPMtpfuOoOGwOuLXH+Y9LAH7Md2wPAGI=
X-Received: by 2002:a05:6870:718d:b0:240:eab9:1635 with SMTP id
 586e51a60fabf-24c68a4ed81mr2276468fac.21.1716386954736; Wed, 22 May 2024
 07:09:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240521134220.12510-1-kerneljasonxing@gmail.com> <CANn89i+ByJ5S2y_M86fG5v2cSYsfaXH4=JL+Y0FMRNpHDSijdQ@mail.gmail.com>
In-Reply-To: <CANn89i+ByJ5S2y_M86fG5v2cSYsfaXH4=JL+Y0FMRNpHDSijdQ@mail.gmail.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Wed, 22 May 2024 10:08:54 -0400
Message-ID: <CADVnQy=32DFjoM+yYbVcSc3G3QWcsgtad0K23zurzoOo1HP7cQ@mail.gmail.com>
Subject: Re: [PATCH net] tcp: remove 64 KByte limit for initial tp->rcv_wnd value
To: Eric Dumazet <edumazet@google.com>
Cc: Jason Xing <kerneljasonxing@gmail.com>, dsahern@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, davem@davemloft.net, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2024 at 2:52=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Tue, May 21, 2024 at 3:42=E2=80=AFPM Jason Xing <kerneljasonxing@gmail=
.com> wrote:
> >
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > Recently, we had some servers upgraded to the latest kernel and noticed
> > the indicator from the user side showed worse results than before. It i=
s
> > caused by the limitation of tp->rcv_wnd.
> >
> > In 2018 commit a337531b942b ("tcp: up initial rmem to 128KB and SYN rwi=
n
> > to around 64KB") limited the initial value of tp->rcv_wnd to 65535, mos=
t
> > CDN teams would not benefit from this change because they cannot have a
> > large window to receive a big packet, which will be slowed down especia=
lly
> > in long RTT. Small rcv_wnd means slow transfer speed, to some extent. I=
t's
> > the side effect for the latency/time-sensitive users.
> >
> > To avoid future confusion, current change doesn't affect the initial
> > receive window on the wire in a SYN or SYN+ACK packet which are set wit=
hin
> > 65535 bytes according to RFC 7323 also due to the limit in
> > __tcp_transmit_skb():
> >
> >     th->window      =3D htons(min(tp->rcv_wnd, 65535U));
> >
> > In one word, __tcp_transmit_skb() already ensures that constraint is
> > respected, no matter how large tp->rcv_wnd is. The change doesn't viola=
te
> > RFC.
> >
> > Let me provide one example if with or without the patch:
> > Before:
> > client   --- SYN: rwindow=3D65535 ---> server
> > client   <--- SYN+ACK: rwindow=3D65535 ----  server
> > client   --- ACK: rwindow=3D65536 ---> server
> > Note: for the last ACK, the calculation is 512 << 7.
> >
> > After:
> > client   --- SYN: rwindow=3D65535 ---> server
> > client   <--- SYN+ACK: rwindow=3D65535 ----  server
> > client   --- ACK: rwindow=3D175232 ---> server
> > Note: I use the following command to make it work:
> > ip route change default via [ip] dev eth0 metric 100 initrwnd 120
> > For the last ACK, the calculation is 1369 << 7.
> >
> > When we apply such a patch, having a large rcv_wnd if the user tweak th=
is
> > knob can help transfer data more rapidly and save some rtts.
> >
> > Fixes: a337531b942b ("tcp: up initial rmem to 128KB and SYN rwin to aro=
und 64KB")
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
>
> Reviewed-by: Eric Dumazet <edumazet@google.com>

Acked-by: Neal Cardwell <ncardwell@google.com>

Jason, thanks for the patch!

neal

