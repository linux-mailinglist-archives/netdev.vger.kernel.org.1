Return-Path: <netdev+bounces-178590-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B24B1A77B40
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 14:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B74C216C4B4
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 12:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B02202C5B;
	Tue,  1 Apr 2025 12:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZmhHqY9P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4584202963;
	Tue,  1 Apr 2025 12:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743511695; cv=none; b=L6VyRENNcNf7+ZH6e6wgXaUlfVqS0kJMTKNGCAHWXLfoPDzW0kNDsN+kIs7iNgzLNpAh5/QsqrzIRjq1twJsW3WA3NC83dsTv7JQBW7GqbQ+mZS8HaNlIE03GLBzDTyKUhrrQIRZNaTs6VLak6yL5u54/91JKkugaM9zLdH9D6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743511695; c=relaxed/simple;
	bh=lDZTSMaO1bJ543JPMI+eaUZipC3tuQ8E4v6VNT6soTQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lH9V7F9UsEa4MpYQeTdaOwQ6WzS/AaZrGQiAq+xu+tBs3GUHNpLmn6MFUjdpglz0/UhA4uqNi3HXsCf62jxpzbithYqrD4h7hJXz/X3mEUVwjkBg2vjSSS3VRGScZ4MCk2PCc5A68MSt3SP5+GCn+F17tQoVa1vOXeXyfi/ywMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZmhHqY9P; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-2bd2218ba4fso2139465fac.1;
        Tue, 01 Apr 2025 05:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743511692; x=1744116492; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kQ/5Y+dwWDZJJrv96q/JH3lzjHcexnpxucH3IGGyZas=;
        b=ZmhHqY9PqE4SDQfwiw8wgVjj+M1p79SCQm7oFdJ032GQOB+E9ClHrzPF8SsQZsyErS
         sz4o5fcTz91GeixTsLmDAlwf2rwwoozROjbqAcJCo8Eua0mm56zWz5Qp22vnwRcymBA5
         w/Hk49hySYzkMX0ceEfK0KCsfZ6HMZimbQiZZkVCSw5j0cbjUbcyrZAa0ytaGJRpxpYQ
         vZ/frDwR/AK7CHJwzwm2h979+ANKyCTVTwUEXwwiU124LVvzJwqLvCxTupCDm/5HWlHt
         w3Ck0VRM1wiSfEZkDSL/fhhvF1DIifUmAJ4qox6UueoENlhctX9u2ETyMqd6HEGuChhX
         7+Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743511692; x=1744116492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kQ/5Y+dwWDZJJrv96q/JH3lzjHcexnpxucH3IGGyZas=;
        b=t+jQfzEh5ItWSZczQS2Duf2ccBG6/s0bZapRNEFCfi1+vfLtOKCypRzgUjVH3PBFO2
         qPIrl/m0gl31c1nSvTLF8pONlAc2AAkcas3tUQXEWyVtmWBSxkmnfkGF9SoYZKayypzr
         U4JzvwUTnKMXXuPawbvi8GtwLMtXMlFbUqo7MeeZbxjPZa4OWjlAUGn+8jftZueB3IHJ
         idArwoQes7Ec9W/knFoCB6TYY/+DNiXRKz8TrachNtQSTx+47Q0M3jn+1HWK5QYH60S8
         YBZLV0NPWcLu1s9Chv8ULg7wRdJhDYHLTUSH7/tlhNj5Es0Uz/G5CkREi+YmAbDULNP8
         yc9A==
