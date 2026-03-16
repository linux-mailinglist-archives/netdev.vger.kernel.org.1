Return-Path: <netdev+bounces-268263-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 5bBKCdpcuGnXcgEAu9opvQ
	(envelope-from <netdev+bounces-268263-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 20:41:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A640F29FDC0
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 20:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 08CD43026B7E
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 19:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D52A93E717B;
	Mon, 16 Mar 2026 19:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t6gf85r8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B361A9FAF;
	Mon, 16 Mar 2026 19:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773690069; cv=none; b=iiPbCehsUJTikfMM022U0njNo/SF22o3AAfyEv3IqbThRiMG9m1yZGe1SybhUudOtdSumCZzGT1yvBS6IcfhqszL+svX8aYNDmr1u3Ghlo4TbSTfXHBhl2nsTk63Fj+w2m9fCh2BAuVmtBkGQ4y97/nulL2i1ye/fcCUoNq0raw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773690069; c=relaxed/simple;
	bh=+r/rKSDJHKoEyUKWlrdPrbGCuVC2E2OzQyf0nGl0zCc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vBKbY1tMzHPzVY5+YicK3GjTE4RqVB/PWI0kvmOdbpI1VzqRJ0Yk4wzcQbKQTuS/rnvWShWZTaLDmw9rkJNJZYpntx1V60MAQd2L3GoHunrjSRXe9zZdx6A203lTqQOvI9HjhhPZnvW9fmIdkHFMbsIWeVTojR53hq/hHRWbrBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t6gf85r8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FBBCC19421;
	Mon, 16 Mar 2026 19:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773690069;
	bh=+r/rKSDJHKoEyUKWlrdPrbGCuVC2E2OzQyf0nGl0zCc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=t6gf85r8cnydejSet9c0sttbHQI2BMNRJUEL4LM4qSqlCJPzzGrYam2YVn67iGS6l
	 UsQQkMIXKR/3xG0sCF3Wxa4rzDUn8mCMroPEAiHofQNkMgtxKsvXC5lI6kVEmpsmnA
	 qSraGb/SPn2C47x4f/prj3MqR7r6mTTJFdCNdgPhrjnCRGyyOSKsN/UJFO60tGmw3b
	 9qcfktfmvpFSoaPZl/ufmkfdQYL2LDdO7qV7v7psaivdxOReDjwVRD+NozCIzeAzPa
	 Pf5gxG1Aq5ju6cAFsij9yibQ2GqLAQM7cFvAxE+zIwfMaj7Y8qQYql8y4xa9qf/MJW
	 Qoo16doqzV/Tg==
Date: Mon, 16 Mar 2026 12:41:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 <intel-wired-lan@lists.osuosl.org>, <linux-kernel@vger.kernel.org>,
 <netdev@vger.kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Paolo
 Abeni" <pabeni@redhat.com>
Subject: Re: [PATCH] idpf: Replace use of system_unbound_wq with
 system_dfl_wq
Message-ID: <20260316124107.0dd3cc2b@kernel.org>
In-Reply-To: <878cd07a-b7fb-491a-9cec-8ddbab2bb13b@intel.com>
References: <20260313150917.271086-1-marco.crivellari@suse.com>
	<0ca7f92b-ec4e-469c-ad2b-648d278bcfe9@intel.com>
	<20260314091048.235a6d0b@kernel.org>
	<878cd07a-b7fb-491a-9cec-8ddbab2bb13b@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268263-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A640F29FDC0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 16 Mar 2026 09:58:29 -0700 Tony Nguyen wrote:
> On 3/14/2026 9:10 AM, Jakub Kicinski wrote:
> > On Fri, 13 Mar 2026 17:08:57 +0100 Przemek Kitszel wrote:  
> >> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>  
> > 
> > Process question - even tho you are also a maintainer I only read
> > Tony's tags as "please apply directly". LMK if that's right, I'll
> > try to remember / make a note..  
> 
> I talked to Przemek about this a little this morning. Since the 
> Reviewed-by tag is used more prevalently in our process, perhaps an 
> Acked-by could mean take this directly and the Reviewed-by keeps the 
> same process of going through IWL. Other thought would be to explicitly 
> ask/state for it to get taken directly. Open to other ideas as well if 
> there's something else you'd prefer.

Sounds complicated :S Let me continue ignoring Przemek's tags for the
purpose of direct application. I guess it's more about who sends the
PRs than who is a maintainer. If you send PRs I naturally never see
your review tags, as the patches will eventually come out with your SoB.

