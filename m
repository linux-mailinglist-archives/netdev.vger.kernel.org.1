Return-Path: <netdev+bounces-137972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE5E9AB507
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 19:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98B59B24478
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 17:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189151A726D;
	Tue, 22 Oct 2024 17:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GNizuojj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5599D1AFB35
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 17:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729617947; cv=none; b=Xve415Eyu10LD1SsEQICSfR+WPe9VAJ8TEXM+SeAFfh7McBcQHsvcy9SEQTpjz4ZgTYnA4CWhB4t8rlFi0Al5CsZNg6L9R7iuvBkM4Ahv/aHWaXEhab3CJY1zY9s9VkMqYZFFtTWV6J/5vTasBB/5eh3AVMQssbgTKgoUuHAWCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729617947; c=relaxed/simple;
	bh=7Nhx76gxc6F6eiHMaboNs7DBV9o2hRoYZzo0Ch79DfE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P3FpTS3RHerqKpLaxbkM3/B37O9gJQ5/ToH1wYY6dpNKHxY9/4CuqgC3JfQIo1+QcvExCqZZP13xzlm/bBHmb1wbmF2KPZsuABssyH5O/CWJmh4H0KBM8etLH0rkNNfJh3K9vZRH74mrW0SH9NYLfubkhukVSvxFXlkOftoAG84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GNizuojj; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-37ed3bd6114so2890295f8f.2
        for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 10:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729617943; x=1730222743; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8hSaLvXn0yFSyVHQRsC6QU/aD2ssRpmAbQU7NlsTtv8=;
        b=GNizuojjDavfvqlT4ISFrJa2aMMETZIbDm/jyE4/yEHzs0TLm2E1iN9RjwgcSRSIxp
         PhGHrpb1gY0epRWrFVMYA18IixJ1lPl4WQ8o0CX93i11vzJ2A0C/qs9nLf6J//wWPe/A
         BFwZcQB4b/cAIQxJ4SrKmZX2OhZhwJywTKoQ1x/EhnZ/nml53XBgx2EY2GLFCdg9J9po
         xi1nSUCqDAOwDfX+RtB6MhdTugd2yCo2VUuTOfGU9xKzV7JS/GNqfePAZjsJ+vbDyElB
         dInOuTr3NcDcnsDL8ngR6LMQldF2syIq+lAYyM2mYPAZKYM8K8AF3SpHBYEOXxmRUz2x
         M7OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729617943; x=1730222743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8hSaLvXn0yFSyVHQRsC6QU/aD2ssRpmAbQU7NlsTtv8=;
        b=Aw8XW/HHPIKvPNJRx3uOzOv8Ns8QryM6eytnLBQiWjlJEiTgb8C0tt05IcFCgyVahQ
         Jf+NVeQfqWOZQZw3ngtHYfw2P8b0qVevgpaPPKLFld577XB1jAMj1CtBgU9r0TW6W4O0
         NAh2iNX2EDNOHk6W62qnpxct0CAFc10Fecx5+PSH+gX79Lb9nbjRLC7PvZhsX0vSO4S4
         /DrUcGQso/f0EJPUjrEd9hW1ZoIQHq2JDBFmTgNTyvMaj1ynSNAufVuR+KcK27fN7cp6
         cW5ERuqT2GHJ+K/Uv4beRdewydlBfaq6mcMUYy+RXrc0kMEA6W3CUfBJ4CwgFBHCGKBE
         CBUw==
X-Forwarded-Encrypted: i=1; AJvYcCW/ColGhUMwjBkjBlRS3rPyLHGsMF4ZC6vLuN8qqroDqBeUdMcC8jX/yKk9lK3uU1ZTR1Gp2eY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuRQ5HidXUMkItAE9WiRw4wLNC+pIsKe1AijB9PtTyUk93dKAS
	93DLgOHgKaVtmWwkeLtCXgMgKgrFuNUEVmb6Jfy9c2sQUu4EMIz6Wdcy6aMbC9NqmrTuzO4xC/J
	oFkNp+kTBZ1viuNDIcXpAZxw4W74=
X-Google-Smtp-Source: AGHT+IGxopSoSXyvwbJ6SKHOpDdmPOBrDcSJm2a7wqW79AZWdLvLfWKswYFr8bJMo2INs1l8UXbKTnIUlZkgiBLm3/w=
X-Received: by 2002:adf:ab03:0:b0:37d:5103:8894 with SMTP id
 ffacd0b85a97d-37efb7f7abemr186717f8f.42.1729617943335; Tue, 22 Oct 2024
 10:25:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022063807.37561-1-yuancan@huawei.com> <20241022155630.GY402847@kernel.org>
In-Reply-To: <20241022155630.GY402847@kernel.org>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 22 Oct 2024 10:25:05 -0700
Message-ID: <CAKgT0UdvnjZo6pNtnZuDFuOQ9Hg=BCeJOAiToS_CFSwpKD8LWA@mail.gmail.com>
Subject: Re: [PATCH] igb: Fix potential invalid memory access in igb_init_module()
To: Simon Horman <horms@kernel.org>
Cc: Yuan Can <yuancan@huawei.com>, anthony.l.nguyen@intel.com, 
	przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, cramerj@intel.com, 
	shannon.nelson@amd.com, mitch.a.williams@intel.com, jgarzik@redhat.com, 
	auke-jan.h.kok@intel.com, intel-wired-lan@lists.osuosl.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 8:56=E2=80=AFAM Simon Horman <horms@kernel.org> wro=
te:
>
> + Alexander Duyck
>
> On Tue, Oct 22, 2024 at 02:38:07PM +0800, Yuan Can wrote:
> > The pci_register_driver() can fail and when this happened, the dca_noti=
fier
> > needs to be unregistered, otherwise the dca_notifier can be called when
> > igb fails to install, resulting to invalid memory access.
> >
> > Fixes: fe4506b6a2f9 ("igb: add DCA support")
>
> I don't think this problem was introduced by the commit cited above,
> as it added the call to dca_unregister_notify() before
> pci_register_driver(). But rather by the commit cited below which reverse=
d
> the order of these function calls.
>
> bbd98fe48a43 ("igb: Fix DCA errors and do not use context index for 82576=
")
>
> I'm unsure if it is necessary to repost the patch to address that.
> But if you do, and assuming we are treating this as a bug fix,
> please target it for the net (or iwl-net) tree like this:
>
> Subject: [PATCH net v2] ...
>
> > Signed-off-by: Yuan Can <yuancan@huawei.com>
> > ---
> >  drivers/net/ethernet/intel/igb/igb_main.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/et=
hernet/intel/igb/igb_main.c
> > index f1d088168723..18284a838e24 100644
> > --- a/drivers/net/ethernet/intel/igb/igb_main.c
> > +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> > @@ -637,6 +637,10 @@ static int __init igb_init_module(void)
> >       dca_register_notify(&dca_notifier);
> >  #endif
> >       ret =3D pci_register_driver(&igb_driver);
> > +#ifdef CONFIG_IGB_DCA
> > +     if (ret)
> > +             dca_unregister_notify(&dca_notifier);
> > +#endif
> >       return ret;
> >  }
> >

Makes sense to me. I agree on the "Fix DCA errors" patch being the one
that is being fixed. So essentially this is a notifier leak since we
are registering it but not unregistering.

Thanks,

- Alex

