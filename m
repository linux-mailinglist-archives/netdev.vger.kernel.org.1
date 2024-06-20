Return-Path: <netdev+bounces-105418-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD2491111E
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 20:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 328192819B3
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 18:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5D31BB6A6;
	Thu, 20 Jun 2024 18:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EclqN1PY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898EC1BA071
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 18:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718908194; cv=none; b=YMZQIb2bDYj/DupO8HueIQqE2xjBzIQiB2RuXyQ9Bd+ONzPi+CDa8+N4ZtUR2gucoSu3YVjG7KHQWfJy2G4GT0sE3LKJ1wJ1u47hcPclARttqhj7ir4k4uQg3rPJJhqxTQ/5bCvjf43ZfSDlrrdU7txjrNbZK4CPy7C5Og/fa5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718908194; c=relaxed/simple;
	bh=YXq1YWccO82XWtTzvt/m+6EDe2hUsPD4XzkUTmi1iwM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hob9QADo/4sczCQIc5U6sZbF6XtDhwBFmxu9e6LZZ+uYZA0IW+499KRRkjqobIiGze3vWFrWkkDeyytnie+fR5ZoeaELt2QSIMbB3kDMKA+mHt0kWiushz8z7mESClLz/vHnxPcTOEAcVyi12kpd77VJ8zIpt9YHZBtM/LrP2s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EclqN1PY; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-57d16251a07so3475a12.1
        for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 11:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718908191; x=1719512991; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RuzHidioJKgWNRZd8U3cTiy5pXTtED8tIWIEng8PuW0=;
        b=EclqN1PYJVjY2Fs4BRAEpHyd/X6rQsZhGnbwN7DUCP+NsnwQ3fkU+Yh8tEIImUsuko
         JNyZy1KMERT0Iq5sYkbdn7CjZ41HfG//iYrHehNe1i8Sy3pjEsdnW2QJRO3NhlKT2sfe
         SWCKtWjKv7kHCa5UONUb4aumk85JrtoyRVTN3Bulc0A+/+gVdldEqsRo+GWC6jcGjRYR
         ETQo9hdIycF1w92Wv8ghxsQiNYoPuBCG6FC2xTH/30YGgbDyZoeGZjygbYR+NQLhQbnO
         /yADGx3GzPps3zRQhLspj0cVhwIjPS06+TF0zvscUK8LTU68pGTDsvsOCgFnORrgyj5D
         Dnng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718908191; x=1719512991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RuzHidioJKgWNRZd8U3cTiy5pXTtED8tIWIEng8PuW0=;
        b=Wo49mc+llnLpNbNlIBBThl/XzAozJe/dhw/20q+BSz2vcrXFGrxy9KER/5YXxTr1oK
         8TfDEiVqoqlyWcSRycpELhq8YTWkM04LsqA+UucKMH82j7allcmHicxqG4QCUGEb18N1
         K9abNPFN0CyWFaJyvQ1cmfJnHSHg5uhSwqSkY8sEecCQEH5xfQ6CMehDpHbWlJqQecs0
         pMlI93Pa1sQ6hJJjRoTp8kEYg7aGSW6nJILtHVH5YO5APjDrH0mX+7OlsqnpNMcZGGj5
         YinNt8JJpYCGKwef4KqcKSWNqmaGspz7z3VbmEfExNhvc26lLJRPo/uLmwmHaeXzAdCm
         Jf5w==
X-Forwarded-Encrypted: i=1; AJvYcCU4hCbmG0TKCQCUPURRtPilD+1oosKPbX0cacdO74XU4R+7jFwSXPmFTxJ0ft69GT6m7u6nyqKdcowdXoDFLU/0WWs4L2+6
X-Gm-Message-State: AOJu0YxJG7atbxoVF2ew7xsy+hWwVv831mXB6NjfmpTUKJgPBccrD3Hq
	CBlNCi/WPMUeYNgHXpw2jIz/nulfTVbxKQxv+XTLjRa63j7LAdYUBy4f+5ckizJFLC2LsBIgUAw
	l/2cskgdWP5f8FGiR6I+H27qGepTbfT1fVv7c
