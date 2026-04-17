Return-Path: <netdev+bounces-279413-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0NwHLf+Q4mmX7QAAu9opvQ
	(envelope-from <netdev+bounces-279413-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 21:58:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D65E841E676
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 21:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 675433009F1A
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 19:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C4C3CEB82;
	Fri, 17 Apr 2026 19:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=post.pl header.i=@post.pl header.b="UoyOEifw"
X-Original-To: netdev@vger.kernel.org
Received: from mx.post.pl (mx.post.pl [89.161.251.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621123CE497
	for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 19:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.161.251.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776455925; cv=none; b=ZoC3IuLcAXz7u7lLhTx4wH3L5TSqDUmnYVtPLxR8vJmRpZU5nbPYyZRBGfcMCi+nfc35LVaAM9CeOFrG4a6RNehr9mRTPSe/nTrLUiT7UbuE3TQ26UixGqO2aL07gr14zSnsW8aDUHjtqd58U/LNSiVxi5LkHfcJVjVY6/TBz+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776455925; c=relaxed/simple;
	bh=H/iI76JkhAImR+TSgSrZwFHNhVlwHzll3YW26I2BFeI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Lv7eMYIx4VYtNW2GZhnkFt9k+78WPRh1LpR9KDoLeWVuWNN45MJalYTdPO5o1unkRkBy1WAsYzfLWuaXhNzsD3Kefxptzdhal4fQ8I5DPxcfiYplHqpu36few8JrikPUu9DAk+0yi/VuZa4TZe6wwuB8xYDqr/chH6kC8psxYeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=post.pl; spf=pass smtp.mailfrom=post.pl; dkim=pass (1024-bit key) header.d=post.pl header.i=@post.pl header.b=UoyOEifw; arc=none smtp.client-ip=89.161.251.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=post.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=post.pl
Received: from localhost (79.184.237.149.ipv4.supernova.orange.pl [79.184.237.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx.post.pl (Postfix) with UTF8SMTPSA id 496FF3AAFD;
	Fri, 17 Apr 2026 17:23:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=post.pl; s=dkim;
	t=1776439414; bh=H/iI76JkhAImR+TSgSrZwFHNhVlwHzll3YW26I2BFeI=;
	h=From:Subject:Date;
	b=UoyOEifwb8UsrJnqjW7AUNGYHHmGmAyNT0/dG4oZXdf5BtBUnbQo4RC4i6k8Mk+8C
	 PDbV61hqY/403Oikr1GyxGwmJDYiALGi6im23AhVQZbyq5u6ItxuV/D0ZHvwtkK7vh
	 eI5hBm9LzDBoMffIM3/nNtCly7P60dNfzW11AFVg=
From: =?utf-8?Q?=C5=81ukasz_Stelmach?= <steelman@post.pl>
To: netdev@vger.kernel.org
Subject: [BUG] some temporary IPv6 address don't get regenerated
X-Hashcash: 1:24:260417:netdev@vger.kernel.org::av+vsVVC0X3nSM0a:0Mdun
Date: Fri, 17 Apr 2026 17:23:33 +0200
Message-ID: <87340td30q.fsf%steelman@post.pl>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-CLIENT-IP: 79.184.237.149
X-CLIENT-HOSTNAME: 79.184.237.149.ipv4.supernova.orange.pl
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: dmFkZTFyHUTBW7Yz1Q4VXsmIvNxEYgAC0gi5NqUn/Ju9THrCuwumkhCOJg3oJZBp+iSMxTFDXVxZRdtsb35tT9OdOAz4EEsC0Do2nstZw4j0Ri9IdWrTgi5Gwv3Em4y5/h5yQQx8S63ZbnMbKRyQS+2VkNfmcDfaDigVoYDvX9wLaNmh0B1bQV6bHdAbhO4iDfkLRH6cQZQrdrag0WnBFvlxz+PUm1EgKUSFuNEk95uSL01mc43Au/gZo9CJKUj4hBYYHyZytt314x7Zi6XBFSMj5x3maVTNkAxNnkatsczq0VvZ+TrHKLhmLqtoPyGhJPgdzhZNpXQ28jxzs8EfLtOuEC4hWBsxLWa/lx3EhzFJlJrd9PXIjMtP/5yv+uq1oktGi1An0cSEitpa52HmO1AL+N/vQpbL70OMDzjH2nM5zxg3thv3pG6uGnzKHuKgO4GgYpsHV6uxnjDkrSjV4YTN6xxDCWlwK9giz8H8GDTk4x/Aks8ktuSbbR/+GnZp01lJnDKut35ceQuXr9BwodY3NU3QfyBbkFM0cySNWCCinyL/xoREj95kIHuZSeOjuYM+/7zbuQnJ5nIjP8pf7QosiPI4TqgXrWJ/mgRZQKSiGEuVNGaVkyWOBOK7JZOjRc4+3JWuX59cuzQS+1tLtgF2MfUSCv2XWnNOG90wQYR/G/Jolw
X-DCC--Metrics: mail02.home.net.pl 1024; Body=2 Fuz1=2 Fuz2=2
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[post.pl,quarantine];
	R_DKIM_ALLOW(-0.20)[post.pl:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279413-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_ONE(0.00)[1];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steelman@post.pl,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[post.pl:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[post.pl:dkim,post.pl:mid]
X-Rspamd-Queue-Id: D65E841E676
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

Apparently, something in addrconf.c can go wrong and a temporary
addresses may not get regenerated leaving users who wish to use them
with only the stable ones. Below, 2a01:110f:4321:1002:abcc:78d7:2055:94ec
while still valid is not preferred anymore. Even if it's not the only
global temporary address it is the only usable to contact hosts on the
Internet because the other temporary addresses are ULA.

Neither received RAs nor adding and removing an address manually (one
with a different prefix unrelated to these below) which as far as I
understand, should trigger address maintenance code.

I noticed this phenomenon once or twice before. It seems to be very
rare, yet quite undesirable I'd say. What might have triggered it today
is a reboot of my router and (possible?) change in lifetime values it
announced.

Even stranger is that there is a preferred fd89:: (ULA), but not 2a01::.

accept_ra as well as use_tempaddr are set to 2.

Of course, this ma be get fixed by a suspend/resume (no, it may not) or
manual ifdown/ifup (of course it helped), but nevertheless I thought it
was worth reporting.

--8<---------------cut here---------------start------------->8---
107: bond0: <BROADCAST,MULTICAST,MASTER,UP,LOWER_UP> mtu 1500 qdisc noqueue=
 state UP group default qlen 1000
    link/ether b8:ca:3a:d4:1e:97 brd ff:ff:ff:ff:ff:ff
    inet 192.168.2.122/24 brd 192.168.2.255 scope global dynamic bond0
       valid_lft 165585sec preferred_lft 165585sec

    inet6 fd89:82bb:420:2:cab3:d2d6:aeeb:e250/64 scope global temporary dyn=
amic=20
       valid_lft 597079sec preferred_lft 78177sec

    inet6 2a01:110f:4321:1002:abcc:78d7:2055:94ec/64 scope global temporary=
 deprecated dynamic=20
       valid_lft 60815sec preferred_lft 0sec

    inet6 2a01:110f:4321:1002:abac:3aff:fed4:beef/64 scope global dynamic m=
ngtmpaddr proto kernel_ra=20
       valid_lft 60815sec preferred_lft 60815sec

    inet6 fd89:82bb:420:2:24bf:fe8f:5c9c:c753/64 scope global temporary dep=
recated dynamic=20
       valid_lft 511186sec preferred_lft 0sec

    inet6 fd89:82bb:420:2:abac:3aff:fed4:beef/64 scope global dynamic mngtm=
paddr proto kernel_ra=20
       valid_lft 2591805sec preferred_lft 604605sec

    inet6 fe80::abac:3aff:fed4:beef/64 scope link proto kernel_ll=20
       valid_lft forever preferred_lft forever
--8<---------------cut here---------------end--------------->8---

--=20
Kind regards,
=C5=81ukasz Stelmach

