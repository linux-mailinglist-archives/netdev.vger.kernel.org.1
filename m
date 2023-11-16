Return-Path: <netdev+bounces-48267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73FDC7EDDCF
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 10:42:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1091FB20A3D
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 09:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6F628E10;
	Thu, 16 Nov 2023 09:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bltQcZJP"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9BF019E
	for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 01:42:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700127767;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=heGG96XfkpUgzfldNR64oAGB+yDvLKeqZ76hGOTYKIY=;
	b=bltQcZJPfz+xn7UUlL+cvsmmLHqX7VBniMZTVv9Ch43hTYEs0SQIQtePxVwUhqTcIO4zf9
	AR2zFXPC7G/yh5RLSK4f+4KaR63VMBIpNGad2OHaruJbN83dHUgQP6pLXpSdskXTxG8KfP
	+3LodUvowhSFUIxyly3ICLQcOYkZt2M=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-S_71L_vgP5KfqwXAsdAlSA-1; Thu, 16 Nov 2023 04:42:45 -0500
X-MC-Unique: S_71L_vgP5KfqwXAsdAlSA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9c167384046so11429266b.0
        for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 01:42:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700127764; x=1700732564;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=heGG96XfkpUgzfldNR64oAGB+yDvLKeqZ76hGOTYKIY=;
        b=FjEhFCEQ9/OmbnNPd6Fau0E6raI55TTK3Q03/PF7m7cYPbK0cbT45YTzIaEAiAGO2y
         uvD80JPqKjs0luN3Wr+o9707qlIlqrE0DSWlHYkGwxSK6pCJD3FVBr6ItHBwQm4XUtcM
         R2pNVJuqvgkLhEPzjuer3zoTqK1NEgPK/2UZj2l+4HAtB8cA5gNIQluUeN6ETdOlFKSM
         UH93iLx2TsiqwOPup4sOEY9lRYRbxF8BThebuVR0q2an8lztB9Y8OaJ0yiRO8oBWKVpr
         We9QIvztDVEto/YYBrKdzNgPArpPzEMpZ8jDmETGvLLb0JFQqXxdCIZOVhzEZQUjJ2bn
         joWQ==
X-Gm-Message-State: AOJu0YyJeJNyr3x65lH5Oje1ly6SVrW4OX+EAjLWERfhrFlADuIEusrj
	s4OlmGF3f/Otj9MMKNCj6wJlTxnoW8fLMTUszWj/A0AhW162SKsndJpZEtl/2qybL605qp8HKQK
	CsmqVanvZleMHsJJH
X-Received: by 2002:a17:906:74d6:b0:9d0:51d4:4dc6 with SMTP id z22-20020a17090674d600b009d051d44dc6mr5575107ejl.2.1700127764286;
        Thu, 16 Nov 2023 01:42:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF9Lx2TYA5UNjfQFCcN+QXNqEZ/5fLFxxydsbS74Vjgexqqz/6UU/5qGFIbdY0aCgbA2PVuHA==
X-Received: by 2002:a17:906:74d6:b0:9d0:51d4:4dc6 with SMTP id z22-20020a17090674d600b009d051d44dc6mr5575077ejl.2.1700127763868;
        Thu, 16 Nov 2023 01:42:43 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-98-67.dyn.eolo.it. [146.241.98.67])
        by smtp.gmail.com with ESMTPSA id q24-20020a17090622d800b009db53aa4f7bsm8151379eja.28.2023.11.16.01.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 01:42:43 -0800 (PST)
Message-ID: <020ff11184bb22909287ef68d97c00f7d2c73bd6.camel@redhat.com>
Subject: Re: [PATCH 2/2] net: usb: ax88179_178a: avoid two consecutive
 device resets
From: Paolo Abeni <pabeni@redhat.com>
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>, davem@davemloft.net,
  edumazet@google.com, kuba@kernel.org, linux-usb@vger.kernel.org, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: weihao.bj@ieisystem.com
Date: Thu, 16 Nov 2023 10:42:42 +0100
In-Reply-To: <20231114125111.313229-3-jtornosm@redhat.com>
References: <20231114125111.313229-1-jtornosm@redhat.com>
	 <20231114125111.313229-3-jtornosm@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2023-11-14 at 13:50 +0100, Jose Ignacio Tornos Martinez wrote:
> The device is always reset two consecutive times (ax88179_reset is called
> twice), one from usbnet_probe during the device binding and the other fro=
m
> usbnet_open.
>=20
> Let only the reset during the device binding to prepare the device as soo=
n
> as possible and not repeat the reset operation (tested with generic ASIX
> Electronics Corp. AX88179 Gigabit Ethernet device).
>=20
> Reported-by: Herb Wei <weihao.bj@ieisystem.com>
> Tested-by: Herb Wei <weihao.bj@ieisystem.com>
> Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>

We need a suitable Fixes tag even here ;)

> ---
>  drivers/net/usb/ax88179_178a.c | 13 -------------
>  1 file changed, 13 deletions(-)
>=20
> diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178=
a.c
> index 4ea0e155bb0d..864c6fc2db33 100644
> --- a/drivers/net/usb/ax88179_178a.c
> +++ b/drivers/net/usb/ax88179_178a.c
> @@ -1678,7 +1678,6 @@ static const struct driver_info ax88179_info =3D {
>  	.unbind =3D ax88179_unbind,
>  	.status =3D ax88179_status,
>  	.link_reset =3D ax88179_link_reset,
> -	.reset =3D ax88179_reset,
>  	.stop =3D ax88179_stop,
>  	.flags =3D FLAG_ETHER | FLAG_FRAMING_AX,
>  	.rx_fixup =3D ax88179_rx_fixup,

This looks potentially dangerous, as the device will not get a reset in
down/up cycles; *possibly* dropping the reset call from ax88179_bind()
would be safer.

In both cases touching so many H/W variant with testing available on a
single one sounds dangerous. Is the unneeded 2nd reset causing any
specific issue?

Thanks,

Paolo


