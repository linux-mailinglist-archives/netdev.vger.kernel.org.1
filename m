Return-Path: <netdev+bounces-252961-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCwqL73Uc2kCywAAu9opvQ
	(envelope-from <netdev+bounces-252961-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 21:06:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3742C7A79A
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 21:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5645D30268BC
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 20:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE1A2D73BD;
	Fri, 23 Jan 2026 20:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="t2CYYPro"
X-Original-To: netdev@vger.kernel.org
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4C02C0F90
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 20:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769198762; cv=none; b=qUCYHdZa7pIV+Efck7Ia3OumhkYCZR07WPnZqK5lUDnGm3HKN0KpKqrEvYdNs6ZA4Z9LoNAlzkJdE2ctHwGUVe6UCM3FzYXLsFd0nztzZApZngGPbdVvBwgB0EXfvkvVhGtE/Ek/61Bf6847r3aaEfz1B+IFMvkaNxLiCaSdwK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769198762; c=relaxed/simple;
	bh=3gNGcsoLTQpESprHSM9qITX7J/EwDXjQhAKXuOdLHI0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ia4gnQW0OEqqs7+KJlfUsgXwEKiXoQr7r0L/xs1qYpVPkNHagODO7NOlg+hXSPDJO+N+bSBFhnuKyjM8PdsXJo2N+h8P+D9RUbpitjPg7hUFNinuqnpVB6GOvlpiTrfxbQCgkbnQpnA0r9X6hM6lZnc4zhlicm2GvugYX6whrOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=korsgaard.com; spf=pass smtp.mailfrom=korsgaard.com; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=t2CYYPro; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=korsgaard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=korsgaard.com
DKIM-Signature: a=rsa-sha256; b=t2CYYPro6XMOCykXxB1+CZaXa+LmneroQ1lQ8D57OZ39yMFBE3d5p5cu3DccE1RVdqi/4GhMnPv/gCWUFJWDh6g91Ps385CJGmU7OfZtmU6ueC43qgfgYNj3BRAQf0pT58e118xEDe7BhQVLkQ9N0uEzgHtE8zfEqzCP6wcezIVHNLzAfcccRLU6hG6BtIbAkTVq50hM+iG5200+XzQSBt+C3yF25+UI1mB17tGH4m4VAM6gnMb7sT8Qec1m7OqZJxKuh27PGm+A3+zWVGHP/pPb2ky9EpuJ/7ygy5UR9UeS5QWvKxj/0k5Q2XHcoZpnBxhhFCe9Zf7pFtHUjloENw==; s=purelymail1; d=purelymail.com; v=1; bh=3gNGcsoLTQpESprHSM9qITX7J/EwDXjQhAKXuOdLHI0=; h=Feedback-ID:Received:Received:From:To:Subject:Date;
Feedback-ID: 21632:4007:null:purelymail
X-Pm-Original-To: netdev@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 2131532355;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 23 Jan 2026 20:05:51 +0000 (UTC)
Received: from peko by dell.be.48ers.dk with local (Exim 4.98.2)
	(envelope-from <peter@korsgaard.com>)
	id 1vjNPh-0000000FoXe-1yWM;
	Fri, 23 Jan 2026 21:05:49 +0100
From: Peter Korsgaard <peter@korsgaard.com>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: netdev@vger.kernel.org,  linux-usb@vger.kernel.org,  Andrew Lunn
 <andrew+netdev@lunn.ch>,  "David S. Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo
 Abeni <pabeni@redhat.com>,  Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next] net: usb: sr9700: rename register write
 commands for clarity
In-Reply-To: <20260123080409.64165-1-enelsonmoore@gmail.com> (Ethan
	Nelson-Moore's message of "Fri, 23 Jan 2026 00:03:58 -0800")
References: <20260123080409.64165-1-enelsonmoore@gmail.com>
Date: Fri, 23 Jan 2026 21:05:49 +0100
Message-ID: <87pl70rt5u.fsf@dell.be.48ers.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[purelymail.com:s=purelymail1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[korsgaard.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252961-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[peter@korsgaard.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.998];
	DKIM_TRACE(0.00)[purelymail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 3742C7A79A
X-Rspamd-Action: no action

>>>>> "Ethan" == Ethan Nelson-Moore <enelsonmoore@gmail.com> writes:

 > SR_WR_REG and SR_WR_REGS may be confused at a cursory glance. Rename
 > them to be more easily differentiated to prevent this.

 > Suggested-by: Andrew Lunn <andrew+netdev@lunn.ch>
 > Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>

Reviewed-by: Peter Korsgaard <peter@korsgaard.com>

-- 
Bye, Peter Korsgaard

