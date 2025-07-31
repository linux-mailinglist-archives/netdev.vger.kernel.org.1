Return-Path: <netdev+bounces-211151-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42813B16F0A
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 11:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61BD51697FA
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 09:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B0F0241662;
	Thu, 31 Jul 2025 09:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b="uerziJRM"
X-Original-To: netdev@vger.kernel.org
Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84AF1F4616
	for <netdev@vger.kernel.org>; Thu, 31 Jul 2025 09:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.154.215.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753955731; cv=none; b=WFIWmNuH6RHC4SMjEzpVa7++IMxR6Tosbnzx6ZYQlc7N9LS4/wX1svKFLXoJASsIT4/ylusyJdU0RYulbU0X+Camzrc/0IoZHGeUv3Mq/WEDOaqoUmnGhu/VKiZ051w2ABqvmWeLg+4rMeuNL6bYxREb38nOuLJSoDGuQ+1Y9kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753955731; c=relaxed/simple;
	bh=h1oPSjiDn/7E4pI7u0mUwP/ACBeVwg2eOSXATiLmYps=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=F1qYtbO3lzZPgT5RAtl92NzUD0Nc51QuboSOIy4VmGTS4sG3Kjugvycy+gC1lDPpKdtj+BcONr9FKu2F3mussFmqlev7Gl+YfD5S0F9YzNr3RwC6hKlYHUHaAbX1IksuPG/4GAdZW8X6rwXO6TPHvcL/QhiVmsXanWi42qlwilw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=uerziJRM; arc=none smtp.client-ip=216.154.215.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=padl.com
Received: from auth (localhost [127.0.0.1]) by us.padl.com (8.14.7/8.14.7) with ESMTP id 56V9tJQt025911
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 31 Jul 2025 10:55:21 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 us.padl.com 56V9tJQt025911
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1753955722; bh=ZQ43oTJRI3k8so4oBEj1Nn7iMmbfeeSJk0xNmbQYtsc=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=uerziJRMdQC4Eg67EJcAc/rf55Q/1PejiapUqGqMFgULPwIM3MWFozeI3h9jZTihq
	 dXd76t/dVkElkw0r/f42AC2JZMNRsxHDqioFF6eboczEAbT9PTmusMee2TWbCe2hUP
	 kGuJBafeGHVKsbBZgzUbBNOZbnYug5IRlQr5FsskzBCvpcx1nGoHrnbiq1G4xuOHIw
	 73MPkQVA6+KyIulGQd7WG6S3qzdBy57xVo/MRs+gwejiuKG7p5LZgwWYqX8ZM7qhma
	 cFvO7ALKev7xzMJV0InleNitgfx7+jdbRaU93S0ao6B/14KhOWnGCswShmO/g89sEE
	 SAruars3FUkpA==
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: [PATCH net] net: dsa: validate source trunk against lags_len
From: Luke Howard <lukeh@padl.com>
In-Reply-To: <20250731090753.tr3d37mg4wsumdli@skbuf>
Date: Thu, 31 Jul 2025 19:55:06 +1000
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Ryan Wilkins <Ryan.Wilkins@telosalliance.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <42BC8652-49EC-4BB6-8077-DC77BCA2A884@padl.com>
References: <DEC3889D-5C54-4648-B09F-44C7C69A1F91@padl.com>
 <20250731090753.tr3d37mg4wsumdli@skbuf>
To: Vladimir Oltean <olteanv@gmail.com>
X-Mailer: Apple Mail (2.3826.500.181.1.5)

Hi Vladimir,

Thanks for helping me walk through my first kernel patch (I thought I =
would start with a one line one!).

> 1. You need to add a Fixes: tag, like the following:
> Fixes: 5b60dadb71db ("net: dsa: tag_dsa: Support reception of packets =
from LAG devices")

Noted.

> 2. The problem statement must not remain in the theoretical realm if =
you
>   submit a patch intended as a bug fix. Normally the tagger is used to
>   process data coming from the switch hardware, so to trigger an
>   out-of-bounds array access would imply that the problem is =
elsewhere.
>   That, or you can make it clear that the patch is to prevent a
>   modified dsa_loop from crashing when receiving crafted packets over =
a
>   regular network interface. But using dsa_loop with a modified
>   dsa_loop_get_protocol() return value is a developer tool which
>   involves modifying kernel sources. I would say any fix that doesn't
>   fix any real life problem in production systems should be sent to
>   'net-next', not to 'net'. This is in accordance with
>   Documentation/process/stable-kernel-rules.rst.

Thanks for the clarification, I was unsure which to send to: I=E2=80=99ll =
send the revised patch to net-next instead.

Ryan (on cc) saw this crash with a Marvell switch, using some not yet =
submitted patches to support in-band switch management without MDIO.

Exactly what caused the switch to deliver a malformed DSA packet is =
unknown, but it seems reasonable to expect the kernel to be resilient to =
this (although one could make an argument that the trust boundary =
extends to the switch chip).

> 3. As per Documentation/process/submitting-patches.rst, you should
>   replace the wording "This patch adds" with the imperative mood.

Noted.

> 4. Please use ./scripts/get_maintainer.pl to generate the recipient
>   list, don't send patches just to the mailing list, reviewers might
>   miss them.

Noted, I just added Andrew for now.

Cheers,
Luke=

