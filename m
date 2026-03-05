Return-Path: <netdev+bounces-264123-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBCmEnPgqGnzyAAAu9opvQ
	(envelope-from <netdev+bounces-264123-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 02:46:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8DB4209FCB
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 02:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E974D3006B0C
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 01:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 232AE1643B;
	Thu,  5 Mar 2026 01:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EJGjVU+c"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0043433688A;
	Thu,  5 Mar 2026 01:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772675166; cv=none; b=Jw1xQ9rgaB9ICwRFVRnDhROhpA9CeM+5KGKQv2uTyC8mSa3sk7F3EErBzsky4iE1rQR/pDM6lHiBTQ/uv7VGeSjJMz76xn/ppiD0b3B9O+J8dmA6xlQaEvfAPT2WKgs6R+CI2Mhe6x9v3GboaNQ+pLSEW+ZmQeJpgCDobDkF9Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772675166; c=relaxed/simple;
	bh=jGgua4ZWYKGM0DDprbPTGzqt9oIqL8qOxD6wHpeP3uo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fX9dA4EpGb5j+3gzkLf6QvALswvt5JoTSD8ObtRKuFckdjWnfCF2ig5xlWEzeSgpCUQ9Jnb2ZvJEb2rGg1OfNqXaZnZ4SLjR/c9XSqD1gw/BGRXfn3dMUasQxGrNMKlYlB8ILiHuxWnSQqnCz0AjWnappg/HdN5wW0/KvaAkFWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EJGjVU+c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1CDFC4CEF7;
	Thu,  5 Mar 2026 01:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772675165;
	bh=jGgua4ZWYKGM0DDprbPTGzqt9oIqL8qOxD6wHpeP3uo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EJGjVU+cOtI5RyIEXCbqJ828Q1ibQEdgbo9sc/wx47Ilgmm3cw7h6BsReAuH4mLt6
	 WdrTGh1opCXFFG/hBBg3P7o/pBianXFBVYB6rXNZ603xLTqgN45v9PvzxQ2DSlFJRJ
	 iiCv0LoeHNqW7M7hjQJSdjSMIyLFuyeE36PodbiZKQdPAU1Jl3VauGCEn3dyb5drJ7
	 r+OuyzUD09bkTSkj7R7zELmo9TCl/KJ6xtQF7brvz+PYamRLVR8PVSuEwUIvrWtqH3
	 QqQ4vDCTkH4Z9iqVW+T1IRqrh2oYHiGRmcKnDbNNCsz8vnCLCOR8Ymv1Acub0hZiH2
	 ZfeaAUIGbaa5Q==
Date: Wed, 4 Mar 2026 17:46:03 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 chia-yu.chang@nokia-bell-labs.com, idosch@nvidia.com, willemb@google.com,
 dsahern@kernel.org, kuniyu@google.com, ncardwell@google.com,
 skhan@linuxfoundation.org, corbet@lwn.net, horms@kernel.org,
 pabeni@redhat.com, davem@davemloft.net
Subject: Re: [PATCH net-next v3] inet: add ip_local_port_step_width sysctl
 to improve port usage distribution
Message-ID: <20260304174603.72553f70@kernel.org>
In-Reply-To: <aa36b48c-6184-46f3-bf6e-4750c2266f35@suse.de>
References: <20260303172949.4741-1-fmancera@suse.de>
	<CANn89i+ntGv0gGYvRq8yziGTE01ozBJ_Mn_RDPXLgs+yU5whrg@mail.gmail.com>
	<aa36b48c-6184-46f3-bf6e-4750c2266f35@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: D8DB4209FCB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264123-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Wed, 4 Mar 2026 10:54:16 +0100 Fernando Fernandez Mancera wrote:
> > Some guidance would be nice. What values have you tested/tried ?
> 
> As I am working on a patch series with improvements to ip-sysctl.rst 
> documentation I will handle that there.

I'd prefer a respin please.

