Return-Path: <netdev+bounces-252413-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCCRFwNNcmnpfAAAu9opvQ
	(envelope-from <netdev+bounces-252413-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 17:14:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B74769B70
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 17:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5D0DC3013870
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 16:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F18D3BC4F4;
	Thu, 22 Jan 2026 15:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nDzPzi2X"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3B833E35D
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 15:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769096205; cv=none; b=u19RwzoUJDTnKKqGyLayJPsz6yRSMTTSSaZ1iZU8ohHd2QzFbbYgqiJ4uq+hbmQerWbuVFPXIJbUaHnho4Cttqwrem9hN7BB6qZaVXEXVTW/hh4GW0ab51I+YIwIF/aAP7zzf2IIlozsaFB/rtIUmDdk1/bd8/n8U6d8iLQrtjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769096205; c=relaxed/simple;
	bh=KLkKNXTbTdeo2MDcbb7rXz0AoJnJZRgPD47siNnfhUE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DB5Mo7GmrU4QhSGeETgZDwRyXFVxWQR0LgFCPe6eREfp9UXun4CSsvChpExzhmWLWcFDPD6TQ75lEoKqmr4iQQXvQ3gzgsGockqi59ySfUvFLFGuLjc24krEopdKo/4TNFJZ6gkQ8KKq4FGLNzxalZTOsB1p/q0G65Ofq5ztiDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nDzPzi2X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E3BBC116C6;
	Thu, 22 Jan 2026 15:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769096204;
	bh=KLkKNXTbTdeo2MDcbb7rXz0AoJnJZRgPD47siNnfhUE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nDzPzi2XeXxPMBzrtvaSUf3SlCvMzUhx/3HMeeIyhElkEoDhIbiNyeuMtNBzixCYb
	 7DNPg1053YzstLlt+00ZZSj1A+rEIX2RSAbMi16qs2FpoSDPGDr82vefSwc/56wLZE
	 sjabZyCHiWiP+EszbFAeoIUjLFC2+r2V+JtlMKu0X+5j9KSzxThuvJ5TyE66QIkX/K
	 qG6vxHE50tlC7B/pzp+Ddbi1Zvzls5kO6BEt332cV8jmIlOkg5qfYNFLa0TyoebpNc
	 Zcw3EzI2+ycfIxG8tKndcqGwx/d7o80kjXKUguSmeri95a5DDXmFPTni4iLRqUPrju
	 BAlXrknJRjSbg==
Date: Thu, 22 Jan 2026 07:36:43 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Subbaraya Sundeep <sbhatta@marvell.com>
Cc: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
 <pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
 <michael.chan@broadcom.com>, <sdf@fomichev.me>, <almasrymina@google.com>,
 <dtatulea@nvidia.com>, <asml.silence@gmail.com>, <dw@davidwei.uk>,
 <daniel@iogearbox.net>
Subject: Re: [PATCH net-next 1/6] eth: bnxt: always set the queue mgmt ops
Message-ID: <20260122073643.4d36e299@kernel.org>
In-Reply-To: <20260122080420.GA1544331@kernel-ep2>
References: <20260122005113.2476634-1-kuba@kernel.org>
	<20260122005113.2476634-2-kuba@kernel.org>
	<20260122080420.GA1544331@kernel-ep2>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252413-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,broadcom.com,fomichev.me,nvidia.com,gmail.com,davidwei.uk,iogearbox.net];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0B74769B70
X-Rspamd-Action: no action

On Thu, 22 Jan 2026 13:34:20 +0530 Subbaraya Sundeep wrote:
> > +
> > +	dev->queue_mgmt_ops = &bnxt_queue_mgmt_ops_unsupp;
> >  	if (BNXT_SUPPORTS_QUEUE_API(bp))
> >  		dev->queue_mgmt_ops = &bnxt_queue_mgmt_ops;
> > -	dev->request_ops_lock = true;  
> 
> Can we also mention that driver with queue_mgmt_ops set makes it as ops locked
> driver in Documentation/networking/netdevices.rst ?

Did you check if it's already documented there before asking me to do
it? I know people don't read docs much but asking someone to document
stuff that's already documented is a bit funny..

