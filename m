Return-Path: <netdev+bounces-273004-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OBIlLD+FyWndygUAu9opvQ
	(envelope-from <netdev+bounces-273004-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 22:02:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2995E353E5F
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 22:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3ED2C30073DA
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 20:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34B82D6E44;
	Sun, 29 Mar 2026 20:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JekhqfT7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CFC257845
	for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 20:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774814521; cv=none; b=lZiItS4Ed2f1hFREyIDzyj9Z/jBnTv0Z6Dquw29niie6GmusATjLS5Nf0aJHjGtoB9D+mnVGwNpxxqcU1fVwaHtD9+E/Zzce1HtBuit7p6qrLYPcOdujsJLCvV6+U6pjdnMPkhsY+tR8XvUFamNbCTV9rix9Smg1YYUPzu7ehaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774814521; c=relaxed/simple;
	bh=6KesuHunNm5vzupfH6dWeNmGrojSoSm6OoZ7E509dxI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bxD1j9TyNkJ9gmdDb7mxbauAXGvtU6hgHy9o0SCLNedgPmShE+VoGc64jmeN5u9ty3erMZKhv2Q0U6T/SXpF/STizjIUHR2AUrp9PXPNGCVHe75rGO7nQ/ThCInaiyoUwGjIreX70ZjLWx5x6rRkLezXIsxh1c4NTaAoFSf91kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=JekhqfT7; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b8d7f22d405so584344266b.0
        for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 13:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1774814519; x=1775419319; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=W2LBsWL0RCR7A1/NBeRjO1DmOoAWjMff84GLac5q8D4=;
        b=JekhqfT7S/8S3fOXygO+G3tv8ClmY6WZ+pFZWo0tdyj79q1llTout79e8bAAs3XR7u
         IP+xpWflJfhHHuQcJjyKb9BribdvSyh2GGym47VzrFgnFWVWzeC1lRCQHEGpakTrGMni
         Mb41H650xJ9KzGdOLMp83IfqpESMGZEFjULwY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774814519; x=1775419319;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W2LBsWL0RCR7A1/NBeRjO1DmOoAWjMff84GLac5q8D4=;
        b=aXyw0CuvHTpuSQ/7DR4icfWcFRR0JYXIMwZ85A00urA9fx/G79c0JzUcbl+HWNVW6i
         6wD8jQeNJls/qqBokLk9xF2bs8Fg8QsBbI6Ito3i0gR4l9bA99WVkXEInh2zlCBbdd77
         0GTXn7NqFq4UetwtN+86gRa9EXemwLrIANIocX6wE6NIK0Cqg/XMI/l+iF7WZr1sv/tu
         SpZOMiz0i0khucjs740GbUoihWt5lwB6muVr/avih56YsVCrFbHgK1n8bxBEwFoMsesY
         xCJ0f/R8l0Et3HRWX1eEsnmU/8vwztyXM4jkBj9zWUSyquDIZsmFKdKQVlbcAdM6PsbF
         /60w==
X-Forwarded-Encrypted: i=1; AJvYcCWHMWQAOSHPMZ46OqZGGItHn8909CtZo2KZeZWCJs06WmdfwoEloNXF1sMjFdSnRNgGqg1GtVM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5k+YpMJJMj0mmyvA2OyK2KGrsRdUip0BLHM58BzOUsPjjtyBl
	drd6l5XKHEh4id+x1nUetxsbQ2W9QMCtwLg6439bdGRj9WYT43U6OK7V+CtGJAMGbz1ANXnns2Q
	KHaCTH+A=
X-Gm-Gg: ATEYQzz+SRfRaotT4FLc43EISP/7uVEOEQ8luDrOm9V7uZ8uoi7U+7A3Mc54NhrCRKO
	a+i/1szRVklr2aEWT5bRuVtRE5Z6CledxlfH70YHskWiumxjUU+nFqe+oPbh5pX2QNl61ZuJPgR
	irOCbIErbeeZciGjckXnVOny44+yeaLuvm0B75S6Iduxd6P+vm7B2NUdE5/oLvngQqFPLh9Ral8
	G4uM16UKeAEXUKiRaBz5BdlIMMdufIj878nsBDwHH5vj++iDaDXkyGHi311vF+W39BivfhUSZl1
	r/cyZKqrJupvE4xXn5wlaFNWqRDUZSWsPvj7bpQzuXVD0llH1Cc4bpQqbAClYbZwT1oilZeCzU8
	oQMLBt8C/jo+vjVJsmIKYVRS3tgFABbAaf5+Jh0eHjBIjnDPFqpoB6LPoC9Klpf03HC+T5naduh
	7O6aA5qBfjnSKL8DNOZ7hgXe4NuQTlETJvpwSdYB9+biW5mt6c2Yp8qFLmtzdjMbvr8/VaXKZQ
X-Received: by 2002:a17:906:ee84:b0:b98:32c1:249b with SMTP id a640c23a62f3a-b9b502bd39amr600540666b.8.1774814518778;
        Sun, 29 Mar 2026 13:01:58 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9b7ae520c2sm196952066b.21.2026.03.29.13.01.57
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Mar 2026 13:01:57 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-66abe08cdf5so5845726a12.0
        for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 13:01:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVD3AvwJGPRRW5FfzufK223t2VsnaE/sVemeNJUKJ7vZPMmLppn7Dv+ZJtNAEPCQGMW7C5UsQA=@vger.kernel.org
X-Received: by 2002:a05:6402:370f:b0:665:638d:75c1 with SMTP id
 4fb4d7f45d1cf-66b2836522dmr5313873a12.3.1774814517026; Sun, 29 Mar 2026
 13:01:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326131838.634095-1-dhowells@redhat.com> <20260326131838.634095-5-dhowells@redhat.com>
 <20260329121208.6092419d@kernel.org>
In-Reply-To: <20260329121208.6092419d@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 29 Mar 2026 13:01:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiJ6gEELLviexdmSHnyjVoG7MFo8Qwhd1zxs_tCnL-=gQ@mail.gmail.com>
X-Gm-Features: AQROBzCLNnOtMDq7_zEYzn905-QyT8tE9Dg3ZE8enKPKMkcfb1CkLbH9Xycl1-E
Message-ID: <CAHk-=wiJ6gEELLviexdmSHnyjVoG7MFo8Qwhd1zxs_tCnL-=gQ@mail.gmail.com>
Subject: Re: [PATCH net v3 04/11] list: Move on_list_rcu() to list.h and add
 on_list() also
To: Jakub Kicinski <kuba@kernel.org>
Cc: David Howells <dhowells@redhat.com>, netdev@vger.kernel.org, 
	Marc Dionne <marc.dionne@auristor.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, linux-afs@lists.infradead.org, 
	linux-kernel@vger.kernel.org, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	John Johansen <john.johansen@canonical.com>, Minas Harutyunyan <hminas@synopsys.com>, 
	Simon Horman <horms@kernel.org>, apparmor@lists.ubuntu.com, linux-usb@vger.kernel.org, 
	stable@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273004-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[torvalds@linux-foundation.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux-foundation.org:dkim]
X-Rspamd-Queue-Id: 2995E353E5F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, 29 Mar 2026 at 12:12, Jakub Kicinski <kuba@kernel.org> wrote:
>
> Could someone with sufficient weight to their name ack this?

I don't particularly like it. I think the name is too generic, and
it's all wrong anyway. Whether something is on a list or not ends up
being much too specific to the use-case, and I do *not* see a huge
advantage to a helper function that just wraps "list_empty()" with
another name that is actually *less* descriptive.

So no. NAK.

As you mention, the RCU version at least does something else, but
honestly, it looks pretty damn questionable too. And no, it does not
work for non-RCU lists in any kind of generic sense, since iut's
perfectly valid to remove list entries without poisoning them.,

For example, some places that want a simple "am I on a list" will use
__list_del_clearprev(), which does *not* poison the prev pointer, but
just clears it instead. And then the "am I on a list" is just checking
prev for NULL or not.

In other words: all of this is wrong. Whether you are on a list or not
is simply not a generic operation. It depends on the user.

The name is also *MUCH* too generic anyway.

               Linus

