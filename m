Return-Path: <netdev+bounces-127907-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9F5976FDF
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 19:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5075C1C225DF
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 17:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D561BF336;
	Thu, 12 Sep 2024 17:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kutsevol-com.20230601.gappssmtp.com header.i=@kutsevol-com.20230601.gappssmtp.com header.b="A8vqhQuL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88E61BE245
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 17:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726163906; cv=none; b=ZoFVFW9SOwV+sSX+PEP4YA1WhZrno3plSPqDwvkf+V5eMt3q0XjMbWSCt16Y0a5XADwGVkqVWo0vMQdEJME4+3O4lirvB6nB4Avsr6RVsaSpp/pad/9aH16EQqSd/jsuzOdMgpDMtVr3hVaHpInvlBx2RtHi+XtIHXRVXdTq/CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726163906; c=relaxed/simple;
	bh=rsyVoMxasFdrzg1ZCN3FzbL7tdpeuQ4bade0QJUXi0U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I1nPbPEuaxvuTPuCCcvVhAXhlaFxz7AMI2TsoLtICInkIjMNO4H5OT6GlTf2oIiew4L0SQJkk5lKkqWqMipxTlLVXHRzZNl1/gey8Zpxj4gG2jBg1r+CE2WZPfD1b90O4KrkOFJHwiCAz7gnL9asYQk16jjQLbHpXZGtX0+ing8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kutsevol.com; spf=none smtp.mailfrom=kutsevol.com; dkim=pass (2048-bit key) header.d=kutsevol-com.20230601.gappssmtp.com header.i=@kutsevol-com.20230601.gappssmtp.com header.b=A8vqhQuL; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kutsevol.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kutsevol.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4582c4aa2c2so7658531cf.0
        for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 10:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kutsevol-com.20230601.gappssmtp.com; s=20230601; t=1726163904; x=1726768704; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fWE9bW9XtqMX66iof/3vxgpMkfAbJVizDpepSHwC0ig=;
        b=A8vqhQuLoACRX+XIzdFfYzEVP9P3qWyCN4wcpgL/PQ3z/ehMGZEJSEWkSUI7brTpH7
         Xlxp7tHidEHNqySAi43OYqzzhFqgXbNz7aYG9BI96nYZgmNvokCmc8p+lqOPZ0RRTTad
         n69jG86sWJCCGRNhdyM5hUCWV9zWwGhCi3JuVIIpbYcs1yuqeJmP39KbEFnp7bYLLraq
         iTNd7BsWjUuTNpa04I7DS/YrWykk9E/h9F6p7lO+2gZxNpgmYmq5oLvu1sVslP0AIqAD
         2npc15ArdH/yppk7ArtZQNq9kBqf4NwOftIVjfHIIGOEIRbgN7DnkroOIMkvMBpuEbZq
         ExOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726163904; x=1726768704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fWE9bW9XtqMX66iof/3vxgpMkfAbJVizDpepSHwC0ig=;
        b=gOLpj/hnQlHgC+rMQVXyj7akqpZIVkPmfVqP/FA5XnCrgHsvqcSxVjEnDEEQ7JCU2x
         RCyLnM8cbQJZVgF6gI0tLTrFYiF9xuc7lHVR0LsMf5b6bEYO/WdvVbNAxYwZ03WtyHW1
         KXjEyDkSfK+z7jTNQKgVECPmLrGpzBJhBMmbawngxwSKI74RkO2GPnDTz467TVY6GWsc
         nMVQu98u7/SwPIF2lPZmWLlXJ9Lxyuysc27Zac59adNXWVaVUOULVmhEvwNM73oijnU8
         P6CWK5FkUVBU0pgM1mLVlb4GpdnhjZGIv70S6MaJLiuHBSVAvE8MlLDm4vbUpC++8VfT
         VVGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGqrdpFoCL0hJns5Q5E56gkUHZf1zZEsz4vTDVUnD0bK6lp/csCoZeTq3OBgLmLHrhbLI9bU8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3ZW6ukytWClNvEGg4xJPreYTFbrMa2e5QGfgxF7jGbHC2TvmT
	a8yyKZIT/XZkrFquplqvhQjyj+EnfTrhSER2gRyn9d1+D3V2knydvkp7awf54YYPHvIoLEht2X+
	KRmdA6PcogGHouw9D/i0lAyW5XLBE2cd4gIyhyw==
