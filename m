Return-Path: <netdev+bounces-85100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7EF189979A
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 10:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E8401F22B25
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 08:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB61414535C;
	Fri,  5 Apr 2024 08:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O3I/OirS"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA601CD18
	for <netdev@vger.kernel.org>; Fri,  5 Apr 2024 08:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712304976; cv=none; b=kqzoPK1S41eXHul+6UxdVGqxJISspfj66Kz+AHluZw0z/Zyz7u2AEbMclLEAg53370aMbV8/LW2j6R2mYaqJIGr4AYQV/j2MdOPlbF2flUcdA/HyqkSHHsyFa4R3GpCHdwK1egfGI8e4y8pKigbNzR5DpzHAadkk9wUXbn3BxOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712304976; c=relaxed/simple;
	bh=N8tiSAiO4xyWIcoObC5tM1NhQk11cyGKT2M1FftBbxY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UrgCjQvmh6MlTuPdxMRd5+NxJD2DIWEMSCHtQCeUFJGTlJHVshcow3HSBFOgaBDQca9C9W1QTVY2Xedfh5BZ8oJLuEhf8ql/Rd+vSA3YlXaLxRddwmw615H20twBV4D6nnNQtA7cSUOwo7s/AT9mS5LZGeqmEdIDHlNidEaqQfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O3I/OirS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712304974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=DMqPcsWYdMz+QuAcl4GQnhcerxyIbnKaTUXcWIfKPf0=;
	b=O3I/OirS/u1uvNSgu18xwAyUFhXpe9MS5vTEZBZipWV9pUiCzyM0GBnqf8z3vsOgHcB3mu
	db57QrraH8mNc1Xqtv6zRQ50lVngKmgVoSgLsTxeekeRNJ2MQNW3fOZD04PGZUCPOQQX52
	bSFLZYfMCkrHggoI1lmZOQIopiDenDw=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-48-g1lWko3lNZ-i-P11TbI0UQ-1; Fri, 05 Apr 2024 04:16:12 -0400
X-MC-Unique: g1lWko3lNZ-i-P11TbI0UQ-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2d6884f6de1so3992471fa.0
        for <netdev@vger.kernel.org>; Fri, 05 Apr 2024 01:16:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712304970; x=1712909770;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DMqPcsWYdMz+QuAcl4GQnhcerxyIbnKaTUXcWIfKPf0=;
        b=tFoCydZAKtlwMKJLwinUz8MLJ7Qa3ELl6hJIZxKJDkaKEqS/gO8/7eUw5mr/pIvqaO
         nVa0ZglrD3PG1FpQmCPXlI3upWPo/GheHvuqNFshwRxkv6jYMY7WHDQFsaS694uLboMb
         oxFTeX4AE3hu6ljhsg8+P3TkAWxo3mD0HmcgyaGrVD1pXHWurZYJ+3vWNyzcT0YkhEMy
         iUEatI/6BKLfBI2eMeLspy+c/AKtZg8N1582O0lOSiHsyNLMUdvSsAP7qFSUOKlz8Ct0
         GAyZoOtdLD7OZZyQ7alcxOsNHmA+nieim5ea34lQK49SHXBrzriXt82yAPiPE9cW+2BD
         xfig==
X-Forwarded-Encrypted: i=1; AJvYcCUlLV5GOpGYeENB7KUqDw4X1bqz28aysRtCw6l233nsc2qMXz5kRHfkoZnaMHpVKXeOhGzRIKhiETvgfAj46M5J3vwpPOto
X-Gm-Message-State: AOJu0YwmajM+IoSYeKOIOxvx6CBi0gE43trirtEI6R4c85qIm4hgJYqn
	w9Lfq/vnxY3wbqtzCuIe0mAeYi0RBo3rHBt6OfEPWVFeUzYuK/fCdXUuIzNU0GjtPqq9nVtfYKR
	NnL+++oAKQHDTj0sBx5g00za0SonXMMaH30YiLHSn3upjDWlJSnPcUvyL26XKmQ==
X-Received: by 2002:a2e:9592:0:b0:2d3:1b88:9237 with SMTP id w18-20020a2e9592000000b002d31b889237mr550711ljh.0.1712304969852;
        Fri, 05 Apr 2024 01:16:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFogvpnQZjO6LZncWCHcyh7EtNDl1PYr1OSiuBpIBMshgE3ZsqlXOsblX1v7LOm2ldM7m17JQ==
X-Received: by 2002:a2e:9592:0:b0:2d3:1b88:9237 with SMTP id w18-20020a2e9592000000b002d31b889237mr550696ljh.0.1712304969457;
        Fri, 05 Apr 2024 01:16:09 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-247-213.dyn.eolo.it. [146.241.247.213])
        by smtp.gmail.com with ESMTPSA id u3-20020a5d6ac3000000b00341d9e8cc62sm1388284wrw.100.2024.04.05.01.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 01:16:08 -0700 (PDT)
