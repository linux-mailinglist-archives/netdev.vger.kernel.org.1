Return-Path: <netdev+bounces-281499-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yL+1Eg7Y72koGwEAu9opvQ
	(envelope-from <netdev+bounces-281499-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 23:41:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A0B47ABD9
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 23:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 459DC30BD164
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 21:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED70739768D;
	Mon, 27 Apr 2026 21:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cuJTYTit"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A24C37D110
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 21:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777325981; cv=none; b=GgMF+TFNKkRNqXOiDalIX8cEFF/3UUdwVaTk4FRzKkoBPv7d3vXUQnNCFUIkJNHEW5XomjmqfkPJ2L1dN9BumpQ9xahsLK2CpNyxgcRIRrVQaQVq8Zz2phqCah9ztCpKUtshn6M+nsWT8KM0rFtY+YWeOmVKJPqeY2XCipiFjzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777325981; c=relaxed/simple;
	bh=i/k46YQbNxc6jmDhpSrBTZQploRe2hY24KQV/uGHVj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zxo8SDobKcoz9jrymzADe68YyqtuH4CKzPQsKQbKee+c2KUpeFmarNCo2YlgKN8WuU//n1WAAmvICaloB6+r9KkfcvCnWe0VQXlCfENyobtpRsfDpDwtSFQw7DZ3YUJcgyjtQNMPdqQTndyesWR+12q8O4gbUqYlJItWKRkH+84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=cuJTYTit; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b8f97c626aaso848650866b.2
        for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 14:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1777325979; x=1777930779; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DjF1Jdn4Kp6xFyaBmAP2391GfFF2q7kuOVlruTChM90=;
        b=cuJTYTit0joP2exP66DiL0fyjzgex78IIzyY3HEY5z/fiX0LwiBC45aoiDugoivD5t
         vDS83XoyH6U38Wiy4JW65CQpkGQcEGupSuVNqKSuYN2TwFioM7lZWiQDoS4+77zgy5BY
         xpWYDSndwSjc+RvxdXOkTtWkqqtDHw/njqAGk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777325979; x=1777930779;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DjF1Jdn4Kp6xFyaBmAP2391GfFF2q7kuOVlruTChM90=;
        b=OgQkvk5mGkhH2qpQfQqWM/oHfgh5K+WVk0gTof4Ljghf2M4KDMJ/jgPzfTeFXJI46Y
         ZRAnDVgQUQSY3RiuQ8cN3tJ5DRWFSCL3J96njP5tBCFsQa5gqYfV1/B50UfK4JY8/PIW
         sdXye6jsnNwau65BPUaj2aFQmFnh61ZhcSd2kEyxbohVOCW7FdBefULTGAG9knI+PS55
         qqrFPN/Rxbklpwa9njSQjwWlofHGtmTDvZ71v4PgSme9KVlA1DyzRFtrg5ZitGTNhlVx
         JjmY1Z1r1OQz28RK47WedOxmgIsL/k1UBkuR/6tLzHfrArVRSAtut1gbMcX2qbjadLnr
         Y53g==
X-Forwarded-Encrypted: i=1; AFNElJ/QJ552I+BCfMA/yF7oR7GBUClVJTSKjBXTpMCgVmNBGAFVkEgm6Lxpy8uiun5jLAQwTynkJfQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5IPfbtlxjIOPzyDpPzYYB6OaELg266suJtXdBHEhiuUPqJS2D
	RLMJpVyl9TrxL3JLisJlYeW6k1hK6UT85NYMbg9HSfMTKLLTV0fxxNGfbj2adMJ1UYtrCFVuRoj
	VVJCzUgCXzw==
X-Gm-Gg: AeBDievTxsErkNpFkimGcEZj5COyhfz8mun7qF49UaqUNPz6rgrthCXNf7qWpbaRsPl
	X6FxF9/nCYkKgCcLydEK2c6zDf+wgXgBerpBtW0srG/mL32jJPx8NxhvFMyKdHGuxToAthxGDqb
	nzNNeM0kVO6lBdhjZekyg+gezKcDB+wykyAAZvDJLk6MW8SECem2FaEtEgok6LNqrHdHYMa/AHx
	rDLI6SMsxTfJc5F31hBE3DzNxKRwG4W5oqJ4vdqUd5lbx4Kti7zcYYb+8UBZ69kuCtE3e1CSqwK
	AA0OGjpI5e39OxqtWyC5c9Yq+1kJafkuBthE1XdjieTHxuYdBs0eUuxsrMtmjaGqy9XzewTwt6O
	P1f1Ro8tQQCrtb0QT8vMzPGKGAqqyVmRcgXPTSm0rGaWGr4+kIctVBQeSTnGXgutgu06CiRsHCW
	hiGzxxImPbe6EPQNq/oWu+aIo/KDYYlAidUm+hDoNtsndvCpHPSG0cSAHDctc558R7h0CrCmx18
	fHvQ61NKC0=
X-Received: by 2002:a17:907:c408:b0:bb7:c28f:26e2 with SMTP id a640c23a62f3a-bb80520b15cmr25205366b.46.1777325978638;
        Mon, 27 Apr 2026 14:39:38 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bb80b2adef5sm9121266b.40.2026.04.27.14.39.37
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2026 14:39:37 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-65c4152313fso14716975a12.1
        for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 14:39:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9S3MxzHegdMdN/VbtNa2KFvy5DItwMoedMYzaRDyQcagZ/295CE+W9xsYtI9ofiRNU/g+Eb48=@vger.kernel.org
X-Received: by 2002:a05:6402:5216:b0:679:1f4f:9d30 with SMTP id
 4fb4d7f45d1cf-679bb04c1a2mr179970a12.4.1777325976937; Mon, 27 Apr 2026
 14:39:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1777306795.git.chleroy@kernel.org> <289b424e243ba2c4139ea04009cf8b9c448a87ff.1777306795.git.chleroy@kernel.org>
 <CAHk-=whC1DZojwdMB1=sJWG2=dsCdfyU8N6tDE1qx50HRZ-WJQ@mail.gmail.com> <20260427222914.1cb2dd3b@pumpkin>
In-Reply-To: <20260427222914.1cb2dd3b@pumpkin>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 27 Apr 2026 14:39:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg0SGbRYhdZ1kvJUTv1HEvmRJyQauFtBGV_fMcZVF8UpQ@mail.gmail.com>
X-Gm-Features: AVHnY4I-AxqvQRk42MegvhKMp_z4sSEpEzhzpgw2GyV2bV8dezSPoI0JTlwB18Y
Message-ID: <CAHk-=wg0SGbRYhdZ1kvJUTv1HEvmRJyQauFtBGV_fMcZVF8UpQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1 5/9] uaccess: Switch to copy_{to/from}_user_partial()
 when relevant
