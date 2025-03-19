Return-Path: <netdev+bounces-176115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 671ECA68DC7
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 14:26:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60D681B60274
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 13:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB362561B1;
	Wed, 19 Mar 2025 13:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HXkGux37"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B3B2561A4
	for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 13:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742390604; cv=none; b=TuZj+5upVy+sROtIppSIr0f+incCFJXuY0zZiqcUV2IZksMY1ZhdqnZOHiSUYEB5Vbbn5tdxv/ZKddq1WeLx4UEtpsBFGixiiKzBBYLgBBJtjVTKudXBQj6rLxeHP2IvZVpXE8hUzwniV3KYHf+dlHXdAIZACr13x1pvztV9Jpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742390604; c=relaxed/simple;
	bh=9ensWkAEv7GTW3OMNwsfZ8Resy2WMOnJtyP8YvyDXuk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UZGEwAuodbfhr7Vz783IGR8QbfDjc9vasdWZqZolyYpeG/Z8BLnmuDnzHaPY36Rv8XRQ94fkmta+VNytDkN23R2cLahIXC/jp20KSvP9VHMi7w6grdtmv2ECs6dEOWPIGoMKLCd0xYM1Zex1jPxstf8J6Y67IrkbG5KK4UBBQ9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HXkGux37; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-471fe5e0a80so59374301cf.1
        for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 06:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742390602; x=1742995402; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=psYNKA6/4hrBUz3Y0AVHXJKQr5Yjmd3kCp1spfxggwE=;
        b=HXkGux37siAjGtiqlsaUyMlZ3xyVPP0epwEV5TED3vYak+Wx7zB1ke5xcZtwBgJzzS
         7DUSk4159dXuxz6uinhzW+51EGn6jtbU/W5VeEgP2lD8mQcu6LpVpL2B+qVWchob8bqL
         Rdv2OZnfD+O9mcBjcuarty6m+y/E+JGFuTmYwjRnjN+o/kXfN1KabL2GMYbXDI4iMC1/
         hW+Y+B1gmeCZax/cDVjjtzfs+aXJQNdshY2BhEhQnUGxvhKwlwo+1FNeMrBrApiZSvOR
         eYfgoRcGLIYD1Udjz+Nk/xbVGWbfb2JYeoGwu57U+HAt3vMDj/lxIrHdyOsmsQzy7RQ/
         Y6ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742390602; x=1742995402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=psYNKA6/4hrBUz3Y0AVHXJKQr5Yjmd3kCp1spfxggwE=;
        b=k7tZKQR0j+sBIF9QhenzVaYBH7pGdYfULDnUBxdg1qXMLGtq2oFvgz+I0GXr/hZqSQ
         bcPhTKsaPEqYjGI0XjoUPJhHf+KJIj6E0fahcOGoKBmOaf8aM7wQEnhmmw8LBOGSs6Wl
         IaSYF7cIQ3KWvkuGREmTJobGLSD6Ynz5/cEzKsSwOb7g5E7h9SLv4y5h/npZVczMTxFK
         GhWAV1AYzi19woerPsRqfG1Yk5pUqoFPXQ6Rx3hdpzxfhs/lRw4hn7lDWsZjI04kR48p
         H9uhprX4QqBzexU5hDEb5I66mM4iyAgbDH+gLtiVKAHlNjsEnczKjbOfmsreIjmIF2i4
         UfqQ==
X-Gm-Message-State: AOJu0Yxn/ZxwXGR2fTQWtIbyZwFfojV2+Z2c8oelgO1Md5HWHRHW3t34
	4DUjsxrEOUXjnv77VqU5fLQtJaNqzv55ilMotPcE9G0B7cmq4jaT0HAYqQ/i5uquEk66ojDZIuD
	dlSXBXKYDuOhagRTHKzkFWPdiBIvAOp3HVCCO
X-Gm-Gg: ASbGnctIiMcx9oQr00LwkrClifsLe2mZxqo/p2Zwr7MUgWzj2dtHxnWn8xF/C50W3VO
	YqTfNbEsq0j1JWWIMtYl8ko0xWjWYCRNoLG/Y3tud5lMl42+S/oQeVQwND/i78ej+KYKSC+fbVn
	72zln8039q4MgRFmkN4UWEZSAVju8=
X-Google-Smtp-Source: AGHT+IF1b8V53T9FhdQQrJ8iDAHBINhY7Z1MO722OoUTatpBP7eKEhkGAELedgqDNn8I12Ri2ahW+JWYrwkUR9jzxUE=
X-Received: by 2002:a05:622a:5513:b0:476:b783:c94d with SMTP id
 d75a77b69052e-47708377ce1mr41852091cf.35.1742390601434; Wed, 19 Mar 2025
 06:23:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2a1893e924bd34f4f5b6124b568d1cdfc15573d5.1742320185.git.pabeni@redhat.com>
 <0063ca98-93c2-4df4-9c0a-7a145e5409ee@redhat.com>
In-Reply-To: <0063ca98-93c2-4df4-9c0a-7a145e5409ee@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 19 Mar 2025 14:23:10 +0100
X-Gm-Features: AQ5f1JpbG3U2EG6L3HSNgKKqo7Ema62A_cl0rgdXLof6FtjM2dwpL9bgI7FLJo0
Message-ID: <CANn89i+cJfGwTw2T6oM=7u3MZe1YL_4pmdZg+TZo0TK28hHr+w@mail.gmail.com>
Subject: Re: [PATCH v2] net: introduce per netns packet chains
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	Sabrina Dubroca <sd@queasysnail.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2025 at 1:59=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 3/18/25 7:03 PM, Paolo Abeni wrote:
> > @@ -2463,16 +2477,18 @@ static inline bool skb_loop_sk(struct packet_ty=
pe *ptype, struct sk_buff *skb)
> >  }
> >
> >  /**
> > - * dev_nit_active - return true if any network interface taps are in u=
se
> > + * dev_nit_active_rcu - return true if any network interface taps are =
in use
> > + *
> > + * The caller must hold the RCU lock
> >   *
> >   * @dev: network device to check for the presence of taps
> >   */
> > -bool dev_nit_active(struct net_device *dev)
> > +bool dev_nit_active_rcu(struct net_device *dev)
> >  {
> > -     return !list_empty(&net_hotdata.ptype_all) ||
> > +     return !list_empty(&dev_net_rcu(dev)->ptype_all) ||
>
> Sadly lockdep is not happy about the above, the caller can acquire
> either the RCU lock and the RCU BH lock, and dev_net_rcu() is happy only
> with the former - even if AFAICT either are safe. I'll use:
>
>         /* Callers may hold either RCU or RCU BH lock */
>         WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_bh_held());
>
>         return !list_empty(&dev_net(dev)->ptype_all) ||

This lockdep distinction seems strange.

The old RCU-bh is gone, we might convert network to standard rcu to avoid t=
hese.