X-Google-Smtp-Source: AGHT+IEvzmYFkY8KMBswieYNsWmzvd+WtjfkWj4yBLSFMEhW9FjraLoua70Fu6n9nhQ8AQayD+LxPyZYLnmTsPdkxXg=
X-Received: by 2002:a05:6402:13d1:b0:57c:fef9:1a9 with SMTP id
 4fb4d7f45d1cf-57d2ec9b828mr36107a12.1.1718908190482; Thu, 20 Jun 2024
 11:29:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240620114711.777046-1-edumazet@google.com> <20240620114711.777046-7-edumazet@google.com>
 <66746ac265e37_2bed87294ba@willemb.c.googlers.com.notmuch>
In-Reply-To: <66746ac265e37_2bed87294ba@willemb.c.googlers.com.notmuch>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 20 Jun 2024 20:29:39 +0200
Message-ID: <CANn89i+Mzur1pA2CZLv3YAjL6GY=6kO2YgTOMhK+Tn_FgCXsEw@mail.gmail.com>
Subject: Re: [PATCH net-next 6/6] net: ethtool: add the ability to run
 ethtool_[gs]et_rxnfc() without RTNL
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Ziwei Xiao <ziweixiao@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Willem de Bruijn <willemb@google.com>, Jeroen de Borst <jeroendb@google.com>, 
	Shailend Chand <shailend@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 7:45=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Eric Dumazet wrote:
> > For better scalability, drivers can prefer to implement their own locki=
ng schem
> > (for instance one mutex per port or queue) instead of relying on RTNL.
> >
> > This patch adds a new boolean field in ethtool_ops : rxnfc_parallel
> >
> > Drivers can opt-in to this new behavior.
> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > ---
> >  include/linux/ethtool.h |  2 ++
> >  net/ethtool/ioctl.c     | 43 +++++++++++++++++++++++++++--------------
> >  2 files changed, 31 insertions(+), 14 deletions(-)
> >
> > diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
> > index 6fd9107d3cc010dd2f1ecdb005c412145c461b6c..ee9b8054165361c9236186f=
f61f886e53cfa6b49 100644
> > --- a/include/linux/ethtool.h
> > +++ b/include/linux/ethtool.h
> > @@ -748,6 +748,7 @@ struct ethtool_rxfh_param {
> >   *   error code or zero.
> >   * @set_rxnfc: Set RX flow classification rules.  Returns a negative
> >   *   error code or zero.
> > + * @rxnfc_parallel: true if @set_rxnfc, @get_rxnfc and @get_rxfh do no=
t need RTNL.
> >   * @flash_device: Write a firmware image to device's flash memory.
> >   *   Returns a negative error code or zero.
> >   * @reset: Reset (part of) the device, as specified by a bitmask of
> > @@ -907,6 +908,7 @@ struct ethtool_ops {
> >       int     (*get_rxnfc)(struct net_device *,
> >                            struct ethtool_rxnfc *, u32 *rule_locs);
> >       int     (*set_rxnfc)(struct net_device *, struct ethtool_rxnfc *)=
;
> > +     bool    rxnfc_parallel;
>
> Would it make sense to make this a bit, as there already are u32 bits
> at the start of the struct, with a 29-bit gap?

Indeed, I will squash in V2 the following, thanks Willem.

diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index ee9b8054165361c9236186ff61f886e53cfa6b49..2a385a9e5590ba4c629577c3679=
dd593d7d6e335
100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -853,6 +853,7 @@ struct ethtool_ops {
        u32     cap_link_lanes_supported:1;
        u32     cap_rss_ctx_supported:1;
        u32     cap_rss_sym_xor_supported:1;
+       u32     rxnfc_parallel:1;
        u32     supported_coalesce_params;
        u32     supported_ring_params;
        void    (*get_drvinfo)(struct net_device *, struct ethtool_drvinfo =
*);
@@ -908,7 +909,6 @@ struct ethtool_ops {
        int     (*get_rxnfc)(struct net_device *,
                             struct ethtool_rxnfc *, u32 *rule_locs);
        int     (*set_rxnfc)(struct net_device *, struct ethtool_rxnfc *);
-       bool    rxnfc_parallel;
        int     (*flash_device)(struct net_device *, struct ethtool_flash *=
);
        int     (*reset)(struct net_device *, u32 *);
        u32     (*get_rxfh_key_size)(struct net_device *);

