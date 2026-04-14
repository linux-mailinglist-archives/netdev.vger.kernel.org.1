Return-Path: <netdev+bounces-278372-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJp9I0QL3mnRmQkAu9opvQ
	(envelope-from <netdev+bounces-278372-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 11:39:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D77F33F80DF
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 11:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C9A87301169C
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 09:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 944D63C1414;
	Tue, 14 Apr 2026 09:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RwjmaZ8D"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7121E3B895A
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 09:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776159550; cv=none; b=AqCOzZflRuf3hoC+X8UG/5kGIm8V34hZEGiQC6t5B1o9a2968SnYtrpJ09RiMJ3JTcPfMzfBQt4bHGOchc7zNx2irDj+SnS4qe+jh3xjTiXX5ImJ6icXNtcD1FWyQhNwjRSmJeHeuKktwwQuXDAqdK1aMbvwPms+n8K/u7G+UsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776159550; c=relaxed/simple;
	bh=9CjN8QKJaZS37XrLND/7+2tyRPuh4F/grHoUHubMTT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p0bkwdcx16cFUhKZ3PXQIA9qVhMOsaZ7i2YV1JxOgd7RzMh4EQKWYlRScuKCcEWhMFAFyYEkHr/AH3comBwQx+sIF2q3Pt+GNZaCT+SvKwfl37irxAWXOwMeNK18uuaj2htKvMsG6PTp+XkcDW0OhB7O1NhjzplLWUaT6wuap+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RwjmaZ8D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E917CC19425;
	Tue, 14 Apr 2026 09:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776159550;
	bh=9CjN8QKJaZS37XrLND/7+2tyRPuh4F/grHoUHubMTT0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RwjmaZ8DHe0zIwVGglFq9cxfKVCEwO20jDRuv964bAglwYo6CXg9lLqIVLWUmR8uF
	 A4/QKiHBuIZf/p1Q2FVSlzmucksuTz8UBvnhMF1+0eydGxWQia78Pa2UxRg3BUcG7r
	 urFTXrtrrsbdpgHp5Hh8uHA/IUx/s9RySuc9v7TWODBIJF+nT6uqQnmqoO++ImIAFe
	 J8RhnUHnmPx7OoBzPhy8c87Ubv3UnH2v/bGhsWs0XrCOzJSMOZVlZrmhwufFZ6pJ2x
	 /f1Ph0SkaNCxTFVWeiOAiqSfCnCiY53MGuXTK/s8GJBpFNhoK/MN4ElIxbu2TgWhJm
	 k7uklo0bwxVmg==
Date: Tue, 14 Apr 2026 10:39:06 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org, Larysa Zaremba <larysa.zaremba@intel.com>
Subject: Re: [PATCH iwl-next 9/10] ice: use inline helpers instead of
 memcmp() for IPv6 mask checks in ice_ethtool_fdir
Message-ID: <20260414093906.GB469338@kernel.org>
References: <20260410074921.1254213-1-aleksandr.loktionov@intel.com>
 <20260410074921.1254213-10-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410074921.1254213-10-aleksandr.loktionov@intel.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278372-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D77F33F80DF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 10, 2026 at 09:49:20AM +0200, Aleksandr Loktionov wrote:
> Replace static full_ipv6_addr_mask / zero_ipv6_addr_mask structs
> and the associated memcmp() calls in ice_ethtool_fdir.c with the
> kernel-provided ipv6_addr_any() helper and a new ice_ipv6_mask_full()
> inline, reducing boilerplate and making intent clearer.
> 
> Suggested-by: Larysa Zaremba <larysa.zaremba@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


