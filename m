Return-Path: <netdev+bounces-301179-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QHUPMot1OWoytgcAu9opvQ
	(envelope-from <netdev+bounces-301179-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 19:48:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B056B1967
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 19:48:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Q0f92W9A;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301179-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301179-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7ACCA303431B
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 17:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4DBE3403EF;
	Mon, 22 Jun 2026 17:48:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A05340A76
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 17:48:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782150510; cv=none; b=e3ia6Dk87CANgQDE354JCcWAxjHBwQWXXhuvkChObLI/0j8hQTWA59bflQUG56D8bX3eDgtS5q0DJkfho2gBaTe9AY8Ci0It8M1w2EGHVxOleCs2fNpyMAahhrk479MN/FzUu7zfdFOhkJ15PB990vM/ADfWzzGyeeKxTJQ2heo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782150510; c=relaxed/simple;
	bh=rT+UtKMtzGnsnjtDXBDLQP30MQk3djrKnOyWlXkyvIw=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=U+39+tMJLMkDpq64lr9AKBdg9rUUW8SOuK6aQdGrngyDeiNx6FnLfhyeDBPVc5j0YUMKiHM2XwS6jkBjp3AHzodm44Um7IdNA9XDfh0u2aj+wo/J+aIBMT3CJ7kZfZYAYmxfAjh5a+SOTPvytpAhXvmXPZhR/sLHVIJds5yQwe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q0f92W9A; arc=none smtp.client-ip=209.85.128.177
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-80260a90522so25312477b3.0
        for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 10:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782150508; x=1782755308; darn=vger.kernel.org;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=33veWonGavd+osVYaZO16Ido/MSdlOEETv1HhacB24U=;
        b=Q0f92W9AAVD8CyTlZPOOj6rGZXrm1afo90xqXd/BHWsbEW6084DAARrb18A/Uiv3mR
         3k/ki1DY49QLWFWy8bZ8QyUEr+miikmIAyUM2x3kGMwG2oGLE+r1Gx4UJpVl1d2oaQs2
         h5Vu5gq/TqZ/KWVv/PaRpOM+wtiSAFreC5D7x2YjQaErOxHbQYQRX0oaXHh/UiEadmEe
         RLP7VL7ZL+R+oz3Rc8fNu40bdCMo7s7eIvpFhBgCmP7L9g8ztSQdBabQ4e+DSZDF6/vy
         jBxD+1cREN6469Qx3TIm+0W9oG6/9EYkDK9id4i1WGzjrXAkd3AOPRnOrFv7nama0sAa
         PPgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782150508; x=1782755308;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=33veWonGavd+osVYaZO16Ido/MSdlOEETv1HhacB24U=;
        b=ZJznMEE+i2ie7ogL9vcISoCxPIt7cQRJnMSlGc6n7XQvoMz9Ztg/nDuRzFKhw8d5rd
         nrEmemQCLpdCRiWSxNKjgikhsS4SrwnvPblJeStSZVRJhBjoGvxpuuGFOPRJYelGlB2r
         zOK12LKUBmiO11lJjewzt3vh4/9PWlBb6QjRtbETvrYpzUjcMrONZ34zfN7hY/oa2nlq
         9ttOgLHRr9liP3uQJNHAuj2edwjPzFjNm1XAl86IWCmtU6IVvsPixJZHfhxPizu9ezPx
         Ua+AC45VozTTcF4k3KqRASp+xgivqzQZCFDK+SFsbcm+49897UOwRDeOxLn4yDGaS7T9
         cTqQ==
X-Gm-Message-State: AOJu0YyJrHv9hsTKYGg4xcutDS4fh8448GXNfSmq0Bm3+dBTUZ5woNBs
	EyawB+6hW1TWuGbCsbhp4t+vyaLUgss8YjzYMMgjUBTMB/SROVmsPWleCOyj5xXO
X-Gm-Gg: AfdE7ck/okG0kjDMmj/aw5PXKrjwH4Xq264cNpK2a7Xq2wsxafQSiowc+1Ssek8xtkQ
	TcAz6dk0BnyzMMUyfPZ4qRDdStA23cJ4nqcFoFqs/iuBQv8gMk7ilHroaTC786aMou9Tc+xWUFt
	KziF5FsG5kN2+j/3SjHms70Dmp6vgE7LLS+utG2GKNQDalGG3uRWSOTNHbFh29TZEirKsxhIRZZ
	WLIeJtDTEqF6kbufC4yu9r0dNz//TiP+rVVNxCO3Nq0gxOUTOBVxZIhZ1/loJ1YeLmYtROVMcC4
	jCt6hgOdiEauejZ03vRpkCGLrkalYWZeAZC2tZGeH/vmLv/9fWdmR8AJu1nsHZNnUlmpnUdCmap
	6ljGIrmDB2nRIfSYwqSnw9xT/83Vur7fWy6aZUJc82xfbKcseI1ssoV3OacJK1mlzVFVzPHEn7V
	UN3+5jlluaQwdEVha8bLD5yJN+wL9/XEfDhRdEcSdEFmERnhJrSrANQ5xSpJe9MHO4aDMy76K0J
	lZOkMugndBvi/c=
X-Received: by 2002:a05:690c:4b10:b0:7fe:bd7:9cae with SMTP id 00721157ae682-80178c4a2ecmr145514817b3.44.1782150508479;
        Mon, 22 Jun 2026 10:48:28 -0700 (PDT)
Received: from WIN6DK41G9CSL2 (c-73-56-149-95.hsd1.fl.comcast.net. [73.56.149.95])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8025f8da5fbsm34884557b3.30.2026.06.22.10.48.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jun 2026 10:48:28 -0700 (PDT)
From: "Brien Oberstein" <brienpub@gmail.com>
To: "'Stefano Garzarella'" <sgarzare@redhat.com>
Cc: <netdev@vger.kernel.org>,
	<regressions@lists.linux.dev>,
	<stable@vger.kernel.org>
References: <467b01dd017b$733792d0$59a6b870$@gmail.com> <ajkAlpiyPWmNPWfx@sgarzare-redhat> <618701dd023e$063de350$12b9a9f0$@gmail.com> <ajkmjgGdJp9Dj6em@sgarzare-redhat>
In-Reply-To: <ajkmjgGdJp9Dj6em@sgarzare-redhat>
Subject: RE: [REGRESSION 6.12.90 -> 6.12.94] vsock/virtio: large AF_VSOCK transfers reset under backpressure
Date: Mon, 22 Jun 2026 13:48:27 -0400
Message-ID: <672f01dd026f$54fa0600$feee1200$@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGzlm2Q3QdtCPSkkHXQpTkeFGbfJwIutksBAb+8QgECzm+rZbZnykdw
Content-Language: en-us
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-301179-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:sgarzare@redhat.com,m:netdev@vger.kernel.org,m:regressions@lists.linux.dev,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[brienpub@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2600:3c04:e001:36c::12fc:5321:from];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	RECEIVED_SPAMHAUS_PBL(0.00)[73.56.149.95:received];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brienpub@gmail.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[209.85.128.177:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.dev:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 35B056B1967

Hi Stefano,

Confirmed -- the 16 MB buffer fixes it: with socat owning the VSOCK-LISTEN
and SO_VM_SOCKETS_BUFFER_MAX_SIZE/SIZE at 16 MB, a 6.12.94 guest passed
21/21 large transfers (1.5 MB x12 through 8 MB); the same 1.5 MB payload
failed every time without it. So the per-socket workaround covers the
bridges whose listen I control, but not vsock services I can't
reconfigure, which stay broken on 6.12.94.

Agreed the old behaviour was buggy in its own right -- it was
over-allocating past the advertised buffer. The practical effect for me is
just that a config that worked on 6.12.90 no longer does on 6.12.94.

A question mainly for stable@: until the merging work lands, would an
interim be acceptable -- something that keeps ordinary small-packet
workloads under the limit without reopening the DoS? I don't have the
kernel-side expertise to judge what's safe there, but I'm glad to prepare
and test whatever interim you think is right, and to test the merging
patch when it's ready.

Thanks,
Brien

-----Original Message-----
From: Stefano Garzarella <sgarzare@redhat.com> 
Sent: Monday, June 22, 2026 8:22 AM
To: Brien Oberstein <brienpub@gmail.com>
Cc: netdev@vger.kernel.org; regressions@lists.linux.dev;
stable@vger.kernel.org
Subject: Re: [REGRESSION 6.12.90 -> 6.12.94] vsock/virtio: large AF_VSOCK
transfers reset under backpressure

On Mon, Jun 22, 2026 at 07:55:30AM -0400, Brien Oberstein wrote:
>Hi Stefano,
>
>Thanks, that matches what I'm seeing: large transfers reset mid-stream
>instead of the sender being throttled (reliable above ~1.5 MB, fine below
>~90 KB).
>
>The bind for me: it's not just this mail bridge -- I use AF_VSOCK for a few
>host/guest services, some of which open their own sockets, so the
per-socket
>buffer workaround can't cover them all. That leaves pinning 6.12.90 (losing
>the DoS fix and further kernel updates) as the only blanket option.

Okay, but in that case did it work?

>
>A few quick questions:
>
>1. Is a -stable backport of the merging fix likely, and roughly when?

We don't have a fix yet.

>2. Could a smaller interim land in -stable sooner (e.g. more default
>   headroom) without reopening the DoS?

What we've merged so far is the best we can do for now, but anyone who 
wants to help improve the situation is welcome to submit patches.

>3. Will the fix guarantee backpressure for any packet size, or just widen
>   the margin?

It should fix STREAM sockets for any packet size.
SEQPACKET/DGRAM is a bit different since we need to keep boundaries, so 
it will come later if needed.

>
>Happy to test any patch

THanks, I'll ask you to test.

>I have a solid reproducer and can turn it around
>in a day. I'll also file this as a tracked regression so it's not lost.

Unfortunately, it's always been partially broken, using more memory than 
specified, so I don't know if this is actually a full regression, but I 
understand.

Thanks,
Stefano



