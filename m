Return-Path: <netdev+bounces-296121-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jjGDNHk/JGrN4QEAu9opvQ
	(envelope-from <netdev+bounces-296121-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 17:40:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EFAB64DD75
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 17:40:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b="I63/lY+l";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296121-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-296121-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A485B30117FB
	for <lists+netdev@lfdr.de>; Sat,  6 Jun 2026 15:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B023AFD0D;
	Sat,  6 Jun 2026 15:40:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C27E3B3C18
	for <netdev@vger.kernel.org>; Sat,  6 Jun 2026 15:40:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780760437; cv=none; b=YnDreuYQ61aTMgkUp4e8Gpzxd0edeNzl/7QXacqETreACRoPtkT5Qeb12Xuzc0rvrRHReMCVu9i/svx4C2u6wD8JwTkOqBtfe+HxIHM2FcNfICmrjZalqBKqQE6qGe/SZog2ve0gLpWAX0swlwkBRA2Wy6zjVfutFs4USZpUE+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780760437; c=relaxed/simple;
	bh=WMgSsIfy1PKU5c1F/a0SxehWuwllFQQMDnT+Xt03d10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lpGfxjG+RxqIGxLVorN5utBI1XJgGjlk/AVs/t9FzgHLRHNoAE/qPKguwWmzhxqC4OqGJ+TeyvK7LS+equeytGaNBK7XogeP9BUmc8D/XrOvNd+9ocH9yAmXqzlc7++J0jGbinjZsujuaxChhywOlqL2lygUxnJ1urEdKYPyfhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I63/lY+l; arc=none smtp.client-ip=209.85.214.171
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2c0b1a48855so218245ad.0
        for <netdev@vger.kernel.org>; Sat, 06 Jun 2026 08:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780760436; x=1781365236; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8MExWzCK0h60vFzBsWlciFXkcrb99eODWvMTGLnsCKQ=;
        b=I63/lY+lBk/uKJkFygNWStq0sZK4yVCue3Qp75cW4LgVGFUReFXDU6ZppBSzCxXHcu
         5zNtVpwsksdJJFn5pIeKwbJzn45juV8Gk8O3GhN4oZSL6fm20LkYZZJDm5v10SIuPixw
         TX2GyMGIGUGcHIsVDPLlnrBiJuT287o+iZiHfyPTF1S4MBqiqUOP8S+pDDR/Qbm8mxk5
         KyKHaD6cF7BnY6Ne1NfeNLk1WXZrXmUBgxkpsz8z5Usas0QOu7dnOMp2uGKcrSOVuotR
         lgq3W622eZ58XOTcwZWYrxGiI2EwvymdKG/MmjX2SN/g/19qExWxaCRgQYak3SCsLxVI
         RR+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780760436; x=1781365236;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8MExWzCK0h60vFzBsWlciFXkcrb99eODWvMTGLnsCKQ=;
        b=MAes/a0MFJGtPS6VIk3Fk4iUbPBY9wjycS6uaDup7omi5zJ/7VJr3himhl08YCpyfg
         /11zJk8JsSRgkL7SdAvUwyEdJVmulIBb7J6qhAxl/L0EFw3v/s2sx9BVXikO76hqXznB
         B5n+SrtH0TyKspRfIY0+7U/0/xnVaRID3Kp0ynDrC0mPO6gl+GS4iIGXnINfRQfRBYsD
         FEOA19iIh8vzakf9JkHFxWeN4EUZDiK5cFYOQ54iIvKK9GWkuYZ0LtQRXEPge2g1rkRZ
         vIIaYp6SAoyvOJhSSm21vT27tW+T6z0h2b3B6hYMzqrH70lebo0TnwcVFETtgcLo8xHN
         t1Kw==
X-Forwarded-Encrypted: i=1; AFNElJ9iobS0Q26h4lUJWPvHZACH+X9AEXLpEjg+AhL00l9SQYC+cDq9exwUFodapE7Jhh6BDAMpgqs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRzdPBYH6XQ9DrcfOygyR1stski5NC2s8TInnIPh/1bTmal8I7
	VfrWKVNtwwlFQ15aycGYIP2Otuta/kd3R8Nb7pB6Uf8ZXs33QPyZRWvqT8TgjPHB/Q==
X-Gm-Gg: Acq92OFrtG+bIgyyHlali9wAKeDLvZjTEqTXcwUNaTUH3ZZi00sq/89MOzxLfFtgfkU
	N/mfTMBhhEBC2mOnN0AhO2NRhYKo3ziEyvM3n9i6yl4F8FIst/HhILJ5pfVsZ2tBsRLWBYkrfia
	Ew5ZYgJpI5Dsiyzbmn3tJM8mNSX9F85LnRzLM2HxRfJWwCAWz81PDB5NbVTeq4p1hMHjuXTMUV+
	Ga0adk+USGYCtLkx1p8u/4n4JNGSnF4DLnRGwsh91iEGtorFptEX8ZObttEQ2r0HOEwSMAQXV//
	tiuqafoHDkZO1615WkiSUvRwSyuAmdHoom739pZeot6moEpSZ7+qpuM01TM1IgkLBFTbSODM/+p
	CiFlfpzUVexyQsVhplM4yPuswXtHAMOR8aLKKbkg3BLybHFNFj2KCBBQK7HV4uLf9nlFGVEkndP
	0GrCk2hW83hMIwam/kkCc7YRPQtyvrtMIFDwjm7SRF6xZPP+T/6Od7dRiZJi9UR7tsxDYJJL5n8
	YGEdxH9yJLe3KZGWEFakAcFdqBNAymDrcOwPJjjvbFKZ7zGbKoDO+6r
X-Received: by 2002:a17:902:ced0:b0:2c1:ee6e:be20 with SMTP id d9443c01a7336-2c1ee6ec4f3mr2991205ad.30.1780760435203;
        Sat, 06 Jun 2026 08:40:35 -0700 (PDT)
Received: from google.com (112.174.16.34.bc.googleusercontent.com. [34.16.174.112])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f6d69csm127016155ad.2.2026.06.06.08.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 08:40:34 -0700 (PDT)
Date: Sat, 6 Jun 2026 15:40:30 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Matthew Maurer <mmaurer@google.com>,
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v6 3/3] rust_binder: report netlink transactions
Message-ID: <aiQ_bgoyRGyFDL8m@google.com>
References: <20260529-binder-netlink-v6-0-92dd74b6a32e@google.com>
 <20260529-binder-netlink-v6-3-92dd74b6a32e@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529-binder-netlink-v6-3-92dd74b6a32e@google.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lunn.ch,gmail.com,kernel.org,davemloft.net,google.com,redhat.com,garyguo.net,protonmail.com,umich.edu,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-296121-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:aliceryhl@google.com,m:gregkh@linuxfoundation.org,m:andrew@lunn.ch,m:donald.hunter@gmail.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:mmaurer@google.com,m:ojeda@kernel.org,m:boqun@kernel.org,m:gary@garyguo.net,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:tmgross@umich.edu,m:dakr@kernel.org,m:brauner@kernel.org,m:linux-kernel@vger.kernel.org,m:rust-for-linux@vger.kernel.org,m:netdev@vger.kernel.org,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORGED_SENDER(0.00)[cmllamas@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cmllamas@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6EFAB64DD75

On Fri, May 29, 2026 at 01:28:40PM +0000, Alice Ryhl wrote:
> From: Carlos Llamas <cmllamas@google.com>
> 
> The Android Binder driver supports a netlink API that reports
> transaction *failures* to a userspace daemon. This allows devices to
> monitor processes with many failed transactions so that it can e.g. kill
> misbehaving apps.
> 
> One very important thing that this monitors is when many oneway messages
> are sent to a frozen process, so there is special handling to ensure
> this scenario is surfaced over netlink.
> 
> Signed-off-by: Carlos Llamas <cmllamas@google.com>
> Co-developed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---

Acked-by: Carlos Llamas <cmllamas@google.com>