X-Forwarded-Encrypted: i=1; AJvYcCUhhB8eO8QNEr3K4nRQ2HkWxJxApubtEEWOZpj9yp0bLOy/t+dMjIrOXkcqQNNLa8zC+yTFFnw76vfe@vger.kernel.org, AJvYcCW4FnxkAuIjueudGApL8vhuLkCaTTUA2r6gqN3pB4qF1ue41p730eXBOMqy6Iyp9+6JHoq849ksPCkpT2Y=@vger.kernel.org, AJvYcCXmmRLRUgwta06HOaBIu+tdn06kqh7ijcC5NCMAZ3KROGLdBsqyjhBuHnSaBuY3bN2TC8THrNcp@vger.kernel.org
X-Gm-Message-State: AOJu0YyFHrowIwBRywrc8D/AY1X0JJ36/sXg0QUdglXKKSUH80ZDTCh0
	8haTkaS7lW4JnN74MCGkXiQzTJITBFKImGbgZNuaAsv2/zUWchx2I8loLdJDShzZ9B1jJpItLvE
	IFpxph0/XGs3itcUA48NZ3J070X0=
X-Gm-Gg: ASbGncu5NxX0ooZcfBp2IUhpJGKLKh27HXWMl7IrJ/K+CeYOqBK/4GR9frTNzPhm8+h
	RVrdI+EwRkurdGOG1OqLarV6rFAzW77KGRFypYoMypSQAUsPKV8O5+ItUWS8PTJmEwIRbGHzT2/
	Jjv5VIamwHIEjD11M09ZBOt25dpA6DurWX6Dn9fA==
X-Google-Smtp-Source: AGHT+IG8Tnh6OLeshuh3GjQ9rBKBY3rdOk43MjNujALzJsNlpgR6kqN2j5V1jvVfj4hbg6MC7kksYi4B5VGTjaEAj5Y=
X-Received: by 2002:a05:6870:4190:b0:297:2763:18d4 with SMTP id
 586e51a60fabf-2cbcf5017efmr6147877fac.15.1743511692636; Tue, 01 Apr 2025
 05:48:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1743497376.git.luying1@xiaomi.com> <e3646459ea67f10135ab821f90f66d8b6e74456c.1743497376.git.luying1@xiaomi.com>
 <2025040110-unknowing-siding-c7d2@gregkh>
In-Reply-To: <2025040110-unknowing-siding-c7d2@gregkh>
From: Ying Lu <luying526@gmail.com>
Date: Tue, 1 Apr 2025 20:48:01 +0800
X-Gm-Features: AQ5f1JrUr1k0WWafmzfNg_Oduajj52h1wbW1c-bclvNY54dwzB0hk0pYL0L0OOI
Message-ID: <CAGo_G-f_8w9E388GOunNJ329W8UqOQ0y2amx_gMvbbstw4=H2A@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] usbnet:fix NPE during rx_complete
To: Greg KH <gregkh@linuxfoundation.org>
Cc: oneukum@suse.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luying1 <luying1@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 1, 2025 at 6:31=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org>=
 wrote:
>
> On Tue, Apr 01, 2025 at 06:18:01PM +0800, Ying Lu wrote:
> > From: luying1 <luying1@xiaomi.com>
> >
> > Missing usbnet_going_away Check in Critical Path.
> > The usb_submit_urb function lacks a usbnet_going_away
> > validation, whereas __usbnet_queue_skb includes this check.
> >
> > This inconsistency creates a race condition where:
> > A URB request may succeed, but the corresponding SKB data
> > fails to be queued.
> >
> > Subsequent processes:
> > (e.g., rx_complete =E2=86=92 defer_bh =E2=86=92 __skb_unlink(skb, list)=
)
> > attempt to access skb->next, triggering a NULL pointer
> > dereference (Kernel Panic).
> >
> > Signed-off-by: luying1 <luying1@xiaomi.com>
>
> Please use your name, not an email alias.
>
OK, I have updated. please check the Patch v2

> Also, what commit id does this fix?  Should it be applied to stable
> kernels?
The commit  id is 04e906839a053f092ef53f4fb2d610983412b904
(usbnet: fix cyclical race on disconnect with work queue)
Should it be applied to stable kernels?  -- Yes

> thanks,
>
> greg k-h

