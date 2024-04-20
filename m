Return-Path: <netdev+bounces-89803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 561A68ABA04
	for <lists+netdev@lfdr.de>; Sat, 20 Apr 2024 08:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8FA7B20E9A
	for <lists+netdev@lfdr.de>; Sat, 20 Apr 2024 06:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4717FD530;
	Sat, 20 Apr 2024 06:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=a16n.net header.i=@a16n.net header.b="pnUYP+Zr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out.a16n.net (smtp-out.a16n.net [87.98.181.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD4F7F
	for <netdev@vger.kernel.org>; Sat, 20 Apr 2024 06:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=87.98.181.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713595219; cv=none; b=gFuByIP2CfgFmTJBzqqc6hRc2r79fr4k/j9Q7ECm3o9or6NFL7cpFFQ+2lQoAqkE448e0g/LQYF+2xIQczLBa+YoIg47xEX3vRxN3mFKVFwUGA1aKxlhXgQHmdb6VSpj060SUJrz/rLvpqJYXT0vjnWZE2G8RlpUyLAhZI2OyFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713595219; c=relaxed/simple;
	bh=9VBYOWLZltsj7hffFQc2+yWe1Fnyjz4y92cCEA3tzVw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DLlkPzvR9O8666djh9l0QPylbwSs5FkQH9X44nwL6L3oDUHgu2eMut7BASSsMuT0lxSHALArYIxckovylUBf/CRgl5RlBtViq0CbolueSxkSmoXBKeCRKy12Hjet+YfBkWMjTSFHFK3Zn3+nv2rhRhjo5SR19gMf/LjiYw717IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=a16n.net; spf=pass smtp.mailfrom=a16n.net; dkim=pass (2048-bit key) header.d=a16n.net header.i=@a16n.net header.b=pnUYP+Zr; arc=none smtp.client-ip=87.98.181.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=a16n.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=a16n.net
Received: from server.a16n.net (server.a16n.net [82.65.98.121])
	by smtp-out.a16n.net (Postfix) with ESMTP id 2BDFC460497;
	Sat, 20 Apr 2024 08:40:11 +0200 (CEST)
Received: from ws.localdomain (unknown [192.168.13.254])
	by server.a16n.net (Postfix) with ESMTPSA id 415EE801223;
	Sat, 20 Apr 2024 08:40:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=a16n.net; s=a16n;
	t=1713595211; bh=Wt9YHBfVZDqhegXzIUXVsXvslr7q8HBq2pAKdLyBOSY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=pnUYP+ZrnXt1UItYMD9YtsqbkvCHJnD8ZFVbH4rYG0XcAl7SQhOJSO10dFcvc9IyA
	 XeFvaw38XqtpIJ9sw46XQ64mUdFZFVjMplFT8IC2CSzdCo+uZYcMPzj+KXBCplPbpx
	 ogGEkYmks2JVmHrv2l4iWU1gYKZBj5wscW8yAZ3j2XK4rxUXPxrRNIv+CHqOmXv+2J
	 ThzastRyQKJDIWHRemeJr9u6JzQdZLnPsx2uZhyddMF+Kop/Kd5c1CYjMgMun38vZ6
	 7Scvp4duezFA2NqZefmKkYDqh+pxa9lXtbGKZm7iRxiSx8kr8syKFGnU7WlGLLDzCu
	 Xm4zjs68Xfrxg==
Received: by ws.localdomain (Postfix, from userid 1000)
	id 23D8D206C1; Sat, 20 Apr 2024 08:40:11 +0200 (CEST)
From: =?utf-8?Q?Peter_M=C3=BCnster?= <pm@a16n.net>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org,  Michael Chan <michael.chan@broadcom.com>
Subject: Re: [PATCH net v3] net: b44: set pause params only when interface
 is up
In-Reply-To: <876ff4fa-1744-4929-9da8-8a10016c2f30@lunn.ch> (Andrew Lunn's
	message of "Fri, 19 Apr 2024 23:14:10 +0200")
References: <87o7a5yteb.fsf@a16n.net>
	<876ff4fa-1744-4929-9da8-8a10016c2f30@lunn.ch>
Date: Sat, 20 Apr 2024 08:40:10 +0200
Message-ID: <87sezgy1th.fsf@a16n.net>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19 2024, Andrew Lunn wrote:

> Still above the --- . Don't use attachments.

Ah, ok, sorry.


> Lets see what Jakub says.

Ok, so I should wait before sending v4?


> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Another line to attach to the patch for v4?


> We are picky about things like this

No problem, I fully understand.

=2D-=20
           Peter

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iGoEARECACoWIQS/5hHRBUjla4uZVXU6jitvQ7HLaAUCZiNjSgwccG1AYTE2bi5u
ZXQACgkQOo4rb0Oxy2jLUgCgnxiBb8dsN04RT07raCVL/Vi0WxQAoMwthu7wKx+c
rjcWILPERTX6iRm2
=jH6I
-----END PGP SIGNATURE-----
--=-=-=--

