Return-Path: <netdev+bounces-222157-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B305B534EF
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 16:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 048395A393A
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 14:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE8233471D;
	Thu, 11 Sep 2025 14:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h8+GyOEq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C113277A7
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 14:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757599837; cv=none; b=VNzRFrEmAcma1JVBj0eA0p2aKg4hUd9zt9cTzGklk6qjT1s27T/eNINBpvH1+UiinnwmN0xRHdx1UxvoKUHRfC08fXJsSIGE9YUACmPvVCwExKw6S6CHwo6Lmzi8LHSur0NnRvY8JYfvjqZDoI8f+YvlXd0NtSXsD6wm/fk+Jms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757599837; c=relaxed/simple;
	bh=gdH6rMVA8fkFzpayu6tKAGXbShstUm5CWf+kLisWYyQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P1rW8iwoCvDaXn4CvldwiSkDKG0D1clWInn4Hklr5i2iov3kdbKddwWWLjmZxYVoH1rPW0ViY6kMkxuyvCF1adRZ1PkmjqkTdES96v6x26mI4ns1yZqiCC5CrSbUGaQIGB8gtOwZzC+rpjHnfhJ8Y/cm4FqlnUipv0PdWxOZ5v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h8+GyOEq; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-24cca557085so161585ad.1
        for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 07:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757599836; x=1758204636; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NTtKKiF/oNS3B5v/oGshvSwm1o3Aa3Jz0g1sxG2LnI4=;
        b=h8+GyOEqfaFsKvHTQ/5vYULQ87DsrYAi9j0QShXVOILWctVr1Ex/xd9xyXCfbZSf2u
         h8B50j9SsiZerjnxi3YmNCZsAYi5cKF00WoOvl5KEBkRra67Lbz7fjujXk51WoTlME+R
         V8Mr6D2gr0z9WgLQzCSEuzkSwxzkLHZitKuxeAEQKzPQrnoucPnfWaZLMY/ddJyF1z6e
         k5IFPD/15LrMk5nAHK23cdDYkppBdN9vlgDiIOniSIgOXvOc0RG0a3SDsg91m8FJA8lk
         snK+hSvoKueVVniVY53f99W/F9EZNkijIGIvvUNqh/fv1B8e0DD//d+wD//fRzfN/dAh
         4boQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757599836; x=1758204636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NTtKKiF/oNS3B5v/oGshvSwm1o3Aa3Jz0g1sxG2LnI4=;
        b=cSkCBP5M8YZVSQDhgPtuHtypbjICaEOgwqHGg/N8qjY6YqTL7Ob6V8OEZIlhakIGog
         rect6GMPLRZxishk3HbMceWXnfc7rk7MytNllCQWCLIJ8BP3qBdVHVD5QJZ/51O5pc6G
         k5GDTTZxTasdBoS8I8AM8FPhvvKSeg8cHArsWnXamFugdBuWhxHVrFxUBR51VRqvynyw
         JNCbzaWnzxSxXqI0/vN8eHmG9NK3D2IYCaITgpq7pftdA6pzGZOUC499Yl7Km5oBUyDa
         qpq4i/fbVEzitmQUh1DJvHQYTYPZbiheSGcV3w4nLHs7gn5i0WYFWB+733uahgpArjK9
         rC6A==
X-Forwarded-Encrypted: i=1; AJvYcCVYyDiVvsEG4aKQWbEldfy3kOxVczRzaxbPjRWIKINBZurCVOqm1cPNcuyjFVD99TfhlJeyAAA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3ep+/4GKgRwoZ0fJq7tWakvUAxY9gGoubuK7Jmi5tOwF8cqEx
	FNjfCfCbZKCTpj1RMTsHwknGAtF6kxUBRO0UTVfrKaLLzmvLXqgKg0iPtSOY3MjZbd5sKHbeBK8
	lpDk3yibZW/RtgJG3ogbtmWX6AsjmJUI/mQRLZjYh
X-Gm-Gg: ASbGncuJeFN/uDKDRtqBagqc0JxY+vmhG7NKwR+HqeUOPkTdcgNVZMQ0CvV5w6948DZ
	/1XXCTKUPs98W9lBZL9jWx9kJ0TMWx7haXpiA7JcPKDcAcWyy/eXr5tBxVJ++1GjldyOaUUJIQx
	hL92y03zNCyCzLxQI1vCM2ugowjQgZxzuzUr096PsKyusW/elGXyZhAjF9AWaeX8wQwQh+7x4Ey
	tzZ+adpaMAxz5ZJJMe2fjFXsWQoEO6KBvkQlFp8btMupwQGHpQY6hH9
