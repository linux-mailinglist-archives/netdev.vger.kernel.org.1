Return-Path: <netdev+bounces-278689-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MD47EFxG32nzRAAAu9opvQ
	(envelope-from <netdev+bounces-278689-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 10:03:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DB390401A85
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 10:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF61930CFC78
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 07:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5361F3B7751;
	Wed, 15 Apr 2026 07:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iNAaI6x2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A1F3A5E72
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 07:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776239968; cv=none; b=nritzo0jtqXryc8wWjDRn7KClH0m9AlMvrPDX4AdTIFwf1d8FmP6ml2bYx0ZvWC+5hP+jZ8v6QaPIVg73XXZVjCOWLf2mPyAdMEA6Scy9iVCIPNFHpZVwWR5/K9VzBDs5wRli7eS8ylfZB6ryJQ1uGF6rAnuevzVH9nt/7LmCbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776239968; c=relaxed/simple;
	bh=v4txLFrjF8x+4vhEHg9wpHXC7HaZVp8pc1Zv6dPSMoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HY56ucu55od6OhfgltpvUNga+ksoPimQ1HxWQ4c+FxColi5iMqWqxx7UUS8csWrcmrqRKu/5OPZk96FZagWSegbExIxVSo+s9+hrldkvsSkm4uundSYVGMZA6FsVgqgTfSZuUUSzSyBOpU1eqru5SQdlDzcMSlwISlZtTlQZU4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iNAaI6x2; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43cfd1f9fd1so4132734f8f.3
        for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 00:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776239964; x=1776844764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fnGUNqAPhun2LmWwo++iWXcTG1XwZ7/9oz20GAfV1pE=;
        b=iNAaI6x2O2Q2sQ6cBd+EgthxSPzePJ4VMMIbt//6SVP06nN7PFtF0nLkXyEEM4tS8M
         wwcfAP/y0OZXX5TAnrqJmKRy5wkQGI7JLSHkz/8G5+HaH8bBIRfDmzMYO7ly9TnxUULP
         UTMVQ2kjylYfcyHkGBXk9fpIZEQkZhvHNw4jh7l/4sl6+37RsYDM7YkSGm6aWfqnxy0l
         YCTge2axoOKL3yeqTfGfAGg2ZNNeE1cRZmAxMjiwyVZ232xhM1+m1VmfX/1LpEFxiube
         oP3KMWTLuia2iEPzZk5+k9Oyij35EGQuNXuoIlAtkRRyg4Sm36r7XTMgZAq16DCwFi8H
         RcYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776239964; x=1776844764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fnGUNqAPhun2LmWwo++iWXcTG1XwZ7/9oz20GAfV1pE=;
        b=psvTW771BxIFgv9VU36QiECd4I/qG+Ohl+d/Y8bMwRvpCq8nXv7oFcPNidL3pwt619
         tyWcIChFbNEr5Qy1PxQrzYe9EKtXYttKmM89nRbFX12t/EOrA6Olf8au4Y0O3piy1L8k
         ES3dN/I4kQ651ZsHw5cPWmUsWBWk5QcQ4Wbw8ZO96snGIhHRCfl2xbm45nrcwEVt7qgl
         tKJOSCBd3IjMikOTWgP4OY2CT7cRuBOPDhU1A+IRSu7NIix767i6LYoncTNf1LZNXhW9
         6A2bxIBbZdX3dE6xj/Fx/hB9fiMuRtIb/mwP2eFn4eTjJ4J0qbHNfYcjMXuxIVRPrlwR
         AGFg==
X-Gm-Message-State: AOJu0YxuBCbyDIXM2e0c3yuVAWQrj/SOZg5qG0YKLeGT/gjRuByYRMaP
	gGLBrJ5NbJwfIXC7zpq5VIrNNDEH0z/HvZ9r+SiobiG0Flps3VpvTBxm
X-Gm-Gg: AeBDieseGNgXfMk4qOXtxbIey8/69PwDo6ntUJ5FvpHr/2VckE4KK+oV9NzIIoCZo1B
	DVowrc0YhExYhrYXd/NEVPbbkRzWSwJIT8GsXzIUDYONBUDUXEJVI4ycokcLKerd8SHc7/A4P4K
	CD9njqp9F4TXwugd1EX3GV1Ic+6lvgIkOFWuVwiJDuW8JgulspwcS7Q8CAL1r7qdcJ6+y/3NCxK
	GdDcY3Tej97MXc21U+U8Rece5qdyIUQfENYH+6zsQVl+56hgw2v+CDUS3QAGETWxHiB2wLGhBtB
	6NmGJoMQ0widX26p8nPCssQhwtzD7JuCZ8yf/iugejcSqdCuVK6xQBQ2tPPpyFT/yFnwKc+eH0w
	kPmvHcKLbilsL+kyKSDmGvKK1mDwJhAnxvmUSReLoe0VSFMbkPC3ckQFEY8olTalK3ThGCfQIaP
	WThK+ptPtRMOI9xyO7t9YwNPH4PV6tCFRh3mVE3faeEPgnr5tNrUxG9NwRyMDqo4nB
X-Received: by 2002:a05:6000:22c6:b0:43d:7e11:1b72 with SMTP id ffacd0b85a97d-43d7e111c1emr12453323f8f.9.1776239963143;
        Wed, 15 Apr 2026 00:59:23 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead3ebaf1sm2843108f8f.33.2026.04.15.00.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 00:59:22 -0700 (PDT)
Date: Wed, 15 Apr 2026 08:59:21 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Ashutosh Desai <ashutoshdesai993@gmail.com>
Cc: netdev@vger.kernel.org, linux-hams@vger.kernel.org, jreuter@yaina.de,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 net] ax25: fix OOB read after address header strip in
 ax25_rcv()
Message-ID: <20260415085921.757b48a0@pumpkin>
In-Reply-To: <20260415063654.3831353-1-ashutoshdesai993@gmail.com>
References: <20260415063654.3831353-1-ashutoshdesai993@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278689-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DB390401A85
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 15 Apr 2026 06:36:54 +0000
Ashutosh Desai <ashutoshdesai993@gmail.com> wrote:

> A remote station can send a crafted KISS frame that is just long enough
> to pass ax25_addr_parse() (minimum 14 address bytes) but carries no
> control or PID bytes. After ax25_kiss_rcv() strips the KISS framing
> byte and ax25_rcv() strips the address header with skb_pull(), skb->len
> drops to zero. The subsequent reads of skb->data[0] (control byte) and
> skb->data[1] (PID byte) are then out of bounds, which can crash the
> kernel or leak heap memory to a remote attacker.
> 
> Use pskb_may_pull(skb, 2) after the skb_pull() to ensure both bytes
> are in the linear area before reading them. Discard malformed frames
> that carry no control/PID pair.

Is it just worth linearising the skb on entry to all this code?
I believe all the frames are relatively short and low frequency.
So the actual overhead is insignificant, but it makes all the sanity
checks trivial.
It is even likely (hand waving) that the extra copy for non-linear data
is faster than all the checks for non-linear data.

	David


