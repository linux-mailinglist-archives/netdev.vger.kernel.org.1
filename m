Return-Path: <netdev+bounces-253818-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YN3mHDefeGn4rQEAu9opvQ
	(envelope-from <netdev+bounces-253818-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 12:19:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E37A3937DC
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 12:19:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2D4AF302257A
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 11:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2125346A08;
	Tue, 27 Jan 2026 11:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b="RqDDOu6V"
X-Original-To: netdev@vger.kernel.org
Received: from dilbert.mork.no (dilbert.mork.no [65.108.154.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D49D30E829;
	Tue, 27 Jan 2026 11:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.108.154.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769512697; cv=none; b=tkf0/DH18u0ARhC/ALa2NUW5g6OKHQK537vCpaGPjPZmTUUItD+C3HD5z7Ox0DEcRqNt68PLITL1se1fYf6VhVFm1VRpNhy94pX/lt7Pi7eQfFXZJgiapPStnQcmAdZZ5YHJ/ym3b4EeUtsY8zS1Xjnuhg3qIA4hfGM2AymY30M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769512697; c=relaxed/simple;
	bh=EKcvypnzP3AQs7jXCrG7eSTUrGVT01ieSDPSA8dqZyk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gHa/SyRZtpOTvKDNVvn1L/B1WmzpAg6vnZ+MWOGyTpN/SrcS5/X3hdnI74uPFX+Wct1yWkmf80Q7Te5t8aNuIb20pEEY3waRu6Zws4d1FtrjzAZEYQRCyUDNMJs/wIhaZ0OlT9BA3uthLtaFtBRxLA6knWulxqKQaVV+l+U8Hos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mork.no; spf=pass smtp.mailfrom=miraculix.mork.no; dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b=RqDDOu6V; arc=none smtp.client-ip=65.108.154.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mork.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=miraculix.mork.no
Authentication-Results: dilbert.mork.no;
	dkim=pass (1024-bit key; secure) header.d=mork.no header.i=@mork.no header.a=rsa-sha256 header.s=b header.b=RqDDOu6V;
	dkim-atps=neutral
Received: from canardo.dyn.mork.no ([IPv6:2a01:799:10e2:d900:0:0:0:1])
	(authenticated bits=0)
	by dilbert.mork.no (8.18.1/8.18.1) with ESMTPSA id 60RBHLr11872090
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Tue, 27 Jan 2026 11:17:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mork.no; s=b;
	t=1769512641; bh=9aysHJ/oZjIPwYLzZqL5Gy+IG3OJV66LZjXaNkOY3EI=;
	h=From:To:Cc:Subject:References:Date:Message-ID:From;
	b=RqDDOu6VQoXhDcdTMCfgMx8IWbDRfJzHj5GYlCgae1Z7M9PP0h0rSQfZDXsTsEQgo
	 aPT/nc1/a09IqNqXCRQ8YtDHtX1+b8MGqvCdLAKO6q3t/b3dSf0kHk0ZdzUeuMtMZ1
	 Ym7PFpE5xforvkArR1Ri2lyex7L5x8fCaxMmbxiM=
Received: from miraculix.mork.no ([IPv6:2a01:799:10e2:d90a:6f50:7559:681d:630c])
	(authenticated bits=0)
	by canardo.dyn.mork.no (8.18.1/8.18.1) with ESMTPSA id 60RBHLQw531028
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Tue, 27 Jan 2026 12:17:21 +0100
Received: (nullmailer pid 1468840 invoked by uid 1000);
	Tue, 27 Jan 2026 11:17:21 -0000
From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, "Lucien.Jheng" <lucienzx159@gmail.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/3] net: phy: air_en8811h: add Airoha
 AN8811HB support
In-Reply-To: <20260126191159.05b57b91@kernel.org> (Jakub Kicinski's message of
	"Mon, 26 Jan 2026 19:11:59 -0800")
Organization: m
References: <20260126065749.1334867-1-bjorn@mork.no>
	<20260126065749.1334867-3-bjorn@mork.no>
	<20260126191159.05b57b91@kernel.org>
Date: Tue, 27 Jan 2026 12:17:21 +0100
Message-ID: <87jyx3e24e.fsf@miraculix.mork.no>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 1.4.3 at canardo.mork.no
X-Virus-Status: Clean
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mork.no,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[mork.no:s=b];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,makrotopia.org,nxp.com,lunn.ch,armlinux.org.uk,davemloft.net,google.com,redhat.com];
	TAGGED_FROM(0.00)[bounces-253818-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[mork.no:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bjorn@mork.no,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E37A3937DC
X-Rspamd-Action: no action

Jakub Kicinski <kuba@kernel.org> writes:
> On Mon, 26 Jan 2026 07:57:48 +0100 Bj=C3=B8rn Mork wrote:

>> +		mdelay(300);
>
> Did you mean msleep()? mdelay(300) is a lot of spinning.

Doh!  Thanks.  I will write that 300 times on the chalkboard.

>
>> +		air_buckpbus_reg_read(phydev, mon2, &pbus_value);
>> +
>> +		if (pbus_value & AN8811HB_CRC_ST) {
>> +			air_buckpbus_reg_read(phydev, mon3, &pbus_value);
>> +			phydev_dbg(phydev, "CRC Check %s!\n",
>> +				   pbus_value & AN8811HB_CRC_CHECK_PASS ?
>> +					"PASS" : "FAIL");
>
> AI code review points out on failure you just print a FAIL and carry on.
> Is this because this is what the vendor driver does? Or we know bad CRC
> FWs exist in the wild? A comment would be useful here..

Spot on. Explaining this in a comment for you, me and the AI is a good
idea.

> Please name labels after what they jump to. Per CodingStyle..

will do if there are any labels left after refactoring.

>> +	ret =3D air_buckpbus_reg_write(phydev, EN8811H_FW_CTRL_1,
>> +				     EN8811H_FW_CTRL_1_START);
>> +	if (ret < 0)
>> +		goto an8811hb_load_firmware_out;
>> +
>> +	ret =3D air_write_buf(phydev, AIR_FW_ADDR_DM,  fw1);
>> +	if (ret < 0)
>> +		goto an8811hb_load_firmware_out;
>> +
>> +	ret =3D an8811hb_check_crc(phydev, AN8811HB_CRC_DM_SET1,
>> +				 AN8811HB_CRC_DM_MON2,
>> +				 AN8811HB_CRC_DM_MON3);
>> +	if (ret < 0)
>> +		goto an8811hb_load_firmware_out;
>> +
>> +	ret =3D air_write_buf(phydev, AIR_FW_ADDR_DSP, fw2);
>> +	if (ret < 0)
>> +		goto an8811hb_load_firmware_out;
>> +
>> +	ret =3D an8811hb_check_crc(phydev, AN8811HB_CRC_PM_SET1,
>> +				 AN8811HB_CRC_PM_MON2,
>> +				 AN8811HB_CRC_PM_MON3);
>> +	if (ret < 0)
>> +		goto an8811hb_load_firmware_out;
>> +
>> +	ret =3D en8811h_wait_mcu_ready(phydev);
>> +	if (ret < 0)
>> +		goto an8811hb_load_firmware_out;
>
> TBH the gotos are a bit hard to read, maybe factor out the logic that
> can fail to a separate function? Then we can just capture ret here and
> fall thru; and the helper itself can return ret; directly.

Yes, this was almost unreadable.

But fixing it turned out harder than I thought. There are so many steps
and we want to skip everything after the first failure.  Could be just
me being daft.  Probably is

Anyway, I have made an attempt.  At least got rid of the gotos.  Will
send a new version after some testing.


Bj=C3=B8rn

