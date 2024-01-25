Return-Path: <netdev+bounces-65729-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DBBA583B7AF
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 04:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA61CB2230A
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 03:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEEAB7FB;
	Thu, 25 Jan 2024 03:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mbkZRX2o"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5094179C1
	for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 03:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706152501; cv=none; b=dgOw9xCgYZkzQsPSDkZP6rWmQ4i65fVYxGJugKaWTCnAUP8w93pzRfZr6FMKkL0xE5PaSS5vJ+3CPEBSCfY9GBSCQWlVOoTV7gn2xmVC31eH5n64cfRnefH8/rGSsuVAl/xEhgb38RxQ3b54zoeacQho3ri6tUqJzVUs/jYfkGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706152501; c=relaxed/simple;
	bh=s5uG1QowG9mewkQnx7r5J8Xw/q6iegtpmxUi7VrWR74=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=nq4rf4JzSc67gEo/Bzm/XFfe2vOvXP0q9MDlMMnneT9VxTfrbKm/uV6Qsn9qkj5YJgo+EohEwNIFKKqg0krwNzPXxFY7z/92RkpniLNf+wAm2rNRNO5COKVC280ROzLj+9YVFcs1XdROl8C1GiGPSq3mYzihZOLB+nYEa1Wg8ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mbkZRX2o; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-78104f6f692so34421585a.1
        for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 19:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706152499; x=1706757299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wLYh+nt9ge5g6rYsCdV5xXhNgsQcoc3etE0lS+iSEeE=;
        b=mbkZRX2oWjGT2ocElE69hodveEc1JWrn0JyaqfwbnMoCE3BHVBqEhCYZibRX7C27n1
         WlBzuS4Fx8SkCrb5Q0XbKzj5m/xKjL/uyw2141dQ+GIuXMpgrssyuv30FGt93f4LrHHH
         7XAts/ypd7M/CnAddiqKnN6R3voHHPrgkrN3yQ6TfQioFDcD8+l1KBDwBHguQxUKWxE1
         NMXv2NkVXYQvUvTzxfEdgRSLdYu6S6zciyaRwosNsQpuRs42VcCW1KWoXO+G59wEN4uw
         OfO5WrzZ0Gdw+OmGiA12INMHpM120C1LX5/tYrDNuBH5pGjxlERzwrw69yXAu+iui1Xs
         wtpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706152499; x=1706757299;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wLYh+nt9ge5g6rYsCdV5xXhNgsQcoc3etE0lS+iSEeE=;
        b=HDGRFaiT0LkCjyZBtPOG491W/qIktOjUytLzXiNE2TMuPh+OQh5j+C++35/WZ+2e2N
         zlrMLP3so+wQRooG6HKqnns5j3RAB1hvN6vE3YdxgS+bR+WK7BH4qlp749eNg40QUF0h
         wDymLGL+q16X7uQvNemGgtwsjCmGFJzQjgXvewPEZEoMrI4UtSKk8mQOyWDYjsYxShQH
         TMyOR91VrdZzG82XZjWGUNyiToosmh01nqz4JBfvXi5ZUZoE7qDeUE0NyOxSNijIEbxD
         5KT2a90ujFwWJlI5fi6RzARdI0HFBNFQ16niZn0Bvk2rWUAyWvP7FeTEVUe6dbR5U/HK
         QiTA==
X-Gm-Message-State: AOJu0YxlZZFo3SPNb6NIkqi99sJ3AlSg+9BlL4mIZAxWutdkcG0jEqTS
	clZnnfayqMoI0Bohe3OukyJmzibp4Z/EE9Q46bh/WdU3BQzJ7Giz
X-Google-Smtp-Source: AGHT+IHOs69jL/rPE0t0HMtGCa5y5wiNEaj6SzkzPpZk1ytWzC8VCVQgo4yw26holTpKtpmMw0tPTA==
X-Received: by 2002:a05:620a:60f3:b0:783:8c3d:64f2 with SMTP id dy51-20020a05620a60f300b007838c3d64f2mr447238qkb.72.1706152499163;
        Wed, 24 Jan 2024 19:14:59 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXzWW5l6p/Y7MrkFmuSjDLXZMh9OxAExxWa/R1HVEPAOgGIrzBdTCUuevUGRZFggyj6au6tt/Ylu0wyjvP7/k+gQd9neU6UZHSUS2NeaCTUkQ==
