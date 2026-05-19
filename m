Return-Path: <netdev+bounces-289589-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OAVPFLq3DGqmlQUAu9opvQ
	(envelope-from <netdev+bounces-289589-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 21:19:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D40358419F
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 21:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4FEAA3008D32
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 19:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56BC33ACA7E;
	Tue, 19 May 2026 19:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="asH1tmpu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB2E377017
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 19:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779218357; cv=pass; b=s2nKNbYemKfnEmjgSZcbnH8OtiP/6GxJ44PzwvAg2Y8o21zdvu6Plx4xKPuFRK6eBPrEaIl5O6BOnstE1sAl8WpCdLEBtP/2SWC5Kp06eNDHSyFnV8q8JQA6bmOt7kZrokg3/5tersMPs1qmTd0iSPtMfgmgkWlztYMYkoV6k4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779218357; c=relaxed/simple;
	bh=jYqz98ubw3WV0foWgcnHBs/x8R9g1tkeUZNdNPIzuko=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=al3uT2bUyuJMSQZJVpXOu3umgUThDqtE4iVL9ry2cVgJ0L6jeREH5Sq9w2/Hm6kjSsF94Dn98VdqOow506ZLz0Dpqg35G9TcLr97cJICCYcpbo+i7ACJ6fSudLVR0cyYJRSKP2EJtptzr2imeRtRwRMsirCFG8JVSv1VTlD930Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=asH1tmpu; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-67c1eea6b4dso319a12.1
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 12:19:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779218354; cv=none;
        d=google.com; s=arc-20240605;
        b=YVMeB/vkkVI2/+26ZJ9WOlN3OXmz5HXkH5S07vFXi7yCOHpCHD6bCbGJQuNE088Czi
         PvlBEFueMj1sJ+31SzUi4F/Mr43POaUb+6RaZJqQOW6Qqcc7KPaecVhCdC5iAO6El3zD
         LJg3dJ9JkjxT0qzgHg4TI9uqX2+tGPoieOUkER1GSIeJFSs7BMQPLprLnXtfjy/UtIjL
         GAuXxXbFbxouKNAbxkZ6dwQ5lC7GvgKdm2lms+u9JEMWN5nyzop6MXvDeP+/oY72JuxD
         ABkikHYAPmRa8sQ27DqsC7g/4HTswp++YUcuy7Bjj/8gVYJGRVUfRmbTKDxDiSScXu+z
         Jxag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=jYqz98ubw3WV0foWgcnHBs/x8R9g1tkeUZNdNPIzuko=;
        fh=zlRi6wUJ9/bX0J40Ibi78tx7izaNTCdQY+HKKol8k3s=;
        b=WizntmwW+0jGisO3cOANdyhhNYuR7cqGPMoXzQ2ljasMgmsH2cosC6WB9yskpN3ZXc
         YIPMuNJK3opoSym/53nGNFFByRkkqGsnBA63asSzFhqMhdw9VSnDsttXJL6f3Ubun+fo
         LBddibGa7btcYr8UzXhefDxBYJaqkockFskCs7VnEbHN/UbqNRF4fuPpGIweUie3lHvj
         gFBapajMRlc+oafHdKkkDtKzWOJJZFd0ch296QsZ3urxF1HUuj6jiGtImrkDLTU1oA0s
         HTePG9Rkh+isxX3+8yAinYcQnZ/ls2Y/SPI026dNbnxUYkAdWazR8x3fGp1qhCx1E0eQ
         pFCw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779218354; x=1779823154; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jYqz98ubw3WV0foWgcnHBs/x8R9g1tkeUZNdNPIzuko=;
        b=asH1tmpups57VJpaHZMmwrdzGrgkW0SNM23mdQLQ9Ttc07kMwZhzFo1ffRVhOrawM9
         ckoqQmhN2PFrhU0UPQwR7It5iuxwDizvKzdxkKytN1PhE6OoFdXaA2qk0FrS+4ySWzHx
         UuUEOEwuXaLDL2U4G5vjE+bBhbIQofKpO4WvTPw7aWZnWvuOOgRIwejeUUWMpbY5V0e5
         e7emd2RXCDpmWE3K+bCYDzK6RdcJrPKVCFdCjtukN25m/TU0VKeXaW7GuEwl0RIQOTsP
         JYxmbLMrbx4K8C6jHGXxe3B/cAkdqnNO434Y3ghjp5BCWEHz6QuNEjpEnaGD9cVaHFdT
         dkqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779218354; x=1779823154;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jYqz98ubw3WV0foWgcnHBs/x8R9g1tkeUZNdNPIzuko=;
        b=Ge5CBgIc49WUTfKu7eOamMCkPm5AM5Rlt8IcJ8se8aOCW9oocTJYo2I/WRTk580EUP
         UJpGbB43EhEONvkeWno93loEcfhJvmXe1Z0C7on2RUAZ5h0ObEA3RxV9qnJqfmzDIQQR
         2z1ZgeLgh/4B3uMjOXB0/b2Q8sL/JdysYAYmEqwOAi4IA4x+10lCNamf0A/OTHqdAjmP
         /1c5oLZbi2IyGmmy3r7+f1YkaHtQPvI3l/6lwmYMu5uGz7ePJTyjygPbkDaFDrdx1noW
         2nwFw1Q+zDgTUFGQfFvSs1lrU/4QbmJMdJ/+zub2c4NLhU0g+sCiS5+bz9LmxkwFL650
         iLBw==
X-Gm-Message-State: AOJu0YycXwTR6L3HgYN8CJ+BKDRAiA5g7j1kG5+PPyPNmmeNVahZF7cV
	/CNbasWkURdJVAalQ/z+x4WmD2yw7+m+AadOW76uuYt4p79VQVVGx4NxyiSVdF55MYuf0dT/DUI
	5F7xwrHaIAyAUH1Ub3WNoN/+2g7I+dBsqlpP2rn+Qow8uwS9Fxk8O4xqsf4Q=
X-Gm-Gg: Acq92OE7z6B11ORYzbisgQeQq/VsPUvgCaQBVWvpv0gXXMCXQv5zKWafmKJT9HCLRlj
	/+dkl7slzeSD5VGgXdDyKuouMvfjyDxeHorWE/S9DuWkoSWwV6ER0ebKuglbt/htaPVkK1vtNad
	GsufSSqB/oIa1VUX1ztMgnvhQ3HuTdUWYthNU51kGD9h0c0BT1WZYFMjhJovAke6dXxWKvxGvdP
	wkPz3hlJcVkPPvq0jxZVpvTC8fWyUe5BLMo9Styb/T7aNsRyhk7roEP+XdNMhEezMb8M53hQCB1
	XPbDhYA6M2TrXxiioE2ncYKoBH6on2kHqfDcnatrPjjEJiCX
X-Received: by 2002:a05:6402:104a:b0:670:9e9f:1a5e with SMTP id
 4fb4d7f45d1cf-684891b6cb0mr173665a12.2.1779218353816; Tue, 19 May 2026
 12:19:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jann Horn <jannh@google.com>
Date: Tue, 19 May 2026 21:18:37 +0200
X-Gm-Features: AVHnY4IqTfx8C9zgLr9odPC6ok-q4vV_LLekYiqisk-ssm3TXL2pmOtpHKe_o_g
Message-ID: <CAG48ez2++gA+Z9GVmNOG5-+NNicjmti3nQ8xhVJuXM042WfwZg@mail.gmail.com>
Subject: [RFC] hardening/fuzzing project idea: KASAN redzone before skb_shared_info
To: Network Development <netdev@vger.kernel.org>, linux-hardening@vger.kernel.org, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, kasan-dev <kasan-dev@googlegroups.com>, 
	kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289589-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com,google.com,arm.com,googlegroups.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jannh@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 5D40358419F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The following is not something I'm planning to work on in the near
future, but I think this would be helpful to allow fuzzers to more
easily detect OOB access bugs in the networking subsystem - maybe
someone else is interested in working on this?

As described in https://docs.kernel.org/networking/skbuff.html , in
the networking subsystem, SKB head buffers are stored with a "struct
skb_shared_info" at the end. This means that out-of-bounds accesses to
SKB data in the head buffer can't be detected by KASAN unless they go
far enough out of bounds to go beyond the skb_shared_info.

For debugging/fuzzing, it might be useful to have a KASAN redzone
somewhere between legitimate data in an SKB and skb_shared_info
metadata, accesses into which would cause KASAN splats. Maybe we could
split sk_buff::end into two separate members for "end of tailroom" and
"start of skb_shared_info" so that a redzone can be placed in between?
Or let debug builds store the skb_shared_info in a separate memory
allocation?

(We could also try to go further and KASAN-poison the headroom and
tailroom until they're actually used, but that might require an
annoying amount of refactoring of existing code, so probably not great
as an initial goal.)

