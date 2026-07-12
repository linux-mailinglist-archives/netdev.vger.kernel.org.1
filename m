Return-Path: <netdev+bounces-306964-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rE3VNFncU2qhfgMAu9opvQ
	(envelope-from <netdev+bounces-306964-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 20:26:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 57286745A1E
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 20:26:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=yahoo.com header.s=s2048 header.b=adPiLP7q;
	dmarc=pass (policy=reject) header.from=yahoo.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306964-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-306964-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B7FB93002B1D
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 18:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B453399356;
	Sun, 12 Jul 2026 18:26:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from sonic315-20.consmr.mail.ne1.yahoo.com (sonic315-20.consmr.mail.ne1.yahoo.com [66.163.190.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F92372670
	for <netdev@vger.kernel.org>; Sun, 12 Jul 2026 18:26:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783880788; cv=none; b=UiX01tTVXNi0y44Btd0yAQGVwLYljwsZMsgVfvlskDUQxdbXJuEu+owsOqtj9vv9OqTxZ1nBoRvOXdF5b+AlBhiyFCnvueQhLwnEoWGnPUdKRBPTqUdepVoJPmW6UPzmAjdiIpsY60JHOicE5iWGsoVKS0HbUuSuylUPrfWpJPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783880788; c=relaxed/simple;
	bh=P6ghZ0tPlX4H+N/TU3ATLD8RRDscZKlj7i64rQ/hT1w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rB4zVGqRSqAQ7BLiYW+UXlfI6GH51Ls1gMQaC9MTDREycMO0FY1yBdjm+NGglYuz55zuB7fHVD4rN8nmgShG7ryc1v/qHRXBd2ztfLPnb3wyF4bhl3m1JLJhO07pJB6mHir/YP2DL7aRHzOC6LhCm+Q+FumoOr4aA8VEf8WwwS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=adPiLP7q; arc=none smtp.client-ip=66.163.190.146
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1783880776; bh=7UMEu4ya97zplXTcJ4hIzqbv8+E3Xf7XQi80Xf5pnCs=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=adPiLP7qPPfLLTYLVyRRbGSOecMVKvdOizeQtMCnl+hMTZqCAcoguMJMqAl1uFaPd+YrE/x9gDN1iFSEgXDjXPta3Jaw5qIFMf4XkLRVB2vjcYs+nF1wEsz29EdysBtEsWTXqoUU+yoam54bmNYpRrEQcIajfO8bqZvzMj7o9JvGdCGjcAadkO+zfebAr17lyRq+L7ZkEzFR4ZIXGtUQNKheLTnx273LRV8dAWZSogsWtWzRljKHM/z2cQ9ThuQ7cYa1DABqYl8+SQnDEO/eNMAklPUwQO48Rn6/6YRmzqivHXLtERFQu6lzEk+vONBx3Q4OvntkLYadYlg5kQYWzQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1783880776; bh=btPtEQ1cme/TdHEX6hi13d8UxdpDaw83oUXPTIU8l5o=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=q3cr0nvWcKIWQIzvOysvyKh5IX9PCCAnDlZlBs8iI7CK4Wp5TpfZ5vJ+ZeyaTN8lWo4v8k73GAfOSx1lXq2M0kvVYAjAap1uCedt2gvrcPYWMVhZ3QAJmgsM+4p6t6L4pvEyBwZ3IjUyWD/H+4tzg0g/rW8NuTBd2xJ3iYWavegPDEV9KyQ9qGrrl9GXuJOlgDf0VRv09xM0pXBO3NEvKbCr88DPSY3IfsH/G41EM6jMxVZ2D7w7IFM2pUTQOuF41xL6Rq6Xx3+B0X0TWh0DOnW70HTrFVEJb5CSg5EGTKTaXffF412vUSk2iN3MjB4HjH0gA+M4/MzSArv5PrW6cw==
X-YMail-OSG: 21tgVmAVM1lZyX3ZgLNG6V_GGeqIAJUY7uBSNqNx5PW3_Cy5JWS0iEwandc7z5O
 Kj3RqkKrgONgoRlIX5odQOObtoTfEyOaFFCOXzYiPW98dGlNJlGGahWJwRhBHtxY3NF_ez5jW8_0
 v.ucj4v0ekBUne._HiaEVdFh4tIASjYfsl_bMtpIkIUAfNhKTFARcPiw.LmjJTtc3KC6BXtPLLYz
 ayjIZ3Q_y3NQhP7yG51kHlMO5MFasQBvLBfDmpBOtNFBL9c33alrc_DgaT_DjEU2lfjAXon4fmTY
 yvbpyQWQLNz_699nAAmR7Rw2N2P7z1FCgztvCHMvytAZj.pdnF.Anzf_WmKf0phYtfUfMQ_mT7No
 GIs.5mKIJjWptyraR49C2n4DCp89IGhHq7cI96VzofSVZ0V_LgPhkPfdPZd9ORY4QR3I3dIwUkj6
 OyudlJGHVZyBACmksLdptCDkhj8CGbeoCK.ADGjCylTjw1lgb0vD8PUJKj5K6SwWEGTsGVmo_Bxk
 7x9KoGZEp.rdiYZvvX9gLOkzURBeB9euqyNEBKls1KKiOc2_xA34fFsQUH31C_bi.3ckZIzcs6_C
 xQvUF6nX9o0t6gxDn.4sgwvb4LLjo60k2km3Ve.PZI.47X3BLNiPfb5koxLeFnlEFAIcSGBQNAJX
 SgJNVvqh47hjKVqL7lA9vnU01k8pqmZmB5HVzKZfrm7UIFucUS79m8lec_rxmehLPyMaN_S4pnLV
 tyOj7mi9BUBjF1XQWAx2cFRGqKVwOjP8tgOMg4DgmWCwqNGXohLG56FKkAOvWMwW6AujGIS36FM6
 ws5KccLeDFnvOHXCzxd8G8US7YyiC5QMUTetwqXfjDfN3FhwDbH24niCk3qYfm3pfPQvUKwV0cw.
 8LR5H012vUhEfTxZ.ony3PPLTkghUU9if6I6qoPUwiAtFsXNLtpxfxEWbtcQN8LNyho0FBVTJ4qd
 .hS_0yETGdZJgBYsKR0SgJqP6rjGKP5lZ7_BrkygRMmtxRE.yriDOKi6DeSEWvuRyBIrpVYc_MUH
 U0gErnH.D4acb0KHv8dPUWvXH7gbcp_b2mQ3oBo5q6bW6UZAtZfIEOoL9kBjb_mpqzipa2licB22
 Dmsy0S322Ul5p9SzDrOzruPrbPQakuwcz7hdPMxJdEjKVthBDSmdjD3KFSeTyNRaIl5fyGQAU5ZM
 unufhQniXY0W9.Nhlkdn.p25AaMXYspnz9waIhTYNk6ANZxIqDqE6Thnjxgij7uvBnDXPygbwbjj
 yXyA_TYz5nChkLx97YcRrQXv6z.Fu7IITvgSPVLawPSgfu8W.5QU_8mANSRD2YzxX.ZVzst5jpNX
 jp.OWMJmHqIS6nv823Bwiflkz5rH.wwXj.Jj8YyR9iVVswvGgjv8X68eFxULIjCk3OkDbAcfuKCl
 eJKwbAy23MwTSzymlwLzMWYSbq9Lf5vIkm9Z3VNt52vMmmXpTBJ.0YQw2atfavWkIY0htToU6AhH
 3GrWhMZvHHQSh7Yo.raSkvQSKc0KrRkE3ZdFM4S8mDKhcvMevpzCqeSLwObt4zDM6hwXg39Y6q0V
 BYw90RIaxfFPvKnGa6D.GAY4j29ac_FEBgm9OWvpQWNs3CGJsVP83E0wrPwa9f3qHtL0GGRK6vSu
 AUuKAxnrZBNwNjUTkM0i1AxVjDXO9yr.3j1dZ6RF0gjOepqhdS.Lq6lzIy10vgm9mLIjVzWzmAgy
 qtweImaNGgBkkc4RgEFIxVGfJkfiEuCD9U4UP3x_VYS_IiSCgKSbKWb8.bM4NBwG1GW4BY.yHn5W
 ORCsnKpIJVtiS9ofd4H3bgz1KzmaIE6SeX.TSM7U_nOgyQWr0MIF.jU5Ax7j6hFE9D7F9Y6dC6.S
 Rq5foVCm910d7gGOcMSK3vSPCEtinmB2c8ZvIxnystSXfVtq6k.B5IDQWJbkDFOx4E5iz5SsR.Ec
 5VLPn7rUle6uBBMyIorUjgrwvWum7FQjGWoASbQach5m.ho5DLpW5RhhyqTW_TC9iIuoKiQTu0NX
 p1526YDOBKrpGodzl9GKHFl2kq5ZegVeGqAz12kKfEzc.oH6tPEOXdW_yqR09vVafemsenQBBsbL
 csCcfNmsK6hBascKJJzDowXLq2q.DlOy6WaB26C6XwSzGeLQUMtwdvTdqGLExjCowwOOmu9hpUGf
 VtE1c8DqtNJC5NfoCGH_dJYJKzccsw9b9Oj7n9dOQqXRYaAGpIEFUpeOdaVZi7Zlov64rYwRPL3o
 VsH0Wnh7b7EPHhNq7R3PHqmuRzk5lGKWo_xEHT6ZthAGozTKYR0CqdZh1KiZvfSx_nwmhFpjzQTO
 Jqfyt5i6dmLQGRWzYNfnPU3_V_57oJW6DO7zEelnN8Ajp
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: 0e7521ab-684d-494e-b6a2-2971447cffb4
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Sun, 12 Jul 2026 18:26:16 +0000
Received: by hermes--production-ir2-7b48fcd765-7kk4q (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 14ffdde626cdbfdeb3ae8e42bb048280;
          Sun, 12 Jul 2026 18:05:35 +0000 (UTC)
Message-ID: <7b164d90-b57f-4746-8b7f-b5bb7fd7fe51@yahoo.com>
Date: Sun, 12 Jul 2026 20:05:32 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 2/2] net: dsa: realtek: rtl8365mb: add HSGMII
 support for RTL8367S
To: contact@c127.dev, Linus Walleij <linusw@kernel.org>,
 =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Luiz Angelo Daros de Luca <luizluca@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260711-rtl8367s-sgmii-v6-0-88f7944ddca7@c127.dev>
 <20260711-rtl8367s-sgmii-v6-2-88f7944ddca7@c127.dev>
Content-Language: pl
From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
In-Reply-To: <20260711-rtl8367s-sgmii-v6-2-88f7944ddca7@c127.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.26136 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[yahoo.com,reject];
	R_DKIM_ALLOW(-0.20)[yahoo.com:s=s2048];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:contact@c127.dev,m:linusw@kernel.org,m:alsi@bang-olufsen.dk,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux@armlinux.org.uk,m:maxime.chevallier@bootlin.com,m:luizluca@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-306964-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[c127.dev,kernel.org,bang-olufsen.dk,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,armlinux.org.uk];
	FORGED_SENDER(0.00)[namiltd@yahoo.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[yahoo.com];
	FREEMAIL_CC(0.00)[bootlin.com,gmail.com,vger.kernel.org];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,c127.dev:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 57286745A1E

Hi Johan

On 7/12/2026 6:31 AM, Johan Alvarado via B4 Relay wrote:
> From: Johan Alvarado <contact@c127.dev>
> 
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
> 
>  - Advertise 2500base-x and MAC_2500FD on ports whose external
>    interface supports HSGMII.
> 
>  - Accept SPEED_2500 in the forced link configuration. The MAC speed
>    field has no 2.5 Gbps value: the rate is determined by the HSGMII
>    SerDes configuration, and the vendor driver programs the 1 Gbps
>    value here, so do the same.
> 
>  - Raise the port 6 ingress and egress rate limiters to their maximum
>    at setup time, as the vendor switch init does unconditionally for
>    the whole chip family. The chip resets them to 0x1FFFF (~1.048 Gbps
>    in units of 8 Kbps), which caps the aggregate HSGMII throughput at
>    roughly 1 Gbps. The vendor documentation describes the reset
>    default as disabling the limiter, but the cap is real: on an
>    RTL8367S-based Mercusys MR85X running an OpenWrt backport of this
>    series, several clients on 1 Gbps user ports were limited to about
>    1.02 Gbps combined across the HSGMII CPU port until these limiters
>    were raised, after which throughput reached about 2 Gbps [1]. The
>    related HSGMII scheduler line rate (LINE_RATE_HSG_H) is already set
>    to its maximum by the common init jam table.
> 
> Tested on a Mercusys MR80X v2.20, where the RTL8367S is connected to
> the SoC over HSGMII.
> 
> Link: https://github.com/openwrt/openwrt/pull/19445#issuecomment-4505613294 [1]
> Suggested-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
> Suggested-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
> Signed-off-by: Johan Alvarado <contact@c127.dev>

Thanks for the patch, this matches what I've seen too on similar
hardware.

As discussed earlier in the thread: the rate limiter helper, as well
as pcs_config()/RTL8365MB_SDS_BYPASS_LINE_RATE_MASK, currently assume
the SerDes is always muxed to external interface 1 / port 6
(RTL8365MB_SDS_EXT_INTERFACE_ID / _PORT). That's true for every chip
currently in rtl8365mb_chip_infos[] (RTL8367S and RTL8367SB both have
their SGMII/HSGMII-capable extint at { 6, 1, ... }), so nothing is
broken today.

I still think it's worth guarding against this ahead of time though.
It isn't an architectural constant of the family, just something that
happens to hold for the two chips currently in the table, and there's
no guarantee a future chip won't mux its SerDes to a different port
or extint id. If that happens, pcs_config() would silently program
the wrong DIGITAL_INTERFACE_SELECT/FORCE register, and the rate
limiter helper would write to the wrong port's registers (or need to
guess an address it can't verify) - the kind of thing that's easy to
miss in review since it only breaks on hardware nobody in this thread
has to test with.

Since rtl8365mb_sds_probe_option() already walks
chip_info->extints[] looking for the SGMII/HSGMII-capable one, I'd
like to have it cache the discovered port and id (mb->sds_port /
mb->sds_id) instead of relying on the fixed
RTL8365MB_SDS_EXT_INTERFACE_ID/_PORT. pcs_config() and the bypass
line-rate mask would then use the cached values, and
rtl8365mb_sds_raise_rate_limits() would check mb->sds_port == 6 and
warn+skip instead of assuming, since only the port 6 register
addresses are known/verified so far.

Draft below, as a preparatory patch to go before this one. No
functional change for RTL8367S/RTL8367SB - just removes the
assumption for whatever comes next. Let me know what you think.

---
  #define RTL8365MB_BYPASS_LINE_RATE_REG		0x03F7
  #define RTL8365MB_BYPASS_LINE_RATE_MASK(_port)	BIT((_port) - 5)
  
 +/* Port 6 ingress and egress rate limiter registers. Each limit is a 19-bit
 + * value in units of 8 Kbps, split across a 16-bit LSB register (CTRL0) and a
 + * 3-bit MSB field (CTRL1). The chip resets them to 0x1FFFF; see
-+ * rtl8365mb_sds_raise_rate_limits().
++ * rtl8365mb_sds_raise_rate_limits(). Only port 6 addresses are known - every
++ * chip currently supported muxes the SerDes to port 6 (see mb->sds_port),
++ * but this is not guaranteed for chips that may be added later.
 + */
 +#define RTL8365MB_INGRESSBW_PORT6_RATE_CTRL0_REG	0x00CF
 +#define RTL8365MB_INGRESSBW_PORT6_RATE_CTRL1_REG	0x00D0
@@ -30,7 +32,29 @@
  /* SerDes indirect access registers */
  #define RTL8365MB_SDS_INDACS_CMD_REG		0x6600
  #define   RTL8365MB_SDS_INDACS_CMD_BUSY_MASK	0x0100
-@@ -637,6 +649,18 @@ static const struct rtl8365mb_jam_tbl_entry rtl8365mb_sds_jam_sgmii[] = {
+@@ -270,12 +284,11 @@
+ #define   RTL8365MB_SDS_MISC_SGMII_SPD_MASK		0x0180
+ #define   RTL8365MB_SDS_MISC_MAC8_SEL_SGMII_MASK	0x0040
+ 
+-/* The embedded SerDes can only be muxed to external interface 1 (MAC8),
+- * which is port 6.
++/* The embedded SerDes is muxed to whichever external interface the chip's
++ * extint table marks as SGMII/HSGMII-capable. For every chip currently
++ * supported this is external interface 1 (MAC8) on port 6, but this is
++ * discovered per-chip in rtl8365mb_sds_probe_option() and cached in
++ * mb->sds_port / mb->sds_id rather than assumed, since it need not hold for
++ * chips added in the future.
+  */
+-#define RTL8365MB_SDS_EXT_INTERFACE_ID		1
+-#define RTL8365MB_SDS_EXT_INTERFACE_PORT	6
+-
+-/* Line rate bypass bit for the SerDes external interface */
+-#define RTL8365MB_SDS_BYPASS_LINE_RATE_MASK \
+-	RTL8365MB_BYPASS_LINE_RATE_MASK(RTL8365MB_SDS_EXT_INTERFACE_PORT)
+ 
+ /* SerDes tuning parameter variant selector. The vendor driver picks between
+  * two sets of SerDes tuning parameters based on this chip option. Reading it
+@@ -637,6 +650,18 @@ static const struct rtl8365mb_jam_tbl_entry rtl8365mb_sds_jam_sgmii[] = {
  	{ 0x0424, 0xD810 }, { 0x002E, 0x83F2 },
  };
  
@@ -49,25 +73,61 @@
  enum rtl8365mb_phy_interface_mode {
  	RTL8365MB_PHY_INTERFACE_MODE_INVAL = 0,
  	RTL8365MB_PHY_INTERFACE_MODE_INTERNAL = BIT(0),
-@@ -1242,20 +1266,70 @@ static int rtl8365mb_sds_probe_option(struct realtek_priv *priv)
+@@ -871,6 +896,11 @@ struct rtl8365mb {
+ 	struct rtl8365mb_port ports[RTL8365MB_MAX_NUM_PORTS];
+ 	struct phylink_pcs pcs;
+ 	bool sds_supported;
++	/* Port and extint id the SerDes is muxed to on this chip, discovered
++	 * in rtl8365mb_sds_probe_option() from the chip's extint table.
++	 * Valid only if sds_supported is true.
++	 */
++	int sds_port;
++	int sds_id;
+ };
+ 
+ #define pcs_to_rtl8365mb(_pcs) container_of((_pcs), struct rtl8365mb, pcs)
+@@ -1229,6 +1259,9 @@ static int rtl8365mb_sds_probe_option(struct realtek_priv *priv)
+ 	if (i == RTL8365MB_MAX_NUM_EXTINTS)
+ 		return 0;
+ 
++	mb->sds_port = extint->port;
++	mb->sds_id = extint->id;
++
+ 	ret = regmap_write(priv->map, RTL8365MB_SDS_OPTION_ARM_REG,
+ 			   RTL8365MB_SDS_OPTION_ARM_KEY);
+ 	if (ret)
+@@ -1242,20 +1275,74 @@ static int rtl8365mb_sds_probe_option(struct realtek_priv *priv)
  	return 0;
  }
  
-+/* The vendor driver raises the port 6 ingress and egress rate limiters to
-+ * their maximum in its switch init, unconditionally for the whole chip
-+ * family. The chip reset in rtl8365mb_setup() puts them back to their reset
-+ * default of 0x1FFFF, a ~1.048 Gbps limit which caps the aggregate
-+ * throughput of an HSGMII CPU port at roughly 1 Gbps. The vendor
++/* The vendor driver raises the ingress and egress rate limiters of the
++ * SerDes-connected port to their maximum in its switch init, unconditionally
++ * for the whole chip family. The chip reset in rtl8365mb_setup() puts them
++ * back to their reset default of 0x1FFFF, a ~1.048 Gbps limit which caps the
++ * aggregate throughput of an HSGMII CPU port at roughly 1 Gbps. The vendor
 + * documentation describes the reset default as disabling the limiter, but
 + * the cap has been observed on hardware. Raise them likewise, to 0x7FFFF
 + * (~4.19 Gbps, above the HSGMII line rate). The related HSGMII scheduler
 + * line rate register (LINE_RATE_HSG_H, 0x03FA) is already set to its
 + * maximum by the common init jam table.
++ *
++ * Only the port 6 register addresses are known. Every chip currently
++ * supported muxes the SerDes to port 6 (see mb->sds_port, discovered in
++ * rtl8365mb_sds_probe_option()); if a future chip ends up muxing it
++ * elsewhere, skip rather than guess at an address.
 + */
 +static int rtl8365mb_sds_raise_rate_limits(struct realtek_priv *priv)
 +{
++	struct rtl8365mb *mb = priv->chip_data;
 +	int ret;
 +
++	if (mb->sds_port != 6) {
++		dev_warn(priv->dev,
++			 "SerDes on port %d has no known rate limiter registers, skipping\n",
++			 mb->sds_port);
++		return 0;
++	}
++
 +	ret = regmap_write(priv->map, RTL8365MB_INGRESSBW_PORT6_RATE_CTRL0_REG,
 +			   0xFFFF);
 +	if (ret)
@@ -96,17 +156,18 @@
  				bool permit_pause_to_mac)
  {
 +	const struct rtl8365mb_jam_tbl_entry *sds_jam;
- 	const int id = RTL8365MB_SDS_EXT_INTERFACE_ID;
  	struct rtl8365mb *mb = pcs_to_rtl8365mb(pcs);
  	struct realtek_priv *priv;
 +	size_t sds_jam_size;
++	int id;
 +	u32 mode;
  	u16 val;
  	int ret;
  	int i;
  
  	priv = mb->priv;
- 
++	id = mb->sds_id;
++
 +	if (interface == PHY_INTERFACE_MODE_2500BASEX) {
 +		sds_jam = rtl8365mb_sds_jam_hsgmii;
 +		sds_jam_size = ARRAY_SIZE(rtl8365mb_sds_jam_hsgmii);
@@ -116,8 +177,15 @@
  
  	/* Hold the embedded DW8051 microcontroller in reset and keep it
  	 * disabled. The vendor driver loads firmware into it to manage the
- 	 * SerDes link, but the firmware only duplicates work that phylink
-@@ -1283,24 +1357,24 @@ static int rtl8365mb_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
+@@ -1272,17 +1359,20 @@ static int rtl8365mb_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
+ 	/* The vendor driver clears the line rate bypass for all interface
+ 	 * modes except TMII.
+ 	 */
+ 	ret = regmap_update_bits(priv->map, RTL8365MB_BYPASS_LINE_RATE_REG,
+-				 RTL8365MB_SDS_BYPASS_LINE_RATE_MASK, 0);
++				 RTL8365MB_BYPASS_LINE_RATE_MASK(mb->sds_port),
++				 0);
+ 	if (ret)
  		return ret;
  
  	/* Tune the SerDes with vendor-prescribed parameters */

