Return-Path: <netdev+bounces-101165-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB618FD948
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 23:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60B101C255C9
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 21:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E55D16C426;
	Wed,  5 Jun 2024 21:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mamKSLgt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FC015FCFB
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 21:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717623524; cv=none; b=ccBwCP7b8Sgvq1zfMkZQqSDnqXXz6irE8slzrL/KtetDmn1LUw2JRjWs6Nfje7PM9JrLotgSkyDWpMZHkcIiuuCwqCakmWvcHbid92z5Blc8SkdRZ7QfEGGtWlKJ2UHFb5ZIpanxQocKMhY0sFf36eynOTPV9rDZh+VsJSfecbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717623524; c=relaxed/simple;
	bh=iFkPUwycPtMXY95Fsn6h0Cq5+b23g0Zkpwj3cwixKS8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YPNLboZvDD4nkHg7u6CTx91URUwrNb2e68o4q0R+dQn3r4JmjZhXVg+nR6e+bbsM851ksYtFL/aTfQBsCdVTLkfszi4BLIahOLrafUw5LeVNL0HAqJE46R8y/uzlr05ThrMI6icefTZI5B9RCpSkBDwBu9YMmHuVtmDc21mQS9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mamKSLgt; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-440075abc22so26251cf.1
        for <netdev@vger.kernel.org>; Wed, 05 Jun 2024 14:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717623521; x=1718228321; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sNlsexQwemrp3YanWDx0EtmNkeLt675d7VKIepxZtwQ=;
        b=mamKSLgtkGbxm/tSXVd7DRkaHPVAsKAEa62DE5FZ2fSTTFR7Cb3/i/Dav1udik/pye
         ZAnfnS2CXmyWOeA/fLaowo74MPoyGxdVNF5rBc18wFGjWUqmj2zL4N4XpbKjt5ekuTun
         N5xW0KbZpOgVJC4xjK2doYvOLsquo/tTwT/k01jhZxTb/FbZZ+QoL3k7X+T/XDPI8k2t
         XU99rbF8tygpo8i/d+rCWUjNIyvlmY4xu2ObdIyfW50HDd76ZyVmM0sXRCUTqXuDOp/G
         YHbdHxaRMnESNczF7PC+fiW1rYHknkvhFxmXUqxQaQhTNblrm3epY150Tdmgr7Qig97I
         WIGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717623521; x=1718228321;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sNlsexQwemrp3YanWDx0EtmNkeLt675d7VKIepxZtwQ=;
        b=Twezthhi2dULsCRVAbzonoEI3Wozx3A5WgtS0lTKcNY6MzEHF8rnFFlwIDQip/ltAR
         HRaDZxSGzlHICmutn9R7/MaoNjx6AxRGBAk/02lXoCtnkV9Bne82GQxqGXgtLFzTqKth
         /JFBesrVcwGYqTOVjLZPrq5jH2GB8w7kaeWRJs+C9Od2qF1EfM2cGOB+6zCpyXKyRwAG
         2g5mBSCIeYeRQJEpc/XoNq0HUveOm+8FrF8dFMbRIvo8JBtWrS+Vq/ZdAevE50zTxzj6
         zCEzYvtvWCZzZpj11B+lwH9fojI3qdEP8+2pKuGL9g8ceKLVal3/woAj4ytJRau0FqDW
         WjAA==
X-Forwarded-Encrypted: i=1; AJvYcCUWXOOsJrsNzoNKdL/VWMM23AOhx9igS1N7HiWqZsc9D72GXpdwLMW6XrZRrxfP1Ai6ac+dmSulTbvDhSFKpqyRcVtuA9Iv
X-Gm-Message-State: AOJu0YwnU7jWVd9vprHXcAf1zqauZvXwPMv9dmbuvrBqFd2EDxDlLrPl
	ywKRmpwkc4RzNhKQ5fwNJyx+TF66+aVTjeUsoy1HxB/qRVZqt/1x63dqjcz/L9WnS20pV6q1gx5
	JN34QcYIKTIbnq56MnNz3JlaHgirG/Nm8tr3x
X-Google-Smtp-Source: AGHT+IEiuKACUaGLuSwGmJwkpMR0OPVSW4SzM49ZaIPJxW507njKclILP9f6lCQlKpo1klduo2oOWGSfKnf+UaubKEY=
X-Received: by 2002:a05:622a:5a9b:b0:440:1451:d152 with SMTP id
 d75a77b69052e-4403730ebfamr1008921cf.28.1717623520568; Wed, 05 Jun 2024
 14:38:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240604120311.27300-1-fw@strlen.de> <FF8A506F-6F0F-440E-9F52-B27D05731B77@apple.com>
 <20240605181450.GA7176@breakpoint.cc> <ZmCwlbF8BvLGNgRM@calendula>
 <20240605190833.GB7176@breakpoint.cc> <ZmDAQ6r49kSgwaMm@calendula>
