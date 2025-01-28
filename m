Return-Path: <netdev+bounces-161420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B68FEA2141F
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 23:24:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8532E164112
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 22:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A069A1DE8AD;
	Tue, 28 Jan 2025 22:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="JtVOZA6H"
X-Original-To: netdev@vger.kernel.org
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E42019CC28;
	Tue, 28 Jan 2025 22:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738103061; cv=none; b=GXn1dmWmwpZRu4exSHa0QJKuQzrqyxTM7cl+Y5rBW8xlYYKasJbkFYGKpo0tbCSkWwsJ1zu2x9gtHSxSHcbXY0T9afmgX9FgkC0x4bra2d4K+zEV9VV2zX0YH8EwK3+BmrNiEchgBgOZqaVcO+VKVBU90cGH03k9SD5eL5ZvSlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738103061; c=relaxed/simple;
	bh=J21s2u2nuQSStqkQXx4YohcQfCGGmJYLMnQTbe94y3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j0B4mWOSlKKopQQ/mOLATI3dQ3PJEJ/3sw89lr5Of5kGB4Y1Xxw2zd7YiY8DBEa2XU9Jbe1LRQkn3m9ERNnYjAf/nUkOOv7dT8hT/sI0yRWQDpnNreXmnjnqV+L8tWxDxiLrG11e7cisoJ2uDKltG6RRTy1IdoVJvASGgrZEo0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=JtVOZA6H; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1738102690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WlJ/vQSJrlC1BRhfLopAn8UyVFJn0XAPGj8Ae9LjNDk=;
	b=JtVOZA6HiI0Opwh5/PilrZzSrXm4Fm6PridGdsgAxKWy8sJqaY/Dzkpo5e+kvVK+u3Oc7I
	XvRzcdiYPHpj3XcTf9zWZZ4mZHji62XfjWIlUht7GROx1q0x5lb52MVr33dofcztAFyoSm
	m//B23Cd7mEmzWycQ/nY1QT05HGgVQ8=
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Remi Pommarel <repk@triplefau.lt>
Cc: Marek Lindner <marek.lindner@mailbox.org>,
 Simon Wunderlich <sw@simonwunderlich.de>,
 Erick Archer <erick.archer@outlook.com>, Kees Cook <kees@kernel.org>,
 Remi Pommarel <repk@triplefau.lt>
Subject:
 Re: [PATCH] batman-adv: Fix incorrect offset in
 batadv_tt_tvlv_ogm_handler_v1()
Date: Tue, 28 Jan 2025 23:18:06 +0100
Message-ID: <2593315.VLH7GnMWUR@sven-l14>
In-Reply-To:
 <ac70d5e31e1b7796eda0c5a864d5c168cedcf54d.1738075655.git.repk@triplefau.lt>
References:
 <ac70d5e31e1b7796eda0c5a864d5c168cedcf54d.1738075655.git.repk@triplefau.lt>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart9301015.NyiUUSuA9g";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart9301015.NyiUUSuA9g
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 28 Jan 2025 23:18:06 +0100
Message-ID: <2593315.VLH7GnMWUR@sven-l14>
MIME-Version: 1.0

