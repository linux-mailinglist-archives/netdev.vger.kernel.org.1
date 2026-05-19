Return-Path: <netdev+bounces-289476-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJrhDaNuDGomhwUAu9opvQ
	(envelope-from <netdev+bounces-289476-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 16:07:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA992580434
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 16:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 370E7305EA34
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 14:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029653ED3C8;
	Tue, 19 May 2026 14:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DlxNFjN3";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="BwGqlPGP"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99326340415
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 14:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779199473; cv=none; b=DXb5ShSG2vIxO73AU6t/ui7SU/UXAljg4SilktJSLbFpVpL/oqhl6x6q7LPYtUWbYZ9TtdKep2pCk84M+lzXv5VUAnEFxYkvKM55AQPfxrjp/pa+OTM0KG5Fujmup6NvG6QpmBAjtwS/SCxgqEld+fxCJ0gzQR9xOOLTbNkTf5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779199473; c=relaxed/simple;
	bh=FMaMUKz/x8QbjfR3g5V6+iL3OxM0o0sNRaKeIldoQQ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fQeXm4cTs0cNS5ouVecttD3nLVbLxOKNW0vKTxdNyntdrKg/PbZaqa44F7jCIfim/m+tAOmsEHKnvinna3SwHI3VDWo253g8ifsEGvqOZTirB4yHAz9we5zpVQkc+h40C5oXmFgVkbxfyTbqfTmuyJsvGaTzOgOI4iidkOFh+EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DlxNFjN3; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=BwGqlPGP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779199471;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JyK79IEx4ySepGt4cTN7KOjcr0GF19I7WDCAu3CkGGI=;
	b=DlxNFjN3lyvNeNWdth2K8s1+gqMkhAWouoKTLoCcoB36t5YuyhcVqkRJJ3Ir9dgp+4xAkD
	BA+y0buyHlQ2eKLRWThCA2Jsd2dp8MZQTh9CQeXXBAPBRDZ57BQVjAkHuhW+2MCGb5AB6b
	iYdfBmAzkt5hB88fr9l2c+nhfwIaY3g=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-Yea_b17lMqqvm_7LZmcrBg-1; Tue, 19 May 2026 10:04:19 -0400
X-MC-Unique: Yea_b17lMqqvm_7LZmcrBg-1
X-Mimecast-MFC-AGG-ID: Yea_b17lMqqvm_7LZmcrBg_1779199456
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-45b7ff2140eso3180066f8f.3
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 07:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779199456; x=1779804256; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JyK79IEx4ySepGt4cTN7KOjcr0GF19I7WDCAu3CkGGI=;
        b=BwGqlPGPyTAEKuDwo8sJ84HiXt9d6LyIl3O6pJQ3hFJOV4X0PKuplQNp5LYIT5tB3W
         jvYM2P1TV4Ezar8/q2HeMsjw+6oduw9NQD8f/Hb0CxUzal9g5uUqJrYPYRRryByceluC
         dN+sGVRQWEkkApEI9FS4l42ymmv6oRo5fa4yDkCGQYSpQJ+2Kw/S4P2ZS7+TICNjVrMc
         /H2GzVj7PBn6KpvYWQafxXhQfq5dJT5yS3XCF4/o9+sEC6gxlvL4jze434UqMaL0jH3F
         ekmJ6zok9+j/itf1kcEJY5lMyadAa/kjXBfmEp9QEGC+/nTaVVsIpHljlx5YsJjmxU2W
         G0Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779199456; x=1779804256;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JyK79IEx4ySepGt4cTN7KOjcr0GF19I7WDCAu3CkGGI=;
        b=KSCLitxVpNSGWR1LBildOnkffJ0X8nulgG0zOfqiNvzFElwzYXJe1LUaPihjSroVL0
         +AA3fpeO9JDpBHzgd5zW5UF/5Tj6hNctrJKTBZw9c2otJCxt3cka8LDkj+952XDZfavy
         SagZWg7XPJf5xFphu6xyySJbbzg0CykZ9NO81m+3n7BpZrP0j0bS6JeeFG2BjR2QMcQk
         KdjdSbV5dM7o4DebJSTz9FToSSAjyuWeTC6TdJhUfOzpMW8SDndtbO9r5ygfSMa7YmSx
         WuS6fhZafxwj78Zi8rbRjHwQYPMTQbIxOmIEZskpCsqf8liPA5ojypJuJ055b5r760uy
         +y2Q==
X-Forwarded-Encrypted: i=1; AFNElJ8xoFxkuZzB8WrmaCnGOnXZptousIB6XiaSQD/ja/TkdaRSD2WNnBWalGhcbybsyvmvAlQ71KA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFH0loM4cLkHDR1ZJxsZndsySS9eR36PdxMVPjN+uScoqi3F1F
	P3d6CwuD3lEnt6zwft4GwvWk6rNjfXWe5hIhbpWwVoSdDxlVElznYFbYmN+8XdiepzdRy9ASrT1
	uR3OQTqmU9icHnhYp/+jwzBFVMA0ImYOiS2M/DVkkrsU30P40ilWjAfSSgg==
X-Gm-Gg: Acq92OEGQAgfxmjSFOI2Y8xNqA4DS+e2LPt0O4WMtcKOWY48qcU9HvdgRfNSZKv0a3O
	Uih20XyzShtDKiAQwpGwAzuNvwOWf5kqXUivQsXksXZiCvKox3F0KsEwDhQbo8gMAsn4Nlz4P2I
	E8qKAFVwkwhHFCKyTfiNnNvl36ooizXzTy51GMNbjg2rboLSDHm0i8d+niqnLmwt2hHSS61wUam
	Qk0YJ/jaW+VH0wRCVpIJS+D3bai148Xfa0brdYa38Flx+9aThL6TVIibK7M5V4SKpEcJTMAwCoG
	p1lOCDQVL92yltZgkKVxaUNsVYV2+kgbqx8SxKp1gsb+IDM/FAQGbMfeTK5yjqRME/wv22QJDz1
	Zc0hQAdS8SCnNe4DZKJLHCajWHG5oh+D9P8W2ZzoeAwS49tGl4it+BZU=
X-Received: by 2002:a05:600c:34cd:b0:488:936a:6220 with SMTP id 5b1f17b1804b1-48fe61f2c03mr335533495e9.21.1779199456382;
        Tue, 19 May 2026 07:04:16 -0700 (PDT)
X-Received: by 2002:a05:600c:34cd:b0:488:936a:6220 with SMTP id 5b1f17b1804b1-48fe61f2c03mr335532795e9.21.1779199455912;
        Tue, 19 May 2026 07:04:15 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.25.33])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe57943b2sm337222105e9.8.2026.05.19.07.04.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 07:04:15 -0700 (PDT)
