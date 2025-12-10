Return-Path: <netdev+bounces-244274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8876DCB380C
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 17:41:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 873B330038DD
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 16:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 007C7313E36;
	Wed, 10 Dec 2025 16:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ACHUdFPf";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="igSJZZXG"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7A420C48A
	for <netdev@vger.kernel.org>; Wed, 10 Dec 2025 16:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765384857; cv=none; b=joilTJiA6OHp/Yx2aAN9qtbIRt4C81uWbCOQnLLIhXRm4VI4KWP2Z1uazjejblfcsnKqocTBocrxLJ/5zbEMgGzZB7BK4oGEE9QLmh4iYrh39xc/STR1HsJQPGbHboMqF4PN/MYm1T/bmDQIl/F5O0UQbzactzC5bw5qv1oaCWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765384857; c=relaxed/simple;
	bh=uk7a3RSeceTCkfWroi5D6CytCtwy+0mYOEV23VXUXCo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rnOQMEArhqfoaQkAeR9YAO3JrlIdpj3HV4HDU2YgQUC9VGft5R/U3aizZftMwOa1XM3amts8z/gs6gutQnj64fKtzAinbYi33YiVdbXuPkW63U22HIpvfMlBylX/xpjo++msmo/h3PYvE4A5EGA8RqbtFwn8sH1M+C9cxK/o6DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ACHUdFPf; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=igSJZZXG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765384855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KMU/IRBc50u8JQly4DVwT36fO3xJSb9g5cdYx006Y5A=;
	b=ACHUdFPf+MzOEqgnkU4Ud7wNwyG0Z/Rp36c++gP/dcWQ7n+j+HOblX+dpeUlpa0A9Q8977
	seROIdHCdW9Ya+gtJCUPB5gzTpaewM01KAAJQ0DIWgfXbEya8XKZBunkig1nD+yO5aCZz+
	vg+Gbu3IkLB691J3kNfCW2zdyR0nwpQ=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-IKJWa-JGPweXoK3aOUbTFg-1; Wed, 10 Dec 2025 11:40:54 -0500
X-MC-Unique: IKJWa-JGPweXoK3aOUbTFg-1
X-Mimecast-MFC-AGG-ID: IKJWa-JGPweXoK3aOUbTFg_1765384853
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b7a041a9121so672357666b.3
        for <netdev@vger.kernel.org>; Wed, 10 Dec 2025 08:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1765384853; x=1765989653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KMU/IRBc50u8JQly4DVwT36fO3xJSb9g5cdYx006Y5A=;
        b=igSJZZXGSVme2WAqGxIRo2mY+fLBWObRn+pPQibObYQN+Vt3Izn8ZlqEJ/+F8/+T8N
         WqM0XqnVk8QhRodqx3SdCJ0tBmCwo15uMbqUGLG7aR5s7pWmS/JwfKJjUyISltE8mjM9
         03xsVKfwXEb5Gn+k6TxXgVhKctvbH0Xnhb3An9ITBk0ttFo2QtiYvWvlVMaEv5DQ0HqD
         yyRMtbOf6aayVvWBv/SBkGiFJx6slNmMBmQI448apLNGB8ge9VCGxJlpglWoS9ag9Ggz
         GmYTH5QKnttn89lnG0t8IIF8ErmciiKCOM1eMNZmNKglrUlto3RiOpfovEIbxsUF8U1l
         Nbgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765384853; x=1765989653;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KMU/IRBc50u8JQly4DVwT36fO3xJSb9g5cdYx006Y5A=;
        b=sPc8VqW16skTkFa3KjluAOZOdBZXignKQ1El4GEnMtfQLiTel/zRtGvKSVlDsXXzkr
         LstSv0BxWpZFd5QTLvY2GU8dwzJt2alrGZ0npfDDGmXDSPz1cvbv6QsGkmj+ysUtumL2
         7Ukj5uYiqAEZOAwUL2bA3c4WnKt6V+VkC4gzuFZCt5PS3eAx+hRoHiHRnrnvk1b3ihSc
         veCjbp2dJttB1PJ8Qhrco3gZ3QR45tjCGeqmGjhAeCotfeophNJvj7HCck+CVtxugIRB
         zFYyIvXR+0FDSE3L3/KX9vQYgFLdNtFMpQVADGvWHZelTVrZhbZyR9TDqun1Kt7vBOLP
         N42A==
X-Forwarded-Encrypted: i=1; AJvYcCXKDvjlerNUyV8iub9eMf0CMLB6FyotO/MGOeNwBipcWEmfIHT55rYj8jcWru0eWkepc0nrzA8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi5wdV74X5sB+4m9vMEpo9GkWhU6NVhdJ3K74rJEaDw5nn2UfA
	Uq8cyKE79l4X9KP0MRG6Tnr0NKlg4X+SkR31OSb9tY58Qi5prIkYRpOJIxvoqlG5nlGspXRLkln
	dmR6ySGe0ESlv0QionmPixrXFt5no9J2Icn47iqX3yEJjd4U30rtf/bt41w==
