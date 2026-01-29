Return-Path: <netdev+bounces-254560-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AK+RHvnqemk0/wEAu9opvQ
	(envelope-from <netdev+bounces-254560-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 06:07:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A87FBABCE1
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 06:07:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 526593018BD1
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 05:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086902D838B;
	Thu, 29 Jan 2026 05:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hlr88dwB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D39E273D8D
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 05:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769663221; cv=pass; b=SnSdXXTVE0IeoKj4CfYFrnj6W3etOsjprR9xFmj2Q/318UnBLm9n+285ZmxPKXoM+a8cjxHiTkG07pcg2pVR81ctwe7demSwkUyAAMCgDXfXl++a9BMi2Zfg3NMKka1aBqzGjVC5xJsPbXjc23cyyUbNaD5FIMou4xzHQGcTAO4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769663221; c=relaxed/simple;
	bh=V7d4MzZRplCljG6BRDQE8wlf7tDBcNWfuYj1stm4g4o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cmA20xqP1PMX5DsT3cztpmo/pnkpK33rW+ADWGHh+mOc7428+YSVqNv2Ge2lnanVcsovSKRfp+mMeQzBBb86db71UJhbZA+XsMO7rPDC1tF3aTGyNBpBewXRT70cd1jnlXaeCa7BRZZUPM32ftVjzRBT2TA0gbYWmZhg15CfhtY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hlr88dwB; arc=pass smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-78f89501423so17388167b3.1
        for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 21:07:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769663219; cv=none;
        d=google.com; s=arc-20240605;
        b=Vbcq9/pfykL35SzIDWXMUBOiKlj9rMWyRXtzzgPU541ScrlHeCPfw4jp9HnzYJOOs6
         KRpyVZb8ZNOMeDIB2HNKQOrForxCnNl8hubF9bUzmeKsf4LJopvd1SzJbRINJTqhasVj
         rj4kgtUTqCB90q02JZojGa8FHzRIr0jx285Pdt3fzmsWuIeBL9WCA1dmmyhipcJBIDjU
         wMLK4eFGilcMETpX1j8uqqnLt90U7czR8LY7vIhb6viIklf2IqscUcCSTq9pLPI8j5KN
         sHQ+wY28DxLa5Dlf5PscLx3dsCqYUFpczmqR1Q4Xsk7Oihd1gjAuBLyU7cN/+W95+4ij
         X5Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=V7d4MzZRplCljG6BRDQE8wlf7tDBcNWfuYj1stm4g4o=;
        fh=gvHGTzCEiIRKQJdm+eYMRffOD0KebICy9jdhq9+wG3w=;
        b=baK47uIKjDtE66OQtZcXTXGt2Ch57LY6yPHJwWezShEvh+FR71migDj/HfEE1pIQLb
         Du1BMBsOZc9r2cH7IuC3s9hrSgQnTfh5g2huMTQ+ay+I4rfpEi5RD9mYDbJrK7jLIr7B
         L1lQLaVOAU+tmQnT+PMKrPV85TNpmBMd7ATvWHB3C64avvh56sLxd8xDKXT15P2RsqD5
         QNqn8Dn9eWwEkoirL8Vw7nphxhxliTxDUGR7XjtO4eU7i742lY7l9xoMWdgIxBeoCplz
         sQJ4OQDs52b+cZMSQfREixvOaV64RUy/s3aBKQAkWbBbcMlKAn1rKdwDhRpFZdUeogBj
         yINQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769663219; x=1770268019; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V7d4MzZRplCljG6BRDQE8wlf7tDBcNWfuYj1stm4g4o=;
        b=Hlr88dwBOwdBhmFA7396wNOJRlleQj+Hcb6HICOBx1MkWSTwe3LrMbRpoxA+i5oRji
         HxugdSc5Kd/9Vv4AjU640sJBzDBKanIj/r/8D7et4q0UcZjGgb5U00tDdXA4Ld87bOwY
         FZihNZW+9ADyv3y+uHSTNqMMAOXRUzx4XMRdGT2nP2M/a0MpB3qjTrZxIACYT9F5es5M
         IpF1E9i6Y07RUBVwrb3vnfu+Ne8Oq8x5EjeiGO1WQ3c3XCMSqBjnfzpysMyJQNnbI2pQ
         hNyV2oEBstV6j6o2f3TfbGSWlpCXbszdhml/dOJ9B2C+iezEWD79uOVKvajmOnvyaSMm
         mu2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769663219; x=1770268019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V7d4MzZRplCljG6BRDQE8wlf7tDBcNWfuYj1stm4g4o=;
        b=gmhFkHHsjGxaEH27Bla2k6nb/tuv0xFv2jfqQp3KJBA+9zeLPNDkQvZSMMS1nDsb2f
         9Cse18M+FMqHpRpH1WbIvtQoZln5YQkxlibjC5kG8GfG1JoQfTg5If5uOgaLAYgb7ecr
         8wN15larUK9qGPF/ubJUcge7OTEezdjvp2ZcoqpFjfAsGhXqd3Dto6XTc2c1m8lrcoBR
         ThkcHwhDKewysgjbhVeR+8xR1wiNQVHL5MjwGOdi7PpjbVscBmnRINQWOPjg0+R8FGNc
         QqCTfEeCbTMrdD46IAeElksEhSpLvFofLKSgteEIa35JEzCwZUiVXUWUTbzZO8uKRFDB
         xfWg==
X-Forwarded-Encrypted: i=1; AJvYcCW/e2Yw6hrtlE5lrwOZixyzKcTYkAWDTFenrGkgGiPr59k8+83dXj1bL5i30FnqLXZT9CzJwzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGv31q2ePXabq/66sM7+eBcVn7ZKInS9Ybeu2HgGSLu/7sjn2k
	xYEUiQkYwdubvpO93SJndnDH9BCU/2s1Fr8DicMnHk9TQFuUaLz0oQN+PJQo58BZ96Q37U3sbTX
	bC1P4xZLiG3IB0uk1zL6R1ko1m5DxQkw=
X-Gm-Gg: AZuq6aL3YPrJXyHsFdsGTPeoaoV4fpekuO3cIhqKZmRk5TzVBtHrlQK3lEPWjzYMl2z
	M0WZpmtNYm27+fx+iVOSEuOH97qkVl6FL+6AcrQUp53N0SO/Y6RXkTGa7R47L4Fc2QEuPL38gnH
	GsKY7oYujZ+8LL6vGdZsA4UQQnDpqPXrJv8c7Kd//1AawG4oxjSF5b6Da+3Bx3XLu0s74uYDLwP
	xEzADGjfqhJta/+pYjeHz2wmCOo+q/pkyMrmqo67adqZjKk5BxfM6QgXp0ZIWxFa5z4
X-Received: by 2002:a05:690e:1208:b0:649:6053:15de with SMTP id
 956f58d0204a3-6499f0b7832mr1437952d50.27.1769663219410; Wed, 28 Jan 2026
 21:06:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260111163947.811248-1-jhs@mojatatu.com> <d42f0c80-e289-4e0f-8608-10580d315fd9@redhat.com>
 <CAM0EoMkFMURPj3+gNOaqO60D4deeht2F3EZWZbmShjO+B4wJBA@mail.gmail.com>
In-Reply-To: <CAM0EoMkFMURPj3+gNOaqO60D4deeht2F3EZWZbmShjO+B4wJBA@mail.gmail.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Wed, 28 Jan 2026 21:06:22 -0800
X-Gm-Features: AZwV_QiigrahvFpgRQhL2mt086FVJtoIxfuIYhj5RwxgHgTxRxpd66hOm8jbrbU
Message-ID: <CAF=yD-Jah3+1Sj3-Us72fKNu-__sg7pNb+-kC_knAV=iTHAitQ@mail.gmail.com>
Subject: Re: [PATCH net 0/6] net/sched: Fix packet loops in mirred and netem
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Paolo Abeni <pabeni@redhat.com>, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, horms@kernel.org, andrew+netdev@lunn.ch, 
	netdev@vger.kernel.org, xiyou.wangcong@gmail.com, jiri@resnulli.us, 
	victor@mojatatu.com, dcaratti@redhat.com, lariel@nvidia.com, 
	daniel@iogearbox.net, pablo@netfilter.org, kadlec@netfilter.org, fw@strlen.de, 
	phil@nwl.cc, netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	zyc199902@zohomail.cn, lrGerlinde@mailfence.com, jschung2@proton.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254560-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,davemloft.net,google.com,kernel.org,lunn.ch,vger.kernel.org,gmail.com,resnulli.us,mojatatu.com,nvidia.com,iogearbox.net,netfilter.org,strlen.de,nwl.cc,zohomail.cn,mailfence.com,proton.me];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: A87FBABCE1
