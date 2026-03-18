Return-Path: <netdev+bounces-269199-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MPMqNA4hu2lofQIAu9opvQ
	(envelope-from <netdev+bounces-269199-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 23:02:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E552C33BC
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 23:02:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ECEC131737FA
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 22:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FFD2356A3E;
	Wed, 18 Mar 2026 22:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f0AkCfVF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C33F34575A;
	Wed, 18 Mar 2026 22:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773871311; cv=none; b=byxqhSzzGExOjrBPHRxpjwDI6WkgRUCusAk7b0eJI79zUyWY9KWoVyuU0BdqeGbi162RCZ+GMUFhuAgBWzt6XpTTYlFqouoToMRvSyKjxEsksJsfs3fZwtJM/TVUq51M+fzdyw1coZX9k4QYDfG2vt5HaVC8aXE5ZGCMtEdcslc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773871311; c=relaxed/simple;
	bh=yKTCfTaO+n3bRBojozjvKT85mTzi5C8fvwn7aUxdfpo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UWHzOS0KfsU/BG4/A7w+Bb3JuF/2vvl2s2JtNh8uvkDeEFj2v2eKJJcLBQ4PRyAtYI+lGUB6CccxCe8Ej/PD3PQc8VJ99ulhCGt15CK+fvx+esKxLqoXLUItxUvGe0mBb1Xqny4yWIonlY8qq0M+4OlPJoNjuzD9KIrqRxPOXvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f0AkCfVF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 421E6C19421;
	Wed, 18 Mar 2026 22:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773871310;
	bh=yKTCfTaO+n3bRBojozjvKT85mTzi5C8fvwn7aUxdfpo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=f0AkCfVFdlara06owOY5ML1hYqVzqv2OmUgyUGimNzLz3xaH8d8Nf9OnSOqKTni10
	 lFEDzPEiiurMoA0I2jrARitaYgVaycsY1BiqKoyexqy1jDrM+Ru5NNaciLxI/3SyoX
	 72NjOUkm6pPIE9SuZC3ha+4BKyqwwknBZTCNyoKsM7s2ubkJgW/fs02Tu0u4BGVbfK
	 0wU+TJ9QnzUqMWMikptq4Wl6xfqeRuXCccCaKetJedDc+NH5tEFYQxnzinmnKlvgf7
	 Y56ig/xcmGsv5BfmKAq5h8zmwHSTiwMYIkrGtle7t34DKkMjxzh5lcF2mQJW4TdW9A
	 ohcYajKq+w0hg==
Date: Wed, 18 Mar 2026 15:01:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vikas Gupta <vikas.gupta@broadcom.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, michael.chan@broadcom.com,
 pavan.chebbi@broadcom.com, vsrama-krishna.nemani@broadcom.com,
 rajashekar.hudumula@broadcom.com, ajit.khaparde@broadcom.com, Bhargava
 Marreddy <bhargava.marreddy@broadcom.com>
Subject: Re: [PATCH net-next v7 06/10] bng_en: add HW stats infra and
 structured ethtool ops
Message-ID: <20260318150149.7a8c6067@kernel.org>
In-Reply-To: <20260315141605.410878-7-vikas.gupta@broadcom.com>
References: <20260315141605.410878-1-vikas.gupta@broadcom.com>
	<20260315141605.410878-7-vikas.gupta@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-269199-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.640];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 72E552C33BC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, 15 Mar 2026 19:46:01 +0530 Vikas Gupta wrote:
> +			/* Per port queue IDs start from 0, 10, 20, etc */
> +			queue_idx = queue_id % 10;
> +			if (queue_idx >= BNGE_MAX_QUEUE) {
> +				bn->pri2cos_valid = false;
> +				bnge_hwrm_req_drop(bd, req_qc);
> +				return rc;
> +			}

Dan C's report looks still relevant:

https://lore.kernel.org/all/202603180509.nOQGZrG0-lkp@intel.com/

