Return-Path: <netdev+bounces-285538-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJUYMvEY/WmcXgAAu9opvQ
	(envelope-from <netdev+bounces-285538-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 00:57:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA904F0074
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 00:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5F3593043692
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 22:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E097372B5A;
	Thu,  7 May 2026 22:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U20G/M7W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2173B27F1
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 22:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778194586; cv=pass; b=bfp64AH45yXHpQFRhKXVHL6oR0i8DkxkbjZ6uxpF+l/C3Z9etkP2GQlpIB4w0Ge9oAl/8+NL73jxMGkv7sfGhYyYCUMDhxeF3oE1+YoQqMj1S+F45bnwc/bZ2K5e68rDviAjttazJEcFHQStVkNzgAvoLSbDohkEXh2mMFOj4qU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778194586; c=relaxed/simple;
	bh=GgIxkriM8U1gxLSNkIPnw/ikY3kzH6BWxnfvfx7jGXc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=upMWwj5jxH6bqqyeKtRktTHaDSWKsN3PzBIq4yWmL9tNN/NEz74xDlg73bLGgjgYDjGUIT0aYBNEuSZKHfygG+OEDhzgfyRVatLqpZ1FRNLDpUHLwTfwKwY5J44mKgzbXUlysGGWxryiatCyA9J4xvzfgPhpXrgO/Koqb2JRoBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U20G/M7W; arc=pass smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-132536e7af4so1713031c88.1
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 15:56:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778194584; cv=none;
        d=google.com; s=arc-20240605;
        b=cNP0Dtv14LoqRsjupMXk7q1OWP0feSHrhreTEbvflHvwgxtevDNtmFipuYQGrYcD2e
         Si5E2zUuXxwVs3qjCIcjMHg/PV+0NdgDgcUzOn92YORvyxL93tQtKrHzAgckZsV2TuMz
         95noKiDU7lWpUzEpwR/k7I2kti5/vXa3LGu9ZpiAL3XE72FZsQYDB9djKb7WP4LRu61c
         2aj7V1LCpOnSldA9Dctog7ekaqJdZFaHosQ6g0DzW57Se4i4HzaFbVg7O+jwSBQ+u7EA
         0FGO5UCqqI/IDtt36slDuApCC2l5nL9G2KiyURgHM5k2LIR6WTyt9mL1DN0kAgcU1b6u
         9ouQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GgIxkriM8U1gxLSNkIPnw/ikY3kzH6BWxnfvfx7jGXc=;
        fh=X11U2xe1/n7U/I8VlzcsS6gGiHT8msqFDYaU0jEGYaM=;
        b=KbBbdv8Ul8uKWOF3ox9p99cCymRixPKFT7GPbCmmMVxJFD/pY+HbYZVgq/H+SgLsow
         S7SXidlk7tAsypzpf6itNz+kMWmyNtikObxK20Tf1iI34aBXJKpSh0hZnnGQyg+nna4l
         UfNUUKdu+nfzGTmMm1tN4bVwB/Ks/UIx6/WQvPe03MLtuh0YC5Sf5tcM/ddq0xsc+D+t
         v7myWXnSZUzop5V7sZ9fRhRZ0MPW4ig3Q1qMwAbIfh6crIW8p72SdER5pCcW8seSCy2N
         1xfxqcIRLJfJooWY0EZBVwTgVpaUt89bIl9pRVyb3MCKAvOeatIaFdHga8pe/J4qqy9X
         OnNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778194584; x=1778799384; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GgIxkriM8U1gxLSNkIPnw/ikY3kzH6BWxnfvfx7jGXc=;
        b=U20G/M7W5CD62wcxiPR/+oRfNR68K36Vj+Z7Uz7gvKxco2lw5+mwfDNLORBwBQqatN
         fFcgomRX8hzhzPDB0NE4QRN8wX1602iKKrvnUf6NAyM8FAGK9n8tanIJdcyIul/86+/T
         h51vcxgy0seEiwSSXGOdtwXJz80d4zyK8St2+Jw6xQgj/sW5jVWfP9LLgR8tjZUOBp//
         kZ9Tvze3N+0NWJH47ndwwb9RGfLMMW3W2uCISuIACUoPR7XPIPLWIG5XAASPKuPDv+Gz
         ITMAd726qB3X7xQAkzyUcbUmrAQAfZSxmLfxEzYnwFuT3gCMFQ65xvJ1uOJ/t9rbkoeb
         e00w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778194584; x=1778799384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GgIxkriM8U1gxLSNkIPnw/ikY3kzH6BWxnfvfx7jGXc=;
        b=bmTe41w8EQYPrJHEPulRAA2aF0P6nqIAbU0d81SGDKw40ZoETGed2hziO0g6W3dSWi
         pwl3MZCh7khDm07PQzwnGVA1kHAkzEOJbBKrkqnl2c1pjFj0oIoaDfXjgv2iehMm8dFZ
         x1VpU2FzosLJgJ0H0pQXOJl6Mx983cX7LRJy6ed9e3D9rGGUHCX7PgfxQXHjLw1IoE8u
         h04p4DeXAQEH1Y227+JiMFvTXxGFTwPKDzzc4OSZmOQ4dqBhcQRn+zJs9iw1pZQ3BYL0
         5nGNONBuXk9eE0TtfCg135WpTX9R/ofcsdp6vlam/nt2/Y/ncFHaAvZ5M1t3xwM+gtwY
         UIAQ==
X-Forwarded-Encrypted: i=1; AFNElJ99Myua0SHXE6CXngfZmhifVHF6F2q86arqGXgaTNYkrJosqNcCFNrXbx9z0aKXQcaF+B+tyaw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzequMheUGhF+zYjrvigcJcolZB+Vd/PjMyuNQuAcN0OtOWgsBL
	BcmfLfuUKlcwn7NoSzqS08K5XUcTzR86oVaLo/e+pbIXc9dsSQhKdRhiyfb9vEFsPw4zbxMv5Yd
	u6I/uP+reeuu+Y3lY+DHLmcudTY4GF1Ukh6rp6wuD
X-Gm-Gg: AeBDievyhb4z2wUU6iSS5faJ4nBiwbXMYV1G1C11IM9LgQ94mCKqNanmSmYT5mey4Yc
	BEjrfo+DdTjEF1O4SfvVEoA6rs12gZXj6zZwU8aPQXPiJXcgRxH1Ftuk3YBIWAzgoEuS6KdVnIy
	FFADppjL5QJpVXMjNfpHUlKlnmzOATAIYJeAs90pu5qqN5nORNorPZtGknwL7qJhexV80V9vYGu
	l+yQE4PnBC3kxvB0P5Bj+ZU3ypr/vGy6ImnjsQXhTfUzQfHUT0kZnzrxHvKerVvTY7OvPW5Absr
	N0pSqe0xcslhrAk80GVlbKDk32QrM2PikRzgag+nT4jJYIuNvynQSz12V7u54+Jc3yA0tUiOCNf
	wOdu/WyjT8bAXCbwDDfN5XWgfhpoSnSs=
X-Received: by 2002:a05:7022:6087:b0:130:a519:9b53 with SMTP id
 a92af1059eb24-1318ea2b2f6mr5215747c88.31.1778194583128; Thu, 07 May 2026
 15:56:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507084305.2506115-1-edumazet@google.com> <20260507084305.2506115-3-edumazet@google.com>
In-Reply-To: <20260507084305.2506115-3-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 7 May 2026 15:56:11 -0700
X-Gm-Features: AVHnY4Llkd1ueiPSJoU-vxTM8fgh3pKj1DFScfun1vt5RpwPQIb7G7HlR2pGh-c
Message-ID: <CAAVpQUD5fjbvQUzOesZHC8vYNr4oBkaQ=wnx3aQGq64_j9ApOg@mail.gmail.com>
Subject: Re: [PATCH net-next 2/3] tcp: use SKB_DROP_REASON_IP_OUTNOROUTES in tcp_v6_send_response()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>, 
	Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, David Ahern <dsahern@kernel.org>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 4AA904F0074
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285538-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,nvidia.com,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Thu, May 7, 2026 at 1:43=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> Replace a bare kfree_skb() with a modern sk_skb_reason_drop() call,
> and provide IP_OUTNOROUTES drop reason.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

