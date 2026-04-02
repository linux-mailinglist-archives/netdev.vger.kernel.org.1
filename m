Return-Path: <netdev+bounces-274704-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4OpvCxPdzmmGqgYAu9opvQ
	(envelope-from <netdev+bounces-274704-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 23:18:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EF5538E4D8
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 23:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F25C6301E223
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 21:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2813B2FD2;
	Thu,  2 Apr 2026 21:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DVJ51DWI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B073A4535
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 21:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775164628; cv=pass; b=nF0DVYm4tIfTm+3LmdTn4jAxX3W4z1DkMJ/+DiIhQqu+iGGFZ5D0+xoZt5zFlwI+MWhdhMytXuWrt+MArBLk4owB5CfWB1eFxyn/hSNc/TFdMLUaleIovMc4aYpVir2eAhsZubnW2xaUKWjB4Kt5/fqTP/kLRQlCevSDWLvW/+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775164628; c=relaxed/simple;
	bh=JYemv0pFJukvLWAyAa8iu4BJ0hea3asYhAZuD5UD2pk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AsG0qoIUR5fQz48qRzM+ehk7bJs7XxKcHsyCaPHu1b+Qnas4r46jxmIC2rlhgmWTVkA7++eNbtU0DhCFhtEwaitHAr6omwDEoA1KF426peFArF8YZYILdm9YNj94OjXALijkneqtpJUZLWuR0xYRVBcO7xAMCFDJGinA7ztZuTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DVJ51DWI; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-66b0dc690bcso1324a12.1
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 14:17:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775164625; cv=none;
        d=google.com; s=arc-20240605;
        b=iHJMhb/aR9muSvXbWHrxlnzTw6VgPkECFZ+ExT4rF4arTaNe7+vh1vnUJa/gQN1Mqd
         8IZBIiMEPLxLa9NNwyHnTsPwyfuKounqmRHo+Hjz5NGxDVyZMeV/GJEcXuQDpxsBHetu
         I5DhTkzzmY9L4WeFuXLo6FL4wsUI58W9fhGQEWesRHJGcLDhNzB7m2jJx+7tYkdYyfEj
         VECIjnBg/kitLiteo0mOBZEASnsaxVFcaB74F7ewF8HJ4Y7s3maPQlM4EWBbYWhsYYoY
         FT43zI9uu85+7xD+iPh6nIYVvbLLyghCmLfisFIE/nHBUddNNr5JWWGUpVZqIKeBf7dI
         tyag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JYemv0pFJukvLWAyAa8iu4BJ0hea3asYhAZuD5UD2pk=;
        fh=1Y6/fLEqFgIlvuKtrxfHEmLjB4St1Azi7szVvYxjXSY=;
        b=Q9/DmeZU3cFPxSdBasSjN3BTzAiXTutrxp/JbUxDItpPiHQV7Yl/VZdxPHvckCkYat
         NgcNBu5aLdMAZ8U7g1FlJhc1AQFI+QF/nf+lgwUmU8/SjsyZCz9y0ETBVgjr5aZdDJlC
         zjJxehMkhNa5Xw3RRuG1SzKVE4FEvBum/NiO+ihLVQRUANU81kYZwlu6pI6mDQNRlnKG
         4nUtmB0RduWbfcfx2WrN2QOaRiTwjVlFCB9gkBTir2tVUdRXBYuB1GuziotGJ/hvd0qq
         UfY4WvrHVK8uC5egiOwX8JOYOGxYbqFehor9ZH0hImXJeesRx92OMIThGjt7Eo2oyv30
         deyw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775164625; x=1775769425; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JYemv0pFJukvLWAyAa8iu4BJ0hea3asYhAZuD5UD2pk=;
        b=DVJ51DWIGVmvUkMPVa8dvWQXoI8HwPjgGEwI/4aWN9F1LCOJ+EcnjNFfHozgXoYw9n
         QxFPskwAZWtzbhMV2452RLmMLijMADld6KZGlx18W7nJgAje+NG1Km1o2BtRU/9fHh0g
         82TWBcUrx8waqJ7+F2U0z6/cJP3YUItWl9RwRvVxDv979EAMTneoiKXVXf2P4mamyewp
         Q1vOSCeyeEbZNJ1az3hX233/uufXsrbeBBZylBBKOMvQJw0h9lPWNoi5QV+b+8el9slm
         g+1oPyUj434iB6kkrQ4dqQxtuLfXHS5ymkOMJ1c5mRkpNEozwUHLAh5Un4lnWLCF70u3
         g6TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775164625; x=1775769425;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JYemv0pFJukvLWAyAa8iu4BJ0hea3asYhAZuD5UD2pk=;
        b=kxl9P+8NYbkatHr0XWPEtE+C3+/KZf+gidZCLvLlfg3tRlL9nrsFOO72h5ILs6aPge
         LichRxxDCnZ2oUxxkkQwqEL5AxvUPXttA8xSmyH8q9jrZPRNfpaGoAnrYy0tkT8dlnai
         Ol5PTuwf+ZNVerHV1BMRGOsvgzqQEYI8okNdE+xHnXqmrLcr9KGnR8hphicv0vomubTX
         IwaufeKzVtUvtVbfUXwR1u1P+sB2OdIsKDJ8UUoGRQjIdEKh27g8HdT5g3giXKevEu4P
         p9XljtQwEn64R9v46HIo//0UuhSWOgqUK0arIclJVygYybc0p9n2G6eFnoJglMiIUx53
         zNaw==
X-Forwarded-Encrypted: i=1; AJvYcCXuBB7KZhWTwHaJSxsAdtbZM9GnAt+u5Y/mEtqljwk8ZfDgiAG1u5CpMUkm+BVNYWHx7A/rzVY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzzrc5HLJSRG12aCd2fBIP5ZPuGT1IeRL5DyhKWMaHRTebTPgkT
	4V3Whv1zOqa8L1UBMDEfxXKsjtkUG8KtfclZmNEk73+OSW0P9e/IKJpnTVmkF9fQGwSLtLxcy55
	rJ9zI6MdMUORwPdjEFW0YYNccf0VXR2XcyM8BkOoa
X-Gm-Gg: AeBDievbysL1AzTRAKMHkwq5QueA3gw+rhv+1IK2ku41zPOkFYj3i8bSRr43PGKsvM9
	qI1HJeTi+gHO9Y0DXvOV9Zxel41fbImw38mzQcJlgI5Elb6hDUQAk+LaewyWa7cbrLq8GN7cGPo
	FKCwHhqYYuLXwH3+2W9ZBvG7wZdK53ksv6Xm77F+Oh2IgWXtDc7VXaFU+YEQoFkWsZcCYIcbLSR
	eTvD4GfqqVrJfuX0DdNODqtc8A9r1b+R+rRaCC3dvZcEhk3AYfw98ktw3byERzcf+RglvcV2E3f
	yBNdgt24pQWYLux5vLIESB7tsHEOzecYdI48mKC/hVAeqrj9tQL1v5mb3Tb+d/iNbgdtBrLY9mx
	spbWP
X-Received: by 2002:aa7:cd13:0:b0:66b:ea0e:1782 with SMTP id
 4fb4d7f45d1cf-66e40f43978mr6990a12.2.1775164624812; Thu, 02 Apr 2026 14:17:04
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402-teaming-driver-internal-v3-0-e8cfdec3b5c2@google.com>
 <20260402-teaming-driver-internal-v3-6-e8cfdec3b5c2@google.com> <j4tjzpbsfu57r5bbqcpo4lfnzzonnmgye23kiyu4la5d7cxuq7@63nrgj4f3xto>
In-Reply-To: <j4tjzpbsfu57r5bbqcpo4lfnzzonnmgye23kiyu4la5d7cxuq7@63nrgj4f3xto>
From: Marc Harvey <marcharvey@google.com>
Date: Thu, 2 Apr 2026 14:16:51 -0700
X-Gm-Features: AQROBzAH5HMbiL0k4hiF5gpVjnYSC-HQWNnE9Kb7GP-2itiiWEQcG4Uq-kpwXM4
Message-ID: <CANkEMgmW693-_tiP8rC7ciKuvLOPwRJzFsP=c2bYdQyHREpKcQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 6/7] net: team: Decouple rx and tx enablement
 in the team driver
To: Jiri Pirko <jiri@resnulli.us>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274704-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marcharvey@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,resnulli.us:email]
X-Rspamd-Queue-Id: 7EF5538E4D8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 2, 2026 at 5:54=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> wrote:
> I see multiple patches squashed here. Could you please split for
> easier review?
>
> Renames separate, preparations separate, adding rx_en separate, adding
> tx_en separata etc?
>
> Thanks!

Thanks, I will split this in v4.

