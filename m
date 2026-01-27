Return-Path: <netdev+bounces-253742-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GEBSKAlteGlSpwEAu9opvQ
	(envelope-from <netdev+bounces-253742-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 08:45:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A9D90D02
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 08:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ADA5730180A3
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 07:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1B6285050;
	Tue, 27 Jan 2026 07:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="pBhjh4uu"
X-Original-To: netdev@vger.kernel.org
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CFA27F73A
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 07:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769499909; cv=none; b=s2uG2QtuV7IJ/lWtZhsvF3S757u5wNI5yLbCiXVL4yPMvKmveFjbinJeZIhbh9bnIzsbSE3S9NeYID2VKHyS9WM5XP55KdcF7nGYfLT9e8mMIjSNEQlUJySrbeVMu7OwX1iMerbuzAwtzZqYrU8GSPexlTsbaYXWes2AWaoW6rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769499909; c=relaxed/simple;
	bh=jRFlianfvhERyS4SQ8HXJV4xHZ0IAZbBHxBU2K0iu/Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YJXNTRmQ571ol6PStAUuFEfcBAyYi5Qb+lHmERrboGseWv9lQNfBSjVhlVmWRx0utGQwH4PvqtkI22NhN4PDIwMfo8RZa0oNZYdqExxRqEH2/cmr2sjPwm17KrRQundEDqiQKe2pOMj9rh5fqURFfqE3sUJp0ix07IcJFS5cHmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=korsgaard.com; spf=pass smtp.mailfrom=korsgaard.com; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=pBhjh4uu; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=korsgaard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=korsgaard.com
DKIM-Signature: a=rsa-sha256; b=pBhjh4uu/IaXMFyJOFZ4J7tDIPlA58kgYhG6qtaXr6zyMeUf9NRrWfrMIsb4TPiTXtfZesYG0Yj2eqiE/VseBEQ/7LmlMpy+oYjslJAMCGeuB8fMfK/LF24WnN+krVUGdeJZ5o0HbBBoGLugWDhlk2EzGa2IdXw0K717SQfXAJFYnmxLeSA7AQpAg7Bxc3P44x1e4uzr+opYW0U5f9h5sWxqSMFvMGPRccIWfToejNOi75DXpNxLLV2FNZZzI5kRTxr5bUJSJTEBUIjs1K5uIXURPNL+grfp0qog+uxuiXNZB62zYVQd6BIozML5evkGuhILP9SS9SpwQydY1GgHgQ==; s=purelymail1; d=purelymail.com; v=1; bh=jRFlianfvhERyS4SQ8HXJV4xHZ0IAZbBHxBU2K0iu/Y=; h=Feedback-ID:Received:Received:From:To:Subject:Date;
Feedback-ID: 21632:4007:null:purelymail
X-Pm-Original-To: netdev@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1981953599;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Tue, 27 Jan 2026 07:43:16 +0000 (UTC)
Received: from peko by dell.be.48ers.dk with local (Exim 4.98.2)
	(envelope-from <peter@korsgaard.com>)
	id 1vkdjH-00000000FYe-0Vcz;
	Tue, 27 Jan 2026 08:43:15 +0100
From: Peter Korsgaard <peter@korsgaard.com>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: netdev@vger.kernel.org,  linux-usb@vger.kernel.org,  Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>,  Andrew Lunn <andrew+netdev@lunn.ch>,
  "David S. Miller" <davem@davemloft.net>,  Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni
 <pabeni@redhat.com>,  Petko Manolov <petkan@nucleusys.com>,  Steve
 Glendinning <steve.glendinning@shawell.net>,
  UNGLinuxDriver@microchip.com,  Nikita Zhandarovich
 <n.zhandarovich@fintech.ru>,  Oliver Neukum <oneukum@suse.com>,  Krzysztof
 =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>,  Deepanshu Kartikey
 <kartikey406@gmail.com>,
  Oleksij Rempel <o.rempel@pengutronix.de>,  Max Schulze
 <max.schulze@online.de>,  Thomas Gleixner <tglx@kernel.org>,  Ingo Molnar
 <mingo@kernel.org>,  "Gustavo A. R. Silva" <gustavoars@kernel.org>,  Kees
 Cook <kees@kernel.org>,  Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH net-next v3] net: usb: remove unnecessary get_drvinfo
 code and driver versions
In-Reply-To: <20260127060534.51206-1-enelsonmoore@gmail.com> (Ethan
	Nelson-Moore's message of "Mon, 26 Jan 2026 22:04:38 -0800")
References: <20260127060534.51206-1-enelsonmoore@gmail.com>
Date: Tue, 27 Jan 2026 08:43:14 +0100
Message-ID: <87ecnb1ox9.fsf@dell.be.48ers.dk>
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
	R_DKIM_ALLOW(-0.20)[purelymail.com:s=purelymail1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253742-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[korsgaard.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,linux.intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,nucleusys.com,shawell.net,microchip.com,fintech.ru,suse.com,piap.pl,gmail.com,pengutronix.de,online.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peter@korsgaard.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[purelymail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,korsgaard.com:email]
X-Rspamd-Queue-Id: 05A9D90D02
X-Rspamd-Action: no action

>>>>> "Ethan" == Ethan Nelson-Moore <enelsonmoore@gmail.com> writes:

 > Many USB network drivers define get_drvinfo functions which add no
 > value over usbnet_get_drvinfo, only setting the driver name and
 > version. usbnet_get_drvinfo automatically sets the driver name, and
 > separate driver versions are now frowned upon in the kernel. Remove all
 > driver versions and replace these get_drvinfo functions with references
 > to usbnet_get_drvinfo where possible. Where that is not possible,
 > remove unnecessary code to set the driver name. Also remove two
 > unnecessary initializations from aqc111_get_drvinfo, an inaccurate
 > comment in pegasus.c, and an unused macro in catc.c.

 > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
 > Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
 > ---
 > Changes in v3:
 > Add changelog
 > Add received Reviewed-by tag

 > Changes in v2:
 > Also remove driver versions from smsc[79]5xx (missed in the original
 > patch because they had a version definition but didn't use it in
 > get_drvinfo)

Reviewed-by: Peter Korsgaard <peter@korsgaard.com> (for dm9601.c)

-- 
Bye, Peter Korsgaard

