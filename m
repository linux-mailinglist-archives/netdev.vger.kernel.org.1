Return-Path: <netdev+bounces-259835-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uAxKBbUTmmmeYQMAu9opvQ
	(envelope-from <netdev+bounces-259835-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Feb 2026 21:21:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 60CCC16DCD5
	for <lists+netdev@lfdr.de>; Sat, 21 Feb 2026 21:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54D213038513
	for <lists+netdev@lfdr.de>; Sat, 21 Feb 2026 20:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC42368294;
	Sat, 21 Feb 2026 20:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eIOaVn21"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C9836829E
	for <netdev@vger.kernel.org>; Sat, 21 Feb 2026 20:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771705262; cv=none; b=KWoHodCPpie7uR3mDOVko0WENs1JlqW/nFWFcSelCMvhE/IUxzasnFq756GFT1A6kWGJt0Lzj5dfJ+10AY7zw6FVqcnLhYnEwvGItvcCQwyrvLgxGtmWSuHHseX839Ck+PEoU5X9L0tkxRTsfZy4uMPTacKDjMUjVjeObjP2DDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771705262; c=relaxed/simple;
	bh=MdfV7MR6/fNLmSxrCi1s/IDBRC28RM6oES4DTBkklKY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=SmP5SfR4eTLT4coeTQNxz3N3kjQ/Jv2utQdCHCTOIFKRPMfy+Jj/nCJjtFamTO1UlWcdp/pm2xQvuKXBvoERSQZyTPdXb735fIfRVMqhmPGGSrVm4vjPaq15+8ewl+OLZon1l4F49PZJKdRsEmmEnE08YV9wysWZ9z7YOau/dhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eIOaVn21; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-48069a48629so31331515e9.0
        for <netdev@vger.kernel.org>; Sat, 21 Feb 2026 12:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771705259; x=1772310059; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MdfV7MR6/fNLmSxrCi1s/IDBRC28RM6oES4DTBkklKY=;
        b=eIOaVn21dxmpGJRJ5AkRuf5VTL3tJulHpCokOrqiI8iCoB4pZ7tMsTzlDJ0GLGA34Q
         n3JXOOSVdrA56L1uDX0fKkBPSR0GcLm8apmgrGBM+MerfDBGcytTQq1OqTqRqweBx3ks
         HAJj5wOS5Ed5nWX6dEmDEesqptyXktUbVlUk14wG/noVbqzsfGydzSDYSVBlRBUwYLto
         rE98i5CvMuV15vFLN8YaIUKikic7fmEH2Z4Zf0PnCiBbjMdV7lDy+8CrpUQywHOBJqfJ
         v+z89zcG9cgneXMzbO9fDKxWg2e2wsoAQIyPD+qkg4AkSHdopNnSPykA0sUshdlhB8yA
         +B3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771705259; x=1772310059;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MdfV7MR6/fNLmSxrCi1s/IDBRC28RM6oES4DTBkklKY=;
        b=pkO4PEj+LcVk1r3Qz8HSDKurZScVaG9emlyGerGImBFEwIqGBgTJ5K4uBJ7qmE9/Op
         1tpYqxJFBRGMGgcYatM3WkP/e82k/ger3PRhZbKRZCXVOxNO02HVFzxLWq+vwI9Z7fpg
         RVzJhbQssSKkDORzcWDPvJbl6lnTbXDLU/DLrXFUWRWhvRTfcF/v88MtCy2rD1Ge7z6U
         EcGz89nR3+0oV0DaVMoMrYQSnw50ZA8d7daUkWTpjYDWo7PGi2FJLAyWjVin8voYhW1x
         n8OLxD+LUqMw3Zh5pjjgjrT5VfUey092DL41t1SUrI65U+WVQS9f6buZJkcbi/UyUXtM
         Gvow==
X-Forwarded-Encrypted: i=1; AJvYcCXPq1UrBIUlTlUip6Y4iOYJhmjT6iZQErymz6BlZUgEkwXsvTfg1EkSC5iF2ty5tTAYvlnjfcM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTNm8ylQLAfibC0TQau1fjOPeSnFTN/0vjnukASJWANIrb7lrX
	EQWtPFlm3Iz2CsjxTEK6bvT7Tem+DyaN3Ovuu1NiuFB8WJ0eX+FbvY+Y
X-Gm-Gg: AZuq6aKmZDqlwHO0wS01a+ojsPnl8sH9yIBPkgYez5lKYv/wxefHIOKX9AHQteY0kjv
	sfr9dokN35MLLdfOHPhAT1bUxyKLdgdHSD2oiwzjd56yb6HP48yk2gtOERCpItGm0VjDK/mayCm
	zPKrI6XCrlCV1dCvz4S8SSHNljTQT/2irAKQZQVRdUSeAFmO2JFRbtAUvNZMV7KHEATqe+d/erl
	QPQw4KVT+OAGj+muKVz2G3WQ1SHrhS5Egw0+VReuMwzKwHJW1XridrSTPCCGTD3lvSuV7Z+9j0u
	Z55WI8vhIW4Ay6GyIT2+CbZx3dARWVx/qr6n3NgUL9iH04SJovm7pgrSY+Bldd46+Cmbpbrkvc9
	U+JYuiwgN2co80QDvRxVKwaD8+o5wHf5QQTaYhoUKOpmA9jn5Z2C5SY0VWpQSuw4SBaLNDgAwlV
	Bm/MfF3x3Ti3h3kINQG6lYHycB6nOJin1b1XRoyp/C0nsJtIAT/zav2ZU=
X-Received: by 2002:a05:600c:1e1d:b0:480:6999:27ec with SMTP id 5b1f17b1804b1-483a95bebcdmr70776425e9.13.1771705258786;
        Sat, 21 Feb 2026 12:20:58 -0800 (PST)
Received: from smtpclient.apple ([2001:912:1ac0:1e00:8846:5cfe:bf37:b202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a316eb08sm175040345e9.0.2026.02.21.12.20.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Feb 2026 12:20:58 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH v6 4/4] net: phy: realtek: add RTL8224 polarity support
From: Damien Dejean <dam.dejean@gmail.com>
In-Reply-To: <def77227-7b69-4f23-8f68-949173eda6a4@redhat.com>
Date: Sat, 21 Feb 2026 21:20:46 +0100
Cc: andrew@lunn.ch,
 krzk+dt@kernel.org,
 robh@kernel.org,
 kuba@kernel.org,
 maxime.chevallier@bootlin.com,
 netdev@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 edumazet@google.com,
 davem@davemloft.net,
 hkallweit1@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <CB0A00EB-82D1-44AC-BBC8-8C676C89AD2E@gmail.com>
References: <20260207092539.647768-1-dam.dejean@gmail.com>
 <20260207092539.647768-4-dam.dejean@gmail.com>
 <def77227-7b69-4f23-8f68-949173eda6a4@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259835-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,kernel.org,bootlin.com,vger.kernel.org,google.com,davemloft.net,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[damdejean@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 60CCC16DCD5
X-Rspamd-Action: no action

Hi Paolo,

> Le 11 f=C3=A9vr. 2026 =C3=A0 12:36, Paolo Abeni <pabeni@redhat.com> a =
=C3=A9crit :
>=20
> This very close to what you implemented into patch 2/4. Likely you can
> deduplicate the code a bit factoring out some common helper.

Thanks for the feedback, let me rework this and repost once it is =
possible

Damien

>=20
> Side notes: you should include the target tree in the subj prefix -
> 'net-next' in this case, a per patch changelog for the introduced
> changes WRT the previous revision and a cover letter.
>=20
> Also note that net-next is now closed for the merge window; you will
> have to wait unit ~23 Feb before reposting.
>=20
> /P
>=20
>> }
>>=20
>> static int rtl8224_probe(struct phy_device *phydev)
>=20


