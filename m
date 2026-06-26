Return-Path: <netdev+bounces-302256-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rM1pEF7KPmoqLwkAu9opvQ
	(envelope-from <netdev+bounces-302256-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 20:52:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 903BC6CFCFD
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 20:52:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ku4SgX+g;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302256-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-302256-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4FE2E301D32B
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 18:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F053ABD98;
	Fri, 26 Jun 2026 18:52:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEBE30569F
	for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 18:52:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782499931; cv=none; b=iEoDoiMm2uyQ0xswf2l03M+/8c8WIVHCwHJjluxLyY96R62fJPq+5HloIx+8M6LM7yauRWR7F/yBZDGHFBhUjf45hg92x4edNQtRXlKdhWOUsbn0anSzkewvsicP/FEwfWeNhZDfYTgwL1vxDGQE1JsuOnedGSJ80/PXCwDqp9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782499931; c=relaxed/simple;
	bh=faZnyJz2V87Mu/N0BovXnVc1f0xWT29HYoOHfcayBxA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fCmC0Otw0z5AhAcooV6lj9+A+2PHNLWafGzI8edIeFx/4DVtsGDnb1vbEKuPkS53ilk+HFuKmFJMo/d+6s3bLrxRrpMpNRkfivJLZXRibyLmrDrsxTH6Vw609oyGhYZgL3uCpocRKj3vX5C34MqbbKyLB8+OjSpbQ7Fw3A7eaH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ku4SgX+g; arc=none smtp.client-ip=74.125.82.179
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-3078e0dcd67so2213574eec.0
        for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 11:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782499930; x=1783104730; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=faZnyJz2V87Mu/N0BovXnVc1f0xWT29HYoOHfcayBxA=;
        b=ku4SgX+ge/ieQoABdELk3oGWcUguzXbqwlGb4+8qkEIpt2dzPf4ILnVDKERukW1/c2
         tm5xViCiTFG9unVQUB+zgOBMPjTbEziHT35YjbgZMRtGJj3DReGblw3JwV16J6RXiEQc
         iqRBlMoeW1CGbcszLKq+n3vsHZRJQiBf+UJzNVrlmvPZOlhrzB3Zg7l+wMk9zoIpr4vl
         82jIr0R156/TIaT0J4EGdgfPa8UDOAFzVjEpYncP644vA+11ONVVfPaQcHJpDr2dO5sF
         M+Zj7lyUzy26PwCqH++djH9HoX6VYcTojShJ78GgLjOC4WujdWENMWbFrBvHhRWbqQeC
         l24w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782499930; x=1783104730;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=faZnyJz2V87Mu/N0BovXnVc1f0xWT29HYoOHfcayBxA=;
        b=TeW+f/MROU0VRCUh94VUyVlb/S4kJCpLL8pO/jgkPg3ukhc7xyEGuVCWnYwtzOxvXu
         vKdc2y57USWciMJvfQEDTbqui/p6kO7sJ/iGskt+/rpggyG/mJKf/Dj/6+pwj393FfsE
         /n337DMN3QhUMtdpne6tEBh6OCREU/J0rNh0DUZ9Tvig03Xu5/gPTopJuurYWElLhfcX
         3ihuXQnSM8kL25M8nWMGp/9/0JrBzh8MOFokGeJyxcyapCMGPzQgkizDv1m+jBanoJRX
         j73kUIOyDQnvONcBE3QyYQKjX+agGn8TE63a4/DYjJeDfUqRElPCXRVtPvmLuFHWH2Ek
         B4/Q==
X-Gm-Message-State: AOJu0YzxxMgcitBEnkfo6WNT+XdJp73rxE+3DNtG2jOBcZXE37S7MuWG
	QMlRxXRLTwpvyR0Z+rMoodgbkht2OW9DwTst8U5958D7tatLyaSUHmid
X-Gm-Gg: AfdE7cnRUb3f2QDKkD0VwYEf/TAU90SFfdGEUiC5G6CnqgRD2XmsRZPwUIiyRHmhMFP
	jL6GyKn+/tbxZlahx6A+fntW1aUQx7m1Z+yUcVfosREVjA1a9KMwJtIvNT6ZSdHbR6GZ3tes3Ee
	QpBLPR3k2TQFA2cGL4inXWsCjaGkdqyWaKTs+LeP778T0jjwirWzqrpTe1GdrvohuZ31lIbBOmM
	1dTv89Mq3FbvsTEHol01cJPcA3F4/Y4CM8gyRh5sMFlskLtkeZV6ONeZNF/JidmQEsXWEHboFRl
	xGIverh+Yu9bjIh2VAKpx+y2QipqTRLrw9NtFRUB70avlLwBi6+TNWMeG2Rd9qz/pEyxsMWooQI
	/noOfK7cYjpE9ou73PU7kPS+JbQGjeoGZrnJlzfYXHomYpqUg2DpC14E5vP9J5Qp8rJjsxHf+4i
	kdnCOZC9WkJwfZIgUoQEFbswF1xrYdxk9CWwCLDHLH7iaBzMz/QryWKvMJJXBWpYGR2R456g==
X-Received: by 2002:a05:7300:760a:b0:30c:2d3d:7840 with SMTP id 5a478bee46e88-30c84e1987cmr7793381eec.35.1782499929291;
        Fri, 26 Jun 2026 11:52:09 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:c002:b4e0:8df9:2e4a? ([2620:10d:c090:500::1:11ba])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7ca8b918sm22125081eec.28.2026.06.26.11.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 11:52:08 -0700 (PDT)
Message-ID: <dccb2602ea054f6fc8c54aba5e74c667be14ed2b.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 01/15] bpf: Remove __rcu tagging in
 st_link->map
From: Eduard Zingerman <eddyz87@gmail.com>
To: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 	daniel@iogearbox.net, memxor@gmail.com, martin.lau@kernel.org, 
	shakeel.butt@linux.dev, roman.gushchin@linux.dev, kuniyu@google.com, 
	kerneljasonxing@gmail.com, kernel-team@meta.com
Date: Fri, 26 Jun 2026 11:52:06 -0700
In-Reply-To: <20260623175006.3136053-2-ameryhung@gmail.com>
References: <20260623175006.3136053-1-ameryhung@gmail.com>
	 <20260623175006.3136053-2-ameryhung@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-302256-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ameryhung@gmail.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:alexei.starovoitov@gmail.com,m:andrii@kernel.org,m:daniel@iogearbox.net,m:memxor@gmail.com,m:martin.lau@kernel.org,m:shakeel.butt@linux.dev,m:roman.gushchin@linux.dev,m:kuniyu@google.com,m:kerneljasonxing@gmail.com,m:kernel-team@meta.com,m:alexeistarovoitov@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[eddyz87@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,linux.dev,google.com,meta.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eddyz87@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 903BC6CFCFD

On Tue, 2026-06-23 at 10:49 -0700, Amery Hung wrote:
> From: Martin KaFai Lau <martin.lau@kernel.org>
>=20
> st_link->map is always written under update_mutex. The paths that read
> st_link->map with rcu_read_lock() are not in the fast path, so they can
> simply take update_mutex instead. Remove the __rcu annotation and replace
> all RCU accessors with direct pointer reads under update_mutex. Use
> READ_ONCE() in bpf_struct_ops_map_link_poll() which reads the pointer
> without holding update_mutex.
>=20
> It is a simplification change.
>=20
> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

