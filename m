Return-Path: <netdev+bounces-276948-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mEYhD+yQ12kaPwgAu9opvQ
	(envelope-from <netdev+bounces-276948-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 13:43:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E23A3C9C3A
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 13:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 81F1E3041493
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 11:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606CE3C196B;
	Thu,  9 Apr 2026 11:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e4/3EwZY";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="bcj4LzDL"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32BE3BE639
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 11:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775734922; cv=none; b=M0ctmNcPndRZLtvmbOacDWCcIsOs9MD/OnC+kPqIpuTovPI/Me357wbvsNFjuyOX2gJuQrBE29XwH/12QrdwAdUp9BlV2GXdjBNpqqIo6REgMHeCGpS/zTCTpd/XKNDJOyur3UL0qGa58sR1FfymOTBtH+79+Z7EWlGfMexRNEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775734922; c=relaxed/simple;
	bh=Xe0sZqgfk9F3yftdgiTDF7qqujoL9xk0V6ZQR7NjLJI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W1m5JvOdw7plNg1gzqa6iFc7o2XvRKmrlfR3d+E5U/eCPMIbnrxQ+P7IF+c/v+ZbQJmLoUYTYSTm0xcAgeeLwh/dH5V3UCahX3cbmOgX74fZIhP4tKor+QNTgRJwDoPTIzuF0hUzSg4HVAyRLqEoyqF7yulxeAd3BdlrkLCl5Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e4/3EwZY; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bcj4LzDL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775734919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IUbx7t7Ut7y7G4O6XCeghrRXrtVFrF8+mllmG3120v4=;
	b=e4/3EwZY4vrUzP+GyxeOW+ORsQTokO0C+arAJ5DXZHZNcQzuIIiqtKdZWujmZNCEXrrUwS
	S54C1MpG1DwgljNU2ZJUIV4l5KxTV4I9Yojxg3ZTkrC7HkHOfIJPp+cn0MOKxzEhaGrFzZ
	KEXaQ5vlC9cHnDVLy3KtvT7c79POwrc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-yzOBXurUPeiNX5QHg_gIrA-1; Thu, 09 Apr 2026 07:41:58 -0400
X-MC-Unique: yzOBXurUPeiNX5QHg_gIrA-1
X-Mimecast-MFC-AGG-ID: yzOBXurUPeiNX5QHg_gIrA_1775734917
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-43d15f2e0f4so756912f8f.0
        for <netdev@vger.kernel.org>; Thu, 09 Apr 2026 04:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775734917; x=1776339717; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IUbx7t7Ut7y7G4O6XCeghrRXrtVFrF8+mllmG3120v4=;
        b=bcj4LzDLPBUJQZMTiz0fY6Txw3x0ETnfL8dDWSDD3tXcuJp61UJAnyJQOWDzKW6Ugq
         a+gxeWySbf4Unhtrjo0IhIW9zHmYSoUCIQRjLLeqIPFDWiOUFON1ngyaDzyFNPCUNk2W
         hiRk2m8uVlOg7jYP0YUzInRFXHiCLt7sbliyBJisC1TWZbMchAbreTbGToZK7nV50yLR
         aJxnTV8dB/p5tTRQ7YmATvYWzB3v/Irl5GntdTqDLr2vNfqVluKxXJtmGT9Q1FlMZR9/
         +bIuSV5TN4Gy4yfhzHFNiweXaCRjSnO54Fmm2LA9xSrw/KG1OnS8EyH26JOh1XZbImDL
         GRTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775734917; x=1776339717;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IUbx7t7Ut7y7G4O6XCeghrRXrtVFrF8+mllmG3120v4=;
        b=nsEom74ZufvzFbW03W9/7yOuJ4NbTDXwwERnhgePw7LrQ6CsVlhikBfdTTkpusZS+Q
         /1WCjW19PjO23RPUMi87x2G3c+sEterpuS9ozvVoc2CiQjlI9BNPQqDOrw3Rgp/IxXef
         kxHgP5FDdmu5WnisBgLlWa4jKHqPSGJUxFIupVAjLw7E6UsXytLddefiTr4ZlnH6msYy
         1utSaFV6Eplia0afcddwnVvDID76wzlNd35ivuI7+AsTqiurXkRyLCC+NQtfyoul8YFS
         ZBR6jgLJrLi9uIwpM0grgAhLEm0ORM7wmFpZns669+pBTvt+TWhZBAvn8VS+KfdMlwSd
         xlWg==
X-Forwarded-Encrypted: i=1; AJvYcCWZpVnKoAFxdvQqFa8Oizu4o95Za2WPvvAgPae49kDsmLmv0MPgWNWahyjK08DG2cWXXj0K/Rw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2nW6Q/msfZ0YppNRbFG1Jlhk4Dwdt4BZzelr/oSH6GaChH2VS
	PAlC5Uu/jUQksUlX2YCYkRMxUPVDnRjl+Pxko18Q/iItLJND/KpzrGeKcJRFE+qbKyrFXOeO8G0
	RDu4+6rWeAb2uuctFFtdMaRdjF080BxaMpFleO+PSm6QjgduCTuFobeftdQ==
X-Gm-Gg: AeBDietNKjnOM9O/sla9qDy+0rxyZeQHkQB23GlVVKhWpe9SrI9s7jhi4hHSActmDDg
	QDlkB+q7jGIYTgIwHWlu58kiB8gW9zQ1DSgaSt3Up+ewezp9452DC5hVHPzhAMK5Odklb2XsnlK
	/V6oXV3didjjm7cgF6LnFRkO1qP7Tzp+I6SQFfMBy3vbCYRszg7ueVvm24U2TkTK1vX8wepGCnJ
	nM6wzxts0tEYaUzEIkK6osRCHA+vDKpVCwnqTVtATvXouyhaAiawqmO+4AqEeWDfgguLTGnJK6D
	rQazRDLYeVAcQIH4oW0oh/ObULkWApphR5TXFk4t5s5mVGuueE26ZGiQ7vQjNcktrnzYctFbm9g
	0uQTq+chrenMA6I6GcclmbyIepTINB1oCt2YOo4C+o6dZdv6A6mBHjSJl
X-Received: by 2002:a05:6000:40dd:b0:43b:8858:1146 with SMTP id ffacd0b85a97d-43d292e7fd9mr39329632f8f.41.1775734917281;
        Thu, 09 Apr 2026 04:41:57 -0700 (PDT)
X-Received: by 2002:a05:6000:40dd:b0:43b:8858:1146 with SMTP id ffacd0b85a97d-43d292e7fd9mr39329594f8f.41.1775734916790;
        Thu, 09 Apr 2026 04:41:56 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.25.243])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4d2738sm68094680f8f.24.2026.04.09.04.41.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2026 04:41:56 -0700 (PDT)
