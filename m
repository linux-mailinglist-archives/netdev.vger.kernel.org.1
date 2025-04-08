Return-Path: <netdev+bounces-180336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD9BA80FF1
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 17:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45C7A4A528E
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 15:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A403122CBE4;
	Tue,  8 Apr 2025 15:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XHHK/PeF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758F822CBCC;
	Tue,  8 Apr 2025 15:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744125779; cv=none; b=V6R0v7Jxs0L/bdcyfe/rQwThimzALqmH0X3l8kZhURHAT6fo/6oEpZH78U6jjsG45ljwvEq1rhJydiR8jZm/eFZgpFvmQbt+e2HdWel7h6qfbvbh9zqa3pkkLwGoLVPqRVxGKa2JRaZSg643rLp2OEe+hN/KJ4utGU4pEKFO+Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744125779; c=relaxed/simple;
	bh=g38sI2F/r3LVSr8muislTa9JSawGqyk3eG9TFH+dXRA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lNS2u6RfMHvjXqEDE0LdJPzVQZMbPa8M8+LqT+kJQsg7eNlzAjuajZOvwytWNl5lHWOJfpeH+xHKK8HbCV5ct5bRMPCTxEY3j37ojnwdunjZ3GcXyLeNZCk/v56haA/nxGq9z1nuyJxoAAgO2tcPoNyz1GKHeb7/+8gLK+k+vTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XHHK/PeF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D3C0C4CEED;
	Tue,  8 Apr 2025 15:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744125779;
	bh=g38sI2F/r3LVSr8muislTa9JSawGqyk3eG9TFH+dXRA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XHHK/PeF7bTPTPlFcZ+0wOd2f8+E4++uNg8a+D5JaH7P0wKrds8VArIUwa/MQsi8i
	 0lFxttBhBoY/qfK0YDBnNpcR0N/5yMjVhabIULWDOUudS1CuLGqJpGWptye1K1YkIQ
	 BZMQ7gv7jDkko2x2OTRBfSRLBOBpvB8lUqX3KSPhPmu9Etf8FiKt+XoVDQHL4TwH9S
	 7UNfC9188QfmKN/hwYFGOnL5C3WZRv3Gmb+C8cMpNK3Fi1MESnjWe+dTW0ZDTgc+Up
	 o8nXg9BZ0TCQjFYIG1CLdvSXculdXqZjp325W+CqX72eJmRlXJCFIMXPW+HAl30ugv
	 FdS3wrWwiBQOg==
Date: Tue, 8 Apr 2025 08:22:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Krzysztof =?UTF-8?B?SGHFgmFzYQ==?= <khalasa@piap.pl>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, netdev
 <netdev@vger.kernel.org>, Oliver Neukum <oneukum@suse.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Jose Ignacio
 Tornos Martinez <jtornosm@redhat.com>, Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH v2] usbnet: asix AX88772: leave the carrier control to
 phylink
Message-ID: <20250408082257.7281c61c@kernel.org>
In-Reply-To: <m3plhmdfte.fsf_-_@t19.piap.pl>
References: <m35xjgdvih.fsf@t19.piap.pl>
	<Z_PVOWDMzmLObRM6@pengutronix.de>
	<m3tt6ydfzu.fsf@t19.piap.pl>
	<m3plhmdfte.fsf_-_@t19.piap.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 08 Apr 2025 13:59:41 +0200 Krzysztof Ha=C5=82asa wrote:
> ASIX AX88772B based USB 10/100 Ethernet adapter doesn't come
> up ("carrier off"), despite the built-in 100BASE-FX PHY positive link
> indication. The internal PHY is configured (using EEPROM) in fixed
> 100 Mbps full duplex mode.
>=20
> The primary problem appears to be using carrier_netif_{on,off}() while,
> at the same time, delegating carrier management to phylink. Use only the
> latter and remove "manual control" in the asix driver.
>=20
> I don't have any other AX88772 board here, but the problem doesn't seem
> specific to a particular board or settings - it's probably
> timing-dependent.
>=20
> Remove unused asix_adjust_link() as well.
>=20
> Signed-off-by: Krzysztof Ha=C5=82asa <khalasa@piap.pl>

In the future, if you don't mind, please add a lore link here, like
this:
---
v1: https://lore.kernel.org/all/m35xjgdvih.fsf@t19.piap.pl/

Sending in-reply-to is discouraged, it messes up patch ordering for
reviewers:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#resendi=
ng-after-review