To: David Laight <david.laight.linux@gmail.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Yury Norov <ynorov@nvidia.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, 
	linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	kvm@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, dmaengine@vger.kernel.org, 
	linux-efi@vger.kernel.org, linux-fsi@lists.ozlabs.org, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	intel-gfx@lists.freedesktop.org, linux-wpan@vger.kernel.org, 
	netdev@vger.kernel.org, linux-wireless@vger.kernel.org, 
	linux-spi@vger.kernel.org, linux-media@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-serial@vger.kernel.org, 
	linux-usb@vger.kernel.org, xen-devel@lists.xenproject.org, 
	linux-fsdevel@vger.kernel.org, ocfs2-devel@lists.linux.dev, 
	bpf@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, 
	linux-x25@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-sound@vger.kernel.org, sound-open-firmware@alsa-project.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: D5A0B47ABD9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TAGGED_FROM(0.00)[bounces-281499-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[48];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[torvalds@linux-foundation.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]

On Mon, 27 Apr 2026 at 14:29, David Laight <david.laight.linux@gmail.com> wrote:
>
> I think there is a slight difference in that the normal copy_to_user()
> will determine the exact offset of the error by retrying with byte copies.

I have this dim memory that we decided that you can't reply on byte
exactness anyway, because not all architectures gave that guarantee
for the user copies.

But that thing came up many years ago, I might mis-remember.

            Linus

