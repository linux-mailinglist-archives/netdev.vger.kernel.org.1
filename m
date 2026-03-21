Return-Path: <netdev+bounces-270253-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oI/oNyP7vmlknQMAu9opvQ
	(envelope-from <netdev+bounces-270253-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 21:10:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A58A2E71E6
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 21:10:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B03C630177AB
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 20:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D5136AB7C;
	Sat, 21 Mar 2026 20:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="eeSlKGU6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F8C33F5A6
	for <netdev@vger.kernel.org>; Sat, 21 Mar 2026 20:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774123806; cv=none; b=MS4EiI3vcf98hdPiAfhLqj0CeOv9uqhj0x6SO6SnXWTUuGJ+zpcc7FbpmuwxyMIgqBvOBl8kXVRQnF5/25BzWuNZcU3vWVEDUSP0aWY8ozK5yFMCYWqXYOggLhMTwSw2JRCkhOeAKNtiBr+Ug+xbCo9A55Qd1migIkuigwaFzH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774123806; c=relaxed/simple;
	bh=E6YZjKGXl0vQfGteXdj0Drrnp5o0VeuQbS+OxjmHhlg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o57ZGCqUZ1NwHHZ97DAxaknwQSEacuKIa1pRVaiOIQyphw3ikXYdWmm1CKBUawjRKnc7sbFmElapQgFX2XyeZEsFj4pIPz2ir/uHibO8JuWZyGHMx1qYNwxpP0TddJDMwS776TrGrFTgUnaB49HcKBFJ8pDABk4f/q+7nO3HPdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=eeSlKGU6; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6674cba2c50so5725956a12.0
        for <netdev@vger.kernel.org>; Sat, 21 Mar 2026 13:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1774123803; x=1774728603; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+GwK8Xw0ld/TS+qhy108IyjO9LdanTTp1MLkg1Ue/FM=;
        b=eeSlKGU6vTmByJGHFQ8z3l6i3I/tcfoVnroaqmiJWIGVAWbQ1ezPKv/0mDyip6+Vwn
         eO1L9Y6+wOjO7TL4lLfAg5svfuw4Cx1wy6tUMdMebCbL0COkHYc2v6fvvY1K5rOdLC16
         +NLLSTMImA1yr3dPcpgaXHJ2JpG5TNXoARfq8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774123803; x=1774728603;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+GwK8Xw0ld/TS+qhy108IyjO9LdanTTp1MLkg1Ue/FM=;
        b=GsEhGKv3FKVywVJr3INP+ljEfpaUlYp917VMGYep4PsZfvAY/8A9bYV//b7YcvIARM
         tUvbMXwNR+QJA1xve8UpOOwpuPhs55dWL1lx75Hqqx1mqwD4tcP+evi2mbP69m6M3rhr
         ceISBFpBZQFzW49Zt2IjwxAQFLjbSR/MZrGMLwj3LspsHh/bOmYPqd/4WcZjvmRVWsAY
         c1huHz0XtUsuGrjnNGHQMnTLKPHZzL1wFU1ThIn7xRK2UOZGOOOCtMoQ/R4P7QhxUBfy
         vha7G462z6DDumuf9ahjGEDK83UeMcN7Z4Jhd0KbTSi7GsUZuXxMs0+qSDhxCDGFgJ96
         0Kwg==
X-Forwarded-Encrypted: i=1; AJvYcCVSYVoIBztJyUitFDuEcEphG4rEQ8WKd8xgHagqrW8v55pEFzC+IfdDdgqrncowuJv8aJLWcBY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlQhGUhTZErbnGUZrd34BIQbgdmBUXqvwGIqVvIp2HKNTWNUiD
	V7TcWYfRDs9x78ZHrK5liO3pH5gB6wEHm6R6BV2HeHz3Z9ZPrkIZjnSXrCxzJ1GC1sJFB0TZg95
	4f80Q/t4=
X-Gm-Gg: ATEYQzxI94+ZQazEiSvQw9elj3+pi2G+XvhT1E9rU7BPRa/nX5PTXiSBpCBkOZF7Z65
	I+XjlhqnQR1VQUBRn45RN1k4LCAtlXFWustgsV3HRmn0tmntn0WBXwFQop0644R+4tm94H4kNgm
	ReSZ5ejJN9Y8XtaAS3MGC2o5wfjt6uMUKgvrgx8xr/fMnpg6maCvk1CsLGmOouPakvpGglREHMy
	bQ/iuY1eA/9CPQ6Kk9/JE28APSKT2xiTUczXiQOjV7NcN6l5pdg9U1ETO8pKU3jfrqmA7CRu4Yh
	1y/A5+EaF+jlBodtuytbBPoQcVYlEPCl8X89VJ4dOFR+0yNwoAmUwOT6w+xY7ZTD/rSZ0FKd5Vm
	dEIIEQkCs7SGwcfyZwvsgZ1qcTSKdUX5L54EhCeje0QASEQqR0tl4VevpzJ2J3/oHaRfnUdt85o
	gCJBxqCt4ZVf16E5Nafxk70h/wdwEQS/+XQt1dlnzMWmwGE5zQRqav6Ux6mBWKMQXGvteE0TKk
X-Received: by 2002:a17:907:704:b0:b98:b08:7450 with SMTP id a640c23a62f3a-b980f93ca9bmr716492966b.8.1774123802877;
        Sat, 21 Mar 2026 13:10:02 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-668d22914ecsm2136191a12.21.2026.03.21.13.10.00
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Mar 2026 13:10:01 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-66966a394ceso761522a12.0
        for <netdev@vger.kernel.org>; Sat, 21 Mar 2026 13:10:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWMa/Wq21AodRnHx0nCsUSyCsATSiVC1R82AOnQsvFhy1BHLE/Vx9MZ5BQzpe2puMbCpNoI2sk=@vger.kernel.org
X-Received: by 2002:a05:6402:4348:b0:664:3344:f9f6 with SMTP id
 4fb4d7f45d1cf-668cd70f41fmr5367138a12.8.1774123800317; Sat, 21 Mar 2026
 13:10:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260319190455.135302-1-luiz.dentz@gmail.com> <177396481128.1855248.1024090053580545012.git-patchwork-notify@kernel.org>
 <6411a735-d187-4848-b199-a0e2c2e0e52c@leemhuis.info> <CABBYNZJfLf6PzKUkGjiCvqEm3h0+3SUcxY5RNbUHv6LBdPT_zQ@mail.gmail.com>
 <CAHk-=wh8dnp1qT_CHG-Zz9H2=G1Q=0rF5SYv+YsEaPnVhznxWA@mail.gmail.com>
 <CAHk-=wgryF_COh9xzhGaJ-FAm471pn5uvqt-Z94+3ENPVu4w-Q@mail.gmail.com> <CABBYNZ+YC43qvRQb7-KXv-EJ=s1Bhdf-Xu1xeEZVuzq96R7NTA@mail.gmail.com>
In-Reply-To: <CABBYNZ+YC43qvRQb7-KXv-EJ=s1Bhdf-Xu1xeEZVuzq96R7NTA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 21 Mar 2026 13:09:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=whFuDumk75VTTWeXzGfCQae4=XT-k8MdYWrca5JtcMrBw@mail.gmail.com>
X-Gm-Features: AaiRm52QcLSQz7-kVNJjvtQZRDwlGBpvmJh_VBc971qisQDLSOkf7cORlWW50mo
Message-ID: <CAHk-=whFuDumk75VTTWeXzGfCQae4=XT-k8MdYWrca5JtcMrBw@mail.gmail.com>
Subject: Re: bluetooth regression fix likely to miss -rc5 (was: Re: [GIT PULL]
 bluetooth 2026-03-19)
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>, kuba@kernel.org, 
	linux-bluetooth@vger.kernel.org, davem@davemloft.net, netdev@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-270253-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[torvalds@linux-foundation.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 4A58A2E71E6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, 21 Mar 2026 at 11:50, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Anyway, since this escalated rather quickly I think next time I'll
> just revert and work out the situation on bluetooth-next, rather than
> trying to access with the reporter and risk  delaying a fix.

Yes, I think that lowers the risk - and stress - for these kinds of things.

Generally, I think that if there are regressions reports that come in
while we're still in the -rc series and the problem hasn't hit an
actual release yet, it's probably worth reverting simply to get time
to think about the issue more.

(Of course - some bugs are simply obvious once somebody has bisected
the issue, and don't need any more time to think about it more. "D'oh,
too much cut-and-paste, obvious fix is obvious" - just apply the fix.
But if it's a situation where it's not entirely clear why things are
going south, and a revert is simple and straightforward, I don't think
there's much real downside to just going "ok, I don't know what's
going on, let's revert and rethink this")

The *good* thing about early regression reports is that typically the
people who test rc kernels are also very responsive to "can you test
this change" kinds of patches. So there is usually then a good path
forward for trying alternate approaches.

              Linus

