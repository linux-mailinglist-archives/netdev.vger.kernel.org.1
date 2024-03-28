Return-Path: <netdev+bounces-82694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5154D88F436
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 01:49:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B06A92A657D
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 00:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C830ED8;
	Thu, 28 Mar 2024 00:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MYmnV0ww"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B637B8480
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 00:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711586825; cv=none; b=u/O8DYh35zJFsXljwEbGszPnBQifp+AmE/L1ulLQiCJjiF5VnSsAH3ciYcvyF13C7qQbdlBfkvisFg6RvCbxG1HnZSkQ+gcmP5Jg8e+Glgo1cIf+NRkIb0EYGE+Qctx/aQ9asC2xH8R+UIHywT2OE7yH4JnElqGtnaFbvvSd9p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711586825; c=relaxed/simple;
	bh=5O0BckSJkMcZIPPF6A3HpA/50UE6EVGOMA31bgfACvo=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M8VrcPxxFlN0onP2Nw4sdwRIRC0n3vwf/9u4EAevQRx7mN8/ZX7+jHffs4vqqrPzm+bme9ySQPFbKtvWdKKTcrnYRUlGdjtAlMCsRiJVV4fwEXHTwKaEG+SPxmzB2X3FXORRr+akikFU/NJpQd305onuYkRn6T087fu9K2BZPcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MYmnV0ww; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711586822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5O0BckSJkMcZIPPF6A3HpA/50UE6EVGOMA31bgfACvo=;
	b=MYmnV0wwdemAXau2PpCwdHE25KBOFYdhgQrXj4/zxrShB7IzJSqfgtpUrA3fRYf08bZWoq
	/dvmqNnfJFNrUmpg+v5LyihqT0j/pu0j1Ev+kW4PoBQYGs/uxGObeChtppd/XNF8TT5TQx
	iYlSmpA79fIKw33koS1UEk+h5GpekcQ=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-384-cfpnVazkNuiNSGp2PnOAxw-1; Wed, 27 Mar 2024 20:47:01 -0400
X-MC-Unique: cfpnVazkNuiNSGp2PnOAxw-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2d48517c975so1925181fa.2
        for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 17:47:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711586819; x=1712191619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :mime-version:references:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5O0BckSJkMcZIPPF6A3HpA/50UE6EVGOMA31bgfACvo=;
        b=bsocxwditm178grd4HfeMfyxFswhB8z8etRRrWhB+DUQgt4BxQw5FCz6kRh710wh0O
         yu5/pRdlccY+zIPNj68cPKYwwln62Jpj3OSOvgH4v9Gsxs8ogdAScGd41z5ZbwmKteSQ
         vkwUyIi6UO/YEz7j4+f0oxItn43l9gwa1BRAVUkDs1GFrXpDed9VBUQjb2Qs+pLprMn7
         aOXP2gJ0ibtCLG5qpDutRIg/6qHVsDFJ+ao/XKg26lR5g3ZVcFciRrcdAtgUvTK2oyP9
         2HHz4BbVxay5trTm0nuFxz+HWyHV0WFKAg8QcUCEkL/i9vEE/HngFr7n9xxGrI2uzqOc
         usNA==
X-Forwarded-Encrypted: i=1; AJvYcCVoGh38TYX4VMxJ7mPfOI+nszAIgOvOzMfZHlEIuI1FSy/otA0QjHvznTknz7oseWBQD7bVQU8cxoiDsRp3FgUmYUwvOgQZ
X-Gm-Message-State: AOJu0YxRDoZLPSovPemxGmWLjTLGPDw4w+hEflN5mR7cuYUusqpdt3rf
	11cQymjKOfUPo1O+zgenZnJXu+sBrimG7v6wUs6XbpooEJFlN2Km77QbxqwvT20ULWXXle7rSQS
	98RtRIIlt/pc6U/t4a5wDdDnJjwk4orCr2xchd55F3abbC9divWdn4ZzsTnpjGhc0QQAaPUBi5I
	TafEnz2JYtF5X1luEWqgTEMzXMjukQ
X-Received: by 2002:a2e:9f50:0:b0:2d6:f96c:d84d with SMTP id v16-20020a2e9f50000000b002d6f96cd84dmr867644ljk.16.1711586819580;
        Wed, 27 Mar 2024 17:46:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDWK6joV0/iQh5KlYwN44LS5IngAbC7R1Qkn/dm1JPxH6MSFYi0B6bfaI3/MpIh/ZUSeiKhOszWywYXmQfdeQ=
X-Received: by 2002:a2e:9f50:0:b0:2d6:f96c:d84d with SMTP id
 v16-20020a2e9f50000000b002d6f96cd84dmr867635ljk.16.1711586819340; Wed, 27 Mar
 2024 17:46:59 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 27 Mar 2024 17:46:58 -0700
From: Marcelo Ricardo Leitner <mleitner@redhat.com>
References: <20240325204740.1393349-1-ast@fiberby.net> <20240325204740.1393349-3-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240325204740.1393349-3-ast@fiberby.net>
Date: Wed, 27 Mar 2024 17:46:58 -0700
Message-ID: <CALnP8ZYMJufj1ALQ5ffojNaY6fj+K8rsSo4JyFx1qoSTjpXg8Q@mail.gmail.com>
Subject: Re: [PATCH net-next v4 2/3] net: sched: cls_api: add filter counter
To: =?UTF-8?B?QXNiasO4cm4gU2xvdGggVMO4bm5lc2Vu?= <ast@fiberby.net>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Vlad Buslov <vladbu@nvidia.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, llu@fiberby.dk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 08:47:35PM +0000, Asbj=C3=B8rn Sloth T=C3=B8nnesen =
wrote:
> Maintain a count of filters per block.
>
> Counter updates are protected by cb_lock, which is
> also used to protect the offload counters.
>
> Signed-off-by: Asbj=C3=B8rn Sloth T=C3=B8nnesen <ast@fiberby.net>

Reviewed-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>


