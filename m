Return-Path: <netdev+bounces-296568-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CMyrFpXGJmqNkQIAu9opvQ
	(envelope-from <netdev+bounces-296568-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 15:41:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1BE656BDC
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 15:41:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=QBd+MO4z;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296568-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296568-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EAB7E30191A4
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 13:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD5E37FF5A;
	Mon,  8 Jun 2026 13:41:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15821380FF1
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 13:41:14 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780926076; cv=pass; b=L6lXTQoLcNLqNiBCTBoQIU6iUh7OAoBB+LEgsEmGBLScBC0lIQ/lUVk6Audki6Ti1bUtde4kyShIkyI51PZEqHPYMXamWgO3nrUmQCrmEqh/lqwwBYjOZtSCsSMbIEma8IoP5HN558EVHRgYPQ6rpdcuQJeEJ9128+MkGp61dBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780926076; c=relaxed/simple;
	bh=gqPtMO02JOBAvYao8yA2V7xfCh7/vpydcNCtmrJkxB4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HdLD2ViffhgAX31dvKMJ2fCIsmkOImxS8HCDbzmXNmTOLPJP76eUp40OtPSvbScGw5tyVIBifRMFY7N+dF4iehyxSnKi/nhHybeGlLlCHF3QzwXJ1kTpUhNQbnnlYvUWreUp5Y22UgFzqOEf2Abp0dqURBUHmSs8sx0kzTLWq5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QBd+MO4z; arc=pass smtp.client-ip=209.85.160.179
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-5177b9a02bdso66813411cf.1
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 06:41:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780926074; cv=none;
        d=google.com; s=arc-20240605;
        b=kmSOrQ/wVybnux1kL/VZjNArNigbePk08GkDql/1gdqXW0SbMSO3WsmiBVqJFGtmdS
         /gevzGFdKiSWOUfAtTz9fWfe3uScY7RtgBxwLNFjyMCb34DPAEog2UYny1fu1OHjK0Ac
         IHpB434O5hgiZD2A6VMOscyF9aIjn60qHVkGIX9VIFg2alf3Pu68azX3NQt/Ci7EJyb7
         cDwJ1cDDSfUJZtD+DJepz9Nge8J4izwpt/77y39KaQdzlPa21bbXE12c7qDMI1bXTTAF
         GP6PHVBqGxEq2s5tosNiOqdX7dz7I0HDhfqN9dD1RP1RnxoIAv224WL0KheIjzQUE8SY
         uduQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gqPtMO02JOBAvYao8yA2V7xfCh7/vpydcNCtmrJkxB4=;
        fh=mRd1V115JBh0iglztSVfyCbJkxW+Xm7mOucWoGkRcbU=;
        b=MdMbA+1iGjD1tLaNwR4dFSdKLsBChPM5XyE+uDBNFuK9LmA5x6J/qhcHRwPHsUhTNw
         +m2ufKcwj8oizO1vudBoHSU2qb+aVhlitmNho41qYSZ/csqUEkCQ8Co/6BY9PhF/SR28
         +PfG/R4mKEQk0vZXymRSG9A1LtSRfyS6yfBmecndKIB29HaYbvF+t698ZgPUTavSU1qe
         M4+v35dFW+oGE/K7NrKjNZ3nvR+v49Olt3Taq5blqxF/QRMVQ1vs0UgRbkWGPGVy6a33
         f//BS2dsxjGUl4OWm8EI4NVYq/YGfVjVYCeNF7hSvGd7f7v8yBX6pNfKLdJ5lDJNyvYR
         nKwg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780926074; x=1781530874; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gqPtMO02JOBAvYao8yA2V7xfCh7/vpydcNCtmrJkxB4=;
        b=QBd+MO4zg7Iedz8keI7oW8BYnaTvXI/5dB4OcELbpF6u2StvXvjauUEVz/fFpfbylN
         ZHmiBdZChmbVJMbAaoIcA2z2CfqKKsNZUP4WZKV48Nk8JigZUuVjtYGGrYNHy7Jfy5/Z
         SyZCJIO7bBnLj4tcKlA+znI3j4DUDtp8fSpwqKTLcSMGoDQ5a8z5ZBlqUshNPjo7gCMq
         sQLoQGwHHSF2uYE+BJhw9wSX5Ej8NKG4t3HMjcRerTXBmTvAFd47b5FQaTqsLk3S2L48
         rQGu9DNz9BBb3OzsP7dOobxV9UqoGMtpoJviaPcCcEcqfSKsYI6F+banmfCUGaW9qHqV
         Uatg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780926074; x=1781530874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gqPtMO02JOBAvYao8yA2V7xfCh7/vpydcNCtmrJkxB4=;
        b=LAaReu1el1ZbRET0+C5lRi5cxDFu6Hc2tsqsIKuThzD5lapUApJc5xdmIAy8KYOSR1
         NzmDBqAw5m6I3M7Y7WHC9ONpbNoI2gVxYoAC5vt2Z8+EbZ5w1WoodL14qHhy/e71MhJg
         FfNIpi0L1R9qVVf/uAiVfvKCgt3Inp8c7B0wlNK08UFTbcAtXmOf1B/zBt+YC+V8maf2
         T4hY85jXMFbqnyMqnh4yY22Bodcse0Ww4HHLlkDjmz6V5ac4Sp54pcgxt+IdCuvdffMq
         LcPYLqvN1kxPv1A5CCYsZxV5uV0b6bNyaieBOLH01TIGeUWyRE77IclUe2Bc5rRpwijE
         MVQA==
X-Forwarded-Encrypted: i=1; AFNElJ9MIjxRKjsOoBVPEUEjOyxS24mUqpLkVZnQl23o6GhrZFVag5D2Ve1jzGFNT/ekdW66cuNOYGI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsL/JRZD0j/Q8H2h0QND/oX+P+jCRLj9X7UIKR1bLrBTE9j4jW
	v2PJDQxyVzjBtX5P0+7viKDjNivXK/+leVJIe/1pbvi/F2Ok+liAC/vTIVVIcXvYd3+rANnqWn0
	fQ1Dz2NCYIy7tmrPoI+dQWyCc7sKbyRJ7mVb3Eadf
X-Gm-Gg: Acq92OFLP3XHSb0+HmKSOyj4k2PDrxmoe54IbYaCV9/l49lxm9sJ6MBIErHzda9b+lc
	FEnzxAL88mm5LIYbg3r6tfQoxjHDKh5pR93pNSLscaRS/gy17X1Btfbtr2cL+vVIbn/pgrHgZAx
	nDr/FQT6KTAzHT7fvlL/wusZ4MFSliaPtXUpUL1VWJduu51b6KTAUh2CdpySuM3OGggcLqoa+NW
	Isrpu1sbeRC4yTmOIyEzlzd2v8Elnqb4o6J7Wwo+I70e1aIYSMjKDhINJoye3J5VpowLMl8RCrQ
	qndd9oy+k/okFGDQD0OJys2c6PcQLg2kbVd9qaOMk0RzbTY/15mL4x+/x15YIMAA9GA6XKVGE8E
	fwKwQX3hq0rMcAHC7Mj6ncXfV+yQ=
X-Received: by 2002:a05:622a:aa05:10b0:517:9668:175d with SMTP id
 d75a77b69052e-51796e810bdmr170922061cf.15.1780926073590; Mon, 08 Jun 2026
 06:41:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605155034.3844105-1-edumazet@google.com>
In-Reply-To: <20260605155034.3844105-1-edumazet@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 8 Jun 2026 06:41:01 -0700
X-Gm-Features: AVVi8CegP08QOmdNJp0XdWwAcdz9m8ngdqiPMb9Ul7qlfQ9z9Uwft5FUdjHSto4
Message-ID: <CANn89iLRx0TT=HnPmrD+iBz3y7ve16j-rjs87paSvUN8OzzzWg@mail.gmail.com>
Subject: Re: [PATCH net-next] bonding: no longer rely on RTNL in bond_fill_info()
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296568-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,jvosburgh.net,lunn.ch];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:jv@jvosburgh.net,m:andrew+netdev@lunn.ch,m:ericdumazet@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,jvosburgh.net:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AF1BE656BDC

On Fri, Jun 5, 2026 at 8:50=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> Add READ_ONCE()/WRITE_ONCE() annotations on port->is_enabled.
> While this field is written under bond->mode_lock protection,
> is is read without this lock being held.
>
> Change bond_fill_info() to acquire RCU and use READ_ONCE()
> to read bond->params fields that can be updated concurrently
> from sysfs/procfs/rtnetlink.
>
> Add const qualifiers to bond_uses_primary(), __agg_active_ports(),
> bond_option_active_slave_get_rcu(), bond_3ad_get_active_agg_info(),
> __bond_3ad_get_active_agg_info() helpers.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Jay Vosburgh <jv@jvosburgh.net>
> Cc: Andrew Lunn <andrew+netdev@lunn.ch>

I will send a V2, addressing Sashiko's feedback.

pw-bot: cr

