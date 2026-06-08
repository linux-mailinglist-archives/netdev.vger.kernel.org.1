Return-Path: <netdev+bounces-296725-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id K2B8BhovJ2pntAIAu9opvQ
	(envelope-from <netdev+bounces-296725-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 23:07:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 209B865A9DD
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 23:07:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ggieVirV;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296725-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-296725-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 723723017CD2
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 21:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3FF399890;
	Mon,  8 Jun 2026 21:07:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4968037998B
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 21:07:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780952834; cv=none; b=UNwMMFfzqkASvnlR/N7Kn65hL4WGQHu+NIu0sz7UB7UR0ESgdqSvxQYX0rPu0QDW8iIHhP091cfkaKxlmoT5sIiG3Y6tHeSVzIx+TaQ2PjQeb66QcMjV3xPAP8vtisk9K+rJTMI/0ZxlPKwfrS+M/JgQVbB9HspwxgZinMV4jOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780952834; c=relaxed/simple;
	bh=AkJ4Onjq6hRT+x3T2G96bEDlFlW6AzfGwTZ56r0g0r4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WF8kOORQVcBRr21bctOiC2nUqkzJJ7rb8ABEuaXLKDKzcmjhORr2pTHP+VcFWn6bkI7W5SqMXx8Tllt1JGoEUK3WKsxfSlLFlIv73jhxdKLATkk7rXi53bNef+3NaPz+16pR333TssiL7xNGDmWFuUSxTxHRvuG4s61mdvIApz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ggieVirV; arc=none smtp.client-ip=209.85.221.47
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-45ef4223be7so2541901f8f.2
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 14:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780952832; x=1781557632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3sHjwoJ5ZnUIbl6Kzmw0eDuutU3fVA4THUQ3Mz9TeEk=;
        b=ggieVirVWHqyof8Uy+u8MkDm3EBe+KpUNRopO7IO34rJ4n5BO8M7EhNCOuDcPz+3LC
         h3uR8nkACCtY0ray2Mio528zObd6swx5fpUOzJcwxzwvwDwDavfp4wvqpEeD39hsjY75
         lywV6qES1wTsUDhbQPYcPa/OUczaRgWKEsZwKreayX9xsisq2g7OtanE5VqW+/lbucLN
         3osluvkuWdUUPWYCCAPRHOMBIMuV2Y5ZeQggfcqC/OmC4yYE0iGu8DiInzb47tqjXlW4
         ZUEy0H0N1yZvprLqoeM57lEZaTqyxistYyJDwg9yPpSMbhw4eQ5XbpPKXodn06gAmNtV
         U+iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780952832; x=1781557632;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3sHjwoJ5ZnUIbl6Kzmw0eDuutU3fVA4THUQ3Mz9TeEk=;
        b=SkmwxFuYvWmH74l2BugzFlqCdI3HY0ysjW0QqjCh2Z76TQnFqGpwq5gO+e/4j9FYeh
         7Z0HoNbRg6XR85xTwTM/hjXaUdKseReNkhBBukOpwkr4PgYpQRJ/994LpduwUuZcEO6l
         sywj9GE+aUPBK6gq1Eoh4SaOIGWDT/4fVnvrMkXOo59uZtjyo3CWjmtplrLgCaVvuas5
         V7uodtfMSbQPDLfVSCcXKVLK5JiYUA0HDA9nxi7SGf2xZ9jFp33Eaw2d2RQkoUHtKgpz
         VBlFgCkqTn2Q71S4euFY49uwLrLNPFQfnhdQbRWbAmfbwZOul8uD54eOKTfXSYDlNXTA
         eD6A==
X-Forwarded-Encrypted: i=1; AFNElJ9bDbiWQFvqhXe94cLrebHEDomjVBZEZXkwSDumoX5VLIn3ALZsoCfXHPYl0unKB+YUgBeK9Jc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjUX1a4rjsl5BYj7hvPXBZICrAfFvN50ZhgAIYZCC3PpX0dIVd
	nGMY1yfVUuIgh4hHTCemwDdAIuvtsxJ3AiXNnylI8ypM3tN17eH2A5Hm
X-Gm-Gg: Acq92OHXjGMq2+UT4VvixEtB9hE2FaMMIxHvs4PTpq4kz0VfUndfaoCaSKGeIaNBDFk
	v6j+6xgtitULqZ+5V+BQf674Cu6NpnHG0y7f0eoitDHSniLihdjqtDD9hvCK/rvaSNJ5QNlksby
	VqYyDwB6sk1qwS0+RtpEB01YEbsI+wlDBCVrmfGjRMBOO45lB4R6OOdadgaRoNQIhdwzAFOpEnw
	ii5t3MOVOBtqhdilBHdSl2WlgLYHEwdHOpgJgeplkKHl6ppULiE0OfrWIZ2jTq9O6nf+ym3b5mV
	oQb3NT8wjAg2nTaepEMyJrvfAJEVZxvecJiOnuW9CuxvRj7ZZ9r7pT+BTRCzGql6wp2rhLjC0XO
	kZCOr5ouEpqDK8uyJiX4UqiwDfXlknLgvXdIb61fUpcBGsXp9HSmIthwNHIJ45xaH/qc7Vl3TYE
	br5wicI2WyZofUGhc0s4V3V2Wd3Vnzc5WH+0DBg0ZPugVx3sjYscSSaksdqyBT6RNfouPIR8g=
X-Received: by 2002:adf:f847:0:b0:45e:779a:302c with SMTP id ffacd0b85a97d-4603065b681mr18894313f8f.29.1780952831514;
        Mon, 08 Jun 2026 14:07:11 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4602cda363bsm43293865f8f.31.2026.06.08.14.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 14:07:11 -0700 (PDT)
Date: Mon, 8 Jun 2026 22:07:10 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org, Arnd
 Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jay
 Vosburgh <jv@jvosburgh.net>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next] drivers/net/bonding: User strscpy() to copy
 device name
Message-ID: <20260608220710.7499931d@pumpkin>
In-Reply-To: <20260608132311.0fb69fed@kernel.org>
References: <20260606202633.5018-13-david.laight.linux@gmail.com>
	<20260608132311.0fb69fed@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-296725-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:kees@kernel.org,m:linux-hardening@vger.kernel.org,m:arnd@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:jv@jvosburgh.net,m:pabeni@redhat.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 209B865A9DD

On Mon, 8 Jun 2026 13:23:11 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Sat,  6 Jun 2026 21:26:07 +0100 david.laight.linux@gmail.com wrote:
> > From: David Laight <david.laight.linux@gmail.com>  
> 
> Could you be so very kind to read the automated message you received
> when you posted this?

Looks like I managed to send two patches for files in the same directory
that contained equivalent fixes.

I think I should be able to merge the patch emails into one and send
as a single V2 patch that contains both changes.

	David

