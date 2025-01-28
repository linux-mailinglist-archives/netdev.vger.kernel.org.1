Return-Path: <netdev+bounces-161418-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B0BA21416
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 23:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC0673A2B68
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 22:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671C01ACEBF;
	Tue, 28 Jan 2025 22:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="GNHpZ8+O"
X-Original-To: netdev@vger.kernel.org
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCB51D5AC0;
	Tue, 28 Jan 2025 22:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738103000; cv=none; b=mzpmEImR6YQBJTn2F9gAC6YqA029u4lFBBQJvNV3G+9EvABJdvVUZLJuNZjHyLnAClxOGrscOnC22qKtQx85HWx/u+If45TW51JkzP7tAzlv1/m3PmSeXtl9YAWshRt64iXc2IUslJYJFzlVEudx+sok2CKDt/oN8qNNJr+Va0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738103000; c=relaxed/simple;
	bh=jACosfkEKjRvwCWjSK1fLfwaHllPnkaJC2WsZPwlCCk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y5o+Ie/EYfmfW9+QApz5wFIa2XX7dGlytBP9Hu5LuAorTdA94JWQzpmWjrNZ8/n2xBUVCy94zqkmpDfbBpHIy/ZDQESKcDyIZE6sFZP8cKJpmUyCYE4RD2qQ33kHavq4Vz0tYIMRFzB0RRsfp5xZwwuwZZab/YNbLWvhlyH7uZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=GNHpZ8+O; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1738102995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SoUbqoynN+sBzfcT9HGO8nkSlJSYhrGLCnBnhpxE0gw=;
	b=GNHpZ8+OYbJ56wDnsK1JmzCFNREa0yguQRFqV9JxrmjZv92a6fmL8cou61x7elOuDKOszZ
	H/D0qWYEmYL7bPVYQ+YQCNgJoB/Xdt59n8XkmTxOoynrX0vgFDJiAICo+ELHMHuyRGl5Rg
	wPJn9U14PsgoRILdUWPVw+SdJnrBCnQ=
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Remi Pommarel <repk@triplefau.lt>
Cc: Marek Lindner <marek.lindner@mailbox.org>,
 Simon Wunderlich <sw@simonwunderlich.de>,
 Erick Archer <erick.archer@outlook.com>, Kees Cook <kees@kernel.org>,
 Remi Pommarel <repk@triplefau.lt>, Sven Eckelmann <sven@narfation.org>
Subject:
 Re: [PATCH] batman-adv: Fix incorrect offset in
 batadv_tt_tvlv_ogm_handler_v1()
Date: Tue, 28 Jan 2025 23:23:12 +0100
Message-ID: <4306467.QJadu78ljV@sven-l14>
In-Reply-To: <2593315.VLH7GnMWUR@sven-l14>
References:
 <ac70d5e31e1b7796eda0c5a864d5c168cedcf54d.1738075655.git.repk@triplefau.lt>
 <2593315.VLH7GnMWUR@sven-l14>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2693008.CQOukoFCf9";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart2693008.CQOukoFCf9
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 28 Jan 2025 23:23:12 +0100
Message-ID: <4306467.QJadu78ljV@sven-l14>
In-Reply-To: <2593315.VLH7GnMWUR@sven-l14>
MIME-Version: 1.0

On Tuesday, 28 January 2025 23:18:06 GMT+1 Sven Eckelmann wrote:
> "tt_vlan" is implicitly used from offset  4 [tt_data->ttvn]

tt_data->vlan_data not tt_data->ttvn

Kind regards,
	Sven
--nextPart2693008.CQOukoFCf9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCZ5lY0QAKCRBND3cr0xT1
y+SKAQCYZr8BMBWIqGtJAOrKxlJZ2moFoPa2nWHaVFUcOOuuCQD9Fs8Msh3lczt/
tCou08Mh45BrfIJu50N2q4F6rzx1UA8=
=1wo7
-----END PGP SIGNATURE-----

--nextPart2693008.CQOukoFCf9--




