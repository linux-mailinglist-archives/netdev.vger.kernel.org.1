Return-Path: <netdev+bounces-99756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C049C8D63DF
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 16:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 059521F2532C
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 14:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C23B178369;
	Fri, 31 May 2024 13:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IMyGz7N/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C214F158DAA
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 13:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717163806; cv=none; b=fm71xPHP4d865uMXy151Y+9kmFSvTivJ88VIlhWNeh8kf5g3kbanZv70uwK0EPcpfaiEQQqDoO+P5dxVK9IHptT77v/LaVuehCPiH20RsvQ7Q29jI4j+xASVmBUYXSofFuiXLYdv1HTuNsA6sfjySYyh+IjIG38rlcUsJKlolLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717163806; c=relaxed/simple;
	bh=pexDzoDCnMkemjDzC2b8O6mK5xhmwOB4EnJmfCOxsNc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=GIuIWXPFz1W5TQfGGKwoCfEfd+DFgNWqmZpQyTejSEwVPJtEzGA8rUFJuuIQdqNUSNLnN0DYd3WOOiCXOnxCrKkq2cJMg5T9DvJdjEXtzjSNAZ1sTTmDEmnhStXhWrxqx4Rn6Q/8LT7O/CuLtTY9M1hE1AmMz+ujyddyxwjnuNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IMyGz7N/; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6f72b8db7deso1173323a34.2
        for <netdev@vger.kernel.org>; Fri, 31 May 2024 06:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717163804; x=1717768604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R/vjYR6AdAcWXKgHL6CzaS8f/Y0GYE/ET5gJEM7EXFU=;
        b=IMyGz7N/8a6W1uj3baYMW19WGbt0t1Det38BQQqrnbLDo9gA6Q/rO3Eo/EQ9aYkzmJ
         DMaNixcqbIfae/pTN7t6VwY2b26uEbG3ydnrcjB+wZMBp544ifwhX+u4353/+3Yjh+Yr
         FzdcusawkUTDbfCx4qkjMDSvJ3qKw2L1h+wFaNaXgS3rWwqj7njrvk4iBn8MrKASBNg+
         5rGZ1p/1RAsP8YuOFugrfv5wc5yo9KWNKCj7foy4ZXJvakUh6AWLaSPWEPtWD2gIyD3L
         BPQMn+cPjq1HDr9ebHNxVKSFIaDfO58d53RuLRRu044K0KqF++rBKPMws72bSpmfyjeY
         NOYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717163804; x=1717768604;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=R/vjYR6AdAcWXKgHL6CzaS8f/Y0GYE/ET5gJEM7EXFU=;
        b=ng5NnTTshQy2pw0gHXnmTqI+2AkInB410WTKbbV9Sqqqv7uQmcJKkzCXwrLtrxjUEO
         uM2mHPmMxmBogs5S4GkGArFXL5fe7Hnxp9w97wYKKzUvFyEBT34aFHcGa63xemMvuIOS
         zx0sCcCL/Y+vfCfpA6MjbvVLSYqAI2GGKtPZbWVbnuBW/rEAIgp5nWU2NFt9fgnYecNl
         gkKVw7fWn7Q3zPE36NkjU1kOdwBpAD3aORw/8FCYqInV1w8Pel/JFVecrIVO7ZQ+4Xpq
         pFlQ90L0xhbzbtph9OLMMLBT+e0wY//OY20dhC4ZHTWuDaPOib8q5LLyCCkX9SkFrCCB
         sGqw==
X-Gm-Message-State: AOJu0YxrJ11ou1H4JaLkBhzraCmdk9EsqS8R8ZcptWIOeD5fotcLazP8
	heJcI3Wo9wW0dtsYMJT6vgAmKcK3nHeFXNTEgLHIcEdpu/jya2/Z
X-Google-Smtp-Source: AGHT+IHjsIKZxQrSmLHv4gmorkcPCsdFtM5CFrYzVEHC3DrAVe35PtuUCN31wq8KpdZClQ/MXPW2nw==
X-Received: by 2002:a9d:7cd1:0:b0:6eb:86c4:eeb5 with SMTP id 46e09a7af769-6f911fa0254mr2107510a34.23.1717163803651;
        Fri, 31 May 2024 06:56:43 -0700 (PDT)
