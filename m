Return-Path: <netdev+bounces-294927-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FZf4DrafIGqw5wAAu9opvQ
	(envelope-from <netdev+bounces-294927-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 23:42:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9675B63B6DD
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 23:42:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux-foundation.org header.s=google header.b=aNtRKDwf;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294927-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-294927-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7339E306593B
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 21:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05EC34A2E1D;
	Wed,  3 Jun 2026 21:39:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF2E4A2E19
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 21:39:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780522745; cv=none; b=L+BUb7XOdACBkbz2XBXaQZ4L/nO0r/zQkaJeWuXLCzAy3WYz79URBCJTwJ1lHWYZecrTQSys5eFb21QVK9xeZ0Bh/8QjYKFPlrNNvrTi8KNrIhSLcTE2yGA0GICS/ICFNvDXwLbxmZxCbcybEcgnuoOFJF9LHGvEtJ1uRiAhuSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780522745; c=relaxed/simple;
	bh=KZSmPn6xQM1bVRhAbp7rTJ/2+QAJ2min3ynRo3L1ax4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T8XufEs+AVR/wyCSZUlEgTLok1sc/QHwSmXWfPOsFfx0R0kYCz7XaoIuxswXSNdFnO2jHn2Jt6W8kUGYmgVHzyaaOO52TUyHBeWKIJvJ/CaleNvPlSnwaM03oNxsXOblylybC34xPck4H987gPmuGwh9vB/L9ka5Z9ksQ+g9Wdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=aNtRKDwf; arc=none smtp.client-ip=209.85.214.179
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2bf1f074a12so410745ad.0
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 14:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1780522741; x=1781127541; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=O8X5hcAFVZJZKmCogabE4dJnuZ1g/E7cQIrqG9l17rg=;
        b=aNtRKDwfadMCvp8fJF7OgqI5pxo+lm4T39QX+CCErOJLQsOb16pxpA15WdzYq6VSS4
         FygZArf83tiWKj+pRJdEZdYjjymLtZNlxB88HY81elQk/RZO4S/jBXSdo8O7Iw+4mPhh
         yi8QJTGkW1b4oqU49z8RkNBwVfFBUBD98IFOo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780522741; x=1781127541;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O8X5hcAFVZJZKmCogabE4dJnuZ1g/E7cQIrqG9l17rg=;
        b=HuUAJhglIJDgQxSmkgpbZfosXeM/0kQF/ce4j3d3mnL4nGw+kQw/wIzV8dse4sJ9J6
         aim/Ia/63Fq5td+XG8N7dd1MV/DGC7D8AmwcLL0rzF3z2wGbZ9eb+yJrXqP9qpvVSM9c
         SsvZO51sFA0HN65waOZzqBsLzisvB0C3XYbJGrXn8inuOxzA2tjiBbYz54GkS8LQlk9R
         aQVyVsfCyXCYukgswQxpSjcj1l4hFhiQIzhvdQ3NV5dkkwMbYoKmNhC1+uwhJyFlHlv5
         izkpq9uy45eZtx7SNzk0Xrunjde6+ZqlfD5/FCrE+UTdZJh+JELYLeF786FPxVzIP6VK
         EROw==
X-Forwarded-Encrypted: i=1; AFNElJ9v2xd0tJ8cit9Q/2krvlwfRlUvRuYrvPAy4f7nGMEeoRmv6BylAbWHIWz8BU2sGH/d6/7pReI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHKZlldYC//uDPppu52jmCzC0QXRtPCoxG/k82XiXTspiK8c0V
	0ojG8sREPi3tmw0llUPQwPMjiokiDiMmPo9+gtaziiM3omcjCLzPaGtPAhuzIubjQg+5PdWZfU8
	YcBPIGyKAoQ==
X-Gm-Gg: Acq92OF+qO/81CjQlq7lidHWox/7cFxjmxLKOsS3JMUAeXSn8YTZhJWN81r7RCDXnU6
	L/lZP6P3KUOu7BgTFUIueHyGhCnNoAn2QLKZppzSxfLraLm8zLBndXiW22/sGTcodpZTWsRQGDv
	r2p+YJqMWUI9aGWI615zgUSMNLXQ0wEJpVJ5qiRBm2L672+r4X8K69HdmZ78RwsOv3ey2vhtEQe
	OV78Scx6mlPAhl521/oTWR3fRI63kRWDc4CTKnEXeH5fiZ3rL2mbZftq68q7T7C6BndWLWDWjbW
	7KgR82Bz/gfnyE7PKkb2KgOZ6Gfgawi9/pxSBC4gklGG0w5OcyNBJMSgEFzzoSv723oZ7SQxgvb
	m1oZA5e0UWrrX4z9/LNK32koELzPuckB1p/F/DP5lbkYaV5VBInYpyDniTWfjrit8LFvEsNx+h6
	V1IdOj7ZNF4e5sQWM/RpZ6rxfdiR7N/vWoSQRlQwcaiB2EQdqOXQ+1IZ/44DyUxtKMt/kkWkLda
	t71qOwUHA8=
X-Received: by 2002:a17:902:e851:b0:2bf:82c:6322 with SMTP id d9443c01a7336-2c1639eded3mr54599375ad.3.1780522741575;
        Wed, 03 Jun 2026 14:39:01 -0700 (PDT)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com. [209.85.216.50])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f6d1e5sm31197505ad.12.2026.06.03.14.38.58
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 14:38:58 -0700 (PDT)
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-36d8b644473so4344362a91.3
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 14:38:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8AJPh+zSHDi5Cc7OWILDM24xthAggHN1caQWyioNOyTUFlm9iwbEKCjLZizKjgNOcOvn7gwbc=@vger.kernel.org
X-Received: by 2002:a17:90a:d647:b0:368:af5c:5925 with SMTP id
 98e67ed59e1d1-36e31102a48mr5572800a91.23.1780522737998; Wed, 03 Jun 2026
 14:38:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wiAqf0PdZ4AKj_4riUnnEb=g_ZNPkLnXrByA9BBHYiFRg@mail.gmail.com>
 <20260602225426.122258-1-safinaskar@gmail.com> <CAHk-=wgKy4dP0oQCNKyMQQf3-uVpaigmDyH6_T0Via76gWST9g@mail.gmail.com>
 <CALCETrWx8-Q5-rK1KnAPCxCbXaWCd=Yfs_Pr8qVMa8k8L6of1w@mail.gmail.com>
 <CAHk-=wizkDXRut5xLXRF-CVUVYMaZ5AOexxeghOAoXPb4yAvQg@mail.gmail.com>
 <CALCETrXzxubt4eWue3+wv7Fq9C2m7uu6bWPstqFh6Mo57bPwQQ@mail.gmail.com>
 <CAHk-=wiEwSjfbjfO74xu=UmkkdHXkJg5QNQ8pP-3iYmunmeV9g@mail.gmail.com>
 <CALCETrW3XcNLuB1Y6PSkxQDSK2o+=EB2AAd25SjWQqcJemwnbw@mail.gmail.com> <CAHk-=wgn3QTLj+F+XccE10dXY-UGWN8+fNLEvhsLw+tik9rOmg@mail.gmail.com>
