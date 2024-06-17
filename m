Return-Path: <netdev+bounces-104152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F07890B54D
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 17:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CA1C283D40
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 15:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C0C135A49;
	Mon, 17 Jun 2024 15:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aX78jsrw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8BF12F373;
	Mon, 17 Jun 2024 15:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718638562; cv=none; b=bJf+TENF0ZvKLmsCxoCGScFuT4Xiae2naD1ZugzpmEKmeg+lMdkLv6T1uClWJnVnr6QJ0lbJ1yrfZG3/9G/8UXPNRUvDTvyprugYQkzYKu4njZFI70I6erVIDpgygsMxqZhQxjIlq2hQbkoHfa1DoIiLRrM2pE5JliEi0jSF5bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718638562; c=relaxed/simple;
	bh=oKkY8DUJHqJi7aq4RzMoPZQz16x9vtWfrZmff64niHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HgfpXfbdw7F4lRgr1rO4bUkGziyxaSAR+ugnztPbvujMa/7LxK4fSZ6f0ETpud2FvQ9Ui1kE7fjw9AZgT7FO+3qo7diSpeUhajNDMMd9jidqcfkOMnUb183GY27k3p8vWAhhnVmT+4yEUN968msPgzvy+jazbGhRgqz2q8ifgPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aX78jsrw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 922FEC4AF1D;
	Mon, 17 Jun 2024 15:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718638561;
	bh=oKkY8DUJHqJi7aq4RzMoPZQz16x9vtWfrZmff64niHc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aX78jsrwC+Iubhy0j5Twmwszbgt+IQ4rh0xY7VOQlt/7Q8167saErxNEwaYeanoBj
	 GK3FzWq1cvzggYHLlRZHWO7tONlD9s1WwlTVW5kWVzNXQj0760Fd610oLn/ksssEYk
	 Ikd48iBggZhQ7ZlzkGkh6mejRrpQaRZD17TKZAWdYHb5uNV4KTaHSP4JGcUxuurxVh
	 rrrTmD9i8zKFFQ7s3ys9QI3IbGHXPc146KYS0VIeMlS4Ol1/uP7jgsau3FHYch/XRY
	 88Mft3cJ0sF4vGVbaZpXFgG3k6gUpTE8Poljvfqi+3xElrForLMEhLQsn20wp8JZfC
	 qpamPkyMLa5jA==
Date: Mon, 17 Jun 2024 16:35:54 +0100
From: Conor Dooley <conor@kernel.org>
To: Diogo Ivo <diogo.ivo@siemens.com>
Cc: MD Danish Anwar <danishanwar@ti.com>, Roger Quadros <rogerq@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Simon Horman <horms@kernel.org>,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v4 3/5] dt-bindings: net: Add IEP interrupt
Message-ID: <20240617-buzz-balancing-c2168d853a6c@spud>
References: <20240617-iep-v4-0-fa20ff4141a3@siemens.com>
 <20240617-iep-v4-3-fa20ff4141a3@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3pdF+DqPTBZylhD/"
Content-Disposition: inline
In-Reply-To: <20240617-iep-v4-3-fa20ff4141a3@siemens.com>


--3pdF+DqPTBZylhD/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 04:21:42PM +0100, Diogo Ivo wrote:
> The IEP interrupt is used in order to support both capture events, where
> an incoming external signal gets timestamped on arrival, and compare
> events, where an interrupt is generated internally when the IEP counter
> reaches a programmed value.
>=20
> Signed-off-by: Diogo Ivo <diogo.ivo@siemens.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--3pdF+DqPTBZylhD/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnBX2gAKCRB4tDGHoIJi
0sCPAP4mFlD9F3AigFkn1v2kp8M9jRDptuUlm1pj5CqYi+/BPgEArpsowjrWpJ8j
9KuM1nqEckGmX8RSrxcfMPxJgEAhAwg=
=kcYr
-----END PGP SIGNATURE-----

--3pdF+DqPTBZylhD/--

