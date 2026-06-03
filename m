Return-Path: <netdev+bounces-294792-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2G0eMrZCIGqazQAAu9opvQ
	(envelope-from <netdev+bounces-294792-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 17:05:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E77BF638ECF
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 17:05:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=paul-moore.com header.s=google header.b=K7D5f+wx;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294792-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-294792-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=paul-moore.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7E7CD317615D
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 14:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3451A3D9678;
	Wed,  3 Jun 2026 14:44:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A7B3AB273
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 14:44:13 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780497855; cv=pass; b=fen9V2gnN9yQiv926FDQDW4huvcvhOJ+brZ9WDApkDEG4aw6EVE6QCIAE8NlqSl8wa/jWhRIsI7YQhNzRH6BOsOWCg7wruzYkFbQ+NSJLIUTvVfHsM1w1pzucP8YZ3Tx/cLf7A2zcOq+tT9LhPxQKeSWpNGwViQHAeqTUSEl+1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780497855; c=relaxed/simple;
	bh=2OkasJ0ndKZfg6cpcJo7yWgVLndNvCdeEQG7xxbqLK0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SXaF3Ct4y7plxr0Q1a59sXALXNnJHj6vu94X+EcAWWvklYPVqsUYXDXAoiw15h5G+4eXh6mD3fwHesj2zyS9zZ8fAPbKGs70xk9HFtbOuVe7KtgWgEhEaa0p853BFT2bI9VkCHwqqqOZ0Sd7i82Ytq0GZKCiXNNXOwHOqC5e4XU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=K7D5f+wx; arc=pass smtp.client-ip=209.85.216.42
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-36d5fd50d20so3251692a91.1
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 07:44:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780497853; cv=none;
        d=google.com; s=arc-20240605;
        b=Oj8ZE8SFHnujntcxOE96dAyYjOpsv4qzf7Xni10xRBrS3u7JKCMe6uAGL4+TinRDAP
         ucVcxp8PeilTwIt1NjV/UiXVEetiA2g/ARJ9UgPCtWvRcV44DWNbAnPX2eJ0HJMqrjE7
         N86/vjGbU/yiz+9sY0hYnU0X7+mvO3q6AbxsUeBBpQ+heqogG+jgFQUK7KUXIplRkPFm
         MA0e2mFQ+VHlL9g9Iz1z9aZBjGu2vacQosiWdd/hQsljDap7Log6wEOS0LYiXznW7GPC
         TtBTgYdaArJFXJ07GYgB36Leu4dNeM+b6PK1nv9e3Jc//8MHISBqoo4dlBNZkGprpZuT
         yStQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Y5JjMZYEtQz+6ik+uw6aiCOF6sKgKEkR5ogTnZvnVt0=;
        fh=ngxHM6bP4fsqt9ftBWqHFdaYeTijfKm6O6/8N8rvTyM=;
        b=CUfMBl3PI7lX6jI/noYLmCPURpQUXTeThsavSAMFi9ig6WfTH4t03pu8P8T5/aHdEp
         /V/HqxZUy+R6aLc9fmV9u8sfXfo71EppgQ7PtNBVP/mBcjDRWfEd7zcKsSObf8r3q8JM
         MV+hUWHiXITDcSk1Uio8ZIGWKbSHHCPRsrjDJpCi76pwN6lUmrv5MY+Gh96964/N06x8
         UGEoQElXceqFLRxotWt0sWr1slKvdfKkycRQK0BOMArij5nIclZahMp2IU1QTlXIHdU3
         An1WF8poEcRS5YaDuovxj1MZDEzDYISDcm/aUindSIu+LN9muZNKRvkBvDURHQ2Sm6Qc
         bYlw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1780497853; x=1781102653; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y5JjMZYEtQz+6ik+uw6aiCOF6sKgKEkR5ogTnZvnVt0=;
        b=K7D5f+wxF8jERGEb36Ms0OO4m+9Fq0hFqokg0cc/mIe6f0adFu2IYc5qQhRMZtXZbo
         pYvyvR/AEHzCCdFP2qNPsBqN8HHt0YKQzvy5TLrFSuokRHsD6sYOc8KrthK3gVHRHmLG
         aJfQ7VIK3oh18o8tj3DvLr9YXhwnBfS+6F/l33cKn7Ux0qcvgzzYqCqEAxEhIG4iX/No
         66kkJd70ctGAG0yysuDInWJWr7gBdbAJ5QaM5ZPB1rCQz6WWysVhBAWyFeV+VVKr9R9b
         OECQC8asSoRgfC9w8GuRmhULjIm+omSKKVfyFaM2/3yu3fnr5++/8/i9nD+k+dmevIFs
         u51w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780497853; x=1781102653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y5JjMZYEtQz+6ik+uw6aiCOF6sKgKEkR5ogTnZvnVt0=;
        b=FG+mSWYeCwMcJfg0XgCZ5Kp5amy2RLVz2qiczBm726xRi87RWYU0BlOfaKY5WdXLg3
         zvGMeBuWNa6RlTXEZXblcyiFUzBImcpjxaRnEU6fCf1zk+47U7tmRFed6K+kXcmMCH+u
         eDic6+eNnMEkXt9z41m1hlPYGZds6COaEt4po+ccCP2yc2Ttf7MY4syUuA074Yr1ZhMu
         yowA6LV0HK1xc0g+xDkFFA41em40I9NA8pRQzrqEdNlfGBwlpVldKZus3EwZiqle/Jor
         3in4RkYiN49LVFEKs6ct8inCUUcIikVQw3H5lfkixftvNlJJad2q2+o05WH77h1Z5I5G
         sLyw==
X-Forwarded-Encrypted: i=1; AFNElJ+EqM8dDtwBXJbKAD09HBW0NXqGe7bzsZ0osFcLSyJmuZ9mc9MInNJJDA2HIIp4zRbOhfFjpxQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjC4841ZOOtGDaAvu/AWawbbt0vgC5eAN7KqOuN+e4sUWkrSg/
	4+JOIejQgNwk5H4hj9r8T/XDJnmkdu3Erx4pYcO1dEGuoLZlyawRK9EYeJE9Lz/MSmaAEcwDLSZ
	Zu/TtnZ7RAeHyw78NFp0Ycw2Kgny+VThdMZl4iLMg
X-Gm-Gg: Acq92OF9L5tCuPTi3vfsYGN1VYigOpJYf+WGXHN/3knbzznsjo8x0Gmdj1y6AXKEMjm
	oRIm3ymnnF8jbPxLqgk6U+Fa6tqks0AYGoO6WPwo8dTuWeWu3F7MhRb0I8t2F/376r2B1kaBFIM
	KKQfTCOmn1p5b1g7fI1YnF63TWplhKTan1U4qhx6P9yGgZlvvEAhDZiDOy+dzzfSW61VjKCPDAU
	/NlD7PNW3cgH728gyu0GILAwsg0VDcqXUktkeKXGrTNnw1G3yorFe67YP0IkLK7QPP5MT5fg1lR
	oQDwfvUusz6JrIA6EA==
X-Received: by 2002:a05:6a20:d4b:b0:3b4:895f:6ac7 with SMTP id
 adf61e73a8af0-3b4978a23d7mr4133938637.22.1780497853207; Wed, 03 Jun 2026
 07:44:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ah8BzqSmZO40xYhS@sirena.org.uk> <CAHC9VhRR4mmkOdWwUCLswmA+_KEjB8RCBBTJ2W4JGiLUWKzxyQ@mail.gmail.com>
 <CAHC9VhRPbkVYAMec0KG55er6GOPdKqMXKdpC8rrHgiAodSv-sw@mail.gmail.com>
 <9d34218f-abbf-4a23-8b35-b305873ffae3@sirena.org.uk> <CAHC9VhQnBi55hjwTATA_tgKNZ=StFYTKu2Av5R8N4yDJwsFswQ@mail.gmail.com>
 <6565c4a4-3102-4521-9c84-48c7c7f0117f@sirena.org.uk>
In-Reply-To: <6565c4a4-3102-4521-9c84-48c7c7f0117f@sirena.org.uk>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 3 Jun 2026 10:43:59 -0400
X-Gm-Features: AVHnY4JIW8gQBYMOr8fggrJDG2mD4293Ofq_rtsFtHA031eqjcjZT-6N6e7Vah8
Message-ID: <CAHC9VhR9R-wBAj64aO60pSUb7f5Tmfj6gprrHQB3g+=WYF14mA@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the security tree
To: Mark Brown <broonie@kernel.org>
Cc: Blaise Boscaccy <bboscaccy@linux.microsoft.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Networking <netdev@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[paul-moore.com,none];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-294792-lists,netdev=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:broonie@kernel.org,m:bboscaccy@linux.microsoft.com,m:daniel@iogearbox.net,m:ast@kernel.org,m:andrii@kernel.org,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-next@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[paul@paul-moore.com,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[paul-moore.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul@paul-moore.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,paul-moore.com:dkim,paul-moore.com:from_mime,paul-moore.com:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E77BF638ECF

On Wed, Jun 3, 2026 at 8:42=E2=80=AFAM Mark Brown <broonie@kernel.org> wrot=
e:
> On Tue, Jun 02, 2026 at 05:45:04PM -0400, Paul Moore wrote:
> > On Tue, Jun 2, 2026 at 3:16=E2=80=AFPM Mark Brown <broonie@kernel.org> =
wrote:
>
> > > Can you ping me when that goes in (or things are otherwise resolved)
> > > please so I know to drop the revert from -next?
>
> > You shouldn't see a conflict with lsm/next now, but if you do let me kn=
ow.
>
> It's still there today, but seeing Linus' comment about not merging
> hornet I marked it as BROKEN instead.

My apologies, I forgot to push my local tree to kernel.org.  It should
be all set now.

--=20
paul-moore.com

