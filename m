Return-Path: <netdev+bounces-254432-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8PNyNTBwemlI6QEAu9opvQ
	(envelope-from <netdev+bounces-254432-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 21:23:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5198CA874C
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 21:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3EFE93016276
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 20:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D22328B40;
	Wed, 28 Jan 2026 20:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DGReanjm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44C5327C18
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 20:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769631790; cv=none; b=lHebAKztXbMAmTvVehfGcuaz2OEPGwBjzCFHxTJ4h4NZZ3ja/egxkJJ3WDLFGDMLwRdrG2byRIWpfuobm6lO9pnsw8oIS5JikN2QtOV3190HyKKkbbuVXfDBD/JccZiu222gfdW5uwArcRvdWVH5ptX8Lupg2s8ArpjkC3V4nIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769631790; c=relaxed/simple;
	bh=b9MCvtvWh2E/1tF0+UKczrhKhqZPr8uIauzicyTvNgE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=knuL2PHnywGi1qRJynaFzZOJgs9cUCWeaiK1NByvaGGUna+dAuLQahcrNeQv1vEouAEbFecjdPMl1qUJxfZXGg7cdlg+CEx+GMb+3kwPU+px1LrVioscGo8WVzFmFbIP47hve9+4KNIptQUmgyO5v0XmFyqsrhKi/olsqpegJIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DGReanjm; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4807068eacbso1742805e9.2
        for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 12:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769631787; x=1770236587; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O76YH7CnxQgojGVzsZVBTRj1IdDcsbxWCr4bVn0nPfk=;
        b=DGReanjm4kdGYa1jdfkp7y4iEFYJDrVSnzOxO0WAhSNIyLtRhxPKivlaGdBHV7RT+B
         U2vQXTACaSE2ElM7Gf57rS94POeOdBp7TnPPfFfgqhB2Ab9H3yaafMp4OyJWMTjKmH3C
         RuSwC/EiwZIL6TmwtWBl2tfL5bH8sxFcnY59JHjM4DNsM8bu/TPgCjN53c+YdMLVlDgJ
         bXByxjuGRsrk97STR0Z6uTK9YK6g0N60gWAZQakFArWZovQ3vDsXUe5Z9vBW8nHe0hvX
         rrYB8Qx1IAGd4t6Faf8GwXgCIhVoKZAZ6PFqtb9Gi8g2xc3uGHX6H7thjvPXiXK83Ozb
         6QhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769631787; x=1770236587;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O76YH7CnxQgojGVzsZVBTRj1IdDcsbxWCr4bVn0nPfk=;
        b=sT/ks0LwpsGbQbBW+iG61wnqOcZNXqrnUjAo1MmvU+8zht2DvyLi8FBdnQRvojUFZd
         7Sj5jbRcLZ+DA06zLIj4CjLaC6uawt3nsRw2qH2jHhqbrd/MeTsilvGD4Evx3xkWRmhe
         i3HPd64qXkqXsLRae16ooWIjEMn844QdBO/0ARwrNUZpB+4C0rsMImpaaaYWtjr+exWe
         6ilGhadkWcdeih4g8hn2BX91c34ThK6tVHTxkvNlVfTh4LFHF2zx2IYpzvhLeltToRW3
         5dOFQRuvI+FqVjw8EtnJaJZoPia4sFGdx/kUV+fvWLhkpTi7t6nQ6j6Rt9qeEiteEBV6
         ioPA==
X-Gm-Message-State: AOJu0YxSfoOfrMwP8LkPEAEAYp3mAKXqFQkX/eJkkQOOu7OMhITqJAX8
	SKDbm7D3JvXEjRi7Rq5RkVvvFxEnhMWX1C+oFmnIBMu89AVTrHJVpRIG
X-Gm-Gg: AZuq6aLaLAy1IRM3zAF5iHTGzHcdWYmrVot7ZbCPjS0jKh6fJtGzBRgsCeZftrZRD7B
	8/SFc1jpI7w3nF08MCaU+3yGDgh4F3ApVrkiVJ5tQBHzFX6c44KH786n4K1OEeKi6smaVG20qYC
	mbZruOHiLt/cX650BnzB38umITsYavipOXjEIXU/VrmLBwtx0QhDPyNLnNV6LVGUcoYnwzEVr3P
	PqJZuCFH9ISgwxgO9OQmlOevMNo/237OyVCFRQPgPa9N7lb+KJ0qZrfGED+owei7JUqN2pUBPNG
	X+8pWmmtXGaiJR+zFCS0wB8S98zTACTn4NKHcxv/CGQpsN5wSxdEIQLJ1NYd14mDDsqDoQvn+Uu
	YbQXVG60KnBcBvNu4t43JB5D3hfx9sVRA+/sMdrXa+yuWKueVZ4NOeWojUbA6c4PfMCPRJCcoI/
	/zZ/pCSxRKhivlXIXdcnasilZ8rpn404PDM1C3lqdt3jQ63SJXWCcivwFv9OLZISKoiaT+eXM7l
	sZj3cHGct6zV1ofQEzdbbdEJdW1mlLY/8WCR2DTi0fno9RFRC6p1Q==
X-Received: by 2002:a05:600c:3b1a:b0:480:3ad0:93c0 with SMTP id 5b1f17b1804b1-48069c6949cmr75215005e9.23.1769631787039;
        Wed, 28 Jan 2026 12:23:07 -0800 (PST)
Received: from ?IPV6:2003:ea:8f2b:7200:a9b8:4711:836e:e074? (p200300ea8f2b7200a9b84711836ee074.dip0.t-ipconnect.de. [2003:ea:8f2b:7200:a9b8:4711:836e:e074])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4806ce4c3d1sm85556935e9.9.2026.01.28.12.23.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jan 2026 12:23:06 -0800 (PST)
Message-ID: <43dff7cf-cb00-4480-8856-501a8313951e@gmail.com>
Date: Wed, 28 Jan 2026 21:23:05 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Status of orphaned ltq_etop ethernet driver: mainline vs. OpenWRT
To: John Crispin <blogic@openwrt.org>, Ralph Hempel
 <ralph.hempel@lantiq.com>, John Crispin <john@phrozen.org>,
 Hauke Mehrtens <hauke@hauke-m.de>, Daniel Golle <daniel@makrotopia.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, David Miller <davem@davemloft.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254432-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hkallweit1@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5198CA874C
X-Rspamd-Action: no action

This driver in mainline lost its in-tree user with commit
cd93b4895ea5 ("MIPS: lantiq: drop mips_machine support")
in 2012. Since then it has had no in-tree user.

Only (?) user seems to be OpenWRT, with several changes to
the in-tree driver version:
target/linux/lantiq/patches-6.12/035-owrt-lantiq-wifi-and-ethernet-eeprom-handling.patch
target/linux/lantiq/patches-6.12/028-NET-lantiq-various-etop-fixes.patch
target/linux/lantiq/patches-6.12/701-NET-lantiq-etop-of-mido.patch
So it seems the driver is maintained in OpenWrt only
(except tree-wide in-tree changes).

To me this leaves two questions:
- Move this driver to OpenWRT completely?
- Or mainline all downstream changes, maintain driver in
  mainline, and mainline also the users of this driver?


