Return-Path: <netdev+bounces-181396-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C19EA84C83
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 20:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 708904C7121
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 18:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83BB028CF5F;
	Thu, 10 Apr 2025 18:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="jl7MZPYD"
X-Original-To: netdev@vger.kernel.org
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9DF27EC7C
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 18:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744311452; cv=none; b=sp4GGvL2YJVlib+a81PpmyfnHgfEW76TijxPgMt8KZ40ru9qJSL3A8wHvdnYjX4a7f66eRoUTkaClreHhaYyBqMWq3ABbfokgSFXlPLBMxr6OGP+O7tGhiD7U7mavAjg+Gw6jL3m0EvKyogQC6kPJls/uqF5oqKkBnxxbRFEfrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744311452; c=relaxed/simple;
	bh=xeL5+hEGBDIKPKRgOBvldVeWd+RMtJ5nakUBfC1vOxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R7bAiN4n2th1no33ES2E4S/NhS9AUn/vicwnvliG9BfnRHpgpBjMBRxiEMX5iNOq5bP3P8J/BcB7dW4VuOLQ7j5xnBcKEbkuy+3X6b9gDJ7trt7BjMzttywYGAKcrqWGKmcyigT6QaVfvuEV8QU7KzpxrN1c6WL03DKaoqOH1UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=jl7MZPYD; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1744311446;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eaY02hnAJ+EVXZaaIQcq6wvdPqkij0YTePX3Y0oOpug=;
	b=jl7MZPYD8uoIVh9uFRRtVWv7dETSd1G7ub23zzwD1KtJORM2Dn2pAwN8OXrgxe2QlCBEb6
	WN5xjPZw0St0U/TbI0aNO4/7WGwS1Pw4+f3Olp9A/0VDUu6sZV+0sTMgpA5P/Fahn7OsUf
	AJU82Btd0yKsjjKhO1aMOKaFFffeUfc=
From: Sven Eckelmann <sven@narfation.org>
To: Eric Dumazet <edumazet@google.com>
Cc: Simon Wunderlich <sw@simonwunderlich.de>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject:
 Re: [PATCH net v3] batman-adv: Fix double-hold of meshif when getting enabled
Date: Thu, 10 Apr 2025 20:57:23 +0200
Message-ID: <4978256.GXAFRqVoOG@sven-l14>
In-Reply-To:
 <CANn89iJQ1Qkby8gFsWHnuYyHYO7_vasNom52OSMAGN49s5EkzQ@mail.gmail.com>
References:
 <20250409073524.557189-1-sven@narfation.org> <3807435.LM0AJKV5NW@ripper>
 <CANn89iJQ1Qkby8gFsWHnuYyHYO7_vasNom52OSMAGN49s5EkzQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1923429.tdWV9SEqCh";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart1923429.tdWV9SEqCh
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: Eric Dumazet <edumazet@google.com>
Date: Thu, 10 Apr 2025 20:57:23 +0200
Message-ID: <4978256.GXAFRqVoOG@sven-l14>
MIME-Version: 1.0

On Thursday, 10 April 2025 15:31:47 CEST Eric Dumazet wrote:
> No worries, could you post the fix today with some of the
> Reported-by: you are aware of ?
> 
> You can add a 'Suggested-by: Eric Dumazet <edumazet@google.com>'

It was queued in the batman-adv repo earlier today. But I am guessing that 
you're request is more important.

Kind regards,
	Sven
--nextPart1923429.tdWV9SEqCh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCZ/gUkwAKCRBND3cr0xT1
y9/qAQDUXWT3n+CQ8ovc1/xN2JPeo8eDzqAX53MuWENH27D7EwD/X64ixToMNA7N
fdJ4uBAK8nWO7vdzHOUwxqzkO0lpLgM=
=//u3
-----END PGP SIGNATURE-----

--nextPart1923429.tdWV9SEqCh--




