Return-Path: <netdev+bounces-259510-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4qmYC1U3l2lfvwIAu9opvQ
	(envelope-from <netdev+bounces-259510-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 17:16:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F47D1608FB
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 17:16:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 660203013B6E
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 16:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2D11F4176;
	Thu, 19 Feb 2026 16:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="JPYCrcsz"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5883BB44
	for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 16:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771517777; cv=none; b=bdcTCmL0hkoYPi8I4PLW1tEbSr5rMwXZavENYePDtnlfuJMP1c4ak3frU6oNu8CULTlV7eCPRuT/F0d4yHEtgUk922WlUgcwKTcPecXH3wYpPvK1i7whkTfoEpdF6U7jXwKiRN+zI8Ag1IiWk+0K96450fLmdDW/d6UaiAXaz/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771517777; c=relaxed/simple;
	bh=jhfFyDUEgtq7O2manZGVeOv3ZwJOGWnBymqTJ+U2zPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fM5e2wBVWXXXhhCbPekaGqPEaLJSlgn0AzCFt78ZQ+RsnUDFbVw0FX61O0oUOB/1iVjyE5CHN6q9UuHlzE3kE05+oqrH6dhhBwn1PRgXWfF2QlnkPQIV7IrCS3i3o5j79UDpngkQOydXH5uONWuYqVfROhnuX7634ceiGqNfIEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=JPYCrcsz; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=iTyCCG5WS2+BLPRyDNy3QqRuaPy80tI3/g7d05j0+fM=; b=JP
	YCrcsz8Nhyq/sAclW1ij7Jhd7TB9XHMaF1Vrr16RU7Xv/Y94o3DDqIsqsUTRw7BbPZO9A6fZLFfl7
	YaHSMqy39dH6CKs9yoNqBiGrr/uJ87CZdiHeO6/M01uHDjwOGeP5Fcs0oi39ZNaniEhqqtr1mzRZd
	q2QRn17t2XeW+MY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vt6hF-007wHu-V1; Thu, 19 Feb 2026 17:16:09 +0100
Date: Thu, 19 Feb 2026 17:16:09 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Maciek Machnikowski <maciek@machnikowski.net>
Cc: kuba@kernel.org, richardcochran@gmail.com, netdev@vger.kernel.org,
	milena.olech@intel.com
Subject: Re: [PATCH net-next 2/2] netdevsim: Implement basic ptp support
Message-ID: <e7387dd2-72a8-4552-8684-3f215f36b2fc@lunn.ch>
References: <20260219140530.2148-1-maciek@machnikowski.net>
 <20260219140530.2148-3-maciek@machnikowski.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260219140530.2148-3-maciek@machnikowski.net>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259510-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org,intel.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7F47D1608FB
X-Rspamd-Action: no action

On Thu, Feb 19, 2026 at 03:05:30PM +0100, Maciek Machnikowski wrote:
> Add support for virtual timestamping inside the netdevsim driver.
> The implementation uses two attached ptp_mock clocks, reads the timestamps
> of the ones attached either to the netdevsim or its peer and returns
> timestamps using standard timestamps APIs.
> 
> This implementation enables running ptp4l on netdevsim adapters.

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

  1.8.3. netdevsim

  netdevsim is a test driver which can be used to exercise driver
  configuration APIs without requiring capable hardware. Mock-ups and
  tests based on netdevsim are strongly encouraged when adding new
  APIs, but netdevsim in itself is not considered a use case/user. You
  must also implement the new APIs in a real driver.

  We give no guarantees that netdevsim won’t change in the future in a
  way which would break what would normally be considered uAPI.

  netdevsim is reserved for use by upstream tests only, so any new
  netdevsim features must be accompanied by selftests under
  tools/testing/selftests/.

Please add to the commit message which of the existing tests in
tools/testing/selftests/ can be used with this new feature. Or include
a new test if needed. net/forwarding/tsn_lib.sh has some helpers which
might be interesting, to start and stop ptp4l. Add a test which shows
ptp4l runs and returns sensible values?

	Andrew

