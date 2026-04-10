Return-Path: <netdev+bounces-277593-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aIBIFRRv2WnGpggAu9opvQ
	(envelope-from <netdev+bounces-277593-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 23:43:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EEEA3DD021
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 23:43:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6F3E9300BE1E
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 21:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA713DA7F4;
	Fri, 10 Apr 2026 21:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KQDsB1+T"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C7D3DA7D4
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 21:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775857421; cv=none; b=LMEsVG7aowwuElVGB96B73Od3YV8IMI5MFQ5fqDAhz+W9hUxFWS8/tRjiSWfsujp97NZNoSvxRQvLaXcI7R5kLmWQnMx7KD9XbECnMFpnfT3PqLVM+Eh4dYDcBz3TBBQ8nKmNUaqrFDseUK18w38p7IWKwnrkL3rnkhyf5RkXls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775857421; c=relaxed/simple;
	bh=MdJPtW/AiFGu719sINGZALkLv1UoDWrGatNqiCqq9K0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jcUWa5dsRmcX0KiH/E9cY7hD2UhbpemtfAJ7U+DW2OJqZzhwBfs9IhjTbWOCJV9O4AuUpPMPzeQj73ZfFz0JRgCM4AOcFelgTfPicFmwboLlPGQ9LatI83TErxtJfkrjir4E83nV+HkP2MLVQzqUp3XW8Tf+G89JQJt2kpCkKwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KQDsB1+T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B150FC19421;
	Fri, 10 Apr 2026 21:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775857420;
	bh=MdJPtW/AiFGu719sINGZALkLv1UoDWrGatNqiCqq9K0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KQDsB1+TPNipJhw9FB/pmXBtD5bnB5fRvQNm0Jfrknz2R0nQJ+pWETHihGPqjLaaH
	 hoJBaCZ2T5Dp4F1yMlwhVSmnGDlcp8ts4N+b6IHi46M/iiwGtB1HKcrU8HBJoSsRpO
	 OzXyOlejIWHAakQkYDKRATVOmYHwnU4URFzDBMLnaNFmWNGNNQSo6ZTCK9ZQrS/qrT
	 ZLVgOGJRCKMMF12ANICgFVJOKIBOYfw7XEzcz8TSaakCdheoZjBm99EBqOFviZrgKx
	 YusifpBrocPmGTyI7eOcISofzmHkshxczbIIX9YpaxXK3CPX/WuldAE7Z2CyB0yMBY
	 PzgN7/gklnZOA==
Date: Fri, 10 Apr 2026 14:43:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: wit_yuan <yuanzhaoming901030@126.com>
Cc: netdev@vger.kernel.org, Yuan Zhaoming <yuanzm2@lenovo.com>
Subject: Re: [PATCH next-next v2] net:mctp: fix setting mctp hdr ver
 reserved field cause  data dropped
Message-ID: <20260410144339.0d1b289a@kernel.org>
In-Reply-To: <20260410063334.7531-2-yuanzhaoming901030@126.com>
References: <20260410060957.1336-2-yuanzhaoming901030@126.com>
	<20260410063334.7531-1-yuanzhaoming901030@126.com>
	<20260410063334.7531-2-yuanzhaoming901030@126.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277593-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[126.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,lenovo.com:email]
X-Rspamd-Queue-Id: 4EEEA3DD021
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 10 Apr 2026 14:33:34 +0800 wit_yuan wrote:
> From: Yuan Zhaoming <yuanzm2@lenovo.com>
> 
> from spec dsp0236_1.2.1.pdf page 26, the mctp header contains the
> RSVD(4bit) and Hdr version(4 bit).
> 
> mctp_pkttype_receive invoke mctp_hdr, and get mh->ver whole byte 
> compare the MCTP_VER_MIN, MCTP_VER_MAX. the reserver bits may be by 
> misleading used.
> 
> one type hba card will set pcie vdm header Pad Len the same with RSVD
> bit, this will not work on mctp kernel solution.

We ask that:
 - new patches are not posted in reply to old ones
 - at least 24h passes before new version is posted


> +	if (((mh->ver & MCTP_HDR_VER_MASK)) < MCTP_VER_MIN || (mh->ver & MCTP_HDR_VER_MASK) > MCTP_VER_MAX)
>  		goto out;

Please save the masked version to a variable and compare that extracted
variable. This line is unnecessarily long (max line length is 80 in
networking).
-- 
pw-bot: cr