Message-ID: <5046e1867c65f39e07822beb0a19a22743b1064b.camel@redhat.com>
Subject: Re: [PATCH net-next 2/2] mptcp: add reset reason options in some
 places
From: Paolo Abeni <pabeni@redhat.com>
To: Jason Xing <kerneljasonxing@gmail.com>, davem@davemloft.net, 
 edumazet@google.com, kuba@kernel.org, matttbe@kernel.org,
 martineau@kernel.org,  geliang@kernel.org
Cc: mptcp@lists.linux.dev, netdev@vger.kernel.org, Jason Xing
	 <kernelxing@tencent.com>
Date: Fri, 05 Apr 2024 10:16:07 +0200
In-Reply-To: <20240405023914.54872-3-kerneljasonxing@gmail.com>
References: <20240405023914.54872-1-kerneljasonxing@gmail.com>
	 <20240405023914.54872-3-kerneljasonxing@gmail.com>
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

On Fri, 2024-04-05 at 10:39 +0800, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
>=20
> The reason codes are handled in two ways nowadays (quoting Mat Martineau)=
:
> 1. Sending in the MPTCP option on RST packets when there is no subflow
> context available (these use subflow_add_reset_reason() and directly call
> a TCP-level send_reset function)
> 2. The "normal" way via subflow->reset_reason. This will propagate to bot=
h
> the outgoing reset packet and to a local path manager process via netlink
> in mptcp_event_sub_closed()
>=20
> RFC 8684 defines the skb reset reason behaviour which is not required
> even though in some places:
>=20
>     A host sends a TCP RST in order to close a subflow or reject
>     an attempt to open a subflow (MP_JOIN). In order to let the
>     receiving host know why a subflow is being closed or rejected,
>     the TCP RST packet MAY include the MP_TCPRST option (Figure 15).
>     The host MAY use this information to decide, for example, whether
>     it tries to re-establish the subflow immediately, later, or never.
>=20
> Since the commit dc87efdb1a5cd ("mptcp: add mptcp reset option support")
> introduced this feature about three years ago, we can fully use it.
> There remains some places where we could insert reason into skb as
> we can see in this patch.
>=20
> Many thanks to Mat for help:)
>=20
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  net/mptcp/subflow.c | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
>=20
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 1626dd20c68f..49f746d91884 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -301,8 +301,13 @@ static struct dst_entry *subflow_v4_route_req(const =
struct sock *sk,
>  		return dst;
> =20
>  	dst_release(dst);
> -	if (!req->syncookie)
> +	if (!req->syncookie) {
> +		struct mptcp_ext *mpext =3D mptcp_get_ext(skb);
> +
> +		if (mpext)
> +			subflow_add_reset_reason(skb, mpext->reset_reason);

uhm? subflow_add_reset_reason() will do:

	mptcp_ext_add(skb)->reset_reason =3D mpext->reset_reason

The above looks like a no-op.=20

Possibly we should instead ensure that subflow_check_req() calls
subflow_add_reset_reason() with reasonable arguments on all the error
paths?!?

Something alike the (completely untested) following

Cheers,

Paolo
---
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 6042a47da61b..298c6342a78c 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -150,8 +150,10 @@ static int subflow_check_req(struct request_sock *req,
 	/* no MPTCP if MD5SIG is enabled on this socket or we may run out of
 	 * TCP option space.
 	 */
-	if (rcu_access_pointer(tcp_sk(sk_listener)->md5sig_info))
+	if (rcu_access_pointer(tcp_sk(sk_listener)->md5sig_info)) {
+		subflow_add_reset_reason(skb, MPTCP_RST_EMPTCP);
 		return -EINVAL;
+	}
 #endif
=20
 	mptcp_get_options(skb, &mp_opt);
@@ -219,6 +221,7 @@ static int subflow_check_req(struct request_sock *req,
 				 ntohs(inet_sk((struct sock *)subflow_req->msk)->inet_sport));
 			if (!mptcp_pm_sport_in_anno_list(subflow_req->msk, sk_listener)) {
 				SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_MISMATCHPORTSYNRX);
+				subflow_add_reset_reason(skb, MPTCP_RST_EPROHIBIT);
 				return -EPERM;
 			}
 			SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINPORTSYNRX);
@@ -227,10 +230,12 @@ static int subflow_check_req(struct request_sock *req=
,
 		subflow_req_create_thmac(subflow_req);
=20
 		if (unlikely(req->syncookie)) {
-			if (mptcp_can_accept_new_subflow(subflow_req->msk))
-				subflow_init_req_cookie_join_save(subflow_req, skb);
-			else
+			if (!mptcp_can_accept_new_subflow(subflow_req->msk)) {
+				subflow_add_reset_reason(skb, MPTCP_RST_EPROHIBIT);
 				return -EPERM;
+			}
+
+			subflow_init_req_cookie_join_save(subflow_req, skb);
 		}
=20
 		pr_debug("token=3D%u, remote_nonce=3D%u msk=3D%p", subflow_req->token,


