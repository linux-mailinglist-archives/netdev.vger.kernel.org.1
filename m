Return-Path: <netdev+bounces-307509-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HQXWKpxRVmpN3QAAu9opvQ
	(envelope-from <netdev+bounces-307509-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 17:11:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A05D756450
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 17:11:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=C1O0uUsg;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307509-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307509-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C20383004623
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 15:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190B9494A19;
	Tue, 14 Jul 2026 15:11:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D5C47D95E
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 15:11:14 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784041876; cv=pass; b=mbZ9Ik9N4Zc1PMj7wdaWq0vZK6DRWD9WXBUjkCO59kyc83y2iPGmVcmhewaEllLzk8mJGD3vlZtlfsKuNA+LGSIPIqYG9F9+wMeHIXADOFyu6Ae9O629zYVlfIJF4UBkTrUW0E13F+faMRA++gPPrTdw80LDGpWL5HcLcraekY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784041876; c=relaxed/simple;
	bh=CeOe8BytLTsWfGvljuYZIJXqQAXY5yHjtMlbwzQHhfY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ghzGPCAq/5drQF1VNkIRFdvBEr7/QOTkerYXQZ8ZxOpUjgNU/HJOQ5mvGcx6K99avAOu0eeYqjplDPdQiHRZIhaV6taf9on9YNjf+B/ipDM/FhPM3kNTS1Z/cb44bAQzfETGVKJjZVFBLyFwhF89KJjqumXgjvtO2d/hECrxN1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C1O0uUsg; arc=pass smtp.client-ip=209.85.208.52
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6983f20a8bfso6677108a12.1
        for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 08:11:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784041872; cv=none;
        d=google.com; s=arc-20260327;
        b=mIdBLl7q+zACAOAnxBdlLzmJzm0Z7W69orxTbOynAETs6q+6iARTm/yejSczEGapnU
         oGnm7wDFfJd4IJFgq40rt1FCGvhryyMXyUISz7SFLKgovBwntaFGiLQr/VX6mgr84Dau
         c20f2qp+QOXa6rLHoL4ET2p1lyQ6UEsuuBiRBO+8TfKClMOZGTbNtXc6EJUyZn9ROt1V
         PmbwK9uQtK2iTPCm2mJEfqmoz0uayN/WomUJWEzswqwq6FQB8/TytbLC1QgDzlX9rBcP
         XZcwwLTHnoTVacYZPQjz0nU0DwM+RjxFDwY4dRvkTQAoYICFUFvLCf8Yi1h9UsCpLCE8
         KQ0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CeOe8BytLTsWfGvljuYZIJXqQAXY5yHjtMlbwzQHhfY=;
        fh=yp3jIqh+kr4IpaBIt1Vt0BWNWITLq5cg7v8giImYtk8=;
        b=hFBVlzZSEobWdCsauS9gKapzQPai8dBTLBp1uGO1NLGG7uqregQEVx/3ehRUqE2b6C
         FJfRvIBXkVC77ELqrp5DwJuTuV73vZA9MsWNbRfAqDAfq+nerIw9NYRW36zA1OlD5yji
         Bc+PSSI0N40IiFxemsTS/3ytC07gToyXBNLQIgFrNPATDS+CDCwYg8Ys+vy+35HnTa0b
         BfrOGULHkS7owYeHIdP6UXq3vG5Oz2J2Af72ELyvIUGzFJVr2hDYPMO/YK41VlJyrLdF
         LrJCctVs6qcZiCMD7+5+KYjs4A2vEb7Bz5onsv7JFVWpPC7QSny9Ymznv5cmbdvfKW/u
         5Szg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784041872; x=1784646672; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CeOe8BytLTsWfGvljuYZIJXqQAXY5yHjtMlbwzQHhfY=;
        b=C1O0uUsghwCYJIIdSsHxw8OmnumXHl1hYeBIWGtoE/hBPGRj9906j6nS0AXSfHEQpK
         rwutTtbgeqRKql3Sc7/4AEqe5KatxhCJeHwxwprH9DQDXvyaA5vBeYqZ2TIj9SFB2aJu
         tKVw8AGy/104nv1g/k/jB49Kq3ppIvh5UaKzIhn0pIk/pgcOUJC0KgM0sK6EQyGnPArG
         agu7zRZ0RNp+YvmSUF9mNwgbItGfGbEKNEyOM2RK7JIVskhrvYRHfauNDEFyr3xyYhpC
         01fcZLR9si8PyqRQmu29Knpl2OCHmVakqJdyqSQck14GhzqFANEoPnw2q58HtKX3UATN
         fN4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784041872; x=1784646672;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CeOe8BytLTsWfGvljuYZIJXqQAXY5yHjtMlbwzQHhfY=;
        b=DKOhAjkAi7qnDUs9vryuKNvB5WUN40OHycjFs7iiKNGRuO5+ZebpMKALG66389I/oF
         CUvbxxIJ3/41d6ELZ54I/juuOfuPHuC5cry630v6v8jUdxZdm5BcK5b8SBJTQBWK1g3D
         hN9psKJh4D1OFpzKunDzeGCfiUG3ZB1hdMGm0HCwuBk0su3PtnzEoSQG/GgJAHLX1X4e
         sQLj2/KdkKdhSU3BaZ5A5oVBUiiBIFb2T+R/LNoTQKu2Zm0vPtH66bj7kiaLtr2B4g5c
         Xn0VJZAl7jJ8xb8qg8SAcFKxvoc0i6mqx/NYVy+GSRlE7QlAWHP2qh705YB+/3uR/LeB
         BesA==
X-Gm-Message-State: AOJu0YyKE4GJ6rhGNuPIgWO4Ug8vzfrT5DS3jRdmkXhr18xRStSfiJpl
	upwyt6/j28Thpe2G1bOFCdfS/45+ehLuqtMIKtd/V7qfz7TWSnMTN70J25JC3W5VRPJ/d4bDfz6
	++ZdGK8f7CbUHHH8q9Lu9z36b0jrdWls=
X-Gm-Gg: AfdE7ckPJwxNVcCQ1eflPwaCJN8XEOSyDsWd9CbT75ljpszK7h7Ojva84n7YxXbzMrZ
	vWCa+mWEgoIIEIU+9XmR1TkFubPLelFkYKZl8bBbSq44qk4LjACGMRBo/uRW+wMEG828epXuvRx
	TWLuR7C74n6B/ReJ54yd3yn9OB8xrFvD3Dxt7IhQ+jkrO4uavBZSoI7XVQ1IIunaWwywsddhPrs
	qK+W+0vm//+rkLcOMTXdPKOzAaQSkKvE3Gqb2E67KccyNpVNPFb98j1ts5JBMyn1AYYNhCoEw==
X-Received: by 2002:a17:907:c01c:b0:c15:cc30:6c74 with SMTP id
 a640c23a62f3a-c1667a934e3mr152071166b.44.1784041872289; Tue, 14 Jul 2026
 08:11:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260713131223.279555-1-a.shimko.dev@gmail.com>
 <20260713131223.279555-2-a.shimko.dev@gmail.com> <20260713172244.GA2381778-robh@kernel.org>
In-Reply-To: <20260713172244.GA2381778-robh@kernel.org>
From: Artem Shimko <a.shimko.dev@gmail.com>
Date: Tue, 14 Jul 2026 18:11:00 +0300
X-Gm-Features: AUfX_mx7lE_nN8ekhGaYC-4WK9SqZefZ5Wc8omCFMKu7jWCwLuuVZoL2ZJ8_4RM
Message-ID: <CAOPX744QmBpZvQgA7Om_1DKOZeKCF3FdVc5XaaF8mCFJnQ4QYA@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] dt-bindings: net: add DAPU Telecom
 DAP8211R(I) PHY binding
To: Rob Herring <robh@kernel.org>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:robh@kernel.org,m:netdev@vger.kernel.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:linux-kernel@vger.kernel.org,m:devicetree@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-307509-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[ashimkodev@gmail.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ashimkodev@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9A05D756450

Hi Rob,

On Mon, Jul 13, 2026 at 8:22=E2=80=AFPM Rob Herring <robh@kernel.org> wrote=
:

> This would also work:
>
> multipleOf: 150
> maximum: 2250
Yeah, great

> With this fixed,
It will be fixed in v2.

Thanks for your review!
--
Best Regards,
Artem

