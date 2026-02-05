Return-Path: <netdev+bounces-257294-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oFtdH6TphGkj6gMAu9opvQ
	(envelope-from <netdev+bounces-257294-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 20:04:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DA312F6AD2
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 20:04:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 439CD302BDDE
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 19:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D6930DEA5;
	Thu,  5 Feb 2026 19:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vw6I11wU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE7230DD37
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 19:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770318229; cv=none; b=bmjW6fdUlxvZl0RKHXy4dNVfvMloRVPWbPPVzyUjZiwLrhBD1fHaiXSCFyCDiPsSKUhCCsxzknFQB3eOhG1Kh0BTiRH2pT+LxJm8nKtn58FJ9be7ZveUyfWVmqKT3qEgJWwDI0AZDxoiOfKwLGQSKwTM834sCJnfzthHM22+Kp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770318229; c=relaxed/simple;
	bh=/wD2ni17a+X09DLamcGiBxtnqEVcXchS+9wo3LaM3xU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QDmvXcQeYD8kT5XiYwv6jHY8wBnNo+d23Y4xGtRKxHwFNX63TXgOWtUVlEcQvI13ElpnJoSKJdiozhiy1+L+rQqJnnm9E+UViXNtovdGc4p5z81wGPKczHB/v3iheXrx8s43/uC9VZ4skaa0PtLtW0xT0A9ipM3REtlPh8nIglg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vw6I11wU; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48068ed1eccso13699095e9.2
        for <netdev@vger.kernel.org>; Thu, 05 Feb 2026 11:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770318227; x=1770923027; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Laz+RPoNLyJoC2bBJYm8bZttzdcZ3Pgrc3YN6EdV/1U=;
        b=Vw6I11wUJ3Eeqrrfy2t1h+ZHAHQv8cWJ8syejGn4GrwNIaLYe6yjLPopKQUw7hMvN6
         6yei9QaaZhXp3TMBn0fx4v/9rGRdjw3r/ivhs7moo0BrxAv1BJ1R2YN71zVEIJJWJxKi
         ceNG1kR4zdVX/yCLnQKzc9wqOdZgvALsjd3j7rqkMD+tBdH9yToQevxwwn399wtjTRHA
         kjnIuzubD4jL/+QIcnVb1+pKKA8iu/SSackuOzJmZJFpHcE0BE0Yn7MJJmY7rCaodqis
         dqLoFrM+sG34k7lrYqKb+lMwLsZAGBVEX1T6IhQi2pwrCgInP/keTwieiwFXZKfpSvU+
         FO3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770318227; x=1770923027;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Laz+RPoNLyJoC2bBJYm8bZttzdcZ3Pgrc3YN6EdV/1U=;
        b=nXtakg8pD0tT8Gp3N2mnsd/anokE2PiVWW1NCxVzga/BJ7bcHgSZPnLNSI25STQj+C
         KqtP+K+mzFNMwrVRsNHyWsZmxaDyabsfdwdojDAozTdiYjQgoedvY36sLgUEVv0jaiPK
         xE7PGPVBV47WX/B8slTY/x0uY3IKHqeNZl9Wwl3Ksamlc8Slqv/4/7WnbQaQb2uXT+Jn
         LjZyVMosHCxEtxqB+Q6VQPlxMxT0KrVRPxSvKXQMd3U6j7RekcQ/+4CT8Tp3nY7kembE
         kuNkpx2k0APawW9pnD4Y/BiszX4Jgl9khd5OvWmNf1TEfl68iHL8XanImJW34vQKVMOn
         8uaA==
X-Forwarded-Encrypted: i=1; AJvYcCVru/9yJYgbnUEjR3snc2QDlgzWzLGxI9Rglwx1LNJXqApk57sFZLfiiDFp/CgAmv46A0sW98Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPHzroC/L8YlMaKOouQnC3pDMdeH3CJojOKRAlVRjS0Ggrcrz4
	ztlOHvyMtYZ3ziHVMprgwbDQ0fwNT/nY5cOyOMCnBRuexh3KPy78SzEb
X-Gm-Gg: AZuq6aJVaE3jTl4066SaCxUQLcuM2gO42MxJMHwDx/roA9JX0pTpD8wIEhmleByN65j
	tafsuxalYF1+KfsV7SsKqBoDgq+gMFbd+eQyPeoIZkE34nI/84xYC30Mt9n7gM5pI/5KtJlbKOd
	36q0MdYK2lS+un+Dm+Md+3O2MypaetdtnZJqgWQEQ5wCurL1gYN1dmSUQRVcRgeaNso4wSgmKFB
	SZaDjC6SpeWkDbjJNJ9/9oXWGMFtofokuyRl0bDF8bxW6+siLLn/QZiu4CACvaOLZ3tyYXdwgyd
	UH8litSySXs8nMmgmREKP7vj1zq/KfTOf/Ildv4c/BYfGDihxQHaI223vXLjVITtjS4knEQqovP
	4+cD+2lpo0kDH00qWoodcs54FDs3zsQsR3WktZZhmQyxWRA0XTPTbk38UizVq+/sa5zsGOpy49r
	RgEycc4fKilBGMkm0lckSt7SDatAbe16wf52/KWwkWP3i4j/fFP3AYpAEKa8kZ/HdvmMA=
X-Received: by 2002:a05:600c:8489:b0:477:c478:46d7 with SMTP id 5b1f17b1804b1-48320216cb8mr7006905e9.22.1770318226602;
        Thu, 05 Feb 2026 11:03:46 -0800 (PST)
Received: from 0.1.2.1.2.0.a.2.dynamic.cust.swisscom.net ([2a02:1210:8642:2b00:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-436296c0f2esm235375f8f.19.2026.02.05.11.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 11:03:46 -0800 (PST)
Message-ID: <ddd1f32c073f155f61104ad92d4fe7de327ca11d.camel@gmail.com>
Subject: Re: [PATCH net 2/2] net: cpsw_new: Fix potential unregister of
 netdev that has not been registered yet
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
To: Kevin Hao <haokexin@gmail.com>, netdev@vger.kernel.org
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>, Roger Quadros
 <rogerq@kernel.org>,  Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet	 <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni	 <pabeni@redhat.com>, Vladimir
 Oltean <vladimir.oltean@nxp.com>, Saeed Mahameed	 <saeedm@nvidia.com>,
 Daniel Zahka <daniel.zahka@gmail.com>, Lorenzo Bianconi	
 <lorenzo@kernel.org>, Nicolas Dichtel <nicolas.dichtel@6wind.com>, Murali
 Karicheri <m-karicheri2@ti.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Grygorii Strashko	
 <grygorii.strashko@ti.com>, linux-omap@vger.kernel.org,
 stable@vger.kernel.org
Date: Thu, 05 Feb 2026 20:03:45 +0100
In-Reply-To: <20260205-cpsw-error-path-v1-2-6e58bae6b299@gmail.com>
References: <20260205-cpsw-error-path-v1-0-6e58bae6b299@gmail.com>
	 <20260205-cpsw-error-path-v1-2-6e58bae6b299@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257294-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[ti.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,nxp.com,nvidia.com,gmail.com,6wind.com,linaro.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexandersverdlin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DA312F6AD2
X-Rspamd-Action: no action

On Thu, 2026-02-05 at 10:47 +0800, Kevin Hao wrote:
> If an error occurs during register_netdev() for the first MAC in
> cpsw_register_ports(), even though cpsw->slaves[0].ndev is set to NULL,
> cpsw->slaves[1].ndev would remain unchanged. This could later cause
> cpsw_unregister_ports() to attempt unregistering the second MAC.
> To address this, add a check for ndev->reg_state before calling
> unregister_netdev(). With this change, setting cpsw->slaves[i].ndev
> to NULL becomes unnecessary and can be removed accordingly.
>=20
> Fixes: ed3525eda4c4 ("net: ethernet: ti: introduce cpsw switchdev based d=
river part 1 - dual-emac")
> Signed-off-by: Kevin Hao <haokexin@gmail.com>

Reviewed-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>

> Cc: stable@vger.kernel.org
> ---
> =C2=A0drivers/net/ethernet/ti/cpsw_new.c | 3 +--
> =C2=A01 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/ti/cpsw_new.c b/drivers/net/ethernet/ti=
/cpsw_new.c
> index b9fc31eb06134dae33427eaba06341c39eb4b41c..7f42f58a4b031fab4c93680c1=
53383e8eeb8f7f8 100644
> --- a/drivers/net/ethernet/ti/cpsw_new.c
> +++ b/drivers/net/ethernet/ti/cpsw_new.c
> @@ -1472,7 +1472,7 @@ static void cpsw_unregister_ports(struct cpsw_commo=
n *cpsw)
> =C2=A0
> =C2=A0	for (i =3D 0; i < cpsw->data.slaves; i++) {
> =C2=A0		ndev =3D cpsw->slaves[i].ndev;
> -		if (!ndev)
> +		if (!ndev || ndev->reg_state !=3D NETREG_REGISTERED)
> =C2=A0			continue;
> =C2=A0
> =C2=A0		priv =3D netdev_priv(ndev);
> @@ -1494,7 +1494,6 @@ static int cpsw_register_ports(struct cpsw_common *=
cpsw)
> =C2=A0		if (ret) {
> =C2=A0			dev_err(cpsw->dev,
> =C2=A0				"cpsw: err registering net device%d\n", i);
> -			cpsw->slaves[i].ndev =3D NULL;
> =C2=A0			break;
> =C2=A0		}
> =C2=A0	}

--=20
Alexander Sverdlin.

