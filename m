Return-Path: <netdev+bounces-300164-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZfLaLKOSMmo02QUAu9opvQ
	(envelope-from <netdev+bounces-300164-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 14:27:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB9F699B34
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 14:27:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Aro8gjpR;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300164-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300164-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 036713039029
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 12:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0533F88B5;
	Wed, 17 Jun 2026 12:23:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6859D3F7ABE
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 12:23:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781699036; cv=none; b=E3boqxFuDjPsWTEH+PiG7IqzKx4tY6UHkUWXv1/SDzIQA2reBJZH+oS9TyrXH8DPuCMzhqXmm9qtkTTRNZwJK1335tAKdylw43rQKXuHRnD0MWVaI2KdL5nI998aSGKwO0jykRPmkPa8itYIAjyzK88M8SxKuf4lI5NXSawfVdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781699036; c=relaxed/simple;
	bh=b1n/4N3C358uVyJqJ1vfqnKIQYA7aHhI29s4Tc1s6u8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HHi50HzYMYiwuh7dNh4U8aEKu4q+tuI0HTSXmYpJctK8cWuBYizdSAxB6sGT+pNjTUkF3VAC8FEw+AluTusRHU00PDexuZIwMO6LDO05K7bbEr22OU/nIZwHkSuthyyaoeYnzlOU4IID/QaIgyYTKrAi6IM5Bwn3sqn4I4RNdjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aro8gjpR; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 124E01F00ACF
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 12:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781699035;
	bh=zXGxmsGCmABLfDzWTa6O9EWCXvTTRqrj37BqPEAmtYs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Aro8gjpR133/hg/iJL3IyR1zaRqTjFN0ShhBWZsVAdoRi0xTTldAsyubocdVsAHYG
	 NZogQcOGkK834NKvtosl5eLbiFNWZRLOFJktTYpPSsS9csXVtbPkWgoHMTaVZjQ2YO
	 b824z5oKBc2XGQ5Z68dspkO4FWt2g1jQiJvBY4NK11iDbQE2GCq9IAto+oKIkeWy+5
	 cBxejMSRoXP9BAbCepcLs5yZruD/eKSp4eHMauVM63W/VMD4RKeZxGO5VQO/B5G7o2
	 kKVd4J1bmO1ATrxQMVWVhZokN98DFQ9C3O5jwZnO0XFLWlyGbMh8/h1MzE9l5Cjf/+
	 hH1P2Lt+MmdSA==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-39677242021so47427871fa.1
        for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 05:23:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9Yem19Q0DgIMDY+6a0epTvwHg7mdouapdhg6WAZmwWCd0ZddKJMWZ82qJ+QD79xQvNkodeH2w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEKqGlLt0Dqgyfk9tEMu5vjGZlCwfbCrqkjen9+F4Zj9i8fZjn
	+o6LnT4ITNOp2YDIRkCxV/k13n+DUrl8ueNL57wer4OcS25OLb/xlzBqi2uPetGx7664pC+laAm
	Qwrav721+Qa6PpyAWzxnqw//pvkphVJo=
X-Received: by 2002:a05:6512:244:b0:5aa:7aec:4952 with SMTP id
 2adb3069b0e04-5ad47019a44mr675345e87.34.1781699033429; Wed, 17 Jun 2026
 05:23:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616-dsa-fix-free-skb-v2-1-9dbda6a19e97@kernel.org> <20260616213728.xhja2net2vbjmgzb@skbuf>
In-Reply-To: <20260616213728.xhja2net2vbjmgzb@skbuf>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 17 Jun 2026 14:23:40 +0200
X-Gmail-Original-Message-ID: <CAD++jLm7tvbB2RBV5FEo=mAkPpmUJEMemXV0+mhTvZ0oX8O=+Q@mail.gmail.com>
X-Gm-Features: AVVi8CdYdgQxLKBl-wiWdmt0jIjNRdggRxTkZchlwbCPbpeZxt_yOxSJ5S_hKWw
Message-ID: <CAD++jLm7tvbB2RBV5FEo=mAkPpmUJEMemXV0+mhTvZ0oX8O=+Q@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net: dsa: Fix skb ownership in taggers
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Jonas Gorski <jonas.gorski@gmail.com>, Hauke Mehrtens <hauke@hauke-m.de>, 
	Kurt Kanzenbach <kurt@linutronix.de>, Woojung Huh <woojung.huh@microchip.com>, 
	UNGLinuxDriver@microchip.com, "Chester A. Unal" <chester.a.unal@arinc9.com>, 
	Daniel Golle <daniel@makrotopia.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Wei Fang <wei.fang@nxp.com>, 
	Clark Wang <xiaoning.wang@nxp.com>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>, 
	George McCollister <george.mccollister@gmail.com>, David Yang <mmyangfl@gmail.com>, 
	netdev@vger.kernel.org, Sashiko AI Review <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300164-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:olteanv@gmail.com,m:andrew@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:florian.fainelli@broadcom.com,m:jonas.gorski@gmail.com,m:hauke@hauke-m.de,m:kurt@linutronix.de,m:woojung.huh@microchip.com,m:UNGLinuxDriver@microchip.com,m:chester.a.unal@arinc9.com,m:daniel@makrotopia.org,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:wei.fang@nxp.com,m:xiaoning.wang@nxp.com,m:clement.leger@bootlin.com,m:george.mccollister@gmail.com,m:mmyangfl@gmail.com,m:netdev@vger.kernel.org,m:sashiko-bot@kernel.org,m:jonasgorski@gmail.com,m:matthiasbgg@gmail.com,m:georgemccollister@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[linusw@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[24];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,broadcom.com,gmail.com,hauke-m.de,linutronix.de,microchip.com,arinc9.com,makrotopia.org,collabora.com,nxp.com,bootlin.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linusw@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1FB9F699B34

On Tue, Jun 16, 2026 at 11:37=E2=80=AFPM Vladimir Oltean <olteanv@gmail.com=
> wrote:

> From my perspective, the tradeoff between pros and cons is not so well
> explained. Consider the following not mentioned in the commit message:
>
> - Changing the kfree_skb() convention, without any mechanical obstacle
>   preventing the backporting of patches that are written assuming one
>   convention down to trees expecting the other (obstacle like a failure
>   to compile, for example, which would warn people of their otherwise
>   silent incompatibility), is an avoidable experience (at best) from a
>   maintainance perspective.

I added a terse blurb like this:

NOTICE: Backporting patches to taggers (e.g. for stable kernels) after
    this point cannot be mechanical or they will introduce double
    kfree_skb().

However, usually we do not consider obstacles for backporting things to
stable to be a major concern, c.f. Documentation/process/stable-api-nonsens=
e.rst

> - Has anyone proven that a real problem exists? Because dsa_user_xmit()
>   -> skb_ensure_writable_head_tail() has run successfully at this stage,
>   so we know that dev->needed_headroom bytes are available for writing.
>   Because DSA uses VLAN as a tag, dsa_user_setup_tagger() will increase
>   dev->needed_headroom by VLAN_HLEN for the tag_8021q protocols, so
>   vlan_insert_tag() should not fail. I've looked at this function at it
>   seems not to be coded up to fail for any other reason.

I guess what you're saying is that vlan_insert_tag() will never fail in
->xmit()?

If we decide to keep things as they are we can probably make a patch
to the Sashiko ruleset and tell the AI to explicitly shut up about any use
of risking double-free when calling vlan_insert_tag() in any DSA taggers
->xmit() callback, but it seems a bit hard to maintain this way.

> Otherwise, sure, it seems cleaner this way, but the way I see it, it
> risks introducing more issues than it fixes. If maintainers feel
> different about this please go ahead, but given the fact that I don't
> really have a lot of time to do proper review during this period, I'm
> more on the pragmatic side on this one.

I am a bit in love with my own patch but I'm not married to it.

I'll let Jakub & al decide on its fate, if your stance is neutral.
If things explode we'll revert it...

Yours,
Linus Walleij

