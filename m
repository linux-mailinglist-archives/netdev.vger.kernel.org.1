Return-Path: <netdev+bounces-70139-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FEE384DD0B
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 10:35:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 425DC1C239A9
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 09:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A239F6BFB2;
	Thu,  8 Feb 2024 09:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="25vftL2u"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2A66BB42
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 09:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707384909; cv=none; b=ctciHeWbX8WEABH+VAU90oaNJTCTF5KO8TfkUhAwiSz/rQimwdSNqDZ2psSCtEv74TPCkrA8fAZ+oVZDoc17FoqfhJ1+K7TzrK8neoOROQxk/9xNnafQSdChBUn2bakSebP7J3vjsPnlVIV25SID2eifHm4ps8v5aK46ObyrqCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707384909; c=relaxed/simple;
	bh=PL4bURsXss2T7/h04cdjZreNU22ZlKTVyPSJ+8zE40c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EBNIx8zVp+HwTL24HR1ZYyyJc7z+Hk5baaLkENy80/EwiIyrZjuBTilU7h9fIoqAKxlpHxu8k9KC1acGbx5UhAoj9I7bZZC3bCINJLPO+4HlIeNpleK+oAKtyggnv8lbQhlIZUEDmiegq9I1J42N1PB0y5XBubRtRx1X7FXKQfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=none smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=25vftL2u; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=daynix.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5116ec49081so382046e87.2
        for <netdev@vger.kernel.org>; Thu, 08 Feb 2024 01:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1707384906; x=1707989706; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8o7bUDuGuu2YaKsxQ+9DhHSbmvO5ysjRunyhwVyAC5o=;
        b=25vftL2u489vuD0qEkL8zYrgDNocyALeu8iRRrS+EBV5H/Wa76XA2SWCZywpvkFrss
         21dGwNjDQAH/O+mhYIyHadweU7te0FolLEhuJuOnDAg8rws4eJGGgelDxHWsnh0qEo8y
         mU8iyuL8Q0R5EBEDPte5a9eO0QBUt8jM0zQLh0hSKecymXyofWTAouvOJmlxz8uGwhb1
         Z6yo3Z+H6aIAX6RQzSEbXfhlQ7CXtgZLTeWTBs99K7smDKBk0l0/4g6NlFmt3RCp2u94
         yYGAWzILL8qRa4OcIxCBIMiDdchAX58Hm/NVU/wPAL2hNjYjznL8UNYsyBP8m7uY/D9t
         Vcdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707384906; x=1707989706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8o7bUDuGuu2YaKsxQ+9DhHSbmvO5ysjRunyhwVyAC5o=;
        b=Z9Q453skeUR+GBg+AnY543/JPaPHNXAOJN3yjJiJvCpKZqj6131ODQczBfw3ITMqfP
         sdfqZvxq3iAdO400mDdQQvfVJpwvE8+r1bHDHLtcnO4aC2huH9YtMuR5LFHMpWI9CtUM
         Mgp4jJV3n/wApdbOkSzkRJYQgfTUR4rTppTq5exfY7tEGcOZaWxapJxC61wnyhZ05Xdq
         Q4RqGkHAOzjVN7JGUNUtcoAz2waMy/88bdPztrCOFUWlcLeTtpFwSmXH98GnhYIneuls
         S1qhu7cs6eDDCMy+bY9FLiCRavDvU716APXWEzpp6PCIBkQIQSprblJ9PBv51/+yW+cZ
         Pymg==
X-Gm-Message-State: AOJu0Ywd+YFcDIKx47UzZg2hFmP/f+CammkPk4cP9dDJOQ1B8EwmC3Iw
	bpcDZgk2JitcL1KKj74WrS1RfD87iR7D0f5Rr/I/OAQ2TCWE67AU2DWDr+PmluNM/Z/KG7d9Iho
	FCzt8Yk7b18ho66H2vX75/OymPa1ip/OuZJiuMA==
X-Google-Smtp-Source: AGHT+IEoQSQjo9erO6Il084RgQafaf4DUGfU2yCLEOnMeOlg/r958bA/YMsX95xq7vDLb2BC2YRvJwvjNWwiPA+eBhc=
X-Received: by 2002:a05:6512:3c88:b0:50d:f81e:6872 with SMTP id
 h8-20020a0565123c8800b0050df81e6872mr8479864lfv.10.1707384905935; Thu, 08 Feb
 2024 01:35:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240115194840.1183077-1-andrew@daynix.com> <20240115172837-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240115172837-mutt-send-email-mst@kernel.org>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Thu, 8 Feb 2024 11:34:53 +0200
Message-ID: <CAOEp5OfKUs+Q+Nq3YywYR=oihSw8Nr=jYSC6a7CN1MTMzJVtHQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] vhost: Added pad cleanup if vnet_hdr is not present.
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Andrew Melnychenko <andrew@daynix.com>, jasowang@redhat.com, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, yan@daynix.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Just polite ping

On Tue, Jan 16, 2024 at 12:32=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Mon, Jan 15, 2024 at 09:48:40PM +0200, Andrew Melnychenko wrote:
> > When the Qemu launched with vhost but without tap vnet_hdr,
> > vhost tries to copy vnet_hdr from socket iter with size 0
> > to the page that may contain some trash.
> > That trash can be interpreted as unpredictable values for
> > vnet_hdr.
> > That leads to dropping some packets and in some cases to
> > stalling vhost routine when the vhost_net tries to process
> > packets and fails in a loop.
> >
> > Qemu options:
> >   -netdev tap,vhost=3Don,vnet_hdr=3Doff,...
> >
> > Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
> > ---
> >  drivers/vhost/net.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> > index f2ed7167c848..57411ac2d08b 100644
> > --- a/drivers/vhost/net.c
> > +++ b/drivers/vhost/net.c
> > @@ -735,6 +735,9 @@ static int vhost_net_build_xdp(struct vhost_net_vir=
tqueue *nvq,
> >       hdr =3D buf;
> >       gso =3D &hdr->gso;
> >
> > +     if (!sock_hlen)
> > +             memset(buf, 0, pad);
> > +
> >       if ((gso->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) &&
> >           vhost16_to_cpu(vq, gso->csum_start) +
> >           vhost16_to_cpu(vq, gso->csum_offset) + 2 >
>
>
> Hmm need to analyse it to make sure there are no cases where we leak
> some data to guest here in case where sock_hlen is set ...
> > --
> > 2.43.0
>

