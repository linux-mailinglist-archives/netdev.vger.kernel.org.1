Return-Path: <netdev+bounces-288646-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qOQWEdyNCGr4uwMAu9opvQ
	(envelope-from <netdev+bounces-288646-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 17:31:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B37C555C675
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 17:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2D91A300FB79
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 15:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11CD7358391;
	Sat, 16 May 2026 15:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="NhA6nPae"
X-Original-To: netdev@vger.kernel.org
Received: from sonic312-23.consmr.mail.ne1.yahoo.com (sonic312-23.consmr.mail.ne1.yahoo.com [66.163.191.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0766B3E2778
	for <netdev@vger.kernel.org>; Sat, 16 May 2026 15:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.191.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778945497; cv=none; b=cwt0/uD6sqvZMEGyn07/cz+2r65wFvDlxtQjA7iHpncOTH37f1e5BD2bfXzYAe6a+mnKo2Dfn4MreChZJj+Q/KzWiIsTF6fumFqcoCOHKgWl1ahj/33JnE6wVfn0IJJRhUr2Erv3nwkMY54S9HAEO6Nb230pNFBSGLbz23TwSxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778945497; c=relaxed/simple;
	bh=bD6WGwZnwT/PB5NAWswED+NW3RAICeGEADp8Bp8Ru+s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LXQbs4yi/OnwDqCEjcVsh4Y8SU92mRqfDWweAZmb2Ur7k3Q0zjktXjok/w4Ipfs0fBzC37XRw8bWWySf70T+lhnX3HoS0K5/MZ7Njld9vhXbAe/JwKqzEDDJHLPYfxTXHjyAZJJiDw/XY85+9Sk+qmox/NvJKDiTgHcaZ8izQLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=NhA6nPae; arc=none smtp.client-ip=66.163.191.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1778945494; bh=8o0c3wTrLl3NcAMsAuP+jfpZyX+nfCq3O/NnytFnK+M=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=NhA6nPae0st5jJ//CrllEUNfk7Veo/DS4K4u8VagFj897PRtpQo3AOeFzJF4AWeIcTTA3AEK9gwxDOiA2Le3UJMrP/gvr0u27NVx+vv2pvDxqBGNSyf5rTIA2kMydpSNeRA0u3rW9x31RLkfi5WtIU5f0uNx9koFDSSWBY+IRD9UY58f2WvU8ffVdMeFjxxqNhPzgVxocS+9o3oTYN1kDrHnQV7Fg2NbwMPn6SfNo7ybRwnhwom+A/XR0a3h7sIkegP4C5cMdQqo2lkaxID0JtqKdK6ZJW/OXoLej7koj/NM9Xv/gEPCu9K6NyhhsywFOirGg1mJb3PwKE9ric0EcA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1778945494; bh=S9wKYneDMvEyHG5ODiSdCyG6mnt7M0deDkEV4/hmiKg=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=rndk/jFem97kAwjHDRJqTxzV/geEWMtdfg//4oyOSOznktd+amFKeYyaqB99wtx2aTiltdJJT6BVdCANCRYV/aIdV2lgA0l8auzaTZszb+fgWYKFK0AeozK2NRswNenRMDLsVA7p9N6VjW3jVGK0KzDLr4QHtNF5ouyfD2vTeCGT6wlexgtzKKncmuxo5PB3QB4CjHhglLjhiboIiOEElxQ/1WIr37CjhyAvxlOcdY8qzdIFDghIu21UkGvIocPkw9Kfr9dqyrrxnejb4VULlxnczDPod5Aca6sHCC8sNJdTg9nGcc6gYzAm2oTVDqWOpt3dnG0R1ZlL+wMMpmi9UQ==
X-YMail-OSG: ZBGuLe8VM1lJB9EqD6d53QFwrsB9hDBqJXPziohywNwA6P_il4bR5ZwdgDhMqQj
 c1.pidVIVaorudfdS0pvd8BNncZj2yVNIpifYwAH18N8lIngO2zlmHV3TonutfHRm5OTEF_s__26
 JNKhLzApSDgz19jp4_jeWv1ImJGoT2NescqWw54pb2vwznV8iJh6UuCvsBEKJUpYrLOztS4RKsET
 m6udDVcktLDdtWK3Os5A.AykWCes3rN5hmx.Nen6Az1xV1orsJ4rOeBcVk5yoaVv7EUHWZnVjSCM
 ueBO5BTQAzFyfwX6UDj7uWVpBJpXZ5CcOjJ9aDg7rPZoFAEJvHQlxzlaGJyomjS8hGLbatlV74lm
 UKYNgMSPzkTS.nx5jMNTIAOSs.cbXWKZHPl25GinbBhA9y38D3n7hHG4aLzSbzKzJigXqHq373J6
 YMzelI0vdt7UQ6dqZnTdu.T.30AN_2Y_jQKj1IKZE1FvL0HlJNO6KNVvjpDZ2whLz7lyIA30n3.j
 qCOusfk5puEfeN6uJL3AVhcXMu9Xv50nHS51jaSCAJpfrzLa3nQZAWSAtfyx99hgFSXGUY1BZQAR
 Woze8N80O6Wuu1FkCaKIJn0hscqPj3TWNzXLF_4f7xGg0jh_iPD3VN5zzpW.fH7Th7Lu._M0mCbn
 WikQXWuy3OzNasT4S8evVi_g0NSymgt80WhP4JRHbHki_m3MeyEUdQlVmjhdRjp10C9nu9jYvJRw
 20HVa3_jadGSkfjEgUOl6B3ON_b5DzSwn1c81Ft9LzzqNrHLeohtjRA.E6NXzGJwtJootZif8qLC
 cvH9OApeQl3sIv3brnOIDoYfsyEqgCXLYle7MsPfuE.FOJyngAH2phE.pqbQJxXdUXI4Um4xF5oJ
 qYyTJsVLoN6THXyDsJ_0G5RFnTdQQdrcvfX3pSQ_RlAaLtpF9ik2a_YWdv4eIdl7zLeLu6u8XZHp
 MeWv4pXISGSj9jE_QrBX_ZX4GuUlx9TAyNLSRcc5TsrzDKg7y5U6TDS8bvzYCV.dyLslaWEaL8nI
 1Jffklurln0f7_mRQFvxjm3uVZ_g1svkRWdPbtbyTNwd8wvZPstF_VViYs4YqpyssN_3UpwATs7Z
 Swph_n6Bzv8nZoa8NjFi5pfhsBvNS.v6psLybVsMfu886AZngp_TjZeaB7SZZZV3hGdzAp4Nf6dT
 gePdNyIJG7MjM.iCBCBL4Vw1n69bBDM2FxQL_iGnHypO39R5oBIBY32378cEm2gAMAo_7VOcTS17
 rm.xcjKE20VHNdju3sOygmIHxRmzfn5OXQpEwY4IZcPb95gW8kz2503cNB4i.7.eFKJtQIA0sguh
 CROVcqDmYcs8Njd3jWTQfbA284ah_aWRf3MqRd50f_vGRIiUnWfhfUmRrtkyTYAjSflDIt3MEgsH
 2h630LUlpL7MjTjRCFyFxSSPeHZ3wP0lqcDsIhpdCd_xi1QV_hYxIZ0aqGX285OYucUidLeDgDWz
 nx5qUSpTYbOlTRzCY8EKP_d90nl.raWt8f7.z_UMpxIs0plLw96qgYC9yGxG68ah0PpSSK1dhmD.
 zPXG1K5Eio1Nvid6PJ5hSLUoC0OEL_p04FpdwLt.RwyOYVZVonaWw_N.nbCU74zNqa5T9JjIWk7B
 f5it1c4h_KEj17HDi1EAjVIYdyEXmEEDfklp2iherZiqx2ir6wvM88XSUYtvPEZn9S07x7zLs8hX
 RMgpFZS8ZRH6MrgBpndxYMQVgwnZ1IvQhJdvT6trDwP3f.zcgFdEAuXNMQv_5caHBDP0c2c.TV00
 8F_AmvDY7diAcmNxe6UiBpMASLOC6tTVrEUfWDDBHIlomCOLvoFGepIuX_djRrGQeOO8am0Uq_c3
 VQDpG9lM3QAEQ5DDepneixp98Bz7aWSQqj_JubhzqbCFtFuwsbvRDk5hU5yGhOAwGsCks8DBFeis
 pii3MdYsdjydY0NxbsUImzhPxcw58.rnrwyADUsx553UXnZ_qUjhNPHc7z0jgHandR9LmeWsjP6V
 NSoyub19m2rZE9bhXmnbcKCyEufcztkA96heZf.EpvCPTH6rx8PLXmHWQMEMerDLhBcbRqtX5Fmb
 LGiE1SsO9Uxumdczoxs4kDJm1bI08C92wXvy3YKHImu3COdSlK_v1HbHMoNz8RthUrsapT_fLfEw
 bb.xwqVe.qGPegsj90CPOp7QfaUVr35n6j.KTHgWH6CnA1G8ZO3D0xfjbo1J71IIj9N825nL4sFy
 T8oiHvnLTrBcdc7LrJIAL9aA2izFc.SVfVotwRvijfRKRONfHII1TIHM..bzSsD_ezPXcDTgMvhy
 YTIQ1Kzu4w7DigMtxBBrWjFnE58ic20e_c5X_TJI0AQZLmg--
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: d148b691-1abd-434f-8668-8abe1a695656
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ne1.yahoo.com with HTTP; Sat, 16 May 2026 15:31:34 +0000
Received: by hermes--production-ir2-89844b765-8tkrv (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID e383ed008e6ba98b8a171bc7f15063d3;
          Sat, 16 May 2026 15:31:28 +0000 (UTC)
Message-ID: <c30b6f95-8a3e-479f-92d0-0e3555250713@yahoo.com>
Date: Sat, 16 May 2026 17:31:24 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v4 5/8] net: dsa: realtek: rtl8365mb: add VLAN
 support
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Linus Walleij <linusw@kernel.org>,
 =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
 Yury Norov <yury.norov@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Yury Norov <ynorov@nvidia.com>,
 Abdulkader Alrezej <abdulkader.alrezej@gmail.com>
References: <20260516-realtek_forward-v4-0-8b6d6a1eefdc@gmail.com>
 <20260516-realtek_forward-v4-5-8b6d6a1eefdc@gmail.com>
Content-Language: pl
From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
In-Reply-To: <20260516-realtek_forward-v4-5-8b6d6a1eefdc@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.25725 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Rspamd-Queue-Id: B37C555C675
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[yahoo.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[yahoo.com:s=s2048];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288646-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[yahoo.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,nvidia.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[namiltd@yahoo.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[yahoo.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bang-olufsen.dk:email]
X-Rspamd-Action: no action

On 5/16/2026 5:46 AM, Luiz Angelo Daros de Luca wrote:
> From: Alvin Šipraga <alsi@bang-olufsen.dk>
> 
> Realtek RTL8365MB switches (a.k.a. RTL8367C family) use two different
> structures for VLANs:
> 
> - VLAN4K: A full table with 4096 entries defining port membership and
>   tagging.
> - VLANMC: A smaller table with 32 entries used primarily for PVID
>   assignment.
> 
> In this hardware, a port's PVID must point to an index in the VLANMC
> table rather than a VID directly. Since the VLANMC table is limited to
> 32 entries, the driver implements a dynamic allocation scheme to
> maximize resource usage:
> 
> - VLAN4K is treated by the driver as the source of truth for membership.
> - A VLANMC entry is only allocated when a port is configured to use a
>   specific VID as its PVID.
> - VLANMC entries are deleted when no longer needed as a PVID by any port.
> 
> Although VLANMC has a members field, the switch only checks membership
> in the VLAN4K table. However, when a corresponding VLAN entry also exists
> in VLANMC, this driver keeps both membership configurations in sync.
> 
> VLANMC index 0, although a valid entry, is reserved in this driver as a
> neutral PVID value for ports not using a specific PVID.
> 
> In the subsequent RTL8367D switch family, VLANMC table was
> removed and PVID assignment was delegated to a dedicated set of
> registers.
> 
> All ports start isolated, forwarding exclusively to CPU ports, and
> with VLAN transparent, ignoring VLAN membership. Once a member in a
> bridge, the port isolation is expanded to include the bridge members.
> When that bridge enables VLAN filtering, the VLAN transparent feature is
> disabled, letting the switch filter based on VLAN setup.
> 
> The use of FIELD_PREP for reconstructing LO/HI values was suggested by
> Yury Norov.
> 
> Fix for vlan_setup and vlan_filtering was suggested by Abdulkader
> Alrezej.
> 
> Suggested-by: Yury Norov <ynorov@nvidia.com>
> Suggested-by: Abdulkader Alrezej <abdulkader.alrezej@gmail.com>
> Co-developed-by: Alvin Šipraga <alsi@bang-olufsen.dk>
> Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>
> Reviewed-by: Linus Walleij <linusw@kernel.org>
> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>

Reviewed-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>

