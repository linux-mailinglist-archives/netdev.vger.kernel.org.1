Return-Path: <netdev+bounces-300370-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id X0CbMNO2M2qEFQYAu9opvQ
	(envelope-from <netdev+bounces-300370-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 11:13:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE0E69EC2F
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 11:13:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=dRekfiRw;
	dkim=pass header.d=redhat.com header.s=google header.b=G9hVX4pq;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300370-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-300370-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E4EB33093C38
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 09:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644713B4EAD;
	Thu, 18 Jun 2026 09:13:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001D73A6B81
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 09:13:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781774002; cv=none; b=U/aDz4KrMRB8HlXuHTHM73+JqTqX284RI0/h8jhk6VF3yaVCJuk+O/bBr8t0+G4PItarkdFqEbQD/iOnvO5OwLy6fBTHfssH6dq7q5YDpoKD4yFw8SNCmFWy6DTG+k6UI18yDTy9mJLGWAD74ctH2XgAsdiTqisr22a9xsljXNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781774002; c=relaxed/simple;
	bh=18ku8zJSegtuNeFkydPWttYoVDG0vlcQI6O1iN5ADdE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gMPjMf8Jr2Tk0r5qrlbUUfcIKQj+8cwWrMnlcbQ18eUaENXfsLzrSM9sbK8jfyILACve1EJTC/EFlXK8xWW6eXz6glnfdb4yVtp42sjhC53Gx+504EwpBJ0kbdbW9g7qYjoMF9u9HP0Z5nx/cHTcqGySy0UgqMru0WtZZwAWcDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dRekfiRw; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=G9hVX4pq; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781773998;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YF07RUa16RTBhVnigCSc1VoV/EXhQAbPj8MDNoWvZX8=;
	b=dRekfiRwiaMsSDNKJDp2YSc7ZbyhHS+5qM+FXsa/apaRnD3VF28g4AbpGN+O+hYArl/bIP
	WyfTQE9ke3AYJ3pDGDr8W+zvXQCaWvpKQIGFyR+9CfhlBMJKn7C34aXcSN5aRi0uEZbu9w
	o//Pv6WLT16VoCklkt3FnP1S3bgSfos=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-bwpCofQwM-m2g0iwTV9vTQ-1; Thu, 18 Jun 2026 05:13:16 -0400
X-MC-Unique: bwpCofQwM-m2g0iwTV9vTQ-1
X-Mimecast-MFC-AGG-ID: bwpCofQwM-m2g0iwTV9vTQ_1781773995
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-490a767c7dcso4693275e9.2
        for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 02:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781773995; x=1782378795; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YF07RUa16RTBhVnigCSc1VoV/EXhQAbPj8MDNoWvZX8=;
        b=G9hVX4pqjDPbNsQdVVGJG2pFDmQAYtUpaOKGmE9q//6T+QU6rfK7esaWKXTdEtJUgT
         HLFZDSJ3BZMYVzHoEN+jvicAN6Yxb7voOoPdA3AUZW94yHJsMmfoLE68HjN4PvGR+4oB
         kY7OUabRM8YNmJDLBKDntTT7niiTWLkVJxbX0nFS5oAGv5t3Mo0G4HBO2v/rtPejDLT9
         3FndENg4z8xpmgbLrNq3uRKWyLW3AnYtY8wpA0bpPpiFJWqMek8Y0OI7/2flpkHAMqN2
         Y9/sTjfyAi9btrSH/WQ9irmUZApyKeBsWC4WxomV6BoRO4ABZYpQreL+8xBVsrSQaOZG
         Dx4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781773995; x=1782378795;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YF07RUa16RTBhVnigCSc1VoV/EXhQAbPj8MDNoWvZX8=;
        b=sfXijgaM5tOyODJ8xrAs0DGNJo3qrGwnCmKZXwRR74udQbKv0L36X8cQbL5z7JQRuT
         euThzAi2dq0byOfhx/tt6HVxHjoFkYiVs6x3dHRRX7CN4bSKxtGASWxf2O79lie4u+aS
         Hs/A/iSCoYBWmZCHLgpYncmcUArNQbFcB8+2qU4XZepVj/1qzmx4mbzWKhFv/VsAJtAV
         7bPcAep7wOgbcEXJN9CYTbiY0NhPAKobTxUrnp9sCnKyrg4v7e9yBR45B1DfyUNuTHNg
         7PlnTUBq1LHo8fhDLbBm1IVy4ZTCcYzdPTw5J82wxwPPuVbnz1jIKAYjAcomtLeNSzSL
         bbaA==
X-Forwarded-Encrypted: i=1; AFNElJ9IpgLSSBmK9IL+4m/uRrS02sQbiZ3i6CDZLvYPOFhE7GR9GwhWzPSvi7QI6rqqLWZD89zfDyE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBAs9Q0WFh+IUek+3lZJz2zTmuCsyI0aVYNXL4gfJjiiT+Gxm1
	5xCii2vH26UcpmM4OpGZoOleb6YDrQYMHpjKMeMSo3Kt0EXE9bqr//PTL3Ye6P3bJDY3M3AQfJG
	khM/uFFwJlfOX11RRihzR/dKHaov+0Xv5HaElV2CS+j1gSSl07b3WaG9FTQ==
X-Gm-Gg: Acq92OGfR4dL89GKWeGDMRwqhtcdv3D69ErUzWrE3Vyj6NyTsGHYkcJRRcb8R/TeMDo
	Qt3im7frTo8OjhE65dFLluTw53lz3SlGKXBjkV1sc9zoafapn9DrmXeLUa919SJxu8A6Ec0QG6A
	+fPMwYo2GuCqJB76gX+4Q2gfvet8nQIiZ2j+vJXhmv61kgncBAa9WnzlxaD6/jS2ZcMOn7L9OEH
	+gNP0XTpKAdta+UXi30AJdJD7bh9jNrbP7fp31GNmqPymApkhBDMxLmPcaHLk4ZlHhLrbouuOfX
	XRE0FHp0OW0L7e4Ba/58Obp3uXkejkbD3GaOawf4aCNUeWB8np/P9H3Uch/YJgc3hPwpLjPkLG2
	rtNuVan0Kc1DQwOuGZj7nk38zyaiuYJicsANZHg==
X-Received: by 2002:a05:600c:3595:b0:490:a964:14f8 with SMTP id 5b1f17b1804b1-492381e1c96mr57598775e9.8.1781773992680;
        Thu, 18 Jun 2026 02:13:12 -0700 (PDT)
X-Received: by 2002:a05:600c:3595:b0:490:a964:14f8 with SMTP id 5b1f17b1804b1-492381e1c96mr57593655e9.8.1781773990369;
        Thu, 18 Jun 2026 02:13:10 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4922fa47ce3sm253587265e9.6.2026.06.18.02.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 02:13:09 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id E9E7A807837; Thu, 18 Jun 2026 11:13:08 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Avinash Duduskar <avinash.duduskar@gmail.com>, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org
Cc: bpf@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
 eddyz87@gmail.com, edumazet@google.com, emil@etsalapatis.com,
 horms@kernel.org, john.fastabend@gmail.com, jolsa@kernel.org,
 kuba@kernel.org, linux-kernel@vger.kernel.org, martin.lau@linux.dev,
 memxor@gmail.com, netdev@vger.kernel.org, pabeni@redhat.com,
 sdf@fomichev.me, song@kernel.org, yonghong.song@linux.dev
Subject: Re: [PATCH bpf] bpf: zero-initialize the fib lookup flow struct
In-Reply-To: <20260617224719.1428599-1-avinash.duduskar@gmail.com>
References: <20260617224719.1428599-1-avinash.duduskar@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 18 Jun 2026 11:13:08 +0200
Message-ID: <87y0gcfbyz.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.01 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.67)[subject];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[22];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300370-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:avinash.duduskar@gmail.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:bpf@vger.kernel.org,m:davem@davemloft.net,m:dsahern@kernel.org,m:eddyz87@gmail.com,m:edumazet@google.com,m:emil@etsalapatis.com,m:horms@kernel.org,m:john.fastabend@gmail.com,m:jolsa@kernel.org,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:martin.lau@linux.dev,m:memxor@gmail.com,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:sdf@fomichev.me,m:song@kernel.org,m:yonghong.song@linux.dev,m:avinashduduskar@gmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[toke@redhat.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,kernel.org,gmail.com,google.com,etsalapatis.com,linux.dev,redhat.com,fomichev.me];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,iogearbox.net];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[toke@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4DE0E69EC2F

Avinash Duduskar <avinash.duduskar@gmail.com> writes:

> bpf_ipv4_fib_lookup() and bpf_ipv6_fib_lookup() build the flow key on
> the stack with a bare "struct flowi4 fl4;" / "struct flowi6 fl6;" and
> fill it field by field, but never set flowi4_l3mdev / flowi6_l3mdev.
>
> On the non-DIRECT path the lookup goes through the fib rules whenever the
> netns has custom rules, which a VRF installs:
>
> 	bpf_ipv4_fib_lookup() -> fib_lookup() -> __fib_lookup()
> 	  -> l3mdev_update_flow()   reads !fl->flowi_l3mdev
> 	  -> fib_rules_lookup() -> fib_rule_match()
> 	       -> l3mdev_fib_rule_match()   uses fl->flowi_l3mdev
>
> l3mdev_update_flow() resolves the l3mdev master from the ingress device
> only while the field is still zero. Left at a nonzero stack value the
> resolution is skipped, and l3mdev_fib_rule_match() then tests that value
> as an ifindex, so the VRF master is not resolved and the rule fails to
> match: an ingress enslaved to a VRF can fail to select its table. FIB
> rules matching on an L3 master device (l3mdev_fib_rule_iif_match()/
> _oif_match()) read the same value, so an "ip rule iif/oif <vrf>"
> mismatches the same way.
>
> Zero-initialize the whole flow struct rather than adding one more
> field assignment, so any flowi field added later is covered too.
> ip_route_input_slow() likewise zeroes the field before its input lookup.
>
> CONFIG_INIT_STACK_ALL_ZERO masks this by default, but it depends on
> compiler support (CC_HAS_AUTO_VAR_INIT_ZERO), so INIT_STACK_NONE builds,
> including older toolchains that fall back to it, are exposed. Built with
> INIT_STACK_ALL_PATTERN, a plain bpf_fib_lookup (no VLAN, no DIRECT) over a
> VRF slave whose destination is routed only in the VRF table returns
> BPF_FIB_LKUP_RET_NOT_FWDED, and resolves with this patch. On the default
> config the lookup succeeds either way, so ordinary testing does not catch
> the bug.
>
> Fixes: 40867d74c374 ("net: Add l3mdev index to flow struct and avoid oif =
reset for port devices")
> Signed-off-by: Avinash Duduskar <avinash.duduskar@gmail.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