X-Google-Smtp-Source: AGHT+IH9kSz1LTsRHP6olFkEn3I3RiC8UrmXXe9vk2Oqt/c99ErBu3hcpVi2M/UbqJs6TCReAvkA4wQxH0qGAQnGXYA=
X-Received: by 2002:a17:902:e5d0:b0:24c:f4b1:baaf with SMTP id
 d9443c01a7336-25a7d989bb5mr9251475ad.1.1757599835355; Thu, 11 Sep 2025
 07:10:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910203716.1016546-1-skhawaja@google.com> <20250911064021.026ad6f2@kernel.org>
In-Reply-To: <20250911064021.026ad6f2@kernel.org>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Thu, 11 Sep 2025 07:10:23 -0700
X-Gm-Features: Ac12FXwDBO6Mw7UkUf65gwJDy2ueo0SM5gLpOEPCxujBQ3DZMkqcIVdNZPHooZM
Message-ID: <CAAywjhTkX3N5CY8+DCEu-DD_0y+Ts0SEkkVphKam1vScMRWdgA@mail.gmail.com>
Subject: Re: [PATCH net] net: Use NAPI_* in test_bit when stopping napi kthread
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, willemb@google.com, netdev@vger.kernel.org, 
	mkarsten@uwaterloo.ca
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 6:40=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed, 10 Sep 2025 20:37:16 +0000 Samiullah Khawaja wrote:
> > napi_stop_kthread waits for the NAPI_STATE_SCHED_THREADED to be unset
> > before stopping the kthread. But it uses test_bit with the
> > NAPIF_STATE_SCHED_THREADED and that might stop the kthread early before
> > the flag is unset.
> >
> > Use the NAPI_* variant of the NAPI state bits in test_bit instead.
> >
> > Tested:
> >  ./tools/testing/selftests/net/nl_netdev.py
> >  TAP version 13
> >  1..7
> >  ok 1 nl_netdev.empty_check
> >  ok 2 nl_netdev.lo_check
> >  ok 3 nl_netdev.page_pool_check
> >  ok 4 nl_netdev.napi_list_check
> >  ok 5 nl_netdev.dev_set_threaded
> >  ok 6 nl_netdev.napi_set_threaded
> >  ok 7 nl_netdev.nsim_rxq_reset_down
> >  # Totals: pass:7 fail:0 xfail:0 xpass:0 skip:0 error:0
> >
> >  ./tools/testing/selftests/drivers/net/napi_threaded.py
> >  TAP version 13
> >  1..2
> >  ok 1 napi_threaded.change_num_queues
> >  ok 2 napi_threaded.enable_dev_threaded_disable_napi_threaded
> >  # Totals: pass:2 fail:0 xfail:0 xpass:0 skip:0 error:0
> >
> > Fixes: 689883de94dd ("net: stop napi kthreads when THREADED napi is dis=
abled")
> > Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>
> Is this basically addressing the bug that Martin run into?
Not really. That one was because the busy polling bit remained set
during kthread stop. Basically in this function when we unset
STATE_THREADED, we also needed to unset STATE_THREADED_BUSY_POLL.

@@ -7000,7 +7002,8 @@ static void napi_stop_kthread(struct napi_struct *nap=
i)
                 */
                if ((val & NAPIF_STATE_SCHED_THREADED) ||
                    !(val & NAPIF_STATE_SCHED)) {
-                       new =3D val & (~NAPIF_STATE_THREADED);
+                       new =3D val & (~(NAPIF_STATE_THREADED |
+                                      NAPIF_STATE_THREADED_BUSY_POLL));

>
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index 93a25d87b86b..8d49b2198d07 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -6965,7 +6965,7 @@ static void napi_stop_kthread(struct napi_struct =
*napi)
> >        * the kthread.
> >        */
> >       while (true) {
> > -             if (!test_bit(NAPIF_STATE_SCHED_THREADED, &napi->state))
> > +             if (!test_bit(NAPI_STATE_SCHED_THREADED, &napi->state))
> >                       break;
> >
> >               msleep(20);
>

