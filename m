Return-Path: <netdev+bounces-256063-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UF8uCRRNgWlMFgMAu9opvQ
	(envelope-from <netdev+bounces-256063-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 02:19:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 77772D34D6
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 02:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E322300F5F1
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 01:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C34219A8E;
	Tue,  3 Feb 2026 01:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BcsWNEvi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8C821A95D
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 01:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770081520; cv=none; b=UJu+4vYQE2UU5WPB5HzoeWhXI/nN3N0w3I8oMLhKkJUYFPwNiU7OoJToRr2FZEbS7sjCGTFT6lWYVY5TzJgIMFChiCaZYZ1dLnLkZ9r9MrtSfg0WID0wb2FJLjx/iQPlu1gNdR3zi+LeGQust67/7oNl89+8nIeMDJShyAfABFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770081520; c=relaxed/simple;
	bh=AWut4A5EvZmuf8e29UygC5BAvfCGnf/3txOaKO7qA4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LuRjfBVQ/LSfyOhPv7ZyeqDDX0ywE/YLzaeukTKQOLl1PtNyFSeRrpeUSJbka7HPc5IZFNi2soW4F2cHT6G18ZTzDcqFUft6avqjKhohLjVlIE5BLFuKhgz1hn79u8N493glO6RPV3h9d0QxNq1nwjscmoFd5ZVaM4jJGCTlUgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BcsWNEvi; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-88ffcb14e11so70602046d6.0
        for <netdev@vger.kernel.org>; Mon, 02 Feb 2026 17:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770081518; x=1770686318; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AWut4A5EvZmuf8e29UygC5BAvfCGnf/3txOaKO7qA4s=;
        b=BcsWNEvi8C4q4HxG/jdJRH5qkECUdovypl0yj1sm+OMHm3plkD3BXVD6WDxo/TOrw/
         5LAX1Cyh1VTzMMBZqbZmVak8cmTtvpxckaoq/mOFVateKUdZXY9OGGnN+g0uX3GXqtJw
         3qj7WkDecUH5R4/QYlb7tKn55uJBYfL/1ye3t5FGchmgnpxookoX3aOAdBfC5GZ8hRz2
         850sdt6ksKwttYmMLdrBENCneXbhzbQUgtAOwh0R1HkXlxPP71KKjKbThlEyqEwvr0Dp
         KDb4+yYraUp91J472JmlL1p4HVWPCQ3g0NPLf4RnaexUWc2iEak3jX4ISd6l2H/6mf2H
         Klew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770081518; x=1770686318;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AWut4A5EvZmuf8e29UygC5BAvfCGnf/3txOaKO7qA4s=;
        b=MtufUhi6Kl8F5uFh4xoggElCNJGbUNMhBk3J/JEjiyobNx4uuYh/aTGy1vDL8dpYJu
         OBQr/jBNYxkdYD6VRyDKBEpTKqNwwveJ8h9trtOvbCnOLLPoIyyTOtcoalE0CdX7OPW5
         woac5pNyDmqUs/NJ2XKqPS5YcGQHJNq4/UrnQcuV3f/dR+RKkmEj8att/nF6HOPes1zP
         riKXthFUxlgeuQhxhw1ASoopM4dsxZh/AjJWknLLIN5930v4ozjg2j+mxJXhjR4Z/SFE
         keXbo8fMXyBGjzFTjobXeWUmXc633xBfnZWs0JpUlEo8A9KVogYr03BnWTYqDRU8ssci
         KAmA==
X-Gm-Message-State: AOJu0Ywjw2HODafVO76h8oEFazmoAtaAMlSFLNnBPSk8lzNnSrgeSaGn
	FOzq7uuKqzZGHOgrX8HmgyhB9xD5ztKoCWqtq8ewTfSpuExqrbO0lMtA
X-Gm-Gg: AZuq6aKI4IBSHF75FQy7O0nCCY+reoIWqjYfJVc1DpLK8Ug8cUWEBFo6YFc9pwUQb7o
	Bj6VTBqCuZN/akCi+ngH/lnWyOW7Cg7RIjeQZSfsMeFo5+TxmpHYAuN873LIcGfoEKvInxI7ntN
	/hoY3hyUO9ev5obwVX/zJayQzbZg2lxueli5eJnNs12mh+xf9ZadiJRhT+oaCfCUUYD3hWIv01A
	ASMWXwi9PVoeALu4/lFk+/4X6dZQlPlPv3VSvphm7uQK3oFgEWsgGMSV6oRH3WQGnb4KQqmKxHQ
	dZadGYcx6FlFDCuLQ2XsvHkiT6L4ZCFajlovW89hqaCdEKmA1ilwaPdHkGtgYRpDdSCVRW2hKJ4
	1/SAeJ67+Tydw7+js/DTGSIKCdpVAr8JbZJe6NuznNVNpuJCVyCJFwTa0tFzZYYJhXKuLY502gn
	n3knKdZ2M=
X-Received: by 2002:ad4:5ba2:0:b0:892:6f12:608d with SMTP id 6a1803df08f44-894ea0974e8mr209720416d6.57.1770081518206;
        Mon, 02 Feb 2026 17:18:38 -0800 (PST)
Received: from pek-khao-d3 ([128.224.253.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c711b7c789sm1347330885a.7.2026.02.02.17.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 17:18:37 -0800 (PST)
Date: Tue, 3 Feb 2026 09:18:31 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Kuniyuki Iwashima <kuniyu@google.com>, linux-omap@vger.kernel.org
Subject: Re: [PATCH net v4] net: cpsw_new: Execute ndo_set_rx_mode callback
 in a work queue
Message-ID: <aYFM528IM43_fXwP@pek-khao-d3>
References: <20260130-bbb-v4-1-2bd000a15c34@gmail.com>
 <20260131124120.744bd931@kernel.org>
 <aX6pHiB0tk6xvrCX@pek-khao-d3>
 <20260202161918.54be9315@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="evuoqMsTIgoryhj6"
Content-Disposition: inline
In-Reply-To: <20260202161918.54be9315@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256063-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haokexin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 77772D34D6
X-Rspamd-Action: no action


--evuoqMsTIgoryhj6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 02, 2026 at 04:19:18PM -0800, Jakub Kicinski wrote:
> Unregistered device is not freed yet. The netdev is only freed after
> .remove routine returns. Passing unregistered netdev to netif_running()
> is safe and will return false.

Thank you for the clarification, Jakub. I will move the disable_work_sync() call
to after unregister_netdev().

Thanks,
Kevin

--evuoqMsTIgoryhj6
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEHc6qFoLCZqgJD98Zk1jtMN6usXEFAmmBTOcACgkQk1jtMN6u
sXE5SAgAsRYktD91exFTnCzTnSMkl2UAj6TGHGQCuhocha2Imq4TEFNe2b1XLHjL
SPzZa6eCURAWHejBF596fz6WepH2a4RZKOj6DWudDj3QAAZA2gmGVSgDdVysjgC0
B+Ov/P2avXJWTKSrfTu7ZRNTuG1dfRHQ+x4cDfHHG5mRWxGIfafTYeRh/k7Zxt5T
lTuwy6+dECR1xM/H22hLhjxeLDUhIbXs1jrUgMLgJBG+ZTQWHAfnIRTF7iAbb0MG
T2y3955RkOSDMSVqjdn+56i2Algxme8f95Nl1iYgBz99DPaNIYTKsVxLj2ofET/K
oHnc/ESoacxGy9ssYMrpokOI7zH2EQ==
=Rrs5
-----END PGP SIGNATURE-----

--evuoqMsTIgoryhj6--

