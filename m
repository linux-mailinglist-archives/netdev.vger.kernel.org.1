Return-Path: <netdev+bounces-280676-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eHStEP/i6WlQmgIAu9opvQ
	(envelope-from <netdev+bounces-280676-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 11:14:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B5844F1E5
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 11:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 83B7330EC21C
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 09:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35393E1CE3;
	Thu, 23 Apr 2026 09:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b="Ve2EdKab"
X-Original-To: netdev@vger.kernel.org
Received: from dilbert.mork.no (dilbert.mork.no [65.108.154.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7A73E274F;
	Thu, 23 Apr 2026 09:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.108.154.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776935375; cv=none; b=jVEp9gbpg7r1RZqo0W37hc2G3mhHiu7567R9pyYiJkjMAoU6RkwAEW/qWdtHRzkAi7gkrriZCwnxuQq58JqE6nKvqa4gV3ruTbXfV6FUwQ+elRLDoCWOTOaM7uSRSh/ujrsXlXGCOqUhNz4XaZIZ2V+SYA3naZbUpO64AIV9sik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776935375; c=relaxed/simple;
	bh=XN8f0MRvC9NVpd6tD0cNCE6ZjJw4390ZXA606TBbQm8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gbe66ek5zJwkg6TYSJoT7QdgdITfqTQCt96xC7z6FRSpZSJMquTUv6WMYl0Yqi5Nz78qt2hEXWhUTnRdTqeaoAzDODNK1pl4/MtaYWVYJmqFdI1eHvbjlYfa37WCOB6IfKHwBqbhUuz2/ck5V1gocanm46+aTRJBHjyCPHCki6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mork.no; spf=pass smtp.mailfrom=miraculix.mork.no; dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b=Ve2EdKab; arc=none smtp.client-ip=65.108.154.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mork.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=miraculix.mork.no
Authentication-Results: dilbert.mork.no;
	dkim=pass (1024-bit key; secure) header.d=mork.no header.i=@mork.no header.a=rsa-sha256 header.s=b header.b=Ve2EdKab;
	dkim-atps=neutral
Received: from canardo.dyn.mork.no ([IPv6:2a01:799:10e2:d900:0:0:0:1])
	(authenticated bits=0)
	by dilbert.mork.no (8.18.1/8.18.1) with ESMTPSA id 63N998F32932608
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Thu, 23 Apr 2026 10:09:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mork.no; s=b;
	t=1776935348; bh=XN8f0MRvC9NVpd6tD0cNCE6ZjJw4390ZXA606TBbQm8=;
	h=From:To:Cc:Subject:References:Date:Message-ID:From;
	b=Ve2EdKab83G1h4HyyHdhN0ZjUDArjY7zH8xpj8Kv9A5RUmmgohFtZd0WbOzaAkROj
	 Bq+gKGKXl84Ey4buy38cDdEH5SI+o3mQWZlE74cGEjBE5qD/fb7HnWnc/QbCH6vUG1
	 auNx2xagdmvSqoMFWy77PIbcNJEaBCQRByQL4CYk=
Received: from miraculix.mork.no ([IPv6:2a01:799:10e2:d90a:6f50:7559:681d:630c])
	(authenticated bits=0)
	by canardo.dyn.mork.no (8.18.1/8.18.1) with ESMTPSA id 63N998kw3458429
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Thu, 23 Apr 2026 11:09:08 +0200
Received: (nullmailer pid 3096294 invoked by uid 1000);
	Thu, 23 Apr 2026 09:09:08 -0000
From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michael Fritscher <michael@fritscher.net>,
        Byron Stanoszek <gandalf@winds.org>, Daniel Palmer <daniel@0x0f.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH net v2 13/15] drivers: net: 8390: pcnet: Remove this driver
In-Reply-To: <20260422-v7-0-0-net-next-driver-removal-v1-v2-13-08a5b59784d5@lunn.ch>
	(Andrew Lunn's message of "Wed, 22 Apr 2026 13:01:56 -0500")
Organization: m
References: <20260422-v7-0-0-net-next-driver-removal-v1-v2-0-08a5b59784d5@lunn.ch>
	<20260422-v7-0-0-net-next-driver-removal-v1-v2-13-08a5b59784d5@lunn.ch>
Date: Thu, 23 Apr 2026 11:09:08 +0200
Message-ID: <87fr4moxfv.fsf@miraculix.mork.no>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Virus-Scanned: clamav-milter 1.4.3 at canardo.mork.no
X-Virus-Status: Clean
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mork.no,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[mork.no:s=b];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[mork.no:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-280676-lists,netdev=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bjorn@mork.no,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mork.no:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,miraculix.mork.no:mid,lunn.ch:email]
X-Rspamd-Queue-Id: A0B5844F1E5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Andrew Lunn <andrew@lunn.ch> writes:

> The pcnet was written by David A. Hindsh

Hinds again

