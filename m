Return-Path: <netdev+bounces-293823-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MInXKMyuHWondAkAu9opvQ
	(envelope-from <netdev+bounces-293823-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 18:09:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D9A462252A
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 18:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 16B68316A369
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 15:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD363BF685;
	Mon,  1 Jun 2026 15:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UIfVywfJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FE83DB62E
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 15:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780329432; cv=none; b=OaXEj/xmQ9bJoPwVgd/bZZF8zbAHKWUbXDXHFmDmuoyb+YniQMgXa8F7LnZcWoPg7S0l16L4it72rgMKgxVvOsfanBsLfXUUsV3mul5GMtHoQSyLfk49/Z3q4JuNB2G+nTWT6/Wk61irp3ss/WACmBAFWbbnbrawLp/42EZvhS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780329432; c=relaxed/simple;
	bh=nTXW1aszJ7vJwM4JLdG9/UwnGyXjFaGyj9QAS58OX2Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jy4LL8ZqdexbY/yxa/S0+FGx/PcIv5lCWm+V4gYX3fglKen/LF3LuVEky88RgE/2mIci7b0habmsuPsF1nA6Bi6y7GbzN+CPUKd2U7WlGz8/MknTNxTPK/gJUlb0wVNERFDYxd8vFJ7CqegS1IStdFKuDhFjowj+7MwifXZwp1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=UIfVywfJ; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-68c19f1f3ceso4817422a12.2
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 08:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1780329429; x=1780934229; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pJkQdYMeeClMSzcCqfeyFg/QAKx7SzNPdhAZ0oh+sp4=;
        b=UIfVywfJiXhjNEFbItMwdW1y/GWy0Qh+MQHs/CbK5bk5sCDg1vAVuOjtxuI9FTu3Ng
         YaHtun4HypTx6/SFDIrOqabyL9AQXs2nMP4VFHfHLbHvuPaRhiIAteMfCnD3FGoT/P6F
         NG87CzMNH3RtI+rXxlEUVEfJyTFS1mv1STk9w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780329429; x=1780934229;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pJkQdYMeeClMSzcCqfeyFg/QAKx7SzNPdhAZ0oh+sp4=;
        b=Cden3DL9xN5W+8NDybUVN6/auuMHlsY/9qtJELg/rmE5Jmtzo6UL4GRIjUUYVSEj+T
         HE7cKLOhkMbO/2JOaTDNTjPJPQp/401hqB95OELstFnSwmrN81xfuom9sJQSRaP9f74I
         odhnxKRPwP9SRJUP+O3GIJq0EpRowaSbTK8lDRih9hWf/rARi2d0E55+h7/v4gArg7KM
         uwnO2RCqsikPL5apnB3J5p4xdptCUekBbCV9hWG285l+ZTg651q7kWl5osEDoIFqjvM0
         0H/nlJXPomBwbOiWs3QBZdAMwZNFCkAJk1nHBBHF4HHTh3e7nBHliNScQ9z/q5P3I5du
         7lEQ==
X-Forwarded-Encrypted: i=1; AFNElJ+IrS2m20uE05at97kHh7lnmu86wCOAN6m7i/G6csOzLxnYkdDAcSLld+rELr9ap0brUOHpWYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+2JM5vjxglw7GjVvZsL0xF8ftZSOYMsR4VAAYFmFsyzRPcTVS
	TPn1xv8Ga0b7hN//UMC5KtLcLp96ins73usAMFffC4VmInKlBm7HZey/bQF/ntR2xFb37xGuMe8
	9OfshT4k=
X-Gm-Gg: Acq92OG6tpjnxsP6eVWRqhI+x0iqTMp0+HALVkGmbC36jAW60vLndQlBm28ahvE6PNb
	VOYkJPWYhpwEAm0rlgW+P4+UjxP6dBWaj6WQtVLyIscrAOgH/dZJqckjxXQFOnYE/tivaN8H/+g
	2iqrOR5jBCHjoCngVM7FMdKDBGicLPLYWB1rbOlsovglaN8smLDh6RB/QT0r0MaXQ3f9EswA48W
	BLLYk262a8tc8ytkyR6Ldn4NRK1CszC1h8OqjCeZBHvERFivT2TG4SmU7iVyzUpCf8DpPxmGFes
	coXDCTDFlOy9fZbCbKAtKydnAfUChFYkAeVcmBtRnnXtTWF3iyEU+N5OM5H4YJ65AXDwFQHtOpD
	eIXlmY4eG5pSymvfjNEaQIfZKupP2YFTsXlDA5KEAx3Cz2K/sLdLapkigRDnkrB16+rLJuGp71k
	zTIQEqFiXDEtLw6J0loAQ1PIk4JZaYawWbQWiy0x6Zq8WFdRDK7I+F+892FMuPGrlS4KvkVI5jP
	wjhpEzxqeg=
X-Received: by 2002:a17:906:eec8:b0:bd8:1537:d63f with SMTP id a640c23a62f3a-beab1d8a779mr711507866b.37.1780329429115;
        Mon, 01 Jun 2026 08:57:09 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-beb4356b901sm238846266b.9.2026.06.01.08.57.08
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2026 08:57:08 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-bebac79fff8so184364966b.0
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 08:57:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8Yl4JsRmbNm4OqjtbERzx8/rxSAnYTuEkLRR72aB6nqVDBQxGuK3P53nYP1BqEUy9QMt1idy4=@vger.kernel.org
X-Received: by 2002:a17:906:2929:b0:bec:203f:7466 with SMTP id
 a640c23a62f3a-bec203f7742mr316403166b.8.1780329017245; Mon, 01 Jun 2026
 08:50:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260531010107.1953702-1-safinaskar@gmail.com>
 <CALCETrW__=8mSusayfXG7UFCfue5BGbx+vqESj1d9wqOfX4s8w@mail.gmail.com> <ah2nBAdsE5vVJ2PL@casper.infradead.org>
In-Reply-To: <ah2nBAdsE5vVJ2PL@casper.infradead.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 1 Jun 2026 08:50:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiFuud0Nn3B9YpTWyQja08TeXVk2AB-aAkmVXyigOagbQ@mail.gmail.com>
X-Gm-Features: AVHnY4JDfRzuLw7CK_4gSBHmXbq5FWvfpfspaVnl7J1jkuJC1SncFOzqHbctZiE
Message-ID: <CAHk-=wiFuud0Nn3B9YpTWyQja08TeXVk2AB-aAkmVXyigOagbQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
To: Matthew Wilcox <willy@infradead.org>
Cc: Andy Lutomirski <luto@amacapital.net>, Askar Safin <safinaskar@gmail.com>, 
	linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-api@vger.kernel.org, netdev@vger.kernel.org, 
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>, David Howells <dhowells@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Pedro Falcato <pfalcato@suse.de>, Miklos Szeredi <miklos@szeredi.hu>, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293823-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[amacapital.net,gmail.com,vger.kernel.org,kernel.org,zeniv.linux.org.uk,suse.cz,kvack.org,kernel.dk,infradead.org,redhat.com,linux-foundation.org,suse.de,szeredi.hu,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[torvalds@linux-foundation.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux-foundation.org:dkim]
X-Rspamd-Queue-Id: 0D9A462252A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 1 Jun 2026 at 08:36, Matthew Wilcox <willy@infradead.org> wrote:
>
> Can we review this series properly?

Well, since it pretty much is what I suggested a few years ago, I
certainly won't NAK it.

And the patches looked very straightforward to me. Just the final
diffstat is worth quoting again because that certainly doesn't look
problematic:

  7 files changed, 33 insertions(+), 204 deletions(-)

and it removes that GIFT flag that was truly disgusting.

So I'm certainly ok with it from a "looking at the patch" standpoint.
I didn't _test_ it. I don't have any workload that might remotely
care.

I did a quick scan on debian code search for vmsplice, and after ten
pages of entries that weren't actually *using* it but had lists of
system calls, I grew bored. So there are likely users, but I don't
know what they are and how much they care. It *might* be a big
performance issue somewhere. Unlikely, but...

         Linus

