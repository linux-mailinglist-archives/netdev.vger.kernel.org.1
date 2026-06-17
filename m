Return-Path: <netdev+bounces-300085-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eV2xOd9kMmqhzQUAu9opvQ
	(envelope-from <netdev+bounces-300085-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 11:11:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 428CB697C85
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 11:11:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=TCeul5BK;
	dkim=pass header.d=redhat.com header.s=google header.b=omYqJm3Y;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300085-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300085-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 145F4317BE1A
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 09:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8DE539D6FF;
	Wed, 17 Jun 2026 09:06:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7314739E6F0
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 09:06:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781687181; cv=none; b=dOyYVUfzCE0cGKleXb7tAmqF2B0gyHU3buEbdS1zHcqhpNSQhU4LkNDamrVDwKLPRoZ9mDdGTbFLotaDLFfaNVWmUHwweGUs1zBpCMxB8PLzyJM9THaMIrR5gBvM6po3I8BVV8unztVPtn7MS7L+LhZoVsIOrRDNTdzcuY4oof4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781687181; c=relaxed/simple;
	bh=69WZuOaA5uDn33icQVKr/RJg3X4tdnNGNXmU1ISAwwQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=F08ViCez8lw4hhX9D91qYyTNpG8SC748VT0VK1DqQzB/fuQw+s/W/g8yqxy1eg0+fjCCOJXp9wLip8/zlGVoj6IbrzwcHb8C8E7ihfmY49zSSm+HF3/K/i1e9R0ltbb6XyyBbou3CL+hyD0bagcEr1nP/J4SomsTp0CREXGMXNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TCeul5BK; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=omYqJm3Y; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781687179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=69WZuOaA5uDn33icQVKr/RJg3X4tdnNGNXmU1ISAwwQ=;
	b=TCeul5BKjlp8XAOdMPwAz9lrX/X+cmsSFxdLtV7k+0oqG4CHoxmD1/fpGSzC+NEfleECO1
	0p2MILKXQx/DWef+N4hmwbZrMB1ebsk0JY+1gj5raQ33fxpx+vcfL95z6ZDwfh0XG4yJcj
	mL3P35MrZmZDj4SfqbPSrMLMFgEa8TM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-TffVwXTFMD-Eq_4_b_1GZg-1; Wed, 17 Jun 2026 05:06:18 -0400
X-MC-Unique: TffVwXTFMD-Eq_4_b_1GZg-1
X-Mimecast-MFC-AGG-ID: TffVwXTFMD-Eq_4_b_1GZg_1781687177
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-4625e71d3ccso404540f8f.0
        for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 02:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781687177; x=1782291977; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=69WZuOaA5uDn33icQVKr/RJg3X4tdnNGNXmU1ISAwwQ=;
        b=omYqJm3Y3d6sWHBMiio2UhE6hR1M2vcnpPoyqpdzBMMUK/HhpAOXO2mkZuuvm1CRwl
         SQfepF6GNbq5DYWL/KhAkwFxPZjq5R1XihXhaj5b9VWGKkp4TSbn/P/BXZTrUY+/kmKH
         SHzNBJxhaZAx8IIM6fEf6YO5avjOdciZZg2Jbufsh6Sx96+fgb/GcOWwr+jIw72g2Zui
         aW4QPonVLtl6OwSNLkBbnyHcbeedAb9mR/TpFZVYGgpSZatpqHMCKG3vGeO5YjBTDFLw
         cpE4R0zjjVXwgrNtVeABo2fFgv15Bd7uvYM5S6lRpbD0iPFQUMCEOJRYD3ltS+uQ30G/
         +sdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781687177; x=1782291977;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=69WZuOaA5uDn33icQVKr/RJg3X4tdnNGNXmU1ISAwwQ=;
        b=cWBi0d2idw5DiUxxhX5PyROdeWaiMGHdF14LDV539LmL6RJnszjb8HmRGjh4cnNR5l
         /fcPK/2Z13B0XSD2J/p+DWFbZdN1pO1EFFhwhrtTHiSdaRH7q5z/LDM1lIRuFXk2LF5n
         7QpkzB2zl5+UvNKTV22AwxnFwEfRINJOqbksVUK+jVkvR8FNbgLNaVw7KulYxHMx5sKh
         s/gVz/eKA7ARAYXqyMNYmLsZEfuHOd9BqogzsZepOmadHGx6WRPib95k+3/WPWq4sGXG
         OQKruW7Iq30Z2kn7MsvXF4dkdEfO8pXIBE9u10YWlhvfp9h1aLlg9xdG5wNUAigl2mrP
         YHOg==
X-Forwarded-Encrypted: i=1; AFNElJ/ZghsNmBL9T2prw/IKjqnA3I7hu+YYHFQ3rheRVnoFb9VrLuNyPgweahBaC+pFpmY0PDd/bCE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2wvwxt7YVxTw8BQFdWHJFN34Znk9OTiMwzwPzJtjag7k3UvS6
	pPNI89d5Eg1SJ8nsL3XywzqBcb7x7ZrhBWSRQ+rWq5N1i4lCr8BZAMBFKx2XI0ShP0yyNOoqHeX
	vz2DgEMTjsUggLmxclKS6bjjT+5YEmFH9zYmC7MCEOb+TpyCAovRLOYd12A==
X-Gm-Gg: AfdE7cmKMmsA5FiVnEG7wZ/dIJlGT+Oiw+PMZYzwIHBI6jYkRU0neTDWKmgwCn2e18B
	JIp+KxdSNRD8SoXMRe9JIc73cWpyqQp9ziyx2Xa0Qye+DG9xXdwLBWyE9LOR7jAsMwtq+TVc1np
	Oqh5UHYPxmFzjQNRgN93AIj0pD1bQDlQMHN9OwPABtzvPs6olOA7K0oKYhex1DK53vnf3/8kuLK
	yf9qyBjBoAILDnWk51y4YDL2S3NA5GYjx9qcl1XPgLCTFIqPMCV9+9nkLoKfjfEVj0ISNj3Uvh/
	sVSGoe/8/FC8zE0uSNXq4XCvV/nSZ/evI7sixpI7yTG3vprew5Ml4CV9eSE1tKEUBUyjFWLe16e
	eEc3JSixcT/IcWIM6GBWhUoSXdAqo9awrg7Y=
X-Received: by 2002:a05:6000:603:b0:463:1d06:ab33 with SMTP id ffacd0b85a97d-4631d06ab96mr684818f8f.27.1781687176619;
        Wed, 17 Jun 2026 02:06:16 -0700 (PDT)
X-Received: by 2002:a05:6000:603:b0:463:1d06:ab33 with SMTP id ffacd0b85a97d-4631d06ab96mr684756f8f.27.1781687176152;
        Wed, 17 Jun 2026 02:06:16 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-462a9784497sm3816334f8f.34.2026.06.17.02.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 02:06:15 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 9B8D88074B0; Wed, 17 Jun 2026 11:06:14 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Avinash Duduskar <avinash.duduskar@gmail.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi
 <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa
 <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, John Fastabend
 <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, Shuah Khan
 <shuah@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, Mykyta
 Yatsenko <yatsenko@meta.com>, Leon Hwang <leon.hwang@linux.dev>, KP Singh
 <kpsingh@kernel.org>, Anton Protopopov <a.s.protopopov@gmail.com>, Amery
 Hung <ameryhung@gmail.com>, Eyal Birger <eyal.birger@gmail.com>, Rong Tao
 <rongtao@cestc.cn>, bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 1/4] bpf: Initialize the l3mdev field for
 the fib lookup flow
