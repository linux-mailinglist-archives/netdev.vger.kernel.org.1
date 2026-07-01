Return-Path: <netdev+bounces-303758-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UPunBWg8RWo89AoAu9opvQ
	(envelope-from <netdev+bounces-303758-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 18:12:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A07B86EF92B
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 18:12:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Jnaq7eY8;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303758-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-303758-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6472430F2DCE
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 16:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B4149250F;
	Wed,  1 Jul 2026 16:02:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pz2-f0.google.com (mail-pz2-f0.google.com [74.125.228.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1821A492505
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 16:02:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782921756; cv=none; b=smf6Uq+T/oI0rwbUCj9ZWtObqVjS44+BmrmKIyt1BW7sMxzYsmouR9guZdzKWlnbTNJQVQmSXXzsF4enecyQPqbkmCYbYxh0Az+qVbmCqZXQEHgIWj17P6xP1ZNTNllba43eTbrPS9Oucs4h0DH/imdOvYAAm1BfEoRm944CQLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782921756; c=relaxed/simple;
	bh=CLt5n+9k9BltT9wSwFyTN9xRcNcQhkuzgc/tEfdE2mY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VSwJluP0E3kiEOLRyxTNNoMppp7e69EAeosGjS1eZfHbEANV2zQ0hh7+97L0PVTPAtSahkjePmIPqI75Pl4CvbRiIfTE18hy1N7dokhwMkMRXAsOwL2cH4CWH3dPs0yataxm8V4fuOnh/4y+sMQxAyXKjQbVcRMqSV6X2V+m5kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jnaq7eY8; arc=none smtp.client-ip=74.125.228.0
Received: by mail-pz2-f0.google.com with SMTP id 41be03b00d2f7-c95bd574471so82053a12.0
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 09:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782921754; x=1783526554; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pV91HpCphsAhlwQVMt0YeBnEib1IavGU1t4mUXB3gNo=;
        b=Jnaq7eY8TN2hMRSdqUEeTHdKwKTb4G7wVgOrsnv7UHfZNOctbW8IDP0dfBrjJi7gd+
         QPTTBtdnRSYxqn1kx3zdyAzOsaUM/CArmliraN1ZZM8I259wIATJ8X7Rn8wNwad8DNK9
         CbJMt/E0f5qfkE+V77SpjrOaYhhK6ptccQwxYHG4h0qy6aa9a0WG+VIMdCtjdHKdkHKC
         T3fyG711uVLNeV+eJAIAtZNeJrq/NeL7MfDznjRF+PJFP1SaTbOBQ183KRnTm8MDknrx
         W6O8YNTSfTsFqckaz7aZwa4H4pMQPh6A964amj6E3iR6LD03dmuLUIe6w4L83hUk3bgh
         oLJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782921754; x=1783526554;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pV91HpCphsAhlwQVMt0YeBnEib1IavGU1t4mUXB3gNo=;
        b=UGbgSA1rhW9rverMNXhQ0R4OD6Z51n2Go4f1bQ2TvC4jgIRyrTfLbwGwrF+jbOzk0P
         oKhxLj7r/8sDr2NvmWgANZr08HBYZmuAX43YN70jttk/bMEgHlc3CdWEyPXDC+8pJNIr
         16KnU1g6F4qw2qo5RjNg7r84+7OD1OjDwUX6ydN8MLcMY7NJOsEW1T8c5R+zAPkxzR/y
         FATZiYWGldk6Sb79yqPlhHHPkh4W5+WBXC26j5WnGtC3sRk7oy4yoWlhWf0IfCmVlNA3
         DZGR82rLfCYcFnyQZvLeLJwybnNPmHp2rCsHAgOBqsawkEWkmvPNbEvHtXn0ShRKNUrK
         aJYg==
X-Gm-Message-State: AOJu0YyjYln6ZG9LvkQSnlfiscuv+6T4Dalo6jxe0GTkYVnw6Okb2opJ
	1wl8xc+2dG7e7f8HC8lzQhrqWkxpvNKxWXOIPh3HwuXk3eSlUq5STwX+jlLSCALM
X-Gm-Gg: AfdE7ckMy0hOMZUcF7PP8u+u21dgYLHMGkrMy9lGPuWM1skoUA0WqFDTc+7OokpSn55
	x9u0EIIUYnvJA+c5b71PHDL5XBIU86Ff4eotsecKO3Nu2dMNYl5rv6JalTz1im9JUUtC2UNeTbf
	0ITzF/aD805SCnnfG8fhNFHoNA7jn4QI60eCazuUdzFIm7w/EeUywuru+ZIzjWo6gb13UBvT3+4
	3UIynn8VtTONg7sIjY05PiyvKwTOOE8d3hfOYXVYN4p2vYezwsiF5ioT8+sTcoJPJJ+Gpt0DIb7
	M5pswQRk2b9IpJsrHCW5wl1DJZx5KeC1K0hAHX3MyInNhARh2UoTf2yN4IhbOlIzdDF6/echYck
	1cBlyA/hiUghhrWIa5bQfs+n2v4KYjv7rZGtNNM2IFnfSLMVW4FsI+ytaj6ALaYzsBxoZnPpzqP
	1W2XKUtioozMVAWGhd
X-Received: by 2002:a05:6a00:3c92:b0:845:d274:c01e with SMTP id d2e1a72fcca58-847c51c59a3mr1226417b3a.55.1782921753943;
        Wed, 01 Jul 2026 09:02:33 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:44::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847cb947651sm21836b3a.29.2026.07.01.09.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 09:02:32 -0700 (PDT)
Date: Wed, 1 Jul 2026 09:02:27 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com
Subject: Re: [PATCH net-next 6/6] net: document NETDEV_UNREGISTER unlocked
 rationale
Message-ID: <akU2Hupq1wlJ-5T3@devvm7509.cco0.facebook.com>
References: <20260630182129.1601784-1-sdf@fomichev.me>
 <20260630182129.1601784-7-sdf@fomichev.me>
 <20260630164336.1350403f@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260630164336.1350403f@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303758-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,devvm7509.cco0.facebook.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A07B86EF92B

On 06/30, Jakub Kicinski wrote:
> On Tue, 30 Jun 2026 11:21:29 -0700 Stanislav Fomichev wrote:
> > +Many ``NETDEV_UNREGISTER`` handlers release their lowers with
> > +``dev_close()``, which takes the instance lock itself. Holding
> > +the lock across UNREGISTER would deadlock.
> > +
> > +Moving UNREGISTER under the lock is mechanical: switch those
> > +callers to the ``netif_*()`` lock-held variants. Deferred to
> > +limit churn.


> Doing anything with the device that is sending the UNREGISTER
> sounds odd, since it's going away..

Looking at __bond_release_one, it does try to restore a few original
settings, mostly mtu, I think? (And it does call dev_close unconditionally,
that's fixable).

bond_netdev_event
  bond_slave_netdev_event(slave_dev=event_dev)
    __bond_release_one
      {__netif,dev}_set_mtu(slave_dev, slave->original_mtu)

Or am I misreading this part?

> Not following TBH. Let's say there's a UNREGISTER ntf for eth0.
> Are you saying that eg. vlan which closes their own vlan0 devices
> on top of eth0 needs to be switched to netif_ ? That wouldn't make
> sense since the notification is holding netdev_lock(eth0) and
> we're talking about netif_close(vlan0)?

Maybe rewording it to `... UNREGISTER handlers interact with their
lowers using dev_xxx handlers which take the instance lock` ?

I'm mainly looking for an excuse/explanation on why UNREGISTER
is not converted in this series. Or should I bite the bullet and
add a few patches to make UNREGISTER ops locked as well?

