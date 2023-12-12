Return-Path: <netdev+bounces-56420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8144180ECBA
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 14:02:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C1421F2155A
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 13:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD6960EF1;
	Tue, 12 Dec 2023 13:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ORhgcKnb"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F486EA
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 05:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702386123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pwd7BiRfpK47/Io5shbJP3Cy3f59uwOes8Wr8Lvrva8=;
	b=ORhgcKnbcvIQ7CCrL0S0WJTsZwWhgcmaiiJDCZsEdtB9sl/1dt9/T6rdvPIASV5jFU5m6b
	dg0iOpA935S0uYPzjErDPlTNzuWtpI8rxtr6lFMupVYIhVWYk+R/FOgBpi8vLrtp4TtV3a
	tQuO6sC4HgH+islvl6R5xZdrkamxFoQ=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-NL11paOROZG4z_ALwTRm9w-1; Tue, 12 Dec 2023 08:02:01 -0500
X-MC-Unique: NL11paOROZG4z_ALwTRm9w-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a1ef5c7f80cso53422266b.1
        for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 05:02:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702386120; x=1702990920;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pwd7BiRfpK47/Io5shbJP3Cy3f59uwOes8Wr8Lvrva8=;
        b=tMoaGVxI0DM/zFi2n3KxbsmnAOZF7lwptOpbFkp15ybOImSk0BaUbt1REQorqSy9NF
         R7AmRurPxv+6IAMUKkfKpvCVWA2EKF5FdkqPVckPEdB7dvviuPKFn3BfWL+nEJmP/Apk
         JhwECjLajOUAiadxtBblZ0lEMEPmhzgaadarHFidQrpSpes2r6kNC/Ico05bGrVGnGcO
         im5wxJqhbw76qB8ub/NKtPSpV69wV0VrZ7UDrqp49fKPckZ+A1LHmS9MJ4Egbr++6QJo
         mKFu8RYYT7NaW91P9odQz1N3QAhK7a1V/aHYBHUJQYX4Cxb2Ifx9ylugSaoNcDYayVhR
         yDjw==
X-Gm-Message-State: AOJu0YyakDYDbT7/0ZofReBtdsILwqAnOM03SgM0reLN0ELl8SkgnRDR
	zL8N4Fi7NvarxjAK/YMtp2Djj44MCjsWbj4CcZDRvx20IIXqRLyTxIxTHUhMNnMTFeojq0RjaXv
	tdFG9a/O25U+yr2/o
X-Received: by 2002:a17:907:a709:b0:a1c:7661:d603 with SMTP id vw9-20020a170907a70900b00a1c7661d603mr6928837ejc.4.1702386120056;
        Tue, 12 Dec 2023 05:02:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG5g83w7evg33Vd8C9GAyYeKqss93O2Ukh1y4L6a6ULzDrQV3DT3RWcXn3D5W2sAt4VilmHVA==
X-Received: by 2002:a17:907:a709:b0:a1c:7661:d603 with SMTP id vw9-20020a170907a70900b00a1c7661d603mr6928809ejc.4.1702386119682;
        Tue, 12 Dec 2023 05:01:59 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-249-182.dyn.eolo.it. [146.241.249.182])
        by smtp.gmail.com with ESMTPSA id sl9-20020a170906618900b00a1cf7b31e9csm6170122ejc.89.2023.12.12.05.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 05:01:59 -0800 (PST)
Message-ID: <94d394d2833754a0a3f7d2cb8c595f44a2b23e43.camel@redhat.com>
Subject: Re: [PATCH net-next v4 1/2] nfc: llcp_core: Hold a ref to
 llcp_local->dev when holding a ref to llcp_local
From: Paolo Abeni <pabeni@redhat.com>
To: Siddh Raman Pant <code@siddh.me>, Krzysztof Kozlowski
 <krzysztof.kozlowski@linaro.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Suman
 Ghosh <sumang@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+bbe84a4010eeea00982d@syzkaller.appspotmail.com
Date: Tue, 12 Dec 2023 14:01:57 +0100
In-Reply-To: <4233248c0ca219693c6e6476aa6e59c799241ac8.1702118242.git.code@siddh.me>
References: <cover.1702118242.git.code@siddh.me>
	 <4233248c0ca219693c6e6476aa6e59c799241ac8.1702118242.git.code@siddh.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2023-12-09 at 16:34 +0530, Siddh Raman Pant wrote:
