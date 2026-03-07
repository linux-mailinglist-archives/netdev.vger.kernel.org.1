Return-Path: <netdev+bounces-265214-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uGJNEIm6rGmDtgEAu9opvQ
	(envelope-from <netdev+bounces-265214-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 08 Mar 2026 00:53:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C4A22E072
	for <lists+netdev@lfdr.de>; Sun, 08 Mar 2026 00:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 08277301AF7B
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 23:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7DCC2DB7AE;
	Sat,  7 Mar 2026 23:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g228k7k9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0452F99BD
	for <netdev@vger.kernel.org>; Sat,  7 Mar 2026 23:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772927615; cv=none; b=oGqGPiqyJKvOn7EGk2qDKBPzxXBwkhXF1TvmgtnaEuE/eCL/dPypOB2wflh2FeqblZMQ+96poYiNMd0Z0bBPju6O1BFR9VeTKfz+4N17y5LbthW67WZK1M97K+VTvVcTTBIeHTdOzVGrL7WECwPCeIPvAsKrxy8V8VLctCuHE/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772927615; c=relaxed/simple;
	bh=Rp5I6tnZ9KHNuigV2xCxO3JX6po9/jbB8s8mZoIUD0E=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=WUpUSdta5uLoZOhKh9vccKkC/4PETKh+yDu8AquMhflYQFssV4ZrCaaxh+pv8xnc/qxnMkBGOvvIsCnWWP4RM5m9JHz5GcqsvN7HF43TKml6asT2F9Sh9GTqBq1RJZ/0AhHw6XoooI86WrnUx7fD4XqFXF4cwBYvsCfFoAinUYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g228k7k9; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7982c3b7dfcso105723907b3.0
        for <netdev@vger.kernel.org>; Sat, 07 Mar 2026 15:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772927613; x=1773532413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KrVted/9LPdxywvkSCrfMXaTaDdzZiGs4BC17n8m8NE=;
        b=g228k7k9cb6ud/HEy/I0GNYuuDXax+psv6A4xQoUsT9j3NRBaM2/KOKYa1NEQ1M0QL
         nl7AGjZ/zO+x62jg958PN5DieYD4LyyuKpgaMWTtDTnkPA1Cv7/wQK7vEKu321t0UewE
         elMekat21dk7Lh2OsnT/0080WTDdvTc7jmC7PRhkyysO373aSJPeUmaPRziQClKMoWEC
         07dRpnPLbTeTt/yWI7d7/SQ/k3eS9qqpdk3Llm/OkkJfB1InibcjAwPubdcH1pyoPUQh
         xmcbo92iyt3pcajqjrE/NrBZOoYIi2V7C/VfYsxeMOsIDIIp1cUSlSz9fRYejOAxhjZD
         gYLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772927613; x=1773532413;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KrVted/9LPdxywvkSCrfMXaTaDdzZiGs4BC17n8m8NE=;
        b=jnHEPb6cb6h1IgfGLLJWqRQ+cixiiRgBfeDg9YMOtJYl6MUQ2ZksOk7qusVmsL37gV
         9jpkxvZTPJTTIVygyL5z8PafNZz6QH9yK/aYAO5IC2i9OBEEWk9B6y60RufzfGnUxSGT
         cJrDB7yWn2evoYuTMud+uORQjipHj5y/DTdA67DKhHpBDqASZcf5Kxbdrx/8XX7mtGaP
         6F4RRyFUVISL4LVGf9/XhS7EqJtUIptGtU0drTJCrC9XARQf/JFYoVSjPJgpLMda0Khq
         FFaickmLCfVOkuTESa+iUJw28gxOcLZQBAI8VesbQeD844aSmDMSbXxdvETXreL29aj3
         QBSw==
X-Forwarded-Encrypted: i=1; AJvYcCVBRUbvMIi7vFBJUFZ3PyRm+4hWcCqhxVMQsuRTUrJiqXcUw1f0UsTlH+85VubfzGomu5lZyjA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu7J4pBtmPc2b5SrYGJB3CxYYBMOloA6693i1zEedRwcM4o7Vm
	mea0umdN7+rtcWIdWx2CK8uVUqN72qUlalFbLSZLjfJ2S9seTxVDneJk
X-Gm-Gg: ATEYQzyDFi7rFQtDvd1uhKZUXrwYLwox/g9GeR1Vz6BQUW9plIOnzv6elmRuCD/R2Ki
	ybinB10pwsJEve08dJPpaIyBKg5cjOvDERU47C7+Ztxzelsfr7MifMpYyCuNB7b9PYEl7TCxavq
	ved+cu6odewJ/9WOI7nXSpARopapUKayQfcfn7Gh+xBych3IOCSJYXyS3RHw3C41AeqJZZCKARc
	B3dZeFyY8bs8eiZr6Vb1p2kSf+HdqUU2NDig5O+cPVYBquH8M8TxwHUWZ2v3V6CgIiXUoQqq0yT
	LBD4ecEQPg95PKCUELd8/jFMjt+ZkO7zK3IU0NEfH3kiZ5wKTYZ5HTlorpGHawaqF35uL6LqgAx
	7nZR2sieYCAqDdOSTbE7jw5bfrbvhLoQkaSEotC4qLeCSmgRs+DCJOLxUXn6EsiM+NExbMIFzvo
	1+GL+xOz66xdsD9yzGgmIdP7A8oWtRKeMb5Tf9ajlt+CaIRneacW9nK5RvbEr5TGWne06801Tks
	RgR8//cMg==
X-Received: by 2002:a05:690c:1d:b0:798:1636:c330 with SMTP id 00721157ae682-798dd756762mr64965377b3.34.1772927613482;
        Sat, 07 Mar 2026 15:53:33 -0800 (PST)
Received: from gmail.com (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-798dee68c47sm25656727b3.43.2026.03.07.15.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 15:53:32 -0800 (PST)
Date: Sat, 07 Mar 2026 18:53:32 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Alice Mikityanska <alice@isovalent.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Alice Mikityanska <alice.kernel@fastmail.im>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Xin Long <lucien.xin@gmail.com>, 
 David Ahern <dsahern@kernel.org>, 
 Nikolay Aleksandrov <razor@blackwall.org>, 
 Shuah Khan <shuah@kernel.org>, 
 Stanislav Fomichev <stfomichev@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Simon Horman <horms@kernel.org>, 
 Florian Westphal <fw@strlen.de>, 
 netdev@vger.kernel.org, 
 Gal Pressman <gal@nvidia.com>
Message-ID: <willemdebruijn.kernel.14fbe42387c70@gmail.com>
In-Reply-To: <CAD0BsJVuTBdfrLkY+p93LYM8Q1dmVsv_k8_b3=wYe7hwDOF5Jg@mail.gmail.com>
References: <20260226201600.222044-1-alice.kernel@fastmail.im>
 <20260226201600.222044-3-alice.kernel@fastmail.im>
 <willemdebruijn.kernel.346c48b49836b@gmail.com>
 <CAD0BsJVgvbmk5y5TKkeFcdMLj+VuCWisX4VXv9g15uu=5ddLVA@mail.gmail.com>
 <willemdebruijn.kernel.2005cee64b1e1@gmail.com>
 <CAD0BsJVuTBdfrLkY+p93LYM8Q1dmVsv_k8_b3=wYe7hwDOF5Jg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 02/12] udp: gso: Simplify handling length in
 GSO_PARTIAL
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: A1C4A22E072
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265214-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[fastmail.im,iogearbox.net,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,blackwall.org,lunn.ch,strlen.de,vger.kernel.org,nvidia.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[isovalent.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.975];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[isovalent.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Alice Mikityanska wrote:
> On Sun, 8 Mar 2026 at 01:23, Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Alice Mikityanska wrote:
> > > Thanks for reviewing my series!
> > >
> > > On Fri, 6 Mar 2026 at 22:55, Willem de Bruijn
> > > <willemdebruijn.kernel@gmail.com> wrote:
> > > >
> > > > Alice Mikityanska wrote:
> > > > > From: Alice Mikityanska <alice@isovalent.com>
> > > > >
> > > > > Taking further the idea of commit b10b446ce7ad ("udp: gso: Use single
> > > > > MSS length in UDP header for GSO_PARTIAL"), simplify the implementation
> > > > > and fix the checksum (apparently ignored by hardware anyway).
> > > > >
> > > > > The mentioned commit started using msslen for uh->len, but still uses
> > > > > newlen to adjust uh->check. If the formula for check is fixed, newlen is
> > > > > assigned but never used before the loop, and newlen is overwritten after
> > > > > the loop. This makes msslen not really necessary, as we can reuse
> > > > > newlen, if we don't adjust mss before.
> > > >
> > > > That's a big if. Why is the udp length now set to the segment length,
> > > > and not to the GSO packet length, as before?
> > >
> > > Just so that we are on the same page: the behavior of the UDP length
> > > field changed in Gal's commit b10b446ce7ad, not in mine. You reviewed
> > > that commit and approved it:
> > >
> > > https://lore.kernel.org/netdev/willemdebruijn.kernel.218d53621fba7@gmail.com/
> > >
> > > I'm just refactoring to simplify the code a little bit + fixing the
> > > checksum field that went out of sync with length after Gal's change.
> > > Hope that clarifies it.
> >
> > Oh right. When respinning can you add this brief summary?
> 
> It's already in the first sentence of the commit message... I can
> rephrase it to add something about "refactoring without changing
> behavior" if "simplify the implementation" reads ambiguous.

I totally read over that. As is is great. Thanks.

