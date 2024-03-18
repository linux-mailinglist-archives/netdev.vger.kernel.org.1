Return-Path: <netdev+bounces-80458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D184087EE74
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 18:09:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EB581F2471F
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 17:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B4454F96;
	Mon, 18 Mar 2024 17:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vml4KMbB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lK6sLjjW";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LHH73Z5l";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/tYtToBm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B387555C34
	for <netdev@vger.kernel.org>; Mon, 18 Mar 2024 17:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710781740; cv=none; b=JDq8GE1QUZw1Iz2HdUo2QlFA+yD3bV0zuTHvXGa9Tysqvr1Q6g6zDqs7Tz5xy7ppcaFEa8L1269nu4R3LE9YXVIu+KzBwUKhWu2xlqRHskFLD6nTCEFXShZ90t7SFeZmanO5WsA34+hhQyDMk3Gz7eNyvF4Mb5RJzizRrIvlsio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710781740; c=relaxed/simple;
	bh=2Jh06q2N+PaoyTfx/05eU5SdyF4sKmU3zCLX/+7z2fA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UVlEvWqcJL0e8ttcs+j4HiKVQD+ZGNw18kv6efqwDy35Vun0WrHKDAHJV2JZpMONHnQ6xUbvTHEyXkPhTdIxgmQNBtg6v9Bz5mxwp2Hhi4DlaQXCygMr4a/ndU1UifvmhaVa/hAKunmMmvx9H2qu+LuiXOArpStnDIxXsgpkIsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vml4KMbB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lK6sLjjW; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LHH73Z5l; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/tYtToBm; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from kitsune.suse.cz (unknown [10.100.12.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CD9CE5C7BD;
	Mon, 18 Mar 2024 17:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710781737; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ftgY+bLb8XwfHyNervbdasFc4FlYUFBR74M9K0wXRRU=;
	b=vml4KMbBoSdX7TzpANJILNLPkosIvB3jQMDK7SgDm7qYh8gl6hJOWSw/xKZ+hlZiaAWCYy
	CjLkv/5dbuaYtU8e6lyt7riKmOqvDyA8n+1Rm2rIf0GUFkWRYWXtgjW5L4oziM67qGErfD
	YSyLhWqrJrJtVmeVA0avYeTKKqPuCdw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710781737;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ftgY+bLb8XwfHyNervbdasFc4FlYUFBR74M9K0wXRRU=;
	b=lK6sLjjW+BWes869Ev3Zwkmn1q7aHB7iPhWXEkxRA9HjXyT25KTEOtAeBEaBX5XPyOpfvL
	MFBGyIFb7+B+mjDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710781736; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ftgY+bLb8XwfHyNervbdasFc4FlYUFBR74M9K0wXRRU=;
	b=LHH73Z5lUD01YkOLQIME/DpDwb0eYMJluswQqcNLUQ8Mzuo+H1dklZ4H/OleGN5iSOQ6V2
	3OrCNjJnoKFy7fUMMNHmNXIIxh+1dbSMJpBB1fenuE4P1AxVjIhIh/0egPzFeiJOn8Do6t
	zg2YGnIkI2TB6zbE1R0iHdU3DVir2GI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710781736;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ftgY+bLb8XwfHyNervbdasFc4FlYUFBR74M9K0wXRRU=;
	b=/tYtToBmjXBuFy/sx0vDRx1IPjdDVL+OpO3t5nHLhGdXKyCMvBIewH3pHuipRdyH3IYYw+
	jf/PbZfKrR6BRUCw==
Date: Mon, 18 Mar 2024 18:08:55 +0100
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: dtsen@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
	wireguard@lists.zx2c4.com, "Jason A. Donenfeld" <Jason@zx2c4.com>,
	netdev@vger.kernel.org
Subject: Re: Cannot load wireguard module
Message-ID: <20240318170855.GK20665@kitsune.suse.cz>
References: <20240315122005.GG20665@kitsune.suse.cz>
 <87jzm32h7q.fsf@mail.lhotse>
 <87r0g7zrl2.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87r0g7zrl2.fsf@mail.lhotse>
User-Agent: Mutt/1.10.1 (2018-07-13)
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -1.52
X-Spamd-Result: default: False [-1.52 / 50.00];
	 TO_DN_SOME(0.00)[];
	 REPLY(-4.00)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_ZERO(0.00)[0];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 R_MIXED_CHARSET(0.71)[subject];
	 BAYES_HAM(-0.04)[58.07%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_SPAM_SHORT(2.91)[0.968];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com]
X-Spam-Flag: NO

On Mon, Mar 18, 2024 at 10:50:49PM +1100, Michael Ellerman wrote:
> Michael Ellerman <mpe@ellerman.id.au> writes:
> > Michal Suchánek <msuchanek@suse.de> writes:
> >> Hello,
> >>
> >> I cannot load the wireguard module.
> >>
> >> Loading the module provides no diagnostic other than 'No such device'.
> >>
> >> Please provide maningful diagnostics for loading software-only driver,
> >> clearly there is no particular device needed.
> >
> > Presumably it's just bubbling up an -ENODEV from somewhere.
> >
> > Can you get a trace of it?
> >
> > Something like:
> >
> >   # trace-cmd record -p function_graph -F modprobe wireguard
> >
> > That should probably show where it's bailing out.
> >
> >> jostaberry-1:~ # uname -a
> >> Linux jostaberry-1 6.8.0-lp155.8.g7e0e887-default #1 SMP Wed Mar 13 09:02:21 UTC 2024 (7e0e887) ppc64le ppc64le ppc64le GNU/Linux
> >> jostaberry-1:~ # modprobe wireguard
> >> modprobe: ERROR: could not insert 'wireguard': No such device
> >> jostaberry-1:~ # modprobe -v wireguard
> >> insmod /lib/modules/6.8.0-lp155.8.g7e0e887-default/kernel/arch/powerpc/crypto/chacha-p10-crypto.ko.zst 
> >> modprobe: ERROR: could not insert 'wireguard': No such device
> >  
> > What machine is this? A Power10?
> 
> I am able to load the module successfully on a P10 running v6.8.0.

Of course, it's not a Power10. Otherwise the Power10-specific chacha
implementation would load.

Thanks

Michal

