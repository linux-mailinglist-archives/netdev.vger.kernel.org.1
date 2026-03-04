Return-Path: <netdev+bounces-264092-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJZ8BR3DqGkIxAAAu9opvQ
	(envelope-from <netdev+bounces-264092-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 00:41:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7288520903A
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 00:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7019E3040205
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 23:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5EB37105A;
	Wed,  4 Mar 2026 23:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PCmWcAQ4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC9E241139
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 23:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772667672; cv=none; b=Ys8LnMTf1MgSFPFWT62c5452kH2iKLwxEcgJZZt+N8QMZZ53eiL4PVOAVJlCc3Mf7nuPxLkXTABTITnIlzUI09R/QJoobWjS9sOCvjkiQUvDS4+lLsTiqptUzISiznAaGnEKMb7HDMJit5gRQHLtfQsg6gjPetDrjrCf/ELn7+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772667672; c=relaxed/simple;
	bh=wUHw6axxvUa/lPOiWXGtEJrAfGKiU5nqgN0QgL7xf+A=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=C2Ei2UmIqR89INCd5F5uFMQkkbzYOw6lKZUMhVc77sChPpu0cTO4mB3z5aY2+UDKkN8OWvuWE54GFJdipidCD2KEF5CuGdCIRcpbdkelYvctDudFUG25cHl6LIsTD/0oTFYsMV3qIog4hnfGzvdnpknCNENtprjmTKFawHgMbIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PCmWcAQ4; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-793fdbb8d3aso91544797b3.3
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 15:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772667670; x=1773272470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bKQobn8L5rXyDNe5EjHKK48q6VnYXQPCLISw68IDwgQ=;
        b=PCmWcAQ4UG33gQqpU4egE9OXl3UwooXcLCnBV7QgKmCfXOoKrFZadUMJTIsQBf+KJm
         5Cy5GZUjcQ+Q/ZpEaEzjZougTWI75F9SxLnsF4ZCYaLw1vP7ZpV0Pyu0biRnZ+IuKmcl
         R5Jp3hcD2MxrxOzn/10Fc782a2H4gm28MtbnvncDmOtTuticvOWa2ROAxxZCN8DgHMtz
         ZFYM1uCED91pbhALQE/HvFxmgtx+Y+7rKAziuPZ4ahfIlE+Nbta92aMVveY0DTigeoUE
         cf2bcu+jEHX4RWk1mGTrk6MPr2zSEO79IiQE2QjRUbiRiqgeJXzsYGedaswlBReBI3go
         O6sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772667670; x=1773272470;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bKQobn8L5rXyDNe5EjHKK48q6VnYXQPCLISw68IDwgQ=;
        b=tfj6/7QQmI2xQM0So0bBfGTLPPFHZd7YmjxQsw7w/nDVXu4+RoPIouCjndc1SltKMR
         V/akYJpBqC14er5Gxf7IQYp63WJ4HIlp5gHXNmInLNvArkqpfO8YwKoF3zbMEh4i0GUZ
         +1kcEdMovitE8DSf3vtlzZjmSoYtrK0IyNY7b+bZykZzMXI70xBhtcS4XfvbJl0tCcvS
         FlQ2Z0LZbzcX5ibdytmgEhf4pQ6016hctjr7KZgarqtSnG22UhMXzTwFxLIIFhkq7rA1
         Q32yo/C3h8sqY/sfjj6fIpRM/2cT2CVjbvZtyXrJHm4XMaBl1zHLGS+igDyfRQQgNrp4
         uajg==
X-Forwarded-Encrypted: i=1; AJvYcCWj7YKAxPEtC3v9ETo48AZJzGasTqKteoCvQPw4czQZ3XeWQ3bTrjcsMEOjwkAXMQpNbDbAjfc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf1y3qMixmsu+4hrzWAkabG67vzDZ1h+DVcNFqSOouIBWSyhyi
	JDnhsOYKHL2oS/W/4oXJOEeMno4s6oGZHMbp+xqW9cre1Z13hP1JiB7U
X-Gm-Gg: ATEYQzzO22etvisJd2ixFs7Lf9pIikcjnBkBrvxCm2rf8KbCKaSLSOQCEkaAnaMeSOX
	uOTIh4KdC2L2qaqQXKadGd9PYDcwb2Od53ZVNWmE3FwA9EkZ3G8uvyhB+zF70+mpDRsyPiiZWpn
	iVbzaZI8Bw/vFJ9SQwLcBSQjamM9JSVTTm+46MRBZ9q1BdLs3WuY03PP64AlSo8hPehoXq6AGbG
	Xgwl89usPyWywZQqhpaDFGV7/ZbE6QJSkJCK2FkkjwKU3LvbX5jUglSm56iUJxIRdyqJpmsmjh0
	+RKomyCG7c3C1MoEU/XjJM7c+Np4QDR6bOHLN7dhIAclKMjBChUKC/VAaE9/4ApR5R7PVI3qth7
	/7DHot4wshw8y5m4IYdlzy/ucdBT0s8Ggntk4BQBXx7Oo80qgdBm+IVevjkfm/SA9If+ETuwNjE
	t4KuOH+TWe5N9nZ3vRaZoY8GbQ0fz/AaoMOqeLtNwiLPQ9LHhOGmu3JSWtFYq6uGScRuxM5d8=
X-Received: by 2002:a05:690c:9688:b0:798:1637:fee0 with SMTP id 00721157ae682-798c6cd93damr31830317b3.52.1772667670230;
        Wed, 04 Mar 2026 15:41:10 -0800 (PST)
Received: from gmail.com (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-79876c862e5sm79190257b3.44.2026.03.04.15.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 15:41:09 -0800 (PST)
Date: Wed, 04 Mar 2026 18:41:09 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Wei Wang <weibunny@meta.com>, 
 "daniel.zahka@gmail.com" <daniel.zahka@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
 "kuba@kernel.org" <kuba@kernel.org>, 
 David Wei <dw@davidwei.uk>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>
Message-ID: <willemdebruijn.kernel.101ad57610d58@gmail.com>
In-Reply-To: <SA1PR15MB5817DD5000DA78CC8187C743BD7CA@SA1PR15MB5817.namprd15.prod.outlook.com>
References: <20260304000050.3366381-1-weibunny@fb.com>
 <20260304000050.3366381-6-weibunny@fb.com>
 <willemdebruijn.kernel.2c99d96277de8@gmail.com>
 <SA1PR15MB5817C41068E5167A39F4CBD1BD7CA@SA1PR15MB5817.namprd15.prod.outlook.com>
 <94f9ac32-b476-40e5-bebc-37a954884396@gmail.com>
 <1d2b02b2-0541-4a17-af2a-95345395d2b6@gmail.com>
 <SA1PR15MB5817DD5000DA78CC8187C743BD7CA@SA1PR15MB5817.namprd15.prod.outlook.com>
Subject: Re: [PATCH v2 net-next 5/9] psp: add unprivileged version of
 psp_device_get_locked
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 7288520903A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264092-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[meta.com,gmail.com,vger.kernel.org,kernel.org,davidwei.uk,lunn.ch,davemloft.net,google.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

> > >> From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> > >> Sent: Wednesday, March 4, 2026 8:25 AM
> > >> To: Wei Wang; netdev@vger.kernel.org; kuba@kernel.org;
> > >> daniel.zahka@gmail.com; Willem de Bruijn; David Wei; Andrew Lunn;
> > >> David S. Miller; Eric Dumazet
> > >> Cc: Wei Wang
> > >> Subject: Re: [PATCH v2 net-next 5/9] psp: add unprivileged version of
> > >> psp_device_get_locked
> > >>
> > >>> Can you give a concise reason for which operations to allow from
> > >>> another netns and which to deny. Also as forward looking heuristic for
> > >>> when new operations may be added.
> > >>>
> > >>> Btw minor typo in first sentence of next commit: associcate.
> > >> Thanks for the comment!
> > >> Yes. "unprivileged" means access from the main netns as well as any
> > >> netns with an associated device and is used for commands like
> > >> dev-dump, dev-get, rx-assoc, tx-assoc, which are user-controlled
> > >> functionalities of the psd.
> > >> While "privileged" means access only from the main netns and is used
> > >> for dev-add/delete/change-ntf, key-rotate. This is more like the
> > >> admin-types of operations of the psd.
> > >> I will update the commit msg in the next version to make it more clear.
> > >
> > > I think Willem's question is more: what criteria did you use to decide
> > > if each operation is privileged or not? I think one reasonable answer
> > > would be: operations that have side effects on the psp dev's state,
> > > e.g. key rotations or changing the enabled psp versions.
> 
> Agree. And the current set of privileged operations should only include: dev-set, key-rotation.
> All others should be unprivileged I think...
> (The get-stats command which I should make sure they are called with unpriv = true. I will change that in the next version.)
> 
> >
> > well, now that I sent that I realize that criteria is so broad to
> > include things like rx-assoc and tx-assoc, which obviously need to be
> > unprivileged :(
> 
> Yes. tx-assoc and rx-assoc are currently implemented as unprivileged. They call psp_assoc_device_get_locked() which currently calls psp_dev_check_access() with unpriv = true.

Consider a more descriptive monitor than unprivileged too. As is, it's
not clear what privilege or capability is implied.

Perhaps just assoc_allowed?

(also please check your email: plain-text only)

