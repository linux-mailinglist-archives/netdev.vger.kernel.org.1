Return-Path: <netdev+bounces-302690-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zTb7NxCQQmo09wkAu9opvQ
	(envelope-from <netdev+bounces-302690-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 17:32:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B9E56DCB7C
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 17:32:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=CujEaR9M;
	dkim=pass header.d=redhat.com header.s=google header.b=fmWbW2qm;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302690-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-302690-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 857B130454A2
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 15:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7EBA3E9588;
	Mon, 29 Jun 2026 15:11:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E22379C55
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 15:11:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782745886; cv=none; b=rZ/+vhkzBCRXgHJpKi2ZKNNH1zmcC8UMhausXexX0rH/V55HINpQR+Qx8uNLCqVrHki6+QbjzT8pIR+yQgO03Qnkong+VDaF6i6hO5NRE8oZiYrhtmER16eucrEf3fJZpmvXaC0KWntDCTObIgmkYTe/D561sJuyd5eOcDOr3hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782745886; c=relaxed/simple;
	bh=kwaiQeiaucp2MfWzIUzd2lPMc574qsl6ASwsK3f6icc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=taD5YBgG1b2HV75NTnW8fAGyDzC8tAk2COLprtYGjPRB9899WShiTOcBhKLRiwBnYbb4OgnLoNUQ2YzgCeWFoy+oSMMRP36yOE+uXSJHsuTNPAkGf6JwanHDFq4c58ZPw3d1gXSbvkT0EsSjAkSP/WVan7v45urdEak0mhb+DlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CujEaR9M; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=fmWbW2qm; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782745884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vx2gFMGxt4RZNuZum2PFhzOqoj2Qwg57W9rcXYdQKuQ=;
	b=CujEaR9MMufAq9QunZbzqLSfCxzZxETa5pnjn3eYmvDfHuCNrBLrztCryqxIT3jTD1MHjy
	GQG7we3jaYeT8QI/8UDcb9QQ4Hvu78IIP+1kAS2TESZZRjS4yTh4vTsVwgQSxwLpRQweBp
	Tqw6Zw8jLBVB36FsUzkgjLNyvf0D1eU=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-mSRCiFFxOxKwpEcv5nPSkQ-1; Mon, 29 Jun 2026 11:11:23 -0400
X-MC-Unique: mSRCiFFxOxKwpEcv5nPSkQ-1
X-Mimecast-MFC-AGG-ID: mSRCiFFxOxKwpEcv5nPSkQ_1782745882
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-6983e384c66so1805595a12.1
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 08:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782745882; x=1783350682; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Vx2gFMGxt4RZNuZum2PFhzOqoj2Qwg57W9rcXYdQKuQ=;
        b=fmWbW2qmY+wuyXZUAjxj+eVFCXxyOHCKAV+g0+A/zw66IC83GUqwlVq7JhRNjiGPhZ
         7u01ztZ+06WmPsIPyBdmq57FURBeXLojLnT/86t1A0Vfh9EMyVMCv3JP5sWf+mdczlrs
         1srCCHSWG+3Dpn3D8+l4Pv+/igi3s58Fg/4jUP/taU454btkq/hWzV5hO7T8IMKavC9d
         AmpTEEP4FDV27zD/tVaW8ElRl0moijDU2gghNWmG1bJnBtP9ROxldqe/e1/mHE/V5KaP
         F/iApMdQRRi8pF6ianKVGbk5lH46NJnwEE3gt9eIAXpNek9ZL5td5GzIscvy1m42JtGr
         BUrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782745882; x=1783350682;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vx2gFMGxt4RZNuZum2PFhzOqoj2Qwg57W9rcXYdQKuQ=;
        b=tKJG9W06PJhk1WW1OeNWQ3fxYZFh0jfO7M67DA7VEgkX+SFb53sHxWRMUPRGqWSqEy
         cgntX7Cw3pIuEFXaeBfC39k/lQxEJdPhEjG72g2LusdVY4Bj/P2ZlhEEHUXNmpnhG2Fq
         qFYTXg3RKzW5zHMdVCcm1Kx+hIkYUlsf1M/g3i4rw2bHcbPwnsAQKWEmKyG97PDEhCMA
         xrKIcOT2jjjKPk7rVCy4jYx2UP8TykLrEqtHLQihYIoXwL1I8vE/AelvmESS2qShILn8
         Vl5BZzu/I8F4FpJFtu/3DwnGBzg7a0k+r/ZjFXIpN0/dIKgJJS0UjrSdvyUdhNzYqaxa
         2lxg==
X-Forwarded-Encrypted: i=1; AHgh+RohYm7YikjIlDExkMbM41S3Es+aX/ho5qMIGN5uwtAODfJVztfWYUAGXcmu77QoM0SoTJ0wm4A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJIhAWWyMssVU8v1WK4g7qffD9WRV3LlK1RAknyWUhLigGi2Xq
	/WvScLQYjyBRnhEp//JjMIKkB1o3Rug1kR+EGckPmym6/FHkB42zim/dZUhSLtFYM2f3olJ5+yl
	//A07tEwPgOqLlwEfHBneYP5Us1jcHwXnTNwxngtUtd1T4aG1FmPkdMihXw==
X-Gm-Gg: AfdE7cnpw00oE99Ujx9aopYDwqFTJmeQxmrpWDWtEy7ZCQjyUJR72+p86S0+KPnbDia
	3mCtY0k6mzRTO8psUDO4QoNsjBEx3xW/l08rZN4GFXXC75xxXVW1KLhCejaHRLQrgjtrxnRjT7i
	5zHekVvKbvjRuDB9DjtonlXb3DMTvGUzYNgMNHy9VOcfmB/8vwR1F9MKOubPSdxAD+PTRAk5hMf
	h5tztKoPreBXoBycDF8QMYbA6/mZRr71tBqPdfhl8+/3N3sD1vqOplCVlqOz8l5hsPREd0mEKRK
	WldX7sx2uTWzWmX0daDTh54uyHEAcMrZhyn07KgSbwAfs39sPO2AmqOl+F7IR7gjtD12WWnYrwY
	LIM2+qngZpT9CBOkgV3L/9c7YJA29yD0qkeM=
X-Received: by 2002:a05:6402:34c6:b0:697:dc26:340c with SMTP id 4fb4d7f45d1cf-69810a74f3dmr6670267a12.12.1782745881810;
        Mon, 29 Jun 2026 08:11:21 -0700 (PDT)
X-Received: by 2002:a05:6402:34c6:b0:697:dc26:340c with SMTP id 4fb4d7f45d1cf-69810a74f3dmr6670232a12.12.1782745881369;
        Mon, 29 Jun 2026 08:11:21 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69847322ef9sm3693279a12.5.2026.06.29.08.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 08:11:20 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id E3E7780A269; Mon, 29 Jun 2026 17:11:19 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Avinash Duduskar <avinash.duduskar@gmail.com>, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org
Cc: eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, john.fastabend@gmail.com, sdf@fomichev.me,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, shuah@kernel.org, hawk@kernel.org,
 yatsenko@meta.com, leon.hwang@linux.dev, kpsingh@kernel.org,
 a.s.protopopov@gmail.com, ameryhung@gmail.com, rongtao@cestc.cn,
 eyal.birger@gmail.com, bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 dsahern@kernel.org
Subject: Re: [PATCH bpf-next v5 1/3] bpf: Add BPF_FIB_LOOKUP_VLAN flag to
 bpf_fib_lookup() helper
In-Reply-To: <20260624115442.4112419-1-avinash.duduskar@gmail.com>
References: <20260624030530.3342884-1-avinash.duduskar@gmail.com>
 <20260624030530.3342884-2-avinash.duduskar@gmail.com>
 <87pl1gcmgf.fsf@toke.dk>
 <20260624115442.4112419-1-avinash.duduskar@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 29 Jun 2026 17:11:19 +0200
Message-ID: <87pl19bcvc.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.40 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.56)[subject];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[32];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302690-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:avinash.duduskar@gmail.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:hawk@kernel.org,m:yatsenko@meta.com,m:leon.hwang@linux.dev,m:kpsingh@kernel.org,m:a.s.protopopov@gmail.com,m:ameryhung@gmail.com,m:rongtao@cestc.cn,m:eyal.birger@gmail.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:dsahern@kernel.org,m:avinashduduskar@gmail.com,m:johnfastabend@gmail.com,m:asprotopopov@gmail.com,m:eyalbirger@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[toke@redhat.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,linux.dev,kernel.org,etsalapatis.com,fomichev.me,davemloft.net,google.com,redhat.com,meta.com,cestc.cn,vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,iogearbox.net];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[toke.dk:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	FORGED_SENDER_FORWARDING(0.00)[];
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
X-Rspamd-Queue-Id: 3B9E56DCB7C

Avinash Duduskar <avinash.duduskar@gmail.com> writes:

>> > +	if (flags & BPF_FIB_LOOKUP_VLAN)
>> > +		return -EINVAL;
>> > +
>>
>> This is fine, but we should probably reject the input flag as well in
>> the next patch (for symmetry).
>
> I dug into this and I don't think the two are symmetric. The egress
> reject is right for exactly the reason you gave: in tc you can redirect
> to the VLAN device directly, so reducing the egress to the physical
> parent is only needed for XDP. But that is a transmit argument, and
> VLAN_INPUT never touches the egress or redirect side. It only sets the
> lookup's ingress (flowi_iif), which picks the iif policy rule and the VRF
> table, and there is no XDP-only constraint there for the symmetry to
> mirror.
>
> tc also has a real user for it. In __netif_receive_skb_core() the tcx
> ingress hook runs before vlan_do_receive() demuxes the frame, so a clsact
> program on the physical port sees a tagged frame with skb->dev still the
> physical device and the tag in skb->vlan_tci. That is exactly the
> physical-ifindex-plus-tag input VLAN_INPUT takes, and it wants the
> subinterface-scoped answer. The 2/3 selftest already runs the VLAN_INPUT
> cases on the tc path, including the VRF-table-selection ones, and they
> pass, so this isn't a theoretical tc path.
>
> So I would keep VLAN_INPUT allowed on both. If you would rather hold a
> uniform "both VLAN flags are XDP-only" line under the same
> restrict-now-relax-later rule as the TBID and OUTPUT combos, I will add
> the reject, but unlike the egress case it removes a working tc path
> rather than one tc cannot use. Happy either way, just let me know.

Hmm, OK, I'm fine with keeping it available for TC then.

-Toke


