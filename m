Return-Path: <netdev+bounces-278268-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wK+eFN2c3WlxggkAu9opvQ
	(envelope-from <netdev+bounces-278268-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 03:48:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 462BA3F4D59
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 03:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 31B6030095EE
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 01:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029F218872A;
	Tue, 14 Apr 2026 01:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ns+DQECg"
X-Original-To: netdev@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2B01E515
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 01:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776131285; cv=none; b=uEcQYeHPWuFcCtgWaK+g4Eh56Zm/chVKa4lPxDyTA6L0s2pzYFqLOrkwcIcLofQl0XtYIwSfEpwjT0+rgeUm5Br0J98Bsdfnf2SAL3gOaxQ7jdgllk3uzE1JYsEugzkA5mym+AQcEEUrrAJeKgQ2Gz5oA8SpqFU9dwPXQ0KK0qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776131285; c=relaxed/simple;
	bh=MtAwJlqd3nVO+JnPWiaK7BVIXHl14zYBqIuYYVvEhFk=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=jE3kDumgSJXdvi2rmO8zRULSKUNNGDojXTWsZUy7UKjex1+1x2P3CkzPOA4zJFkfI+B8Qf1O5Qu57hP0dUt64lfBQ07DEgD08PJFuV/waiNyAODCLU+qr8agfAvtgAVxovEe/IJDlTtN6GWIWg4a2hlvMH1sKPEo6FlUIifXUFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ns+DQECg; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776131281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MtAwJlqd3nVO+JnPWiaK7BVIXHl14zYBqIuYYVvEhFk=;
	b=Ns+DQECgRX2Zm+kbhkaOW26GGREDdXaYEfaX0fUWJ/oC8eEtu6gtHmZl5FXuadz0h300zh
	mnHrBdylisavXW9uFMlPjoZHOYEcJINnUEGdV4AOPCVtmPrVtS/EfkqueEXdRo925fcPFP
	EuPUeN6L0TzAK4LNzgvFmvBGX6WojEQ=
Date: Tue, 14 Apr 2026 01:47:58 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Qingfang Deng" <qingfang.deng@linux.dev>
Message-ID: <5cae00a663a3830bacf172cd1cdee0c0c2640d4a@linux.dev>
TLS-Required: No
Subject: Re: [PATCH net-next] pppoe: optimize hash with word access
To: "Eric Dumazet" <edumazet@google.com>
Cc: "Andrew Lunn" <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni"
 <pabeni@redhat.com>, "Guillaume Nault" <gnault@redhat.com>, "Kees Cook"
 <kees@kernel.org>, "Eric Woudstra" <ericwouds@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <CANn89iKmxWiCTt7nVk-DZ4R_KsYDYbPwQ5f7Hp5F8hWmr+zc=g@mail.gmail.com>
References: <20260413035212.56566-1-qingfang.deng@linux.dev>
 <CANn89iKmxWiCTt7nVk-DZ4R_KsYDYbPwQ5f7Hp5F8hWmr+zc=g@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,kernel.org,redhat.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-278268-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qingfang.deng@linux.dev,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 462BA3F4D59
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

April 13, 2026 at 4:42 PM, Eric Dumazet wrote:

>=20
>=20On Sun, Apr 12, 2026 at 8:52 PM Qingfang Deng <qingfang.deng@linux.de=
v> wrote:
>=20
>=20net-next is closed.
>=20
>=20https://lore.kernel.org/netdev/20260412142250.131bf997@kernel.org/
>=20
>=20Also I would suggest using hash32(hash, PPPOE_HASH_BITS)

Thanks for the info, but I would like to keep the same algorithm.

