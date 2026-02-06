Return-Path: <netdev+bounces-257410-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eENxCrxVhWmnAAQAu9opvQ
	(envelope-from <netdev+bounces-257410-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 03:45:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B229BF96A2
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 03:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BBCA63017079
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 02:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023B9286405;
	Fri,  6 Feb 2026 02:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q1RLiyrN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42C028507E
	for <netdev@vger.kernel.org>; Fri,  6 Feb 2026 02:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770345913; cv=none; b=cvtvg7C6my63lWdjlnJZ/pEdsM0UvTHU999Is/IRfytV2dKJJB2U/8OxQ3cBZ5HTHMYKZmKauc2UaExTTAu+Ad7aiJ4tNLk5mbkPh5F1RVaVCJF86YVCf9PDCC0n+9oj9uutn82K1I0eRTpYjuXViKZyd+v8WRmEHkjH4SKwymg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770345913; c=relaxed/simple;
	bh=8CNFS45Oc0fm3+DqsFHXkg7W7FjbbaNCYL0QqeshuS4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XypIGub1uD5KbOO2cg/NFX1lwbw9AKxR+z+SYRBhu3SgxGfJ43UP0I83toxLEHmtU/KC5MLQJT9+nuy5tUM1Ev1EO+iXX/lnBFCxa5jd+IpKyz+s1Fu/Ofl0uLV3Zi9EOtAcZF2NYcdFuRFS9PAOrFXbm7G5h7mf22MeOf621ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q1RLiyrN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2263BC4CEF7;
	Fri,  6 Feb 2026 02:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770345913;
	bh=8CNFS45Oc0fm3+DqsFHXkg7W7FjbbaNCYL0QqeshuS4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Q1RLiyrNgSnu1Q5+gv9Dn4jjsdHtP4v53m7UmZDAOkqmPa16oaOgOcbjiV9wmMC6d
	 qleJtbFbppNPT4jrn8b62II1SDA8guyxOkTJiqw7FxEOmjoXS4pNMD9aq7zjH+Oxo7
	 qImlNiwobT3WSWO4I4XdtHHTsR6JEzVz7DxnctYzxqPGw0W074XoUSGbBijTto0+j5
	 QqaNkb+1XBCnVlWwCYNvkwhOKIKlpROEIQfT+aS7lyG2cDs+o06zVbAFPa0Nj4DLnf
	 VFI/ia35nhFB2+rqtXXCyqDTH3xJhHHPwrCmlzdkfcneEW396RVvdi22rLduemHSa3
	 suxSCKKxtstxA==
Date: Thu, 5 Feb 2026 18:45:12 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Tom Herbert <tom@herbertland.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, justin.iurman@uliege.be,
 willemdebruijn.kernel@gmail.com, pabeni@redhat.com
Subject: Re: [PATCH net-next v7 00/10] ipv6: Address ext hdr DoS
 vulnerabilities
Message-ID: <20260205184512.306ec46b@kernel.org>
In-Reply-To: <20260204225154.58245-1-tom@herbertland.com>
References: <20260204225154.58245-1-tom@herbertland.com>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257410-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,uliege.be,gmail.com,redhat.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
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
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B229BF96A2
X-Rspamd-Action: no action

On Wed,  4 Feb 2026 14:51:44 -0800 Tom Herbert wrote:
> IPv6 extension headers are defined to be quite open ended with few
> limits. For instance, RFC8200 requires a receiver to process any
> number of extension headers in a packet in any order. This flexibility
> comes at the cost of a potential Denial of Service attack. The only
> thing that might mitigate the DoS attacks is the fact that packets
> with extension headers experience high drop rates on the Internet so
> that a DoS attack based on extension wouldn't be very effective at
> Internet scale.

Patch 10 never arrived..