> llcp_sock_sendmsg() calls nfc_llcp_send_ui_frame() which in turn calls
> nfc_alloc_send_skb(), which accesses the nfc_dev from the llcp_sock for
> getting the headroom and tailroom needed for skb allocation.
>=20
> Parallelly the nfc_dev can be freed, as the refcount is decreased via
> nfc_free_device(), leading to a UAF reported by Syzkaller, which can
> be summarized as follows:
>=20
> (1) llcp_sock_sendmsg() -> nfc_llcp_send_ui_frame()
> 	-> nfc_alloc_send_skb() -> Dereference *nfc_dev
> (2) virtual_ncidev_close() -> nci_free_device() -> nfc_free_device()
> 	-> put_device() -> nfc_release() -> Free *nfc_dev
>=20
> When a reference to llcp_local is acquired, we do not acquire the same
> for the nfc_dev. This leads to freeing even when the llcp_local is in
> use, and this is the case with the UAF described above too.
>=20
> Thus, when we acquire a reference to llcp_local, we should acquire a
> reference to nfc_dev, and release the references appropriately later.
>=20
> References for llcp_local is initialized in nfc_llcp_register_device()
> (which is called by nfc_register_device()). Thus, we should acquire a
> reference to nfc_dev there.
>=20
> nfc_unregister_device() calls nfc_llcp_unregister_device() which in
> turn calls nfc_llcp_local_put(). Thus, the reference to nfc_dev is
> appropriately released later.
>=20
> Reported-and-tested-by: syzbot+bbe84a4010eeea00982d@syzkaller.appspotmail=
.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Dbbe84a4010eeea00982d
> Fixes: c7aa12252f51 ("NFC: Take a reference on the LLCP local pointer whe=
n creating a socket")
> Signed-off-by: Siddh Raman Pant <code@siddh.me>
> Reviewed-by: Suman Ghosh <sumang@marvell.com>
> ---
>  net/nfc/llcp_core.c | 55 ++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 42 insertions(+), 13 deletions(-)
>=20
> diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
> index 1dac28136e6a..0ae89ab42aaa 100644
> --- a/net/nfc/llcp_core.c
> +++ b/net/nfc/llcp_core.c
> @@ -145,6 +145,13 @@ static void nfc_llcp_socket_release(struct nfc_llcp_=
local *local, bool device,
> =20
>  static struct nfc_llcp_local *nfc_llcp_local_get(struct nfc_llcp_local *=
local)
>  {
> +	/* Since using nfc_llcp_local may result in usage of nfc_dev, whenever
> +	 * we hold a reference to local, we also need to hold a reference to
> +	 * the device to avoid UAF.
> +	 */
> +	if (!nfc_get_device(local->dev->idx))
> +		return NULL;
> +
>  	kref_get(&local->ref);
> =20
>  	return local;
> @@ -177,10 +184,18 @@ static void local_release(struct kref *ref)
> =20
>  int nfc_llcp_local_put(struct nfc_llcp_local *local)
>  {
> +	struct nfc_dev *dev;
> +	int ret;
> +
>  	if (local =3D=3D NULL)
>  		return 0;
> =20
> -	return kref_put(&local->ref, local_release);
> +	dev =3D local->dev;
> +
> +	ret =3D kref_put(&local->ref, local_release);
> +	nfc_put_device(dev);
> +
> +	return ret;
>  }
> =20
>  static struct nfc_llcp_sock *nfc_llcp_sock_get(struct nfc_llcp_local *lo=
cal,
> @@ -930,9 +945,7 @@ static void nfc_llcp_recv_connect(struct nfc_llcp_loc=
al *local,
> =20
>  	if (sk_acceptq_is_full(parent)) {
>  		reason =3D LLCP_DM_REJ;

'reason' is set to 'LLCP_DM_REJ' every time you jump to the
'fail_put_sock' or 'fail_free_new_sock' labels, you can as well move
the assignment after 'fail_put_sock:'

Cheers,

Paolo


