Return-Path: <netdev+bounces-271166-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gKt/DvG8wmlflQQAu9opvQ
	(envelope-from <netdev+bounces-271166-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 17:33:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 350B6319135
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 17:33:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EA63C30529C6
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 16:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BEF3D3CF9;
	Tue, 24 Mar 2026 16:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UvWNF0wg";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="rUmU6YOm"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25486282F04
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 16:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774369141; cv=none; b=hsaWUfNDbhQgHLhQcsZudUAi42/Hc+0t4gFWXw1zgsCRicwzJQHsYx6EKDItnxRVENauMqQpqebNfiDRGjm1tEcJEX+mXw+AsbTngm7uQPhcCRBNlRoM9M2A31jaH7HBLrs36rVQk9o1T9kedaPnPagm4NYf0o2GqSK6WDIIVfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774369141; c=relaxed/simple;
	bh=j2vmMAgZBEIHOIcyw/exgvoqxhaoAAncNtLEhyVK7V8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Z1naIY26aTR95VLyIfddJ+EUQjZGl5115z+NmPO8U3O9K0ch+FafTeiclzI5gGXpopqm3NsIM6mmDiO4o5njCVsjsLM96FE5QHdBWyiWAt2fTR2Ut17D2Q2EYeVeJ0Srp87echpBg6bgz/ysFSVRTRm+80tuvtzUk33ApqelgJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UvWNF0wg; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rUmU6YOm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774369139;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0pLGEONAHfojUOfaOSp5cChM4XB6HpkP9CDLtETY2Zg=;
	b=UvWNF0wgSnxfP19DhIuC8JjD76fiIkslCDX4/NMpmxQjVX4QBESwrbJJDbBDYIjiZM21/w
	HtU27K8qMP0CfUO4RM7dbJrJaBEvfkSSEvjugzhh2QF09LhIyK8Aw8gQGls1GFxookIIMX
	HlEicRAq+l6D/vQK/CpMRxgdEeGD4ew=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7-2IYQzY20OySdedpTlCGzuw-1; Tue, 24 Mar 2026 12:18:57 -0400
X-MC-Unique: 2IYQzY20OySdedpTlCGzuw-1
X-Mimecast-MFC-AGG-ID: 2IYQzY20OySdedpTlCGzuw_1774369137
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-439bcec86dfso4569654f8f.3
        for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 09:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774369137; x=1774973937; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=0pLGEONAHfojUOfaOSp5cChM4XB6HpkP9CDLtETY2Zg=;
        b=rUmU6YOm3ZCZMZ7EHRgBKorXwzUWJWZyvVQK2SXrCg0xIYrY28uBtwIT4j0wrCZOIq
         /GRGXn/UnVt5NfO3Mls1U1Ekx/w0M6seRDG+T4BTaurcKpQlnit7qfYnVBmmmmiJ6RDx
         MFq8Rh+CQUgHb/CBoM0XKX1WtJo/4MZjkruQBBwW65VjtlhrhwOyaFhbmpF91R7iY3oW
         SKcdCmb1T4EuAjfw0iq/pDCufgTmGFYA0Hx9fSo3VWjTx53FjxVCmuw3J/lwqQSp47kj
         RtLHSvMECkQfCmVy8+D6FFworxn8+EsTstLaureeD9XjKhLU+/Ij1ugvz1QzeJyRAscF
         h+IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774369137; x=1774973937;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0pLGEONAHfojUOfaOSp5cChM4XB6HpkP9CDLtETY2Zg=;
        b=Qryn9wHJ8ccHQmbp7G4LeJzmkRYQ+yMNAjyqsHptzry+F4awIMJ9b0xyqXlsxqmn4+
         3/cGdN/sDY8Pb0HkPc3ItRpZwCU1ulYNWmt8hJD2xiwulYFgLHeQ4pSh98MvrZgn6upK
         24sXTjnWok0cLSIKQrc6Un1RXrHaxuFYRCYHmov9AR11cGT/Z+Yj0QlggqgdXRLosHTY
         S9F3EvEL+qSiOJ8NwmFVrkvSUQf+9p4bTSCm+hw8uNwniaQXjFte/R1GRrXx4g3N5Taz
         c4/52OuBmX15HadRyRBucrXnjJ0to6BULsfM3YYGNWkC5Q99pVnfWMpn1HXhc2806JlV
         XDhg==
X-Forwarded-Encrypted: i=1; AJvYcCXdGkptH3zGAiwrkXJQmMb0yasllEGxzTydeIn12t9TR50mBG5BIj1deEPD3zc68oYBb8RfrKk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yznl8tk530/7NktS9OSZzNdjys3T8r55iUbJb5xdhvNvF3OhFDX
	FrBN7JwiIs4tcwqDzPUxbCnRA+Y6tnZygPhF0Osrdb9sHdwj0mFiCl/yD37/zn5WmuCR//c8415
	LdSqwzMrNLucwM7ZWtfzB+IF9fodBmGLpAvrPS23jZaOZGkTIXUjzdR+gZg==
X-Gm-Gg: ATEYQzzaa9Kk8lU1HILMzVtdq3pf7OxpX0QEoquj8/VHjxz67KYpFLElxnSh8vWI6em
	q6volcmsUlUeh+++eaOloAH/9Wbx6GUB5rg68l3wbma6VVhmq64m+z/j9T6dUbXbIx15+1Q6udi
	xjxGSr2K4EhXAKitm83XboX44/YLEAe8IDXK3hUZCPTN0VElqOCcNGNhFsmyzlPe8OOpPwl8pUj
	UO0ljthv7BQDuVjeNZjMOWAzye6pCQ+birmWyp3O4J5ImHLusoEnSRoNd/Mj88yvEkwdSdwtmGS
	MuiImfYn2TqlWXIYnGLTICYY6RqdJbCZNtOqBTIi6kasOnMniEFurcQX05dzZd7PEYqpJoKr+Fb
	rkCIRpqZ8HHHTG6Yc5EFeo0SPSqYC3pxFYMkCUIU0KdZqHmts
X-Received: by 2002:a05:6000:2509:b0:43b:4920:56bb with SMTP id ffacd0b85a97d-43b88a0cfc1mr107791f8f.52.1774369136503;
        Tue, 24 Mar 2026 09:18:56 -0700 (PDT)
X-Received: by 2002:a05:6000:2509:b0:43b:4920:56bb with SMTP id ffacd0b85a97d-43b88a0cfc1mr107724f8f.52.1774369135946;
        Tue, 24 Mar 2026 09:18:55 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b64717e97sm41173985f8f.35.2026.03.24.09.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 09:18:55 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 24AE35A470F; Tue, 24 Mar 2026 17:18:54 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Leon Hwang <leon.hwang@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, Andrii
 Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong
 Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard
 Brouer <hawk@kernel.org>, Leon Hwang <leon.hwang@linux.dev>, Lorenzo
 Bianconi <lorenzo@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
 kernel-patches-bot@fb.com
Subject: Re: [PATCH bpf-next 1/3] bpf: Disallow freplace on XDP with
 mismatched xdp_has_frags values
In-Reply-To: <20260324150444.68166-2-leon.hwang@linux.dev>
References: <20260324150444.68166-1-leon.hwang@linux.dev>
 <20260324150444.68166-2-leon.hwang@linux.dev>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 24 Mar 2026 17:18:54 +0100
Message-ID: <87ecl9mc9d.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [0.37 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.53)[subject];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,gmail.com,linux.dev,fomichev.me,google.com,davemloft.net,vger.kernel.org,fb.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-271166-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[toke@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.dev:email,toke.dk:mid];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 350B6319135
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Leon Hwang <leon.hwang@linux.dev> writes:

> xdp_has_frags was introduced by the commit
> c2f2cdbeffda ("bpf: introduce BPF_F_XDP_HAS_FRAGS flag in prog_flags loading the ebpf program").
>
> The commit f45d5b6ce2e8 ("bpf: generalise tail call map compatibility check")
> was to ensure backwards compatibility against tail calls. However, it
> missed that XDP progs can be extended by freplace progs, which could break
> the backwards compatibility, e.g. xdp_has_frags=true freplace progs are
> allowed to attach to xdp_has_frags=false XDP progs.
>
> To avoid breaking the backwards compatibility via freplace, disallow
> freplace on XDP programs with different xdp_has_frags values.

The problem you describe is not actually a problem, though? A
frags-aware program can run on a non-frags interface just fine.

You're messing with long-standing behaviour (since 5.18!) to solve a
non-existent problem. In a way that completely breaks the frags handling
in libxdp[0]:

    Running tests from ./test-libxdp.sh
     [test_link_so]                PASS
     [test_link_a]                 PASS
     [test_old_dispatcher]         PASS
     [test_xdp_devbound]           PASS
     [test_xdp_frags]              FAIL
          Kernel supports XDP programs with frags
          check_load_frags:	FAILED
          check_load_nofrags_success:	PASSED
          check_load_nofrags_fail:	PASSED
          check_load_frags_multi:	FAILED
          check_load_mix_big:	FAILED
          check_load_mix_small:	FAILED
          Test test_xdp_frags exited with return code: 1


Please don't do that.

-Toke

[0] Run 'make test' here: https://github.com/xdp-project/xdp-tools


