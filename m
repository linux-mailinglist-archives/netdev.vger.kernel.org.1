Return-Path: <netdev+bounces-99226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 908908D4278
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 02:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B36AB1C2263A
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 00:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9EE8F47;
	Thu, 30 May 2024 00:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AWbyJFfo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F376D8814
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 00:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717030026; cv=none; b=QQ633R8043axhGat+vSxJbc5YLjNJzgNx5cRmn9wf+8cEp7zBCRMCHkdG/fvVtUDuuQ7Vdp2zXxwk3cshAFrK64WFiSn4URpHtyKnWcXLWZL1m+n6uWQcbcJWz7SC2BG66b2qprLGLkqb2L+ODjdyskfRcS7m5gLXp+UP+WJ9Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717030026; c=relaxed/simple;
	bh=T7+L8zSx24UPrxEiXAjqn+OrIhKKuzWRn04I7ERbZIU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=RpBvitswRCNbrrhPbKEZRSGXlz8Dy1eLtx5yxHs87mSh4g4IKFIZR6df3c3WCIkPJ3HVbztcvZLv/bM0t5sAGbahuIgBrA27eYScCa8rlYVvc52tIZZGTz6IJWfj7Qn8C068QPOPCWa3V2D7LAO1G/Vmz68+30XJ/4RaO/f9wHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AWbyJFfo; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-43f87ba7d3eso1467881cf.0
        for <netdev@vger.kernel.org>; Wed, 29 May 2024 17:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717030024; x=1717634824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xG2J5UvvwrbJ4Z1FlJXLqS51iEXcDyo71lcqaTpzDqA=;
        b=AWbyJFfoowKW6YeukatK5Yf9XFmw80ZOMrImcPRDCsa2DRQEACMJv/+daYDi5gUL50
         zZVDj07ocWkPnicrEWGS93CuRoqK1HKb+5su2Ek27OCvZeAkCEx5DmjblaDvMUbyolht
         XIKf/m9s0e5y23i9TinD/HwRYouu4V5u3prVb+xJ30cHokR7V4OoTesk3ruQsI8jdk7R
         neSCB/k6zmV/xVq3dBt1GvdGE16cVumS2URSUoBpjVkB1gzLxoEAzEpEQMbiiPJR9LlE
         nKKnACFg8S210LvnC2W2Rn2QrZQbpzIbjHD/EpRcse3JBFQ0E1vvMENwTc9fWl9Y7ED2
         i8rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717030024; x=1717634824;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xG2J5UvvwrbJ4Z1FlJXLqS51iEXcDyo71lcqaTpzDqA=;
        b=ZzSMxNDGzCfOMn/3AMsR5FOnowWEDjSx0ZNtULLuKKNE/J2cPHG18GHEifItumPCqD
         I5AE6KruO+oSdaA6Pr6uHVNYkFJvO8IzL5eyXPNhbjC2Mmin+JitI+aESIKMuqCHMrna
         XzVwID/hJzChpkVfQ9S4K6/sk5EJP5oStjo4CYLrFlP2/V9l9mzrz1BgtTyObH2Pkfiq
         n8NDnDW3/FMxC2ShZur9NbJslXdMIlXJyw2Mljv7HfsK1Rb5E6W30XKQDfVcYHZggAzG
         Qu3LYGd2kcFtnd9Zd/X+2ZCl2erIFn1YgkWaq+uefPjUETYNuIQP1K0c7/ZSV9muqR9M
         00bw==
X-Gm-Message-State: AOJu0Yy6lzsYK/11jntLxdiwN34onqECWTLlR8oUrSCDprvjcPkTUmio
	SkwI9Qxq9P3BSOzb9Cm1z9kuU3KRIXa03KJQn6z0OZ2AR6eTBcDE
X-Google-Smtp-Source: AGHT+IEcUzLimxS+TW1Z7xVjW2+AsDFudFsuncv45+BXAp4Ee4q1XRT5LAVNWQZzfAnLHiNrHHl+VA==
X-Received: by 2002:ac8:5d54:0:b0:43e:3b8e:671f with SMTP id d75a77b69052e-43fe93130c2mr8855001cf.47.1717030023624;
        Wed, 29 May 2024 17:47:03 -0700 (PDT)
Received: from localhost (112.49.199.35.bc.googleusercontent.com. [35.199.49.112])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43fb16b97aasm60002811cf.4.2024.05.29.17.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 17:47:03 -0700 (PDT)
Date: Wed, 29 May 2024 20:47:02 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, 
 pabeni@redhat.com, 
 borisp@nvidia.com, 
 gal@nvidia.com, 
 cratiu@nvidia.com, 
 rrameshbabu@nvidia.com, 
 steffen.klassert@secunet.com, 
 tariqt@nvidia.com
Message-ID: <6657cc86ddf97_37107c29438@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240529103505.601872ea@kernel.org>
References: <20240510030435.120935-1-kuba@kernel.org>
 <20240510030435.120935-2-kuba@kernel.org>
 <66416bc7b2d10_1d6c6729475@willemb.c.googlers.com.notmuch>
 <20240529103505.601872ea@kernel.org>
