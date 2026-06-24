Return-Path: <netdev+bounces-301790-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id koZFGHZTPGrgmggAu9opvQ
	(envelope-from <netdev+bounces-301790-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 00:00:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 551796C1A98
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 00:00:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=jTB9zJFc;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301790-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-301790-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 774D530148D2
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 21:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371E82C3768;
	Wed, 24 Jun 2026 21:59:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCF928D8D0
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 21:59:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782338394; cv=none; b=fBPtqLI83TEUuSH1a93ZWXFPI9qOqOmRiFHULlWkB/g1qmJf063VAoKnZsANdaKAghirARTJX5debouG7ZE/GsFphTYnWzfJoHNw+jLWKsADLC0Zaa2HH+5qGkuag+9BAsAv6S5LBls1ykuk99G6PK//IZn6R/qrxg/B65I2LGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782338394; c=relaxed/simple;
	bh=h+OydAedszTH445JQMgZ+upnFEvuyx0391pi32Sciiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hrCYfVEUYDyQLxm/dhebzkZnBABi34VRvThpICjqXguL4WRNc6mFJzPFr81GFvLt//Ay/oCaO9MQoxO7Gg+YdwwGlHfwM5qDj2pntp4wasjhJeXPwEGJZ96Gqa2eoaj0x6wUJ4Y4ctEyXP7Y7A/jnF1EVso7cRnJ4pqQdlYmWUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jTB9zJFc; arc=none smtp.client-ip=209.85.128.43
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4903d730b1fso16693005e9.2
        for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 14:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782338391; x=1782943191; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Uk4j+NCOVK1y3rM5ffoDmCbin5eAq9ei9VnnP9xZjK4=;
        b=jTB9zJFcCtPfHUo9WuDGukgRq0HU0joEIeNkO5lAytRp4zpmH4iCr3ZBiX6UCUKmm+
         wd0bhC9OzXrspxKW1xXRaFDkv7rcPHOVZ/ee7OKaPkMCPC+s4wsfx0diJSZxp6jnpnBF
         Xf1XI0qkAzpqgaKTwKEIEXsspLgyC6oXa7yfTPFqo8Q9u3xvWCiERFoMJ2pLXfIYUt4C
         kCKGmmjGcrHT5bvyN6x5s2KcJaBMO0kntN3uno14Qu2C6z3AcxtKWvSdA3jpLpwexITQ
         Djj8ccIIitk5JeV2Ul2PvjYAQDMHONfRoNvLpRaCjnXBHMEQ5snzj9L+fY/BvH0FtMWv
         lywQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782338391; x=1782943191;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uk4j+NCOVK1y3rM5ffoDmCbin5eAq9ei9VnnP9xZjK4=;
        b=hDdJFFXOgrl48oiQ+A487MkETWp7Vdj0lKqkOTE1V64Mk0pqRcTgp1pIEe7vWkR73f
         Ik79R8tRmSEVNwF+Nd+3IY+h0lWHBidhxqehigbWhKb+SSXev7UEpRuBWjdK4imH/P7p
         GqKR2QwSjW0sX9mCv3mqUV1bH/Wz9ENHU2O4YmhzyZIP4q/OREuzH9DrB/OWTq35Sewt
         Kdzx/w3w+vnwRK1bibOImHyIH8FM0JrM3T/1uFTAlZD1cbqZ+NPl+cYD73lP9YNSEFVA
         PQlZhNs8pFObxuRH3cjl8v8XlTSkyGdEfi8glTSVfDltg6iFpgJKx2HuefcpiKeoOlbK
         CgJA==
X-Forwarded-Encrypted: i=1; AFNElJ9yp0TnMpQ40F/Rezbym0i4cJBBYjBd/Hh+erlAXzV+CDOUA8Zm3reRpbAqsIFXiK3QwwImqak=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5ekamGpYYOTF6EUkjF0pUL2rJLn3+w5NtLQG+dC8e4rjXXmyV
	jHPn3srhpQqIL/F8e05Hyqf3ESuId0I7JZyqbR0JP+sQRHCocr82DL7r
X-Gm-Gg: AfdE7ckb2MI/mYWsrxCY+LVgpE0EKJ05SIZmOWX+2WPbKjL7xpAI4xlPcDeV8Z1PNer
	0DFdItQ2Yg2uYjHV38Frg1F8Grgjwh6KBbC3T6iI9jLfZrunPXZReNJrUGm6hLF1oJ4xdJsWSTQ
	idUZODMpZVN2hjec3040MqIwopW0HMkPyVcc86q8PMH2CK5lrfl0pJ2NpPdEU28Z9Ue6ccKNmKR
	azPgzWZ5MVmg1fzPPlxbOllaxrvV3SiKWDtBZ4B6O4DX1hyC3trLB3cQcb5f8OhwbefDbQi5YM5
	IJkLKUrbkFGNk/3kNjHR+20thai/rkCPP/KwtFMbdbV1WL9RfTNRPucrDUcb8XtiNmVZWLSzeCg
	3k96zlvD7zw0sQr0GfClDyHYcjW5nLR/JRIjyxJ44wtGuM91LkVLwPddJDXM8eo1mEZBBduYDk3
	+pQVEQjtXnxBDF/hjeaSRFWxR2CEkIsFmAUDH8pEjfScqT2WRyoQCrJZk9yBp/AHrLvnxpqW3Dl
	w2U9CBlpizRakWlCir2pmcSJJXrN1bRypiIq2VsEx6mEdv2qD3WIdhOwgmB5/7W/8Ynf3LtX6pp
	MRgVbTz8/PYKcVQDc1o6wMDcaq1TSBGx72qw/LSS7UY=
X-Received: by 2002:a05:600c:5491:b0:490:bd1d:4732 with SMTP id 5b1f17b1804b1-4926087361fmr76202125e9.23.1782338391110;
        Wed, 24 Jun 2026 14:59:51 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e0046ffccb749d01d87.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:46ff:ccb7:49d0:1d87])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46c221d9405sm11485640f8f.22.2026.06.24.14.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 14:59:50 -0700 (PDT)
Date: Wed, 24 Jun 2026 23:59:47 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Jordan Rife <jordan@jrife.io>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Jiayuan Chen <jiayuan.chen@linux.dev>
Subject: Re: [PATCH v2 bpf-next 2/2] selftests/bpf: Add tests for
 bpf_redirect_peer with BPF_F_EGRESS
Message-ID: <ajxTUx8eLYM2erU4@mail.gmail.com>
References: <20260618182035.43811-1-jordan@jrife.io>
 <20260618182035.43811-3-jordan@jrife.io>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260618182035.43811-3-jordan@jrife.io>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301790-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jordan@jrife.io,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:martin.lau@linux.dev,m:sdf@fomichev.me,m:jiayuan.chen@linux.dev,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[paulchaignon@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paulchaignon@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,jrife.io:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 551796C1A98

On Thu, Jun 18, 2026 at 11:20:33AM -0700, Jordan Rife wrote:
> Extend redirect tests to cover bpf_redirect_peer(BPF_F_EGRESS). SRC
> redirects to DST using bpf_redirect_peer(BPF_F_EGRESS) then traffic is
> hairpinned into DST using bpf_redirect.
> 
> Signed-off-by: Jordan Rife <jordan@jrife.io>

Acked-by: Paul Chaignon <paul.chaignon@gmail.com>


