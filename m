Return-Path: <netdev+bounces-275682-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cAgFCgH102nToQcAu9opvQ
	(envelope-from <netdev+bounces-275682-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 20:01:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BE00E3A5F93
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 20:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A6CD430057BF
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 18:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEABD38E129;
	Mon,  6 Apr 2026 18:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BKormZZO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC1B38C2A4;
	Mon,  6 Apr 2026 18:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775498459; cv=none; b=ojqfTBBU/THFf2YsxUwEIW+z4E/gNdiBTRxQQvkROxa0wvidF7gSJ+MImksx+ErcpFc1AXQO4xhGkLNDWfWsP95RipS3jCfmm7pOOB2Hl00lQBgKp7qtNGmx7FceF+630dzZ00TpzLXMz1XvlpaRERMIDMLlO9zL94Wc5nF/bAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775498459; c=relaxed/simple;
	bh=xcEhnR4W//A1ik8wSUJ08Up7GUS4GXGUPS1g+tFQ02Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L3ylxKFWQgaTSEAJhjtNNJLydYPSN7NFHWxFl+OlaheV5/aX1ycNL/CHQNxwyflCutWq0Ye7Lk6V7Skp7WUm3zamZWZKFNTLv73W7FksHhpIdI6ysSxSrA02ZEcIjUU5kTBMp+3W7xErVlOk6FlC1WzipkyEIr2KuROz20M6EOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BKormZZO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C550DC4CEF7;
	Mon,  6 Apr 2026 18:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775498459;
	bh=xcEhnR4W//A1ik8wSUJ08Up7GUS4GXGUPS1g+tFQ02Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BKormZZOIaxMcjbufXUOmz+OjmJ3Ht2Ob34DXi6NqlJwXdMw5O428aZfdgsObcJwx
	 a3WcNYTNioq1JaoyU/N42ta2UlU+MAP3jkukClAAYzg8k2u8KTg9DKxim2JW+iMvG2
	 ToJ9ZTvc8Kr8zi1zrvHpIzgrz4Gn+b4AH7bsKmy35QnQ9+K150j4nqXKWWvagikiD5
	 uhbTgfzVsvStE5M5sIHnBqiuj+GgbGGC2ID/SjlZbCOsOHwVcmas3+yQKvF29g5kbf
	 KPkGprPmNBvjTlYB8ykeQYasqUaB8qDZ1bC4U2f+tIqYQxO8kPx9Du3NyJ6IaaoN15
	 fG48EBHC1pkfA==
Date: Mon, 6 Apr 2026 11:00:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
 <magnus.karlsson@intel.com>, <stfomichev@gmail.com>, <pabeni@redhat.com>,
 <horms@kernel.org>, <larysa.zaremba@intel.com>,
 <aleksander.lobakin@intel.com>, <bjorn@kernel.org>
Subject: Re: [PATCH v6 net 4/8] xsk: validate MTU against usable frame size
 on bind
Message-ID: <20260406110057.49b61126@kernel.org>
In-Reply-To: <adDhtBR9aairuaJr@boxer>
References: <20260402154958.562179-1-maciej.fijalkowski@intel.com>
	<20260402154958.562179-5-maciej.fijalkowski@intel.com>
	<20260403170357.14cb166a@kernel.org>
	<adDhtBR9aairuaJr@boxer>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com,redhat.com,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275682-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: BE00E3A5F93
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, 4 Apr 2026 12:02:28 +0200 Maciej Fijalkowski wrote:
> On Fri, Apr 03, 2026 at 05:03:57PM -0700, Jakub Kicinski wrote:
> > On Thu,  2 Apr 2026 17:49:54 +0200 Maciej Fijalkowski wrote:  
> > > AF_XDP bind currently accepts zero-copy pool configurations without
> > > verifying that the device MTU fits into the usable frame space provided
> > > by the UMEM chunk.
> > > 
> > > This becomes a problem since we started to respect tailroom which is
> > > subtracted from chunk_size (among with headroom). 2k chunk size might
> > > not provide enough space for standard 1500 MTU, so let us catch such
> > > settings at bind time. Furthermore, validate whether underlying HW will
> > > be able to satisfy configured MTU wrt XSK's frame size multiplied by
> > > supported Rx buffer chain length (that is exposed via
> > > net_device::xdp_zc_max_segs).  
> > 
> > For multi-buf - I suppose it's fine, but wouldn't this be potentially
> > a regression for setups which use single buf? Suddenly we expect the
> > user to provide space for shinfo which was not part of the initial
> > AF_XDP design?  
> 
> For single buf xsk_pool_get_tailroom() gives you 0 so it is not taken into
> account when we do comparison of mtu vs xsk frame size (in this case frame
> size is defined as chunk size minus headrooms (xdp and user provided
> one)).

Ah, missed the xsk_pool_get_tailroom() magic. The rest can be a follow
up, my main concern was adding stricter check for non-mbuf mode.

