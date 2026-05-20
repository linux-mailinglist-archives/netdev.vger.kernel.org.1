Return-Path: <netdev+bounces-290097-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4IqcG6U6Dmoc9AUAu9opvQ
	(envelope-from <netdev+bounces-290097-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 00:50:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CC03759C52F
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 00:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C13431A525D
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 20:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30224361DB8;
	Wed, 20 May 2026 20:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="1B9bMQZu"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D6033D4E8;
	Wed, 20 May 2026 20:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779308121; cv=none; b=SY1FAp8WAEu6UU6Y2Mo8KEKP913rcCAe1mdwVM9Yp9pcsdYgDDkjq2dKe5+V4HLGGMPOzlX/U1wZRF4HL7dU0+a3P0p7v3jFZlWFgjcO7v1Z8Wplhxqy7XN4aIwPjVH156z9ryaZD4uY9jGv6BiP0cDvywHrR03GzVB5QrtCnYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779308121; c=relaxed/simple;
	bh=IH7dRv0KgUy49qjCBLZhEhoNIeVeZlhUjkZK0WeVIVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IF4kS4lsM/yFzZ2X/K+K4RCjHVzdfcImlYlaK72O1YKq6FP8b7NAWHFfa7o7zbjZdM7THg/QJafml83gpfkY7CLU0I3yTIajzgvFTj/ECCR7JFiEVZNWvVIH+07ANFCSpG70LX3CRkyA3QNY6rPG7Y4/y457kIVkOuGeF8T1sT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=1B9bMQZu; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=bXMK+gd4wGZ4tCeBW1FQjrPBlHTcDMWzxfhiyewkKok=; b=1B9bMQZu6759LQQerkZ6GTq/eS
	gfyzcq5OOXLJVbldVejASrFzil0b0K6Tt71SVX2mRniqqVcQMly3i76kUIG+a5e+EXoINVTRAmlaB
	yH+GKF9Sb8ks+3kjdX+pVRjCGIh59b6k/PgXCycuaVNX07FDCwieu7CKQ/ZtzKBWoU1A=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wPnJW-003tkl-3t; Wed, 20 May 2026 22:14:46 +0200
Date: Wed, 20 May 2026 22:14:46 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: mike.marciniszyn@gmail.com
Cc: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>, kernel-team@meta.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Daniel Golle <daniel@makrotopia.org>, Kees Cook <kees@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>,
	Jacob Keller <jacob.e.keller@intel.com>, Lee Trager <lee@trager.us>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Alok Tiwari <alok.a.tiwari@oracle.com>,
	Chengfeng Ye <dg573847474@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next 0/3] dd LED support for fbnic
Message-ID: <48c64757-dc3c-4d05-a269-fa4f50c299c3@lunn.ch>
References: <20260520200337.204431-1-mike.marciniszyn@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520200337.204431-1-mike.marciniszyn@gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290097-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,fb.com,meta.com,lunn.ch,davemloft.net,google.com,redhat.com,armlinux.org.uk,makrotopia.org,gmail.com,intel.com,trager.us,oracle.com,linux.intel.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lunn.ch:mid,lunn.ch:dkim]
X-Rspamd-Queue-Id: CC03759C52F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 04:03:34PM -0400, mike.marciniszyn@gmail.com wrote:
> From: "Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>

The Subject: of this email has an off 'dd' in it.

> The second patch stors the max speed from the firmware dialog

stores

  Andrew

