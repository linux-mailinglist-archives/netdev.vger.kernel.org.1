Return-Path: <netdev+bounces-276612-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CN2QNOSA1mmwFwgAu9opvQ
	(envelope-from <netdev+bounces-276612-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 18:23:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BF0F3BEC81
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 18:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8828E3017C10
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 16:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF983A1E67;
	Wed,  8 Apr 2026 16:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fRrx/4uX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1376534AB06
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 16:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775665369; cv=none; b=BZvMoYI7ZpytKArdRdY0/EP6uTTi8w9yAEzk/iegcLUjmCv3zin1MjUpyFDo/ueusGzw2wU5M2/CJcczZApIizTTkRSThoM6Rwe8Cbtl+czTXB8L6stz2t8CHfJc8ge60BZCwK2md5h0/qe6G1fo4XaqIy7LZOxkOlBkQB01gIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775665369; c=relaxed/simple;
	bh=MbK2EhOyylLAxU2Q/eHjdaz1ad4dnrnqpmOeagl6cGE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IXcKTKzicFt8Tj8Q0ha/1S47wvKktYmB+p9k0HbsxqeBW5a2xAjntSUtaPL/VmzNvXLyzR2LFbtwiBzFUYQnBFHg03i1Z02aU1uy8B57IA+oq5sMdLreD3ojJzuCn6ePynKOZUS3b7Vtxpi9bsizmcvu6FXRyFYteDeLHJBR84U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=fRrx/4uX; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-66c304dbfd2so73582a12.0
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 09:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1775665366; x=1776270166; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FrJr1968WuvXLCx5E+q3h8WCNbUNL7Em2uQzgCx18+c=;
        b=fRrx/4uXqqu8FVs+LcB5+I88dBlbYd8KacXUkYaa0Va2hEsXqTy3goqfpBY3fJh9Tc
         fWLfDWTTAbpW4h4KhUuq98O0GWVfXP4mtkz84YLszyBxoDZuDhWVs01lVCiiz6fT+bsd
         wk++HSaQWQLzrNf7GJCzQan7iGqEmJhg6mkCs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775665366; x=1776270166;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FrJr1968WuvXLCx5E+q3h8WCNbUNL7Em2uQzgCx18+c=;
        b=LiYmlPmwqdqOWnANRXllW1/+waUuUrJUGzszKsjFRmBfw674xLDp94tBcK9LrcILAl
         bfHGy8sqz7Bhk/qTPj3MdFDOQ538Ucyi5i81sKp8FCR3p3X1i4RScpH8sG7p34wpeBnS
         PuklFj3IeCX96vJiqX2baryQa8i/bC4FzBrgjmaKlanN+GKQKllHqdcAsZDXHz1QG/OU
         M6VMejOzdJ3htJel0mcLFQ3z8TjLbcTMKKNEeewmYFqIihDKlC6yTOVTGehIj1cSPTZw
         KY5XSoubqlRovjIue369+jctCC8x/xwJf9WuS7JlNqcP24ofaAm25ElOeYSnAmhY/ms0
         P0Mw==
X-Gm-Message-State: AOJu0Yzho64zF3U/dxkelltDucZgBsz1LKoq5FHOAiyuXCNGqoeEqxQb
	NZ119d2J6qMPWIXzRSd21Bu2ZACkMyFm7ggDPoSdt7GYpDdV31crcSrPbqw8d+2HXu1qcb8azf6
	T6SW21Jg=
X-Gm-Gg: AeBDievKRqxmSYZQdiodVMEPWuHgPNg7GrELEfkjqcb4Sl+38b7CgTfEetmVJlbBDIZ
	XuTZ75HcEfkCOh0vlJi394nyDfYu2AeaIajDBW8V/Mk1c5rSUmMRGS4udu9+CecN9nAvPKys0g3
	cO2STjn3VuJDuSoQFqiVVnmBPfcs+Rc+33uDIr7XM4WLADG/2kab6ii4FB0fd/UF+1HOUQ5q5+1
	gEfuRCbGOfJKYMcKMcYD9Qh6vIujHpLc+21Vwcc/0Nto5ZpaSTEe799Gkjs4L9MsMJ1ldoUWxag
	Pi7gxOahNlnP053B/R/IItH9kNpclOnd2VOAMJl6heUT/h/rnb0x9HDAbb2VBjZyrgonWTdwF3d
	3SxEkKRRafTO3p44BD8X1BjA4sjvV0SP23MSJAL4s7LML8Z4ypI6s2Ib0elU3pLeR6jeMwzTt4y
	7BUy72av4daeuhJ+FE4YOuu0lf5WFNcL/1aPVJFr3Rqm6IZkeoBcz3GA2Akq6BVk1wQGjJ/CV5
X-Received: by 2002:a05:6402:5174:b0:66b:bc47:8ce3 with SMTP id 4fb4d7f45d1cf-6700a77d5e9mr52385a12.8.1775665366327;
        Wed, 08 Apr 2026 09:22:46 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-66e033ba245sm5106165a12.20.2026.04.08.09.22.44
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2026 09:22:45 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-66c304dbfd2so73508a12.0
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 09:22:44 -0700 (PDT)
X-Received: by 2002:aa7:da5a:0:b0:669:cbc5:db7e with SMTP id
 4fb4d7f45d1cf-6700a57ee26mr52955a12.6.1775665364063; Wed, 08 Apr 2026
 09:22:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <adZTGOjjJrVJOcT8@shell.armlinux.org.uk> <adZfTi3R6jtsjXx-@shell.armlinux.org.uk>
 <adZ9grUg71f518Fg@shell.armlinux.org.uk>
In-Reply-To: <adZ9grUg71f518Fg@shell.armlinux.org.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 8 Apr 2026 09:22:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgvBPt8b204E49qUfK5F3otKzV==4t8Z=6_wXO6vgWqHw@mail.gmail.com>
X-Gm-Features: AQROBzAZ_qhfjZYeQTD5IRVziYmZuTFOofH8RWcCNS0y3LUoXT4zBJ_T9EYFJb0
Message-ID: <CAHk-=wgvBPt8b204E49qUfK5F3otKzV==4t8Z=6_wXO6vgWqHw@mail.gmail.com>
Subject: Re: BUG: net-next (7.0-rc6 based and later) fails to boot on Jetson
 Xavier NX
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-ext4@vger.kernel.org, dmaengine@vger.kernel.org, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, 
	"Theodore Ts'o" <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, Vinod Koul <vkoul@kernel.org>, 
	Frank Li <Frank.Li@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276612-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[torvalds@linux-foundation.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,linux-foundation.org:dkim,armlinux.org.uk:email]
X-Rspamd-Queue-Id: 7BF0F3BEC81
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 8 Apr 2026 at 09:08, Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> The rebase is still progressing, but it's landed on:
>
> c7d812e33f3e dmaengine: xilinx: xilinx_dma: Fix unmasked residue subtraction

Well, that commit looks completely bogus.

The explanation is just garbage: when subtracting two values that may
have random crud in the top bits, it's actually likely *better* to do
the masking *after* the subtraction.

The subtract of bogus upper bits will only affect upper bits. The
carry-chain only works upwards, not downwards.

So the old code that did

                       residue += (cdma_hw->control - cdma_hw->status) &
                                  chan->xdev->max_buffer_len;

would correctly mask out the upper bits, and the result of the
subtraction would be done "modulo mac_buffer_len". Which is rather
reasonable.

The code was changed to

                       residue += (cdma_hw->control &
chan->xdev->max_buffer_len) -
                                  (cdma_hw->status &
chan->xdev->max_buffer_len);

and now it does obviously still mask out the upper bits on each of the
values), but then the subtraction is done "modulo the arithmetic C
type" (which is 'u32')

In particular, if the status bits are bigger than the control bits,
that residue addition will now add a *huge* 32-bit number. It used to
add a number that was limited by the  max_buffer_len mask.

So the "interference from those top bits" stated in the commit message
is simply NOT TRUE. It's just complete rambling garbage.

Instead, the commit purely changes the final modulus of the
subtraction - which has nothing to do with any upper bits, and
everything to do with what kind of answer you want.

I think that commit is just very very wrong. At least the commit
message is wrong. And see above why I think the changed arithmetic is
likely wrong too.

It's very possible that the 'residue' is now a random 32-bit number
with the high bits set, and you get DMA corruption.

That would explain why this happens on Jetson but I haven't seen other reports.

                    Linus

