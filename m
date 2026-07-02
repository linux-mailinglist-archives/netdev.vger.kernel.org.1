Return-Path: <netdev+bounces-303918-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nydiFSPSRWoNFwsAu9opvQ
	(envelope-from <netdev+bounces-303918-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 04:51:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB756F31D6
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 04:51:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b="vZ/IsG5/";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303918-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303918-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6530E3019FF3
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 02:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E18130C34A;
	Thu,  2 Jul 2026 02:51:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6651F2D9EDB
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 02:51:11 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782960672; cv=pass; b=lQh6U/Na8NgzgMtbiGYoJycIYZtcfa6nZmggWE61dWvzzx8rHrkToxVPB1gUhjMF1rNd541RYGlYNWNumP8B/VMb7iDDyNbERNSLKKMmaTtYjDJkwYIpvXxF658AaW1yPmLAjQK5qgsAtYJw+ZJj5QKY+8hy6aWIFD2kafT/9k0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782960672; c=relaxed/simple;
	bh=V02uRyzPsmfh462SnSvkHOPH9vsl+Tq/gut01vTXNzw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IjKdERT43439R6NBlJWBO9JeortZeAigc8Ur2xfZEmPdYkHHjdfomR6EPrkk+DiB6rm213pCrLz3RD31wWlwTH81h6ElrpAdZI9scEQmUqNtFjPbnUQf6uQTEoC+waek3oOawn8bqN+4ZSzi0QnNMZaaAHvU0X9jTswpYj7UabI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vZ/IsG5/; arc=pass smtp.client-ip=209.85.216.53
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-37fa53bc22dso969584a91.3
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 19:51:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782960670; cv=none;
        d=google.com; s=arc-20260327;
        b=g7CatDn1lbULIDSc7duzRNpb15/y+o0fz3756apRVo09PjToNu3X70CQRHfuwr+GQF
         q5pLzyrQ9XVrh5nAgEC7ja1U7A9PW3mXBtcBAP36hXnlVm5vonivGxaHjoODmuWQyu6o
         nsP13d+PzA8dkqtZ6c+z1dObqikwDDZflLY/NVJzBfs+DwDUwsR22NbJuYvB+BFU8CMA
         olEckSAqBJqZMF4L0W/UuIb/QnMPxYrvAj8vQUQqZnRZf+LcnftZDZkW8A85XMNSJZTI
         ZQX8192b9bhooxRksqAg11A6hbCMmLAaySVIkqt8B7GC5gSvJ8NunQb/x+S/XZBfj4fp
         MYlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=V02uRyzPsmfh462SnSvkHOPH9vsl+Tq/gut01vTXNzw=;
        fh=kvxtgn0tesWsX49HYx/0n2KcgWkyYkJ8IRy7enhrYBY=;
        b=sa+33zPdkMd+t+jQjbXuhVDmqCBGiY7UkLyxY3/afkf43bgIgJB9ivMh56MxY2gLYg
         1Hc+kzhFJ5WbeJql9ynthwvxFl9F8vIyCUmt4AmC7/J/uV2aINuzxHu80NKgypmnMVn1
         LQv3RIxi/+NzP7b4yWxZVCTCwfNW/2O4lsXfP+i5xHkj+7RhJZhqMS0FgjkioJIR/18j
         5R62aHeCR+3pP7/F5z3yiMRWKKA6hroQQfqNCscZi7V8I/3EMPX58QYeAmXiAk5UAQUK
         NF4zs2HVi3CQfO1jwRFU2jGLjJpxG8YyjdqMFDMcsxbBAniAJhIrXk3wSltxG+MABUe2
         HS9w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782960670; x=1783565470; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V02uRyzPsmfh462SnSvkHOPH9vsl+Tq/gut01vTXNzw=;
        b=vZ/IsG5/hDs1a+IkmYHP4/7aqE0iAeqOYDTuHgZFoLUSQSmD0r+ksoFcB90KNVp5WZ
         hPwy9EFuMw0OPG5DPB7k+Hkmn6ovufZsdD2IzIBn9SG6XUsZzeNL1vo2yd+SqqN0Jhv4
         U+P3MuLtTXwCyWjEhEakP5HfA87fw7wbiXFVNMuw7bNQwjpe84KvYE6UB6fPZiJ6hi3g
         Azrae3IMUB4wrhPgTBKvAGyAwaYJMX7GRwLoGrp9IegIRViuLXTF9TOCBdShZJTPGjG3
         zjjV9ewxsF9MFCxoKSYIW/tvlBcGJm2yLyCyIoVIaudSF0v8J7QA1qtqVHi3isnH9oz/
         BN6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782960670; x=1783565470;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V02uRyzPsmfh462SnSvkHOPH9vsl+Tq/gut01vTXNzw=;
        b=itkK9i6uBddMuP7L5Nec5hd52gaqbuzxSPoXk0cby77HN3E0tBRn4jqLhSTY921kQU
         wNVvJGGVw5vOt5L+WJrOt17F/foG78GETP7I0iQ32i3t06SIICJRHtQhluVWwGFJOSaN
         18RR4j6zRa5SGhPHiVyAvc61bfrR5OpSxRWSrco7UBtgzuRlcCuP304eh6oVr7zjaSku
         C7gDNvJwdZE1PHi4uWBSK68XaZGI6zkhrALM+sSTiPwqyqwR9RVWXoYQzSLq+ue2nWb8
         gRVB46ZajheroSQbNnufiAJeB0cBxMEMhjBjrbRMYEPYiftSEV2VttfiNB1Ef2HEu6w4
         basw==
X-Forwarded-Encrypted: i=1; AFNElJ9MljuRau9HW+X1PZ8QiAAY7plm3LvNrOaGQn3dSAIIypLm4j6wRBPUxbkZdpgxZAiDkYMFigA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlA/pWaEvr82bSODCipKzyn08uE7rHBrPpsDWvfmIDL4DDL9Nt
	QSIHhNCl/pJbMyKGyvj1nQuDkQlcJtdqWOuj7lg1uXkpr9pt5qiA/Q3uGTY6CmknI4nJnIUAzWW
	QIrLHEYzMWGwj8ltjzp+fYMp3q5kNGGDMi2EY/GC7
X-Gm-Gg: AfdE7ck+LVZ1GJEDGBT5R1/vV8ioLBLmo4D5eCjpvDNYe3C1PWXaDpD5n1SM470emzl
	HEdJjWQdzZq2UyEJcKDaT1Irwjs0UxYlhTBtCqIz4r9VldAf4LzLw3p1E1NINFsMicj1lg/ccXE
	HPw2C12+z+8gwk2/XT1cKXIChTujSvFcpQTcNE7pjJaxaOt7e1KyKtfaSRdG3o6OqvdbYgiBk2u
	NPDRph67uinp8h8eEfxbxuBRG7mWnJrP/Y2Tr0k0vQ8bwjl3g93J8NSqiR8obP6M/vTF2VP3Lzr
	++se9oZNAa940iaUctgEp5Xsm2/ptlK+9HojqalclTzBxVeGW5RzPG+eGrqMVyooEAlyz+3MdVy
	UHjTb8JK3gu52pWnRF0ng7v9Lkx0t+RFPXTN+NecPLxK3nkvpwswk
X-Received: by 2002:a05:6a21:6803:b0:3bf:aab1:cc8b with SMTP id
 adf61e73a8af0-3bfed559c70mr5143888637.46.1782960670152; Wed, 01 Jul 2026
 19:51:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260701122329.3562825-1-edumazet@google.com>
In-Reply-To: <20260701122329.3562825-1-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 1 Jul 2026 19:50:58 -0700
X-Gm-Features: AVVi8CfLmfTwGshneuQeMHmMvpysNEPz1c1l5k95kS-d0rK37SU_sfica5o-27c
Message-ID: <CAAVpQUCQTXdPKR_pzpkYN2ZH2=baBcV+XzeenjyoXU3zJ6rb5g@mail.gmail.com>
Subject: Re: [PATCH net] amt: fix size calculation in amt_get_size()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303918-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,lunn.ch,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:andrew@lunn.ch,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EBB756F31D6

On Wed, Jul 1, 2026 at 5:23=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> amt_get_size() incorrectly used sizeof(struct iphdr) for the sizes of
> IFLA_AMT_DISCOVERY_IP, IFLA_AMT_REMOTE_IP, and IFLA_AMT_LOCAL_IP.
> These attributes contain IPv4 addresses (__be32), not full IP headers.
>
> Replace sizeof(struct iphdr) with sizeof(__be32) to avoid over-allocating
> netlink message space.
>
> Fixes: b9022b53adad ("amt: add control plane of amt interface")
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

