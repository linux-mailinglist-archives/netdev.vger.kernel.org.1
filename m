Return-Path: <netdev+bounces-293656-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCiQEJ5SHWp/YwkAu9opvQ
	(envelope-from <netdev+bounces-293656-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 11:36:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D520B61C8DE
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 11:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3A4FE302F6A5
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 09:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B47E3939D2;
	Mon,  1 Jun 2026 09:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GVdGIgWe";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="luSsgwMX"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6643932E3
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 09:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780306364; cv=none; b=q3um+qHDe2U3Wp5rZjZTY0YsQvELr3VRsuGEjB74Fuvhjy1uakmIpUe6Nweo3UHRtpRmGy/8/vWuG1p18cqDRmQrTGAsPRf6wjObuznw2UQH4ByrIqZkfgaX2iVKbCJWnAvLLdkYVN9CI1vkHWca+IbUthfwg1L0eCa5E5ZQn20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780306364; c=relaxed/simple;
	bh=aeJX6dXJghL4L0k/98gZpCBvMgVIBHhvis8QU91lGB0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tml+Z3ZzGYOC5uodUXqUJ+usiF3/YlzpIh9afyWZPa37YlMxtH4BIXqLEgX2thE54Ve5VuNgY5AFAIkTMep/rjneY33M2BLtceZh4bAgVphN52s/H2Ordlw/O7aV66KfB18A0nhDTWFyjKYwRpa8oY8g0ZDPT4RTip54e3sRHzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GVdGIgWe; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=luSsgwMX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780306361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Yb+EE09b4g4IsWhIcNW7yc7MKt+xMeLe5twP9TbR3IA=;
	b=GVdGIgWeN3uR/IwA/HXsAtxCbt7sjxBqBk8om8PElyWCQ/isZ6j6pUSmTQ5YRq5uiiroLn
	n1SIfE0CbzuMyye14Hph68bEKGQDQL7KBbrRCavb91Jssawd/KR0NKKSzxNZHVIoIzc/2l
	jLv8enA16sugvjSIaEroMSZmjR8RAG0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-mUmhMjbOPrmyYTBHAYKYSw-1; Mon, 01 Jun 2026 05:32:40 -0400
X-MC-Unique: mUmhMjbOPrmyYTBHAYKYSw-1
X-Mimecast-MFC-AGG-ID: mUmhMjbOPrmyYTBHAYKYSw_1780306359
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4909c0f0ba2so21596275e9.3
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 02:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780306359; x=1780911159; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Yb+EE09b4g4IsWhIcNW7yc7MKt+xMeLe5twP9TbR3IA=;
        b=luSsgwMX9speKCd84obdSN5RefU9lMJ5Nflc62tE+aWO6MVrYSSi7fdL3E0wxSelaq
         PHGnnWctStid3EaKFBeJYzWVk5P1lO8H6CkHPg0APoCHcsr2xlqA7AF/zA0JsWe+jMS9
         FEnbqlMcY2yEimYpbk4huoDG/Eul8Fzmfog/o9+8cX3fMkpw0n4qzWKT+fJGdiNRZdlM
         I2f4wr3aXP2hdyyd0rxXP8MAar3yribNDJWFJAdWWVGFfcPnIXdIEkDMAP5tPuxQ86sf
         WJmYL682OzR1RKeNTLYR66FxcJsQyve1oZY0ayLmm/qRAc7LDH/+6cF6Y2qubNYJK0fr
         vvJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780306359; x=1780911159;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yb+EE09b4g4IsWhIcNW7yc7MKt+xMeLe5twP9TbR3IA=;
        b=p4LNtRMYzv9K1i6TESx0zADpw92ruoRQPWB/1SnsI4/n+b8c82AIu+0pbyPLE/LzZM
         H5kvi+R/PmtQNw2eHO3DAC4X7yakJgjzb8gsMMI2liGS0Lb87gX9xcEeLXkyeJ07/JTT
         XpAbp/PoxlX1BznI1P23Gq5Lhn7tqoCxhU2ZdcLMGBzX9jEbqHx+Ek5AdeFU/ld9Qg0d
         CRKEQMyQqrlN/awI0tcuS7Muu40PcOG+ZkuzDNHAg2vWikCZ+2CNQJELxE1hwW8/HJsi
         oxkD+D+DTtU782VKzBv62Rwx8YF0ZRwPD/3JlIO63BuUcp24DuX2xb415/EFq+FWdh3n
         4U0Q==
X-Forwarded-Encrypted: i=1; AFNElJ9/O5kc8ejb4rJ7sL+NydX+Z9M9Tn8F8QcJ4XrG36+OD3Jj3zmfXTgnuOb7hcApZ/Oe8bO+ZTg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDX6wB8FgfJJC8JLHjqRjC904+tOFMxTgy7pvRLxpUFsRJi6BT
	D8zAJ0ko9EbFTMjzHQa1QRWIn9Au2s6Hyg/sMzHMbj9EOBir+mYwEPpKMy256SX2oczdve8j8ua
	dPb50ubWdMqn0VCrFOTaWs4WpaZh1/BsBdR129pEJQk/1p6rzv5UHng6yig==
X-Gm-Gg: Acq92OHVNIV9toXJgbuLP0jBxLwEPikHDrBYDqy0iEXqOkOGdDUvPdgmmeaOUGC4ZOJ
	QAoKvLqPjOHe2oKrct33srjotAgUU8W6P28GBH3o+KCVTH1Worn2UBJjyTAqB4wduSnnaBCgytk
	OwsUGQxXGYYWWNkge9ZBV+VgsT+dJWpBZneHYGl6FNM55gbVE5/WKVivr5MS7qwdyBIGFMwUDjr
	0Bnek0cKf5Gut98THjV/MiZOvLB7ETbxO0/cOLyopsjQku9LWTmyac2v7WV7cx3jteWILOCZv/F
	UnsWsVNqvR/0nrD6AJQ4Sc37auGHJde67BiERJdVXNMXLnfX/lfJ6NKcXmh161dBats5otZbqO6
	cOJL5Thkt3qGFXXqNX0O0N41eUUjnN7fe2bAZgjPnkIbVsxihEexuZhiiyQs=
X-Received: by 2002:a05:600c:6287:b0:490:a1a6:6f24 with SMTP id 5b1f17b1804b1-490a29338a8mr186920045e9.15.1780306359058;
        Mon, 01 Jun 2026 02:32:39 -0700 (PDT)
X-Received: by 2002:a05:600c:6287:b0:490:a1a6:6f24 with SMTP id 5b1f17b1804b1-490a29338a8mr186919585e9.15.1780306358692;
        Mon, 01 Jun 2026 02:32:38 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef34a04e2sm21727194f8f.1.2026.06.01.02.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 02:32:38 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 242C07BA6AF; Mon, 01 Jun 2026 11:32:37 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Ren Wei <n05ec@lzu.edu.cn>, netdev@vger.kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
 kuba@kernel.org, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, memxor@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, yuantan098@gmail.com,
 zcliangcn@gmail.com, bird@lzu.edu.cn, zzhan461@ucr.edu, n05ec@lzu.edu.cn
Subject: Re: [PATCH bpf 1/1] bpf: devmap: reject cloning fragmented xdp frames
In-Reply-To: <4b596825bccc64d03e0c2e0db4dceb12c7f5cf47.1780176829.git.zzhan461@ucr.edu>
References: <cover.1780176829.git.zzhan461@ucr.edu>
 <4b596825bccc64d03e0c2e0db4dceb12c7f5cf47.1780176829.git.zzhan461@ucr.edu>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 01 Jun 2026 11:32:37 +0200
Message-ID: <878q8y38sq.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.63)[subject];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,davemloft.net,gmail.com,fomichev.me,linux.dev,lzu.edu.cn,ucr.edu];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-293656-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[toke@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,ucr.edu:email,lzu.edu.cn:email];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D520B61C8DE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Ren Wei <n05ec@lzu.edu.cn> writes:

