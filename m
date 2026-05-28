Return-Path: <netdev+bounces-292493-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IItMA3qRF2oUJggAu9opvQ
	(envelope-from <netdev+bounces-292493-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 02:51:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7D05EB69C
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 02:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 90219301D683
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 00:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD67175A89;
	Thu, 28 May 2026 00:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jvMjeoxH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5A2197A7D
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 00:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779929080; cv=none; b=QjdX+vwi0TY2kbG+mNf982xIk4ZjKi4zAXfCH0Bu/2g7k05Aoy1N63ro4/Auxc3W97PAbevFavVbUBf3smWGhFolz9f6kSgB7K7pAedcPP8V9ex2doJpXL8od+YosJKxRWVqOH04i+GRPZfc0k/inx/pIhh1fGP29K81dfX9EyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779929080; c=relaxed/simple;
	bh=eHBD2YwjcGL2Kupke6osxp+ZsQKJLogIiYNcVD0QOXU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ElIkAjwwOMLy3eIWNz9S7MBbh1lB5HF0k9FFXRF8/MOWg135Yb6gXfqRuez5lOJjY5wbDAwK76jzyqW7V4HraROGm3Pn2chyl+qJqMShiXD7gShvySguHGBqGuT/HsJGdXyuhOC7xzzpK4WuO2M1V6fPNMC7A02p08PETYRtz/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jvMjeoxH; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83B491F00A3A;
	Thu, 28 May 2026 00:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779929079;
	bh=0GhPTDPLy3t0sp2Ls5AKQu4sV/wdA0f7m/trx3B/a6s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jvMjeoxHI8wy4vsHF2LmDDbzsuWzjO01t1ykvDmdOFm3kvOHBDBuKI9jx4WAP+0pK
	 PgF/bu58dXUqenIYMwUn4DQucoLgImP5Cdw+yZYNKxRC6ACGmEXh0rH1OLjjHEFXRT
	 1Dy/4Ly7rzUBTuQXK+2gFxKdd9YVZD3bD+lubGZU7zCb/w27gaBI2ZnsKAvViJqEtH
	 rkOHFPPwMtRBynE5V9/gbVnHkvXt45TaZrapU5b2qnxmdF8SmwXMoIwFoOe10sPUPe
	 liiIWtd9BO2W12zPwRD/ZCnBjdAYkga/NqVrn5KDQ+wHps4sdcDbhxB5WfjP4bSHWT
	 Fq4aE+6qEtclw==
Date: Wed, 27 May 2026 17:44:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, richardcochran@gmail.com,
 yangbo.lu@nxp.com, kuniyu@google.com, willemb@google.com
Subject: Re: [PATCH net] ethtool: vclock: propagate errors from
 ptp_get_vclocks_index()
Message-ID: <20260527174437.5b48187d@kernel.org>
In-Reply-To: <20260526153650.2779821-1-kuba@kernel.org>
References: <20260526153650.2779821-1-kuba@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,gmail.com,nxp.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292493-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 9E7D05EB69C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 26 May 2026 08:36:50 -0700 Jakub Kicinski wrote:
> ptp_get_vclocks_index() was written with sock_timestamping_bind_phc()
> in mind. Any return <= 0 will get converted to EINVAL by the virtue
> of sock_timestamping_bind_phc() not finding a matching vclock.

Sashiko points out that dump needs to skip over devices without vclock
cleanly. I'll respin.
-- 
pw-bot: cr

