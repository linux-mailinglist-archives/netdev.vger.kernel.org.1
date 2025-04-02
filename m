Return-Path: <netdev+bounces-178705-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A230CA78572
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 02:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 627A07A4699
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 00:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6AFC367;
	Wed,  2 Apr 2025 00:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ezxme/WU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415EFAD24;
	Wed,  2 Apr 2025 00:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743552739; cv=none; b=bawVQmVxXv6RW20LLABDjUVMRgA7wmVVXnXP+vxo1ATjaKxwMz6I41/JWqTxh5VuuSDsJgaN3GvWO5yBZ++Kl3oZ1ZoihjHPo9N2NqJDETMOI0dRtTEJpF1KdlnTPhDQg3KfULlSsw0tkEyd+HZ1nh3vUWl7DDHWxsxrw4pyKTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743552739; c=relaxed/simple;
	bh=Fx+DQA/hs6/5nL3RaXhlTNOvDv86/gbuzKWDELxxTaA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QTg/yjiHFfxrX4rT6QjKmQkT0iyFXEoWdQpwGQWzNCwYnqXpgRzLL8IXGqaNFiXcZ6EioVvaT9ZnIAJmiaqJHeiuWcTCPpySX0NilUfwP05anU5iwsVznOrIJPLmWKzF2A/5o0n6xjIU2IuEqod02zvGMKrZj7ahuGluHYDeQuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ezxme/WU; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2a01bcd0143so6640606fac.2;
        Tue, 01 Apr 2025 17:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743552737; x=1744157537; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KQ1QCtwsepe633EoRp9qwqH7AZPQqB3yQI1eiOpigjs=;
        b=ezxme/WUoVpAL6FY+O+RDR+ybgbnU4rxbYdwWDRnOZnzg79Fjr+QFUkGCOQFlJihsO
         aw89zLowYU95pg+Ob2My4HHCjSS5w84OqHt1MC9usSdka6o2Zn16opIlrqjvt09j8h1R
         fUUpWvpjN6ytwToYIbx1JSGVSut5drpumofH7DkUTinNKE4hVDueObsPs+otmhhSuiNK
         cqqnYKgLNEReMdFQkLwNqdOWXFusVBJu0axeBJ/d/5W8C2lgGlXVjskC4xe1vmaJGInO
         fZcujhsosHIwPGEaUaXrU0TVDGmA4RXAnynD0m5ltnccrC67CkLaba3f25DlRWhn6Urc
         jgQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743552737; x=1744157537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KQ1QCtwsepe633EoRp9qwqH7AZPQqB3yQI1eiOpigjs=;
        b=lY59YGqEfF5vaKf8AD+SA32yf0/7JpoP/qgJByokVKiWYSFlPrmB04/UhC+foVloZV
         mBjZbogKpaIDfXMN+/qlK8NbOdj2iWPMV0OgzFXxpDRv58Un0EX20PDIrukCaSchxpis
         0dj57XOlYjtLHEVgjYrFwnzG1pjDJowSGr1opzaG09UR4J/+W37l5noJRT9W2yNCW79K
         uJIyMCFNxOxK7GDpjzEo3DpBl5JY/hwtwKI6QcH9YcqIVpAYwctrMTi5tFUVF+iRU1Gc
         jyOfwIrzDK49T6k6jvYh/jXxqLUQ9EQXHsEo1Ob0lMjol+AaRONgcQTfcVPfdn3gwqnI
         8QEA==
X-Forwarded-Encrypted: i=1; AJvYcCUDCxTjzUNxSFZU1+PPjafy3IEAY1cdT8ZnmyPuWj7yn2wPHjcByGZP/uaCg9ouK6VDSjo+ODXix3ok@vger.kernel.org, AJvYcCWoBSRz10CJVJTgTTumiyxgHH8WwTG3MPqLFPK/MHN7dh3ASj9voaxTLPdy3faQf+gN4mHaFV7VP7J8lmw=@vger.kernel.org, AJvYcCXEo1j+QMlVJopHnsGfcqGegny1qGT4HtHZrJcyAjGuKK2SqKYElQ2/j7ZUqksMVl5rhwYR85k3@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4q8MHrenqmjfVq4kn+puBv4NaLeDIZYu6kh87qEz/G8EFtP2j
	WED6hGtYZliF04MDjmJKF+6eu+c7gwmosNznpXSXMlyI5oNjuERVICVq1oxCL3wuN+siDMAsgTb
	y2ZNffs6IbPO7TgKH1f3zO3g97Zc=
