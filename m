Return-Path: <netdev+bounces-255950-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UFfmMBfbgGnMBwMAu9opvQ
	(envelope-from <netdev+bounces-255950-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 18:12:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D6345CF6C4
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 18:12:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7AC27303888C
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 17:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58CF3387351;
	Mon,  2 Feb 2026 17:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ortolo.eu header.i=@ortolo.eu header.b="hyLaeCQH"
X-Original-To: netdev@vger.kernel.org
Received: from herbert.ortolo.eu (herbert.ortolo.eu [80.67.179.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885F9387343
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 17:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.67.179.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770051984; cv=none; b=Xjc8nLRqvj3nyu5oI/0kVeLFZNlBfIUXB4kiMWbEJ8EOrLNmVo+DLTcbCh9ko1d116WXA6+XyRw2rquQ4X62cRSwAeZMhRRBBF9qEHnpRlBapOg+ef3YKScggAEcIVxHqEzwcYz1a3jJVFJLBXBeRvR4UUi84Ulr0SMC1dmGfC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770051984; c=relaxed/simple;
	bh=zKUGRj4u4BViCIuoDiq57lZvsIIvalNDWqWzapVybq8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PH1h2mdeFpUu2bmjCbukAeMf1ASpZHD8BoUcWjIgwINyHWTE2PEDZNyBdM9nzhDv6XRn+gSO+YYo1y/NeTBEE2Mkz1T8o2ux6kYxRjF0f9F5tutcV7HePfeNZn1eLVtYX0Y1CIYyY3t+Y8BVdkjtkDaQkf8V5g8lkRZh/OHnei8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ortolo.eu; spf=pass smtp.mailfrom=ortolo.eu; dkim=pass (1024-bit key) header.d=ortolo.eu header.i=@ortolo.eu header.b=hyLaeCQH; arc=none smtp.client-ip=80.67.179.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ortolo.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ortolo.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ortolo.eu; s=herbert;
	t=1770051656; bh=zKUGRj4u4BViCIuoDiq57lZvsIIvalNDWqWzapVybq8=;
	h=Date:From:To:Cc:Subject:From;
	b=hyLaeCQHehUteSK6Ea3UgRDcEUKdPgVmQeDiFQG+02isJHrL0ld91jrl7xpnd4Lxg
	 UJbT6F4H7IHWa0YKBtFo24adZAT4Cddw9YbE7nyZg/ne3BfwoXJGkCvOvYaehzl6tQ
	 tCLbB1VuKyoS1ztTTzLlTn4ae0UqCbs97PGyfjUI=
Received: by herbert.ortolo.eu (Postfix, from userid 1000)
	id C6DDF7373B; Mon, 02 Feb 2026 18:00:56 +0100 (CET)
Date: Mon, 2 Feb 2026 18:00:56 +0100
From: Tanguy Ortolo <tanguy@ortolo.eu>
To: Realtek linux nic maintainers <nic_swsd@realtek.com>,
	Francois Romieu <romieu@fr.zoreil.com>
Cc: netdev@vger.kernel.org
Subject: Weird issue with r8169: shutdown on carrier comeback
Message-ID: <aYDYSHhaF1vQSxdW@ortolo.eu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ortolo.eu,reject];
	R_DKIM_ALLOW(-0.20)[ortolo.eu:s=herbert];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255950-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[ortolo.eu:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tanguy@ortolo.eu,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,ortolo.eu:mid,ortolo.eu:dkim]
X-Rspamd-Queue-Id: D6345CF6C4
X-Rspamd-Action: no action

Hello,

I am experiencing a weird computer issue that is at least partly linked 
to the r8169 driver: the computer shuts down when the Ethernet cable is 
pulled off and plugged again. Or when the switch goes down and up again.

To be more specific, the computer is a [Trigkey Key-N100][1] running 
Debian Trixie. That computer has two Gigabit Ethernet controllers:
     $ lspci | grep Ethernet
     01:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168/8211/8411 PCI Express Gigabit Ethernet Controller (rev 15)
     02:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168/8211/8411 PCI Express Gigabit Ethernet Controller (rev 15)

[1]: https://devhome.corp.adobe.com/docs/default/component/ethos-flex/docs/devhome/prerequisites/

One of them is configured, and when I pull off its Ethernet cable and 
plug it again after a few seconds (or if I reboot the switch it is 
connected to), something simulates a power key press (log from 
systemd-logind: “Power key pressed short”). Even though I configured 
logind to ignore such events, one second after this, the computer shuts 
itself down brutally, as if experiencing a power loss.

After a few experiments, I determined that:
* it happens on both Ethernet interfaces of that computer;
* it happens only on _configured_ interfaces: in particular, it does not
   happen if I unplug the Ethernet cable, run `ip link set enp1s0 down`
   and plug the cable again;
* it does not happen with the proprietary driver r8168.

I am not really sure the r8169 driver is at fault here; it sounds more 
like a very weird hardware issue in specific conditions, which are met 
when using it. Anyway, I though you deserved to know, in case it could 
be useful. Please tell me if there is anything else I could do to 
further diagnose that issue.

Regards,

-- 
Tanguy Ortolo