On Tuesday, 28 January 2025 16:11:06 GMT+1 Remi Pommarel wrote:
> Since commit 4436df478860 ("batman-adv: Add flex array to struct
> batadv_tvlv_tt_data"), the introduction of batadv_tvlv_tt_data's flex
> array member in batadv_tt_tvlv_ogm_handler_v1() put tt_changes at
> invalid offset. Those TT changes are supposed to be filled from the end
> of batadv_tvlv_tt_data structure (including vlan_data flexible array),
> but only the flex array size is taken into account missing completely
> the size of the fixed part of the structure itself.
> 
> Fix the tt_change offset computation by using struct_size() instead of
> flex_array_size() so both flex array member and its container structure
> sizes are taken into account.
> 
> Fixes: 4436df478860 ("batman-adv: Add flex array to struct batadv_tvlv_tt_data")
> Signed-off-by: Remi Pommarel <repk@triplefau.lt>

Thanks for the patch. I just wanted to dump my notes here (because it is 
getting a little late).


Original calculation was:

1. tvlv_value_len -= 4 [sizeof(*tt_data)]
2. check if tvlv_value_len contains at least num_vlan * 8 bytes [sizeof(*tt_vlan)]
3. tt_vlan = vlan section at offset 4 [sizeof(*tt_data)]
4. tt_change = change section at offset offset 4 [sizeof(*tt_data)] + num_vlan * 8 bytes [sizeof(*tt_vlan)]
5. tvlv_value_len was reduced by num_vlan * 8 bytes [sizeof(*tt_vlan)]
6. num_entries was calculated using tvlv_value_len / 12 [sizeof(batadv_tvlv_tt_change)]

result:

* tt_vlan = tt_data + 4
* tt_change = tt_data + 4 + num_vlan * 8
* num_entries = (tvlv_value_len - (4 + num_vlan * 8)) / 12


After Erick's change

1. tvlv_value_len -= 4 [sizeof(*tt_data)]
2. calculation of the flexible (vlan) part as num_vlan * 8 [sizeof(tt_data->vlan_data)]
3. check if tvlv_value_len contains at the flexible (vlan) part
4. tt_change = change section at offset num_vlan * 8 bytes [sizeof(*tt_vlan)]
   (which is wrong by 4 bytes)
5. tvlv_value_len was reduced by num_vlan * 8 bytes [sizeof(*tt_vlan)]
6. num_entries was calculated using tvlv_value_len / 12 [sizeof(batadv_tvlv_tt_change)]
7. "tt_vlan" is implicitly used from offset  4 [tt_data->ttvn]

result:

* tt_vlan = tt_data + 4
* tt_change = tt_data + num_vlan * 8
* num_entries = (tvlv_value_len - (4 + num_vlan * 8)) / 12


The broken part of the change was basically following:

-       tt_vlan = (struct batadv_tvlv_tt_vlan_data *)(tt_data + 1);
-       tt_change = (struct batadv_tvlv_tt_change *)(tt_vlan + num_vlan);
-       tvlv_value_len -= sizeof(*tt_vlan) * num_vlan;
+       tt_change = (struct batadv_tvlv_tt_change *)((void *)tt_data
+                                                    + flex_size);
+       tvlv_value_len -= flex_size;


if the line

+       tt_change = (struct batadv_tvlv_tt_change *)((void *)tt_data
+                                                    + flex_size);

would have been replaced with

+       tt_change = (struct batadv_tvlv_tt_change *)((void *)tt_data->vlan_data
+                                                    + flex_size);

then it should also have worked.

(calculation for this changes follows below)

> ---
>  net/batman-adv/translation-table.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
> index 3c0a14a582e4..d4b71d34310f 100644
> --- a/net/batman-adv/translation-table.c
> +++ b/net/batman-adv/translation-table.c
> @@ -3937,23 +3937,21 @@ static void batadv_tt_tvlv_ogm_handler_v1(struct batadv_priv *bat_priv,
>  	struct batadv_tvlv_tt_change *tt_change;
>  	struct batadv_tvlv_tt_data *tt_data;
>  	u16 num_entries, num_vlan;
> -	size_t flex_size;
> +	size_t tt_data_sz;
>  
>  	if (tvlv_value_len < sizeof(*tt_data))
>  		return;
>  
>  	tt_data = tvlv_value;
> -	tvlv_value_len -= sizeof(*tt_data);
> -
>  	num_vlan = ntohs(tt_data->num_vlan);
>  
> -	flex_size = flex_array_size(tt_data, vlan_data, num_vlan);
> -	if (tvlv_value_len < flex_size)
> +	tt_data_sz = struct_size(tt_data, vlan_data, num_vlan);
> +	if (tvlv_value_len < tt_data_sz)
>  		return;
>  
>  	tt_change = (struct batadv_tvlv_tt_change *)((void *)tt_data
> -						     + flex_size);
> -	tvlv_value_len -= flex_size;
> +						     + tt_data_sz);
> +	tvlv_value_len -= tt_data_sz;
>  
>  	num_entries = batadv_tt_entries(tvlv_value_len);


Remi's change:

1. size of first data part is calculated using 4 [sizeof(*tt_data)] + num_vlan * 8 bytes [sizeof(*tt_vlan)]
2. check if tvlv_value_len contains at least 4 [sizeof(*tt_data)] + num_vlan * 8 bytes [sizeof(*tt_vlan)]
3. tt_change = change section at offset offset 4 [sizeof(*tt_data)] + num_vlan * 8 bytes [sizeof(*tt_vlan)]
4. tvlv_value_len was reduced by 4 [sizeof(*tt_data)] + num_vlan * 8 bytes [sizeof(*tt_vlan)]
5. num_entries was calculated using tvlv_value_len / 12 [sizeof(batadv_tvlv_tt_change)]
6. "tt_vlan" is implicitly used from offset 4 [tt_data->ttvn]

result:

* tt_vlan = tt_data + 4
* tt_change = tt_data + 4 + num_vlan * 8
* num_entries = (tvlv_value_len - (4 + num_vlan * 8)) / 12

Sounds at least at the moment like a plausible fix. I have already queued it 
up for batadv/net but will leave it for a moment to allow others to review it 
too.

Thanks,
	Sven
--nextPart9301015.NyiUUSuA9g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCZ5lXngAKCRBND3cr0xT1
y3xfAP4u0mrCRUsT6pG8vmB3OJXyhDzJLVA1GtDeXlK3yQ4lEwEAi72tsVDvMtr4
+Mbtf7ICIMGG/L+xYEa6Zb4wWBkSZA4=
=5Ryn
-----END PGP SIGNATURE-----

--nextPart9301015.NyiUUSuA9g--




