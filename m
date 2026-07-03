Return-Path: <netdev+bounces-304376-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mkC+C9JbR2q4WwAAu9opvQ
	(envelope-from <netdev+bounces-304376-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 08:50:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 888B86FF375
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 08:50:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=hnVXtDMt;
	dkim=pass header.d=redhat.com header.s=google header.b=sZ9me5Fr;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304376-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304376-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C970B302768E
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 06:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183FF388E42;
	Fri,  3 Jul 2026 06:50:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A88E386450
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 06:50:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783061432; cv=none; b=PxJHhrY3zEHP1XEoLo0TLdXPZfrLb5xvO1JCwOJrvqULTR+td8dGLQ/hveVcO4mrMd/9KkwddpQIZjb/AjsB46eqKSSDEJ27fNXlBpMu2E6Q8Ug8+xueDMuzt44sxA2FtD+RvuYrP3fDNIgdh6v0jyWsQaJ6lnwCq5TU7tXSAzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783061432; c=relaxed/simple;
	bh=FAHgEr0+qYzyMi2GMfvTD6+0+azG/R/j9asAIzLTAZk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F0aiWnQVPhaZVYpsgtygqR+w80rOZsW3u31BOqZhN5hcqxEmlN92phCS5oYwXZ20pd+YfKtGcq4BJNxILMCKlg69Zl2eutNwGZmzTlqEonf42lVcroD1ZVhpwpOpneO224IDlN9W36OgowS6IVeLmRc1FNI1qzx661Ke37Kq+ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hnVXtDMt; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=sZ9me5Fr; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783061428;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZZoQqgKDmro48PzsrYUtUQsh7adKe/rqnmsjXdwyuCY=;
	b=hnVXtDMtWxtEDFWhgDkFkt6KHdJelFINXoc7p7W4ogfKmDwXTLGBfXrnu8tcEXnFUQjiv0
	JRT/8t2PntLhZKR0VTgwxI3D/j596tXERzLPGaA0ASrtzz4h5lfrWp7wjuLPHWp+tpDceV
	AVNr4Ji8ipKgx5sqk4/i/dnDM7RDerc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523--1ZeLbZ3OYKeQJVnIVrqAQ-1; Fri, 03 Jul 2026 02:50:27 -0400
X-MC-Unique: -1ZeLbZ3OYKeQJVnIVrqAQ-1
X-Mimecast-MFC-AGG-ID: -1ZeLbZ3OYKeQJVnIVrqAQ_1783061426
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-47162f83c75so950472f8f.1
        for <netdev@vger.kernel.org>; Thu, 02 Jul 2026 23:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783061426; x=1783666226; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZZoQqgKDmro48PzsrYUtUQsh7adKe/rqnmsjXdwyuCY=;
        b=sZ9me5FrNo5YOzNwOhyNA+RzIVG2Td313rod9/bqm3UO4sPD5KNQ3MkRuesbkSUsEO
         bkaQSOcLbNHxA+vwBBIt+FpeGfIlyaXCt/x6ZRDJLVQNKIWXLIF7urNtnfwwOTukgFcV
         ELAMSZ8PV3asYtiZ+TIsnUam1OPgQbvutz4Tk4WqYXZXjJmoWmpUP48LtzHZt0VhJqgp
         E2YS5Mj9Ue3cEL1RvgsMgQutDyTXGcFgIYd17BM2FloBUAonatoWaBg+B/qvN3/Go1oB
         p5dieT61jklUQK73kB61C7XhA3OiXG7xgngd8wxp4z6e7ptKq+dfTUBMWOGDV31LOix9
         CEBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783061426; x=1783666226;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZZoQqgKDmro48PzsrYUtUQsh7adKe/rqnmsjXdwyuCY=;
        b=NZ0lllbxMkjp8JO+pAhxT8mzO6WpDnZGaRa4J+BRehoEi1qa653cXjo7e1ys34DmAw
         +XQOfm0jHc2LcL8tq9uCh6wb3HLG/F4eTzUZ0PpI9hcZCEcvCdA9vKq89j9OQut3hJB2
         g9AwrfBEg/YSf2SkytZLEJcYG1YaMtjwiJ6Sf1ki/ZsKCZY9XH32GpAAdP82KAEUefA0
         BiKeDClV7PrHcxqFcpns6heQ2kkqz5OW9y67LVSO46nBgxhapGPjztvvIF6qHwUrsFeS
         Q5PDTLf9G2xtQeTEoBvXT9XsvPfrYFu2i1HMMRckU/dUibWEZH61AhCBDAQrBXfoqZBn
         9fSg==
X-Forwarded-Encrypted: i=1; AHgh+RqbmFbDPJ3h7MpqctfAG/cQeSvw94vhU/13QgBEGFNW+x4YR2hcpIbAYN/20xNOydbkBva6b0A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN0SuqQE2kdHQTtIv2RMfd7UkTkM0VJNI9oh7sMTWz5BCgClkT
	cjMGRXNgf8zl0l3IYjgB3WpsH9jGP9fZC1p3RHlVLnpduEJf54Hb5bVL8ki8OgqmD5UvL2kLHsy
	ZE33zjTqVDKPRuiije6CMT13EYRg+sCIQIw4OaNPvszg4Eimqib5s3UrfOw==
X-Gm-Gg: AfdE7ckMrw1qwuDKRmzmlEgdwMahApMHuztLcz9kf28MMRtThulV7iMNpjJtFRYZAjr
	aFt8kX6WcMu8hhL7xPOw4ESfgfCw31QPnaJhJ2JlHU/DyCnuct8wqy1mur0lK4pApiMmQrzmzrS
	2SOoilGKiHVfUGyxGGEaVYct0nxhu9wA/LKwuRBAFWyIWHcV/BUl/6FvcMye9WFqxpQjcYZZfJD
	EVeGhvu2CmbrMF38IkYCaVEeIcAKzwp5NxRooexmixNOD1KUXFIbcccTRmePPwYJrY5HkuyzlE8
	UX/csCV6xJpJZZ1ZrjBtfBBiA0ACO8wKZCHFX9ze8fJVa18UKpFBDvHtQiSv5zM89rxQjr9Tab3
	h+Qq3Q7tODLXA5QqC+XQWMsJ+VTgVN2npTijkf6tmC2qox+v69l1oOEYsuHN9bNqwXGKEY+Vmvt
	V7+2R7q7WGpw==
X-Received: by 2002:a05:6000:112:b0:46e:6959:35a7 with SMTP id ffacd0b85a97d-4793657c2cdmr2990084f8f.22.1783061426001;
        Thu, 02 Jul 2026 23:50:26 -0700 (PDT)
X-Received: by 2002:a05:6000:112:b0:46e:6959:35a7 with SMTP id ffacd0b85a97d-4793657c2cdmr2990062f8f.22.1783061425565;
        Thu, 02 Jul 2026 23:50:25 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:2eb7:f61a:75:4534? ([2a0d:3344:5521:6b10:2eb7:f61a:75:4534])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-477db8a4b73sm15116562f8f.15.2026.07.02.23.50.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2026 23:50:25 -0700 (PDT)
Message-ID: <2a0033b6-9a54-4de3-b1a8-78d4bc815f56@redhat.com>
Date: Fri, 3 Jul 2026 08:50:23 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/3] net: report multicast group user count
To: Yuyang Huang <sigefriedhyy@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, David Ahern <dsahern@kernel.org>,
 Donald Hunter <donald.hunter@gmail.com>, Eric Dumazet <edumazet@google.com>,
 Ido Schimmel <idosch@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 netdev@vger.kernel.org
