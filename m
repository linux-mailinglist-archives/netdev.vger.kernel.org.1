Return-Path: <netdev+bounces-48268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9217EDDE7
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 10:46:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B8A51C20846
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 09:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC06228E22;
	Thu, 16 Nov 2023 09:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hFrwg86S"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF3DE0
	for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 01:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700127995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GruoM/5/32+k91gDkX5IlRzhNe9lOGFcfel6ZoBid20=;
	b=hFrwg86SQuS4knRIeOwLid/MJV3SBJHCp0Vt1cLPTsH5cJyrFcnJarxh5xUyS099xwTN7e
	VIJsT72C4HKnPeXhWUQNEHgWyK3MvoVOasiBpJ28q9owKybYwN++NVi0fVfODOyezGZNSh
	k8htFwXou3M1vxvRYGXaYpHXAL4VHtg=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-fp5dzcYtOfinlkXxeyYusQ-1; Thu, 16 Nov 2023 04:46:34 -0500
X-MC-Unique: fp5dzcYtOfinlkXxeyYusQ-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5401de6ce9eso99361a12.0
        for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 01:46:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700127993; x=1700732793;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GruoM/5/32+k91gDkX5IlRzhNe9lOGFcfel6ZoBid20=;
        b=kDngF/VPyXq7dUdFqMNZV6mTVhg5o+B3UfiJ77AkLlaJSyyoNz4fY/E/qd3hmghdKS
         +wgIAUt3Ozm1JZyz55BtI65PNZEmS1F0IPTY91al/qT+L+w/0FoiV4TniOk3HkL8mW7H
         jvLMbDpK/MWmpiRGzS0IAWwF/5OjVy+RoEPFuQEGZbeupfR5VEwDPs66SQ9XO0DoDzAp
         BxUdpHutI0c8WD74FrfTmJvc0AKM3gUFTwAWspOgz4NRf5BZ3d7myRYKOTnitQeTK4D1
         kFnNB/p8rSiITSZL9GCewCwwjgrH/QzdGVlLeQ6/7pJusYiJoizJsPGcQbl2eDZAxW1X
         F4Yg==
X-Gm-Message-State: AOJu0YyD1vxYWjXCRsCjcSq+5uNJhnmTi/yT6nIo1itd2nT2bgi8In0l
	pUamYM7jmmtg6dcmlTHhnAIL6jOP2onQ4mxEK4esJbCsL1JGkPOCenbHjKLCJUeC7M0KbALFAe9
	skBLE8+RRbCsUZT2Jha9xODuS
X-Received: by 2002:a05:6402:5518:b0:548:15e1:3b26 with SMTP id fi24-20020a056402551800b0054815e13b26mr456432edb.3.1700127992898;
        Thu, 16 Nov 2023 01:46:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF6FMEPXWLzaTbwCpFj/1CLV+LAdXnP2IviLRo7oPmaJQCqz4fjhooDueXV1KR2Y44bOlBZPA==
X-Received: by 2002:a05:6402:5518:b0:548:15e1:3b26 with SMTP id fi24-20020a056402551800b0054815e13b26mr456412edb.3.1700127992587;
        Thu, 16 Nov 2023 01:46:32 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-98-67.dyn.eolo.it. [146.241.98.67])
        by smtp.gmail.com with ESMTPSA id v23-20020aa7cd57000000b005402a0c9784sm7495481edw.40.2023.11.16.01.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 01:46:32 -0800 (PST)
Message-ID: <59083303fc79497b2658ff15ac3c18b985e270ab.camel@redhat.com>
Subject: Re: [PATCH net] tipc: Remove redundant call to TLV_SPACE()
From: Paolo Abeni <pabeni@redhat.com>
To: Shigeru Yoshida <syoshida@redhat.com>, jmaloy@redhat.com, 
 ying.xue@windriver.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org
Cc: netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net, 
	linux-kernel@vger.kernel.org
Date: Thu, 16 Nov 2023 10:46:30 +0100
In-Reply-To: <20231114144336.1714364-1-syoshida@redhat.com>
References: <20231114144336.1714364-1-syoshida@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

On Tue, 2023-11-14 at 23:43 +0900, Shigeru Yoshida wrote:
> The purpose of TLV_SPACE() is to add the TLV descriptor size to the size =
of
> the TLV value passed as argument and align the resulting size to
> TLV_ALIGNTO.
>=20
> tipc_tlv_alloc() calls TLV_SPACE() on its argument. In other words,
> tipc_tlv_alloc() takes its argument as the size of the TLV value. So the
> call to TLV_SPACE() in tipc_get_err_tlv() is redundant. Let's remove this
> redundancy.
>=20
> Fixes: d0796d1ef63d ("tipc: convert legacy nl bearer dump to nl compat")
> Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>

The patch LGTM, but I think this is more a cleanup then a fix, please
re-submit it for net-next, dropping the Fixes tag (so it will not land
in stable tree).

With the above you can add:

Acked-by: Paolo Abeni <pabeni@redhat.com>
> ---
>  net/tipc/netlink_compat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/net/tipc/netlink_compat.c b/net/tipc/netlink_compat.c
> index 5bc076f2fa74..db0365c9b8bd 100644
> --- a/net/tipc/netlink_compat.c
> +++ b/net/tipc/netlink_compat.c
> @@ -167,7 +167,7 @@ static struct sk_buff *tipc_get_err_tlv(char *str)
>  	int str_len =3D strlen(str) + 1;
>  	struct sk_buff *buf;
> =20
> -	buf =3D tipc_tlv_alloc(TLV_SPACE(str_len));
> +	buf =3D tipc_tlv_alloc(str_len);
>  	if (buf)
>  		tipc_add_tlv(buf, TIPC_TLV_ERROR_STRING, str, str_len);
> =20


