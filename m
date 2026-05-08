Return-Path: <netdev+bounces-286048-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GGvqCixw/mnNqgAAu9opvQ
	(envelope-from <netdev+bounces-286048-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 01:22:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E534FCB79
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 01:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AC63E3005A93
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 23:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD37364029;
	Fri,  8 May 2026 23:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U006x1Qi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589753314AC;
	Fri,  8 May 2026 23:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778282535; cv=none; b=NKL+W+hBRbynAjiHNNRIJa+hKyiWXX36mtc55Qu6WIuJWaUeaTwHTXOnwf89bueBQr1QNgCGxYOYQVnhEmN1Tzo5uPGfkBEuC7TxWydZAe8o2bU8/aJf9Za3/bgit+e6GFvfLeW4o6cCxR6Gb6dOr/4UsTnefn5mhY+JgzORMOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778282535; c=relaxed/simple;
	bh=2AevTr3shap19RUwMMlENTSD4YYHTePzbIvM0R5o1lo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dCiDY0JiYI0unbWFx15mS6GTnMXm6nor8iuEG6FgPEOFAwWz8lpjatFLdUVq5+us727D+fv0A1OJvAHhQH4Zv18qn8+Ai5pIXrpuoa8qci+2FhvAAs7JRLf7u95Jfjhjq+cgWdreWQjQQh6Bu95uqzDLSd69v9eO5GKh06n4MNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U006x1Qi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DAAAC2BCB0;
	Fri,  8 May 2026 23:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778282535;
	bh=2AevTr3shap19RUwMMlENTSD4YYHTePzbIvM0R5o1lo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=U006x1Qi5eQV8i9yrksMub0wobOaVX5RjUJq+keDQ64c+l16x5WSvWiE4KFcC/+vJ
	 roHBlJI3OkPAJJA39d2ejeHLi0IISw5fbcqZccAwDh7PRzjRDwWyeENAZvGeaMsclr
	 RPDbwOtvr6Wv2cyXplNKOlJw1UdcYSp88opgx/WQ+rpBrJ9uJSiXthYLwMtnqzR3RU
	 OCBYCis4bgVvbE1Pufq5fptFH6tEj1GmoT2/x/dMCB0lwB94aDGGR/mwMnWbWO0Ddb
	 vKU6yPeBieS4Y1flyyZjEQ8dztxlSJwdSabxUL/iJqKYO6aic98zhe8C4Kdb7VGmsM
	 J/SLZDHVmTz6w==
Date: Fri, 8 May 2026 16:22:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Steen Hegelund <Steen.Hegelund@microchip.com>,
 <UNGLinuxDriver@microchip.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, "Steven
 Rostedt" <rostedt@goodmis.org>, Bjarni Jonasson
 <bjarni.jonasson@microchip.com>, Lars Povlsen <lars.povlsen@microchip.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, <kees@kernel.org>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-rt-devel@lists.linux.dev>
Subject: Re: [PATCH net v2 1/4] net: sparx5: defer VCAP debugfs creation
 until after netdev registration
Message-ID: <20260508162213.6b755d8c@kernel.org>
In-Reply-To: <20260507184714.joyobsh6ydjzrkc4@DEN-DL-M70577.microsemi.net>
References: <20260506-misc-fixes-sparx5-lan969x-v2-0-fb236aa96908@microchip.com>
	<20260506-misc-fixes-sparx5-lan969x-v2-1-fb236aa96908@microchip.com>
	<20260507090810.53e66ef6@kernel.org>
	<20260507184714.joyobsh6ydjzrkc4@DEN-DL-M70577.microsemi.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: C2E534FCB79
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286048-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[18];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Thu, 7 May 2026 20:47:14 +0200 Daniel Machon wrote:
> > On Wed, 6 May 2026 09:25:36 +0200 Daniel Machon wrote:  
> > > Move the debugfs setup into a new sparx5_debugfs() helper in
> > > sparx5_debugfs.c, invoked after sparx5_register_notifier_blocks()
> > > succeeds so the netdev names are finalized. sparx5_vcap_init() now
> > > only deals with VCAP state. The sparx5/ debugfs root is created in
> > > the new helper as well.  
> > 
> > netdev names are never final :( User can change them at any time.
> > The best practice is to name the debugfs file by some stable hw-related
> > property, bus, port number etc.  
> 
> Right, but they are finalized in the sense that we have a name we can use for the
> debugfs files (which we dont pre-patch).
> 
> Hmm. I think this patch fixes an actual issue, where you cannot query the
> debugfs files, because a previous patch broke the ordering. I agree that the
> names chosen (netdev_name()) for the files were poor, but is that really a fix
> for this series? Should that not be adressed in a future patch for net-next (it
> involves changing an VCAP API function that is not only used by Sparx5/lan969x,
> but also lan966x.).

Dunno, if we are aiming to switch to a different naming scheme we can
just do it now, I reckon. It will not make the fix much longer.
And presumably it will alleviate the need to reshuffle the ordering.