References: <20260630110207.37841-1-sigefriedhyy@gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260630110207.37841-1-sigefriedhyy@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304376-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sigefriedhyy@gmail.com,m:davem@davemloft.net,m:andrew+netdev@lunn.ch,m:dsahern@kernel.org,m:donald.hunter@gmail.com,m:edumazet@google.com,m:idosch@nvidia.com,m:kuba@kernel.org,m:shuah@kernel.org,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:netdev@vger.kernel.org,m:andrew@lunn.ch,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[davemloft.net,lunn.ch,kernel.org,gmail.com,google.com,nvidia.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 888B86FF375

On 6/30/26 1:02 PM, Yuyang Huang wrote:
> RTM_GETMULTICAST reports IPv4 and IPv6 multicast group membership, but
> does not include the per-group user count. Userspace therefore still has
> to parse /proc/net/igmp and /proc/net/igmp6 to obtain the Users column.
> In particular, this prevents iproute2 from moving "ip maddr show"
> entirely from procfs to rtnetlink.
> 
> Add IFA_MC_USERS to carry the user count in RTM_GETMULTICAST dumps and
> RTM_NEWMULTICAST / RTM_DELMULTICAST notifications for both address
> families. Update the rt-addr YNL specification and extend the rtnetlink
> selftest to verify that two joins increase the reported count by two.

Will you take care of implementing the iproute2 bits, too?

Thanks,

Paolo


