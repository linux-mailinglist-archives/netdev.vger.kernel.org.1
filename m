Return-Path: <netdev+bounces-292532-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6ItfHYSrF2rWMwgAu9opvQ
	(envelope-from <netdev+bounces-292532-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 04:42:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E6B5EBEEC
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 04:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2CA193051D17
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 02:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FDFF2F8E8D;
	Thu, 28 May 2026 02:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="VKWmUuoP"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378AB2F7F13;
	Thu, 28 May 2026 02:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779935604; cv=none; b=bQqBjOzRF8kw64rFDCVAuNeAXVQKg73hes69eFLyReqksSUNOFkpfw6XoQOxFjVzpVNh1HpboJ9MRJPPh5wc6DJPjaJh+VZwb9NMbmXbtlH24JWoqFyhCYzBa4yY6N/BtmBNEuSCPn4+X1doC6XcBs6YYAJtLvRL4NcKE2JO2fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779935604; c=relaxed/simple;
	bh=ftvZ5wYwEjX576O+Yh8giu0FbxTIXnilbQ8TL4RZsuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FB3TWY9BA7L2Y+gKTQq0f3kVVCuDrvS48yuLy7UbFz2c0sLgdONz+PbIZ0Oq1ivuZe1C1Rlw+HFhgcdtsMpoa+p2WVwjO7xVhCJfadEDeEadzZG8Jhmpm5QhsHrJ0XoPNNXVOHbvs0C7JtDYXhtKCSiK8F35HhzKbkG0OySoQaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=VKWmUuoP; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=fr6Y8TO2W2jW05r04g+qUVWDWgl79hZnYclXguG/q5Q=; b=VKWmUuoP8INoMui8mp3eJmFYiP
	ahE2ykh8GiAD2x8IQYdUHjVT+QdgJEY35qiN5L+ZO7OUomSsWPVc7aOHN1lF9DwGHFQo+lsobPn8J
	5+/AaAQZ8vdjsLB68GaadoQ1MXaq8Buz8A0Z4zbqQbdc8F92yXHt578KQ0nIb9+gkxgw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wSQYY-004qOD-Kt; Thu, 28 May 2026 04:33:10 +0200
Date: Thu, 28 May 2026 04:33:10 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: ciprian.regus@analog.com
Cc: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v2 07/10] net: phy: add generic helpers for
 direct C45 MMD access
Message-ID: <7e309b40-62de-443d-a2e0-d9098147fd8b@lunn.ch>
References: <20260527-adin1140-driver-v2-0-37e5c8d4e0a0@analog.com>
 <20260527-adin1140-driver-v2-7-37e5c8d4e0a0@analog.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527-adin1140-driver-v2-7-37e5c8d4e0a0@analog.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292532-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,gmail.com,armlinux.org.uk,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:email,lunn.ch:mid,lunn.ch:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,analog.com:email]
X-Rspamd-Queue-Id: C8E6B5EBEEC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 27, 2026 at 12:51:52AM +0300, Ciprian Regus via B4 Relay wrote:
> From: Ciprian Regus <ciprian.regus@analog.com>
> 
> Some PHYs support direct C45 register access but not C22 indirect MMD
> access (registers 0xD and 0xE). When discovered via C22, phylib routes
> MMD access through the indirect path, which won't work on these
> devices.
> 
> Add genphy_read_mmd_c45() and genphy_write_mmd_c45() as read_mmd/
> write_mmd callbacks that bypass the C22 indirect path and use the bus
> C45 accessors directly.
> 
> Signed-off-by: Ciprian Regus <ciprian.regus@analog.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

