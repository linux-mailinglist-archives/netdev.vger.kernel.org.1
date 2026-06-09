Return-Path: <netdev+bounces-297144-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iP1RMQ88KGp9AgMAu9opvQ
	(envelope-from <netdev+bounces-297144-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 18:15:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 53233662370
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 18:15:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=f0YIBmV5;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297144-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297144-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D83A320885F
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 15:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85CB492513;
	Tue,  9 Jun 2026 15:43:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D8E492508
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 15:43:08 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781019789; cv=pass; b=U8kauBILoGsvoEU67QXTNPNmq+rkARZwpv9bFGiyMIe1CTQMgfw07VTAokr86SnkARdT7VCwu2N0v33usJZ9USkAWFZYL42p1RGIAWSsZMIGb6/Pnxe3zvGiN0vVji69T/fy3vrUyfuH1IfTghffNQ2XKIU+Rdk7aOxqy5ntmRI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781019789; c=relaxed/simple;
	bh=AkawksYOnbBwFcd1FvuSVg2iwch9HscqG/sBjj04rHM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IFGtZfTfbSrauL6HD62YQ7JKZsp8spG7sRhNY3uZRsGQS5nNBxmiuo7xdROBw1vwFvRtefogylYD23dEAdXLC6IUDEeB45Rk8A54YceEs+Owa9wpzCxmFQ1TV4bWqd7khDHB3U0vU5fqz9GMWLxIAsuYvIo6058bP/KNVcpjGL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f0YIBmV5; arc=pass smtp.client-ip=209.85.160.171
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-51778077b28so64053251cf.1
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 08:43:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781019787; cv=none;
        d=google.com; s=arc-20240605;
        b=BqwyUpqJF8svZHQyjHABhkO0JJyCS2DbMX/clqt8uaMpYNciXGKRG7V3wLojFWLqM7
         wL87uspG02lDecHdQ+DMKilHFP6bOPkNqaKmgB2ndNSO1Ouo1w9Q22UVHy4h0kIulw8Q
         CbJxaktrgngjGHhQeGOKy9aq72yLxZCAclIoIR/4muJZ1GY3h8AVcOV61cSKqQ+OkG3j
         r4mLoecZnhgnrbnPoY4T57faNPolY04nj3WOu8wVrAWgOzhFG9aGMQu0z6dVEcHbwm3y
         NWPzu7sXOmRt4njPJpbgjDvb1SikUX8Ywv3YMexBZTXbxY4/vxYJwN5Zl8nziQ/uEVS9
         7UNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AkawksYOnbBwFcd1FvuSVg2iwch9HscqG/sBjj04rHM=;
        fh=K7abq2F9IE5JIpNvCvcoXdmIggVYoEYFbQCjlQsEqrM=;
        b=WYZOKH7BFJjOMAP0fvYAsiS4vvboA/6KKIf8+4lRXZI8hNxGFKUkM12dXCnxPJ0LdL
         bLozb8nu6L0TMEeEOSA6yqQDlVNX+o++ln144m0ra4H1RufrTl6bJ7xxKUO9pmU8wpmp
         sG/umccJlMbUs+FeFNKTC6MO8rl4XNyINCxu60YxbuWoBpoDEKFciCvb4EZ9xQTL/SL3
         2UMNIhc5m9XvsgftrRB5wRJshpl0QfODH/8FvtDW8xeHQB4LlsXidN3l/46FJdvU0pGz
         mlRz+x5sE+Hkdwx3GtSZW3ROlcRfylCzdRidh/xJfhMVg1RiDuifMvrms1KRgho3ALgm
         Q0lg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781019787; x=1781624587; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AkawksYOnbBwFcd1FvuSVg2iwch9HscqG/sBjj04rHM=;
        b=f0YIBmV5T7GLDS+VR9jKCMnVVCtSPEKGDjm1znZWu/08UEGt1d9xevQzH6zJjiVwt8
         Jnn2ikaU+Cpi80d0keayH7kA5CESQPx/UKcv5i9rhD9J2la8c+tf7VMTgRhiBwylRdAC
         Zz56SuBFZQer9Oz9uP3Lj4mu4lLF77OGqxUzp/VQdXJU52xV0PMdtaKb/mcxqJpAW3oU
         4KnLl5F2tyF90pj/7nxCazDTbpe3fhYDEjn6FHtjBTWmG4I6nIczn7F1P/z0YzGGk20l
         jH5WIzXwu9Fxz/bJea/4SNRRHn3oWB/dLbe6aqKWm2E+A8svy++tHzAT3Ctl3OzuKavy
         l9kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781019787; x=1781624587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AkawksYOnbBwFcd1FvuSVg2iwch9HscqG/sBjj04rHM=;
        b=kzfrS7+GbFrLeLTURA3Y6iFL/PvBknf4RISXeERCpvbSx8850i4nGP8eE5fMfg/M8l
         NizoS1qmgXBJdlBO9oVdr2cTxXZ9BMPjXHZFu8aJnmbUzrq3B+O44uxjeTSI3hlZFMR1
         3ikowPEshSQEmO9s5FwEBy3sTOkpGE9jJxahyGPfhEtw7HvFYYOPf6TrW+AnJMmql4we
         2yHI4waR/6Y1HLczh4mjlYS5x50y0EH5oZPD2WclRdc7H0NEpmucPmXljtSpCsgXlWLc
         iZ5+RbwUJ02TinGnUqOuufYW650e+kk1N29rmMi1hxb+7kZ0B6KJZLqVwIIt1q0tWXFc
         gXow==
X-Forwarded-Encrypted: i=1; AFNElJ9vhQCYTDJplV8R5pwgbh85twTgYz2YR/duj/q6GFqrTukBU33aI1n1/f9JhC7IUz+lnzoChCg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYazzxCMHSJzXOspoSHKBUhd2I4E9YmgtWsGoU3ZgIQqbBe3T3
	YGSgrpMhXf6fkVRIllEHLGWkAJK7CWplqzcBmd9B9DMlAfzDZuDQJorGq1kbvQlk5LG4lcJo+df
	ghJKta5Y1L+NC2aNVHou8rwdHSdNTgzSGoHMRkeQJ
X-Gm-Gg: Acq92OEnPEsGY+r8hEThExrL9lOPxs8lGZVIGAnmPgctMv/bB4Lk82cuf7bAb/Mpkxl
	YdLACmcCwXw2JVDOx3WlMT5XxYB+jNeDHZ6MiYWjHP8rokPYF76hz1zn5loZWjfPtLZqQOube5k
	K4iBczjqulNn9x8GCrbB+pBveDo9x8aiPwwTb3iKittJPLybY99pnPjqxFICpErFUmLb9j//GQC
	LKUKmRhBROdhqKKTFaUvdeExb2rhKieMowuonl02JnKU6OQ8PuUwNASsS6hbaZhRXcs6fGuR6M1
	OaJRvT+eGZrsw6s+3a42/gjmUsh9a3EXhQYbuWRbTGx1a3p2DY9lyvabLTuZA/+BRQ4uTsg9PIW
	0iock2GzaTGgCnB/kafVoFSB6Xop7pQ==
X-Received: by 2002:ac8:5814:0:b0:50f:bb77:a084 with SMTP id
 d75a77b69052e-51795afed1bmr288388351cf.25.1781019786597; Tue, 09 Jun 2026
 08:43:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605002912.3456868-1-kuba@kernel.org> <20260605002912.3456868-8-kuba@kernel.org>
In-Reply-To: <20260605002912.3456868-8-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 9 Jun 2026 08:42:55 -0700
X-Gm-Features: AVVi8CcxbrLZZy5Pz_-2l5tR_5118v277iVa4YSbwN9i3hIMLXLijUs4PRqIJTw
Message-ID: <CANn89iKNKudFS76k4ZDrD8TxkSViGXLeKEwuPbgTLijJdifdug@mail.gmail.com>
Subject: Re: [PATCH net-next v2 07/12] net: ethtool: optionally skip rtnl_lock
 in ethnl_tsinfo_dumpit()
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, horms@kernel.org, michael.chan@broadcom.com, 
	hkallweit1@gmail.com, maxime.chevallier@bootlin.com, joshwash@google.com, 
	tariqt@nvidia.com, alexanderduyck@fb.com, willemb@google.com, 
	jacob.e.keller@intel.com, kory.maincent@bootlin.com, sdf.kernel@gmail.com, 
	jakub@cloudflare.com, nb@tipi-net.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:michael.chan@broadcom.com,m:hkallweit1@gmail.com,m:maxime.chevallier@bootlin.com,m:joshwash@google.com,m:tariqt@nvidia.com,m:alexanderduyck@fb.com,m:willemb@google.com,m:jacob.e.keller@intel.com,m:kory.maincent@bootlin.com,m:sdf.kernel@gmail.com,m:jakub@cloudflare.com,m:nb@tipi-net.de,m:andrew@lunn.ch,m:sdfkernel@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-297144-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,redhat.com,lunn.ch,kernel.org,broadcom.com,gmail.com,bootlin.com,google.com,nvidia.com,fb.com,intel.com,cloudflare.com,tipi-net.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 53233662370

On Thu, Jun 4, 2026 at 5:29=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> ethnl_tsinfo_dumpit() iterates netdevs and per-netdev PHY topology
> calling ops->get_ts_info(). Switch to the "ops compat locking"
> helpers which take either rtnl_lock or instance lock, depending
> on what the device needs.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>

