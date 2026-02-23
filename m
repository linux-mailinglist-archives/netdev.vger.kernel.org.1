Return-Path: <netdev+bounces-260238-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uPY0F7XTnGkJLAQAu9opvQ
	(envelope-from <netdev+bounces-260238-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 23:24:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E799917E483
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 23:24:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E3C443027314
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 22:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6110378D85;
	Mon, 23 Feb 2026 22:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fkHMTjfw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B437E329E57
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 22:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771885489; cv=none; b=Vk/bXEvXLDcToD7jb+37Ttq3UGqi+dhrlMyNqRPhU+9ypUCPFCKYFFIQsvfC/SGKrURMBamfy07OPTexbTLP9fwaQGO4lPrU/Gavaca+d5276+QA4WZ0OmRPntYrAPe4pr86WtOpLHF9OpEoS0sxqLHdcC6vIP8aAJ9ffFOwxME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771885489; c=relaxed/simple;
	bh=0VkjYryZowNMu1EDooetduYdfglDwYWjSvl6W7SQww4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d2Cqys5sCFV92x/bnkN0OFjNBIjYaYb7AtGrWnA0IhIU0gCWZk9yqYs+lrW9rv6+7KUlBfnrWLPg0PelsnhTdM2drRXhyu8nXQznheYEVVRr17jTZn8g8e3HVtG2/jY7LLx7BzetaIAoPw4CpdfbLfYBaA0+SJDC921fHZgll6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fkHMTjfw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69674C116C6;
	Mon, 23 Feb 2026 22:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771885489;
	bh=0VkjYryZowNMu1EDooetduYdfglDwYWjSvl6W7SQww4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fkHMTjfwi9BNWqyi7Sc5EkfgMIJwtJ04D9iNieiLLY8abJVwZleVTsCyNfiVsiUKh
	 pHS+tHR81salKY5O0tAK4xN5rdF4wR92Zeh7e8aRpdwBZ9kEuvPL8XuGu0DJAm/1jv
	 tW21L2qLq9LSXfdEneHLV1Z2Bx1Bc1doFEB3Hz661hAtD1tA5m2s5WgJF9F0X1ws34
	 Bv90GtyuzymJHbM9KNRX7xBC2Jb/r7d5thIWooUsep3AqXfUFCJU6YKyYwUlxjtHss
	 39/+KD1OvdM+U4N1MNNROT+/uaBLfGUXuYo8vaylURd7kC4uEhZZ6PYU0DOTVGK3YP
	 Q5TvcYd6ZCeIA==
Date: Mon, 23 Feb 2026 14:24:48 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Shantiprasad Shettar
 <shantiprasad.shettar@broadcom.com>, netdev@vger.kernel.org
Subject: Re: [PATCH 17/62] bnxt_en: Make bnxt_resume() easier to analyze
Message-ID: <20260223142448.6f59bc7d@kernel.org>
In-Reply-To: <20260223142344.62457ab3@kernel.org>
References: <20260223214950.2153735-1-bvanassche@acm.org>
	<20260223214950.2153735-18-bvanassche@acm.org>
	<20260223142344.62457ab3@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260238-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E799917E483
X-Rspamd-Action: no action

On Mon, 23 Feb 2026 14:23:44 -0800 Jakub Kicinski wrote:
> On Mon, 23 Feb 2026 13:49:05 -0800 Bart Van Assche wrote:
> > Pass the same argument to netdev_lock() and netdev_unlock(). This patch
> > prepares for enabling the Clang thread-safety analysis functionality. No
> > functional change intended.  
> 
> Please split out the 13(?) netdev patches to a separate series.
> If you CC us on a subset of the series out CI will not test it.
> Please keep in mind that we ask to wait at least 24h between
> resubmissions

Oh, not 13, 5, you already spammed us 3 times with this. Sigh.

