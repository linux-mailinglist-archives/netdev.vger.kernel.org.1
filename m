Return-Path: <netdev+bounces-299897-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id I7ZREBZzMWqbjgUAu9opvQ
	(envelope-from <netdev+bounces-299897-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 18:00:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D37F26919D6
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 18:00:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=eHqjyJGu;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299897-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299897-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BE10D304F537
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 15:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31DE044D03B;
	Tue, 16 Jun 2026 15:55:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2501337C912
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 15:54:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781625301; cv=none; b=DL3qZK02EHDsXx1dHlAxRSY5TlbohKhLgRldSJSe4NOY5tgwDWfhdyAMfshF1i3vW37SLoje1X3hmPM7PZjE+mMgiPHQxtkwed9FZU+uXkdm7j7KfzEbySqifLwdRWFR7b5dnKnbJ1UlTaWITLaEJMuziwTKKzn4WVA3U4DMs5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781625301; c=relaxed/simple;
	bh=PHodwggY7aVmb6EKV4xJNnCtQ31Uvuw2qFAqBtz+Q/0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Eo7LcHaGN14InqsnX1JBi/h8FNqHAC2eiuIO8cLL7RR0JiADmbm10p0kwMFZk3lXsIWK44auJzgEs1MAsrsf6AqyGnHiRN4vkWEj7l+zNfVeWzz7EZAr2k4xcEtnzmk3e2/BQpNeNh99CeQj1oZ8cGBRrVMBSf+nrhW2r6lOQsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eHqjyJGu; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6132F1F00A3A;
	Tue, 16 Jun 2026 15:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781625299;
	bh=xqvtHPSJepx/q/Es5+VA/QAkX3DxUxfvnW8+rBqurrU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=eHqjyJGumWojr40wMwN67tFs4QZqQ5OYMKtW5059O7a0fzFt7Kza/WVBDx2b91ytp
	 M4TPlzBsTNk4029hE3IvLG0lETDF4qlpS+eI1Dbs+sdY5lVvq1IRVeovHFqVUM5FXG
	 KTFpFCypCIWJBd+Kon5ETDcOxtqsIcC4FFnE/rhdvlREx2WMj3I5rAP8DJcVjpfu7r
	 QjfsoghdU3bEp+XVpotDCYaeP+P28y5ZVYQc/tvBRqVbaW8KZl3mV8saV8FAjP9IAh
	 bpneZBLnfijngtxAdRZZerXWpQ0GloVawP09cnyItXGvJcyea9hz8BFO5p+Fwsxumy
	 GqM75BzSU6VvQ==
Date: Tue, 16 Jun 2026 08:54:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Nikhil P. Rao" <nikhil.rao@amd.com>
Cc: <netdev@vger.kernel.org>, <brett.creeley@amd.com>,
 <eric.joyner@amd.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
 <edumazet@google.com>, <pabeni@redhat.com>, <jacob.e.keller@intel.com>
Subject: Re: [PATCH net-next v5 0/6] pds_core: Add PLDM firmware update and
 host backed memory support
Message-ID: <20260616085458.19d8e3f1@kernel.org>
In-Reply-To: <20260616023554.258764-1-nikhil.rao@amd.com>
References: <20260616023554.258764-1-nikhil.rao@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299897-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:nikhil.rao@amd.com,m:netdev@vger.kernel.org,m:brett.creeley@amd.com,m:eric.joyner@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:jacob.e.keller@intel.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,linux.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D37F26919D6

On Tue, 16 Jun 2026 02:35:48 +0000 Nikhil P. Rao wrote:
> This series adds PLDM-based firmware update support to the pds_core
> driver. PLDM (Platform Level Data Model) is a DMTF standard for firmware
> management that provides a vendor-neutral interface for firmware updates.

net-next is closed for the duration of the merge window.
Please see: https://netdev.bots.linux.dev/net-next.html
And of course:
https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer

