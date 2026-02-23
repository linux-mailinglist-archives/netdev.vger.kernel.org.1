Return-Path: <netdev+bounces-260075-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uCPXGhNtnGmcGAQAu9opvQ
	(envelope-from <netdev+bounces-260075-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 16:06:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D7CE817877D
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 16:06:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 98216305DD04
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 15:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EAE535BDAF;
	Mon, 23 Feb 2026 15:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="Bi8miG0S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D0E3451D9
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 15:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771858931; cv=none; b=OhddxRCXcgsgO3cReyz2cmIzikH2fdl136u6YKbRpuQelx0y0C8dUGs4MJ3oyY3m9tLPteBvoXZh9IESH+NVieGmW9rRoFBiJhZMIfbNnxlaPzai38qascl3RElUK1YpEU+uunsYc6mu+HR9BojuMDn7ij+jMBRm/4nzgj1hX+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771858931; c=relaxed/simple;
	bh=DJpNDmDyIrKn7kt89iPA47eOQyY++TU0zFaH3aJGWKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hed4neShZfuj6t/OcZE0wrulWXBZ/uVzlwuSY8NjdcchzBs9JkbsjAMTtqDU0Jm7KTakbzbeluOBXdr8uRHi2yVjamC8yb58UT7hz7PfXYZ0ERBZKMK1zetWg8IObwcrzPmFLP4rPcu7ScrtCcIEw1QOtmgpyV6veL7jI68jGpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=Bi8miG0S; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7d4c68f0e47so2532731a34.1
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 07:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1771858928; x=1772463728; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qTN8ZuMw3IBNaYoAHK7lC0KSJE/o8k5UplAc8Jft30I=;
        b=Bi8miG0Sz573Ii1SK02XqPqZszZtXFDC0s6JN389hMiZtRDnkSysCkW8y7t2ppBoW/
         Da3FKVsegMw7XQXA//pcJ6js2xHUKiPdItV/vaeI7DAYPON02291qWV6KNiaHUnFe4Qp
         ib3hjtmYjr+JWidZSanRGb1othbLDyCT1OkY0890ZEgSLyd8fQcJl3UfaIcKgdM+Flfc
         MKGdzVa72C4PyJtfqenpPmShoxQajId86sk3Swij0YoSpdM/Zhi//xCxEkbrqZI0CyA9
         vZw1mxOGIaiiJz+PY9AVBH6uu7GXpT4TqKqktHDQeGvDqXwyIMLRj+9xmOyIzWBDS5pl
         TVhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771858928; x=1772463728;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qTN8ZuMw3IBNaYoAHK7lC0KSJE/o8k5UplAc8Jft30I=;
        b=l8U1JLpqKucfdad85Q9YQjpLKciMfDYsFjlKMEG97ggVkMqjmDOvWcudwObaxicTtA
         TMiDWUhycTizKg6VbgRaUufCSEIFOS+AnztFcPTXPBTOw52JEGjdnSGA4+DzP+YP1aw8
         0dm7w8qR3Xek/hOg21z/eyABPYfPiflr7yjkdetyZjFlZ/FgKKxhkY7+kkGuQA0Bffk3
         2q51Q6qfqAjF2vuOnIEsnune1IApxl4xtqYo2PkF+bztczn+BqFg9YtY6NZTDwKHQE+x
         uDNeKqGUXMN1hZkC7PIFtFngQgptvLlo+Ix1yKxdWQdJnnHeo0FclPV4rqsaSpcdcyKz
         eDtQ==
X-Gm-Message-State: AOJu0YyeJuRIsVgIDfWsNR+qBucj1Sl4S1OnNS05J7/N7b/RR8+sH0ff
	DxfWtD8MNEZ0+yDVnJq2gn0kzDJw9dOGakH0j3uV2hrorUvhW1cq6yCynwJgkmGjDA==
X-Gm-Gg: AZuq6aI4TIfUasBcK6lcAAyuJUO/BiW8ZFAqZdfd9ABTeHu7R5M4t2ncGINOIO6Zf+u
	SsSlAu2MH4Y2uPKmPyU33TA3Om7GQH+DLjIVpELnaHR2lLFegpypvc/GzsgOjRmLP+zP9JT8xzC
	efCDWL735+vdDUQG1vVyJ/FR86tedbsPt03CLZCINedrPuly5xBUghLkQZKcqCOJPpU5uOmImr+
	/9BG8uM6tkpWPfpJLP45/xK6cc3ukt1P87jl964SjUJJU+7MIwyU3KEBKzsxp550uiGXwCLQZnB
	T5q8NbQtBTwlF4RPpu+K6c6zNjd9/LPVYO3CQCN4wi3kTvs9JONaVnAqACE6CS+rhPBMnxh3X6I
	G9/uWZVtFdG3HJzWL10nDeZsqKBNLujtyQHwZ7NpZOIZUvToN7V0fC511BobXPRZsVX09mmHFcr
	Vr0HVFIEpfQEPMdk004P1nmqZM
X-Received: by 2002:a05:6808:13d6:b0:450:4628:e3f0 with SMTP id 5614622812f47-464463428a2mr4950723b6e.36.1771858928282;
        Mon, 23 Feb 2026 07:02:08 -0800 (PST)
Received: from rowland.harvard.edu ([2601:19b:d01:d210::687c])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8997c8adf68sm65878116d6.20.2026.02.23.07.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 07:02:06 -0800 (PST)
Date: Mon, 23 Feb 2026 10:02:01 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, Petko Manolov <petkan@nucleusys.com>,
	stable <stable@kernel.org>
Subject: Re: [PATCH net] net: usb: pegasus: validate USB endpoints
Message-ID: <ed6ad3d0-e46e-413e-9db7-1c788c8a2dbe@rowland.harvard.edu>
References: <2026022347-legibly-attest-cc5c@gregkh>
 <acc166b4-9ce7-4e95-8f2f-4300ee6dd27e@rowland.harvard.edu>
 <2026022352-dried-sputter-eba9@gregkh>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026022352-dried-sputter-eba9@gregkh>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[rowland.harvard.edu,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[rowland.harvard.edu:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[rowland.harvard.edu:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-260075-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stern@rowland.harvard.edu,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rowland.harvard.edu:mid,rowland.harvard.edu:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D7CE817877D
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 03:54:30PM +0100, Greg Kroah-Hartman wrote:
> On Mon, Feb 23, 2026 at 09:39:52AM -0500, Alan Stern wrote:
> > BTW, what is gkh_clanker_2000?
> 
> A hacked up system of tools/scripts I'm running here to find stuff like
> "take this previously applied commit that fixed a problem, does the same
> pattern need to be also done anywhere else in the tree"?  It finds a lot
> of stuff and then I sift through it and see if anything is actually real
> or not and if so, make up a patch for it.  It was my "merge window is
> giving me a respite from reviewing patches" hobby project this past
> week.
> 
> Now if I was really good, I could turn the output into a coccinelle
> script, as this is just simple patterns.

It's a little surprising that nobody has asked an AI to do this sort of 
thing yet (as far as I know).  It's hard to say whether the results 
would be better than you get with your hacked-up system of 
tools/scripts, but it might be.

Alan Stern

