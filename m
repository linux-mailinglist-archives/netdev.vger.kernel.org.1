Return-Path: <netdev+bounces-117622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1143294E96A
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 11:11:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 439B71C213F8
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 09:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8EE16C852;
	Mon, 12 Aug 2024 09:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HpKmYotQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C31A1586CD
	for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 09:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723453910; cv=none; b=WlTt2cnbhQwy809TkvOlI29//bFiG4Itps40aauUVJ1bO/cRwgG5DtZfHQhrEU8TGRsu0SwjRfzqzpH3fcoj89a8CzgK+FEJVBbVpRb/sHs1oUG5RWeVcEK+PCDczgftp1IWGp5DiRAYcDNP/lFo+CNp/CGhIgACqq0mIR+lTEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723453910; c=relaxed/simple;
	bh=bzZY8eUtnqlBbKQu453uN5L9lIeKBY2OifFcuBR7kJQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YT+toalAu2J++HMlBLZ4JDpxzo34YNsL7k9j1x2zd/prBVfrqOrfGbRJyRKj5fSZU2OBABeBco9SN7XwKrWojgThanzQ/ysMeZLUZwS8+r6r698ENK2lqYXl4vVLkGjLEc/xEazrT9FqIN4s2Ek/HdPwFWyIucbWQMejlh74OKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HpKmYotQ; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a7a975fb47eso459810166b.3
        for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 02:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723453907; x=1724058707; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bzZY8eUtnqlBbKQu453uN5L9lIeKBY2OifFcuBR7kJQ=;
        b=HpKmYotQwqo7q7mP4eBq7s0/fmZJxvl7nZP6lTsfcxxl/U0N8PemNp515LIIpqjI/c
         zBoBznARvcYHwNVyCAu2cnSOKm/PShJlwnm1XWDrkhO/NNC/IFEuOZp0zuE0upT+WwJq
         ofvzbScWzhlu7qJnj7excqxdrBOEW58rqhDP8gXYXtPbtpY3TPaprTjkgKhWTb7QUkm+
         RUuDn29h+Kmd8UQsjOyD+o1cBtPKPe2kZgIbT77haALd8j8WcOofAqLJnB4PhdRQcBpt
         M+NMbFAF+tbU10T8XVBgGk4pPAT0cE/FqZi37y+BNaq553MUprWjM+I2YJd2Mc5WIfyL
         /DsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723453907; x=1724058707;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bzZY8eUtnqlBbKQu453uN5L9lIeKBY2OifFcuBR7kJQ=;
        b=kUkRUgZn+5+jUAItgB1CJbT/Q/s3L+QBU/3S22pQH4VaTb+YF796JaBSp2swqPZ0ri
         /F5UvKF4zKP4u8TX9rPjuuJmARWkrW5NEh+eVh2eHqIUoW3/10Ge4WilSziybES6UWlS
         jrYDah7owp1q1HrnYFI4qRCBiM0a7SlM5mxe0elMIGSr3TWpwUA25LYk16Szm9RBr6so
         U1FcMZvhHx3JGHdlIdTCavNqUP1OvnDmfQ2Egvr+VgKK5ljnn7xS8AMD0mXUwgIN4dck
         AuqGgb4K8Glh2H/TJUWhriR5NVV4m442EG6xAeU0VyneF5OYpwRMStPnsc85lkRiGIP5
         uIdA==
X-Forwarded-Encrypted: i=1; AJvYcCXNEVm186SauoHIZiqSd8HIxV0Bsi6bjGp4CStOXw/I+g7Ezb/R8Y+Zh2oAVf6NrVJ+uMDz9rCHd5I7fSetVH4kUKPDaQKW
X-Gm-Message-State: AOJu0YzwDpRzT7UF3dhSPioSrHV2JtNQ1nbUGYalE1hiwDeP4i6dUjpN
	lKuMjQCQZSW64ozQ3J7+NBZSMKttPbZWQRuVE7R/uk8INd165Qse7OnLLl/tNF4a7lC7L7m9ZN9
	J1zkHylI6fLJiQikxsK5fr+LWawI=
X-Google-Smtp-Source: AGHT+IEvtemmznDYp7BrTXZ6iEKkkCmOm7w1L1kNyYhkm95bCUImTPCn9287prvJzKkiFhGfDg+wyOxkn8AgkhK3swo=
X-Received: by 2002:a17:907:f1a4:b0:a7a:a4be:2f99 with SMTP id
 a640c23a62f3a-a80aa59ad15mr631317066b.22.1723453906677; Mon, 12 Aug 2024
 02:11:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808070428.13643-1-djduanjiong@gmail.com> <87v80bpdv9.fsf@toke.dk>
 <CALttK1RsDvuhdroqo_eaJevARhekYLKnuk9t8TkM5Tg+iWfvDQ@mail.gmail.com>
 <87mslnpb5r.fsf@toke.dk> <00f872ac-4f59-4857-9c50-2d87ed860d4f@Spark>
 <87h6bvp5ha.fsf@toke.dk> <66b51e9aebd07_39ab9f294e6@willemb.c.googlers.com.notmuch>
 <87seveownu.fsf@toke.dk>
In-Reply-To: <87seveownu.fsf@toke.dk>
From: Duan Jiong <djduanjiong@gmail.com>
Date: Mon, 12 Aug 2024 17:11:35 +0800
Message-ID: <CALttK1Qe-25JNwOmrhuVv3bbEZ=7-SNJgq_X+gB9e4BfzLLnXA@mail.gmail.com>
Subject: Re: [PATCH v3] veth: Drop MTU check when forwarding packets
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@kernel.org>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Sorry for responding to the email so late.

>
> I do see your point that a virtual device doesn't really *have* to
> respect MTU, though. So if we were implementing a new driver this
> argument would be a lot easier to make. In fact, AFAICT the newer netkit
> driver doesn't check the MTU setting before forwarding, so there's
> already some inconsistency there.
>
> >> You still haven't answered what's keeping you from setting the MTU
> >> correctly on the veth devices you're using?
> >

vm1(mtu 1600)---ovs---ipsec vpn1(mtu 1500)---ipsec vpn2(mtu
1500)---ovs---vm2(mtu 1600)

My scenario is that two vms are communicating via ipsec vpn gateway,
the two vpn gateways
are interconnected via public network, the vpn gateway has only one
NIC, single arm mode.
vpn gateway mtu will be 1500 in general, but the packets sent by the
vm's to the vpn gateway
may be more than 1500, and at this time, if implemented according to
the existing veth
driver, the packets sent by the vm's will be discarded. If allowed to
receive large packets,
the vpn gateway can actually accept large packets then esp encapsulate
them and then fragment
so that in the end it doesn't affect the connectivity of the network.

> > Agreed that it has a risk, so some justification is in order. Similar
> > to how commit 5f7d57280c19 (" bpf: Drop MTU check when doing TC-BPF
> > redirect to ingress") addressed a specific need.
>
> Exactly :)
>
> And cf the above, using netkit may be an alternative that doesn't carry
> this risk (assuming that's compatible with the use case).
>
> -Toke


I can see how there could be a potential risk here, can we consider
adding a switchable option
to control this behavior?

