Return-Path: <netdev+bounces-294746-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iIzqCLwlIGrUxQAAu9opvQ
	(envelope-from <netdev+bounces-294746-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 15:01:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F04637CE8
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 15:01:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=eBBCtHPU;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294746-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-294746-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lunn.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E9E08303FFD3
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 12:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E3D466B77;
	Wed,  3 Jun 2026 12:55:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0091A0BF1;
	Wed,  3 Jun 2026 12:55:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780491335; cv=none; b=BtaqbOxywY+28x5BpIz6786sv45YdVZyArK7gxGjU3+KqFFTy01zYX3QiVsscbzFWkBcARUBWm+3rL6jxbkaUN7D8aTvn9KwPeyoFUHAjjfsU9oALhtqS5qWJVJVjq8cCSnAZijVfU+bIiPC7ZpP8JS4L1xK0I1t3r74yxqyFtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780491335; c=relaxed/simple;
	bh=G6k6nElzVlSohrj7Ypd/k/ztuxeVsCgtuuIksNySwj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nfMZUcH6bYTjoLGvart+ggtv3xh0yTB9PHzvKBNAaUL7bEnpcT2e51rBciovo6AQ6/394tPHmD3uN3jws1T9QG+pIk7wv2RaBewrk2NBaENBj+4thyrnMz5W8kYho+qWZB9JJCBRiXz7dFnIHRodxn5Fva2O5Mu3HJHc1uWuAo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=eBBCtHPU; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8u2Jh7i+EE4SalPv1UXpLCcYjn0jkw/InxVLERVBTqU=; b=eBBCtHPU6fp9bSQhN9llsx9xWs
	mUThDgDiFOjj0LjhHHeV59b3LbLvjstqKXNnOGJCzV8bJHeuVPO5JccBOOBneW12XwhsQ4XePVdLh
	ccP0f9ysQp2hbKbmT/Bu0vdfSFNNTw+ax0cwwVKC16ILLE64qxv2r7AedmXcHmxKcGVM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wUl82-005sWW-90; Wed, 03 Jun 2026 14:55:26 +0200
Date: Wed, 3 Jun 2026 14:55:26 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Shaoxu Liu <shaoxul@foxmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] rndis_host: enable power management for
 Telit LE310X1
Message-ID: <6f52869d-da6a-4004-a35b-c27d9209d84a@lunn.ch>
References: <20260602090528.2544-1-shaoxul@foxmail.com>
 <tencent_B7686B84CD4B76D76BB912FA6367FAC2CA05@qq.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_B7686B84CD4B76D76BB912FA6367FAC2CA05@qq.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294746-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:shaoxul@foxmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-usb@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[foxmail.com];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,foxmail.com:email,lunn.ch:mid,lunn.ch:dkim,lunn.ch:from_mime,lunn.ch:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 66F04637CE8

On Tue, Jun 02, 2026 at 05:05:28PM +0800, Shaoxu Liu wrote:
> Enable autosuspend support for Telit Cinterion LE310X1 RNDIS interface
> by selecting a driver_info variant with manage_power callback.
> 
> This keeps power management scoped to the new Telit ID only, and avoids
> changing behavior for all existing RNDIS devices.
> 
> Signed-off-by: Shaoxu Liu <shaoxul@foxmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

