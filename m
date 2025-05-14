Return-Path: <netdev+bounces-190309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A43BAB627B
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 07:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6463586577A
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 05:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46211F3BB5;
	Wed, 14 May 2025 05:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NbdBu3W/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDFB13D539
	for <netdev@vger.kernel.org>; Wed, 14 May 2025 05:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747201384; cv=none; b=BSIYfa5yyM/SUXaUEtIwwCyoEyZplfG85r1PbKEMBMRtFEqxFIH5TlpEM6fVYzoTQ2deAbvuwOcwvS3Tn41D5KGnbjZqpr0yZOEAnKKc6jz5JsVrmNk974U/i6l/FLNelUvEH7NDs4hnAslTEtFKO3+e5x0r2diJejArTa6/knk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747201384; c=relaxed/simple;
	bh=cp/o4QRIMFelBcMg+GCMRzJc7wIQJrVUuC/VGCEys4c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UW1BHB94KwbTBim6aIrNThXZ5MjLVo+yNdCcPOHaVPd9AgmLfmeJdFXP6KBxx/4jgTsodSlsZigu0F+xtmqKpKUyM5to5WMXkp65zfYJKgpK4gh1prvd9BGuLO2pcO70eZW70SwWG7+7HuBq18/EQUXl1ZycPHiS5v7Nv2mmfTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NbdBu3W/; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ad4d5bb4d0eso316249566b.1
        for <netdev@vger.kernel.org>; Tue, 13 May 2025 22:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747201381; x=1747806181; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5FK/k0gp0l3olUFLrP7RHmq1plQlJu4ZSk5ZDkm9Ku0=;
        b=NbdBu3W/+iexT6+OoNMH4P7R7qiIHIxE20joQlwpW8tQipMcugP3AVWCqRcSzaaDA8
         wcTnvPfHCQvEO+0btA+FPGreSVG/ZfoIaUUq2obNgZa6XpTumIW0ARJLibfxHIkQZ4uA
         h0KbAJaO6kR4JlLrMtDLHaOk350JEiVNRBqIBFWAwokSP1Vepb6627C3k804I0dfoxFh
         vhvQRehFT6a+Gq/G9xZvWK+bnRtYHKI9jeyMeBId43W2ZN9TSmQPI2LCY5p8bgMSL/GN
         3YKU/O04fcmmIk/4flyPLkrKYH/UGOMwTI8NWMnQpVHlmiCbdMHqXFPF7qYNqBREnqJE
         CwbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747201381; x=1747806181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5FK/k0gp0l3olUFLrP7RHmq1plQlJu4ZSk5ZDkm9Ku0=;
        b=OsJd5SX5xiHadifDqhFFTaIog3odwNLyRzTlT1JnPWaHAWvWwAWkft2WEym0eG8vyr
         q1Wl7ekfduQf/9/9wC6KZJOU22HE1o7zXmxyuTp3bUo7JVYTIl0fw2j3l7G13Xspu1+u
         +Ux0x2a77EqHLcj/xUYOMKxCQdGNRccat1xwLyIKLls9jnWWeYmvmtOSfMrjG0tythEE
         ftqKADH1wEcAMFByOnzek9Hq7NbJvmgR0tKXXiV0Gv/WKcCEQUHIgRlkuYrzJ97tflFX
         pFpEDAlgRkjcZ+2MMqNkc197Es1yUa/zswjDloox+1VKx+uzl7Q1OO3D4EIUI4vV2WQ5
         ILgg==
X-Forwarded-Encrypted: i=1; AJvYcCW/oTWGX8Zjg0odzEYT+5ezkLugt6SJS8KnzPPBcdwuPjS7//G42MbHKWzN5r/ZXJlAtRPmidE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZzsXoyd+oN5XuAgHzEMk3gvWqwpqIUZdJ+bYceCTdpkMR/KNm
	3iLdDk/0q9Pmmf8synw361h4CYL9ypg0zUkMaxedV3+AspTMfYOkIn93YdGtsPeyCRWDl0ocz1Z
	fM7jqJIuBdHu6EB/pzECZV0Gz0Ds=
X-Gm-Gg: ASbGncunoVl70DAYzRVAWzAJ12ocKw+2JiexxgYkN4w/dZ6gwdXaOA4TqX/i8En7zoX
	/hAOVAi4cFibZv2oNHQ/jhBJ2oXTuCmZ1qHX2jpv8hxnrqW4PSgOTHFntHrW29gy6vSgpjrQVPh
	e09UsC/BBraYjcnJwTUakBpdmRvTbj7sU2uQ==
X-Google-Smtp-Source: AGHT+IH6eglgXbF1Nx/oip8PhNgaw92niGOIZWoTUsHWbeq7ORu30ara9gG/y7vIz4SbmtpD78+dUJHl6VyvPDop5Nk=
X-Received: by 2002:a17:907:168a:b0:aca:d560:d010 with SMTP id
 a640c23a62f3a-ad4f7565b8bmr193327266b.49.1747201381268; Tue, 13 May 2025
 22:43:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250512084059.711037-1-ap420073@gmail.com> <20250512174442.28e6f7f6@kernel.org>
 <CAMArcTXOS4z6v5c2JCdAVg0RKjnoovrftx=cjt-09RXp29NW3Q@mail.gmail.com> <20250513073016.2ab40a90@kernel.org>
In-Reply-To: <20250513073016.2ab40a90@kernel.org>
From: Taehee Yoo <ap420073@gmail.com>
Date: Wed, 14 May 2025 14:42:49 +0900
X-Gm-Features: AX0GCFvIr6ngT3-uT7XG5PY-7ZRkl7_PfhPx50lTrMZJwmYFvJSNsF0qbbS6yJE
Message-ID: <CAMArcTVssM7bc6jQWnbBri1ttzRU7GvK8egJ7Ff27iRv3ehSSQ@mail.gmail.com>
Subject: Re: [PATCH net v4] net: devmem: fix kernel panic when netlink socket
 close after module unload
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com, 
	horms@kernel.org, almasrymina@google.com, sdf@fomichev.me, 
	netdev@vger.kernel.org, asml.silence@gmail.com, dw@davidwei.uk, 
	skhawaja@google.com, kaiyuanz@google.com, jdamato@fastly.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 13, 2025 at 11:30=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Tue, 13 May 2025 12:24:52 +0900 Taehee Yoo wrote:
> > > On Mon, 12 May 2025 08:40:59 +0000 Taehee Yoo wrote:
> > > > @@ -943,8 +943,6 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb,=
 struct genl_info *info)
> > > >                       goto err_unbind;
> > > >       }
> > > >
> > > > -     list_add(&binding->list, &priv->bindings);
> > >
> > > Please leave this list_add() where it was.
> >
> > list_add() is moved to net_devmem_bind_dmabuf() by this patch.
> > So, you mean that let's make net_devmem_{bind | unbind}_dmabuf()
> > don't handle list themself like the v3 patch, right?
>
> Not exactly like in v3. In v3 list_del() was moved. I think these moves
> are due to cleanup which I requested earlier? There is no functional
> need for these? I'm giving up on that cleanup request for now.
> Let's leave the list modifications where they are.

Thanks, now I understand.
I will make the next patch only fix this issue and drop the
cleanup changes.

Thanks a lot!
Taehee Yoo

