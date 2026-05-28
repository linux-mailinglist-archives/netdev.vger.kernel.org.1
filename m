Return-Path: <netdev+bounces-292650-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CCpfFOUaGGoBdQgAu9opvQ
	(envelope-from <netdev+bounces-292650-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 12:37:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 680375F0B29
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 12:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 74482307097F
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 10:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4422E3BA22C;
	Thu, 28 May 2026 10:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="djJ10qiv";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="IBvpIKZW"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F8435E1CA
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 10:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779964294; cv=none; b=ei9n7uMXfjBG3hm/sM/uCmRgEQB02Au7FKRi2bXKLV8p9INwKbEaArjGSHU2klLGrhx1jI8r0HGIm6Tu6LewQEDczy9PDvEKNpQcDa6FQBxPkwkJbOPUc0jj++AyHGBZmVvJKZOUSuYGfT7r1xsgCwTj9hM2i5ede/dbOAIcPXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779964294; c=relaxed/simple;
	bh=uMZInyhct2J6By9KxHA5ABF9l3RGFcif2+JpLTJpi2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YRPi2ACgU4n5N+6iwxcCvs3CSXkCHGiP7uNbbx9RZy8s/pM6iu+cHUkGDcNclbqNIlWnUu0MAVl6YGK8RSvCRGVVM1eAcslg81ywhGxkz4QVwMY5G21G9z+GB40yzd4FotJlMZRrpqCBASK+nfaExzuU+HGiqnk74/+eCVyMfUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=djJ10qiv; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=IBvpIKZW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779964290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Aww6jC3I0Nj95YFehLzt5woPsMu1GhH9KVyzIE2qdSg=;
	b=djJ10qiv/uiXzM9u4KCytKWxBZ72HXS+oB9Z7bFbAYw19F6MS4xiO7IgOkJZvdS/q64p6k
	CvY50pCeAYEBNTJ+g9TL/Ysp3h7+zlMm6OmRCJmM4m9KTqt2l+DW8/MShcRHGb+Ss+xgPj
	8veFYhx/I/xR3m+DSjTfgpCyiviZ+IA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-wm1gS7rfPi-c0Sk4qLfFkw-1; Thu, 28 May 2026 06:31:27 -0400
X-MC-Unique: wm1gS7rfPi-c0Sk4qLfFkw-1
X-Mimecast-MFC-AGG-ID: wm1gS7rfPi-c0Sk4qLfFkw_1779964286
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4905428aad6so44711555e9.1
        for <netdev@vger.kernel.org>; Thu, 28 May 2026 03:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779964286; x=1780569086; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Aww6jC3I0Nj95YFehLzt5woPsMu1GhH9KVyzIE2qdSg=;
        b=IBvpIKZWXj0J0IVWvVuueUTaYy5x9zH3gB5XP7WNB2tVzcW3KkxIEPfSweb1jyvNu+
         nIXyf5ryB5CZ9W+evXRfpsBT9UgV/sld8OUaIAFAeY3CDJqYViD6kAaoA2B/T8aei7f4
         K6hWSZ1cR928VAKp+sBv6ShSj4oXlI/urufjJNJgkv9siJTY2otkPwadnktAxrdISDLh
         JdfA8dvAJuLYSQrmq+ReH50wZ1CSZicsmogV2xacCes8gJH6/ihwoYpVY4vp4CFAhvfc
         E6vLKfcpng/5bMx6io2mDtpoo3NHy0g8EXfAnLbAffI2wCVTGJVrePPRdWedp4InGwlM
         UhKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779964286; x=1780569086;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Aww6jC3I0Nj95YFehLzt5woPsMu1GhH9KVyzIE2qdSg=;
        b=ROJVQjy2lbzFCK9aepSzXIZiXwyFg6vhQ0WIgbhhYRSjdtsIm9K+edhl9c+jV/RMBm
         y6FFsDCXWQ7wCLPEAc7mXeOg4mjjzQVLKNin7lveZjazf6jSQKW/hPUO+e0pRWoLlHcq
         GQhFAW07Lwy2YvMT0B85GU21lIcRQyYbZD57JSVho0YSzPhQOApmpTazE6HvKXw77PC9
         O9Pll+p+ku2iKNUq9MsQItvWinu1IO5kY4BTSYngwg3DZomE5VE2p/CUwyBS/d/GAVHJ
         6nbOy8CM140lHkFbv5ACzkzHz77tj85O5vfyK5qCoOD7d9795FyF0ye35X+6u9XDXu4R
         cAKg==
X-Forwarded-Encrypted: i=1; AFNElJ/k+7xQwHEmQh7nrqAPx63KxRTe5sQsTL98ZE/evv9v86V/opbUk9Lb7OtW/+xS9WnPCOgC6XY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww0TOCRNaMauFRzZWtarbkY/9ukrROYTsAFWNIQKUrJiDnj1gH
	Rc3kzNwL7JpEQLOWb4q2siMWCTB5+MFnDDbUh123ORsD9hCYVAMzbysAQDcVKZEOSB6NnN2Wv7u
	BOHlcARiP08b9HK8uJIVPWazaovqH2R6WgDEX0j2gIRNYgKMWvgGBUloesw==
X-Gm-Gg: Acq92OEOrUNxuIb4Ey0L0etYdfIdizSiWrQ27ZIBAmus1TtUEOnXI5GXXxTfqADifix
	P4RPT1WhbV39mzo26q94dM4rgb9mjpe6mlOjEmLPTPWxWpU/sU39+tXfUjegYmCmkLwOsETirDG
	TJS5hzE4BGZ6u0zM9d/V5EQH6kx15c/yXZpaGJNbBS63GDPX/RH3ThXqCX3Ter42b0/h9EmdVW3
	qKqy0+w/3h0M5QLFHrKX3VKWdrp7NA2NHT8L5VPdKmg0Gf6+/X5uATRsKbMH48FVkBeIoMwcmKr
	9evZKsyRe7kE6mOGhHETiyUN9HJ6LMfqez493RNLrA2VB4Fhq3956UwN9Ho5SPQIG5jBQ+kM1Vt
	7eakeWtseORnQDZsAiQTT/pZd47TphySDPS8IYC1gYKsGouGo4XQm1w3MMK7xCVzqO3BEyqokCw
	YDbYOxkn8yHpI=
X-Received: by 2002:a05:600c:1992:b0:48a:76a3:2b9b with SMTP id 5b1f17b1804b1-490426c5416mr418407285e9.17.1779964286048;
        Thu, 28 May 2026 03:31:26 -0700 (PDT)
X-Received: by 2002:a05:600c:1992:b0:48a:76a3:2b9b with SMTP id 5b1f17b1804b1-490426c5416mr418406935e9.17.1779964285634;
        Thu, 28 May 2026 03:31:25 -0700 (PDT)
Received: from debian (2a01cb0580324c00f1205deb3ed928e2.ipv6.abo.wanadoo.fr. [2a01:cb05:8032:4c00:f120:5deb:3ed9:28e2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49092a817d3sm38019705e9.10.2026.05.28.03.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 03:31:24 -0700 (PDT)
Date: Thu, 28 May 2026 12:31:22 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: James Chapman <jchapman@katalix.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] l2tp: fix tunnel refcount leak on register failure
Message-ID: <ahgZerhdz5KcVMNz@debian>
References: <20260528043418.1153320-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528043418.1153320-1-vulab@iscas.ac.cn>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292650-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gnault@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,iscas.ac.cn:email]
X-Rspamd-Queue-Id: 680375F0B29
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 28, 2026 at 04:34:18AM +0000, Wentao Liang wrote:
> pppol2tp_tunnel_get() creates a new tunnel via l2tp_tunnel_create()
> which initializes tunnel->ref_count to 1, then increments it to 2 via
> refcount_inc(). If l2tp_tunnel_register() subsequently fails, the
> error path calls kfree(tunnel) directly, bypassing the refcount
> mechanism entirely.

This is the expected behaviour. Since l2tp_tunnel_register() failed,
the tunnel hasn't been exposed to the rest of the system and we're
guaranteed that nothing depends on it.

> This leaves the tunnel's ref_count at 2 with no
> way to properly release it through l2tp_tunnel_put().

The tunnel is simply freed. The refcount doesn't matter here.

> Replace kfree(tunnel) with l2tp_tunnel_put(tunnel) to properly release
> the reference through the standard refcount cleanup path, which will
> call l2tp_tunnel_free() when the counter reaches zero.

This is buggy. At this point, the refcount is 2, and l2tp_tunnel_put()
will decrement it by only one. So this patch just leaks the the tunnel
forever.

> Cc: stable@vger.kernel.org
> Fixes: 6b9f34239b00 ("l2tp: fix races in tunnel creation")
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  net/l2tp/l2tp_ppp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/l2tp/l2tp_ppp.c b/net/l2tp/l2tp_ppp.c
> index 99d6582f41de..16672e9df748 100644
> --- a/net/l2tp/l2tp_ppp.c
> +++ b/net/l2tp/l2tp_ppp.c
> @@ -661,7 +661,7 @@ static struct l2tp_tunnel *pppol2tp_tunnel_get(struct net *net,
>  			refcount_inc(&tunnel->ref_count);
>  			error = l2tp_tunnel_register(tunnel, net, &tcfg);
>  			if (error < 0) {
> -				kfree(tunnel);
> +				l2tp_tunnel_put(tunnel);
>  				return ERR_PTR(error);
>  			}
>  
> -- 
> 2.34.1
> 
> 


