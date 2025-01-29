Return-Path: <netdev+bounces-161456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A4AA2191E
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 09:35:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7E7F3A28AA
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 08:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8071990D9;
	Wed, 29 Jan 2025 08:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="nPESqwUJ";
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="X0zU6JXQ"
X-Original-To: netdev@vger.kernel.org
Received: from e3i103.smtp2go.com (e3i103.smtp2go.com [158.120.84.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7459B8462
	for <netdev@vger.kernel.org>; Wed, 29 Jan 2025 08:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.84.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738139755; cv=none; b=Bt6Q414e80VpL1XEqg++ZiLeJnBVZVKHrN+VeB/ax7RcE5pIRuOZGArfwyoNN3GMIbvQRwvEsYZ+81QUv7/DNNOKWQMIWMwyLxOB4m3938xo5SBNsSoSzHgXrhozUpWoCXUyTc0fL6Tc9vzpQEx2qocY2CxlIlBI/JgZTesnvNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738139755; c=relaxed/simple;
	bh=yz31b2ue5JCbQXayYcj8IbxD8JP42W1SCJcAIEHyNog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RVCVIhQE/b3aF0AOYna6Me7DNngVmzz7ScXc1ocFNyzx7RZABChN1QHXYUusZSmR2tXBls62LOhR7pcOTCIpZAiO8q3+yvRRBaIJCafaN64aJ0tIHvEhAGgPethI0aJakYKPuiEC/+G32kQpfw/Px4pbVZJbSHB4y4sPVbri/W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=pass (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=nPESqwUJ; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=X0zU6JXQ; arc=none smtp.client-ip=158.120.84.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smtpservice.net;
 i=@smtpservice.net; q=dns/txt; s=a1-4; t=1738139749; h=feedback-id :
 x-smtpcorp-track : date : message-id : to : subject : from : reply-to
 : sender : list-unsubscribe : list-unsubscribe-post;
 bh=DY7ub80gYd9tjBAAYJLj+o/B1grhiHlqArNUfs+UkGE=;
 b=nPESqwUJ7w8YFSnT3j+vkuF9f3CUr7LBljLg+0CLntanUIUjLwe+TtWwVMnD2noMA8UFs
 oLGIUAgQJSw/7Gbv9QtEjA9BVNPOPfS+P0KdMcvK6JgqBwnSiQAQOSZw+wwvLrqKg+4mfpL
 R1o1mifJJAnB1fsmFbs1iyZzYH+9lRKGpOSmWJ40l3E+dEvLwY0C+0bdUQvj9WI3bXyjtLL
 csDtoDaI6WhafzrtelYH9l5LDv9fe+uCASqn8tKTA1SGaDwxePjnrRROYOw3cwNMny/8+Kc
 so2vFZRzM5i7uq4TzXVDxRbcDI6/6sxySUnqDOk6UnrTN8n9MaEJKNPf8x7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1738139749; h=from : subject
 : to : message-id : date;
 bh=DY7ub80gYd9tjBAAYJLj+o/B1grhiHlqArNUfs+UkGE=;
 b=X0zU6JXQBk/1e2buxHWatEnLB3qntTC5oYfCfBECq6XEnr7hv4g+sY4iVYb4iCT2c1ipR
 8TQQiuJC8S04Q1OblvrCM8af/ESeWO5CZW5cgannzUZW3f6yQaiBbEdTkYhrn3df+KQDLKe
 VURAtoH42iXNiW+8oJrOHIoKvVumv56qB78gRaEH9Zq2ujOqLx/NWBxg3ONN5iKhC5yZpS7
 imBAMczBcsqIY6Qp8w2ceVv2f9j/qOkkGjryuIp/Wy+rqiKS4JAMmiBxt+Vk0ZgBxxTXCsI
 t2kHH/o7GT1LzaTtTZiLlnr5kFu0QIcW01iJohfgChzg5dUdR1yNcSu+7MLg==
Received: from [10.12.239.196] (helo=localhost)
	by smtpcorp.com with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97.1-S2G)
	(envelope-from <repk@triplefau.lt>)
	id 1td3Y2-FnQW0hPpfXA-ln41;
	Wed, 29 Jan 2025 08:35:46 +0000
Date: Wed, 29 Jan 2025 09:32:02 +0100
From: Remi Pommarel <repk@triplefau.lt>
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Marek Lindner <marek.lindner@mailbox.org>,
	Simon Wunderlich <sw@simonwunderlich.de>,
	Erick Archer <erick.archer@outlook.com>,
	Kees Cook <kees@kernel.org>
Subject: Re: [PATCH] batman-adv: Fix incorrect offset in
 batadv_tt_tvlv_ogm_handler_v1()
Message-ID: <Z5nngheTbToYRJFi@pilgrim>
References: <ac70d5e31e1b7796eda0c5a864d5c168cedcf54d.1738075655.git.repk@triplefau.lt>
 <2593315.VLH7GnMWUR@sven-l14>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2593315.VLH7GnMWUR@sven-l14>
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Feedback-ID: 510616m:510616apGKSTK:510616skYQn4pg0B
X-smtpcorp-track: UWknqejfzBnV.LLhh4rBIGj7C.ktnw-gTfRA6

On Tue, Jan 28, 2025 at 11:18:06PM +0100, Sven Eckelmann wrote:
> On Tuesday, 28 January 2025 16:11:06 GMT+1 Remi Pommarel wrote:
> > Since commit 4436df478860 ("batman-adv: Add flex array to struct
> > batadv_tvlv_tt_data"), the introduction of batadv_tvlv_tt_data's flex
> > array member in batadv_tt_tvlv_ogm_handler_v1() put tt_changes at
> > invalid offset. Those TT changes are supposed to be filled from the end
> > of batadv_tvlv_tt_data structure (including vlan_data flexible array),
> > but only the flex array size is taken into account missing completely
> > the size of the fixed part of the structure itself.
> > 
> > Fix the tt_change offset computation by using struct_size() instead of
> > flex_array_size() so both flex array member and its container structure
> > sizes are taken into account.
> > 
> > Fixes: 4436df478860 ("batman-adv: Add flex array to struct batadv_tvlv_tt_data")
> > Signed-off-by: Remi Pommarel <repk@triplefau.lt>
> 
> Thanks for the patch. I just wanted to dump my notes here (because it is 
> getting a little late).
> 
> 
> Original calculation was:
> 
> 1. tvlv_value_len -= 4 [sizeof(*tt_data)]
> 2. check if tvlv_value_len contains at least num_vlan * 8 bytes [sizeof(*tt_vlan)]
> 3. tt_vlan = vlan section at offset 4 [sizeof(*tt_data)]
> 4. tt_change = change section at offset offset 4 [sizeof(*tt_data)] + num_vlan * 8 bytes [sizeof(*tt_vlan)]
> 5. tvlv_value_len was reduced by num_vlan * 8 bytes [sizeof(*tt_vlan)]
> 6. num_entries was calculated using tvlv_value_len / 12 [sizeof(batadv_tvlv_tt_change)]
> 
> result:
> 
> * tt_vlan = tt_data + 4
> * tt_change = tt_data + 4 + num_vlan * 8
> * num_entries = (tvlv_value_len - (4 + num_vlan * 8)) / 12
> 
> 
> After Erick's change
> 
> 1. tvlv_value_len -= 4 [sizeof(*tt_data)]
> 2. calculation of the flexible (vlan) part as num_vlan * 8 [sizeof(tt_data->vlan_data)]
> 3. check if tvlv_value_len contains at the flexible (vlan) part
> 4. tt_change = change section at offset num_vlan * 8 bytes [sizeof(*tt_vlan)]
>    (which is wrong by 4 bytes)
> 5. tvlv_value_len was reduced by num_vlan * 8 bytes [sizeof(*tt_vlan)]
> 6. num_entries was calculated using tvlv_value_len / 12 [sizeof(batadv_tvlv_tt_change)]
> 7. "tt_vlan" is implicitly used from offset  4 [tt_data->ttvn]
> 
> result:
> 
> * tt_vlan = tt_data + 4
> * tt_change = tt_data + num_vlan * 8
> * num_entries = (tvlv_value_len - (4 + num_vlan * 8)) / 12
> 
> 
> The broken part of the change was basically following:
> 
> -       tt_vlan = (struct batadv_tvlv_tt_vlan_data *)(tt_data + 1);
> -       tt_change = (struct batadv_tvlv_tt_change *)(tt_vlan + num_vlan);
> -       tvlv_value_len -= sizeof(*tt_vlan) * num_vlan;
> +       tt_change = (struct batadv_tvlv_tt_change *)((void *)tt_data
> +                                                    + flex_size);
> +       tvlv_value_len -= flex_size;
> 
> 
> if the line
> 
> +       tt_change = (struct batadv_tvlv_tt_change *)((void *)tt_data
> +                                                    + flex_size);
> 
> would have been replaced with
> 
> +       tt_change = (struct batadv_tvlv_tt_change *)((void *)tt_data->vlan_data
> +                                                    + flex_size);
> 
> then it should also have worked.

Erick's initial patch was almost doing that but Kees emitted concern
that this could bother the compiler bound checker and suggest the
current flawed logic [0] (hence him in CC). I wasn't sure the (void *)
cast would prevent the bound checker to complain here, so I tried to
also follow the "addressing from the base pointer" strategy Kees
mentioned.

On a side note, I am all about hardening and memory safety stuff but
if that means impacting readability and spending more time trying to
please the tool than thinking about the correctness of the code change,
that's where we end up converting a perfectly fine code into a
logically flawed one.

[0]: https://lore.kernel.org/lkml/202404291030.F760C26@keescook/

-- 
Remi

