Return-Path: <netdev+bounces-275296-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QAvROHxV0GkA6gYAu9opvQ
	(envelope-from <netdev+bounces-275296-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 02:04:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F1623992CA
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 02:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8F0730115B5
	for <lists+netdev@lfdr.de>; Sat,  4 Apr 2026 00:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA154883F;
	Sat,  4 Apr 2026 00:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YOWKtvK5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57C74C92;
	Sat,  4 Apr 2026 00:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775261038; cv=none; b=fWJhR+Ij8sCxm+MB4Q7DXWpaNo9AkIrhiY1386Le+fsnr8H1DsIULQcA1Bf89EHG8ulSCKNmmG+xF/diYO5ho2fA8suLBfDoMA3Q5uTnI0lTLFD7c2UTs6CFOHc6bhgpbaAkxf87pQgQHAo4PerVu0mbh9wHH4G9wXpQIrPOzRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775261038; c=relaxed/simple;
	bh=e8c7H+ZPoDWwwXYrkE7pEd5nu81cDoPtuLT9V6+iKl8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nBn8+IP8n0TZLOz8caHL1hbXtKqkCS+8/YDlwX5GldmePRSjhop3Ngk2Hnz6v2j2Y/39V1gKx6JNG8evHaecNeFV7w57DxinqGi344HcFpqzCGw4tY/JEbaOZj9zwwrweYT5tbhiyhmUTtO14iYx4A5OsE+BQaqaoFF6dDZv2ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YOWKtvK5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4E4FC4CEF7;
	Sat,  4 Apr 2026 00:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775261038;
	bh=e8c7H+ZPoDWwwXYrkE7pEd5nu81cDoPtuLT9V6+iKl8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YOWKtvK5OZrHHQuYf6H8v8YLAjx8R3WGOxIE9AkXN1bxrLesiW4HLLIrzdTTTycD7
	 ZSeFa2y8BQetI7CJI2I9YTsCg0rpBj8CObuLf5Tk5wCSFy/5DWpU2G6kYWdg/0Ttxd
	 ZpEtWxxWdhgpzdIhCAdh4kRulAGxXZzUVqhye1+ni/xdtmTephWKfW+OR4EdLrMqcM
	 Oy30MuQe9zVDYgWO2VRG4aTuONXQXSd+tovC6l+lr+Md9i3UraZgsem1rTjbSYIH/e
	 7ycVXls1PTxmi65TnMIhIpFyxlHUS6pEAJJmZmix2MBvwM7l+cOsdZlZbkj9cY/Ghv
	 /cyjUdn1ovfzw==
Date: Fri, 3 Apr 2026 17:03:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com,
 stfomichev@gmail.com, pabeni@redhat.com, horms@kernel.org,
 larysa.zaremba@intel.com, aleksander.lobakin@intel.com, bjorn@kernel.org
Subject: Re: [PATCH v6 net 4/8] xsk: validate MTU against usable frame size
 on bind
Message-ID: <20260403170357.14cb166a@kernel.org>
In-Reply-To: <20260402154958.562179-5-maciej.fijalkowski@intel.com>
References: <20260402154958.562179-1-maciej.fijalkowski@intel.com>
	<20260402154958.562179-5-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com,redhat.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-275296-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4F1623992CA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu,  2 Apr 2026 17:49:54 +0200 Maciej Fijalkowski wrote:
> AF_XDP bind currently accepts zero-copy pool configurations without
> verifying that the device MTU fits into the usable frame space provided
> by the UMEM chunk.
> 
> This becomes a problem since we started to respect tailroom which is
> subtracted from chunk_size (among with headroom). 2k chunk size might
> not provide enough space for standard 1500 MTU, so let us catch such
> settings at bind time. Furthermore, validate whether underlying HW will
> be able to satisfy configured MTU wrt XSK's frame size multiplied by
> supported Rx buffer chain length (that is exposed via
> net_device::xdp_zc_max_segs).

For multi-buf - I suppose it's fine, but wouldn't this be potentially
a regression for setups which use single buf? Suddenly we expect the
user to provide space for shinfo which was not part of the initial
AF_XDP design?