In-Reply-To: <20260616223426.3568080-2-avinash.duduskar@gmail.com>
References: <20260616223426.3568080-1-avinash.duduskar@gmail.com>
 <20260616223426.3568080-2-avinash.duduskar@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 17 Jun 2026 11:06:14 +0200
Message-ID: <87bjd9h6yh.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-300085-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[toke@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:avinash.duduskar@gmail.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:dsahern@kernel.org,m:shuah@kernel.org,m:hawk@kernel.org,m:yatsenko@meta.com,m:leon.hwang@linux.dev,m:kpsingh@kernel.org,m:a.s.protopopov@gmail.com,m:ameryhung@gmail.com,m:eyal.birger@gmail.com,m:rongtao@cestc.cn,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:avinashduduskar@gmail.com,m:johnfastabend@gmail.com,m:asprotopopov@gmail.com,m:eyalbirger@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,iogearbox.net];
	FREEMAIL_CC(0.00)[gmail.com,linux.dev,kernel.org,etsalapatis.com,fomichev.me,davemloft.net,google.com,redhat.com,meta.com,cestc.cn,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,toke.dk:mid];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[toke@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 428CB697C85

> The helper already initializes the other flow fields the rules path
> consumes (flowi4_mark, flowi4_tun_key.tun_id, flowi4_uid and the v6
> counterparts); flowi*_l3mdev was added to that set afterwards and this
> helper was never updated to match. ip_route_input_slow() likewise zeroes
> the field before its input lookup. Do the same here.

So how about we explicitly zero-init the whole struct instead of adding
more fields ad-hoc like this? Otherwise this seems like something that
is likely to happen again if we ever add another field to the struct?

-Toke


