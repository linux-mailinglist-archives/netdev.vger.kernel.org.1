Return-Path: <netdev+bounces-268345-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mKcqMbiYuGmsgQEAu9opvQ
	(envelope-from <netdev+bounces-268345-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 00:56:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5118D2A21D2
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 00:56:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B045303DD27
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 23:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B204C35CB73;
	Mon, 16 Mar 2026 23:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GKsDff31"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE40283FC9;
	Mon, 16 Mar 2026 23:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773705379; cv=none; b=COLICHOSDzT3IHaEgdbGNuKdAHA7byWo5eDqtoGOUoszm4JrelD4ux+xv0SVHp4oQxwV0WU/perNTVjlzabLA3qlQhx2RIpE9VMO45/ddkDttFJLw6u994cFetxIxyyi17ln77L++hTXY+Uuj4Q8K9XTH6bkvDeNDR5PMO6aox8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773705379; c=relaxed/simple;
	bh=DgUYXuvJ86+JYxo2mtsIoUEvcAZLFFLbFq+gNWjLwRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KhQwqItUVcau3+Trl8FuLvCjF3EjwGkbvwZNC99fSKICMeVfr2umrI7ExMHO4k5ZcHO7R6M5rS+3iZzsoVdsOuCA8w4x46FOmzM2AtzwfxIB2LeK11r0jDlSzb+W48gXvVH0F9KFbXbyU2afkNuwxbrq/GQ9wxyt0LcPYWaIJOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GKsDff31; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFEFCC19421;
	Mon, 16 Mar 2026 23:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773705379;
	bh=DgUYXuvJ86+JYxo2mtsIoUEvcAZLFFLbFq+gNWjLwRQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GKsDff31hLtRGtVRmZ+2v+UYPqgSNd2Y3qqj3wX2qguePy5njWzMCP8VwxtllPI5f
	 zvUYx9QYYAbJH8+5fGd2eIGE0AVyHeF8ZYSsELC1VyybhXsRbGyAyPum0vRMb0o7PM
	 /fWeN3papac5J1amlCIPxN44ruI8CLotmBaHi2uwDugRT05RtwppIWXmKBH0l/I6OO
	 sg33C1w2ksYSlcjIPKA3ZCGDqfYjTGoWRYFhzWx5SkCsIweWDuectyBHdfYd77TiEm
	 /XqN1QDpczIW4rxwyTH9kTLrDrwFEv2hrKOcRw2UJjfLhyrZAukV2+dBiUGzw4R1wb
	 52Pa9tep4y5WA==
Date: Mon, 16 Mar 2026 16:56:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Anas Iqbal <mohd.abd.6602@gmail.com>
Cc: jonas.gorski@gmail.com, florian.fainelli@broadcom.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: dsa: bcm_sf2: fix missing clk_disable_unprepare()
 in error paths
Message-ID: <20260316165612.4ffa7830@kernel.org>
In-Reply-To: <20260316132547.1274-1-mohd.abd.6602@gmail.com>
References: <CAOiHx==pVOOtvOb3eooRGt8EcwjTtkY-33Nn+Cu_m3pu2gVtpg@mail.gmail.com>
	<20260316132547.1274-1-mohd.abd.6602@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,broadcom.com,lunn.ch,davemloft.net,google.com,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-268345-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5118D2A21D2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 16 Mar 2026 13:25:47 +0000 Anas Iqbal wrote:
> Reviewed-by: Jonas Gorski <jonas.gorski@gmail.com>
> Signed-off-by: Anas Iqbal <mohd.abd.6602@gmail.com>
> 

replace this empty line with a --- when you repost
That way git will cut off the change log when patch is applied,
which is what we want.

> v2:
> - Add Fixes tag as suggested by Jonas Gorski
-- 
pw-bot: cr

