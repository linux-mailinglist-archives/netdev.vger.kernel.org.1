Return-Path: <netdev+bounces-305025-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id efJwEbGrS2ocYQEAu9opvQ
	(envelope-from <netdev+bounces-305025-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 15:20:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A1307112D0
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 15:20:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=F3ISOmGw;
	dkim=pass header.d=redhat.com header.s=google header.b=kGoSHgdv;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305025-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305025-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 92120309733F
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 13:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A603DDB04;
	Mon,  6 Jul 2026 12:59:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5B33DDAE5
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 12:59:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783342777; cv=none; b=h0DRDrPewRRpu0CL05CPRsb9hGUUEHtgl+vTG+6Wypufm5Kd6/b2OiocrKZDUVoi+Ux9GHR2VAoOzlRGdO3NwUdcH9rimvmgoTh/gMISwQLryGWpZ65yz1Jg1AFw6eIEInzqxPbbhAnZ06G+KCSKWELL5die5Vw2XT2+5lfyBfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783342777; c=relaxed/simple;
	bh=s9b9bY6MCpyrRAFwYuTIXWvnVjlLEHiUcxu48WtOtdw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K2MYsuSeDRGCkNR0+Z8Rze4e9q7YZCPTS7iaPQlRf/RAzAiceIZ/bggSypY3bfbhc9UEapClZZj/b5EfNhyNxEHN77K1jb3J03JfluUxNkmA9JhRCQ0xNF4TiHwYzlGx8iOa730uiozb7Ct3LwJY0hsLIK8KxB0SZUECFvindk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F3ISOmGw; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=kGoSHgdv; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783342775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zoSKYyhKqobABEuW+nEYaaDQiTcrlx3ESRdaTrHoHVE=;
	b=F3ISOmGwYuMdkv5mFu7UCcUQPD1GHHDg6v5l5yQfqUOC95COg0gnzHff61qNCku72YZ3qk
	nQMRaLhwheRtIKNbYy/t26ioFINJ2LUmzX3yJ2B+g6flWBrHlmeJd8wFv6Q8Qr7qpqv7qv
	gbgxwMl/dhUOTqw/w+F8VoHNDQrDHCo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-201-PdAKugnIN3WUmjUqqRNz-w-1; Mon, 06 Jul 2026 08:59:34 -0400
X-MC-Unique: PdAKugnIN3WUmjUqqRNz-w-1
X-Mimecast-MFC-AGG-ID: PdAKugnIN3WUmjUqqRNz-w_1783342773
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-492488f8583so31475845e9.2
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 05:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783342773; x=1783947573; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zoSKYyhKqobABEuW+nEYaaDQiTcrlx3ESRdaTrHoHVE=;
        b=kGoSHgdvKkZLowhmDrRMCxAr5lXx9KCAFxi6VM1UwCYDerAwGZSAr1yuM5VpyNmP9G
         m08NK+Lk7Cg9bq//wO63+xychubl3tWaMGTPAZ9tcSvKOV5/Jz2L9y8EHe9rJR3dzAOP
         J5c+of8brHUL3MPMVTv/FMwq9+5aKSpzcbjjyTMzpEEL/HBCi6Nk8TD5voP6RdocAJ3A
         WJ+X2R8519HPTw+KfxKO+vUmP3DGQrcf6DVMUzJFXo8SoVKqB7Ks9yNwtpkJxZW+ruFm
         d9IN3GlhLiTA2n2iWTvOf/AuNUcnPj0Bdw3zMQJkxX1C2Y3T4aje1HVxVRXKeZ1LJgki
         PArw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783342773; x=1783947573;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zoSKYyhKqobABEuW+nEYaaDQiTcrlx3ESRdaTrHoHVE=;
        b=E/C4AGXIvZTLKuO78Y5YAuwBoef7w4atnYVU7XEDxFXY4/O2q36Mn4t8EKLhxDHh2X
         YwkB88+Riqu/eih/hhZiolbDmVBbWtNGihNJ7ZAycdvGIfn20BxTKkEWlyawrA2G1sr4
         GckcaOjeHvKvfWj1k9EQGwBjz/0Nl5fbHTkN7m/GfWt9IDpCGhy7cTW3oXYbogfvGLwQ
         qRaLnP4yKEUnS1b5WQSVhfcyNB0JxfvPZnitAmPhwSkqkr1v9xituQzmUMq+xpFXxXe/
         5S+O5RPvHpt38W2/ebe2G4+GwZPGUBkRqAcZ3lzGh4ibrqSkT1eXoCdJZZRRbMV0SY4E
         +Blw==
X-Forwarded-Encrypted: i=1; AHgh+RogspZKK/ULVHXLtG9rRLnCAGxOJhwzJnFNYyXiHchiMUM75uYfx+GJCgjhfn9hVKMxB6k3Wa0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4RgPqolCEg8jkfc5+efglCb5gr4UrJvoV5q8jQAmeCZDyn6XP
	PX0GrgYmkPWYxMNz7RA1wticd/JGynt4fAh+cgm2xh4J/EncX6MiTRMgVB1dyAdTiKzD2P0d3AG
	wsj1SFm6UgppCs7vgOy9VucCg0uATMOS36+xmOb2KwSdtWy7LTmBVjI/DtQ==
X-Gm-Gg: AfdE7ck4/5H5M4ApEjt/WI9Hy7X78o7doiFWgU5QZyoJhqFnLFhmm3vnanpR3rFNOlo
	z26HzpyOMuHTbY9pJXxjoJSE21xhVl+WGuqTVO1xIkWw3vkiy0c8XrL44SxEFg1uPaED+fsK9i0
	87YyIMxjpPSaJUykfSeFUV9qT5b5VDXX+3v9a/0yz/idx4WmZ2tRIr8bFx/+ZhcUC5ubnL9tLTA
	o9vZ/mblv+Vw1rfK3HsuGVfgehZ069xpRJMGcAr78xYOCBrsgPmrwxpQJZntguYPoVu6CNieZz9
	IFzipJWVqm0xlui6iX5Z80C+N5ROP+iP/ocgo0HKO52DR7W5BGDKBneZEm7HB5/BJtU7IuP7dKO
	QCJvp6yjAchyFpDHDPI3HAqICgxuOXkkCZt8RoJRoMWSyh8UakIuLdLPiAo6cDLIH3jbCXoVvaM
	H7kRHAxgDPhHhF
X-Received: by 2002:a05:600c:4747:b0:493:be3e:cc3 with SMTP id 5b1f17b1804b1-493df093146mr4391975e9.21.1783342772613;
        Mon, 06 Jul 2026 05:59:32 -0700 (PDT)
X-Received: by 2002:a05:600c:4747:b0:493:be3e:cc3 with SMTP id 5b1f17b1804b1-493df093146mr4391595e9.21.1783342772196;
        Mon, 06 Jul 2026 05:59:32 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493c63bf7efsm373032595e9.14.2026.07.06.05.59.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 05:59:31 -0700 (PDT)
Message-ID: <bc05872a-b42c-4744-b18d-5fbcf5df1e47@redhat.com>
Date: Mon, 6 Jul 2026 14:59:30 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] sit: no longer rely on RTNL in
 ipip6_fill_info()
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 Ido Schimmel <idosch@nvidia.com>, David Ahern <dsahern@kernel.org>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20260701155135.3962058-1-edumazet@google.com>
 <20260701155135.3962058-3-edumazet@google.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260701155135.3962058-3-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,nvidia.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-305025-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:horms@kernel.org,m:kuniyu@google.com,m:idosch@nvidia.com,m:dsahern@kernel.org,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3A1307112D0

On 7/1/26 5:51 PM, Eric Dumazet wrote:
> @@ -1184,9 +1184,9 @@ static int ipip6_tunnel_update_6rd(struct ip_tunnel *t,
>  		return -EINVAL;
>  
>  	t->ip6rd.prefix = prefix;

Sashiko-gemini noted there are ONCE annotation WRT ip6rd.prefix, but it
looks like they are needed.

/P


