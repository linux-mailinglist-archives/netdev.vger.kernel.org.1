Return-Path: <netdev+bounces-275055-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aMs/CsjEz2lH0QYAu9opvQ
	(envelope-from <netdev+bounces-275055-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 15:46:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E58394A94
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 15:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6AE283010BA4
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 13:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB5124887E;
	Fri,  3 Apr 2026 13:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="td0Sco6p"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D61A18AFE
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 13:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775224004; cv=none; b=bc9wY4SjFauAc5/kdz0eA/lZXw4DKlu7CzOtU+XUXDALLBM/SXfLvkqq1B7PTv+/bWUPIiRJygEkU2IauciJ+p+QiAgmLmIq/ijekSZsqt2/fHbg9BOKMjk98XvmMb/B5gt9uRpl3mZI5yUmn3h8K+SkF1sFAZXzibQ94jpS/Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775224004; c=relaxed/simple;
	bh=dhORVKWFgjtVArpJ/zyWhD6ZCl+KA8tWqkp4buwBhVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kRcOq6/3nt05n3fepNRxkhRhQeippXzYCBnD7Ucm9bwXWiVpKMcV821/O86aMZq0JyxQvi0WjHgDMm+Mdd+90JgNdj5t7zl4e2JddKui40bho0bGiVUEIlGMdXZM7/Blp5CyqPDSfHu7173C8QuHWGjW+vLXHrvGpo9wDofS2ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=td0Sco6p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF2F8C4CEF7;
	Fri,  3 Apr 2026 13:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775224003;
	bh=dhORVKWFgjtVArpJ/zyWhD6ZCl+KA8tWqkp4buwBhVc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=td0Sco6pI+LxyaIhFPmXSLmUkKKwdApeH2C2hVh83THoIuY85J2eBJ2r4F5l5UNMn
	 F8tOC1z5zuCKJrd2ZmDV3DcJH7CV4SHKLPcMfZJnzK2qXc+319MlYKxVzt4i31O/3Q
	 1JlmkYIre6WzEO6NbaJbSnE/Sy8M9fNKyuRhnRCGfG59f0/ZV3OC7syhptbDxYhPXv
	 5pA8iyVmjkxqkrKRhzXpyDFRDZVJNegQuC1Tenh+Mf90FS50jqJhncnQ1ZZxkPHht4
	 EQvtcSaJ0RQDRFNKZgyvk6z7FS0EVwlUMDllVjJvN20HvQcoKdHBUgdmXy/RDapie3
	 eN6Oa/WwJlomA==
Date: Fri, 3 Apr 2026 14:46:40 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	Marcin Szycik <marcin.szycik@linux.intel.com>
Subject: Re: [PATCH iwl-next] ixgbe: fix cls_u32 nexthdr path returning
 success when no entry installed
Message-ID: <20260403134640.GG113102@horms.kernel.org>
References: <20260327073046.134085-1-aleksandr.loktionov@intel.com>
 <20260327073046.134085-8-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327073046.134085-8-aleksandr.loktionov@intel.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275055-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[horms.kernel.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 90E58394A94
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 27, 2026 at 08:30:42AM +0100, Aleksandr Loktionov wrote:
> ixgbe_configure_clsu32() returns 0 (success) after the nexthdr loop
> even when ixgbe_clsu32_build_input() fails for every candidate entry
> and no jump-table slot is actually programmed.  Callers that test the
> return value would then falsely believe the filter was installed.
> 
> The variable 'err' already tracks the last ixgbe_clsu32_build_input()
> return value; if the loop completes with a successful break, err is 0.
> If all attempts failed, err holds the last failure code.  Change the
> unconditional 'return 0' to 'return err' so errors are propagated
> correctly.
> 
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>

This feels like a bug fix that should be routed via iwl-net with
a Fixes tag and some description of the user-visible effect
of this bug.

Else, please clearly state in the commit message that this is not a bug.

...

