Return-Path: <netdev+bounces-269057-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iAHlBJG/umkGbgIAu9opvQ
	(envelope-from <netdev+bounces-269057-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 16:06:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BDCD2BDD9F
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 16:06:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 762B1307AFDB
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 15:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3832B3DFC6E;
	Wed, 18 Mar 2026 15:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L3+P9n0z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4463D6684
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 14:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773846002; cv=none; b=BgTq7W4LLBiDvqEKAauhOPF8w3hvL2QiTx2NJXGBitD5mvgdzFmGQu03K3qWvxQq+Q01wPJg+qpnUN4hUrTDYGOhDed1oO8J2mC0i3vtJMUgh3W735AafwNUrnRXpM5QC2WNyh61P+6UCY5XMrguS8OPK5IlPqnhi9Q8oiWzT1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773846002; c=relaxed/simple;
	bh=bEBit3v/3EaAeXPIrEhvLJqSi6H/H8xXCeELyouAkUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cFnVfDEeHMZf9yD7+XVPKB536Ef7Qo4QX+/VklozIx7c0+fIOOt8PhCMXyoLTmZmkcIxA6+eYoGed77gmblgOR6QleH5/s/AxSCxOiBOqtedWUIGX4bx0g1dZomR00LebNGapZnU+1wOZNRCMrFHR7PRUbjjt7Rbx86hFCoNRLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L3+P9n0z; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2b6b0500e06so8339245eec.1
        for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 07:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773845999; x=1774450799; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GnznBYtreFWiJHMzmWhLo1aMVcwsFyxP3+fWvwEHCV8=;
        b=L3+P9n0zXI//cQ4O8pD4tXKfXA9JJZViwEaz858VcWyAtkmPOPJ1pqP2YR7Y0oZxJn
         g4869r/W9sg9XydsDfbUKDrlgveO8J+xFVDR/w9vdh0p6Qs9vDV9LQItLKx5yPWKhR1K
         cFcLLath8FwNc4Mlk22IJfXScbvW4ghiVIC8bn2Ii51mF3L1c5E2kUKgNrrCxIXMHRb9
         Am7YnncgNsLNa0etUwOVxZSP4wpG+sDRmGX7p+aYo277p9qvCsa6YgpxoFv2+RQ/YJG6
         UVWLQreP+I5Fv1Ma3x9J0YfV3oTzlI5cczqSZ4/GW9oIb7tYBTQWhtcb5A+C2vA/Wy4f
         /cTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773845999; x=1774450799;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GnznBYtreFWiJHMzmWhLo1aMVcwsFyxP3+fWvwEHCV8=;
        b=qLQBE2RpBNRAQFx7VprpXIbWQ9SstH4ywFAGkGt8HGdVDnsZVR+YOVr9nYg4Edv5be
         aFjNRcQDWmLYCRPTxzH33uRLYuShmy8MFyKK8VQiKTx88DcfTMRfOeK6xHwEPgvXO3Ep
         h1bMh608LuxE1uwHJI5Kv6BrmoE4+QDYeNhpo2gIgHjN8zE4rdEF+NCn41/gwujHcV/Q
         iEixcbAQ+AXzG6oewfzUZtRNyqMV/JV+jvsYGPhgg/ilil0z9GwIa3YbFCsL4t4LAFFv
         P++pw6a6t8Mlb+VsNyWSLE9CyvF04JKUvtKLxYIEj81VQBMct2Pwrr8FvdVNaZz0xlo0
         kUFA==
X-Forwarded-Encrypted: i=1; AJvYcCVS/vF82TZAAQ7frA1r3OUlw/hqrWvY4oLig08FPgLsTecwPhgsRN7sB8YdC34q0KKMFbWkM0M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK0UjD5gtUbWZpLDffsZvjHF2N/nnAmaaHDRJ7BdqlEvb0MWbb
	X/wbCeLip140QpoNmBd17luL1jDyhOo+aavV/rWVn5KuvHR9qcRGjch0EnpH
X-Gm-Gg: ATEYQzz5mzG7tGzcT+Wnjo11qa1ZdNyxKqjdMDycr/sPhGM3v2U0LuBTi1dnH2KoJ7x
	d/OuhwAZID34EsSYK6cW1y6bzoZ5k6AlC15GuFbPowUayAtABZjWkohThb+BhOIzdsr+HnSmw/M
	DQsZZpXiPih9IbRcNPwffhyqLztn8aAz25kvek8nR3kJ1GLkryKFNLu/LKapsheO/+f63yDxBRg
	50RODF4qc1Nambn5hqyYRSf8n0gDGceKz64b/nN+hsEDJTXHKS1Q3xqIDPu1aiqIxQrJj2YRINV
	lS1Xbc+ANtq7MHhRMZyDmfXxqJQSCgJIHM/4+OF3cVeUx9mS/2aVxNtqBHggSexkpcgem9T7cmA
	wwWcOV3rTyP0YDTHp0MFjlkuS55SKpUCwPso6804zD99szHUWTZrEltg4LK5/Ay0dpPu4llAERN
	l6cGAx0gIT0ULZ88BAx5dZ65n+SscG1JapST7XaZxnvUAd/AU66mrIEabiySFbZty/YAX2lVvUD
	EGaDJnek/T21roHKw==
X-Received: by 2002:a05:7300:ec18:b0:2c0:c415:cfd6 with SMTP id 5a478bee46e88-2c0e50a0a8dmr1648662eec.13.1773845998562;
        Wed, 18 Mar 2026 07:59:58 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c0e55a489bsm4388531eec.23.2026.03.18.07.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 07:59:58 -0700 (PDT)
Date: Wed, 18 Mar 2026 07:59:57 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Mina Almasry <almasrymina@google.com>, Wei Wang <weibunny@fb.com>,
	David Wei <dw@davidwei.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	bpf@vger.kernel.org, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next 5/6] selftests: drv-net: add netkit devmem RX
 test