Received: from localhost (131.65.194.35.bc.googleusercontent.com. [35.194.65.131])
        by smtp.gmail.com with ESMTPSA id h7-20020a37de07000000b007815c25b32bsm4665470qkj.35.2024.01.24.19.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 19:14:58 -0800 (PST)
Date: Wed, 24 Jan 2024 22:14:58 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Alan Brady <alan.brady@intel.com>, 
 intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, 
 Alan Brady <alan.brady@intel.com>
Message-ID: <65b1d232a7ff8_250560294f3@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240122211125.840833-1-alan.brady@intel.com>
References: <20240122211125.840833-1-alan.brady@intel.com>
Subject: Re: [PATCH 0/6 iwl-next] idpf: refactor virtchnl messages
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Alan Brady wrote:
> The motivation for this series has two primary goals. We want to enable
> support of multiple simultaneous messages and make the channel more
> robust. The way it works right now, the driver can only send and receive
> a single message at a time and if something goes really wrong, it can
> lead to data corruption and strange bugs.
> 
> This works by conceptualizing a send and receive as a "virtchnl
> transaction" (idpf_vc_xn) and introducing a "transaction manager"
> (idpf_vc_xn_manager). The vcxn_mngr will init a ring of transactions
> from which the driver will pop from a bitmap of free transactions to
> track in-flight messages. Instead of needing to handle a complicated
> send/recv for every a message, the driver now just needs to fill out a
> xn_params struct and hand it over to idpf_vc_xn_exec which will take
> care of all the messy bits. Once a message is sent and receives a reply,
> we leverage the completion API to signal the received buffer is ready to
> be used (assuming success, or an error code otherwise).
> 
> At a low-level, this implements the "sw cookie" field of the virtchnl
> message descriptor to enable this. We have 16 bits we can put whatever
> we want and the recipient is required to apply the same cookie to the
> reply for that message.  We use the first 8 bits as an index into the
> array of transactions to enable fast lookups and we use the second 8
> bits as a salt to make sure each cookie is unique for that message. As
> transactions are received in arbitrary order, it's possible to reuse a
> transaction index and the salt guards against index conflicts to make
> certain the lookup is correct. As a primitive example, say index 1 is
> used with salt 1. The message times out without receiving a reply so
> index 1 is renewed to be ready for a new transaction, we report the
> timeout, and send the message again. Since index 1 is free to be used
> again now, index 1 is again sent but now salt is 2. This time we do get
> a reply, however it could be that the reply is _actually_ for the
> previous send index 1 with salt 1.  Without the salt we would have no
> way of knowing for sure if it's the correct reply, but with we will know
> for certain.
> 
> Through this conversion we also get several other benefits. We can now
> more appropriately handle asynchronously sent messages by providing
> space for a callback to be defined. This notably allows us to handle MAC
> filter failures better; previously we could potentially have stale,
> failed filters in our list, which shouldn't really have a major impact
> but is obviously not correct. I also managed to remove slightly more
> lines than I added which is a win in my book.
> 
> Alan Brady (6):
>   idpf: implement virtchnl transaction manager
>   idpf: refactor vport virtchnl messages
>   idpf: refactor queue related virtchnl messages
>   idpf: refactor remaining virtchnl messages
>   idpf: refactor idpf_recv_mb_msg
>   idpf: cleanup virtchnl cruft
> 
>  drivers/net/ethernet/intel/idpf/idpf.h        |  192 +-
>  .../ethernet/intel/idpf/idpf_controlq_api.h   |    5 +
>  drivers/net/ethernet/intel/idpf/idpf_lib.c    |   29 +-
>  drivers/net/ethernet/intel/idpf/idpf_main.c   |    3 +-
>  drivers/net/ethernet/intel/idpf/idpf_vf_dev.c |    2 +-
>  .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 1984 ++++++++---------
>  6 files changed, 1045 insertions(+), 1170 deletions(-)

Great improvement, +1.

This makes virtchan more robust during edge case conditions, more
scalable and the code cleaner: less open coded duplication across
every vc operation.

The code mostly matches what I am familiar with and we have extensive
test experience with. From an initial side-by-side comparison.

I'll need to read the code that differs more closely (such as the
xn_bm_lock that Simon commented on) and will run a sanity test. Even
just a successful boot will have exercised much of this code.

One comment for patch [4/6] only.