X-Gm-Gg: ASbGncsc0Ul2B26DEpE15kKgxhqvnYMx2hm1Cv556cqvvK0l5sUddkHr1vLwQOWY3+r
	QMOaea7FzTER1qsoIZiSYYwCzwRmiPjSdn/YoZ5XIu7yuHELiGXJH0k/pz929YmaeDxFFQPAep8
	D7uNJYs6CyBrJZrDI8Vi0haiOiXQlwoKKIVht7GNgsAp/uk8YgpCIbZB16RDqAYsDACJeL407cA
	xVqkBkUJt7T4emB9Db3g385aMHAm+MWkvcb7bL8bnQxnseT4M7MdzBvmXwOI/3I3P+Re8dHkjAl
	cXQnYH2lFahVetKmi9f6eeXcVs+ScUcb4NzHlaL8Fr4Mb2bU956yJjFNujriJzyQbYofwsFNdQA
	xywPXwdHiWuXFvL+nVswcLdHx98G+vTuIJA==
X-Received: by 2002:a17:907:94cb:b0:b7a:101:f86c with SMTP id a640c23a62f3a-b7ce82d34efmr370425766b.10.1765384852787;
        Wed, 10 Dec 2025 08:40:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGxCYaxBwmdqi6FSUGIRtPlqV2SSNwj1qvtR33wUpB/+5JxgAPXIn5dktNe1H2WNLCmp1mXUg==
X-Received: by 2002:a17:907:94cb:b0:b7a:101:f86c with SMTP id a640c23a62f3a-b7ce82d34efmr370422966b.10.1765384852338;
        Wed, 10 Dec 2025 08:40:52 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7cfa2ebb59sm3691266b.24.2025.12.10.08.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 08:40:51 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id DA9243CF5AF; Wed, 10 Dec 2025 17:40:50 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: =?utf-8?Q?Adri=C3=A1n?= Moreno <amorenoz@redhat.com>, Eelco Chaudron
 <echaudro@redhat.com>
Cc: Aaron Conole <aconole@redhat.com>, Ilya Maximets <i.maximets@ovn.org>,
 Alexei Starovoitov <ast@kernel.org>, Jesse Gross <jesse@nicira.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, dev@openvswitch.org
Subject: Re: [PATCH net] net: openvswitch: Avoid needlessly taking the RTNL
 on vport destroy
In-Reply-To: <CAG=2xmPCYdYBk9zc9EHt2dmGUBuXJHqnMLByac17UHOqSt2CFw@mail.gmail.com>
References: <20251210125945.211350-1-toke@redhat.com>
 <B299AD16-8511-41B7-A36A-25B911AEEBF4@redhat.com>
 <CAG=2xmOib02j-fwoKtCYgrovdE3FZkW__hiE=v0PuGkGzJvvBQ@mail.gmail.com>
 <7C74F561-F12F-4683-9D99-0A086D098938@redhat.com>
 <CAG=2xmPCYdYBk9zc9EHt2dmGUBuXJHqnMLByac17UHOqSt2CFw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 10 Dec 2025 17:40:50 +0100
Message-ID: <87a4zqmgrx.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Adri=C3=A1n Moreno <amorenoz@redhat.com> writes:

>> Not fully sure I understand the code path you are referring to, but
>> if it=E2=80=99s through
>> ovs_dp_notify_wq()->dp_detach_port_notify()->ovs_dp_detach_port(), it
>> takes the ovs_lock().
>
> The codepath described by Toke is:
> (netdev gets unregistered outside of OVS) ->
> dp_device_event (under RTNL) -> ovs_netdev_detach_dev()
> (IFF_OVS_DATAPATH is cleared)
>
> Then dp_notify_work is scheduled and it does what you mention:
> ovs_dp_notify_wq (lock ovs_mutex) -> dp_detach_port_notify -> ovs_dp_deta=
ch_port
>     -> ovs_vport_del -> netdev_destroy (at this point
> netif_is_ovs_port is false)
>
> The first part of this codepath (NETDEV_UNREGISTER notification) happens
> under RTNL, not under ovs_mutex and it manipulates vport->dev->priv_flags.
>
> So in theory we could receive the netdev notification while we process a
> ovs_vport_cmd_del() command from userspace, which also ends up calling
> netdev_destroy.

Yeah, I agree, it's not guaranteed that reading the flags outside the
lock will be race free, so re-checking seems safer here (and is also
quite cheap).

There does seem to be other uses of netif_is_ovs_port() that are outside
the RTNL, though, so maybe not such a likely race in practice?

Anyway, I'll respin with a comment.

-Toke


