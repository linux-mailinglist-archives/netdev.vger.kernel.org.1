Return-Path: <netdev+bounces-242434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF8B4C9063E
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 01:16:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 543043A96DF
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 00:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4933D1D432D;
	Fri, 28 Nov 2025 00:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="WqVORRox"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2F1149C7B
	for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 00:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764288992; cv=none; b=bcfejwppMHYBKF0r2636oNJZ1hrfq/CWQ/TdvzwfDjmEjHs0ZOPNu5MqQYO9M8e0RXUgMEQzSHwf8BFO81dgOvS1DkcZZ6xoQTlB6kVA/1wHUvdx/Pbh0Tpqv/VhnacYKgGho9XfSk2knetOHN5dD88VfAKQLFXq6dpRaUmnl9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764288992; c=relaxed/simple;
	bh=/f5AJstH+nkEL/NwBUZtkEuWsmh/aI2o6SSahqAyPSM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HI+1aypCVpwU/YMpTNBnE4Go2MzNsgvgpVNjWCq97s243E17PKdSCmUpgnIiQzsi+DvM2m5RCZvO7DvczRjXSduik43yWyvz+Krdr2p5UnB8Ml/KHDJRP6JfMQZpeKWd2LAw6Aq3oznQAQEpww8N2eghfRkv0v5ZTfLOfc0UuAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=WqVORRox; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8b2d6df99c5so252515085a.1
        for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 16:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1764288989; x=1764893789; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/f5AJstH+nkEL/NwBUZtkEuWsmh/aI2o6SSahqAyPSM=;
        b=WqVORRox8NaQHixNj22gB/B3z5r2D8fS/ViyQ1Exw8wyZR7zjErOgWB7AKtekdGEb8
         t51gwvRF0tHdfRHsekXH0BbGhNP2x0FOxmajcRFfi1YQKXFHT5xbHeTZjZhKbF+4RF7m
         10qhx5dRu+kLuh+wvEH1LWRPuT0F6Q1iZR4bkCcidFnzIEkDiuB7Iw9DZR0Rg6K0GrXG
         F6u/VEOvLtrmwqdSA1WO2BrUh3NrKlGGE+YrRnoEqOl+FlRWDtnadrS1cj5YxkS4wJ09
         Nq9lI8w5m1lW37+Z9hbA7tQl2I9TAV4VwG9Ga78Zd6+XfrR7LvwLzSXkOYsoEodFV5go
         GlXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764288989; x=1764893789;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/f5AJstH+nkEL/NwBUZtkEuWsmh/aI2o6SSahqAyPSM=;
        b=jQ+zFOD0BABmO+LWVAEpBaVXp/6j2t6ym9vjaqLYpJUpsL3Jwy+ZcIUgEBvwd9gBXa
         FoYIif+3zRk3bbbjZlYTnpvAlJvlrgUVS+GrzUybAtg61PE7wCwUjMHsq5/2X3jwjbKl
         TgAJcHQh3p1iiTJs8530Q5Nrf1dcVpoExLKVKH+VybDJ7oAx2nJzr+kEXRQ/bipCwwLy
         KkaN/H54Xf1MRSrumejixbgN3G06iGdxhow/F/5YjidNAiN9i/ZsVkkhulMxhofMBG/K
         Ivn95cdmSG17L8EGFB0DHDKxaQGGIAek5pYNMFh49H5sV2rui3v/Agj4u04aGRas79Mw
         WXXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUr32Ol1vkNIRQfMDRyZMGzeuL1VIst/QwBmLkX3ofBxCgyonvc/4Y4VmXtMD60dF8HHh1SwYI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuhWcE8VgV75bFCl+GefXMgCKgtElnBqijJz1KlKxzVWwtSpMQ
	sucM8pW64r2ijVzyyfkH10plOZrMjcsS11UMR/XuQCuNkFszJ0E4A0x3GMI2Q6vc0kCpXJO549m
	+WfCFAqwWdSvAUOKz9Q/TYAb51B5BzqpmADIJF3ml2LV/zI/DMOs=
X-Gm-Gg: ASbGncsHe1k80h22snLdh8H1kQXhXJ/9oF4+8kcVoRZrw5bumHMH6/+OdARsjbbyYha
	uw8gXNCE3B17eFeVkKz6h2wZTDNXrHMGOAUeaQKulK4T8EuhYwJi7XWcVSyiewlInfQcNyRim4t
	5DaYaqnhszxYnhw2iXlobypZSOaI1yY5TzQLUcPPzM4wITCQkEEOCihodjVN+UypD06zsi/0hvG
	n4+aDfeml3JDlveYtV7MvemSEhKWUoX3FWtIHMU9cF7BHjrEOdDsRSZU0ZzAb6Lb3legjR2f2hn
	T0/OXAc=
X-Google-Smtp-Source: AGHT+IHqtqFThjT0il3Av8xWTU6PtV96MSG8Goe9XxzXE4td+Exyt3EFwZ1YQr+Qn1b36fkEWbyrs9Jz6MGV1Fprrjw=
X-Received: by 2002:a05:620a:1990:b0:8b2:f0be:27f5 with SMTP id
 af79cd13be357-8b33be05c62mr3793893285a.36.1764288989592; Thu, 27 Nov 2025
 16:16:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251126194513.3984722-1-xmei5@asu.edu> <20251127153644.55ef4796@kernel.org>
In-Reply-To: <20251127153644.55ef4796@kernel.org>
From: Xiang Mei <xmei5@asu.edu>
Date: Thu, 27 Nov 2025 17:16:18 -0700
X-Gm-Features: AWmQ_bnOxFilKmR9vNSK0sO-1VqGCMNowWWrP0Rc25rhrMJR1r8SMo-VGLfuglE
Message-ID: <CAPpSM+S1-c68WsY3KYQp4R3kC+p+eREdJP0Qas9Q68MiA9Y3AA@mail.gmail.com>
Subject: Re: [PATCH net v7 1/2] net/sched: sch_cake: Fix incorrect qlen
 reduction in cake_drop
To: Jakub Kicinski <kuba@kernel.org>
Cc: security@kernel.org, netdev@vger.kernel.org, toke@toke.dk, 
	xiyou.wangcong@gmail.com, cake@lists.bufferbloat.net, bestswngs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the reminder. The conflict has been resolved in v8.

On Thu, Nov 27, 2025 at 4:36=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed, 26 Nov 2025 12:45:12 -0700 Xiang Mei wrote:
> > In cake_drop(), qdisc_tree_reduce_backlog() is used to update the qlen
> > and backlog of the qdisc hierarchy. Its caller, cake_enqueue(), assumes
> > that the parent qdisc will enqueue the current packet. However, this
> > assumption breaks when cake_enqueue() returns NET_XMIT_CN: the parent
> > qdisc stops enqueuing current packet, leaving the tree qlen/backlog
> > accounting inconsistent. This mismatch can lead to a NULL dereference
> > (e.g., when the parent Qdisc is qfq_qdisc).
>
> This series does not apply, please rebase on netdev/net/main.
> --
> pw-bot: cr

