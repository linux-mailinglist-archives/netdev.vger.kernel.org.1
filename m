Return-Path: <netdev+bounces-119155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC3F9545EC
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 11:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E61C1C220BD
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 09:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6253815575B;
	Fri, 16 Aug 2024 09:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TQVy1hjV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gXgbqc0g"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6BBB155731;
	Fri, 16 Aug 2024 09:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723801181; cv=none; b=Rrt8cioBmzXDvUIvdDv0f2KSBNgRfwx824NKeBusXrhNquPTCMJaCTamTpMTAb8r53LefsR477jN7YkD8SVWYofQpy8l/u3srwtfnuUg6Mi0jSxfSI8eeI1oDX0QHLG+79kHZu7eMRf/ij01fRSYH4dehTpTNSWFcP+0cBrFgM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723801181; c=relaxed/simple;
	bh=GCA8cQuwEwNBgoj9TYSkK4RVcQzIIkJrc8uQklmoBIc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gPhSV364nxXOqewH9GY2lsMMPLWmCzov5Q5vIo19EG8UfgpOfulFCMy0ULgEEqSAC6tzGZtHlT3p3f1dzOVVEsnpSAbVoFq96CBh7EvLR5UxU4WYpIIoc2y056LB+wb/BUndC8ExZZdaWmYKoa9CrVETmAbwK6lMJ6EJ8oUZgqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TQVy1hjV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gXgbqc0g; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723801178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GCA8cQuwEwNBgoj9TYSkK4RVcQzIIkJrc8uQklmoBIc=;
	b=TQVy1hjVZkSV9/q3bVbtCwOGqJrYu9NfXUhRDEcF/rj044n1iOI+D5ozqLxJjTb3wPVS2p
	Q4NxufMC50XeV8nZw517pExjPCH8dO6lvINlDs/gcF9DZ0xc/KiILYNBDh/Lbnl/sgP5WW
	oi4BEZ4morJO7xfgRb/eOaX6SE1ZpoRga/ubc+KXJFrLBxHIW08BmdA/qdoIQM1wqZHQjY
	qfVWZEd7nbhp85hE3hgb5G9MuvFos7NOcE/sNMyNY5RbMMHizvuA0fytWYoh4Zgm80BGQp
	X8GIy+b4nogTfVweY+YAnbuj0xGFJKwbEZdCpTbQU/aTcbWXo5kDaWHPY7oeQw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723801178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GCA8cQuwEwNBgoj9TYSkK4RVcQzIIkJrc8uQklmoBIc=;
	b=gXgbqc0g0YJpJuzLSKYVMtDgr3vTyKl1EcypXECeHHO7pfQGIrqOMhanWq31iqn/dsobvw
	pe04TNc4f4K8ozCA==
To: Daiwei Li <daiweili@google.com>, intel-wired-lan@lists.osuosl.org
Cc: vinicius.gomes@intel.com, anthony.l.nguyen@intel.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 przemyslaw.kitszel@intel.com, richardcochran@gmail.com,
 sasha.neftin@intel.com, Daiwei Li <daiweili@google.com>
Subject: Re: [PATCH iwl-net v3] igb: Fix not clearing TimeSync interrupts
 for 82580
In-Reply-To: <20240814045553.947331-1-daiweili@google.com>
References: <20240814045553.947331-1-daiweili@google.com>
Date: Fri, 16 Aug 2024 11:39:36 +0200
Message-ID: <8734n4vmav.fsf@kurt.kurt.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain

On Tue Aug 13 2024, Daiwei Li wrote:
> 82580 NICs have a hardware bug that makes it
> necessary to write into the TSICR (TimeSync Interrupt Cause) register
> to clear it:
> https://lore.kernel.org/all/CDCB8BE0.1EC2C%25matthew.vick@intel.com/
>
> Add a conditional so only for 82580 we write into the TSICR register,
> so we don't risk losing events for other models.
>
> Without this change, when running ptp4l with an Intel 82580 card,
> I get the following output:
>
>> timed out while polling for tx timestamp increasing tx_timestamp_timeout or
>> increasing kworker priority may correct this issue, but a driver bug likely
>> causes it
>
> This goes away with this change.
>
> This (partially) reverts commit ee14cc9ea19b ("igb: Fix missing time sync events").
>
> Fixes: ee14cc9ea19b ("igb: Fix missing time sync events")
> Closes: https://lore.kernel.org/intel-wired-lan/CAN0jFd1kO0MMtOh8N2Ztxn6f7vvDKp2h507sMryobkBKe=xk=w@mail.gmail.com/
> Tested-by: Daiwei Li <daiweili@google.com>
> Suggested-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> Signed-off-by: Daiwei Li <daiweili@google.com>

Reviewed-by: Kurt Kanzenbach <kurt@linutronix.de>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAma/HlgTHGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzghDCEACx8T5zGnmrBjeSsXzemRWluHVJI6Ub
7QnBxWCvIfrC8sUUzgsXYa08yMTXjTAkSh9pxTW0oVqpV01J+jd7NKJrz1qdZ1XV
RDRF178k4DPKLSrP1/XkMaFV5DI+56OzRoZgEudq5rmSVwqcdYNh+wRrO8Oh7ucx
xgQhXMhvzZruRCzsMNyStuqn3zF51M1YPBfgTLjk8UD9nnXGLRnwLFgv0OjUL89K
rhD5TXZ3seFW82RelaNorkC2ALLkPAQB7Pd2GVejrcWcj23Una2aPZV44uqV1VMI
iBnE1idHmJEO8/T4sLxwudHr1WJffb82PxadBdm7NGemqZh4OShc0GOWoWu2OEdY
UojoM8OGofudAfol8HdUHESETaR3gK5ZIlKEl22nPWN/rDpaUCl+se7Kv7UGpacc
vXd3AP+V/3oDb21evFjjqlQGsqodcTKD68C7OjvRZT0fSx7V0rnyxm4Lvou1zwWl
KbWG112CXPgx1YSJNiPfsYNhJMU8wmSjM9PABy1PLLgbesLfKIbj8o1lF54Aq2Nn
TyvhsWHYCnEPPfo2uRNtWX94h9uBZRo/Ll2kz4H4vVCD87RXkWMgNcdHcYzeiUIL
NLnNi7PHcQtpclrQVDLyh5c8m9VKCOCFtE2g4IdiMjOV/ecP/iCknnqf3Zxs5Piy
BTECwLhghJ5GKA==
=sPWN
-----END PGP SIGNATURE-----
--=-=-=--

