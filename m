Return-Path: <netdev+bounces-278094-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qO/WCZr53GnXYgkAu9opvQ
	(envelope-from <netdev+bounces-278094-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 16:11:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 255D23ED1F3
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 16:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B6203300463D
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 14:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A181D3D811A;
	Mon, 13 Apr 2026 14:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vuz8JIgy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9563D75C3;
	Mon, 13 Apr 2026 14:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776089491; cv=none; b=u0GK8DKUy0Zh0oD6dEUDsF/TMPK1MlIDaTsfmzN/lFoY6nr6+d/HhNhanpfoSVMLzxIRe+cA4Ze8plj/ovsEyCuGzZ63YIYya12bBnVbf8kn7N07bvqjcxmCqKeUeIjm2NurxBajG/yK3JE8dwJpzsXVIEKrCQH5EJdbEzRlixk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776089491; c=relaxed/simple;
	bh=gFRvrKXlOfg+aEGi39wpVj9CoHvkfV4SW9XjwhO71Bg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NT9nx60rWuWtxgpXpgamRXf0KlMHUAU03D2goTzO+2aVFatTlN0NpSt9bDQk7kaaXhtSJNAlgqHcqcTE7zS/sqCY70DDgJFJC4iF+9E0Pvkqwa8U5WAUOUflkjHnhMN29t/v4YfQzqxxc+v/j7bRWMBbYtxcpQv8KaQSrXzQnSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vuz8JIgy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD6D9C2BCAF;
	Mon, 13 Apr 2026 14:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776089491;
	bh=gFRvrKXlOfg+aEGi39wpVj9CoHvkfV4SW9XjwhO71Bg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vuz8JIgyGFQs79J7jNYhLXjVTEJKcIy7q5fIMQvp69Rs6UAmh9zywB6sRRJyuSPZ2
	 g+pdHQ203cM48BifuF+R1XKrQAour1unMgz1Hs9HNTMCQzb2M3F4CRrv4S2bN2AAfT
	 29qhXHvawfyEttE99sA2TD0YgSFFuxY+c2+oUt2NwsZH5HNRQi85n8aohpaOvSd32v
	 fM9Vygo51KBRkcEEhB8B9OMaZ7kqOmtJ3ZeRTprb2EqP88EMVtZe1TDG9WyHnoQiru
	 RKdLCkyaoXwYB6kV24hu8LH8p1H1q0ApAoO5ee8ZbPe7R36iMv9CJbvNo5XyKF14mn
	 aGz59T8PyA/0w==
Date: Mon, 13 Apr 2026 15:11:26 +0100
From: Simon Horman <horms@kernel.org>
To: Matt Fleming <matt@readmodwrite.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@cloudflare.com,
	Matt Fleming <mfleming@cloudflare.com>
Subject: Re: [PATCH net] ice: Fix missing 1's complement negation in GCS raw
 checksum
Message-ID: <20260413141126.GR469338@kernel.org>
References: <20260408190214.1287708-1-matt@readmodwrite.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408190214.1287708-1-matt@readmodwrite.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-278094-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 255D23ED1F3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 08, 2026 at 08:02:14PM +0100, Matt Fleming wrote:
> From: Matt Fleming <mfleming@cloudflare.com>
> 
> Commit 905d1a220e8d ("ice: Add E830 checksum offload support") added
> Generic Checksum (GCS) support for E830 NICs but omitted the 1's
> complement negation (~) when converting the hardware raw_csum to
> skb->csum for CHECKSUM_COMPLETE.
> 
> Without the negation, every CHECKSUM_COMPLETE packet fails the
> fast-path validation in nf_ip_checksum() and falls through to software
> checksumming via __skb_checksum_complete(), which triggers the
> rate-limited "hw csum failure" warning. Packets are still accepted
> (the software recheck passes) but hardware checksum offload is
> effectively disabled and the warning floods dmesg on systems running
> nf_conntrack on VLAN sub-interfaces.
> 
> Multiple other drivers (idpf, ehea, iwlwifi, cassini, sunhme, enetc)
> also apply ~ for CHECKSUM_COMPLETE. The ice driver was the only in-tree
> user of csum_unfold() for CHECKSUM_COMPLETE that omitted it.
> 
> Fixes: 905d1a220e8d ("ice: Add E830 checksum offload support")
> Signed-off-by: Matt Fleming <mfleming@cloudflare.com>

Reviewed-by: Simon Horman <horms@kernel.org>


