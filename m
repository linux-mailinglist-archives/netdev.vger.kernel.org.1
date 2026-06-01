Return-Path: <netdev+bounces-293851-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8EnpGG+/HWpidQkAu9opvQ
	(envelope-from <netdev+bounces-293851-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 19:20:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05311623328
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 19:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A76B300CC26
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 17:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B863DEAC4;
	Mon,  1 Jun 2026 17:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="VPtcisMy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11ACA3DD861
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 17:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780334268; cv=none; b=BIMLrskLctkvZXoNCNaOtOFQP38akGDVFrk/MdHRoyrx/DVZHg2lsLbSL4VlumIhampQHB2k7vh7JIGqubsld66HgY2p8pceWKC9Fu3BMffqjMT2sB/ZdkNfgxD8iOcQMCcWCIHXxFZ9xcSjxpbARAIB6Rf7lM/Rmm4xrR1iaV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780334268; c=relaxed/simple;
	bh=QOF4HTo9NC+sG07UWNWNGhB1bOa8fZKjrboF6NtGYig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e3+lrpv5pVWeaw452hSPbE75xmlSja/9RIX6JaBJg+WiN6dMyEa1WqnLTv9K8kVKmz6Py8vb3LU69X4vqk/l3dTyia0ZjTq1Zx+A53l35nLJ1JlYmiOkmiECPQs8e3ZdOukaHQnggJ+M32qeNEHOXiATTPfl7nNYFbZog5+V6B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=VPtcisMy; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-beb2a97cc9aso437349766b.2
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 10:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1780334263; x=1780939063; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8glRJeBkbbvtPfYZZguJlBO/diWKKHW+QvqawLEed2k=;
        b=VPtcisMyVtMPtLtRjN+qVp9en8QqOm1sevcoPwB5ll5VOlVmsj4DlxJ9BcM0w7v5Qw
         fysKwa080G28VGidjcLImxS0Z5q42d4ddTdaPHr/EKAJGZb80c6BxTFPdVhvcrnpuJzC
         AVGsD2RGdaPbXl8AYurf7nfNIpUG4d44mphmA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780334263; x=1780939063;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8glRJeBkbbvtPfYZZguJlBO/diWKKHW+QvqawLEed2k=;
        b=o+zqk4DEaEKX2sVRVDd2Phcza0W3gVudVlKAoqt0mVPPX+nnsu0TkO8qdvCEv45Kag
         o8qjlmqH9eqhY01EBX9Yr0b0p3g7Bl1oXpuiMvoAQMf9OlPxfxfkUg6zWNNKxgKwVlKd
         hIylG+YebhS1fAWv1uYvDO41GetwLSvkfpgHskZpXHkhvwPF5f8FDQCzqNerItr47nXu
         ycNiIYnuaqi+qY7fVDwgmUMdwPRNqjqKjPAZXb7xwwXvhlXqkdfzSjgbH6Sr7F6R9Twj
         2EtYLuk1RRsJbWtsNUHSk9oCFa3fpKj056nVZ1oZpqxx421N597xTqWUxcpKFDpbCOxS
         IztA==
X-Forwarded-Encrypted: i=1; AFNElJ+2+RRCeMK8V6rPQv1UVPqESrU5MYvPRyfI02GrwpI3nSHyW82Av8ftaW4yPbeN8kbrj81JLPo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVHVqiU0cuHOfYNcKEwPzC+2Up1xZNGb9BR+ftxYwiQqk+UMxR
	JqeAhPA4kpkwfBpIhlSN4dbjLYrGDEG9Ag7yD2/IMURJdCx6aMFUTbP1mw3Ujo9cWniDRBx9bEu
	0yCr6lwM=
X-Gm-Gg: Acq92OGocnKSP1xgGMHW0Op1tB/wtzQQX7c+e85KKH+Q/YoRBlXVwTHi1ruiUMabl1G
	XUKlnLr03W1xpsmBPK0T8w8w5BHdL99M22EEidO70JxuegPWfG3SG5BR4LLm1qQGhjnYhkVOKMo
	ZhqmFJfO4a/KrOtCV6GNSfg6PmRFnFgEnGqVjROQAQMW1ehQ02NaA++uJUlAiwEkTqZOKt2EDR1
	iy1vZlBhw328DQ9V5RcYpzYRmRNzrHIfei8IE+yKNfwBwb/qNWCfCGvHtgdE2RUQBf/DTKV8GCj
	jQHCPOnXfZB8QAy/bBv2d16ivkauQ4Hh2SAWQMdlBBG/OewDNyLkObb+Xemnbka9KRUyLAzFbA2
	wKgYUVbF775J7L7u+EsVlZHRyGG/D6Zng5UAIEAxOXN16FxfxY+0dP6FBds9k7mlVbvq00P1EJz
	RvSyXeXP9h1OwRBl0oZFw51xgbKmRW/JAoAqbPOHa6M9ezHfFdS9xpunfRTFZ1JV7nT6/lrdSA/
	+BRv2/YthM=
X-Received: by 2002:a17:907:97d5:b0:bdd:3c8:3348 with SMTP id a640c23a62f3a-beab334d1b5mr750052866b.40.1780334261575;
        Mon, 01 Jun 2026 10:17:41 -0700 (PDT)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-be9d31dadefsm355465366b.21.2026.06.01.10.17.40
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2026 10:17:40 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-bec4639953dso264710566b.1
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 10:17:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/ju7FkLwJ0+rkK+tJuzDkWCjg4OA2m622nWhPAc+rrslP96sZ9cfEHbzflAZpuRz92CmTIDXk=@vger.kernel.org
X-Received: by 2002:a17:906:4583:b0:bef:12f:347e with SMTP id
 a640c23a62f3a-bef012f3d6fmr16123966b.24.1780334260114; Mon, 01 Jun 2026
 10:17:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260531010107.1953702-1-safinaskar@gmail.com> <20260601-enthusiasmus-canceln-anlehnen-0e62317a9784@brauner>
In-Reply-To: <20260601-enthusiasmus-canceln-anlehnen-0e62317a9784@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 1 Jun 2026 10:17:23 -0700
X-Gmail-Original-Message-ID: <CAHk-=wifX_rrDjRGnDnOqE-usptAukuXKrmuPuVDP5bOCBWzGQ@mail.gmail.com>
X-Gm-Features: AVHnY4KexWf0o1w3H7pefWBidQ5elZSrUhqo_ATAUmEnAO4iwBaX4DnfDRLKUYk
Message-ID: <CAHk-=wifX_rrDjRGnDnOqE-usptAukuXKrmuPuVDP5bOCBWzGQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
To: Christian Brauner <brauner@kernel.org>
Cc: Askar Safin <safinaskar@gmail.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-api@vger.kernel.org, netdev@vger.kernel.org, 
	Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@infradead.org>, David Howells <dhowells@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Pedro Falcato <pfalcato@suse.de>, Miklos Szeredi <miklos@szeredi.hu>, patches@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293851-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,kvack.org,infradead.org,kernel.dk,redhat.com,linux-foundation.org,kernel.org,suse.de,szeredi.hu,lists.linux.dev,zeniv.linux.org.uk,suse.cz];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[torvalds@linux-foundation.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 05311623328
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 1 Jun 2026 at 09:42, Christian Brauner <brauner@kernel.org> wrote:
>
> Applied to the vfs-7.2.vmsplice branch of the vfs/vfs.git tree.

Btw, if people want to work further on this - assuming we don't get
any huge screams of pain from having effectively gotten rid of
vmsplice() - I don't think it would hurt to look at limiting the
"regular" splice() too.

We already have the code to just turn it into a pure copy on the
"splice to pipe" case: copy_splice_read(). In many ways it would be
*lovely* to just always force that path.

We already do that explicitly for DAX and O_DIRECT, but we made a lot
of special files do it implicitly too, so quite a lot of the splice
reading cases already use that "just read() into a kernel space
buffer" model for splicing.

It would be interesting to hear who would even notice if we just
always used that copy case, and made "f_op->splice_read" never trigger
at all.

And it turns out that the only thing that ever uses
"f_op->splice_write" is splice_to_socket. Which was actually the
problematic buggy case.

Everybody else pretty much seems to just use iter_file_splice_write(),
which does the "emulate it with just a write from kernel buffers".

So *if* we get rid of f_op->splice_read, we do leave the case that
really caused problems, but nobody will ever care. Because once splice
only deals with private buffers that can't be shared with anything
else, a f_op->splice_write() that gets things wrong is pretty much a
non-event.

(We'd have to look at 'tee()' too: I don't think anybody really uses
it, but it does do the "no copy linking" by just incrementing
refcounts on the pipe buffers. So to really protect against
splice_write users messing up, that should do copies too, but as long
as it's all "private ephemeral buffers" that get their refcounts
updated, I don't think anybody *really* cares)

TLDR: maybe we could ghet rid of "f_op->splice_read". *That* would be
a big simplification.

                Linus