X-Rspamd-Action: no action

On Thu, Jan 15, 2026 at 6:33=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Thu, Jan 15, 2026 at 5:23=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> w=
rote:
> >
> > On 1/11/26 5:39 PM, Jamal Hadi Salim wrote:
> > > We introduce a 2-bit global skb->ttl counter.Patch #1 describes how w=
e puti
> > > together those bits. Patches #2 and patch #5 use these bits.
> > > I added Fixes tags to patch #1 in case it is useful for backporting.
> > > Patch #3 and #4 revert William's earlier netem commits. Patch #6 intr=
oduces
> > > tdc test cases.
> >
> > Generally speaking I think that a more self-encapsulated solution shoul=
d
> > be preferable.
> >
>
> I dont see a way to do that with mirred. I am more than happy if
> someone else solves that issue or gives me an idea how to.

It might be informative that there used to be a redirect ttl field. I
removed it as part of tc_verd in commit aec745e2c520 ("net-tc: remove
unused tc_verd fields"). It was already unused by that time. The
mechanism was removed earlier in commit c19ae86a510c ("tc: remove
unused redirect ttl").

The IFB specific redirect logic remains (tc_at_ingress,
tc_skip_classify, from_ingress, redirected). Maybe some of those bits
can be used more efficiently. The cover letter for commit aec745e2c520
had a few suggestions [1].

Another redirect limit we have is XMIT_RECURSION_LIMIT. Though this
assumes running in a single call stack. BPF redirect uses it as of
commit a70b506efe89 ("bpf: enforce recursion limit on redirects"). For
tx. Rx takes netif_rx, so enqueue_to_backlog. So it does not seem that
this can address the entire request.

[1] https://lists.openwall.net/netdev/2017/01/07/92

