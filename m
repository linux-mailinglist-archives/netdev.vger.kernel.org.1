Return-Path: <netdev+bounces-255022-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +AxcMGwwfGlVLQIAu9opvQ
	(envelope-from <netdev+bounces-255022-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 05:15:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC51EB70AC
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 05:15:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6CB123004408
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 04:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CCD72E7F29;
	Fri, 30 Jan 2026 04:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eqpXv6Iy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FA519E992
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 04:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769746536; cv=pass; b=WvH9/2htkME7+UeohmoKBNxkXmTxY31NNIzMrerwoSfWrrrpNqNNmEudKQ/8Zfm3eZOMhi0RxZBj8TSnvauJJQOr78aG4LRqkPDQ2NKkmssPhTJhgvbYmQJHUuKylDr87EoxOgJNqtCv8TtguNa+dTy91N0BvgKWr6C5ZW+1RQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769746536; c=relaxed/simple;
	bh=fL8GG1JMH/gBzSRjHKZX6T/wYIsMSQWNC+UDWpbRW68=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=g5Y2dW7RFOGGfSFLeKnwRvRNi9yNkGnMGS+fiDra2gq2bdQvw4NdNMexU6J8gVN5kNGmXThbGPpCEsOLr42wuUeDg2lMFRFp2oLS7mO2gBlW5zH7rk7HPCBXNmVNspQRDnyOvqaHTHE3N4loZtyIGffw4QuP+rIIKOgMD1BI1B4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eqpXv6Iy; arc=pass smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-79472374371so11728787b3.0
        for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 20:15:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769746534; cv=none;
        d=google.com; s=arc-20240605;
        b=f1MPO/e6+8cix7fIb/Yz6wwJIU9+51WO6sXwC1XZZVuS8DUhoPiv+BQDARngWSQwzK
         Z42lRK7QUTzAqcTKua+jnlRm2FB7wJq8xiJCX8xKRZVbWjg6MM7zVOKBygWCXSHKOQIO
         FglEI2Cu4KI9InG7hpMCV+pFc5HiRSLtXftfkaLlILsSpE6i9CrZAu2TDbUgBfePvjPi
         e2FtnsvbhD/te6y1VszqEb9wfw+uZFfhNZtf6DBDdXX/tZNupoYbvIxNkAKgGcgRfGaP
         LUeoH1escEYiBc72cBRdO5ORwS6eg+e1vHPiSa6XoHou7w6z3ZW292Umwc6IzPq3KmrK
         Pp0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=fL8GG1JMH/gBzSRjHKZX6T/wYIsMSQWNC+UDWpbRW68=;
        fh=ZZosgpjpf66QA4MzzGSozejVVFUgvWKH465VDOW0BjA=;
        b=BR7s8iHyORb7oc3odSu+N6suI/xVapaYTiajNfD+H1m/e7E9jaZIDDSHdawR3pD/0S
         q746yukEyAm0egtYnDnhEhHOxVGL1Jfql+idiwvp6mEjT0DRIFNY3RfCzJlT8rTOgXYI
         W+cQd7GHLxxhQCblWNGdYjpcan5WUkMOWRX5jVnDuZPWSYIMhrf6BQSTbzVigH3MzF13
         ivB7T2dkdpDTGUgd8N5GiPbQ6SmMZlxYjqesA+Q1/+nSMhEmwOxNcQZkjSlWuLtbi+E1
         3a/6OcWto0E6ZmoctvXmIB0lAfw1B9zfAnf/lhS5HfaGeBj/KBLeAMMTf28oRhJQXQWP
         wlAA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769746534; x=1770351334; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fL8GG1JMH/gBzSRjHKZX6T/wYIsMSQWNC+UDWpbRW68=;
        b=eqpXv6Iysc02WojC6VnC0Q1NbAnJb29gfbxFQHXGEq3Fm1juYpetDozzy0bMogdoBt
         RNtk64me+h7ScSfWodSHv6Ybh83yMNivh2ilis42f1biQL8GqipVoIyH4j0tcQpldxrv
         +yLEVDmWXrhB0GLgso8yH3MxDJ2D3tXKm03AxQBtuBMtQoSf84gsGSBJKZD/YX67Ia25
         CIZ3ih0gFAhFvRdVdwgN5zXq0umtsob0SIYSTHixv3lsJGYXDPrjISLegphH13ha0ntq
         owx/QR+0NkiRzJkAMd0PuGht9Dff/oYmHiM4P5rntG5WL7pbQQrfSdkuHTywTsWt1dG3
         P2Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769746534; x=1770351334;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fL8GG1JMH/gBzSRjHKZX6T/wYIsMSQWNC+UDWpbRW68=;
        b=CvuqhW5vOmgdwP7vQYCgA5P1Dg8ydnj4sg+AYgHuOC149aN6+FeMUTLmxxWh0gXPq9
         BK+mdxk5+11qfbwDk9c7yhfnIucXcgp6mMm0Q1UQaIaMNlutKk28WE05R75gVLMlrOAJ
         UoUP/13up0iqeUdpjrTnJSeznY0DVGd/WZwR2Oxub1QJcaHd6qb6fOXaC/MZOsFrAtyA
         Pu106EIHVQSgacDPOgVXLR+MSP547SQ3TiWtEXLbIhQP0Y7evsX5zePygw+7EFwQJqVS
         JK5xQvGyyLiML9Za1I6B8jSUvAGvgMO1UhgbrtTQwibjbBt3V7jmyIeWaSCMrGxX65DZ
         Ev2A==
X-Forwarded-Encrypted: i=1; AJvYcCXLSCt5IKercYrMuXYXginxjEN3CtDkjFaMwz2zcjQDIhBHk3c+hiWfByqsj4u1GwhRdHHASp0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/VyI0amXlU/BweKIZZrue22odaOvmuxPydJH6k59U7BJP2q6q
	lvwmsttMKubadQmsPHq93m0r9RNcobkpgYQA2zfZUP8byfNVYy5rBTnF+7f3JydvcmhbDij5cAT
	sJ/27qcf2FpitoQbT/nNhKv+ik92v0y4=
X-Gm-Gg: AZuq6aK+TtENM2brN0WrExF+aD56AKZJzLYy0Cg5y4Kh1QJahOglw56LJ4EDXzRjWkt
	9kIQpurfeG4XS2bNYH09ojIageyE8sJ0ovFJY535GbizzTFmsIC5iN8P/CS2YbBj59AK2hopNQz
	PLtp3dAkbZ+0u4CmvWG0o2ZheGC2eKi/zUlOzjs6tb1puNmE4FD2ZwTRWhk42EGjLASBeGkCeiN
	w+50uao/e8MrFSTnTedIorxk9I2S/noY+VWu65sXjZNiAYeopq6srRWzl8ash2HeEOWC+WpDZSr
	1eJRB/X20BLnoJTtHkD82tl0Grn+ow==
X-Received: by 2002:a05:690c:6c02:b0:794:1a19:f6e5 with SMTP id
 00721157ae682-7949e04f60cmr17165727b3.63.1769746534014; Thu, 29 Jan 2026
 20:15:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Hirokazu MORIKAWA <morikw2@gmail.com>
Date: Fri, 30 Jan 2026 13:15:22 +0900
X-Gm-Features: AZwV_QjanwzacHU1_BddjLyd7v0cxohUMNvzDQ0Ii7XwaI27Z8CY7Z18QX-qPx8
Message-ID: <CAA2RiuSnH_2xc+-W6EnFEG00XjS-dszMq61JEvRjcGS31CBw=g@mail.gmail.com>
Subject: Re: [PATCH net] ip6_tunnel: use skb_vlan_inet_prepare() in __ip6_tnl_rcv()
To: edumazet@google.com
Cc: davem@davemloft.net, eric.dumazet@gmail.com, horms@kernel.org, 
	kuba@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzbot+d4dda070f833dc5dc89a@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	FAKE_REPLY(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,gmail.com,kernel.org,vger.kernel.org,redhat.com,syzkaller.appspotmail.com];
	TAGGED_FROM(0.00)[bounces-255022-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[morikw2@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,d4dda070f833dc5dc89a];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: DC51EB70AC
X-Rspamd-Action: no action

[REGRESSION] ip6_tunnel: IPv4 traffic broken in MAP-E/DS-Lite since
commit df5ffde96693

Hi,
I am reporting a regression in the IPv6 tunneling stack (MAP-E and
DS-Lite) introduced in kernel 6.12.67.

[Description] After upgrading the kernel from 6.12.66 to 6.12.67 in
the OpenWrt snapshot, IPv4 packets can no longer be sent to the
external network via MAP-E or DS-Lite interfaces.
[Environment]
* Hardware: FriendlyElec NanoPi R6C
* OS: OpenWrt snapshot
* Kernel version: 6.12.67 (Broken), 6.12.66 (Working)
* Protocol: MAP-E and DS-Lite
[Culprit] By bisecting/reverting individual commits, I have identified
that the following commit is responsible for this issue:
"ip6_tunnel: use skb_vlan_inet_prepare() in __ip6_tnl_rcv()" (Link to
the patch: https://lore.kernel.org/netdev/20260107163109.4188620-1-edumazet@google.com/)
Reverting this specific commit on top of kernel 6.12.67 restores
normal connectivity for both MAP-E and DS-Lite.
[Steps to reproduce]
1. Set up a MAP-E or DS-Lite connection on kernel 6.12.67.
2. Attempt to send IPv4 traffic (e.g., ping 8.8.8.8).
3. The packets fail to reach the destination.

Best regards, nxhack