Message-ID: <abq97UD7CHR7bdod@mini-arch>
References: <20260316-scratch-bobbyeshleman-tcp-dm-netkit5-v1-0-b53c8cd72b23@meta.com>
 <20260316-scratch-bobbyeshleman-tcp-dm-netkit5-v1-5-b53c8cd72b23@meta.com>
 <abns9COj7WagFtZ8@mini-arch>
 <abn3rJGXXyDYSNzA@devvm11784.nha0.facebook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <abn3rJGXXyDYSNzA@devvm11784.nha0.facebook.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269057-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stfomichev@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.929];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,meta.com:email]
X-Rspamd-Queue-Id: 7BDCD2BDD9F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 03/17, Bobby Eshleman wrote:
> On Tue, Mar 17, 2026 at 05:08:20PM -0700, Stanislav Fomichev wrote:
> > On 03/16, Bobby Eshleman wrote:
> > > From: Bobby Eshleman <bobbyeshleman@meta.com>
> > > 
> > > Add tests for devmem RX over a netkit device with a leased queue. This
> > > is the same as the other devmem RX test except for ncdevmem executes in
> > > a namespace, binds to a netkit, and skips the ethtool NIC configuration
> > > steps (relying on the test runner for that setup).
> > > 
> > > The RX path is setup as the following:
> > > 
> > >  RX Path
> > >  -------
> > > 
> > >  Remote            Physical NIC          Netkit Host        Netkit Guest (netns)
> > >    |                    |                     |                    |
> > >    |--- TCP send ------>|                     |                    |
> > >                         |-------------------->|                    |
> > >                       dmabuf                  |--- BPF redirect -->|
> > > 
> > 
> > Is it too messy to parametrize the existing test to run both with and
> > without the namespaces? Feels like should be somewhat doable in python?
> 
> IIUC, we could have main() do something like:
> 
> for env [NetDrvContEnv, NetDrvEpEnv]:
>     with env as cfg:
>         [...]
>         ksft_run(tests, args=(cfg,))
> 
> 
> And then the tests could call helpers that check cfg.netns to use the
> nk_{guest,host}_ip6 addresses when true, otherwise use the regular
> addresses?
> 
> It should be doable if I'm following your drift.

Yeah, yeah, this plus some small changes here and there (to pass your
new -n in the netns mode for example).

