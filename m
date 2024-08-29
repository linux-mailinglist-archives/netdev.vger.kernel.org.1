Return-Path: <netdev+bounces-123069-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1EE096396C
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 06:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 963101F23EEE
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 04:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AEA91459F6;
	Thu, 29 Aug 2024 04:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="lr4ujlW7";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="ThoSdptK"
X-Original-To: netdev@vger.kernel.org
Received: from mx-lax3-1.ucr.edu (mx-lax3-1.ucr.edu [169.235.156.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E706145341
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 04:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=169.235.156.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724905844; cv=none; b=S8n8doyFPCDdjxvfq0d6WLPIIBf/HtA5FxkkHquhKd92mfn5Mi/SrgJQSR96MjSO1/odGyBfyECrgK7BrLz5Niw7v+nYLroGAkNJpFFSxW5GN+mZfXxPuxfEax9kKhlXOMwDvr0KYciwbVGCxBN0T5/PykdyHIT4r2kbczRFuZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724905844; c=relaxed/simple;
	bh=Hm8X6G7US76DjH1BlXkmp5j9VJxJk6hQZ6v/aVdZfiA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YHwyNExFjr6VagTefoXo9T4kUp1aXCrrUTlKP+wHWcuXCThERMb0ERq+0yveOhmcBnW+jKlMgn4QxXmDZDJcj+XxlyBfN4m3P7wgIp1gHXnDU+l77OEdxAtZE0kWt5vrBB4NrcYFZWNzXa5H0otv2jKLkFPLdQ3orO2qKRMZ6jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu; spf=pass smtp.mailfrom=ucr.edu; dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=lr4ujlW7; dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=ThoSdptK; arc=none smtp.client-ip=169.235.156.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1724905842; x=1756441842;
  h=dkim-signature:x-google-dkim-signature:
   x-forwarded-encrypted:x-gm-message-state:
   x-google-smtp-source:mime-version:references:in-reply-to:
   from:date:message-id:subject:to:cc:content-type:
   content-transfer-encoding:x-cse-connectionguid:
   x-cse-msgguid;
  bh=Hm8X6G7US76DjH1BlXkmp5j9VJxJk6hQZ6v/aVdZfiA=;
  b=lr4ujlW7INoQZwFd4BIwabUcjIKsVsYyW4Qnr21BWGaEnBJCvmusCN4W
   oEntWvcILNI/H+usb8Py0tS9ZPqdbbLL24tX04KsZy7C5T79NkPWoR8Mc
   I936pvQAUIzJvHBqCaB8SwNiLfdtrwG7qk2CURaPWZBNoC20MXjQdDJYD
   C9QuSvsuVOXgCll3pMMh7noqGSXz3nOtbAAZyBJN0eHrBNRpTxptjIaoz
   BLvezQyT+fx+yyheEgw6JwQZEH1AhP7Fl+9Qda71w/LxBpZvJa9noTbzC
   K25HDKXe0M3ABsKwd47J2e++Q4EB54jGEVIWGy82OVO4NJx/uDA7sQKr4
   g==;
X-CSE-ConnectionGUID: eR8TN9DXQ+mjfwCS9fY7XA==
X-CSE-MsgGUID: 833iVZKPRq6ew01G8Nz7hw==
Received: from mail-il1-f198.google.com ([209.85.166.198])
  by smtp-lax3-1.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 28 Aug 2024 21:30:35 -0700
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-39d5537a62dso2488695ab.2
        for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 21:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1724905834; x=1725510634; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dihk3etWk++rvq6e35hR7jF9/0aw2VkPe9Rvva2gqnA=;
        b=ThoSdptKzuerrehahMwcfSitbKdbUq5w9XwhAWOwb0hOVERjzLxqKJXlwtODsc9HwO
         akdev3IvSgpBTvensKy/kAVOciJQf/T14ksXQwKOKAlax7iCGuMzJAFcIuw9VdezNExX
         71W9ew6/oZdhygbru6XXgtKh9JcRvZmhTh8ls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724905834; x=1725510634;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dihk3etWk++rvq6e35hR7jF9/0aw2VkPe9Rvva2gqnA=;
        b=Gu4sHym2OV8jGXYVgFoFmPgATK7LJc23dl2lHfMkZ9vsHHhQiOLJc7g8aVBkhR3tG9
         sLr8OyKaRP1kE8WGATrtczcPDoBuhEpnM7nJlTp0sRMaMzq6uIRJIKkRG6Aq05BXpIs1
         HAeY3gjvNmvQBTR9/tXVXVRPcxOd/12pDDDOpgitp/PBEy7++k8EhWu3pZZFjbIGW4Dc
         gpQC9vTlF+ut2M0KBN5SBkSIYjYfYwFWWi2gEpNfCLLm0L3euuxY/ucncxJmh4nmNOMc
         F02UxTertEWa+srcgy6KCNVYbWiZnryyeCIc66Cv5jgTpnqutmkh7u2V0/7sCHbs7jXE
         A/dA==
X-Forwarded-Encrypted: i=1; AJvYcCXZSje/IrCTV8l34DkM7XJylWgmmXL+SIIDh8Nsw/kfjldhMIgNwmAAZifu8QkpoZZOy9oNJLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEIIZwx/b+pSRHFEJN3M35rpfWb+Vg9hkKJ39lA/in6DiHPvgi
	c9LTYHXHe37kqyCi98jfXs5cjUHOXo6W3McOyc/JKQcAMdIYjhtEjlM4qFtf6bm0MZO333Hdi1l
	oVazOjdmPVkIH9VNvDVOFYmTOL2oOfHIGtoYolApc9LtZSKDTz2Q2ft8Y2C/DIUitPl+a1ogyfC
	uXx14j7unmCqCL43jKLc2G+NfGpLsVJA==
X-Received: by 2002:a05:6e02:1607:b0:374:a781:64b9 with SMTP id e9e14a558f8ab-39f3780c6f7mr24796705ab.13.1724905834306;
        Wed, 28 Aug 2024 21:30:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQ8G4yBQZl8uMVmbjN2GKvaVb134BrRd4Eeb8qtEDfsvzBlguVr1+MIJ/adcXERyfRH9HRB6shu5q79ziNrk0=
X-Received: by 2002:a05:6e02:1607:b0:374:a781:64b9 with SMTP id
 e9e14a558f8ab-39f3780c6f7mr24796515ab.13.1724905833918; Wed, 28 Aug 2024
 21:30:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALAgD-7C3t=vRTvpnVvsZ_1YhgiiynDaX_ud0O6pxSBn3suADQ@mail.gmail.com>
 <13617673.uLZWGnKmhe@bentobox>
In-Reply-To: <13617673.uLZWGnKmhe@bentobox>
From: Xingyu Li <xli399@ucr.edu>
Date: Wed, 28 Aug 2024 21:30:23 -0700
Message-ID: <CALAgD-7AOA0At+y0BR2MZ0WXPFM03tQneRbeGZQqiKy6=1T0rw@mail.gmail.com>
Subject: Re: BUG: general protection fault in batadv_bla_del_backbone_claims
To: Sven Eckelmann <sven@narfation.org>
Cc: mareklindner@neomailbox.ch, sw@simonwunderlich.de, a@unstable.cc, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	b.a.t.m.a.n@lists.open-mesh.org, Yu Hao <yhao016@ucr.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Which line would that be in your build?

Somehow, the bug report does not include the line number in my end.

At the moment, I am unable to reproduce this crash with the provided
reproducer.

Can you reproduce it with it?

Sorry. The above syzkaller reproducer needs the additional support  to run =
it.
But here is a C reproducer:
https://gist.github.com/freexxxyyy/0be5002c45d7f060cb599dd7595cab78

On Sun, Aug 25, 2024 at 9:24=E2=80=AFAM Sven Eckelmann <sven@narfation.org>=
 wrote:
>
> On Sunday, 25 August 2024 06:14:48 CEST Xingyu Li wrote:
> > In line 307 of net/batman-adv/bridge_loop_avoidance, when executing
> > "hash =3D backbone_gw->bat_priv->bla.claim_hash;", it does not check if
> > "backbone_gw->bat_priv=3D=3DNULL".
>
> Because it cannot be NULL unless something really, really, really bad
> happened. bat_priv will only be set when the gateway gets created using
> batadv_bla_get_backbone_gw(). It never gets unset during the lifetime on =
the
> backbone gateway.
>
> Maybe Simon has more to say about that.
>
> On Sunday, 25 August 2024 06:14:48 CEST Xingyu Li wrote:
> > RIP: 0010:batadv_bla_del_backbone_claims+0x4e/0x360
>
> Which line would that be in your build?
>
> On Sunday, 25 August 2024 06:14:48 CEST Xingyu Li wrote:
> > Syzkaller reproducer:
>
> At the moment, I am unable to reproduce this crash with the provided
> reproducer.
>
> Can you reproduce it with it? If you can, did you try to perform a bisect
> using the reproducer?
>
> Kind regards,
>         Sven



--=20
Yours sincerely,
Xingyu

