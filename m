Return-Path: <netdev+bounces-284096-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJNwCugx+WkG6gIAu9opvQ
	(envelope-from <netdev+bounces-284096-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 01:55:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ABAF94C5017
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 01:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0BE3E3016528
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 23:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAFF53EF668;
	Mon,  4 May 2026 23:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S69KAucb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8856D3E639C
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 23:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777938891; cv=none; b=j0wO/iaL0UKW09boOHRK036tLqYYrcrMk+jmSecLsiELexCkocfGs5APdETvjRgkX4VeEqdwC38tgJUsoa5HYhUatQtTIaGIY6aen+GCFIPOK9tlUqeHwkZcxZpkYAFJK+2D4bkRHXU+njv7o7WnqN3fxNX350aQdSafsV2Rusw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777938891; c=relaxed/simple;
	bh=8Q0ykBaXf0sz3aWKh2H/iAaN9C4POkNO3dVqrYNpg4I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r53S8EgOb8Rz8guexAIpvWTZzwlu1Pt1fCdUFut7d+PWjWP4YTaXm6MMx/pQz8WZ3OT1+HIrTaLzRTPAptQEoKxGT+WTHc58cryyND906jI5GBBYN31CRLpqyyTwWGvqn+HObaMoNPJngmF7IZrdm44ygnwRj/Fzlxyv+c5CxkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S69KAucb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0FFFC2BCB9;
	Mon,  4 May 2026 23:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777938891;
	bh=8Q0ykBaXf0sz3aWKh2H/iAaN9C4POkNO3dVqrYNpg4I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=S69KAucblOMJHepPpZSqP9Q1rV2ZheBE5DVsbXtsbksZgjGxS/D9LnNGahJvmg728
	 9SFkh8Q8YoW2iQEKDvDbZoxJFvPOv+P2ysZ7+yUl97d/Sif0/GuZduduc6YQAW4q6w
	 AiapQrLJqTAT+qJoSMYIUYzJOkI8n3ouL50K5v0FwdfX7PuriEAoYu4K+h31MJqqb7
	 RUQ9w8ZwehO2Putk0ASimaebZLItZI9IgEWh/J08d3gOmXb0RynnqGVMdzW1+fPSMy
	 UdzpPDqMtXJEbmY5gtW0Zk6r0T8hjnt1r4QwNM0QqPZh7yEiRAXh7psuEnBYq11om3
	 arLP5ubOvM8eg==
Date: Mon, 4 May 2026 16:54:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, ralf@mandelbit.com, Hyunwoo Kim
 <imv4bel@gmail.com>, Sabrina Dubroca <sd@queasysnail.net>
Subject: Re: [RFC net] ovpn: fix race between deleting interface and adding
 new peer
Message-ID: <20260504165450.7cc15bcd@kernel.org>
In-Reply-To: <20260504142033.2327646-1-antonio@openvpn.net>
References: <20260504142033.2327646-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: ABAF94C5017
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284096-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,mandelbit.com,gmail.com,queasysnail.net];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Mon,  4 May 2026 16:20:33 +0200 Antonio Quartulli wrote:
> This patch is sent as RFC to give the AI a chance to review it once
> again, since it was able to spot a new race condition in its
> previous version.

FWIW I think you can just ask for Sashiko to track the openvpn mailing
list?

