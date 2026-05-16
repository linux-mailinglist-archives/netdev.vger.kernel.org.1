Return-Path: <netdev+bounces-288645-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oN72L7ONCGr4uwMAu9opvQ
	(envelope-from <netdev+bounces-288645-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 17:30:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C556355C667
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 17:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 57AF33001FA6
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 15:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2066A274B28;
	Sat, 16 May 2026 15:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="PQpZUtwm"
X-Original-To: netdev@vger.kernel.org
Received: from sonic317-32.consmr.mail.ne1.yahoo.com (sonic317-32.consmr.mail.ne1.yahoo.com [66.163.184.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AD41946DA
	for <netdev@vger.kernel.org>; Sat, 16 May 2026 15:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778945453; cv=none; b=Kibmx80D0D4hwpifaScgtV35min7xqs6FOggyAIYbIBfH8lGK2Lakgy3kDngA8zYWGPrMJ37AxMPihZy4FG3EpPtVITj++FROfgDoTtuM+St1jecULs888MbDdtd1xM/vLxywmKBwoqg482eV0VSM9Yxx2AuGv9QYbmwgU7HjFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778945453; c=relaxed/simple;
	bh=pWkOQq4depPqxTrLvAV6OUQfZn9UxokVjfq4Joq5+zU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JYmtvP0YIon9CJ3ULdKrL0y+MA1P1024J8m+zSsvjHBy9Hs+NVPNWSC/uh9lMP9O2ck0n5FB+ZyeJ2ejpMWRujQE7MMYoeZ6wvGPdHmnM/+8mBw3K9ia2mxsly5VaLg+zjnwjNDENKLfyPGSU1/veRVyvLNcngKr//g0cV1qFzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=PQpZUtwm; arc=none smtp.client-ip=66.163.184.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1778945445; bh=00Ls9cyZJDBic+jPjggxUXiCxftp306cH3nIyU8ePwU=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=PQpZUtwm9SzVfSiBmWkmMQqfzSfgBf2agGNcX4jQCA3kkysgEEsfZ5Sm953jleHMSPLVbWsJ5RXQ2yPcnEN8qMfjmKt8XaPbbpY5NDPI7p1hoFhwlE75qPFCwPDIhxzRM8tlrIcFh2vNkrJtiSeWZxn4Ccg92adDkiifm1QRENrlvyCBasCvWuqT6nKtt251NIjdiwHQbKIdpveQQCo/QLHRHHIi6T9lSOcqxsTcvbxpXYzNxyxTwXDgYWjbNwsUJ3dhDr9xEbZS5jrPPaj268A6fzmDbeEX9mniEcHU88h8rhlw2CXYkiQtR/NXcS8B8QvKpYDribFMPSesBPtMvw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1778945445; bh=vw+ezAzTaOzX7NKfWr2DJA/wsQ/FnqO8e02TGEYDnAV=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=SegitYhhbOanlUMRr/92G9MQWQK42jRJOmjc0ZjyJtpcUBDt0k8UZibGUgu5kWqVPn4CnULHAh3S/wtyuPWddPVw26izKmh10H0TVftTPV5h2aMUFY86dZeAbZYKE9yOkWwra3tK3n/UZnaRMq/q/jzLk1TRzihUhfx2GcIo3YvQcCIwGYRFGreAneBVwaSI+FZIRf+ei+n3LR8VA7NCv/e9xKNO/mDrlyLNM65T1B1cqF0KXgnTYwHYLpZVFYN6xZOFt0k1yWgiaD9g2LU/H75zpAG6yFV9BQB+91sWAOkmBFaexi1KC+jsaj5v+/javHrGPAQB7JM3FOCTDRgw9Q==
X-YMail-OSG: _QvyWlYVM1lugP6_sig0XZH5r3KS4ChCtlQxO41cHEhl1xZnt.7qKqTaNew1zHy
 .o1st3_1qA1xlls7duKZ0Derf2QrUyLF77zkuYSBC.Hne0bqVOdLbZHiiirgmiUSJkxgEvCAgq2Z
 rv9GywIxGJTnRpZKm1xP8MWbyIOUmMP434hsr4sKjxiplkXwXZSRF36Akx0iZXx6F9QfMRZDdItH
 BSVaRaKZqvLYM6JeiWDWM13VdjD6eEME31FIQDmW7_QhNoR3pGupRnYzR_s.2GiZpU1hY0V1pO_e
 HN848xhjBqXhzD3kMrTV.8gXEL.TD6qr7RMm3ZUjOWilD01KW68Qv369c0IDEFwO.PvP.OgqxjEH
 ipRN9R2wh57VzeFyDzKiNtnuXbv.im0oLnVOMQ47k9DMMQJjeAjy0tVNQXmJC.QEQ4M5DoM3RWlY
 eu_LaSaodSpBBTqn973kbUceLT8vh9AfPhOLpN8vU8TNepQzHdo_nUVcweKVNWHbQk_fLmb2YSLS
 btiqN73Qu2Ndz.UnxC0xJKtl4Hd7EpwJbQujugfGV1f31SSNhKRDths2l_r3jUaB86ELVHUSkeAC
 .rfIyK8Tv1S6k32B.iLWElLcU4h2bbQoFrC7LKAl895gcQcZxvMr6EQBDKC6R.bhKTE1e7iRKOPV
 wAFpgjCBTcTKXdYiQwNXTe70VdypsrG1woF0X7QUUgnadHTkEQzvhNdfH4fwhOAX97FWJ.E0hebY
 iGfzWfTFkHqUk6ZfKRhOGwp3d6GQfBOP8yOtkBC1Bn5qgdEoNvVaT8WJgLyzc3emSU8pGD9mLgKu
 CMzeo5Hdgka2zqxdvWFnCfAdMBGUyNu7ZSPaysJrLCHFVYSnjfxfFiGGhPhl9Vv2ftr8GLPxcePf
 wc3n1ZYyqhE6kWAB.lJDgLS5EsJiyoOyywtrnSBhnUrEQK_CfypQEEpQQAzz1Au23j0Rgge.qg0P
 Fgwo826LULKWQFgFRQs_GsDqboXEcMiQoRKgh8K.6mCmI544sccX.0hgo79emMSGN7c0DMjwSIWZ
 eL.goXEm6bR30whkv6b1z4Dy9AXPVO5RLi4PY9uITZ6h19qBN0hkiUaMnhLUd4GM_m_TKo8n0CIC
 PEpVdlRSTM8xQGK3UvCv16e1.YzryQ7xmNw5ksQGHAV5WdwRQDignYMvXImLEP2hwXrKfdmMQSJ6
 _tsU7SZnBcCy26MGGp3u8GUC2H_z1yVCXMNLJzKDF2k9yw34smEIEkKJVbbebKLKhcvI5x9H7cfg
 JPEN18qyZhMA6W4M5aWAM6ffjd9kk_APP2CIzpdqWAy2pi5syaidPzWU8mRdBV_vWBnddEKdAnt7
 tjlFLSdZvWDmOAyW3DzZ18KDfSQ8H7fJwW6LF9ekP4nldeWI3GfHVBzcCZv5nv16fC8ZqDmLPCxx
 pF3zRVeHv6S0lxHPNVLvR6fu9.gjjApULRGagZ7ACVilgIBgDGZYN7k2RZp8_RBgoTu6KMiQd7.2
 b1CL10qgrnecxXso45sfnLBN44KB9uyuXqn3pYprvm0spYmPMA0C_a3ID.LnmL1i.gAXGgcCTynZ
 gk64FBOT40Pqeq812tJ_9aR7dYd69E268Y8MGiWDvx6ou5fC.DiJ2zr84y5CiUkdaa5B958VvoqT
 NNLG2skYPEq3uNQHYPTsrWB9W1ECDAg34mT7MakTuUz0Ppt41B8mFHY4jsG3EMvJbErPLOhCHTdA
 um8iWAR.PNb8X_YwyOXTQLeIatdgS_dwtmqDKUi6t1f_PY1cvGpQDWAAb4MZQlX.MrXRwI_kKbb_
 tjHkIkyGBmbMCLH.cbtpQnOPhJjQ_vd0bSsVxb2lT6_Np1kVV0BnyITiIQVJ3SniafHAvkDuEyFI
 Tn2RY6yDwhLKFsbXe3cpdg8Gcv8pmzMjo2LP4rMDx2vzlGDbBNAE0ZghA1fvY.I2LtKedLonkJU8
 OXvg3oETw9Uz1ETL9JWlaCyrKyYOxdcaNV8HNOBJQEQCowwOzh2PRbW9E_ZH7pdG9oBtK1SFgWrt
 YgP_i2ynAu8S0DcXrBRdBZdKXr4u1JYGUimlBiw5FiYEIxJxPYik6iemKg33iId68vgodOT9LLe7
 _QaSIf_wgb3H.2Ue4t_DhtEYYl3e0pC_DeRT.xdJ1nxQv9qwiLHGyGrF7kgaa0IsjWdcT8uPgL7E
 Ex7vs5tom6RY0Ho.WLYcW5lodFDp0gJd2CSL0w9zSF96rcWbgYHj.Y0T01JyTr21.IOlfSnv71ub
 4C7O9d7emMsJR.Ox3XSZ2KyuVNYy65WDdO9upU4kNWppbRM.9N4m6ohNi13MQkT68BZ0o7.5a2yj
 .WzkJ8J9BCiwqS_piJJ.YAyUpmOWz93IeCqEmBkgFUfLiXw--
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: e0e997b9-ca97-4419-910b-c49b89cd02b3
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Sat, 16 May 2026 15:30:45 +0000
Received: by hermes--production-ir2-89844b765-5zx6m (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID b811c7f3b2bfed5587f9049e61047525;
          Sat, 16 May 2026 15:30:42 +0000 (UTC)
Message-ID: <59c5ff7e-5152-4758-a49c-7b0d1299ef0a@yahoo.com>
Date: Sat, 16 May 2026 17:30:37 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v4 6/8] net: dsa: realtek: rtl8365mb: add
 port_bridge_{join,leave}
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
References: <20260516-realtek_forward-v4-0-8b6d6a1eefdc@gmail.com>
 <20260516-realtek_forward-v4-6-8b6d6a1eefdc@gmail.com>
Content-Language: pl
From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
In-Reply-To: <20260516-realtek_forward-v4-6-8b6d6a1eefdc@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.25725 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Rspamd-Queue-Id: C556355C667
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[yahoo.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[yahoo.com:s=s2048];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288645-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk];
	FREEMAIL_FROM(0.00)[yahoo.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[namiltd@yahoo.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[yahoo.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,bang-olufsen.dk:email]
X-Rspamd-Action: no action

On 5/16/2026 5:46 AM, Luiz Angelo Daros de Luca wrote:
> From: Alvin Šipraga <alsi@bang-olufsen.dk>
> 
> Implement hardware offloading of bridge functionality. This is achieved
> by using the per-port isolation registers, which contain a forwarding
> port mask. The switch will refuse to forward packets ingressed on a
> given port to a port which is not in its forwarding mask.
> 
> For each bridge that is offloaded, use the DSA-provided bridge number
> for the Extended Filtering ID (EFID). When using Independent VLAN
> Learning (IVL), the forwarding database is keyed with the tuple
> {VID, MAC, EFID}. There are 8 EFIDs available (0~7), but we reserve the
> default EFID 0 for standalone ports where learning is disabled. This
> fits nicely because DSA indexes the bridge number starting from 1.
> 
> Because of the limited number of EFIDs, we have to set the
> max_num_bridges property of our switch to 7: we can't offload more than
> that or we will fail to offer IVL as at least two bridges would end up
> having to share an EFID.
> 
> Co-developed-by: Alvin Šipraga <alsi@bang-olufsen.dk>
> Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>
> Reviewed-by: Linus Walleij <linusw@kernel.org>
> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>

Reviewed-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>

