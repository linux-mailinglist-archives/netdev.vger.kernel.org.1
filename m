Return-Path: <netdev+bounces-272098-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yJKDJkBKxWkU8wQAu9opvQ
	(envelope-from <netdev+bounces-272098-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 16:01:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9941F337369
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 16:01:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BA52630C0022
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 14:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1666395268;
	Thu, 26 Mar 2026 14:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RJqALb5A"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2734F38A288
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 14:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774536200; cv=pass; b=t26U6KxN9TIr1omnK6J3LwBfBDkSsTb0XyNpZTqJ0Boa19RWngsXbasLM9Eti4sUetPHiCB5OM/z9BBjWtzckoCgkIDL9DLhGuoiQY60VJQeeQyff6gUVhCRSVnm8JC5N5zSVmUbmC6wqIyN2DCk/K+suNOcud9B+pDNOmSbgHs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774536200; c=relaxed/simple;
	bh=FVFmAgQz4gE6E0Y4ObIalXmNJsTFXoYF3zXEEXfO3R4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QmSD1ZkAoRBtWycjcHcQFKcpSspOGB8uJ6Dt3RtvJu/3mOWiywpgTqFol2PIIoIcf6R8PJYeX6iVgCNBAzij37E9ZF3M7dSLfUs5htFYt72PEfICXuEQwjcHtVbW9ARo2dje7yuWSFrOOadMSLpVhQNQk8I01WogXPfJ686wlu8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RJqALb5A; arc=pass smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-829afe24fb5so801713b3a.0
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 07:43:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774536198; cv=none;
        d=google.com; s=arc-20240605;
        b=D3ue2LaQj5YBKzX78b9jgd/3vqNYkmlMUoTn5sCVce91ImkAdX1FmzYdZ4JSrgPJHi
         FK3GA40eRiccQsxncVhm75FXn9gL70Wtw9dJkWsvy0/bAM4yV/ySb7Tg1TkZeTnZiejg
         k9759n2oJmbakbTGncgmUgQGzc5OUr5lxthXk6X4uPj339GBvZmmxDeFChMBhYiGOw+p
         d7izIYzitnmRyi+19J547uvElteFzxLih3f4G56beNaJOHZLXjEnoz/s7YlcDv/Pt2sI
         FRRuCUUByGO8P+49kAwC6umEGHkuyB2xEc+No0fvEtTdrUjXcU0UWt/4Q1ZyweJ+546T
         VFpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FVFmAgQz4gE6E0Y4ObIalXmNJsTFXoYF3zXEEXfO3R4=;
        fh=NP3WYT8z2Ci15TlaSQ/cI8Zq8LUdt/h5IQGFjoSXF1g=;
        b=R8i/DIp+n/0o2VgCsT+nd2an7mdoUIY2VBAoZVqaMgTKarR7XRNeqF+ZRJwqoTmoNn
         0T3CwzhucZ9X1Fh/YA777PRfqBDU3fWVTzI9CO0bMHws1hWARWuLlBTGuqpcgTUBh17d
         9EZqt2h79lfW28rCFeTbFuZzd7fS3myZ7c2FY2E1mUmPITECbsSS0G3Ew3KDL2oJ2g/u
         Db732eQUNZwSqEmRhogV7AhSQLPjLeqyUwGwpEkwZW4Q2eN7j0flWpr3OFOF4LyWJbgN
         FoC/pB95FsD0RY+i7rwHRXvKoyJRmQT2FWhKkDobVW6luPRaEKpXCG/su6M2IvmPwTJ4
         q2+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774536198; x=1775140998; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FVFmAgQz4gE6E0Y4ObIalXmNJsTFXoYF3zXEEXfO3R4=;
        b=RJqALb5AAvygIJTVL50uaxLdZMrLhLvw+8ou2Un04sVISYn60ms/0wjR+SdjSEPN36
         Tf+w8ITMwvZSlzJFC+pT9d+9OrzZ+bDOoesuMLLIY/svIIs3OPiLd0t8UKfkF4Av6LGq
         df6NA3NyO1JYX8iz2iLfJUMGtUQOb3bQeDMY/W0H07+BCtu51Q+rsQq/fj3XMz6KbQ1U
         KCXWV+MDCdf/o+XAOiOnjtwuafUStOyj/PTGiDBO0ia2RP5KTW6EStfITMCscDnjc96c
         VUcd8u11sDOeO2UlMD1yKL1DlejYFx48nSki4hJOQql+6h9anr4oz/5PGCf6GFlcDgEa
         pG6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774536198; x=1775140998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FVFmAgQz4gE6E0Y4ObIalXmNJsTFXoYF3zXEEXfO3R4=;
        b=Qzbf3Dz44vnBIT3HoUdaYaWeUXCP4XN34+sYgSY2eNw35OIHPxVK1I4dr5TXFxtmMJ
         oa2wGA7TTXbWY7eOXUKPl6zdawdfp5ZBzRT+xlomENfcN4DKhFGhtqGiviinOOJdnnwG
         echKYKKOVhRp7sefiSM1AEo2ufLvbUVoQ0VxhSB8ZjRCr7gi5isfQma6XCaUdLfeR1S7
         R2TNrkdq2K2oZeDJKNUEekb2MNi1cQ5FKp04GHRcVSdz1ESQNiUKrecOJ0wDChfMUKTB
         X0hOZGsdxHLPkHAQJQTB1b5zCLTRDNAMPeMtzs13DVDYnsLnjkV0B4GVXQEJTefT+XtP
         m9mw==
X-Forwarded-Encrypted: i=1; AJvYcCVLZ9VEe4Ewp9oGEpfrW+MhLzm8wTpR1v7Ort09Nm0GC8bz0CZvYorxR4uN61psQCN/r/gmAfw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9PoCBu5A78hQJRDSRN8ss5OSOXETcrxukuYNa8n82K9M/LAvg
	e57E3k2OZhjKLgdSuL+oLgrmtwDKf7rGgtws0CTXAGz06JbQhvH4fjB8D6UoJ9zcQLchucymyQg
	O2cOemJN1XJX/MuBNDjKsWmLJdDK8hlo=
X-Gm-Gg: ATEYQzzZmyeCYHSLf9U4YTCxcH+OobqfFDGA67ALGgGr651vrL63wAczZ1vUVmXknQ2
	+Ise9lqLezl9Pp4qmrfxcuv4oOPfr/PR7gUj2d8ggD8nOg3s8SM57ql4BUhlj/VmxsW747Hk/lF
	U/OHu4+7NIMLBW6Wp0cdd2kjL+qBG0TWeIMqy4CeFUTVRjE0hLStdTh340t3PE+Kt6D2yRics9Y
	spaTV8A3bu5tweMggMIPZK9ZckzBbF0IEvaMrNKGFx15brVuNyC/SxzIbS6utd+K7BOpFtT7OIO
	UUMvNJr1aDwFd5oQixvzw4XOwIn2ApCPzI42rsxAp2FN6u6f7cbusVd7ej3hOkVr4oEcXfimOFv
	CusxAfZ2+ffHFkWv082euJMzQ4MknFlwHSNMZRsZS
X-Received: by 2002:a05:6a00:21d3:b0:827:3e19:574a with SMTP id
 d2e1a72fcca58-82c6e0c9316mr7888671b3a.42.1774536198060; Thu, 26 Mar 2026
 07:43:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260305013852.3769-1-dqfext@gmail.com> <CALW65jZRyKydW6bs-mYwh2mEn0dpv3opVEr=WczKn_0952_+Yg@mail.gmail.com>
In-Reply-To: <CALW65jZRyKydW6bs-mYwh2mEn0dpv3opVEr=WczKn_0952_+Yg@mail.gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Thu, 26 Mar 2026 10:43:06 -0400
X-Gm-Features: AQROBzCH-dMP5gYoRzTA9-0LoSdsw0LRMs61HA75Mz0OWbc31OaZfkW_Re03PrI
Message-ID: <CADvbK_fj_26MLP=+U+rzOMfqdPpdvFQJgN_fozd2uAjRsfHweQ@mail.gmail.com>
Subject: Re: [PATCH net-next v5] net: pppoe: implement GRO/GSO support
To: Qingfang Deng <dqfext@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Felix Fietkau <nbd@nbd.name>, linux-ppp@vger.kernel.org, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Richard Gobert <richardbgobert@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272098-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,nbd.name,vger.kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 9941F337369
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 25, 2026 at 10:43=E2=80=AFPM Qingfang Deng <dqfext@gmail.com> w=
rote:
>
> Hi all,
>
> In some cases (such as BIG TCP) a GRO skb length can overflow a u16,
> then what should I do with the u16 length field here?

I think you can either add a check in pppoe_gro_complete() to ensure
the aggregated size does not exceed U16_MAX, avoiding BIG TCP
behavior; Or, set phdr->length to 0 and rely on skb->len to determine
the actual length, as done in BIG TCP itself.