X-Google-Smtp-Source: AGHT+IFuvDGUGnOq4enNgaz263NpOLDBjldkv6QXNDkKpAomPEH83V/kDoS2P8ablIwkVQkOc3vbJREnzodxgrYgnl4=
X-Received: by 2002:ac8:7f51:0:b0:458:5d27:851b with SMTP id
 d75a77b69052e-458603df3e5mr44591581cf.46.1726163903530; Thu, 12 Sep 2024
 10:58:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912173608.1821083-1-max@kutsevol.com> <20240912173608.1821083-2-max@kutsevol.com>
 <20240912-honest-industrious-skua-9902c3@leitao>
In-Reply-To: <20240912-honest-industrious-skua-9902c3@leitao>
From: Maksym Kutsevol <max@kutsevol.com>
Date: Thu, 12 Sep 2024 13:58:12 -0400
Message-ID: <CAO6EAnWOrzOhHNURLct1tsxLL_gaNT+nWttTk4oPcD66h-xAZg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/2] netcons: Add udp send fail statistics to netconsole
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alex Deucher <alexander.deucher@amd.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Breno,
Thanks for looking into this.

On Thu, Sep 12, 2024 at 1:49=E2=80=AFPM Breno Leitao <leitao@debian.org> wr=
ote:
>
> Hello Maksym,
>
> Thanks for the patch, it is looking good. A few nits:
>
> On Thu, Sep 12, 2024 at 10:28:52AM -0700, Maksym Kutsevol wrote:
> > +/**
> > + * netpoll_send_udp_count_errs - Wrapper for netpoll_send_udp that cou=
nts errors
> > + * @nt: target to send message to
> > + * @msg: message to send
> > + * @len: length of message
> > + *
> > + * Calls netpoll_send_udp and classifies the return value. If an error
> > + * occurred it increments statistics in nt->stats accordingly.
> > + * Only calls netpoll_send_udp if CONFIG_NETCONSOLE_DYNAMIC is disable=
d.
> > + */
> > +static void netpoll_send_udp_count_errs(struct netconsole_target *nt, =
const char *msg, int len)
> > +{
> > +     int result =3D netpoll_send_udp(&nt->np, msg, len);
>
> Would you get a "variable defined but not used" type of eror if
> CONFIG_NETCONSOLE_DYNAMIC is disabled?
>
Most probably yes, I'll check. If so, I'll add __maybe_unused in the
next iteration.

> > +
> > +     if (IS_ENABLED(CONFIG_NETCONSOLE_DYNAMIC)) {
> > +             if (result =3D=3D NET_XMIT_DROP) {
> > +                     u64_stats_update_begin(&nt->stats.syncp);
> > +                     u64_stats_inc(&nt->stats.xmit_drop_count);
> > +                     u64_stats_update_end(&nt->stats.syncp);
> > +             } else if (result =3D=3D -ENOMEM) {
> > +                     u64_stats_update_begin(&nt->stats.syncp);
> > +                     u64_stats_inc(&nt->stats.enomem_count);
> > +                     u64_stats_update_end(&nt->stats.syncp);
> > +             }
> > +     }
>
> Would this look better?
>
>         if (IS_ENABLED(CONFIG_NETCONSOLE_DYNAMIC)) {
>                 u64_stats_update_begin(&nt->stats.syncp);
>
>                 if (result =3D=3D NET_XMIT_DROP)
>                         u64_stats_inc(&nt->stats.xmit_drop_count);
>                 else if (result =3D=3D -ENOMEM)
>                         u64_stats_inc(&nt->stats.enomem_count);
>                 else
>                         WARN_ONCE(true, "invalid result: %d\n", result)
>
>                 u64_stats_update_end(&nt->stats.syncp);
>         }
>
1. It will warn on positive result
2. If the last `else` is removed, it attempts locking when the result
is positive, so I'd not do it this way.



> Thanks
> --breno

