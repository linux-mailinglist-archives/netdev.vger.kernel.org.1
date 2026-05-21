Return-Path: <netdev+bounces-290623-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 9SGSEGp/D2pdMwYAu9opvQ
	(envelope-from <netdev+bounces-290623-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 23:55:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D14D5AC37E
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 23:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AC90E3018A3D
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 21:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B092E3403E6;
	Thu, 21 May 2026 21:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nrrcCKHs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3223134E744
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 21:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779400541; cv=none; b=inlRSoOladIYQFLOsiGt1hhddPgB0bge26xNUhqpowXTqmf5uVjOzK8eBdPq+l0DDJpr+NltbhN4BrS7/bYwv+Wxrie0bT5ddyK1VtqGn1oT7HrwqJeCSEHv1nls1pKTqbaAmezmVp38xFMD5TdzsihQ40QAPjEgSkuPsJYHUpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779400541; c=relaxed/simple;
	bh=5cqPB3+SwRfBO8Ct4IGJehGsBMhMU2/xMj6otSkR2VA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=txzVG6eGKi3ssf+cxtxqhiv61A0Dv6hYsamSiURJ2L6E2FAoHw0QUEKWVBFi+JjsLzWs/HiHlYCoFwrgvp0FvkOQN4ljXBOGa4XZHCcX0nMyhmi9Y0t2EGQx8O11IrkPu7/IoSohQomVqzqnTtnFAeR5WY9eCHr41HNUHLiNkWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nrrcCKHs; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4903cbfad68so7217365e9.0
        for <netdev@vger.kernel.org>; Thu, 21 May 2026 14:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779400538; x=1780005338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fjS78Z3Qswu8i7cXKtkfbhBl7RI0zMzp/ofF9gwFPs4=;
        b=nrrcCKHsM4KoZUGqct6ghA9IxBmcauY4sxujCG4si5K9kQfRAVo09vRVTze+SkDHK2
         E6VxSc8HZINHY3REZ1Q/IDtuK0INo8Ib//MTXSxrnq8VlFcBJdbF+dVyUds5e0v8GMki
         GVaH0Wn1PQ5cFiz7pWMYqmRkgNInzVXsFvxeZsf1MvSKIu1qDfpRkr872AFtuJ/gF7Jd
         vUv4xUorPLPbaVPK41ZhyJaiLUQeIFOywJDZCpa1+NC91wijmSKMlFFJVIncuPHXeuAm
         Vjfh7XyVKoE9K9oDZ6xvjiOQ7lRTHFUjFQmSg/kSt2dr1pKjbkEYEB0+ntLIFjKOG/Um
         Levg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779400538; x=1780005338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fjS78Z3Qswu8i7cXKtkfbhBl7RI0zMzp/ofF9gwFPs4=;
        b=WfaJkJlXNZMBNY9g9Zl1kq54AaL+VbRyrU+wB8r3q/MFUIruu3iewILM0UGTh0ohyX
         BpzMBtUWnQggAxtgfYAFLuF/nSpN6H7b8Ft9k/ox2j86DQPyxS8APYGw+p0Iy8sncoj+
         MrCcYzpSUapUZluXQujDvDSqGh+sn3+Nl5ltXaEB94rGwH8ttZXtzVsPx49E7559vFFg
         iiUCL+XWc0mKA36T/f7evxhgfgKjnx92NIasINhPcXEYa61h91QSnyDpU4le/3PJ7rS5
         gPodq4QtyRwmMKzn+ZJYFdvPIqzPDdgkWOynQdgDmNY0jv4U7TkDUi8uxqhxf635+Moi
         X3Yg==
X-Forwarded-Encrypted: i=1; AFNElJ8/HeYYG8zYSN63auqgV4rMVKWDzsPxS2BlH925Ho2c6awOXIr5dcaqqNt1nSzU/s3QxUYEffQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuiAEvDSeF7B0xsTp3SW3KkpAyQi6ZbvMZLRWX4eVDRkLwqv8+
	/4kbowMxM6XYfj2SdlwtffoNbqnb+UIgK43Y0sktZUw0iQLzH3YiWGka
X-Gm-Gg: Acq92OGkhdNehivoQfLQQc+Ad5ZiNVTb80Ugi28zQyaUI1ND4OdKzGFbEu8B9tRK9/O
	vqskDt2osOJDQ+9Q9HBvlPgtZs/R97XuvhA55gz6lXAnAQLftsF/pQpeZhfjcgNQuXsO0/KazYI
	NxnWHkE55+aJbrdJLFTGLV73iIJvBbQNg9717dcOvzYwZ7/RlqEg63ufqZyRLSAibce7z4D05Ce
	fKqenjKWjhG0uo/hu96P1VY7brPAdbBckWBBcDJYqqlh8NwOL1+yRdn2wVmkcnETgJB54S2SDLE
	9KEeAaaHn5/RruXnj/2cAcrBWuzKhyNU+38mD5jdYrhwUErA99+5XMdha9tv1Bnc1JUe3w8OWvt
	TPRt8Clu8ZFfI1z3vtU4vpERHzZ/6akROvuDLRJAWkykkn6mS+fMzEyy2t261FM64/BdEFoNccB
	v9k2Vn9pu3LmaE1Dmw9AM/skMsBPiecbDQRrzTvZMTxAdAGa9P5nznp5mTe3gZMMsHhdII396OI
	Xg=
X-Received: by 2002:a05:600c:1c0b:b0:48a:53cb:8604 with SMTP id 5b1f17b1804b1-490426a495amr6525425e9.14.1779400538508;
        Thu, 21 May 2026 14:55:38 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4903c9abbadsm52437075e9.8.2026.05.21.14.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 14:55:38 -0700 (PDT)
Date: Thu, 21 May 2026 22:55:35 +0100
From: David Laight <david.laight.linux@gmail.com>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 0/5] ethernet: 3c509: Bring driver back and make
 some fixes
Message-ID: <20260521225535.3f60f0f9@pumpkin>
In-Reply-To: <alpine.DEB.2.21.2605211848420.1450@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2605201115010.1450@angie.orcam.me.uk>
	<e1c7eab4-b330-49ad-bd39-df7dbc0a9511@lunn.ch>
	<alpine.DEB.2.21.2605211329000.1450@angie.orcam.me.uk>
	<20260521175549.70c27369@pumpkin>
	<alpine.DEB.2.21.2605211848420.1450@angie.orcam.me.uk>
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
	TAGGED_FROM(0.00)[bounces-290623-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 3D14D5AC37E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 21 May 2026 18:49:52 +0100 (BST)
"Maciej W. Rozycki" <macro@orcam.me.uk> wrote:

> On Thu, 21 May 2026, David Laight wrote:
> 
> > >  NB as I point out in the cover letter I made sure there's been no change 
> > > to binary code produced, so I expect no fallout, and as we discussed with 
> > > Jakub the removal of the driver broke `git blame' anyway, so there should 
> > > be no cost associated with the cleanup.  
> > 
> > Can 'we' make sure that the commit that re-instates it has the git tag of the
> > old version in the commit message.
> > That lets people go back across the remove-add.  
> 
>  It has all the usual `git revert' stuff.  Have you anything else in mind?

Not sure :-)
But you were suggesting it would break 'blame'.
I know a 'delete' then 'add' gives serious grief.

-- David

> 
>   Maciej
> 


