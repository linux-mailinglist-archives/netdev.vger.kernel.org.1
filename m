Return-Path: <netdev+bounces-290565-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDaAFUNND2rgIwYAu9opvQ
	(envelope-from <netdev+bounces-290565-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 20:21:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C0A5AAF9E
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 20:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 933F53157C36
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 16:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0016539C00F;
	Thu, 21 May 2026 16:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dgx3a7mS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C9C39A4B3
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 16:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779382553; cv=none; b=jESB1wQM5pCOsG2At6y0Hnlw63CMrpnyzVdPHdd0VnSIGMlakvcGe1tE7mfkiIvYwOm28WS6unWQgwbQ+e6Mu33L0H+RNbQBvMm6f5I1gkXZiktJeKPVQnWTU1eGmfUb/WNjjdvtZF6e7vOY9ZErbaSZ6uTzbdG/Mp3lbW7SB6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779382553; c=relaxed/simple;
	bh=KldFHpf/7ny0qHbOcWSEpAE4BwUxQP29kdNTvWDuo+A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qK8TNN/1fKN/Zo7oU7viyKY3U4diXILYgZnVE0UcCLmWPNz7HMmrej7ioeXa5XVns3px0Y2RLeykSG6VguZEPYr2oniW3yqM+DIsT+RFxKQ8aQbWSaS4VjYNkEXdwC+fFKcYqmKOhDF72ff+ewYxcTffl0mnxRbcXvd6ZHmXPVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dgx3a7mS; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4903974854dso8860485e9.3
        for <netdev@vger.kernel.org>; Thu, 21 May 2026 09:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779382551; x=1779987351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k7qjfCSIVLPl5u1gIaO5P/Vio0n5VJVARL9FB7rXD2k=;
        b=dgx3a7mSidVDSbJa8ee7BNlwTVOJ8RrsOOuvRaXBnQRPQWYe1htq97CZDotoRpFEGS
         vZLQ5AL++03UT3CbfcatpCN6Xma3oj8NtPj3sE0kdw1cY+bsBAs5v56awiY9DNcWkmbn
         PEwxGRO74AK823L1lNklsdky20elw7jU/vnHzS7jFzVWCfSz3osqSq5uyoBT0EYyaHM/
         QZZMiQmFSg2OSyLZldqqtTmqVAx0z3Cstf6XLILhcljjenFBDRznPKze08by5txg66Ip
         hM7ycyxZFaJ9nTvdwSl+JWLdHekyOw68zWwKywW342rFJ1Z5zfmdTpF7aGF/pocLkvRF
         atMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779382551; x=1779987351;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k7qjfCSIVLPl5u1gIaO5P/Vio0n5VJVARL9FB7rXD2k=;
        b=B0rNnn8I79rLNSI51akcUAlckLCu2NxAF5hvQ/YL9Fzr7r5QvFmmom3IoSSuZLWYpk
         eDuyRBGnYtf/wwhcZLjPjLlH75eS3boXIC6Mg/dFTgmcImmS7Q9LzCL46+KGiH67nQbc
         e9JQUMWayHuF7uJzoaAGZoYq0eEx2dGIRP6mWg5JgVWCSRpXzCiOo+SmWhfm7ebT7Iog
         DTwbEKSUNE3XWX8JiFp+G18TBuKJXM8d4uUgZ0KGWL6xh1IabMVMqT28K+1BSCEOujor
         EovLfUVOaJ7jlfQFkMrvZt11o2uUUx0B+xLkC5EVqdlfYAVSqddp4yV7Tc8vVbGfuQh4
         ubFg==
X-Forwarded-Encrypted: i=1; AFNElJ+FWynHwSj6ZzzqbFO37lWJtd+SHmj3FqsfH7/iq+29VoK3jUQY1Wfm7qjXOZTvOPRXhronOE4=@vger.kernel.org
X-Gm-Message-State: AOJu0YykXmKG6IJPRmT69dzPs2Gq+zOE55NYpnFGQfitRMhuz7NmodRv
	iApFp6g/SGzLvaY8PzzGuXVl6DPe6vyajy+NQGj8PLbR3SzTclf3U7ie
X-Gm-Gg: Acq92OH4Ax28WslDXjqOX7nhF93s1yRFUMChSNcZaxbvrrPi2B8JqOcFvz+C9PJC+T/
	M/m+AKf4SvvZkyd3d0NopvulCMNAGB24ApX0eHnOAOyn37O+ISSfgZ6+myFMJpmJncP8XeIIa3L
	JEl9/WkaiJ4HJ9hm/iT+w/NsHqdTfoI2m+psSgvUlKNqKUCzAlA1Ud2wu0FEaJatGf0MsjVzliq
	NM1Bn0heA0LW2Oi3dzugdoymfy3VSTkk8JEYuXNFgfL8MnaA6FQ9rmQBtXaoi5/rHHHt+DR4TvX
	xg2t29t9qaEkde7fbbEjUB82iOFMhftg7/eLIy6uJGo9GyfYiADKfwvU2yw7frTnc+tHVTGyoRl
	G4tYAO6y4of5nOemVoA0bQWJNeX+fTa8F0+U5IrhG74r+kMvGpEXyoas35NA2/1HB79l9fN4qX3
	23ThyFdAsL2MH4Zuzym11SpR62B+bWMPVpTMJIl6vO+ETTaLoXmayMA4HiYiiDD0V9
X-Received: by 2002:a05:600c:4513:b0:490:3cd6:db37 with SMTP id 5b1f17b1804b1-4903cd6de06mr36938395e9.12.1779382550722;
        Thu, 21 May 2026 09:55:50 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49033d3515asm86408645e9.1.2026.05.21.09.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 09:55:50 -0700 (PDT)
Date: Thu, 21 May 2026 17:55:49 +0100
From: David Laight <david.laight.linux@gmail.com>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 0/5] ethernet: 3c509: Bring driver back and make
 some fixes
Message-ID: <20260521175549.70c27369@pumpkin>
In-Reply-To: <alpine.DEB.2.21.2605211329000.1450@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2605201115010.1450@angie.orcam.me.uk>
	<e1c7eab4-b330-49ad-bd39-df7dbc0a9511@lunn.ch>
	<alpine.DEB.2.21.2605211329000.1450@angie.orcam.me.uk>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290565-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 92C0A5AAF9E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 21 May 2026 13:45:26 +0100 (BST)
"Maciej W. Rozycki" <macro@orcam.me.uk> wrote:

> On Thu, 21 May 2026, Andrew Lunn wrote:
...
>  NB as I point out in the cover letter I made sure there's been no change 
> to binary code produced, so I expect no fallout, and as we discussed with 
> Jakub the removal of the driver broke `git blame' anyway, so there should 
> be no cost associated with the cleanup.

Can 'we' make sure that the commit that re-instates it has the git tag of the
old version in the commit message.
That lets people go back across the remove-add.

-- David

> 
>  So as I say, may you both please weigh in pros and cons and let me know 
> of the outcome?  I'll then proceed accordingly.
> 
>   Maciej
> 


