Return-Path: <netdev+bounces-236826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 352E5C40665
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 15:37:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4B1E3A9A3E
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 14:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C72722D46B4;
	Fri,  7 Nov 2025 14:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QetdWTll";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="AZiuTRYo"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F572765C5
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 14:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762526067; cv=none; b=b2Xm0avxhZ3yk83hpc99oLC+p2C/8MtrgWoHdY/8Bj+/VhLvb6aXzsLONLjYZKtXYmOFXH4EPPorVPH/CCAzspW8EC4EFynyS7kGBs5rQQ7XjEUE/Vf61p/0ZMXTgzXKhRlj0xutMcK1wxNXcsSwamOrpVw3iulbyNT7QhJVU7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762526067; c=relaxed/simple;
	bh=C7Xy2Vm8TJUF8IpWN7Qe7y0EEaxuSO98Vopih90RDOY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YQ8QdqiIvuzHVwkGIv/0BviR1lvdHpz2S+idtrwuUyAzc122iR3vwVPAxRBtVEXqW8HDsGJsH/7bNbPqOObrCyBr8xyPjEjJqHYb6ZoRiw1wQn2y45dw25cDMsnQlJ6En0TTtniteMwqeF4UbmX/BjkBPPB4XQTpTsHaGzz/8Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QetdWTll; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=AZiuTRYo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762526065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C7Xy2Vm8TJUF8IpWN7Qe7y0EEaxuSO98Vopih90RDOY=;
	b=QetdWTllycUCBglQXfldAQ08Ps7kdCnAi0kW/ZLKonxAD36zXd+46Grk+TbKNMKW9tG74H
	navLBZeNSFo8O1mk1WjCdYA60Tptc9AFYFbd5ZhsZv0/gz4yYLEAcb2wrgiHwNhDGrg+QQ
	PytoNu3PL4GQ0vt+88D/BnXoW150Zs4=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-E3gk_6sIO66ty9hV9RIugw-1; Fri, 07 Nov 2025 09:34:24 -0500
X-MC-Unique: E3gk_6sIO66ty9hV9RIugw-1
X-Mimecast-MFC-AGG-ID: E3gk_6sIO66ty9hV9RIugw_1762526062
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-6411d877fbfso1100399a12.0
        for <netdev@vger.kernel.org>; Fri, 07 Nov 2025 06:34:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762526061; x=1763130861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C7Xy2Vm8TJUF8IpWN7Qe7y0EEaxuSO98Vopih90RDOY=;
        b=AZiuTRYouKgpcBrbJMFV5HditO0dA2q3tm1ZwuBHGMmzkaQRAUwtIl7595sZmIq5oU
         +8P1YcjnvYarV6qoyJfrO4WeUby9X2bOpYEP57YjOGuLYHTwMzEeNUg5o9qYf3OsIfPV
         AyDc7JrsuqwUh+LYncir28sfbokz/A7n62BHSzaHPfnxTfErCj86azTMA8HNvCxq4y0a
         eP0bJV+9QDkiKiCInMMUYIhJOfEdTRoiwAKD6bfhuR4gROrwEma0djbbCYyQDAonjAvu
         qmHQrkEVuy6kVeWq3rsrHJUZiKy5kyGDYboR1Ki/LiLKbT5N+SXywRwO6J4dWUeiZ01n
         gKKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762526061; x=1763130861;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=C7Xy2Vm8TJUF8IpWN7Qe7y0EEaxuSO98Vopih90RDOY=;
        b=W+H03QY/zDUZ97grsk2JyKvD2MJN0urDJUIDUnsVvA3WdGGtIhbk4RMI8mlspGzMDa
         x/ZL7YFhcFDg9yzqTZ4TTl20snXHu/gpocbcKyLUV4udCzF6zjyCPCaJp65EeOlFXbH5
         ZY02P1+3FtrBpuHQqfXwuqlqxv0tiuaevRQKeHuForVZh7qCt0sRvmJCXgRSaQodahY5
         TwmnAUaewuNURh5XaxypoZF8e4uVB6ujBfUoP1HXyzFh5V3GLwm70zrpzU9Wlwv9vmM2
         BcUlarCpeYhkhHAlIY8AIwjJgozKi26Vjkcnar2oTRNk6jCwFMHaZ1NeQCk3GEmGZwWf
         cOgg==
X-Forwarded-Encrypted: i=1; AJvYcCXHPbs3/KAANXy495Jq72GF/TGpddSn+LvCBcISly0X7DIkPdpE7cUqzO865vwqD+XxgoyMrzo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0fNA0UBYVAh+1GrUshKr9FiofwR0JkbZt75MXLvVPiYECbD6n
	g0gCO1RmF5/nXKb1kSgzVJHiUWCaaIjzAKYMIhzNM1MZW0lHiH07cCrkyZDlksm1jQ/mfRmODUR
	ltms137T7/cC7YAVz1TQL62H2rzw/7D+xkg1XfW6RV+63eHJHcA+g3u5NXg==
X-Gm-Gg: ASbGncvVDDJ5x/Tf+f67DtKim2HRo2sapx6idpUoZkf5k9NOQL1lkozzrGZaGrIxaVL
	mMIIpYnyxXzEdCMZLdrYMViDbqiDwHa7sASPP7074zMpr77sxxOY1a1kMHWnGpFchv4PT3LLg7o
	2ADuViRNoHvBxsoryETsUClhTeHGWFU1G7pkj4UEjJiTX+JP+Rze9uuRHODcrt9V8f5PnSqW4II
	t1F5wh801nVE/ig+ZsAKkq37EzVeNW6A36gsXU3Y55R5Ln2ZVL7nk8gW8B+Iq2lGWRSloELsuMA
	LKd1gSh7DJ5i0jEbLB2lR44xp+BEfqccYjZc+PeoL6aHQxLo/2LyjvvXfQdAZB1HeH7kv3c20pp
	f1nt/JaNI44giBe6Fm3LPFC0NOg==
X-Received: by 2002:a05:6402:42c4:b0:640:eea7:c950 with SMTP id 4fb4d7f45d1cf-6413eeca1e5mr3554770a12.13.1762526061668;
        Fri, 07 Nov 2025 06:34:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG5rFMQbr7lj7QkZ7YxE9lVDh4LV0o/uagjhRGZ9H6CcUJCHqn2X44NmYmLtmtaGdEs6jpeag==
X-Received: by 2002:a05:6402:42c4:b0:640:eea7:c950 with SMTP id 4fb4d7f45d1cf-6413eeca1e5mr3554739a12.13.1762526061306;
        Fri, 07 Nov 2025 06:34:21 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6411f86e9d7sm4235256a12.36.2025.11.07.06.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 06:34:20 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id AE74D328C60; Fri, 07 Nov 2025 15:34:19 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, Willem de
 Bruijn <willemb@google.com>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 2/3] net: fix napi_consume_skb() with alien skbs
In-Reply-To: <CANn89iJsH3iGuFct0DrLfN8tiga5hNKBQXsX-PgOWNERgHwqMg@mail.gmail.com>
References: <20251106202935.1776179-1-edumazet@google.com>
 <20251106202935.1776179-3-edumazet@google.com> <87ikfmnl15.fsf@toke.dk>
 <CANn89iJsH3iGuFct0DrLfN8tiga5hNKBQXsX-PgOWNERgHwqMg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 07 Nov 2025 15:34:19 +0100
Message-ID: <87a50xoqs4.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Eric Dumazet <edumazet@google.com> writes:

> On Fri, Nov 7, 2025 at 3:23=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <=
toke@redhat.com> wrote:
>
>> Impressive!
>>
>> Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>
> Thanks !
>
> Note that my upcoming plan is also to plumb skb_attempt_defer_free()
> into __kfree_skb().
>
> [ Part of a refactor, puting skb_unref() in skb_attempt_defer_free() ]
>
> TCP under pressure would benefit from this a _lot_.

Interesting; look forward to seeing the results :)

-Toke