In-Reply-To: <CAHk-=wgn3QTLj+F+XccE10dXY-UGWN8+fNLEvhsLw+tik9rOmg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 3 Jun 2026 14:38:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wha=LtAq8y-B4j9ps1g_qv3CK0LrHdHEVxP_52p-m=NZA@mail.gmail.com>
X-Gm-Features: AVHnY4IpVbwzilxzEo0kIzmtKsGcV63XCgmSpKmBQvjcdm3Lbflf84U-wY6VXLY
Message-ID: <CAHk-=wha=LtAq8y-B4j9ps1g_qv3CK0LrHdHEVxP_52p-m=NZA@mail.gmail.com>
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
To: Andy Lutomirski <luto@amacapital.net>
Cc: Askar Safin <safinaskar@gmail.com>, akpm@linux-foundation.org, axboe@kernel.dk, 
	brauner@kernel.org, david@kernel.org, dhowells@redhat.com, hch@infradead.org, 
	jack@suse.cz, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, miklos@szeredi.hu, 
	netdev@vger.kernel.org, patches@lists.linux.dev, pfalcato@suse.de, 
	viro@zeniv.linux.org.uk, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294927-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:luto@amacapital.net,m:safinaskar@gmail.com,m:akpm@linux-foundation.org,m:axboe@kernel.dk,m:brauner@kernel.org,m:david@kernel.org,m:dhowells@redhat.com,m:hch@infradead.org,m:jack@suse.cz,m:linux-api@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:miklos@szeredi.hu,m:netdev@vger.kernel.org,m:patches@lists.linux.dev,m:pfalcato@suse.de,m:viro@zeniv.linux.org.uk,m:willy@infradead.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[torvalds@linux-foundation.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[gmail.com,linux-foundation.org,kernel.dk,kernel.org,redhat.com,infradead.org,suse.cz,vger.kernel.org,kvack.org,szeredi.hu,lists.linux.dev,suse.de,zeniv.linux.org.uk];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[torvalds@linux-foundation.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:dkim,linux-foundation.org:from_mime,linux-foundation.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9675B63B6DD

On Wed, 3 Jun 2026 at 14:36, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> It was just the filesystem side that basically now instead of exposing
> the page cache directly (with filemap_splice_read) now only exposed a
> *copy* of the page cache (with copy_splice_read).

... and let me note that UNTESTED part again.

The patch looked "ObviouslyCorrect(tm)" to me, and I did actually
compile-test it too.

So it probably wasn't _complete_ crap.

But I never even booted it, and if I had, I wouldn't have had any
loads that uses splice (or sendfile) anyway.

So caveat emptor.

              Linus

