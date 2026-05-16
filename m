Return-Path: <netdev+bounces-288644-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKcIEnWNCGr4uwMAu9opvQ
	(envelope-from <netdev+bounces-288644-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 17:29:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF64E55C658
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 17:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5C5CE3008891
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 15:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 854E23559CA;
	Sat, 16 May 2026 15:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="tUQBn5Pl"
X-Original-To: netdev@vger.kernel.org
Received: from sonic312-23.consmr.mail.ne1.yahoo.com (sonic312-23.consmr.mail.ne1.yahoo.com [66.163.191.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA3C33C1BE
	for <netdev@vger.kernel.org>; Sat, 16 May 2026 15:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.191.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778945392; cv=none; b=UAGRnrCGaZJGsdfLHDaewIY9+jxRbqV7WPTXJtObFqHDzaG4AHZF8QNonRDBbPj2dutYyFFcCox0WKhDbC2xBEopjECjB2v7yNr/3igE4Np0WKZVf7GCdCwIdBRVqvniwJLj+zv1q58KcjKKzFMEsPVB0MhgaDQ/g7Wlu4T1sMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778945392; c=relaxed/simple;
	bh=/CARwGY88hbYBkPKizldZzNXZzvAct6W6hUNyAJiXUE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xh0TXTmwiFv5OXk2H5WGySvBLC/gZtkHjhGAehlbWqjFFD8NYQorIxSGwWrT6oTE/EEX6Zm5RBY1/QQMOIsGLAPOQsm32lwheV8GYSAPfQwlw2jCQ4PoZjsvOAtm6ZE/p8tPE7DKYbXHJapeCsl1xW1hrfIzJFRVjsqiOJ6Z4UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=tUQBn5Pl; arc=none smtp.client-ip=66.163.191.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1778945384; bh=6yxwewShWRjIXWFXH3E6aLl29t968DReh1/7l+x7/s4=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=tUQBn5PltWwREA2PawLSyCFLYQXint3qqoitePmH097qRsIAqq9ifmp+o9AnPplQOrKu4F6hYxC5JfxrnoGc/YpYMYujcIAZlCgNh/t1eHY9udTOXKG0sDWgscfRYTVYWRf44kkWo4YHGZ+8gIy58QlBBOveRNuQIptFPUmt+9XeefuRME3tWGeB8iRx6m+76cLkCPJY3YE8IXJSE7b8+4uWwVW6tqKIy3ee5oegXOu79ZBRnz5rnxcDfkIeBJ1HEMl6R9MLOAbMJ3gDcshVT7uHflYceBYZbSfiVrBnBbayJZ4egIcCJt8SPzbIaGRtJ812U1b64oscPfKLf86PwQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1778945384; bh=DGcufVS11v+4peYO75gMNwHpDdvkQy2kIBH/2RKonU2=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=nZQAXBtKD9WyMwlr2B7brEiL7Wy2vsvhSjR71ygGuioFT8v/zajkzXmdLQ0ZH7cnVIlTH12Fez+ZJX27pv7OHTE1mb32V+DdscW70/QRZoxjt32gBtvvodNK008lnl1pgZA935BSYNH7DCG/vmjqpflCE9E8FmtmdlhsuweSGSPw4UaRvyopw1IkV+/zEqBmr/s3cU6LnQegiFAf7AMKIFFhfFZhSI9Uf0IHQov4A7mirNKCXvSyrhGwNMapm9mnmYxPt2aZs/V1Bn+kObEhzJub1KxnQdOMn1gxPhtwryqmV4uXXHkk5WwMPnj7J93TTxtpXsx1TMnOhxKqoV7Zqw==
X-YMail-OSG: q9gGsoQVM1nB1bOcF__zx9cf_VgOP8c9KFJanD7DwbeEELo3MbxvimGUb_H4xkD
 0miTHiDwkhKuox5ASQzmMSIl_EpGG8cEpiIJuo1qQbQFYLM4zUoZtqzw2PYdCTiBgXjPxXAzwTCT
 ujrzJPnMAaE7ZS2hX7_B84dWRquO.Bpn9R1V8X3Nmqc8mgxc6WZ3HyI72VpNQmhalBLS3PBLyy9m
 JGhyk5hFIt5rz2s.IunWOBnBtIMd51kVRnh11Z4qI_IKMxXJQQLlpgiGunP5Me7vgEFOAFq35oub
 WSClEx080UEdx5GQF6m8dRiegM8DHKDB6chbs_FLmp6RoG2V_sBE2AEBBDTur0xSzNh8gWjGsZ7f
 h9OfnTZNKYUwdVOqpeeFDoo_Y77YkMe2QFj61opNFz1VgzbsphQh1bMTW_2.sLeQ5e7vCZjP7nze
 jq7pSGZla81qI9kR7v4Pi082Qmj_d7CrMsuwSMKCy2WcInV1iMq4slPKRZ.P0V4irqU5A3O_BlBI
 QXZyFwMGBt0sUIIjj_UZ6eU.ntCsqT9s9rM.yd8Plx4rZEqtWUX0ain._NeG76rvezAGfHGHePk3
 p_WwhRfKQ.0N4GkOZrEklwlOkaKRZ1bWr76t6TLK6I5fWVDobCZ3LoXRAWVUTjXsXsIKUUjUXLHZ
 4xkdh8AH82rXpBVmBg95m8Q2qQO02YkJQFT1pDMR3qPKDG8JAGsdA8DxaKX5RuZ_CI8bvpuBsSwa
 dN_p0ih8oWE_.EyKz27o.Qa5CVo1MIbuba4ohJ7Jydt4jAqtl9YDcLYdgraUZz.Xv2Z2OlgET6IS
 9GKfWSucGAes24tr6eB6Ly3SjtiVvuPMFKEE5gv8okx6Y.r.MLkQttLmtwFulR0ODm.lWkxPdQV_
 SA_nxHgyo7UqcrwgerTVJWKI.mpzxR_OB1iMETnOSF1X7hZM6_sl3yZknZwfLug8iVthsElwVP1C
 2BnrZX7sWWRovYmHdUk78_BzZuxIRfUqZuWbkOHRFb.crSrnAlOuUFuI8JTiLnpEsFTyytG9lwZS
 g6M5LQzpxiWxTb9_dBiu8p.oMo3fFjGCsswns9hNCjZlKUFwJXFoi.R2dT7ChrBNlp.Ocuhynyxj
 u.VQ9hWmGTrV1KqydV1P30QMt7aDoo_XGJxWyTv0ngCrUJajlJpJqcRto0L.RRa0n99nNKe20EMa
 a72Hc5TE4feTp0hM1qH_TkMT7buoaPMNOdguIkpARwrYfzA7lEndPC27SBsGzBcJU2HGm1bJHSI0
 ar3rioLy2zvJBLkk8mRIjppfYBah7frMcbFL4ItfCwEhugMxE_URUWnTVTje3ZJ6PTFaaQOrfH3t
 KlVmYWvtNa3bIOr3T1WEIVdLktd0u5oMYDauECJbeC.LYRzRw03C3daQRWNvlTIZKt.GalxYh7ev
 gBB8_L_ZBckugTz5O9G.k4lNkNl_PqhUtMbxUoFvlf55hsqB4.SBlL.5iKu.IBBzFl9dE6KAqoGp
 aQvSMmuek.O5mYxPhOsrXhkGX0A_vAtkNY4U9Ha7TmWlWFq1ImfNN2VKXvIMsp5nY4xVT_HltINc
 92oK0JeKNsgMLJbQlhTK9_10AtoanGfmdDg6FGSyzu42pSxwbkqwEjx3UVSS_50rZtRLBqfFn.25
 2tlIDfOwTym.PYMp4EOHunFgwnTBPTRc3Wnn7p4te5NuVbZoIj12iFKXQpgpmNTGt8Oa7O3Ikmaq
 aVYuWvsp4S5SazbpmE03mXK_mpuVcxAnXoINj._YkskvVjegaL_33GAmfDzHYJr559eRJ2KREM3j
 yj5MT8xtL2ZC.fo4mkaxbH72ySnnhLWJ_7zMCDt4SdxIqy9Mw.w7WAb05YHS3Y5UdNUV1GpuTOoN
 v7F4GIk3IMogqjfMtSygo9NjZm0FgUBPt5TJcJNg4NBg1eFgbXIp2ks6Sqy0t_ZI_vdyLZ8KEfIH
 fIQHg0_ICdWy1rfEK24RJjv1YU_BCIWDPd9s5PaEqPKMRITBODjIzl_04xLJhxEiZ37rqiSQil3F
 eu7SB2rhaHRD_2VY8LKb9Mkj5jJRKd4ymUClq5o6dZLcXFNXcKloF6KkRilQV0Ba.5lsoBghmq0f
 K4YSgyQbWPdnvvXqC8CMYVZbGj2ksK_y4PM83XQ4f.5WYoOvivbYk6IsaVPewoWCZyDJ4oenb0CC
 8QVc5rrEau2ysn.YgKfBq6Drb_z85CWopS7MfR6yC2GhPs3Oio5h51QkiwNwDB1SRrXvb3KQjQmK
 vJNk1.c3vpRcRC32YjCC.DfhnTSXLhQaXpzYyzdGSUOuUTNn_aA_jm5XQj6x0I5VW9gi4AU9wC02
 _p19NVUHj1ppNhqvESCf1YosIWqLX4_q.2ls-
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: b88af161-7689-48ea-a1b7-81c2b1ac3ef4
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ne1.yahoo.com with HTTP; Sat, 16 May 2026 15:29:44 +0000
Received: by hermes--production-ir2-89844b765-j4kkl (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID df374cca5b665f59e96dcb63b0d61ee2;
          Sat, 16 May 2026 15:29:42 +0000 (UTC)
Message-ID: <bfc07fe3-268a-46c1-a186-0f3a43bd2a34@yahoo.com>
Date: Sat, 16 May 2026 17:29:38 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v4 7/8] net: dsa: realtek: rtl8365mb: add FDB
 support
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Linus Walleij <linusw@kernel.org>,
 =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
 Yury Norov <yury.norov@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260516-realtek_forward-v4-0-8b6d6a1eefdc@gmail.com>
 <20260516-realtek_forward-v4-7-8b6d6a1eefdc@gmail.com>
 <03d0fc52-108a-44de-b22a-6bf4a2d9da90@yahoo.com>
 <CAJq09z4nEe7sLeSqOYjq=B=mMjja-W9=99+O6wHwQ6an91wNJw@mail.gmail.com>
Content-Language: pl
From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
In-Reply-To: <CAJq09z4nEe7sLeSqOYjq=B=mMjja-W9=99+O6wHwQ6an91wNJw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.25725 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Rspamd-Queue-Id: CF64E55C658
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
	TAGGED_FROM(0.00)[bounces-288644-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[yahoo.com];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 5/16/2026 2:47 PM, Luiz Angelo Daros de Luca wrote:
>>> +
>>> +struct rtl8365mb_l2_mc_key {
>>> +     u8 mac_addr[ETH_ALEN];
>>> +     union {
>>> +             u16 vid; /* IVL */
>>> +             u16 fid; /* SVL */
>>> +     };
>>> +     bool ivl;
>>> +};
>>> +
>>> +struct rtl8365mb_l2_mc {
>>> +     struct rtl8365mb_l2_mc_key key;
>>> +     u16 member;
>>> +     u8 priority;
>>> +     u8 igmpidx;
>>> +
>>> +     bool is_static;
>>> +     bool fwd_pri;
>>> +     bool igmp_asic;
>>> +};
>>> +
>>> +static void rtl8365mb_l2_data_to_uc(const u16 *data, struct rtl8365mb_l2_uc *uc)
>>> +{
>>> +     u32 val;
>>> +
>>> +     uc->key.mac_addr[5] = FIELD_GET(RTL8365MB_L2_UC_D0_MAC5_MSK, data[0]);
>>> +     uc->key.mac_addr[4] = FIELD_GET(RTL8365MB_L2_UC_D0_MAC4_MSK, data[0]);
>>> +     uc->key.mac_addr[3] = FIELD_GET(RTL8365MB_L2_UC_D1_MAC3_MSK, data[1]);
>>> +     uc->key.mac_addr[2] = FIELD_GET(RTL8365MB_L2_UC_D1_MAC2_MSK, data[1]);
>>> +     uc->key.mac_addr[1] = FIELD_GET(RTL8365MB_L2_UC_D2_MAC1_MSK, data[2]);
>>> +     uc->key.mac_addr[0] = FIELD_GET(RTL8365MB_L2_UC_D2_MAC0_MSK, data[2]);
>>> +     uc->key.efid = FIELD_GET(RTL8365MB_L2_UC_D4_EFID_MSK, data[4]);
>>> +     uc->key.vid = FIELD_GET(RTL8365MB_L2_UC_D3_VID_MSK, data[3]);
>>> +     uc->key.ivl = FIELD_GET(RTL8365MB_L2_UC_D3_IVL_MSK, data[3]);
>>> +     uc->key.fid = FIELD_GET(RTL8365MB_L2_UC_D4_FID_MSK, data[4]);
>>> +     uc->age = FIELD_GET(RTL8365MB_L2_UC_D4_AGE_MSK, data[4]);
>>> +     uc->auth = FIELD_GET(RTL8365MB_L2_UC_D4_AUTH_MSK, data[4]);
>>> +
>>
>> The problem with overwriting uc->key.fid and uc->key.vid values in the union still exists.
> 
> Hello Mieczysław,
> 
> Thanks for the review. Please note that rtl8365mb_l2_data_to_uc
> operates on the unicast structure (struct rtl8365mb_l2_uc), rather
> than the multicast structure (struct rtl8365mb_l2_mc) quoted in your
> comment.
> 
> For reference, here is the definition of rtl8365mb_l2_uc and its key:
> 
> +struct rtl8365mb_l2_uc_key {
> +       u8 mac_addr[ETH_ALEN];
> +       u16 vid;
> +       u16 fid;
> +       bool ivl;
> +       u16 efid;
> +};
> +
> +struct rtl8365mb_l2_uc {
> +       struct rtl8365mb_l2_uc_key key;
> +       u8 port;
> +       u8 age;
> +       u8 priority;
> +
> +       bool sa_block;
> +       bool da_block;
> +       bool auth;
> +       bool is_static;
> +       bool sa_pri;
> +       bool fwd_pri;
> +};
> 
> As you can see, there is no union in the unicast key. The hardware
> table entry has independent fields for efid, fid, and vid (though in
> practice, vendor examples always show one of fid or vid set to 0).
> 
> The multicast entry (struct rtl8365mb_l2_mc) is the only one that uses
> a union for the dual-purpose field, which is interpreted as either fid
> or vid depending on the ivl value.
> 
> Regards,
> 
> Luiz

Reviewed-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>