In-Reply-To: <ZmDAQ6r49kSgwaMm@calendula>
From: Willem de Bruijn <willemb@google.com>
Date: Wed, 5 Jun 2024 17:38:00 -0400
Message-ID: <CA+FuTSfAhHDedA68LOiiUpbBtQKV9E-W5o4TJibpCWokYii69A@mail.gmail.com>
Subject: Re: [PATCH nf] netfilter: nf_reject: init skb->dev for reset packet
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Florian Westphal <fw@strlen.de>, Christoph Paasch <cpaasch@apple.com>, 
	Netfilter <netfilter-devel@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, daniel@iogearbox.net, 
	Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 5, 2024 at 3:45=E2=80=AFPM Pablo Neira Ayuso <pablo@netfilter.o=
rg> wrote:
>
> On Wed, Jun 05, 2024 at 09:08:33PM +0200, Florian Westphal wrote:
> > Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> >
> > [ CC Willem ]
> >
> > > On Wed, Jun 05, 2024 at 08:14:50PM +0200, Florian Westphal wrote:
> > > > Christoph Paasch <cpaasch@apple.com> wrote:
> > > > > > Reported-by: Christoph Paasch <cpaasch@apple.com>
> > > > > > Suggested-by: Paolo Abeni <pabeni@redhat.com>
> > > > > > Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/=
494
> > > > > > Signed-off-by: Florian Westphal <fw@strlen.de>
> > > > >
> > > > > I just gave this one a shot in my syzkaller instances and am stil=
l hitting the issue.
> > > >
> > > > No, different bug, this patch is correct.
> > > >
> > > > I refuse to touch the flow dissector.
> > >
> > > I see callers of ip_local_out() in the tree which do not set skb->dev=
.
> > >
> > > I don't understand this:
> > >
> > > bool __skb_flow_dissect(const struct net *net,
> > >                         const struct sk_buff *skb,
> > >                         struct flow_dissector *flow_dissector,
> > >                         void *target_container, const void *data,
> > >                         __be16 proto, int nhoff, int hlen, unsigned i=
nt flags)
> > > {
> > > [...]
> > >         WARN_ON_ONCE(!net);
> > >         if (net) {
> > >
> > > it was added by 9b52e3f267a6 ("flow_dissector: handle no-skb use case=
")
> > >
> > > Is this WARN_ON_ONCE() bogus?
> >
> > When this was added (handle dissection from bpf prog, per netns), the c=
orrect
> > solution would have been to pass 'struct net' explicitly via skb_get_ha=
sh()
> > and all variants.  As that was likely deemed to be too much code churn =
it
> > tries to infer struct net via skb->{dev,sk}.

It has been a while, but I think we just did not anticipate skb's with
neither dev nor sk set.

Digging through the layers from skb_hash to __skb_flow_dissect
now, it does look impractical to add such an explicit API.

> > So there are several options here:
> > 1. remove the WARN_ON_ONCE and be done with it
> > 2. remove the WARN_ON_ONCE and pretend net was init_net
> > 3. also look at skb_dst(skb)->dev if skb->dev is unset, then back to 1)
> >    or 2)
> > 4. stop using skb_get_hash() from netfilter (but there are likely other
> >    callers that might hit this).
> > 5. fix up callers, one by one
> > 6. assign skb->dev inside netfilter if its unset

Is 6 a realistic option?

> >
> > 3 and 2 combined are probably going to be the least invasive.
> >
> > 5 might take some time, we now know two, namely tcp resets generated
> > from netfilter and igmp_send_report().  No idea if there are more.
>
> Quickly browsing, synproxy and tee also calls ip_local_out() too.
>
> icmp_send() which is used, eg. to send destination unreachable too to
> reset.

Since this uses ip_append_data the generated response should have
its skb->sk set.

> There is also __skb_get_hash_symmetric() that could hit this from
> nft_hash?
>
> No idea what more callers need to be adjusted to remove this splat,
> that was a cursory tree review.
>
> And ip_output() sets on skb->dev from postrouting path, then if
> callers are fixed, then skb->dev would be once then again from output pat=
h?

