Return-Path: <netdev+bounces-296119-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9s0HCjg/JGrA4QEAu9opvQ
	(envelope-from <netdev+bounces-296119-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 17:39:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D196864DD70
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 17:39:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b="ByWYB/cv";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296119-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-296119-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 780B53019807
	for <lists+netdev@lfdr.de>; Sat,  6 Jun 2026 15:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104D53B47D5;
	Sat,  6 Jun 2026 15:39:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338F73A4F4B
	for <netdev@vger.kernel.org>; Sat,  6 Jun 2026 15:39:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780760371; cv=none; b=Vp2vd9DOVbW4hPSsAYaKL+jOHYYBkK+8om7X73QMGbRfjH/tKg/ykDf6CqZvqoy1DCL0E/xz8ywSiP3HeL0zEh3yH9I9rwSP6UWJFZbcYNpXSF1bAQPna9IxuzYSGfTXaeZNtVN5No3TCJMdKa6Bru7ECbb/zZE1EyTpqHeFzWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780760371; c=relaxed/simple;
	bh=ufkwTlSXf3ZWG1Dce5sP9AW5G+vLKGXNBj0iluLZVZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M4uEDb52TTtEouQKdS6EPIelZumTlCOr2Evnu81dXz7B2AvPARnFm23C1Te24Erw6wDfRz/IylBKuVUt0aZD0UUktZfamquHd6Em1NMtYj1ME4kStEWnBfHzRZstG721bwmiAI5Cs8QfbdTDlawczqzuciQZ1qPpKoJYtpwNe4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ByWYB/cv; arc=none smtp.client-ip=209.85.214.169
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2bf22c18ad3so223715ad.0
        for <netdev@vger.kernel.org>; Sat, 06 Jun 2026 08:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780760368; x=1781365168; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uqoLt1G0zuPhE5ck7aafsVgdkXtWSkd44IQ+/jjkZyM=;
        b=ByWYB/cvXr/ClV6Fkhh9LFM7lNIDCM1kOlRQ8HWXKu69rqHuGfjhFodgyj0LiKb0D0
         b/vXI9lJtZecZH+7I1mnwXQJkLYQYFsQcVbfFVw3AqNnA6yiVjq2xNIo71O2YW+lVCkg
         5Akb/HMBFAPcz1jvA64WMGqG22ZioAP+i1+wsCU7BA029ooSWp4+uXyHCJjlgSJddHXT
         3SVnIad6pGH0nh5IErI/H6R6BU3OyJlrPB2eRbTG4dC0zpb+tGRimE0XTLGstxxDPKdq
         zNJHlXb8AWzsHw5T/wLSGn4J5kh6JxwI328DZjZk/nS8v00OezGZWfVWuX8hGC/lNoD6
         Z/pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780760368; x=1781365168;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uqoLt1G0zuPhE5ck7aafsVgdkXtWSkd44IQ+/jjkZyM=;
        b=FyMxxUJYvDdSCMuuTN/1ZbEmmKMHJKF/z3wehIlMtRneTRcv8x34OQ7zG0s5ybwIGc
         03Sdb8odJMoQAmoQwkBqIPtJU7m+wgR9Icwk5AYQ0VLkNk3Y9ZB1uRjvq83b8bSihsSp
         JmxryC438sS7+zTkSfGO586CiYxOnxoL6uAZ0YQSFKB443WPGUn0iJSdNInGRirh/voB
         teIGZ6y7X4wBpa3u/IkQKSdLo3PPn3SdpWSXhleZXKjMiAAYHiXrLRAUdVmAgA0DP4rP
         NStz3gETokI2vMoO1sDYbtXHnxP2JpEmxVtjYhb5nIFQ2nL0TZxu/HpJa6S9BApXS8Sz
         cYFg==
X-Forwarded-Encrypted: i=1; AFNElJ9a0Lx5C/jp5cPb62BdxVUTGgiAojF527QosKmofRwviqzRkUe084/99BR9BBsxjIAJZDixCB8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMOb3bwuhrYAnQVscGPDp/ZiSPYJukcN2iXsPBpe8AwKJqs3OD
	WXKkY2qVZsP9CBEmQP+U/I8UGygjo20xRJzgVOUZZSuxhfLm4hwpB9sQsQjAYEcteg==
X-Gm-Gg: Acq92OEKdViUyBYh+7n0fSD3BCOIyzOAbxK4vjX0QzoguEojwNHluO+BEZc5viul7dX
	k/W6Z0JUuUIwyctjzlAf151clGzveauY/3mUOMcid0q3tS3yNEoVWbu2ZnFZK/pAsOzsMojEmRi
	tOdJ/LXKU/dttI/5hbTFDssYvnpWWe6djaCkeYif9rATZVstIm1qeZB02jmwaIWfMiw+7lIxGSv
	n0M0K99GfVq9jIAJQMZZ4Q/K/mfSpyrvVPe5V3GrSL7eEeiIGHTbJGeXk92u0cAVjoyaLuPW+r9
	lBqIowTDzjDGIKxssYi1ZnH9x1X6nkI+y1n+7Cj29tE6omgeMDhdd6LQNg9y6pE1rOU+y0YNKKi
	rizNCleIoUcXxgbIjPmoh49PxPIedxsfxA8ncFkyFB49+a1v3CKqQ+rpA1hs6upUtcRco0C52sD
	RjFgzIs1gnbdnkvutS+XJ3zPXv4h4yL7HGAAUlakpRS5E69z0oC6oX0ZEEv0BZ1uFamITEbz3Wa
	TcPNlYeYNaxiuabsrL0XzX2KJEDH1moVAw2/F10ck76YOUhDyUsgTaU
X-Received: by 2002:a17:903:8c3:b0:2c0:c14c:bf37 with SMTP id d9443c01a7336-2c1eb50a69bmr3034435ad.16.1780760367949;
        Sat, 06 Jun 2026 08:39:27 -0700 (PDT)
Received: from google.com (112.174.16.34.bc.googleusercontent.com. [34.16.174.112])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f6e2adsm135347905ad.5.2026.06.06.08.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 08:39:27 -0700 (PDT)
Date: Sat, 6 Jun 2026 15:39:22 +0000
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
Subject: Re: [PATCH v6 1/3] rust: net: add rust/kernel/net to NETWORKING
 [GENERAL]
Message-ID: <aiQ_KizsNCBFOGRZ@google.com>
References: <20260529-binder-netlink-v6-0-92dd74b6a32e@google.com>
 <20260529-binder-netlink-v6-1-92dd74b6a32e@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529-binder-netlink-v6-1-92dd74b6a32e@google.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lunn.ch,gmail.com,kernel.org,davemloft.net,google.com,redhat.com,garyguo.net,protonmail.com,umich.edu,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-296119-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D196864DD70

On Fri, May 29, 2026 at 01:28:38PM +0000, Alice Ryhl wrote:
> To ensure that networking code can be found in a single shared place,
> add it to the relevant NETWORKING entry. The net.rs file is moved into
> the net/ directory so that it's included under the MAINTAINERS entry
> without needing a separate rust/kernel/net.rs entry.
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---

Reviewed-by: Carlos Llamas <cmllamas@google.com>

