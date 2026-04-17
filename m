Return-Path: <netdev+bounces-279435-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id BgqDEICp4mkQ8wAAu9opvQ
	(envelope-from <netdev+bounces-279435-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 23:43:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CE0F241EC1C
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 23:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C61CC30058D2
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 21:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 802B437CD24;
	Fri, 17 Apr 2026 21:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kuDg/P71"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F3029827E
	for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 21:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776462204; cv=pass; b=r2es5YkiTPX40YpFSXveBw6E8VMtfHUtIyL6WZvgJ1SNEehrqGnlr1m4+TRFF/Fo4x3LmwNkuuknyNvvLNcxLZoThVoiQiMO6W14z49Z33obBzj2j7yT2ZYOAERWBvEKu+iUi5eLre1A1Ad8mz2HdQi0w+7QNiGEfy5A2q+iW+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776462204; c=relaxed/simple;
	bh=yglK+KYyzCc4gXFpjKt4bGTO9sZSJ/LSmcVavZ+sZmA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DxEa+oqnAOIl/Pm3GzWzBf/txsGHMmSba1XKKY9xz4TDXbwuk321wXwlE7IvgI/8QjqIzAaiLHXBkxntktxvIoNbBtfzxnNK7Xlyv1dopi7nYs6CAugp2nJ0WZ2uEOUXIs1Ivp6/aYueWYZlIH7O7dFga0xwVelTPlBdk5N9y4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kuDg/P71; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-50335b926c2so9539631cf.2
        for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 14:43:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776462202; cv=none;
        d=google.com; s=arc-20240605;
        b=Jev+bkOggWovP5x//0588oEgGYQQqkUMzR9kj4NOrHNyaSianIDPshBRVt2MMoSMlx
         fAlNGtnw9adOnAA2cEDaQcYsmR60yRzLpgzmQrXcGe1zTz+uL8hhNhE2XIxO9sS3nHg2
         qV0kdTNa6oYbw44Tc5AYq8Bx51/s59hbe9aNArs4L/jUn944U1ZtjWrUlLYWrDO3YQxz
         a1wzlJ1MJRyZeBQOPkQ7kbJs4I/+0MXWyrMKJ3QMEFck8t+Zs8TO9w6nu5qzCPZDPgzG
         tSGsBBJoIe7WdTsL5KKLLXj7MqhSvaR0sg/ghvc0NPJ8BHO76blAOgozB/NXovpUOGla
         kgjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yglK+KYyzCc4gXFpjKt4bGTO9sZSJ/LSmcVavZ+sZmA=;
        fh=qf/b4R6qZsAzuzunaEnkXPx70Gqf0KvO7x/NrkqBCS8=;
        b=ddg5ozxGOoX5lTaBQaLhabzRYxvI3vS6hcaK+odO7P2Wd8KluOEowqT1l48on5gWeF
         dIOKwwYaAaPB8OM0VHU7ZbeV2lvCio86+ZxWrzr/OWXCMMktNTGr0FSELZGwLoOkJPk3
         +1HKvrey2x9HzksPE4v7ze27d+XXdocFQrKym9jEMto5uHoo5SdmVz6VtFijCjjS7TME
         XxFcvDfdoyAQYNdmi7BziXNgj3bGqBEZicZSYdikB0pAGQgdvwDU3Q0N3xjCgVzalzK5
         fcpNFsw96Hk2QivsHxseTaoRMstkktVkqJ0UWVjiIPSoCOciezaAx+MhsKfY4cU0GkgX
         K4YA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776462202; x=1777067002; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yglK+KYyzCc4gXFpjKt4bGTO9sZSJ/LSmcVavZ+sZmA=;
        b=kuDg/P71fbYimlisG2v+gmrIlvJ/sKScYUxXRzlqxB4i31CE3+L2T+czHNjrVg1D1U
         /FYzf+tL2Kk01I5An3hIefBUObjhvKDF7hWtfTQFz5Zc2qUoTCRozm2zkN2MfkeHCtcG
         z6DGUFBrNfdulYERZNw+HHhyOwNBtAnjXM0i4OC7qn7l9sR04o2miph7AdDvIUSzqkCQ
         WkVR2S9Bovx1oF2x5KQU+/8qsuZHTOCew2f/OuPMVt/BH3HSz5F9M9D1DaCl0xb/+/Eo
         SeEDAzkuH+F34YxsB7AqvwSG6MQHQSuG2ors4qUXJIRzoFz1cbXhu0FpN70O5zeh6bVL
         4BuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776462202; x=1777067002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yglK+KYyzCc4gXFpjKt4bGTO9sZSJ/LSmcVavZ+sZmA=;
        b=Ud+8zw6UE2VO1Nia7bC1hycQwY8K/uJvqYDncLDAugP4XLyRDZpoOS7vwzfGFd1uk3
         tu8ksse4hRbj1YGYw6Cj9XaNzrHahVdHX2trNLmGJz6x4tHeQMaX8lrhsAaND+s/V/W4
         BSLlCi+R4NRUgPSn5secjlbV+Z/XDrfIO7TEwljhM6iBPmWSWNhsRh55itmMTWbpqqN3
         ATXh3fwUacUPF1GpRzZ+3NZ+iZxpDcCNUCILqdSdNlk1HHbg1GV2CnUNSf9cZaTWwu3A
         b7ut9vrx+MInCUyYVg6nk92LhwDfAT9So321cLb5eI+fERm127hFi+odX/+VTGE+/oCk
         qH7A==
X-Gm-Message-State: AOJu0YziBA6GJ0ho/bC63I3YwcEMOoc88yVdRQjY7EIC1MTmAvoPbRr8
	fVCYm3NrN3ylCM8L88SJ/XT0g6sIucDjKJWIAkqgizyzqm2+OQ9+2xNSr3MQ9ulsYSEKUSCsvdN
	IVKc6sXkDRavR2TNoOGPIa1NIlSKq1NiO2yv0nscx
X-Gm-Gg: AeBDieuCJKRPPDT0Y1+kIBALLA9vCbQIFYhIsRCV4aHfHJgJ68kpaBRglQsHdIdpBMv
	j/1kBk7ubF5zex1bC/paKlxLetaJauKIcn8yVw1E1oOcQHyOlrFiLOIEF/4qJ2YgSsofVpUuF0Z
	HZl7zX23Us9+KKQLOidnssIvHLMy62gBHMQowhPc+jBCsLxM74uLOqKFOWeQjInalsLuBqiCton
	vlT4GEBoKFv0jzA5Hm4B5s0CC0ZXApgb+V9alxcVCTRx75M4cI3TwUWD8cE3JVXkRSBasbih72T
	IuwchYRqeK+6O+4xwJN40KP9jpHy6muI9BY8ttCc37N+ozEU2cCe0PPwchhXsLVf2bF9efNr8JY
	YnJpc7Qde
X-Received: by 2002:a05:622a:1305:b0:50d:8db0:7abb with SMTP id
 d75a77b69052e-50e36ecfca9mr66972521cf.42.1776462201612; Fri, 17 Apr 2026
 14:43:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260417202518.1354891-1-rubenkelevra@gmail.com>
 <CANn89i+zy=YttsDesBzvtSrkdY+==L_L6j4O7EFjYKEggcXbGA@mail.gmail.com> <CAGHX7-OsuADyxGr-QoRRspuXYm_3aS590Ez4zvGsjyPsSKLJsg@mail.gmail.com>
In-Reply-To: <CAGHX7-OsuADyxGr-QoRRspuXYm_3aS590Ez4zvGsjyPsSKLJsg@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 17 Apr 2026 14:43:09 -0700
X-Gm-Features: AQROBzDqYZfp9YqkNryk1ere3ddp84ZDo4U0lzTkeFGinCI7IycsxBR-tXTPqzs
Message-ID: <CANn89iJg5ehYP6Vbn=oS=xLPBURU36qSf=vVWvpnLURkGRJ2zg@mail.gmail.com>
Subject: Re: [PATCH] tcp: fix orphan count order in __tcp_close()
To: Ruben Kelevra <rubenkelevra@gmail.com>
Cc: netdev@vger.kernel.org, ncardwell@google.com, kuniyu@google.com, 
	davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279435-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CE0F241EC1C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 17, 2026 at 2:36=E2=80=AFPM Ruben Kelevra <rubenkelevra@gmail.c=
om> wrote:
>
> Hey Eric,
>
> no. But I'm not a native speaker. I'm sorry if my explanation did not
> meet your or the project's communication quality.
>
> The point I was trying to make is that currently we underflow and
> overflow an unsigned and signed int in case we start with 0 in
> tcp_orphan_count. And while it currently has no real effect on real
> world applications, as we use a 100ms cached value anyway, I just
> wanted to clean up this "old" approach which was apparently chosen for
> historical reasons to circumvent bugs, not because it was the intent
> implementation.
>
> That's what my list of old commits about the history was meant to referen=
ce.

We are using per-cpu counters, folded every 100ms, so the precise
value is irrelevant,
as long as it is balanced (does not increase to infinity)

Thanks.

