Return-Path: <netdev+bounces-288697-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Fm3XCbhsCWrzZQQAu9opvQ
	(envelope-from <netdev+bounces-288697-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 09:22:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B6D055FA3D
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 09:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D640300AB2F
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 07:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A149424169D;
	Sun, 17 May 2026 07:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="PHiOX+p6"
X-Original-To: netdev@vger.kernel.org
Received: from sonic304-20.consmr.mail.ne1.yahoo.com (sonic304-20.consmr.mail.ne1.yahoo.com [66.163.191.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3A18287E
	for <netdev@vger.kernel.org>; Sun, 17 May 2026 07:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.191.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779002548; cv=none; b=B65MFQO8dIHbWmiPlonjCr88QOjJpF8yvA5k6wiV5HLSEel5qe1WuWdOw2ibJ5g8u4wdIdB5kV3ONveHL1zEox3V8lag/5MVARpODm2TtNY7+QVnFdXovFP7ruYRzu3y9Oa2aQIXjU3FlXuWNq73Dg2IcUWp27tLTQdOoV/aOP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779002548; c=relaxed/simple;
	bh=W42+bh+AN0wWT/bejzYcTPCDS3JMPkEfRl6VbOqD4o4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=irInbzHTUvbni73wGWvlixaKcunAm09+rtLRVVsYgMWz1v8Kf29dyJMgk6AfVsX9pxRo1DuC80mQLHM0PwXilFhpsoidVpTaOR0h6bN169cq5oysOM3W5XrJ9mWDvciXh53k6sMqLnDwMQ2AqBl0ycg1lkldI7lfc+1xnR/rwR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=PHiOX+p6; arc=none smtp.client-ip=66.163.191.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1779002546; bh=mX7woosI9CQkNgA6oJNCXGUH9GTMSUXYEf/Pv/zp7IA=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=PHiOX+p6I7pAGmclUpOxOvNMwbZoWhTz7LXQtVeP9xuzKE8xcXGsete0mMVIAAda3Vt/XWDgfv3/Sm61h3q9Qod/RzaF2VnItPsmjrU7SmQa/LC5DpQTmjtlaemK3Nfdsw6481vSFzAC+x8MU3wEmGXtlPN0lgpUy2Stwq6e91jP+Ctc6k1m9FXgOO7BGfKJSapJjjWH2ep7bO3OMPa61yKLW0PXoX4bdMzBMeHFWXgs3TtHzZrvSG3+cyWfQEpF5EnyKwmN/MGmPkjFM1Avbp01VfU0+HKdsrz4jbekKSu+AUqGB+G4CPu+5hGygXdvMefg59fVG13WF0mBSJkomA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1779002546; bh=q9oobPlg+4tBmGTE+iFMnNNVsinvQa8BHDBLjh04xHF=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=ayjH1zeyrzyDLe+VybDc+k7rhh3Hfk8zIaNhdsmRjZtuiF9zXhd/6imFE2F/++3sQy6CqB14MP2flQ4SjOCIUUiCK5+lv8+AdXLnNizrefw25fP3eLQZ3WbrKbpJcoypQUbXKeH6CViqmBWU06WNAVtsnRZW5YJYL4nh9anQVvoHMqea6auJkJLfRHsqJLlvYX4QOqOURiwjiQb6c0djwtPak+YPouWE7KTgvyLbBLrrj/ETL/GXgU2MjsGn6QQpKwa3lKamN8slh7n3SxHqc8Jw9AnZ+t5NIZUnVSiM5GU/Mfvj0WhUGMgqXTvGwd+ADmzLDvUxlc3+SO0MVTroLg==
X-YMail-OSG: av27AGIVM1k2apDtDkZIa5p4108zk1TM7TnaQx99B5TuZtD.uN67.hCwlhDMM7X
 lJgceHUK3drIq0EtBsSCtFL3nFs6li2_TxsBvxHpOVt1ojgMU5jA1352fPE4k.GuqpS_c6pIsftx
 UdPngIW0ydaETr0HLSECm14vHX7XLLIb3t6XmLi1fYoIHDAZBQ2CRDcY8hWG.LfL_Nplgl6BBKIM
 Nc8IIcQ07gFH6lBSKIj3mJ4Z57PfB_rw617WoM2428IWVBQvgtlC9EGYe8qFplb9JEWqxNxLikv3
 FPV9MHhqU1Ggb7OniAqNcCCzJvqnKAZ_eFrfO4lwhRtNkcV0AiEZdMFKGLnMyodEh5n.Feu28NYE
 6z1qlQaqkyXCc.NmPW73j9GPFSLeePNVcauaJl1HpBSmbX9riG7gdJaMc281Rhe5_LL7YLDMHLYr
 uOGXt5_vmms2SqA8WRr6NJyEQi0Vg0hwp5C4L_fIKtC1HIuJSg1PKKvyRXysGMKPLfmYhxyotFF8
 bVQXMqDWwAp2YTIOQtsvSk1KMonLgtdjvIGYq.TpPWVb6RV81C2ZWXdxvTUGk6UnFKo1NZO71.P5
 6iZrDGgskU49IBNSfrYH4vbjaAwFvrl3amBf9MWNabKRXCEhC1rv6E4ceBqxOEK5pSqeNgPJPrr_
 L64G_7SMwFYD8SwBoh9PadcVg2QV4y63hdAG_XcfbmWsX9uwHYIFMpobuQJwMDBJAs24h56Wgqk4
 MJ1O9PU13AAvG1NHtd99jUT6mOp2QrPB4rU_0GRV85wVPepntVmx16v.HBcQk_0.cO3hsAoE43MJ
 RdUsvbmnU7Jlid6gHEYN8xv0WeRGuGSUP7S5mP2IvgGphqYVlkT6ri87LwtHkojMiwfMHdDcg71C
 pTZi5qPajgUU8atIG.3oAWA52ydbN_eU59IFNRW3HMhWwq5xAofvQmpmk8NOUeaOp.oOJ8jHub.h
 lT9LAjpqylqBgsnEi5wCAVz2iBIngpg3iXkMAJS3rWrrZHOuAC9H.SJHHIVpgQMWlTuaLXhK3dLh
 77.Ormm8QyJF_BNwOLkalYFFzk0c28kzrvz4ZXQsfYGRVLLGB8zem43zWmeSv2zjWhQwprJ_T1cs
 8qXtjr4dpB7KRQ5kWFAhs7w35sp83i9x9KGJqGEJ5w4QF3B2jXZ7.QbnbkuL1n.DInS2UIq8bsCY
 tlsJaS1ga4XwyyDm1elhIJa1i2xZX8EGAwj6bBrRzfz2YslqmSE70o6a2vpfeTDswcGFvjxZ7Axy
 OSBZw1CG5QiQqvmGq_S59GEhIe6yZLeJSyDYCEjqkGUUnOTQa7hAMOEshyacmaKIfP9HQMY7vpik
 f_VO0pyjLPpYyWSVLTR5Ak48m4u6yogKpmy1jUZNrZwS8PDYGLkupXEDGyD7jk1uU9PRSxp4.kws
 aQVMSxi_ONisEXk10CgQHxo3D4Xj434HKAfBIgtNiEf_1QPrJYayguYroylMpZgnrR.MuywtJWFE
 urTGzDv12loZb541sTFDcQ7p4nqIQWEKU2CrNMXg7LpJTDBGp7H4GdhmuKrQXVH1uER5lgUiTr3_
 lP.2g1Jrkhqsk2v.1Jzn4qBUMpc.cgmKRQhhB7DzK_Wtjgb54HB_8q38zsfkwu4bEW8DbFwkXseY
 HRf7CM0Z4BIKcNzPCoNEisNynmkKkQsh6X7xL1VwiHkDJpr3MUaZTRCv1cHT9mkcbVXSKaBuuuGa
 wAsSHPTR50s6AbsxqFtog.7Uhdwpm3kKe2nwgYYkSSEI3qEEC0ypx1GcZL62sRmkeWMIXbZNvb3.
 62IlH78Nbm8GlbjH.A_HPtHYRLXoBbpg.jD7eOAqw0LDucBOlHWA9rJT.vh4oWBXi1VczUEe.5ZD
 TODVmLEOQac1nW4wevm1ntNJgRjPTQbQoLqHJELWhlLjdCfBe_iN8MMTCHpiz_C83j7N4l_ElCNw
 pi9RDaJA0SpOxDFiM0tLJjjEzLFmFDm5RD0y7rbsAXdfdJ2ofUP9IlYqCbImM6wByQlN_AnX65y7
 _OScZtaUJZZVcSyDNgcheLmKFZN3WATtL47SbFV6pEDR8HGCsq3m0w3EVhTOKoYIhduXW.4PTbCz
 f5_1I435qBYMBIW7dpHgTeo3B95gwgIfZ._RqzDvvI_Dklw.MchFgun09jYDdyASn6ZUTHz7tqKF
 AxzNtcg1sKeiS5PTz79OulO6Y9Dz3Bq1hYw6GDFHykDNiFh7TuPWA9CTELB8yDfur.LEgV5SDtTF
 vaJeIMTogMVSjCgtBDnLx7qUyKPKlUBEKDkUb4Maq6srk_kGDOkaw49Gn52Q8tTiIRLyEGtueAxj
 VR4u3O.KpONsyOzo1WoT4d.foo4rkTlm.12Vm0gKmIgIb9w--
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: bc5eede1-969f-408a-80ee-c1c399b04dca
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Sun, 17 May 2026 07:22:26 +0000
Received: by hermes--production-ir2-89844b765-vmp7w (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID ef2b852bfea421f08da7457608ddab95;
          Sun, 17 May 2026 07:01:44 +0000 (UTC)
Message-ID: <e9edd482-28dd-4222-8df2-822da29f0f53@yahoo.com>
Date: Sun, 17 May 2026 09:01:40 +0200
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
X-Rspamd-Queue-Id: 6B6D055FA3D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[yahoo.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[yahoo.com:s=s2048];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288697-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email]
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
> [...]
> @@ -1196,6 +1258,195 @@ static void rtl8365mb_port_stp_state_set(struct dsa_switch *ds, int port,
>  			   val << RTL8365MB_MSTI_CTRL_PORT_STATE_OFFSET(port));
>  }
>  
> +static int rtl8365mb_port_set_transparent(struct realtek_priv *priv,
> +					  int igr_port, int egr_port,
> +					  bool enable)
> +{
> +	dev_dbg(priv->dev, "%s transparent VLAN from %d to %d\n",
> +		enable ? "Enable" : "Disable", igr_port, egr_port);
> +
> +	/* "Transparent" between the two ports means that packets forwarded by
> +	 * igr_port and egressed on egr_port will not be filtered by the usual
> +	 * VLAN membership settings.
> +	 */
> +	return regmap_update_bits(priv->map,
> +			RTL8365MB_VLAN_EGRESS_TRANSPARENT_REG(egr_port),
> +			BIT(igr_port), enable ? BIT(igr_port) : 0);
> +}
> +
> +static int rtl8365mb_port_set_ingress_filtering(struct realtek_priv *priv,
> +						int port, bool enable)
> +{
> +	/* Ingress filtering enabled: Discard VLAN-tagged frames if the port is
> +	 * not a member of the VLAN with which the packet is associated.
> +	 * Untagged packets will also be discarded unless the port has a PVID
> +	 * programmed. Priority-tagged frames are treated as untagged frames.
> +	 *
> +	 * Ingress filtering disabled: Accept all tagged and untagged frames.
> +	 */
> +	return regmap_update_bits(priv->map, RTL8365MB_VLAN_INGRESS_REG,
> +			RTL8365MB_VLAN_INGRESS_FILTER_PORT_EN_MASK(port),
> +			enable ?
> +			RTL8365MB_VLAN_INGRESS_FILTER_PORT_EN_MASK(port) :
> +			0);
> +}
> +
> +static int
> +rtl8365mb_port_set_vlan_egress_mode(struct realtek_priv *priv, int port,
> +				    enum rtl8365mb_vlan_egress_mode mode)
> +{
> +	u32 val;
> +
> +	val = FIELD_PREP(RTL8365MB_PORT_MISC_CFG_VLAN_EGRESS_MODE_MASK, mode);
> +	return regmap_update_bits(priv->map,
> +			RTL8365MB_PORT_MISC_CFG_REG(port),
> +			RTL8365MB_PORT_MISC_CFG_VLAN_EGRESS_MODE_MASK, val);
> +}
> +
> +static int rtl8365mb_port_vlan_filtering(struct dsa_switch *ds, int port,
> +					 bool vlan_filtering,
> +					 struct netlink_ext_ack *extack)
> +{
> +	enum rtl8365mb_vlan_egress_mode mode;
> +	struct realtek_priv *priv = ds->priv;
> +	struct dsa_port *dp;
> +	int ret;
> +
> +	dev_dbg(priv->dev, "port %d: %s VLAN filtering\n", port,
> +		vlan_filtering ? "enable" : "disable");
> +
> +	/* When vlan filter is enable/disabled in a bridge, this function is
> +	 * called for all member ports. We need to enable/disable ingress
> +	 * VLAN membership check.
> +	 */
> +	ret = rtl8365mb_port_set_ingress_filtering(priv, port, vlan_filtering);
> +	if (ret)
> +		return ret;
> +
> +	/* However, we also enable/disable egress filtering because the switch
> +	 * still consider the egress interface VLAN membership to forward the
> +	 * traffic. We enable/disable that check disabling/enabling transparent
> +	 * VLAN between the ingress port and all other available ports.
> +	 */
> +	dsa_switch_for_each_available_port(dp, ds) {
> +		/* port isolation will still keep traffic inside the bridge */
> +		ret = rtl8365mb_port_set_transparent(priv, port, dp->index,
> +						     !vlan_filtering);
> +		if (ret)
> +			goto undo_transparent;
> +	}
> +
> +	/* When VLAN filtering is disabled, preserve frames exactly as received.
> +	 * Otherwise, the VLAN egress pipeline may still alter tag state
> +	 * according to VLAN membership and untag configuration.
> +	 */
> +	if (vlan_filtering)
> +		mode = RTL8365MB_VLAN_EGRESS_MODE_ORIGINAL;
> +	else
> +		mode = RTL8365MB_VLAN_EGRESS_MODE_REAL_KEEP;
> +
> +	ret = rtl8365mb_port_set_vlan_egress_mode(priv, port, mode);
> +	if (ret)
> +		goto undo_transparent;
> +
> +	return ret;
> +
> +undo_transparent:
> +	/* It will also try to undo the failed port if the error happened
> +	 * inside the transparent VLAN loop but that might be inocuous.
> +	 */
> +	dsa_switch_for_each_port_continue_reverse(dp, ds) {
> +		if (dsa_port_is_unused((dp)))

- typo inocuous - innocuous
- redundant inner parens around dp in dsa_port_is_dsa((dp))


