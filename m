Return-Path: <netdev+bounces-128450-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A86C9798C3
	for <lists+netdev@lfdr.de>; Sun, 15 Sep 2024 22:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 097271F21311
	for <lists+netdev@lfdr.de>; Sun, 15 Sep 2024 20:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984384962E;
	Sun, 15 Sep 2024 20:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UUIqSRBJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8D91CF92
	for <netdev@vger.kernel.org>; Sun, 15 Sep 2024 20:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726433375; cv=none; b=IcQlspugeANoRx/17ZopJQeD0AWY86jbvHqtDAyemoeoZBNttTHx8At7rRYshQfzSNRJnPncIufak3cC6WtPOy0AoT0A1kJmii2cIIhRbuc12H9Z2cfkL89/MaTNwWZo47K/bzMaYPipcBvo3FGlV76viSs8RqLsJfAhWhW/2hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726433375; c=relaxed/simple;
	bh=PSYL7X+Gm+LoRTHFueABnURmgspJNTWVNTi4fJ2wz5Y=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=spPhCf1dF4iJATspak1oTC6jLdii3yyLeNzywYynDMtGNhwi9j9E4YJowBbYeUul19cKz4nImLtNADmQzMUXDTLsxUbFpxB+oRlnTi+JV6mgSAnEX9B6xBTWxsTUa7APM/1L0e4Gf6JwyHVIrAX2fnO5Nnj4YAB52cOMCaCSZ4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UUIqSRBJ; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2d87196ec9fso1773160a91.1
        for <netdev@vger.kernel.org>; Sun, 15 Sep 2024 13:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726433373; x=1727038173; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Mvdgc7Nmeg3nHuj+xSHFKZBoYQmQ42IhOKI7TZbUboM=;
        b=UUIqSRBJErWOwrXB5wHUX/JuBS6UaIMgKzXtIbMa/qz3+JEJI0FRnQHkXRX6qY6FZz
         e8/4p6CuUT+fnJdjq6/q5hj8GtH3596qjCPnDRBlmf4QEp/ykseHUJPISCwn5xhGmdp3
         gOC5ogXbF4O2JgQdmACFe7eH62dhSp9foZwVZnSG9xwCO05ofy6SSYZP3CV9ejm4wZ5D
         ce4NajfAJKWTGsG3UW3HNCUkeLKYa0M+9wx9ZaUpOimOnNuO+970eFx3c2MhEPyvOTJF
         156qiQi75iTwE8dILSYUH6Kpp+IfceaJuI5wXM08oT0u/vNwxGOUFEMwiOv+bJqrRrZF
         44gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726433373; x=1727038173;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mvdgc7Nmeg3nHuj+xSHFKZBoYQmQ42IhOKI7TZbUboM=;
        b=dW4R1bwpub+e+cBW+7cLFYI7UTx7d+9NG+zJQnBEyUAIM5GS/n+qt6Vk55GO8YBeoq
         Cn+jkhnuQnWOfotokjzHKE8QdfzeoiA2L/1VvLWcLsXsGuUnLMhR5psbN3+kLQH+aWu1
         7mV/x6bf9sJgodDFeCDDIQPhYyKWEGgd8KRbGpt1l4vKpvMZnYOqe+tLfdRZXXQw30/e
         WTpWODJZupgGMlkgV26hfMuctRuVlhc7h71nd+fXvh8+NB1wmbPSdbIKveO6jt1FhStq
         o/beT2iVlp//luOxayzi6ttOmVm1e4WEfOJ7LH9aMaM+4ZmOhK9bcbkfWADrV3YK6ZHy
         GSiA==
X-Forwarded-Encrypted: i=1; AJvYcCUWzr+NlOvIwt990HKgcI4UOg1H/PXW9RSBUNNIV/ltPqWeVPxpseizuBGyk6h7OAekDGfXjtY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfYwljwFxDEYemV2cTVozX+/UuPGvP5Gvr6oUGMG1hc5SzQ3FQ
	T9e+wYJh90qOcEFRQnfHAx6xJXyY1lLj/tFwkgm9zI30J6ksC9F5Dg9r6ou7TVtgVZVB46bzSWc
	GfGXR3LXjyYy8RrJsjrgVrrY6TXs=
X-Google-Smtp-Source: AGHT+IHbjrzTx2SkLcGkOx9K3epO/NoEd+UbPWtoji5UGIZKEQS9iTqwz0l9Pkd8r6km4MzxZPHDVZjFWnv/Cb2EctA=
X-Received: by 2002:a17:90a:a010:b0:2d8:77cc:85e with SMTP id
 98e67ed59e1d1-2dbb9f6e1d5mr11014746a91.37.1726433373312; Sun, 15 Sep 2024
 13:49:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Alexandre Ferrieux <alexandre.ferrieux@gmail.com>
Date: Sun, 15 Sep 2024 22:49:22 +0200
Message-ID: <CAKYWH0Ti3=4GeeuVyWKJ9LyTuRnf3Wy9GKg4Jb7tdeaT39qADA@mail.gmail.com>
Subject: Re: RFC: Should net namespaces scale up (>10k) ?
To: horms@kernel.org
Cc: Alexandre Ferrieux <alexandre.ferrieux@orange.com>, Eric Dumazet <edumazet@google.com>, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

(thanks Simon, reposting with another account to avoid the offending disclaimer)

Hi,

Currently, netns don't really scale beyond a few thousands, for
mundane reasons (see below). But should they ? Is there, in the
design, an assumption that tens of thousands of network namespaces are
considered "unreasonable" ?

A typical use case for such ridiculous numbers is a tester for
firewalls or carrier-grade NATs. In these, you typically want tens of
thousands of tunnels, each of which is perfectly instantiated as an
interface. And, to avoid an explosion in source routing rules, you
want them in separate namespaces.

Now why don't they scale *today* ? For two independent, seemingly
accidental, O(N) scans of the netns list.

1. The "netdevice notifier" from the Wireless Extensions subsystem
insists on scanning the whole list regardless of the nature of the
change, nor wondering whether all these namespaces hold any wireless
interface, nor even whether the system has _any_ wireless hardware...

        for_each_net(net) {
                while ((skb = skb_dequeue(&net->wext_nlevents)))
                        rtnl_notify(skb, net, 0, RTNLGRP_LINK, NULL,
                                    GFP_KERNEL);
        }

2. When moving an interface (eg an IPVLAN slave) to another netns,
__dev_change_net_namespace() calls peernet2id_alloc() in order to get
an ID for the target namespace. This again incurs a full scan of the
netns list:

        int id = idr_for_each(&net->netns_ids, net_eq_idr, peer);

Note that, while IDR is very fast when going from ID to pointer, the
reverse path is awfully slow... But why are IDs needed in the first
place, instead of the simple netns pointers ?

Any insight on the (possibly very good) reasons those two apparent
warts stand in the way of netns scaling up ?

-Alex

