Return-Path: <netdev+bounces-304589-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AfsOIX3RR2rufgAAu9opvQ
	(envelope-from <netdev+bounces-304589-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 17:13:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8156B703BFA
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 17:13:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=yahoo.com header.s=s2048 header.b=L03jyNav;
	dmarc=pass (policy=reject) header.from=yahoo.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304589-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304589-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5708C30015B3
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 15:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48AA73D9030;
	Fri,  3 Jul 2026 15:12:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from sonic316-20.consmr.mail.ne1.yahoo.com (sonic316-20.consmr.mail.ne1.yahoo.com [66.163.187.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D3A3D25D7
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 15:12:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783091576; cv=none; b=glQ0YMxsjhi3cqV1ZiB+gtcKEh1c8lpj0i8wwJSx8cxkKwK80bZyVcwq9oWTOY7edfrx0PMNmZYL9HOHUMkHqlUoo+nCmaXk8axIcmSPkYpgRPS5wIuiyiVRCj7HV6/gngQfRd8MbhIqA5eEuUH2/RgQSrVNViy4hcCm13lIFng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783091576; c=relaxed/simple;
	bh=1nV1CcVkDS8/9nhmlH4kSZSbOr73OqMRtLvnQYAmekA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pbKEafMVV55yEV/zdkY+O5F633bvvQMwqIv1H5OnWrfmPPmzKk23xRqV6uYYp6sR0yfO4FYUJTdxP1VRclEYnhJphF7J0Ed+xVh5CtkmRdDbEUUZlGfrBQhOMiWS6cyezEzyk9OIxVUjBycVNUUGj+d4cfElE2swl+WLLk0TUQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=L03jyNav; arc=none smtp.client-ip=66.163.187.146
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1783091568; bh=k2+PFBwefhXzIc8LwpDoo+civaTM3ohkE8K6ZsUoi4o=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=L03jyNav+62ZAyiMaG3bAvz6IJ+mxab91BeIUU1jlNfLW4m4vfkUEZS8pS1aRHXkTV52w2FBXxx1LNYvHvYa++o74SR935Ru9psZ79LjU+66P0qMpo/hDop/dNd9ygKhWp8DmzKr6enK8b4zBAFTxzNzCL9LkI9KcIctJbAj8OOg7d5H1MX7I5brf5S6pjZjQu12P75VKBuxvrrQYStmrFulIWSJRGU1q0RSMAq34FlA9Rxw3otGbooKFvNdQqFos3PRkxtq1tIwpsUR1SfWdY9dYWGZUe9zZxNmi5GwPeSP+UxHfmUb6jEtXPKLMnq3mrqb9aIVd1QidFMyDFAwiw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1783091568; bh=Itm/CYhzmu6oo3WvrFgWGnbzzSlpjFjdWjICkL/V7vG=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=sjUcjWoDIcHwLh1THDC/IJEJrHHTbKPZYyIdCqZk83n8oSBFCQRixvk66fhFw5ch6zi+BHsPbEvJv534iZKd3DraOxOwC14wQk9a6VDnKS7Fed0EX6yB5EQ8n9qwo7jslggdPbRAqU6RB7VBhuanVNl31qVN92pSugN6U0lfHgslFndoHcQUQi+Rcjl7aIQDTc+HyVe/hQa2D+YDiO4JSX73D3IOha5RZWM1qzs8Eo7l6o87V6JGwvr2TVnRvsh7MOI0Tpx7nRFvAWQCrXH7e9An9cMH+lLYaOzlSAUUe6PXrAieK6eFlWcZNzq6mBsk31jKEgxAtZ4dEOGPUOIuwQ==
X-YMail-OSG: NiLQrhIVM1kLFppDuoPZcbcy8s8jgx1UzZwdNsKOsinC9qRaKdUbxUrzwuxSchX
 Ov0N.l44pdtgGh0BDm2Cv2kt45HV.j.QS97t3oBLXw_ErjUcnxHQJwoVYPlPqvzYfUx_W2209H8Y
 sTmjo2r2MVwyOm38hQSY3EFGIJhuZfhq2ReIr99tUgDe9sC.l3llEA4stRQZHqKe5OLfeKJUo.w5
 i8XruPRCcSVSf2gdzSm_ASCsPt3jLAaI_BIPspVBLr3MGtR4d.dIyVuvI5mAccCLl.XNHvUOGM3Q
 UFB1Aw6Au1.ICbMhgMtjYEXwHVBqFfWKCw6.jxooeChTr.Ii.xqz1Pm_X3ny1iTAvhfpz6zRgEmE
 s416cYNmmswQjIdMfp0w0z8vsE3RCnWSCRedeUYruJFKFn6r01ww3xZ9CJvjmubOoTZbrkHMZnQm
 _bxDbnOgjt0YVF6Zp4vVAPAmy3_bEQmjsmmQvSqH_NmRRcS_3YG4a8Ql8TddxX.tPm9_fdmz1mA9
 z2k5Fdf__uzVpS.mi3USTZPyaO6okuWJC9I5yIjCaiHGRq81aA.c85_t4ST3Seh8vmBl2o4v9EPg
 YhPMlKGBA3I_uDYLdq7r6SzFdkRw4E8GGPDK57mt6gZR__FD_ODMhy6nEje18As7rFj_jUB..Of2
 a6sSDd0EnoO2SSNP1mKOdWEK7uZg4iVA6JjH2_ki4F14G8pO4S4HloJK1nxHI1GlzhW936ZZkNg6
 cVfsyPWUJDeRVljhEUsJCjyzexpvUCN1vJwE6LSSBgHjgveLl6ojfeP0usJL2f3PaR8qPxTNRi.J
 ntHZWi0dR7ut_j.39cUFcaYEp6gBhnkXkEx2lQ2fbIDM1NcRqlTEuG0pjq6DF0pDBrnPmdKY8eIb
 hA_7aETa63.nGdDCQN.j5_G7XiHvueZIKPSoV7DPKOiv49HGUys2fm.MdmpJZQiMQsCKbQtPE4fh
 pjIzvB6RqXCiseffmtzGLfmrgqto1f_t4_Htr9sV0d4YvBcTYqIBcc_wrHRocblJg3tc5Ismjd2O
 LALMk1N0EvdXObw8wpaA2kQGu1AAy70WrVPDxr36_rwcSTKR13OEYXN.AAAp5CfBZYCeWRsyz.3_
 qZIxSS2oq_SWY.UHBsu8XPSz2.00KDxwH.5pAp1OxlMlduwnKwhxYsQG1c8F6ycvgGq61tg48xty
 t6l1JpFa4akiQC4Vgy3OeEazp8jFQuiXoDOkTGLwILmhXP1r3UVFFJufNI4B8BcgAlGjwwa_CBGE
 LcPG7Z36iAQ2bJTmAo47JA5I6lPjWiwPkLINSqlyBsPB8XWpEZ8_k5FOn_zX.krrproX7f_kL6IR
 bF3Px2wU3mHhCTK7SaKKbQw4Qf6_XIZGuucDeW446XuVFo1rt6PvkV96922QIqRRcKIwdYlHMfIu
 Hq_3V0HD8YYpDcy0GUalEq4CRrRVGv7WoXGY9swAHMj5Hoze26hzjgnkMBccN0RvZCccm5f5vSLW
 7K0M6l.MrE9lBq22H0d6MYgZ5.l1H6BcA_ifN8p_bkAKmpik390pWnoN7GUGNiC2TTlGorzWygV.
 uA2qKtd0KRQrARa4t3X0DokgX.3DlS3BipeioOoM8gVa8fa32ugaIvUil40sACcI9dAfXUK7xuj5
 LAKqVLdt2W4CSl10QxMD4rSLGbJiDdtZv5ej8lvM2i3EYvJc0IhxFuZ.Gx1e2e9RSMTDNSshj3xU
 QyQUv8LWkURoUbm.Hb.ZlMkyPAmXmxEC02_rcffGek7e3aRfK1HvkqbG_CYzur0c_64xReYHP0o9
 DWknm94sv.e8LXRe6o_ESvb68JgBKZ.SWTjFW3.Ys.NXzW7SX2SA38JTMfJzkJItWhlSBNQOGWoA
 afK_WuZ1xyRJQKF2IGV8Zd9HdCau5PZB9k79qlt2XhsmpkqlUpdfEyVl8kyIOXRGjraj5ayQqa_A
 m.HE030PL2u8xE3zmPnyaWKaWbn0FX4UDfLhRoW9Lpg3HA5JmOJE8l8.rT5IimUeM48ERqEDGOIS
 THP1rNq95c79ZWiUOyNaAVl3sMII.a94mcF6Q.a8lSr5Ir039K1iUqw8kfP.Wf5fDT93XttY.0GG
 _UxCMjmk_KubCVm2dI.hQqeeeBG33COKZaVk7D9jbAbf22ogkkNmb1Y9zRc7H_LW4CcNlbWbOqiv
 I5qEUyeWeG4n_E5MLY01ZQD5Ai4qAsikB7y8n2tYmMIhYyOl86dBLY1wstwoswIv_OjYJpeAe6lu
 x_HujpUmwCcHeT_DhY3AhP5B8DqJlaUlmaK3ZI8XqdDrDJLc2KlnPrNKv0KD0z9u2vmL.5PkF5lZ
 YEmnBE42yeZNLYy8E35Rje9JPhYd5_7Pm5GdzVDQ-
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: 6c98f731-2dd2-4bce-ae19-b439d3707459
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Fri, 3 Jul 2026 15:12:48 +0000
Received: by hermes--production-ir2-7b48fcd765-cq95n (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 76de314da11aa4a7ef01b8e45f7e1db7;
          Fri, 03 Jul 2026 15:12:44 +0000 (UTC)
Message-ID: <577055ac-9378-4d43-9ff2-1a1dd17ae9dc@yahoo.com>
Date: Fri, 3 Jul 2026 17:12:40 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 2/2] net: dsa: realtek: rtl8365mb: add HSGMII
 support for RTL8367S
To: Johan Alvarado <contact@c127.dev>, linusw@kernel.org,
 alsi@bang-olufsen.dk, andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux@armlinux.org.uk
Cc: luizluca@gmail.com, maxime.chevallier@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260702204648.276112-1-contact@c127.dev>
 <0100019f24962e49-10163ad6-22fd-4528-b8f3-75703cfd80dc-000000@email.amazonses.com>
Content-Language: pl
From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
In-Reply-To: <0100019f24962e49-10163ad6-22fd-4528-b8f3-75703cfd80dc-000000@email.amazonses.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.26086 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[yahoo.com,reject];
	R_DKIM_ALLOW(-0.20)[yahoo.com:s=s2048];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:contact@c127.dev,m:linusw@kernel.org,m:alsi@bang-olufsen.dk,m:andrew@lunn.ch,m:olteanv@gmail.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:linux@armlinux.org.uk,m:luizluca@gmail.com,m:maxime.chevallier@bootlin.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-304589-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[c127.dev,kernel.org,bang-olufsen.dk,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,armlinux.org.uk];
	FORGED_SENDER(0.00)[namiltd@yahoo.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[yahoo.com];
	FREEMAIL_CC(0.00)[gmail.com,bootlin.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[namiltd@yahoo.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[yahoo.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8156B703BFA

On 7/2/2026 10:47 PM, Johan Alvarado wrote:
> In addition to SGMII, the RTL8367S SerDes also supports HSGMII, which
> carries 2.5 Gbps with the same signaling as SGMII at 2.5x clock rate.
> The chip info table already declares HSGMII as a supported interface
> mode for external interface 1.
> 
> Extend the SerDes PCS to handle HSGMII, which phylink represents as
> 2500base-x:
> 
>  - Select the HSGMII SerDes tuning parameters and external interface
>    mode, and mux the SerDes to MAC8 in HSGMII mode, from pcs_config()
>    according to the interface. The parameters are again lifted from the
>    GPL-licensed Realtek rtl8367c vendor driver, and again only cover
>    the tuning variant for a non-zero chip option, so the mode is gated
>    on the option probed at setup.

[...]

> @@ -1264,6 +1279,16 @@ static int rtl8365mb_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
>  	if (neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED)
>  		return -EOPNOTSUPP;
>  
> +	if (interface == PHY_INTERFACE_MODE_2500BASEX) {
> +		sds_jam = rtl8365mb_sds_jam_hsgmii;
> +		sds_jam_size = ARRAY_SIZE(rtl8365mb_sds_jam_hsgmii);
> +		mode = RTL8365MB_EXT_PORT_MODE_HSGMII;
> +	} else {
> +		sds_jam = rtl8365mb_sds_jam_sgmii;
> +		sds_jam_size = ARRAY_SIZE(rtl8365mb_sds_jam_sgmii);
> +		mode = RTL8365MB_EXT_PORT_MODE_SGMII;
> +	}
> +

Johan, looks like you forgot to include the scheduler bandwidth bits for the CPU port. Without this, HSGMII will still be capped at the old SGMII rate limits. Something like:

#define RTL8365MB_REG_INGRESSBW_PORT6_RATE_CTRL1	0x00d0
#define  RTL8365MB_INGRESSBW_PORT6_RATE_CTRL1_INGRESSBW_RATE16_MASK GENMASK(2, 0)

#define RTL8365MB_REG_PORT6_EGRESSBW_CTRL1		0x0399
#define  RTL8365MB_PORT6_EGRESSBW_CTRL1_MASK		GENMASK(2, 0)

#define RTL8365MB_REG_LINE_RATE_HSG_H			0x03fa
#define  RTL8365MB_LINE_RATE_HSG_H_MASK			GENMASK(2, 0)

[...]

		/* Allow full 2.5G on HSGMII CPU port: set scheduler
		 * bandwidth limits to max (0x7). Fixed-link init-only;
		 * no runtime SGMII reconfiguration is expected here.
		 */
		ret = regmap_write(priv->map,
				   RTL8365MB_REG_INGRESSBW_PORT6_RATE_CTRL1,
				   FIELD_PREP(RTL8365MB_INGRESSBW_PORT6_RATE_CTRL1_INGRESSBW_RATE16_MASK,
					      7));
		if (ret)
			return ret;

		ret = regmap_write(priv->map,
				   RTL8365MB_REG_PORT6_EGRESSBW_CTRL1,
				   FIELD_PREP(RTL8365MB_PORT6_EGRESSBW_CTRL1_MASK,
					      7));
		if (ret)
			return ret;

		ret = regmap_write(priv->map,
				   RTL8365MB_REG_LINE_RATE_HSG_H,
				   FIELD_PREP(RTL8365MB_LINE_RATE_HSG_H_MASK,
					      7));
		if (ret)
			return ret;

One more thing while we're on this: I checked the equivalent registers for RGMII on the RTL8367S, and they come out to 1, 1, 7 respectively (INGRESSBW_PORT6_RATE_CTRL1, PORT6_EGRESSBW_CTRL1, LINE_RATE_HSG_H). For correctness these should be set to those values in the RGMII path as well, rather than left at whatever reset/default state they're currently in.