Message-ID: <eada2df3-7e3f-46a5-b290-fe0e8975a1bb@redhat.com>
Date: Tue, 19 May 2026 16:04:12 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 3/7] atm: convert to getsockopt_iter
To: Breno Leitao <leitao@debian.org>, Chas Williams <3chas3@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Magnus Karlsson <magnus.karlsson@intel.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Jon Maloy <jmaloy@redhat.com>,
 Alexandra Winter <wintera@linux.ibm.com>,
 Thorsten Winkler <twinkler@linux.ibm.com>,
 James Chapman <jchapman@katalix.com>, David Howells <dhowells@redhat.com>,
 Marc Dionne <marc.dionne@auristor.com>, David Heidelberg
 <david+nfc@ixit.cz>, Samuel Ortiz <sameo@linux.intel.com>
Cc: linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 tipc-discussion@lists.sourceforge.net, linux-s390@vger.kernel.org,
 linux-afs@lists.infradead.org, oe-linux-nfc@lists.linux.dev,
 kernel-team@meta.com
References: <20260515-getsock_four-v2-0-0d8eed952627@debian.org>
 <20260515-getsock_four-v2-3-0d8eed952627@debian.org>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260515-getsock_four-v2-3-0d8eed952627@debian.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289476-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[debian.org,gmail.com,davemloft.net,google.com,kernel.org,intel.com,fomichev.me,iogearbox.net,redhat.com,linux.ibm.com,katalix.com,auristor.com,ixit.cz,linux.intel.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,nfc];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: EA992580434
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/15/26 10:32 AM, Breno Leitao wrote:
> @@ -797,13 +798,13 @@ int vcc_setsockopt(struct socket *sock, int level, int optname,
>  }
>  
>  int vcc_getsockopt(struct socket *sock, int level, int optname,
> -		   char __user *optval, int __user *optlen)
> +		   sockopt_t *opt)
>  {
>  	struct atm_vcc *vcc;
> +	int val;

I *think* you should use 'unsigned long' here to avoid user-visible
changes due to put_user() replacement.

/P


