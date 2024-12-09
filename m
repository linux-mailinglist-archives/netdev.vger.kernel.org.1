Return-Path: <netdev+bounces-150406-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C89D19EA250
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 00:01:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4463B163C0E
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 23:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A300719F13F;
	Mon,  9 Dec 2024 23:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="wmE8+hxb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA70919884C
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 23:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733785257; cv=none; b=lZQ0yQvPy3/i1eAkw1xV5Tvn0k6pFN0GWRzucC39m3DtR9VHt6d5K1cXp1mSGfC6GDCD+bodD3ywlIkbBxpD8ufV9gp1KLPSaOmwuTcqm+gKmBgnon6hAXGveJzFUqFkF+l8M2YskfK2A/s6PE2R+8GvgZA17jQp10DMmlomaYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733785257; c=relaxed/simple;
	bh=ZT3GdiHB5YddOdoINvPd3JXTw5o0wS6zkw1cRcwR+cI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eopN1UmCXPPL9AngzSNQ1SjiRPOLSBoHc6MLejqvJH0llz/kRSJwhdAPn+FLFMhlr/5UDm/fu7mqr7mnSRPN2EgY7nF+l2sqZFncwx/TXb4GhBLaD1Ws76SWI0QwvNBKnZZoG4NlWORoby/1LhJFXloyGBFFBRnZM/ZCSXwz/l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=wmE8+hxb; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-725ecc42d43so1154519b3a.3
        for <netdev@vger.kernel.org>; Mon, 09 Dec 2024 15:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1733785255; x=1734390055; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8rdqTpO2uA1Ykp81jesT1emUsHbdy9YgUbLnxTQ984U=;
        b=wmE8+hxbyMLI2u+SXv/TaLIks5GKBjLtiqxn+G1tuV1o5ba4RkWC8m2MMJGQRmqI1k
         3RPtaMgGm1qzJOpAm1mDtz8cjGPam1TBmVaIJzxq2JicwPwobf3RcrXYPuNX/3JwP0pO
         Hv00J744wUToH0jWuQWNOJ7W4CQ9g9W8rKRA6MZeVmyeA0mhoyR9vTpEk7WVbpUJ+0da
         YpjwwsJSmmVPbIpgeN+3m//MrSk6kT53zek5b92v1SD02S+VhzdOtmITk4bTvawCrRxe
         bUh5BseFpwKFipQvulzc5hfXrYtt6rWYmpjfLG3Jj4R/b/vyXRNmgQzD9JAf0sdTPrhg
         KSJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733785255; x=1734390055;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8rdqTpO2uA1Ykp81jesT1emUsHbdy9YgUbLnxTQ984U=;
        b=s9MQwX8Om+R5jnVkGfh/PCaVV1IDgeoPOgAfOuHkS3te5Oj1Mtd9AyPviMML+DtCzo
         c8g6ic82jqTDo+9wKprhHeegqygL6Y1bzdkZCXKbJwmzlWAdDFIVk816VjAtsRf9HPxB
         VBOK+HyohycIoA46V0ybW22LXzz2zgHoXe/WDKXpH8zikYJ+OnlFbViR1KfC3ESaZb5y
         vEJCkXYfKilKe/EfoQAjfHSpPBJNiiYcvkTnaznWuhcy4ie8e1pvHppbddlVmV8MW5cP
         okx7cbsWo3b8mC0dLIwRmIfghyw0Z9DLIcmcMgiz99g6mbZ3da3n8rQqcLZrdNhzHUss
         Sm7A==
X-Forwarded-Encrypted: i=1; AJvYcCUnO8pHzIKVIW46FJOjND1r4iVMZV9z5PGjda8EFMtyzx7MTzqlb/EAMwdU6mNnzd78WcMPyrE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVMhRZeEZIPSM/F67EhcUlaUs39tkQF04HUUB17aXf31XYg554
	3TMfc4M5JWNyny3ONg/5DW7alG2kEJFLZaZUZG95z23bUmmhd32TBYaXq72PFQA3UrnJUM9hyQx
	Dhgb+8TbgXSZtRCMowhs174Ef88+OVtqI9+Vj
X-Gm-Gg: ASbGncv0XtyNOP/ZwZUQdKjbXiPRZuxDK6uetqzN76V+QOEoyv7AJAuALReU2jdZgSz
	NS0Xh/yXWyxBorQzCtfB0LA2C/e1VdUxgPg==
X-Google-Smtp-Source: AGHT+IG6WKU6sgAkakV11JKiqBBUmy5CZr+tK6ahkhudY9xN8p7Xb63u2DWQaS54pYrmBuUuBf0pO1kzC5tBKMzAJx4=
X-Received: by 2002:a05:6a00:885:b0:726:41e:b32a with SMTP id
 d2e1a72fcca58-7273c8f1d15mr3403673b3a.4.1733785255122; Mon, 09 Dec 2024
 15:00:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209-cake-drop-reason-v1-1-19205f6d1f19@redhat.com>
In-Reply-To: <20241209-cake-drop-reason-v1-1-19205f6d1f19@redhat.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 9 Dec 2024 18:00:44 -0500
Message-ID: <CAM0EoM=KWpQMcFrHiDPH=FM1raL47McVkCYBMGHBcScXGY_z3Q@mail.gmail.com>
Subject: Re: [PATCH net-next] net_sched: sch_cake: Add drop reasons
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	=?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	cake@lists.bufferbloat.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 7:02=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <to=
ke@redhat.com> wrote:
>
> Add three qdisc-specific drop reasons for sch_cake:
>
>  1) SKB_DROP_REASON_CAKE_CONGESTED
>     Whenever a packet is dropped by the CAKE AQM algorithm because
>     congestion is detected.
>
>  2) SKB_DROP_REASON_CAKE_FLOOD
>     Whenever a packet is dropped by the flood protection part of the
>     CAKE AQM algorithm (BLUE).
>
>  3) SKB_DROP_REASON_CAKE_OVERLIMIT
>     Whenever the total queue limit for a CAKE instance is exceeded and a
>     packet is dropped to make room.
>
> Also use the existing SKB_DROP_REASON_QUEUE_PURGE in cake_clear_tin().
>
> Reasons show up as:
>
> perf record -a -e skb:kfree_skb sleep 1; perf script
>
>           iperf3     665 [005]   848.656964: skb:kfree_skb: skbaddr=3D0xf=
fff98168a333500 rx_sk=3D(nil) protocol=3D34525 location=3D__dev_queue_xmit+=
0x10f0 reason: CAKE_OVERLIMIT
>          swapper       0 [001]   909.166055: skb:kfree_skb: skbaddr=3D0xf=
fff98168280cee0 rx_sk=3D(nil) protocol=3D34525 location=3Dcake_dequeue+0x5e=
f reason: CAKE_CONGESTED
>
> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal

