Return-Path: <netdev+bounces-276026-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0LfUOQ0a1Wli0wcAu9opvQ
	(envelope-from <netdev+bounces-276026-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 16:51:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 457DA3B0626
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 16:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1F6A43049706
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 14:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64AAB3093C1;
	Tue,  7 Apr 2026 14:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n8sRoLdb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F6430BB97
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 14:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775573240; cv=pass; b=rSFIqXaaImlwmwq0FOSUwWMtVDdxsIkbVqQjWDb5RnJPxyMLVUhwWfLaRGqi7QlZwur415Mp3eX9+mp01dMyNXdgbXlefxCW7bV/6Bo6mRwSXxTQ6WpaEByqGA5J870JSAcWQqssSTqeuSTAypz+X3Cxvoc7s9BVQflgcMxFW/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775573240; c=relaxed/simple;
	bh=OeEj/HXgik+5b8Gkgy3jnJFzvK2dtmMqmb+r6b1XYqI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AMf7hS18WnyYYVczAdOPh9yphgjQJQTFbwp3kwTedBI2ntfDHRzi840h8YnevQhR8WoBmPo6LPmrJuE4RHvFeymjc1nK9c5bl8rtQRsIoH/uaJGVjmSQGDndSIhAVrFxTPheX+XzyRKlrdt2j7InWR57Rgms5XO9hhjoUI2YQ/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n8sRoLdb; arc=pass smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43d01d6b50cso4859985f8f.1
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 07:47:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775573235; cv=none;
        d=google.com; s=arc-20240605;
        b=jLJ50XKXvREBqeJ1y8zI19qRZB4epGZTiFaTjZsAq2+/ocj8sh1tTMK1hJAWQYOeUs
         AGhBRg76/wEDMJSKbcB+Ao+IUnbnWxfFYlXnskE5gm+XPkjojS9tWBitKjZMSmV9/Iuj
         w+muTDJJtnLxurFKpN1pcIghws2cOnokZu4xqRONv1IlOQ1P5sw5n+gW48Qx5A+ivPBS
         dJ78KiTx0PtzF7vOaFoHDA7IRbT7M7FvByg63EbZj4Da5VhLCiGMD+YP5mK21tLjefaG
         oMBMwUJqnhxJEH24/eRuWD4mIQL5M5T6eJVfElYPcjF9Udf3cymckOSeEM8z+WmNtatc
         5aZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OeEj/HXgik+5b8Gkgy3jnJFzvK2dtmMqmb+r6b1XYqI=;
        fh=3HYU6NHT3q1jw7xb+wfzV1AJPFT6MUsdgJT0DeaRYb4=;
        b=TEqBpCs9WXKyK11FOJUDcaRvOV9xuC5Gdd3wkpExSrR3F/C3Pdqlp7gQcf8XHm1jel
         xePwoHNyc7GkkoUX23LoCsMs1fUa2cw/bRCdsJPHupB2M2/KL/iC/viRHvHK93WLywtk
         xmCebJp9RqmVR9rdDjxXMa0nEa4Z5gjefB/HW04+arHeUm+Wy127TfL+KYWJEq4CK0A5
         vZK4JxV4nZKA16W0NLV3iUczrUMfkVb2TrGt8UtDR/HDzjnNN8tAqRzB7w3hccpK/LCe
         ZfvinRXG+JoWyLrfn9DCFjcZMDzsjbWHjZJpfQLqlhg3b8g7YgobY86quPIuLTnKMNsp
         nBwg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775573235; x=1776178035; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OeEj/HXgik+5b8Gkgy3jnJFzvK2dtmMqmb+r6b1XYqI=;
        b=n8sRoLdbGYa2E6FSeh4l88AhfVwsCr+GqAFcl17NRsyxrYGWHg7oGJGl4JonMKEYAM
         Q1GCLsTeYCVZ/9tiRbp+OuJHEq52aDGGZivtBQCXFGm2+ZRslM4ods4mB0cwZZadrzCw
         kSLg0QFY7e7gQGuwJ5FhXQIq7aUFy8nTlx/SDs7/sdznNmB+2hFknDfMq3FWEUrla71C
         55FBPCryNoaQ47QH+LgW0cQFmC7D5e8KiZ6APEgHxg9S8+nNb4auHG0wKIRJ7MzWvTVI
         K7XHMaVJv0JuDXXS/7RseT9Z3spfEU+16cx1m30DWtp3KjGNftSvrbygn9u1Oz+TL1kU
         HfMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775573235; x=1776178035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OeEj/HXgik+5b8Gkgy3jnJFzvK2dtmMqmb+r6b1XYqI=;
        b=ZDJXELtlBq7Fe5GN3A6G9O7twCCbuA8p0o4wUfZbXUrnuOnUmmUT2xskkMgsz1YEO0
         AxCTLvuOcTRMdGD3A7TP1SrS/KzfoO+8VmkGuY4ppX+0CgZ/pitvfOvR1tq+JH1h36xW
         cRK/3zZlxH7YmQHhEyFVEu2lYPhZNbRVDDdmIhF+2ezEyNgR8fnmoQYTg8DWCQX5k6SJ
         tQZ2jlqJyqGZ4rRT0xNOM+2cvc950ejWih1sULy9nnEdIQY1DNIOy9eZ0K18tFIjPafK
         +JjodB7OUGwZSTJRofmAkuGVgMYbFnGqMicK4hTWsayLzlLGGWTvtqteQ6h3rGdCc3RK
         Mokg==
X-Forwarded-Encrypted: i=1; AJvYcCUrvnqt2yx66WgZ2O8/ANcdheqyuWi1voie11ruu0n5AGFNVugBFLehT0CvcA2VnL8c4UFLmOI=@vger.kernel.org
X-Gm-Message-State: AOJu0YynSCYpKn+CH4BerB5egyPbny6PI5iMdMRaD+625HLHQ4Oz3SEA
	3k75Vn1di0Ru6aBsIIATOPdh1br1uWZtmsomJOalIIQMLrqwXDvYVSZwWg1ucl8G/wCjFlfqVxQ
	ECNh9ltN5I2jn9Azfml3+4WFeWK4yYQU=
X-Gm-Gg: AeBDieveYejFjk795U3xgXBiDJ3IMu4OCt2EUn4OWdu0NU7pu0KlowuBPMxFDwLK5F6
	koqIKbv8QOf7BHMZS1KMXT1Fsx9dBnbt8LU/J6tzvKthJQhTjX1u1mEfhpXHqzILELLPMg2sJYx
	YOtSThQCB+K9KQrsAKZbnlAJdcDSUstcs5k5vdqidmp0EzXzydCx+lYqKkex271DIaTlxEM3f2M
	SYDq4rMR0NaeNUUuLI0iD0yUiZdH8/FqYSyEUUnTZxOKOctn5H4qMrv+hnXbSqJ40TYVlYg8WGf
	SUqp3lPqmD9iOmrwR2f7/dBQZE+YBusVXTSbT5J4rvjF975LwQp/yav3Ni8ZRZk/UR14YWhpK4i
	ZG5RcxJMbQ1Q6QLDN+X7qQu8Aig==
X-Received: by 2002:a05:6000:e52:b0:43d:303f:f358 with SMTP id
 ffacd0b85a97d-43d303ff3c9mr14598152f8f.2.1775573235071; Tue, 07 Apr 2026
 07:47:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407060203.3391-1-adithalex29@gmail.com>
In-Reply-To: <20260407060203.3391-1-adithalex29@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 7 Apr 2026 07:47:03 -0700
X-Gm-Features: AQROBzDfw806rbk62zqGXz60VYbL74dh0suuu09-A-cSlhpc4P2RimlV4vGLOSY
Message-ID: <CAADnVQJ5g8VKSiSLaN8KBSi3jZc0U4C-UEZeXrPVxF+ZMz6jZQ@mail.gmail.com>
Subject: Re: [RFC bpf] Ingress RX queue provenance across cpumap redirect
To: Adith-Joshua <adithalex29@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-276026-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexeistarovoitov@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 457DA3B0626
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 6, 2026 at 11:02=E2=80=AFPM Adith-Joshua <adithalex29@gmail.com=
> wrote:
>
>
> ## Follow-up
>
> If this aligns with intended design, I would be happy to explore a concre=
te
> proposal or implementation.

No "follow up" please.
STOP sending AI slop to the mailing list.

