Return-Path: <netdev+bounces-294252-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GJPiObnoHmrmYwAAu9opvQ
	(envelope-from <netdev+bounces-294252-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 16:29:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE14B62F492
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 16:29:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=nF0VACAg;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294252-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294252-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54C4130E47F7
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 14:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519E03E9299;
	Tue,  2 Jun 2026 14:20:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512273EAC84;
	Tue,  2 Jun 2026 14:20:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780410047; cv=none; b=dwZwtvO7FQaP9AeIpK2sGYfoMChW4QtnQX5thlSzwxEjXzoZU4kpHqqla+7i8V+l2sUpjbXrL4gBb+8Ur0ErJ2eg+naj1IjgjIeuseA8TXkN3UmKNIxi75g2WQzK91t2Wp9VXjHTmzNfeQddnUo6RmlMX5tmsadr5xnA2q6pLHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780410047; c=relaxed/simple;
	bh=RS3qmHG8K0KieoALeFVGxZLWMWad6OS6syEMWuZStDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LA84N1uV/6N7a3ZXPJEutdMQIf3tHxCYgy5ulvIOtInM6FDzX7gg+Jzh4BPaVpHmck8QNDqd8rguOiFllZJN/0hiycJIu02pNsh9QNWuiCcCocRmFYwjWDmT8zy4fVNlJjp75pkz6uznk6Y/Ucs2WXVTBepMCFnVa3kpvaw5BFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nF0VACAg; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E92431F00893;
	Tue,  2 Jun 2026 14:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780410046;
	bh=gpFIDtAO59P9SJizwaFN00oogcc1wMSs8mQhgemNFDI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nF0VACAgbhj0NFFle0U8chNOIMYoeuSLSPBiUSrCRWsbw2uPm3jwMExOBYb4s5C29
	 9sBuIkVVGRWlBP3Z3FwOoRJeUPkjXdgblo+Qzuf+VsrNM0qNfV7J1Ha3xA4jMbL+RF
	 cgI5LWhQRV5kq9yOhSs3d08+Ir1tv4rMZIkPw8a5nyhSLEkmRMN3uuLw2wKp8+wd1m
	 sbDRCS1e0QJ/HYWY3bl40GXCBlMB3+Jt7VwWONU+ute0rUJBUL7xFtklAEsNzLYAC2
	 iLphgBK2YUfTVjHvILtCZ0j7yOdQDrW2AgEXAj44oFw8aFSCv2hLGnWqRUGGzrZPSq
	 33Ye+9wctVq8w==
Date: Tue, 2 Jun 2026 15:20:40 +0100
From: Simon Horman <horms@kernel.org>
To: mike.marciniszyn@gmail.com
Cc: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>, kernel-team@meta.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Mohsin Bashir <mohsin.bashr@gmail.com>, Kees Cook <kees@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 0/4] second series for xpcs based rsfec
 configuratio
Message-ID: <20260602142040.GB3410996@horms.kernel.org>
References: <20260527000958.81108-1-mike.marciniszyn@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527000958.81108-1-mike.marciniszyn@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294252-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:mike.marciniszyn@gmail.com,m:alexanderduyck@fb.com,m:kuba@kernel.org,m:kernel-team@meta.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:jiawenwu@trustnetic.com,m:mengyuanlou@net-swift.com,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:mohsin.bashr@gmail.com,m:kees@kernel.org,m:andrew@lunn.ch,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:mikemarciniszyn@gmail.com,m:mohsinbashr@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[fb.com,kernel.org,meta.com,lunn.ch,davemloft.net,google.com,redhat.com,trustnetic.com,net-swift.com,gmail.com,armlinux.org.uk,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[horms.kernel.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url,vger.kernel.org:from_smtp,linux.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AE14B62F492

On Tue, May 26, 2026 at 08:09:54PM -0400, mike.marciniszyn@gmail.com wrote:
> From: "Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>
> 
> This series adds to xpcs to add the necessary configuration steps
> for the DW PCS/rsfec for high speed interfaces.

Hi Mike,

There are AI-generated reviews of this patch-set available at
https://netdev-ai.bots.linux.dev/sashiko/ and https://sashiko.dev/

I would appreciate it if you could look over them and address any
issues that are either introduced by this patch-set, or directly
impact it.

I would not suggest expanding this patchset to address any other
pre-existing issues, but rather address them separately as appropriate.

