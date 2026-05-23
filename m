Return-Path: <netdev+bounces-291052-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kH25H9RWEWrxkAYAu9opvQ
	(envelope-from <netdev+bounces-291052-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 09:27:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F067F5BDBA5
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 09:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EF182301A41C
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 07:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816D334403A;
	Sat, 23 May 2026 07:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Lm3Bhf17"
X-Original-To: netdev@vger.kernel.org
Received: from sonic316-22.consmr.mail.ne1.yahoo.com (sonic316-22.consmr.mail.ne1.yahoo.com [66.163.187.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C052797AC
	for <netdev@vger.kernel.org>; Sat, 23 May 2026 07:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.187.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779521233; cv=none; b=Wk+LfmtjOpt6dmMuGnWk/xKCeIDVadjMjJSDiAInNp5/Rfxk8ueOqcG2PI7UCYEMvh/OMCJzCb3zHmovglldV2Ia8VM7DDHfLW1/vkgSupzFpHiSHSKnw9jYuyIgEIqUhykR97MdFmBQT7ITDR4JN1p0d8Rl/bd/sUXI7xcHhZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779521233; c=relaxed/simple;
	bh=rZkxZ95gt/FpkLiA90ABH0Ta4XQFOOSLgueMerhnlbg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VS89Qz4TWHHgJnX/8+PAhkgyldV/mBKgAgVQoYqAd7Hr+cLwXWje2d3S+I3ox3lBIj/fe9YW8bL/jd4FtM/c8aWosolhDaXbxypO2jEZ9OfrZpH1J789kI/plY7oQPyMgCrNmyUunSkcDm+AOIU3WPXotc280shhmfDtEVwkm1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=Lm3Bhf17; arc=none smtp.client-ip=66.163.187.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1779521224; bh=jUSqYS9G6tzR0e1cNVefs6BFu190yPK+IEIP3I1EWxg=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=Lm3Bhf17Av7/uaqJI3MYIrO7SfFNHLruPGmKNHG3OmNynMG/gj1B7N5kPkc7LNA4t/iMEjsVMFepiSB4b/esyP20yW714pnFzc/k50HEbmFta0tW+rzsOgz150o3zKiby+95yzzWfO7iiXZxYhG9Q05QPmi8jdSzpZExl+fECniIP8nN49W/a7j+AvcprS8MrpYIXaJPDlpk0dXCH7Vc6kK0kyFMy/lI82mccWf/id5V2a0SNJc3Vqzfzzgq2M/rusM1HeHyimhAR2l9YahlJFVogullea1eAjLcr+oUcwNdnoiItJVkaX63Mkh7fZW1a7go6H9qpHqPfAKYMBaaaw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1779521224; bh=dQTBkmsgbwLJ5T0aH0wYmY1mAeFTipqWlNnedGrq/FC=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=dBcRJ2lKtsXFjH8JgyLqEVboG6zvGift0by4acr4zhfpUrv5EPF8aZW9YO070zOfJl1SkYjigXAVezHYeblQuNsrhDnKHs2F8y6D3/8QhHPIXFTSl/5y8jAnv2rgPLfO2V10Gg12wZR5170TzSTLHAZTmcT/OgTfSXOZPS03lUfSOBiJRvDr3aQtD+2HfHgdy8poKlsGoO38/+vFC6rWWbZIt5qE+Ro/rpreL2c1y1T5K6wfbxYVzOIuTOLkmJU0L3EOiIni1pd42mbca0mNPfjkhCVaPl9bM4PMmD8eZa1kd8aBNSaCuWeoFyaxT79H28BuQnC+rqFnWMW6pHqocQ==
X-YMail-OSG: fBU2qSUVM1kVjzyJi71g_sbellqUf9sqdsqVpAfAqYaGehTTktK9Lwy9mi1RZZn
 5.84yOGndKXn37GnsAjP7PocWB62Zo_aIQv6cKPcgA1UmQE98FXF99fwDJNTLqUJF41oUPo_Z4wk
 eOcTK36W0MAW9v2mKpmEHryHGjTmwFRFi94potrxSwNhMpWwygFoMyk_QqMv2etlQE31b.4CfVt.
 lls4d.cvFHSR4dtI.5mjmonYe6Uq3v9TD0ekP6v4PxkKC2naY5zeEcaAS9A4G8nPR.GJOPnDD8Cg
 qI8GlPfZU5VyJKnp36rslvXFYKtYXI2VOQgvsmTT5Di8iY3P4.okabSRPmTjGXWZTATg21KyD3Kv
 Tr.T5zCGhcPYhcRvhrZdd_oExgUWYs4bDzV1r0zIXP_mJKO1pYMkEyjroJ_gU.1cElk0.N86VuIH
 o.zgQZK4r9xQafPCfmOuu4GvpULsoAaBHaQzKceQbIgOii.b.K.KAfJABnJq_mvgnypta8BiFLLf
 N8HVrrhn9pvdw8QKyIPDokoQBs3iPB0lWtwyvEDNLxdlHwJdewM530mI4jmJAP1wIgy3qA7Cg_4Q
 1MNM0FDAIuF55uTEw3DmWGtqX1Ta0wFo6m1uzVu2GGtqrXN3fQaaGbAaAeQuR0hmBRvWOoa9rtUA
 LUn2VlDZLWm0QT3v4kUKkEs3wv2dICvIf4KbgTK0LqQ08nVQSJ98RcHygYQ8rnmj651EB1anX.FO
 PMPECVXC_OuXyK.0BBupPkcZh854u3mbHZTqwpw_gAi8IzDxRCmSAm3X5XfJTF4t800skQ4BVkIr
 o6Bm7aIcUTXT.gQCVx_7l7Fx4gsVUw7MfzZGxI9SgBJSDDuqnAV0TzPolyeAdG5idp4DHP5sxu_D
 jfJr6v3SZIEn2gi3XJMGn6BUfP0y5ydHnY3jIpAi0P2OMRsNid3OftpMgpBjDI24GxWWMgaCTabs
 zy5AOd4blPGmrtYwldXaAKEZBhk7f0aO2qAK_geUGxEb9kPzKP_kzO1A2NwT4L2Iupo4lgXSyNyV
 IT4R8lE07_EHSw.ZD_.AfmBO_OlcP7ZtElzYXSxDLCKdBQi4yiLRG8w3uiido2opT0CZzitiun8Q
 jGzA2aJOPbBW1iMO8KaZo_RVy3APR0V_DuLAfxfZii0_4BwTyOS9n3v9dgVPnUHMLtznVwvyBGk_
 MkFOjFEg59qZXhGQHpxycGlmrYHGDZSAK_5SDvaGcw___4hO9fV796haiOfLkht_VWspU55DZHlx
 WkPXpOKN7OXL30inZcEaHmTuxiopAmy8RA4yGQC0JiIFJxTDbwg2pnZOKTms1PDpO30NP0TEIKhu
 cA3ZceLTEKwv2intJ80SW5LMM8.MvDUiyUNvsnCfWjfdFDBnzrdJR.tb3ALsFN8sZDedrsVgrZZs
 rUtJ5ehXHNdRNsCZ6uP9.EdO_Y1yKlgbtLcNxWqyG.0.5_nNYO20wP5ZpILY7sMjyRyr0sEqIIie
 gtqTBMh1ACW1g9fLEWiy_UKCsJX.XeCwyZwBbMq7Uqo9g_3Hv44IMfIrrCiBJO5hQ6RLSVeunbmP
 nUNoctYfqGotchGJRxXfYW8wDGSrf3O5HbytnjAcJxMswzIxbgkcG5gUP6Kd0joTVGf_HZKeTJAS
 YhBWkIKHWuEHwTKgMIb75nAd5ElgJ12octI8BTMAVgZMnyhzdlcEH5.Jkedl7CXyVUvN2yQ3wL6i
 kHxDLjfrxPD1YPsGs6OM93SLrVgBmXp4ICV9D0hSl8HeInYNIJEHJF62GcN2HJLEMHOZJ2bOjnlz
 F45w5FEU9JqInrJIECVXmPNUtFpxeaB0uCY4aXJAvs0W66b90MYeRG4E7CFp0V6YjVyXtsl1A8e.
 FDIOHIb6pAQ1OrPmHv3Lilj22N3AJonvS93LNQK1nwvafCenEYNvc4F91EqAHnZLavGWHk14Q76m
 2jx8ENeCo.A66xs0Q711mjqiOQrZcvGAPoZ32V_0E1H1FQGQdVut1fYCmvbWy5mcsFIaWfJbxRHW
 novZpItAsQbSsc3pgS9LVH1Y7yvBVVV5PkEoUQzZ5scwSvXw0S0M2IaliXMhZwCSeT30QMXyaOS6
 B1K_ss.ZSp7oygSDz.8slGia3ShewFzJ9che8lZVPwZHtfTJZISSsezx594DS3rT9jbTqJQZ_qxq
 6FQMvIYPFyfoEKKzF4O7gpgaazm4X_2znZqXTdZq4cMn2JJlMDUSjtTOH6AMmOJ2bgbKcnTEl9zH
 XI4OiEsywBSbbhmGST1FXYoi_zfjhNrZvCx9WM_fjlTY9d5YPIMv0YhybMiMudqXnBGYbW0P46jw
 RipeE6WMd17EQt02E.mURe0x7wgHbeW8H
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: 31b68497-b2d1-4dd4-9474-801732bafb34
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Sat, 23 May 2026 07:27:04 +0000
Received: by hermes--production-ir2-89844b765-bdgnn (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 61e416b66dded75f0c1de66a03ea0666;
          Sat, 23 May 2026 07:27:01 +0000 (UTC)
Message-ID: <2d4c5723-9118-4a45-b7b4-d76958835cc9@yahoo.com>
Date: Sat, 23 May 2026 09:26:57 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v7 1/8] net: dsa: realtek: rtl8365mb: use ERR_PTR
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Linus Walleij <linusw@kernel.org>,
 =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
 Yury Norov <yury.norov@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260523-realtek_forward-v7-0-313805e218f3@gmail.com>
 <20260523-realtek_forward-v7-1-313805e218f3@gmail.com>
Content-Language: pl
From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
In-Reply-To: <20260523-realtek_forward-v7-1-313805e218f3@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.25725 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[yahoo.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[yahoo.com:s=s2048];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291052-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk];
	FREEMAIL_FROM(0.00)[yahoo.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[namiltd@yahoo.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[yahoo.com:+];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: F067F5BDBA5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/23/2026 7:55 AM, Luiz Angelo Daros de Luca wrote:
> Convert numeric error codes into human-readable strings by using %pe
> together with ERR_PTR() in dev_err() messages.  Also use dev_err_probe()
> instead of checking for -EPROBE_DEFER.
> 
> Reviewed-by: Linus Walleij <linusw@kernel.org>
> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Reviewed-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>

