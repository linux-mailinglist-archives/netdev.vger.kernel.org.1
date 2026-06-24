Return-Path: <netdev+bounces-301626-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8PJbKKzFO2rpcggAu9opvQ
	(envelope-from <netdev+bounces-301626-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 13:55:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EFFD46BDDDC
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 13:55:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=s6FK7+8v;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301626-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301626-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E4DCC300F5FB
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 11:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF302EEE75;
	Wed, 24 Jun 2026 11:54:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BAB2D8DCA
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 11:54:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782302096; cv=none; b=r8TSepdJDEDHgGMYfRYKLnFjetpOJlonD8Cylh6Gry6JIqRWMrrpnuGtmopNV40xFBqQWZDI+yn5ONml34E4f4ZYf78Ac90Q97fyr/g58t5Wxaj9PII8uIgHGDXhtBCqayN+2b2a7TQ7YPiQkwKWAFDhkW35wRBV98EYAAj2vsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782302096; c=relaxed/simple;
	bh=TMWGjgzhMSCfw5zila1yJHv6X+TiVrsYoTVEXvWsB08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qZTYwJgCImwuLjM3MVNgJPnIp2KYYyUPTZUZbbeQYT0S6mcZHFFjtR+d5on8n9cZPh2K3H06b2IaCAZXbmKov9Olp9YMei8KwAGnunpNITc8VnQO+NXJHjfVYlCYjbHIWfXC/1djNWHylys+acLGHpDIDq8W8eEKTkUNkQTScx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s6FK7+8v; arc=none smtp.client-ip=209.85.216.43
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-36d98b9aa9aso774106a91.3
        for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 04:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782302095; x=1782906895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z8Vn96XVnW2krHp7V5/fKbqoj2TgGkav7pxGg+ctypU=;
        b=s6FK7+8vdlP/evJWM8aQW2cyHOMsflq8dKm8WwRbi+F7V8VLeElkpZxFrPZBVC6pqW
         Bs3+6AGNzUCzjWFhm7z3y4mKcDT4SkInzd+tYK1tPxdwOy/Oh12ASZQRtlWFSR9HOJII
         ZW3rkC6prJLPzeeKTmOj5q2ZJ58oKJSS4SYVphU7HGrcuriGpgTZtTsa7gGGOmL9x9Yp
         gtCI92QTrZn9ic5MvuqW2Uz3GeTuR4J0lo09dNXZBFDE6ztKrAA5gE9I/KCbUvh2sbN6
         FGVV4FOKOWT8R9UW6aed3gndS+nfCvR84R+MrFMG7PgHeeNbCOHnsjaZvD7zPRX+leM4
         DDGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782302095; x=1782906895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z8Vn96XVnW2krHp7V5/fKbqoj2TgGkav7pxGg+ctypU=;
        b=R0HaMSKXpQyYdZwC3Hpmwi9QXTvle/3Ew0/1a0AU+Md4ppFEje6tSZJuMP2oQvD17X
         3J/pFk7dnUqDACOMTmlYPSgp0JmU9MF9K2TmarlEe+IRYsO7EakukoKvkVXr67KtWbGc
         dyl3ehG39kB2FVzhJ8GcFTNdmhBKIY83HAUu/rIIgaIKlpkbvMZnLpJcAilCTgYY9aEy
         scI7edq1UP/r2RfAONn8Xdm5n65vNXdIj25kHnoiaR9fkxJ4xCMOBXUEac3E+RIW+t+j
         jiJCkXQUJWfvBSmsm5Rtxw/9Mf17AyWLjbrQxJagmxOddU7ddFyxEgaeeuivZNzYUmZw
         qH5w==
X-Forwarded-Encrypted: i=1; AFNElJ9k6opQdvcQ/GCanN/zvf7v4TahE4oTwotyRRcN9X7xu/GqwMtg37rChbQtoeoXbG1LysYi1G8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxj+43sol9qV8PfCoeRcPV0i7XGGVBsocaR+zlW94GCxOzlxZZ
	dMHCJLj5ACYI3ATLYM0yVdkeylcUPm22gnscHAjpgOFlb1jEBuC50B8G
X-Gm-Gg: AfdE7ck4LhdAs0sa0MxW3XtvtQH2xMOeKExAlo29oZcjX0p7TjSIfXErvj21SoJqXsa
	pPNRZ4IV/ws25F2X3ER1ADJrkLJTpW794NrTNyR8aC4EyjKe15zpF0JKbuU2eTZY3Rncr/HhBfW
	BwrSqk4VB1lQrjKAI+iS8LiSNe8l89XefySc2WSLKycYwyDTRoUa8G391+M1xgQ6WoCmzLR3GR8
	4dsCwodSzxOfh53lFA9gsW/Tfif7Ki1onWljVqGafiPvNzFDGptEy5Zufgk7qNYXJ2JkVYAiaFl
	y60axxq0wH7o88e2p26RpHfxMPrK2BvjhkEnxpAGj/0yfxIcqimng6YY51D8s1S1GUxPVZaDbyN
	KDu8GPPWgp0K10o3gHwE3eSZvoPEEwWfRGjBQ52ObjZ7REb3z0vZC6OWPC4EcLCLusyE3VJIRBe
	yKMnKrccc5v+DU65vijv4d4SaxsWW4QKCoKpFo/nnywYr4mRE472yq2i6QErQz
X-Received: by 2002:a05:6a20:b7a7:b0:3b3:f46:1ef3 with SMTP id adf61e73a8af0-3bd15239141mr9670702637.41.1782302094539;
        Wed, 24 Jun 2026 04:54:54 -0700 (PDT)
Received: from r912.tailbb6e1e.ts.net ([182.70.116.80])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8bc563c168sm12708560a12.20.2026.06.24.04.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 04:54:54 -0700 (PDT)
From: Avinash Duduskar <avinash.duduskar@gmail.com>
To: toke@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	hawk@kernel.org,
	yatsenko@meta.com,
	leon.hwang@linux.dev,
	kpsingh@kernel.org,
	a.s.protopopov@gmail.com,
	ameryhung@gmail.com,
	rongtao@cestc.cn,
	eyal.birger@gmail.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	dsahern@kernel.org
Subject: Re: [PATCH bpf-next v5 1/3] bpf: Add BPF_FIB_LOOKUP_VLAN flag to bpf_fib_lookup() helper
Date: Wed, 24 Jun 2026 17:24:42 +0530
Message-ID: <20260624115442.4112419-1-avinash.duduskar@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <87pl1gcmgf.fsf@toke.dk>
References: <20260624030530.3342884-1-avinash.duduskar@gmail.com> <20260624030530.3342884-2-avinash.duduskar@gmail.com> <87pl1gcmgf.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-301626-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:toke@redhat.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:hawk@kernel.org,m:yatsenko@meta.com,m:leon.hwang@linux.dev,m:kpsingh@kernel.org,m:a.s.protopopov@gmail.com,m:ameryhung@gmail.com,m:rongtao@cestc.cn,m:eyal.birger@gmail.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:dsahern@kernel.org,m:johnfastabend@gmail.com,m:asprotopopov@gmail.com,m:eyalbirger@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[avinashduduskar@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	FREEMAIL_CC(0.00)[gmail.com,linux.dev,kernel.org,etsalapatis.com,fomichev.me,davemloft.net,google.com,redhat.com,meta.com,cestc.cn,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[avinashduduskar@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EFFD46BDDDC

> > +	if (flags & BPF_FIB_LOOKUP_VLAN)
> > +		return -EINVAL;
> > +
>
> This is fine, but we should probably reject the input flag as well in
> the next patch (for symmetry).

I dug into this and I don't think the two are symmetric. The egress
reject is right for exactly the reason you gave: in tc you can redirect
to the VLAN device directly, so reducing the egress to the physical
parent is only needed for XDP. But that is a transmit argument, and
VLAN_INPUT never touches the egress or redirect side. It only sets the
lookup's ingress (flowi_iif), which picks the iif policy rule and the VRF
table, and there is no XDP-only constraint there for the symmetry to
mirror.

tc also has a real user for it. In __netif_receive_skb_core() the tcx
ingress hook runs before vlan_do_receive() demuxes the frame, so a clsact
program on the physical port sees a tagged frame with skb->dev still the
physical device and the tag in skb->vlan_tci. That is exactly the
physical-ifindex-plus-tag input VLAN_INPUT takes, and it wants the
subinterface-scoped answer. The 2/3 selftest already runs the VLAN_INPUT
cases on the tc path, including the VRF-table-selection ones, and they
pass, so this isn't a theoretical tc path.

So I would keep VLAN_INPUT allowed on both. If you would rather hold a
uniform "both VLAN flags are XDP-only" line under the same
restrict-now-relax-later rule as the TBID and OUTPUT combos, I will add
the reject, but unlike the egress case it removes a working tc path
rather than one tc cannot use. Happy either way, just let me know.

Thanks for the review.

-Avinash