X-Gm-Gg: ASbGncv0g7cDH9KwiU7RNo+uttEHE7+YYzHD5bLadPZglsOfAXYhWf9NMn2BGA7X2ED
	G5DiyafiuxAkuhHzy1eR+2Xd4NX/U7TeAQcNmbi/o0O0NTu2XGmNYccwfiNv6oIDF4L0Jvo9DnC
	ojnw+7HJfdmGw5hzRJ+nkYuYsnF6E=
X-Google-Smtp-Source: AGHT+IHOraqWJCt2syW2jgSSoa7/gYqdb1v+46ayw9NvK2danUjDUGrKwZ/0H1XbrR63kZIlFS0eLahRL1e8FFkrcx0=
X-Received: by 2002:a05:6870:44d2:b0:2c2:d47e:5702 with SMTP id
 586e51a60fabf-2cbcf41feebmr9997295fac.2.1743552737075; Tue, 01 Apr 2025
 17:12:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1743497376.git.luying1@xiaomi.com> <e3646459ea67f10135ab821f90f66d8b6e74456c.1743497376.git.luying1@xiaomi.com>
 <2025040110-unknowing-siding-c7d2@gregkh> <CAGo_G-f_8w9E388GOunNJ329W8UqOQ0y2amx_gMvbbstw4=H2A@mail.gmail.com>
 <2025040121-compactor-lumpiness-e615@gregkh>
In-Reply-To: <2025040121-compactor-lumpiness-e615@gregkh>
From: Ying Lu <luying526@gmail.com>
Date: Wed, 2 Apr 2025 08:12:06 +0800
X-Gm-Features: AQ5f1JoKCAO_qM4EgqqPFGi9tsJCNmms42uIb-8D6A1QbIT1dV1oyRWyr89hFJc
Message-ID: <CAGo_G-fiR5webo04uoVKTFh3UZaVTzkUgF2OcD8+fY-HzWCO6g@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] usbnet:fix NPE during rx_complete
To: Greg KH <gregkh@linuxfoundation.org>
Cc: oneukum@suse.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luying1 <luying1@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 1, 2025 at 9:48=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org>=
 wrote:
>
> On Tue, Apr 01, 2025 at 08:48:01PM +0800, Ying Lu wrote:
> > On Tue, Apr 1, 2025 at 6:31=E2=80=AFPM Greg KH <gregkh@linuxfoundation.=
org> wrote:
> > >
> > > On Tue, Apr 01, 2025 at 06:18:01PM +0800, Ying Lu wrote:
> > > > From: luying1 <luying1@xiaomi.com>
> > > >
> > > > Missing usbnet_going_away Check in Critical Path.
> > > > The usb_submit_urb function lacks a usbnet_going_away
> > > > validation, whereas __usbnet_queue_skb includes this check.
> > > >
> > > > This inconsistency creates a race condition where:
> > > > A URB request may succeed, but the corresponding SKB data
> > > > fails to be queued.
> > > >
> > > > Subsequent processes:
> > > > (e.g., rx_complete =E2=86=92 defer_bh =E2=86=92 __skb_unlink(skb, l=
ist))
> > > > attempt to access skb->next, triggering a NULL pointer
> > > > dereference (Kernel Panic).
> > > >
> > > > Signed-off-by: luying1 <luying1@xiaomi.com>
> > >
> > > Please use your name, not an email alias.
> > >
> > OK, I have updated. please check the Patch v2
> >
> > > Also, what commit id does this fix?  Should it be applied to stable
> > > kernels?
> > The commit  id is 04e906839a053f092ef53f4fb2d610983412b904
> > (usbnet: fix cyclical race on disconnect with work queue)
> > Should it be applied to stable kernels?  -- Yes
>
> Please mark the commit with that information, you seem to have not done
> so for the v2 version :(
Thank you for your response. Could you please confirm if I understand corre=
ctly:
Should we include in our commit message which commit id we're fixing?