Subject: Re: [RFC net-next 01/15] psp: add documentation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> On Sun, 12 May 2024 21:24:23 -0400 Willem de Bruijn wrote:
> > Jakub Kicinski wrote:
> > > +PSP Security Protocol (PSP) was defined at Google and published in:
> > > +
> > > +https://raw.githubusercontent.com/google/psp/main/doc/PSP_Arch_Spec.pdf
> > > +
> > > +This section briefly covers protocol aspects crucial for understanding
> > > +the kernel API. Refer to the protocol specification for further details.
> > > +
> > > +Note that the kernel implementation and documentation uses the term
> > > +"secret state" in place of "master key", it is both less confusing
> > > +to an average developer and is less likely to run afoul any naming
> > > +guidelines.  
> > 
> > There is some value in using the same terminology in the code as in
> > the spec.
> > 
> > And the session keys are derived from a key. That is more precise than
> > state. Specifically, counter-mode KDF from an AES key.
> > 
> > Perhaps device key, instead of master key? 
> 
> Weak preference towards secret state, but device key works, too.

Totally your choice. I just wanted to make sure this was considered.
 
> > > +Derived Rx keys
> > > +---------------
> > > +
> > > +PSP borrows some terms and mechanisms from IPsec. PSP was designed
> > > +with HW offloads in mind. The key feature of PSP is that Rx keys for every
> > > +connection do not have to be stored by the receiver but can be derived
> > > +from secret state and information present in packet headers.  
> > 
> > A second less obvious, but neat, feature is that it supports an
> > encryption offset, such that (say) the L4 ports are integrity
> > protected, but not encrypted, to allow for in-network telemetry.
> 
> I know, but the opening paragraph has:
> 
>    This section briefly covers protocol aspects crucial for
>    understanding the kernel API. Refer to the protocol specification for further details.
> 
> :) .. and I didn't implement the offset, yet. (It's trivial to add and
> ETOOMANYPATCHES.)

Ack, sounds good.

> 
> > > +This makes it possible to implement receivers which require a constant
> > > +amount of memory regardless of the number of connections (``O(1)`` scaling).
> > > +
> > > +Tx keys have to be stored like with any other protocol,  
> > 
> > Keys can optionally be passed in descriptor.
> 
> Added: Preferably, the Tx keys should be provided with the packet (e.g.
> as part of the descriptors).
> 
> > > +The expectation is that higher layer protocols will take care of
> > > +protocol and key negotiation. For example one may use TLS key exchange,
> > > +announce the PSP capability, and switch to PSP if both endpoints
> > > +are PSP-capable.  
> > 
> > > +Securing a connection
> > > +---------------------
> > > +
> > > +PSP encryption is currently only supported for TCP connections.
> > > +Rx and Tx keys are allocated separately. First the ``rx-assoc``
> > > +Netlink command needs to be issued, specifying a target TCP socket.
> > > +Kernel will allocate a new PSP Rx key from the NIC and associate it
> > > +with given socket. At this stage socket will accept both PSP-secured
> > > +and plain text TCP packets.
> > > +
> > > +Tx keys are installed using the ``tx-assoc`` Netlink command.
> > > +Once the Tx keys are installed all data read from the socket will
> > > +be PSP-secured. In other words act of installing Tx keys has the secondary
> > > +effect on the Rx direction, requring all received packets to be encrypted.  
> > 
> > Consider clarifying the entire state diagram from when one pair
> > initiates upgrade.
> 
> Not sure about state diagram, there are only 3 states. Or do you mean
> extend TCP state diagrams? I think a table may be better:
> 
> Event         | Normal TCP      | Rx PSP key present | Tx PSP key present |
> ---------------------------------------------------------------------------
> Rx plain text | accept          | accept             | drop               |
> 
> Rx PSP (good) | drop            | accept             | accept             |
> 
> Rx PSP (bad)  | drop            | drop               | drop               |
> 
> Tx            | plain text      | plain text         | encrypted *        |
> 
> * data enqueued before Tx key in installed will not be encrypted
>   (either initial send nor retranmissions)
> 
> 
> What should I add?

I've mostly been concerned about the below edge cases.

If both peers are in TCP_ESTABLISHED for the during of the upgrade,
and data is aligned on message boundary, things are straightforward.

The retransmit logic is clear, as this is controlled by skb->decrypted
on the individual skbs on the retransmit queue.

That also solves another edge case: skb geometry changes on retransmit
(due to different MSS or segs, using tcp_fragment, tso_fragment,
tcp_retrans_try_collapse, ..) maintain skb->decrypted. It's not
possible that skb is accidentally created that combines plaintext and
ciphertext content.

Although.. does this require adding that skb->decrypted check to
tcp_skb_can_collapse?
 
> > And some edge cases:
> > 
> > - retransmits
> > - TCP fin handshake, if only one peer succeeds
> 
> So FIN when one end is "locked down" and the other isn't?

If one peer can enter the state where it drops all plaintext, while
the other decides to close the connection before completing the
upgrade, and thus sends a plaintext FIN.

If (big if) that can happen, then the connection cannot be cleanly
closed.
 
> > - TCP control socket response to encrypted pkt
> 
> Control sock ignores PSP.

Another example where a peer stays open and stays retrying if it has
upgraded and drops all plaintext.



