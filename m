Return-Path: <netdev+bounces-260168-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0CzdKiClnGkYJwQAu9opvQ
	(envelope-from <netdev+bounces-260168-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 20:06:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B33017BFF3
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 20:06:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 463DC30515D5
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 19:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D820A36A029;
	Mon, 23 Feb 2026 19:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pr0MywtR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF1536A01A
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 19:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771873565; cv=pass; b=DoPF5KiVrMju9X1HFzklNCp3Q6JdYcwkEWpVUwL8vwNw2mOQE/cvQMCo1xFXNpt2gGiP6j2oxfnXb6f7hdzpW3FTnEohQVNCfg9d51O/AFZ14TVqTjxxEZwBs6panHNjTD+uUC1DgyYckeW+RsJsaUHaH3np7U9371ZENlFjRAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771873565; c=relaxed/simple;
	bh=6QB2+HmhY704JueNEN430tG2Ep5xaIsTF/Du2YJI/oA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vgsyxxuo6CVs/ZHKmrCvEFer+e4OZVaeTrKAPLa97AQW+IzvuqhXDp0s5ygdkJjkTgHxE/E7LFlscEKdB5P/Riu23w0/RHcMN+WmO15izU1XBAW0jTXB5QIEBEovOefc/og96Dm6dNMYCT6NaM+0ciZDc3pnBgQdpDHqXDpmlj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Pr0MywtR; arc=pass smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-12713e56abdso3127480c88.1
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 11:06:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771873564; cv=none;
        d=google.com; s=arc-20240605;
        b=eT6yzzNeneEQBWd4daPqYDUzfmnZpWlMdeJI1Qk/yWwtuT1I7BUVLQ8v56OL95xgXl
         QttOultclR5r+fyWsDG0RV2dARBjq4n/+ylaeHq4StXGSFmk9ZCK/GDrX4hO5jdImebF
         6Sdk4fktk1EgvL4EkC78DsB5ku50Tx3UQybYPDN8pzDqroiRX445Ua8Odcqi+KtJactF
         b6f/UoG4vLa8QogeHTIgx2Vvl1Pk/UF9QosEjPYFwr5PxBInqTMHLkIymHn6iW7xaAhg
         R4USBX0NceV8Q1rpVbpSqkWWOb6Czr0Tb/CxWJJTv4wJdJM8gEcv0uZIhorodirXAuA8
         7KHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6QB2+HmhY704JueNEN430tG2Ep5xaIsTF/Du2YJI/oA=;
        fh=sysc4K35QhnmzFSI9lkT+Svr+9r1o6zlPXnq8KOq6/I=;
        b=FvYm6IO2cD4azUkjAn+E3Vo3bD3g1MlY93jZ+2ZUMxQh2Os/767AgZ87efrdJ/ezcQ
         0VLQs32QL3xbySDF69CFBRj6eRzch4nm4AFCSSDEFQS8rKj/WWjiwMVzSGMwGTs4syeu
         eWzucBng9O9D6KGdewLXd25iu0kiKU+3Izx9LhxDzVVah74L5bcEVze+OvjN3SiWmwMz
         JGC55NAEJ/cm641N/qiyFPEoKhVz34U70woKuWu9cZd+ld3nqKCOctA4zSrDT6ICybm5
         iAS6e+uZ3xsXrFDHpnhsTk5ZMpy9Mt5MwKnpbaawyq9xiPrd7Uj8yzxUigxXSUI3hcAx
         ZEkg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771873564; x=1772478364; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6QB2+HmhY704JueNEN430tG2Ep5xaIsTF/Du2YJI/oA=;
        b=Pr0MywtRPC39GMhD1VhvAKQLNEqdrrRRWj92zTO18BwHNdeTjtQvbtnaEn8knH85YI
         eYfnd/Qrg/kzrqh9NvVnxYy59+AmCkKDSbRFF8rJJ4Ig0Jil0Z6mu5KPgInRTBl0hLFO
         J8G5UTaCA2yDn8RDK4cR3cIMEZ0B6lfVE3KOU3sLChgohepTKZXaI5EH6Y5Sjh1vJBbT
         1a5TDvmM9O5FPjqXJUy0ETkGxsBUADhHwqc3aWZ5Q214DcJ1gzO5GFglEFQ0acKQ8iYq
         IEg4ZekSGJtupvL974qIIpty7C8/nEzqSQjccLCYJzB7xZyknyQXfnMAJeIT4FqvxMCC
         Q9RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771873564; x=1772478364;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6QB2+HmhY704JueNEN430tG2Ep5xaIsTF/Du2YJI/oA=;
        b=GywNzRgwYcNBXk3cNOfinpEeflDCK6qNPBtyfZuOuK2cwNSpqR91QcJ4pAyy4Rs0K/
         k0uq0Dt79NJJ29CtrjIdJPNnLE/LCIUUpYiN9hVJm/54sn5atknmkHhXQCi0xVidN0GC
         Lg3kj/3Vui+36+WGsjYSDofW6pqVt20bPHkTqtPgYlMVCq5w90I39rK2TEEpv81W7/A/
         gL3xsgcI3mU/93NX9S8io5OPGI+iS6aF5h3ZyHoy9hih+c9gzfq3HmgHLsaIGh57OxfO
         7MKh5EnHoHRFtIrWSrzIOG4XAhW6kiwibEpDZroPYeWkqbjfAukK/fNa9uS0qMB2DFxe
         6xOw==
X-Forwarded-Encrypted: i=1; AJvYcCXCt5DwMz4or4LnE6tL2brNz78etjWvaT9uXm1Kb0OirVMMoDt24IOQ7XMNr/N7icPze1+7Y+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQJqVamDQgGc8olXoRSRmalnsKGFhiHb6NoydLG52b2Q+KBg51
	a4hPJDCgPocN/NfUmvLDnmOcGbb7HQd852AiFwKY78KuekIqYK5ltyoyoO2DfiC37MJiE232H1m
	d0AL0z8jZ+GzQ6DV0nNmTbTdB1/tQGamiKViVY2jL
X-Gm-Gg: AZuq6aL+y9En0b3msifwUmgpmriB99M1+IXdT0tCTfuo+qHuK8PpMdPb1M71xcA2CXN
	bXmMYxcD995I//PteECCVl8ptIuxlloPYZe7KR2bz3MXLmdjTCyjUEx6vciu9G45jRUFHR0mfFE
	ccgut8fsFm8ZEqfBLUmgXAgC9O4goagudXC1wHPyNGMhmmdjIZ+W4X0nehaiQMN03E9Ybr+DPUI
	qD8507oQZvvBLFChq2nEiOhd2lx/PTSYA2n5kFB1yBc+pdtgN/XIAVIVegxzM45FZLCxwHeFQhG
	rsv9wdRzQUHapk4B5ao7igVb+3VtzBByYk3NsPzCCrnECqUyVQ6DMmEiBftgzXNqTy4K2Dbn
X-Received: by 2002:a05:7022:1602:b0:11f:1e5b:2dd6 with SMTP id
 a92af1059eb24-1275faa7f90mr6519573c88.17.1771873563260; Mon, 23 Feb 2026
 11:06:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223161742.929830-1-edumazet@google.com>
In-Reply-To: <20260223161742.929830-1-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 23 Feb 2026 11:05:51 -0800
X-Gm-Features: AaiRm52kNQn2jnsT3jry7s5Nfz6x08nE1brCrK2libwLGoNKSOkBH9vUhVn-39c
Message-ID: <CAAVpQUAiPW=+e6cL2LreEhT-5B+8JJ4oMQhWWRCSBB=h+TXbWQ@mail.gmail.com>
Subject: Re: [PATCH net-next] icmp: increase net.ipv4.icmp_msgs_{per_sec,burst}
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-260168-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 1B33017BFF3
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 8:17=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> These sysctls were added in 4cdf507d5452 ("icmp: add a global rate
> limitation") and their default values might be too small.
>
> Some network tools send probes to closed UDP ports from many hosts
> to estimate proportion of packet drops on a particular target.
>
> This patch sets both sysctls to 10000.
>
> Note the per-peer rate-limit (as described in RFC 4443 2.4 (f))
> intent is still enforced.
>
> This also increases security, see b38e7819cae9
> ("icmp: randomize the global rate limiter") for reference.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