> From: Zhao Zhang <zzhan461@ucr.edu>
>
> Devmap broadcast redirects clone xdp_frame instances for all but the
> last destination. That clone path only copies the linear frame data,
> while fragmented XDP frames store skb_shared_info in tailroom outside
> the linear area.
>
> As a result, broadcasting a fragmented xdp_frame leaves the clone with
> XDP_FLAGS_HAS_FRAGS set but without valid frag metadata. The later free
> path then treats uninitialized tail data as skb_shared_info, leading to
> an out-of-bounds access during frame return.
>
> Reject fragmented frames in dev_map_enqueue_clone(). Devmap already uses
> -EOPNOTSUPP for unsupported XDP frag forwarding cases, and the current
> xdp_frame clone model cannot safely represent a cloned fragmented
> frame.
>
> Fixes: e624d4ed4aa8 ("xdp: Extend xdp_redirect_map with broadcast support")
> Cc: stable@kernel.org
> Reported-by: Yuan Tan <yuantan098@gmail.com>
> Reported-by: Zhengchuan Liang <zcliangcn@gmail.com>
> Reported-by: Xin Liu <bird@lzu.edu.cn>
> Assisted-by: Codex:GPT-5.4
> Signed-off-by: Zhao Zhang <zzhan461@ucr.edu>
> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
> ---
>  kernel/bpf/devmap.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
> index cc0a43ebab6b..2bfebded5329 100644
> --- a/kernel/bpf/devmap.c
> +++ b/kernel/bpf/devmap.c
> @@ -581,6 +581,10 @@ static int dev_map_enqueue_clone(struct bpf_dtab_netdev *obj,
>  {
>  	struct xdp_frame *nxdpf;
>  
> +	/* Frags live outside the linear frame and cannot be cloned safely. */
> +	if (unlikely(xdp_frame_has_frags(xdpf)))
> +		return -EOPNOTSUPP;
> +

I am OK with restricting this (the support can be restored when/if
someone has a need for it), but we should add the same restriction to
generic XDP (i.e., in dev_map_redirect_clone()), so the feature set
doesn't diverge.

-Toke


