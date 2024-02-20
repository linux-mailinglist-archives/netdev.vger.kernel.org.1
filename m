Return-Path: <netdev+bounces-73258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6907685B9E8
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 12:07:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D4351C20C3E
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 11:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B17265BA3;
	Tue, 20 Feb 2024 11:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UM60vKtj"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D055629FD
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 11:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708427237; cv=none; b=CoUH5cWbDPJNxgj4dFV8JFXUSbk2O9X6FATDYr/edmmoBk51Br7cnNUSX1WSuDM+FGG6Uumoio9pX4SGnVhy8lHKE/LlBlpnMBiP8oFDvopOd0IyjL9lzU4OOh59vgNGzWwcCCV0clXrC4hTuOGM6U1QhGIIvYYmM0niiSQOxmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708427237; c=relaxed/simple;
	bh=Lp8dCyYds4xZe7wmUp37l/j23b84uGujZXcBdTXYm4Q=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ft3kfmF11eIWHQMsZ9fe1OKK2EZ9CNQkPDHNiVsM89NHXsIu8NsBExizFW85sKXWsOGeQBJOgfxfhnDZpDLO4pkhjsrYZkXl1w2dh6YoSG+d8Tz7QqcPvxTJaZl6+2YJhTF8MA6adbbqCp3iULYePrfGBpzCEwoqZzcRG8jZ7es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UM60vKtj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708427234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=cZAyF/dK4C8hNTFrZ5l2vsstAGvzlJ0WSWJrvB9gfl4=;
	b=UM60vKtj9wM5uQXOioJYS1xhBKV77DQco3jfpHETQ/I6UsO9QSl7etVUaaKeIn07CtuHdI
	jGT9spBDNgw7mBHo31dMnjaNWQq3gVAe2BQj7osDMRmSTkF/QFlOjNwz8jktyOh8HPrcXt
	x/vEdClSIYW9zgVbMR+HXGk1/4H7TRY=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-132-33QN5HbzOgClbMBNrFOZyg-1; Tue, 20 Feb 2024 06:07:12 -0500
X-MC-Unique: 33QN5HbzOgClbMBNrFOZyg-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-51133766a92so2123019e87.1
        for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 03:07:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708427230; x=1709032030;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cZAyF/dK4C8hNTFrZ5l2vsstAGvzlJ0WSWJrvB9gfl4=;
        b=q7M3Mq/OC/ubWSE4lFs2UV3Z37XFW4iGuH6TF0iMmKZfoRq694Fq+xwzeaRaezA4mX
         k5r2wyOqH5jApC8L0J5VbnaLo9mF6cGjKKSTVf8r89CpByUjh4mKOoJVd+dnbkisGOgS
         UfEdCu2AQprFRLg0F+Afc081aAPf1b/CEnUHt05D4WhkpQERgvLzOundtac/qtdN7BaX
         b4YnsRH+mdBZhgsNofknHxb42Ya+Mt79cb377GPVFl+UNNs9QdI21ZtR9/EfAYLGpFqJ
         ODJyzLSsmujasmZHOI/r4+jfu3IxFLiOq8Me3mYv6nXFy7A3JJWrtPxhtdM/xs+PCLbO
         msmg==
X-Forwarded-Encrypted: i=1; AJvYcCWBlGz4rfPGEKELDe6JrB4Q84yPIUMKCH8Cfww6gjSrtip8t7voGsrPdXg4mNsY3+I4K8W8AOIqelqSeI/40OJggeFzZjwH
X-Gm-Message-State: AOJu0YwfqQ/lFUQpp/VNZJ/VJwZo13frGLwJ62cW/5J6VaUqDg8rNXZe
	J3xc/lk/czQZoGLkfEwS0Oq6Mx08gK5lFepHti+g4LzNfCrPk08fHRKh8ST43MIVVI91IF/4LSx
	kGKoCSWi3mIaY/bgjiVn8ObOUpwHMAL3T1pj/1tlxHpOKd19u6+v6nA==
X-Received: by 2002:a05:6512:ba6:b0:512:bead:a28d with SMTP id b38-20020a0565120ba600b00512beada28dmr2224270lfv.5.1708427230547;
        Tue, 20 Feb 2024 03:07:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFs2Tkbp8dJDY2Dx5+bR/tkmoWefJVe8ynukJXXtD4Llb5hG++Prg2rkksWZ6WwAsLo+Sogrw==
X-Received: by 2002:a05:6512:ba6:b0:512:bead:a28d with SMTP id b38-20020a0565120ba600b00512beada28dmr2224259lfv.5.1708427230102;
        Tue, 20 Feb 2024 03:07:10 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-230-79.dyn.eolo.it. [146.241.230.79])
        by smtp.gmail.com with ESMTPSA id z27-20020ac25dfb000000b00512a87ed7b2sm1079808lfq.190.2024.02.20.03.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 03:07:09 -0800 (PST)
Message-ID: <6b3e0b63889b4f3764bf7d2c2d761440d2ee02d9.camel@redhat.com>
Subject: Re: [PATCH net] net: skbuff: add overflow debug check to pull/push
 helpers
From: Paolo Abeni <pabeni@redhat.com>
To: Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org
Date: Tue, 20 Feb 2024 12:07:08 +0100
In-Reply-To: <20240216113700.23013-1-fw@strlen.de>
References: <20240216113700.23013-1-fw@strlen.de>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-02-16 at 12:36 +0100, Florian Westphal wrote:
> syzbot managed to trigger following splat:
> BUG: KASAN: use-after-free in __skb_flow_dissect+0x4a3b/0x5e50
> Read of size 1 at addr ffff888208a4000e by task a.out/2313
> [..]
>   __skb_flow_dissect+0x4a3b/0x5e50
>   __skb_get_hash+0xb4/0x400
>   ip_tunnel_xmit+0x77e/0x26f0
>   ipip_tunnel_xmit+0x298/0x410
>   ..
>=20
> Analysis shows that the skb has a valid ->head, but bogus ->data
> pointer.
>=20
> skb->data gets its bogus value via the neigh layer, which does:
>=20
> 1556    __skb_pull(skb, skb_network_offset(skb));
>=20
> ... and the skb was already dodgy at this point:
>=20
> skb_network_offset(skb) returns a negative value due to an
> earlier overflow of skb->network_header (u16).  __skb_pull thus
> "adjusts" skb->data by a huge offset, pointing outside skb->head
> area.
>=20
> Allow debug builds to splat when we try to pull/push more than
> INT_MAX bytes.
>=20
> After this, the syzkaller reproducer yields a more precise splat
> before the flow dissector attempts to read off skb->data memory:
>=20
> WARNING: CPU: 5 PID: 2313 at include/linux/skbuff.h:2653 neigh_connected_=
output+0x28e/0x400
>   ip_finish_output2+0xb25/0xed0
>   iptunnel_xmit+0x4ff/0x870
>   ipgre_xmit+0x78e/0xbb0
>=20
> Signed-off-by: Florian Westphal <fw@strlen.de>

This is targeting 'net', but IMHO looks more like 'net-next' material.
Any objections applying the patch there?

Thanks!

Paolo


