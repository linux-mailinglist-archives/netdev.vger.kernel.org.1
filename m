Return-Path: <netdev+bounces-294405-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iOi6OUQ/H2p4jAAAu9opvQ
	(envelope-from <netdev+bounces-294405-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 22:38:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 47EF7631CC0
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 22:38:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=nxnUirJJ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294405-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294405-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F97B304D453
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 20:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46DC12F7EE3;
	Tue,  2 Jun 2026 20:30:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40ED2EAD1B
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 20:30:27 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780432229; cv=pass; b=SWg8kHz46FzwGz9+5+7B3TaOrGmYzL5/SmaxjNqkfFBO7XTjc2cqHxqx2d+7aZNDV1BmYLg7h/rItWpFzz0aEPfxhmL4WtIJ5zH5ZDrO0o52KbrUN2euLm3hkggkW+utxpSB6gyjq+2+3CEKEpOEZrp7kUG4vNZJUuO5w+eK5mY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780432229; c=relaxed/simple;
	bh=6WBL/OVvf6uLKQpuFZ28T83IvovX5akLJSlhp+dXiN8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eTAO6csjsDLtoBTO3NYz+Yr3Hvftq4g8nTfXoCxG9zgVHuu9yAQueFpZK+OBPgOlk0mldkZeYn2t0IcFjFmbjZu68FNXjFgNBXyuEfvKpnYUQhK1T/xpUGEsxBvBUZt7kWC73zgBQ3N+iJOsUsxhj/42qJ5wryTs5eUTdOt8IWM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nxnUirJJ; arc=pass smtp.client-ip=74.125.82.45
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1370417c01cso11863203c88.1
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 13:30:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780432227; cv=none;
        d=google.com; s=arc-20240605;
        b=AiLbEnpFqUSRU2aVlaMcO1VujXXuU0dVLQAs/oLAtBCKjMoVa1zhPIOdM8Mt99bjCV
         t5VSzM8bpYo4NtBx264w194Qzm8QG8NOwzRRghCp6YDDrvCjBe/OiL/NVrRk+sPNcZgs
         motTZGqa2pKjGiu3CbGkSMlQnwI/2BgjCbe1SFcJxVLoVN8VwBlEaKA42xfX3VhmrWH3
         kUAl3t7M1VQJZFYUpi5O0OlhpvsbaY+F11v8DIkVVMx0omkm268zOz++bawp2el/V7us
         yBtAyzc94xrd6rA+uu6/hLoaSkhcV5QJy5WGhlbGK2roYcZhwe3usqVsm0akTMLDjp6I
         TrRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6WBL/OVvf6uLKQpuFZ28T83IvovX5akLJSlhp+dXiN8=;
        fh=qfnlmk8xs7KVgj/24gIXnpFw7Ecunw5XZGhG/r9BPYA=;
        b=C9Kp6ExVE7hR9rNNA5PaOHzRX149rZliUif0dyLaBDG498CBvbBVa/ClszdxXtTadr
         ZH1sXq5QI7YShdXmC0ZLttAZipywVBGCVoJgioluNj2vKbIckzeXQxOWd78fVPJVktRG
         gRaZmxhHsqI2hc/L/f7g6X5P+lYaiHzK+ucIxutrO00CaYhiQN8KbQpEzmsQRJDfhD77
         SRU/Coep6zKzffxqKacN2HHrnIMisgWu+yoMmSq9Tnyt4uPhVFynwPsxT527vFNdEJ0d
         mZ7oQZg1pyJwv9Wwmu3qEoZf5qZyYXtwaAM3q6PxYn/+UzsO5anISX+uH4urf6hlj2va
         CPjw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780432227; x=1781037027; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6WBL/OVvf6uLKQpuFZ28T83IvovX5akLJSlhp+dXiN8=;
        b=nxnUirJJuqq6h5rUXaEKDMMGbDIs8M87xYeS4SygCGT9FaSxSoSNx/CfTdBdRAa+Fw
         aPPO36cPASOVX7qH/YJb/v2XiGSHxv+QRPWHIY/jCrvqBaJNpDlBHVywBHXw8/3RJUH8
         M5Hsa9ci3rOOJXNSzufmLUtpDPnyjru9NJIdq6b1CaMwv9yTAn0N4bVapih1FWC38wxr
         wRsrg19Uke74EaKwKgKN1XDQnZHvLEhPk4TcbKPgFS1HFwvx27X/EYV/CbOzD3oAP+sp
         nnF21RPDuA6mZQuxjfAXFZ1RZ0mAwS/CoPeoE1KTlKSeP5NQz9ER+gUP0jOn82xzjGET
         eK4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780432227; x=1781037027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6WBL/OVvf6uLKQpuFZ28T83IvovX5akLJSlhp+dXiN8=;
        b=XRyV4N7NVCCel26uTAh131c9BvwKJhHUIZD0N+icc8nfkixUNF3vjrUbW3dxGONIEp
         Ofm29+KBUfbMlJzB/c+WAXL8mFcxur33A48KF4TqHjezK1vsNxCLvcAoEWdqnFx707ft
         py1IPIR/LUo2xSce8UeC35f3E8156OGwWIegMci9EOna8rVDvHwKU7D5xyDbzca4sBSy
         7vMk+342lCNP4DuqTMC9R051JpLzyp4ux57usibLlTZBoFSY1Q1TPAN2NjmNRudo0n3/
         +7YFnQG6Y1JN2XhkZGUnYzzjsZ08lyYIDbo2u9p6v3k99yX79bDPGhYy++AZcof3YxNP
         uHow==
X-Forwarded-Encrypted: i=1; AFNElJ/LjW6omkhjRl897HyEQiA9sXT0MCMtH6qZbEMS83w1db9QcuqBezkr7FLOgZRZB6qyfmn2TFk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw9kiE/AOdESUzwi5BPJLtshNenBWXklrR+YXoI7/LR9NAR8lA
	5aL/V5U6bTVLoAkRiLxRlIUDgqLJfHPuwgSnPkXW3WhChRXIk65kbqnYNlDowcYek4Ky7O3yspq
	XcCfMrx+sV7AIuFJcKRmmbcHPAU/glvIjjZoiz3KM
X-Gm-Gg: Acq92OFKHc49gZhyF7c9+4VClldi3XqSkC1F2ZlL0ccqbERpyDsa6/Xhi/O/ArC2EeL
	3gpQJGcIunSpbJZXMO19psCjPV28bct5ImzbIRVJbEDaO2wZh52c2Zy9akpr5h/+dFXmEomD9yx
	9qMycbAl0cO++dqNZWazHczweW/3o2zw37gO+X5dxCuStI8qM+beu4IUt2AI4VgxtD97OAuVh5L
	k3zEjE75XLUCn7DaCeQdeJlwOX5a1UmN9R7yNN/oKHTfCnFu5uYdyJS4TJTmnazrQSMhDeR38gn
	U7HpAsARjlvkDuTO3AKtCGW8F4HvNLYGlyprXbbTdaMhZMFykCQcR67NcLi2jKp4woMqzBf/iyy
	Fc2/mA/Mfc8H88tIimNL09RWPfKFiVo5FVdEDV4QSwZealxEclByBpDVyyG6tk+A=
X-Received: by 2002:a05:7022:2581:b0:137:edc4:a5e6 with SMTP id
 a92af1059eb24-137f6bf3da5mr101077c88.29.1780432226317; Tue, 02 Jun 2026
 13:30:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260523061102.2762452-1-kuniyu@google.com> <20260602125951.50492267@phoenix.local>
 <CAAVpQUBAL_6A3MPcH8w7+EZyfOG9D0i2X3pu5Vhd+fz8Y0=QBA@mail.gmail.com> <20260602132653.2b2f4f93@phoenix.local>
In-Reply-To: <20260602132653.2b2f4f93@phoenix.local>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 2 Jun 2026 13:30:14 -0700
X-Gm-Features: AVHnY4LYosabcVKWfqXXDe1l553DVpf-r9Am90tmbbUw5NT7Mm1NxbfLLjz5Iqc
Message-ID: <CAAVpQUCUsK9tY7F9hjYFYR2yVJ0sQ=vnWyhuV5g9-vxNC+cbSQ@mail.gmail.com>
Subject: Re: [PATCH v1 iproute2-next] iplink_geneve: Support IFLA_GENEVE_LOCAL
 and IFLA_GENEVE_LOCAL6.
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: David Ahern <dsahern@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294405-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stephen@networkplumber.org,m:dsahern@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kuni1840@gmail.com,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,redhat.com,gmail.com,vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[networkplumber.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 47EF7631CC0

On Tue, Jun 2, 2026 at 1:26=E2=80=AFPM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> On Tue, 2 Jun 2026 13:06:33 -0700
> Kuniyuki Iwashima <kuniyu@google.com> wrote:
>
> > > No new code can use matches(), it creates problems with conflicting
> > > short arguments.
> >
> > TIL, so the recommendation is simply using !strcmp(*argv, "local")
> > or anything else ?
>
> Yes, that is preferred.

Thanks, will use it.

