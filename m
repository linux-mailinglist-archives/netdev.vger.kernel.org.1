Return-Path: <netdev+bounces-296861-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yO8HA1t3J2qoxgIAu9opvQ
	(envelope-from <netdev+bounces-296861-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 04:15:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4019165BD34
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 04:15:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=BtkpyO97;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296861-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296861-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E509B301619D
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 02:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29912F747A;
	Tue,  9 Jun 2026 02:15:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01624285072
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 02:15:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780971349; cv=none; b=T4gUn7l6YxWxDukkUgarO9h4QXtSura03ZX7ylnRfCmVw7/ajROn2/6BujZX/1WUsbJkBOs7h7isHY/ivg8010CVcuZW1ri0yLXicR5wEwZXpk3SRWCXMY8PlYxVQhiUc+p3Pu7vo40o+uVANTtP+VxTye0gLvSsacyKbwZXze4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780971349; c=relaxed/simple;
	bh=8mrA+bQiXpYaBTGHL7k3MZUvo6xYXvYgLgakzL63cPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i0nsxuRRqQdWZrAJNkQpyhUhxkvQM3OrMVZVK8F1PC2Y0xTfmwwg72yKLR9mmQ6/uQpjNIk7I66RDzsZwlMJdrzGL3LCQYuEG+tqfdCxC6fv9dV7Ft1tk4N9c6KGC8F4nUREwgzkdra+8nW25htFOhbs0zl2OLCK7ikTZ0bW6w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BtkpyO97; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BB2E1F00893;
	Tue,  9 Jun 2026 02:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780971348;
	bh=8mrA+bQiXpYaBTGHL7k3MZUvo6xYXvYgLgakzL63cPQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=BtkpyO97lepeavCkG0m5/cyRh/NK4XSjOLsdE4uUNHHlkEYX76G86KdyhQ7h4Y044
	 wBQPJyzmKNYVotOphdGUkbhjE+GKQGmWI8GNsZEXMy+ocQePv/BefMEqrXnouioHAT
	 UIOaBBn72GtkIbK7ET5KbW3VsztTUuJV4K2Htp50VQbZWRfxOxoUD8u18EsHE80HVn
	 Tb4ih5OZ6fHznywGMULRNNOXbtjC1oma/+KDii7KA7rSVJhZXkd4uMVHVM47DbRPUR
	 tdvJFC3k1fmQkffDNzLc9FcE5V+Ie8/dkFIu4whjHTQRmCgBH6HUqpX/nqSz3TzIz5
	 JJnHh84fQMz2A==
Date: Mon, 8 Jun 2026 19:15:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Alexander Lobakin <aleksander.lobakin@intel.com>,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org, Madhur Agrawal <madhur.agrawal@airoha.com>
Subject: Re: [PATCH net-next] net: airoha: Add TCP LRO support
Message-ID: <20260608191547.21a29bb8@kernel.org>
In-Reply-To: <20260606-airoha-eth-lro-v1-1-0ebceb0eafc3@kernel.org>
References: <20260606-airoha-eth-lro-v1-1-0ebceb0eafc3@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-296861-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:lorenzo@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:aleksander.lobakin@intel.com,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:netdev@vger.kernel.org,m:madhur.agrawal@airoha.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4019165BD34

On Sat, 06 Jun 2026 16:45:28 +0200 Lorenzo Bianconi wrote:
> Add hardware TCP Large Receive Offload (LRO) support to the airoha_eth
> driver, leveraging the EN7581/AN7583 SoC's 8 dedicated LRO hardware queues
> mapped to RX queues 24=E2=80=9331. LRO hw offloading does not support
> Scatter-Gather (SG) so it is required to increase the page_pool allocation
> order to 2 for RX queues 24=E2=80=9331 (LRO queues).

NIPA says this doesn't apply
--=20
pw-bot: cr

