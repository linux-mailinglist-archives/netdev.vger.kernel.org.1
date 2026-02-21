Return-Path: <netdev+bounces-259828-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2C14CevYmWkeXAMAu9opvQ
	(envelope-from <netdev+bounces-259828-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Feb 2026 17:10:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A4316D3C9
	for <lists+netdev@lfdr.de>; Sat, 21 Feb 2026 17:10:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8E6C30214DE
	for <lists+netdev@lfdr.de>; Sat, 21 Feb 2026 16:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E902DCBF7;
	Sat, 21 Feb 2026 16:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="0yd43Een"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBD32DB79F
	for <netdev@vger.kernel.org>; Sat, 21 Feb 2026 16:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771690215; cv=none; b=PyDvWAMD1crpeQb0czLrdD+qrarbn8YrH4xj2g+AzEu2bOJvBd2KCZWEVysRu+E3CV+07GA4LZ3lTkGyQo+9bv4ADH8lrbQhQYoxmTE+MScmfdP2i6azoABLNiLsyZmMgBikwRFI0eCsthekCnI+Plcwlvo+jwiDzFlHukIgHJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771690215; c=relaxed/simple;
	bh=ZbkqrLdc62pLjotZtZoP+RnNAEPOTnqSGQpsrx5OEoo=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=If41AcIhcemgsC1qPJNLosIR3itf7/Lu8AihHIKC30NRCHqp5n5GupXLydeD5PDVewtoIurVVULTrrRgIFLeui9Uvjm5KXj3pcPiA0p686NJz2HBYSmNBbc+RvAWjbs/pzZ7jyDOEsdc7a0r+jc2NYxY18qKt5nVYgmCpjAqrJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=0yd43Een; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-463d81452abso1955443b6e.0
        for <netdev@vger.kernel.org>; Sat, 21 Feb 2026 08:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771690213; x=1772295013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z4UNznzYHS91akkUO/PnX70Z9N2x6qXPiwF3ms8pLos=;
        b=0yd43EenNMRd68lcr22haul6wZd6yAXs46Z4dMy9W5X32vDDPSGHdtvPPSVw3NJ3z8
         2gjFUjQ3jQpZP0uCFo6oQyKxlLTQm/MKQEVlyoigcn47V+zEMUSzOjPCaWwoPbE6XPWD
         9wJ5mOkfOSCmyWvKvIppWlbfSM1tHoDNb6bJP+Q2/+h3DCeHdMAXmV8mpwFCTnjY/t7O
         ctSJm6ltRkqoyVdi1P2QwVwmqXgD64S3ivaqbUKjlVbRFuKO32+VuVYjYoayyiOTeexi
         YMGeAUCEyKWclv9GZeqYYWUqlZJ25uvOHKNnhbJt4iKi0KHA7X2IMEWS7AbQSBiGrTLu
         kuog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771690213; x=1772295013;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z4UNznzYHS91akkUO/PnX70Z9N2x6qXPiwF3ms8pLos=;
        b=OMUqEthsolk4ShONr8lYzp38FnEd58fVy50/XnK5i9Fnbt3wCj8F4yWlJZpDAzS5hA
         omsiJEPU2Cx1NZ49nFOfz5GckAuuj+1tHmIya/Lm3cZ7c+Lm9RUnTd5LEYFl3oBfU/wC
         5SCehzubtIDGqnCH5iQL9hsmr+4yDRglyQtRimmgIQ/P20mNzEzKL+lh72cLSd4OTUk3
         U/6m3JDZffPWenTA7e6+I3P+F6s3joi4xtHuJuQrgVOPlzABpySTcIN1sdNb8WPzZAWm
         QpJcMwxHeP8OLMkTgpamJ69jQY2IeWQZtwknIY0snCpYRSwdScBxeGkHWePL2CpNkkx5
         aUNw==
X-Gm-Message-State: AOJu0YxmYplyQjLa10ZkCGksqCZt2b13qoU3DM0x245N/VW23ybVeM0Z
	7b8WXOkL96QNSLx6EONJptLA1hVWl0tfEzDFAZe0oPRKbKSiCnCtFJpe1EMaPnBwyVbu+VWC+GJ
	Cv1le
X-Gm-Gg: AZuq6aJB1rEB322hkFN22HIFzsKW9JodqrIptgghpfw5ugBSHt2aXTQPgfBzgcPsJQg
	9o/RldsGWXb6o8wr7bTF/k1XLNVLZWevrp+EvmT+251QiWWc67ZDpGMB+Asa0GVxSJ8E9H+w6mw
	Wv3cwg55szhsAel2GOcPgwLoilWNzYcJJR2aC6Gk6VdLCRflExMKraaXMzq7wTa5B7hplbsp14i
	VY1SJfzYbHIWk3fCS4lesc0BIQd/G+2vHpXpgmAxA4zv8HCd8zF5PB8QFFcx6EYO9km761dKfMq
	+kIL8S7X8kiNIVnQ45oBGLexC/8snZOhL4O6XAQJ+OBIK+d5lHgrlj+ZR6FThMh7c1laEtw+YA4
	do+zeg8aXUPN9KofvrWsWHmDppuIFVzscBXvG0Co/yejAyxwIQgtaCYkej3E4ax3dT8Nsx1ox9Y
	Le5JVw2L9AdHeo70S+5EkptkiHLYltH6nS73IdczzlnPCFkathQOw4TF399BE+87cP
X-Received: by 2002:a05:6808:ed0:b0:463:93a5:a5c7 with SMTP id 5614622812f47-4644616ec49mr2000980b6e.2.1771690212576;
        Sat, 21 Feb 2026 08:10:12 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d52d072598sm2664044a34.27.2026.02.21.08.10.11
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Feb 2026 08:10:12 -0800 (PST)
Date: Sat, 21 Feb 2026 08:10:09 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Subject: [ANNOUNCE] iproute2 6.19.0 release
Message-ID: <20260221081009.45f00ca8@phoenix.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.56 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[networkplumber-org.20230601.gappssmtp.com:+];
	TAGGED_FROM(0.00)[bounces-259828-lists,netdev=lfdr.de];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 54A4316D3C9
X-Rspamd-Action: no action

This is the regular release of iproute2 corresponding to the 6.19 kernel.

The biggest addition is a new `dpll` command for managing Digital
Phase-Locked Loop devices via netlink, which also prompted refactoring
the `mnlg` library into a shared location. CAN XL support saw major
expansion with seven patches from Vincent Mailhol adding transceiver
mode setting, PWM configuration, and a RESTRICTED operation
mode. MPTCP gained a new `laminar` endpoint type and several monitor
improvements from Matthieu Baerts, who also added a MAINTAINERS entry
for the subsystem.

On the devlink side, there's now support for 64-bit parameters, a new
`SWITCHDEV_INACTIVE` eswitch mode, and burst period configuration for
health reporters. The `genl` utility picked up JSON output
support. Andrea Claudi modernized `ifstat`, `nstat`, and `lnstat` by
converting them to the high-level `json_print` API for consistent JSON
output.

Rounding things out are smaller fixes: per-CPU support for XFRM, HSR
protocol version display, an off-by-one fix in iplink, a musl libc
build fix, and assorted man page corrections.

Download:
    https://www.kernel.org/pub/linux/utils/net/iproute2/iproute2-6.18.0.tar.gz

Repository for current release
    https://github.com/shemminger/iproute2.git
    git://git.kernel.org/pub/scm/network/iproute2/iproute2.git

And future release (net-next):
    git://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git

Contributions:

Akhilesh Nema (1):
      fix 'UINT_MAX' undeclared with build with musl libc

Andrea Claudi (3):
      ifstat: convert to high-level json_print API
      nstat: convert to high-level json_print API
      lnstat: convert to high-level json_print API

David Ahern (4):
      Update kernel headers
      Update kernel headers
      uapi: import dpll.h from last sync point
      man: Fix spelling in tipc-link man page

Ido Schimmel (1):
      devlink: Fix resource show output

Ivan Vecera (1):
      devlink: Add support for 64bit parameters

Jan Vaclav (2):
      iplink: hsr: add protocol version to print_opt output
      ip/iplink: fix off-by-one KIND length in modify()

Matthieu Baerts (NGI0) (6):
      MAINTAINERS: add entry for mptcp
      man: mptcp: fix minor typos
      mptcp: add 'laminar' endpoint support
      mptcp: monitor: add 'server side' info
      mptcp: monitor: add 'deny join id0' info
      mptcp: monitor: support 'server side' as a flag

Petr Oros (3):
      lib: Move mnlg to lib for shared use
      lib: Add str_to_bool helper function
      dpll: Add dpll command

Sabrina Dubroca (1):
      ip-xfrm: add pcpu-num support

Saeed Mahameed (1):
      devlink: Support DEVLINK_ESWITCH_MODE_SWITCHDEV_INACTIVE

Shahar Shitrit (1):
      devlink: Introduce burst period for health reporter

Stephen Hemminger (6):
      genl: add json support
      genl: move print_policy into genl
      uapi: update from 6.19 merge window
      uapi: update mptcp and rdma headers
      man/tc-actions: fix typo
      v6.19.0

Vincent Mailhol (7):
      iplink_can: print_usage: fix the text indentation
      iplink_can: print_usage: change unit for minimum time quanta to mtq
      iplink_can: print_usage: describe the CAN bittiming units
      iplink_can: add RESTRICTED operation mode support
      iplink_can: add initial CAN XL support
      iplink_can: add CAN XL transceiver mode setting (TMS) support
      iplink_can: add CAN XL TMS PWM configuration support

Yureka (1):
      lib: bridge: avoid redefinition of in6_addr

Stephen Hemminger (1):
      v6.19.0