Message-ID: <fa3896b1-097a-40f3-8733-7d7425519347@redhat.com>
Date: Thu, 9 Apr 2026 13:41:55 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] l2tp: take a session reference in pppol2tp_ioctl()
To: Yiqi Sun <sunyiqixm@gmail.com>, jchapman@katalix.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 horms@kernel.org, netdev@vger.kernel.org
References: <20260404133245.2391409-1-sunyiqixm@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260404133245.2391409-1-sunyiqixm@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-276948-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,katalix.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9E23A3C9C3A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/4/26 3:32 PM, Yiqi Sun wrote:
> pppol2tp_ioctl() reads sock->sk->sk_user_data and dereferences the
> returned l2tp_session without taking a reference on it.
> 
> Since the ppp socket/session lifetime rework, session teardown runs
> asynchronously and can clear sk_user_data and drop the last session
> reference in parallel with ioctl(). This leaves ioctl() with a stale
> session pointer and can trigger a use-after-free.

It's not immediately obvious to me which are the actual code paths
involved, please include a more accurate description of the relevant race.

> 
> Fix this by using pppol2tp_sock_to_session() in pppol2tp_ioctl() and
> dropping the session reference before returning. This matches the
> existing getsockopt/setsockopt paths.
> 
> Fixes: c5cbaef992d64 ("l2tp: refactor ppp socket/session relationship")
> Signed-off-by: Yiqi Sun <sunyiqixm@gmail.com>
> ---
>  net/l2tp/l2tp_ppp.c | 88 +++++++++++++++++++++++++++------------------
>  1 file changed, 54 insertions(+), 34 deletions(-)
> 
> diff --git a/net/l2tp/l2tp_ppp.c b/net/l2tp/l2tp_ppp.c
> index ae4543d5597b..e6d7d3537180 100644
> --- a/net/l2tp/l2tp_ppp.c
> +++ b/net/l2tp/l2tp_ppp.c
> @@ -1042,66 +1042,79 @@ static int pppol2tp_tunnel_copy_stats(struct pppol2tp_ioc_stats *stats,
>  static int pppol2tp_ioctl(struct socket *sock, unsigned int cmd,
>  			  unsigned long arg)
>  {
> +	struct sock *sk = sock->sk;
>  	struct pppol2tp_ioc_stats stats;
>  	struct l2tp_session *session;
> +	int err;
> +
> +	err = -ENOTCONN;
> +	if (!sk->sk_user_data)
> +		goto end;
> +
> +	err = -EBADF;
> +	session = pppol2tp_sock_to_session(sk);
> +	if (!session)
> +		goto end;

Consolidating the checks here brings an user visible change, as
unsupported cmds previously delivered -ENOIOCTLCMD.

>  
>  	switch (cmd) {
>  	case PPPIOCGMRU:
>  	case PPPIOCGFLAGS:
> -		session = sock->sk->sk_user_data;
> -		if (!session)
> -			return -ENOTCONN;
> -
>  		if (WARN_ON(session->magic != L2TP_SESSION_MAGIC))

This check is already present in pppol2tp_sock_to_session()

Similar chunks below.

/P