Received: from localhost (112.49.199.35.bc.googleusercontent.com. [35.199.49.112])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43ff35dfd56sm6813981cf.21.2024.05.31.06.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 06:56:43 -0700 (PDT)
Date: Fri, 31 May 2024 09:56:42 -0400
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
Message-ID: <6659d71adc259_3f8cab29433@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240530125120.24dd7f98@kernel.org>
References: <20240510030435.120935-1-kuba@kernel.org>
 <20240510030435.120935-2-kuba@kernel.org>
 <66416bc7b2d10_1d6c6729475@willemb.c.googlers.com.notmuch>
 <20240529103505.601872ea@kernel.org>
 <6657cc86ddf97_37107c29438@willemb.c.googlers.com.notmuch>
 <20240530125120.24dd7f98@kernel.org>
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
> On Wed, 29 May 2024 20:47:02 -0400 Willem de Bruijn wrote:
> > Jakub Kicinski wrote:
> > > On Sun, 12 May 2024 21:24:23 -0400 Willem de Bruijn wrote:  
> > > > There is some value in using the same terminology in the code as in
> > > > the spec.
> > > > 
> > > > And the session keys are derived from a key. That is more precise than
> > > > state. Specifically, counter-mode KDF from an AES key.
> > > > 
> > > > Perhaps device key, instead of master key?   
> > > 
> > > Weak preference towards secret state, but device key works, too.  
> > 
> > Totally your choice. I just wanted to make sure this was considered.
> 
> Already run the sed, device key it is :)
> 
> > > > Consider clarifying the entire state diagram from when one pair
> > > > initiates upgrade.  
> > > 
> > > Not sure about state diagram, there are only 3 states. Or do you mean
> > > extend TCP state diagrams? I think a table may be better:
> > > 
> > > Event         | Normal TCP      | Rx PSP key present | Tx PSP key present |
> > > ---------------------------------------------------------------------------
> > > Rx plain text | accept          | accept             | drop               |
> > > 
> > > Rx PSP (good) | drop            | accept             | accept             |
> > > 
> > > Rx PSP (bad)  | drop            | drop               | drop               |
> > > 
> > > Tx            | plain text      | plain text         | encrypted *        |
> > > 
> > > * data enqueued before Tx key in installed will not be encrypted
> > >   (either initial send nor retranmissions)
> > > 
> > > 
> > > What should I add?  
> > 
> > I've mostly been concerned about the below edge cases.
> > 
> > If both peers are in TCP_ESTABLISHED for the during of the upgrade,
> > and data is aligned on message boundary, things are straightforward.
> > 
> > The retransmit logic is clear, as this is controlled by skb->decrypted
> > on the individual skbs on the retransmit queue.
> > 
> > That also solves another edge case: skb geometry changes on retransmit
> > (due to different MSS or segs, using tcp_fragment, tso_fragment,
> > tcp_retrans_try_collapse, ..) maintain skb->decrypted. It's not
> > possible that skb is accidentally created that combines plaintext and
> > ciphertext content.
> > 
> > Although.. does this require adding that skb->decrypted check to
> > tcp_skb_can_collapse?
> 
> Good catch. The TLS checks predate tcp_skb_can_collapse() (and MPTCP).
> We've grown the check in tcp_shift_skb_data() and the logic
> in tcp_grow_skb(), both missing the decrypted check.
> 
> I'll send some fixes, these are existing bugs :(
> 
> > > > And some edge cases:
> > > > 
> > > > - retransmits
> > > > - TCP fin handshake, if only one peer succeeds  
> > > 
> > > So FIN when one end is "locked down" and the other isn't?  
> > 
> > If one peer can enter the state where it drops all plaintext, while
> > the other decides to close the connection before completing the
> > upgrade, and thus sends a plaintext FIN.
> > 
> > If (big if) that can happen, then the connection cannot be cleanly
> > closed.
> 
> Hm. And we can avoid this by only enforcing encryption of data-less
> segments once we've seen some encrypted data?

That would help. It may also be needed to accept a pure ACK right at
the upgrade seqno. Depends on the upgrade process.

Which may be worth documenting explicitly: the system call and network
packet exchange from when one peer initiates (by generating its local
key) until the connection is fully encrypted. That also allows poking
at the various edge cases that may happen if packets are lost, or when
actions can race.

One unexpected example of the latter that I came across was Tx SADB
key insertion in tail edge cases taking longer than network RTT, for
instance.

The kernel API can be exercised in a variety of ways, not all of them
will uphold the correctness. Documenting how it should be used should
help.

Even better when it reduces the option space. As it already does by
failing a Tx key install until Rx is configured.

> > > > - TCP control socket response to encrypted pkt  
> > > 
> > > Control sock ignores PSP.  
> > 
> > Another example where a peer stays open and stays retrying if it has
> > upgraded and drops all plaintext.

May want to always allow plaintext RSTs. This is a potential DoS
vector. In all these cases, I suppose this has already been figured
out for TLS.

