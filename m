Return-Path: <netdev+bounces-88217-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA508A6599
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 10:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DD351C222BE
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 08:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E066084DE6;
	Tue, 16 Apr 2024 08:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="is7Wha1q"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A1E75808
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 08:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713254494; cv=none; b=ZHB2ngb+f0Uz9VpzLbD45kWghho6IyFVajcSypBjmQpKBFW8DgRQwCg5GGZtuK2jCKQ46ThdNQJ3TCFP6lektVUTzJ9PYQ/NQENbBb41L9IH5UelhQkfC4QprsJXf4GgJPRprJaIt6m2b4ksNj/9O3ap6vNdwMStBpguIJLbY1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713254494; c=relaxed/simple;
	bh=/5PSh3gQxD68ih5BsnEns+zQ+nJ7DqHQ1j5LS6G9IhI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hsqA7/EKKazvIYlNl4XnbxJhhDMPb4g1S+duEtsEdkFGYw5LbFdqKJf2tRX2eRmBHgjo0Ojh/91j4RShB3zkM/GYMBKTviJrkqtlJKGvnMM2AKW3rF7Gr0w+oqtpVXS+W6W/eqfHisyCTFQKALIjsgP1XqOzS9hYS4hpZuKDsvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=is7Wha1q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713254492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=RZyLaR4q5+Pr37vSM/MQ3Xu6NDlopZTeCIe709qY0Co=;
	b=is7Wha1qsK5vMheVsEX9tVIofxqgtbudynhwfJIIsiX8WYnEUafwsIxgcLsMwy86lnb3Uk
	HG9RzwSOf9qCQYq+HDKS8amE5EjFsbN9ekk0/B42q6Q2DVXCRxlxly6jBdSB3247FuhxbV
	dNj8MMGNZ3x1N2PnE9/M7jM/b4kjBkg=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-189-eNLwUscCMDW-V8oE2n2jDQ-1; Tue, 16 Apr 2024 04:01:31 -0400
X-MC-Unique: eNLwUscCMDW-V8oE2n2jDQ-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-56e353671f7so839957a12.1
        for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 01:01:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713254489; x=1713859289;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RZyLaR4q5+Pr37vSM/MQ3Xu6NDlopZTeCIe709qY0Co=;
        b=vH9hiv8jzEmAoVqTptKleEkgeDYE2KHHE8pK97xb3d2BiDV4c8YCmFaaVeRuLrKN0C
         /XgoHSqP65CKwTw+dajJm0k2awaxc/GDR/MYmPA8QZuFnHQqNr1YBFsNM2KCA/KrCMoY
         s1YHj7OV4kYsyc17KEunUWT0qEpOAYt5UXbjHqGvO6ihPK0p3To7C5jrzNJkbA5OTMNt
         M5Wg/J45RaWm/tUvFXMW1jOhDFq6frnThG03ddcYfnfrfaOtVvISh27oLdz+0gwiItEC
         NbIR5ev7ZbXiwsw/ohpj6qOCocprjjy+UHhwaSKML7F+hwR4QmxyuThPFF3FpKaj67fB
         VRVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXylGeRuV6T8Z4+FurItwly20OfFa5c/YyHjZ92u1j6hAf3Gtwdyfwoz8y0P9IthNgBlXIFmaZiIhL175RA/Rfvl7A31P+g
X-Gm-Message-State: AOJu0YzzQ5zTjPnJp6zQYV+sPlxATfCNBTLlk9MjnL++XCNJx4ipc/2O
	zIx9ZCPJjH01Pvak6czN2kLh1V1E5zlIX78IDFx+fQXsKaV7iyZKqOIvEnsSdrLCmfANFNwzNx/
	x46hteBVDkJ4FXAIbVu+GnOMxf6bEvQfIjk/X3zILyDfKkEGPu1YSFjf51/X0wQ==
X-Received: by 2002:a17:907:928a:b0:a52:3d34:bde5 with SMTP id bw10-20020a170907928a00b00a523d34bde5mr7722188ejc.1.1713254489675;
        Tue, 16 Apr 2024 01:01:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/LX6P6cDzbV4AhcbDPirXop+h15Q/25WfZZAq2lSrgc4GTOj2Zj7zmiJK2/fcOh8KHp29DQ==
X-Received: by 2002:a17:907:928a:b0:a52:3d34:bde5 with SMTP id bw10-20020a170907928a00b00a523d34bde5mr7722156ejc.1.1713254489287;
        Tue, 16 Apr 2024 01:01:29 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-231-31.dyn.eolo.it. [146.241.231.31])
        by smtp.gmail.com with ESMTPSA id k11-20020a1709067acb00b00a524b33fd9asm4296150ejo.68.2024.04.16.01.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 01:01:28 -0700 (PDT)
Message-ID: <2d3ea199eef53cf6a0c48e21abdee0eefbdee927.camel@redhat.com>
Subject: Re: [PATCH net-next v4 3/6] rstreason: prepare for active reset
From: Paolo Abeni <pabeni@redhat.com>
To: Jason Xing <kerneljasonxing@gmail.com>, edumazet@google.com, 
 dsahern@kernel.org, matttbe@kernel.org, martineau@kernel.org,
 geliang@kernel.org,  kuba@kernel.org, davem@davemloft.net,
 rostedt@goodmis.org, mhiramat@kernel.org,  mathieu.desnoyers@efficios.com,
 atenart@kernel.org
Cc: mptcp@lists.linux.dev, netdev@vger.kernel.org, Jason Xing
	 <kernelxing@tencent.com>
Date: Tue, 16 Apr 2024 10:01:27 +0200
In-Reply-To: <20240411115630.38420-4-kerneljasonxing@gmail.com>
References: <20240411115630.38420-1-kerneljasonxing@gmail.com>
	 <20240411115630.38420-4-kerneljasonxing@gmail.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-04-11 at 19:56 +0800, Jason Xing wrote:
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 744c87b6d5a4..ba0a252c113f 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -412,7 +412,7 @@ void mptcp_subflow_reset(struct sock *ssk)
>  	/* must hold: tcp_done() could drop last reference on parent */
>  	sock_hold(sk);
> =20
> -	tcp_send_active_reset(ssk, GFP_ATOMIC);
> +	tcp_send_active_reset(ssk, GFP_ATOMIC, SK_RST_REASON_NOT_SPECIFIED);

I'm sorry for the late feedback.

Some of the caller can set subflow->reset_reason, so probably something
alike the following:

	tcp_send_active_reset(ssk, GFP_ATOMIC,
			      subflow->reset_reason?: SK_RST_REASON_NOT_SPECIFIED);


would work - with an helper even better.

Could be a follow-up patch.

Thanks,

Paolo


