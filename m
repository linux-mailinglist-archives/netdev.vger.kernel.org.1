Return-Path: <netdev+bounces-303939-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MWZeNZ7ZRWorGAsAu9opvQ
	(envelope-from <netdev+bounces-303939-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 05:23:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F1D6F3352
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 05:23:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=johnericson.me header.s=fm3 header.b="dR8H/USd";
	dkim=pass header.d=messagingengine.com header.s=fm1 header.b="C jDFCov";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303939-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-303939-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=johnericson.me;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 88E5B3011A79
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 03:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A283101A5;
	Thu,  2 Jul 2026 03:23:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3558527AC57;
	Thu,  2 Jul 2026 03:23:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782962588; cv=none; b=D+nrEORy6FY85mccG6/5Hn6yRk7vrik/fs3AZ7EQEJXEjoY2yoNrNn5SJlalDA+HrRQrI1u+EZvoH7WLflbuDNAypQmjaklEPhJAVQK2E4sWTHiUQupmxkSj2W1qDFBWXb4qkOB1YYbskybYqQ+1KagBmUubvpv2xeZl3kFG11Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782962588; c=relaxed/simple;
	bh=h52IPXEO3GErwPUXSaSWfDdjb5VBspL/PzrUT7vQqEg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=BvgR7UeZyF40zT1yuvIDL3bwveaPG8E2WVygpD75sym2HUIraPc4zyrU+NSZ7CxhagTCIIrAqyhwz6z1aJHYGYC0bYrSlodGNwbwybYWSbzyO0bWgaA5dOd2bEeeCqnrVSPxOfNibUdoul2NG0vXhopT086E8aEps5TXfaSvlfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=johnericson.me; spf=pass smtp.mailfrom=johnericson.me; dkim=pass (2048-bit key) header.d=johnericson.me header.i=@johnericson.me header.b=dR8H/USd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CjDFCovs; arc=none smtp.client-ip=202.12.124.150
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 3CFB21D0006E;
	Wed,  1 Jul 2026 23:23:05 -0400 (EDT)
Received: from phl-imap-16 ([10.202.2.88])
  by phl-compute-05.internal (MEProxy); Wed, 01 Jul 2026 23:23:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=johnericson.me;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1782962585; x=1783048985; bh=+ofwFd0BgfH978UubVq3+U13sv3WhECD
	ex7It7QGGUQ=; b=dR8H/USdaOxwA8CPdfFY89sM3BC1+DOOrvJsPM3+yZLXRQqq
	40bkEMX6zts4qFPZfegYrUkvWhny8WZOou0hVp8MMv3wwzuu8w53mhLxO9QqqKYm
	WUYWV1aK9oMsrzetc6Re2IhRdt9PCZKdwsIoSzfl3sICf588keEwpKde8Akd+h1M
	FbJo+msUq4rwBt5q7Warf1SRTIKq9emrZHPNtLAkF3gnAz8rBNraUWigiyYBjUsC
	6XnLUhRB/w3HAQ+WzAxvWcn+odFNqMpo0Rir8XMIXHORYlSCSRq+nn2pgJ/13EQ6
	DStp+B1p1Cnf6m4wZ4Ge2h2cTsjtFODwsn/BrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782962585; x=
	1783048985; bh=+ofwFd0BgfH978UubVq3+U13sv3WhECDex7It7QGGUQ=; b=C
	jDFCovsnejQgJrhSNtYSSOvrC4hJ47Dd1Gav+2htmIldr4Co+5euDii0MPGSM7O8
	pWhQ11olagALAMydFq/u+YlUeG/5xYOlf8W6wFr4GlfVWVhH1/dgfSvecfi9LiK9
	vi3g8jaVeNSdoUY4prtQFVLHYALNkZquk4nVOajVdkkz50qf5ux7ndwf6CzP7p7N
	l/5wiKWc1rkeCnYpr90UPOnLpbAGAF4gXHJMgBAOE/mFepUCEPxMVGaAJIa3CD9A
	HqlUkznOcwB4dPgd4qwT4nWs5pglSLA/HXgCyIIVX5mlhxHCsDfWDhlU7qUU0FJH
	XTGDRfJIjprBlckCmwlqw==
X-ME-Sender: <xms:mNlFapSrjxUA73UrHUnUc10NEnh4QtgVRUCgwipMQH53vPB-phz6qA>
    <xme:mNlFatnZUaJ9cmR51IQjKytXXa8DWcaLYPYY-AMV1GRwIejdTm2snSM-J3_HsAsSV
    9xSsuq_NPSpzKsdc6Ai6cJlRE1JKTln-08vsU2tjkQRWt6d5BRhr8C9>
X-ME-Proxy-Cause: dmFkZTFM4tHx1Q26ZIh3UHc0hey+73JTKicWAXjZ52Lldta0RJQwSyaD00TgDAIOLdvcqT
    ZtskFQh1q65fyyZhjZuDmkQcsycDoBQkNBcRSf9ESab22aSbz5H4ecg2npHMwRQQ3bvvPK
    6h7ypaUo586eXVYjVCnGPD4Y3xrUo+EYT+l0TOEqhIoXIHuVmPkmWlteO8t1Cr+Ae6YZJh
    ZXwuwaQzAqI2+ebnMhG0DrmGevo7feD4kb6Rv8skIvSe8sLe+VpUezCTgtTpp/KcKEH8pT
    18aJSibAKd95jY6Dqc3PoFuJijcVZUxKcEEj6FETnqYBZbdZ7V9eYFLrh7QkgAE5CzQ7ZL
    wKATY6bxfLhaqtAXkUyRZ2JQ7lOh+BhbEsfnCQjIUIp2Yb0Ig+9+ktLi6kL+gestfZKKFk
    WSlmAqJuhhDtJ15qdQzwo0rGS12l5GRwPCt+lzh1ibZZJXP8ayRL0iStOoXTlTGD/3UqgG
    a8F593FosQmmIgLoVoqikr/BxYXa9B2v94FvnrKYgv2Fh90yNHdii44R0eDLAeDolyKG89
    ZkwFpSaa3bRWAId0PEUMoEDEHfmtFY+ibABbIeBjkcTHd767DTt1LXPP3K41/JVHZ+Yxgy
    baldltiKOkr2fS92PstYI/tB/OaepR/ZkVIuBmME1GHkjEl3SZlxzT2Le3NA
X-ME-Proxy: <xmx:mNlFasTNu2XizDprPQb8Z5qCZi15vrGoNpkwSHTovXCkCsSGBB7o3w>
    <xmx:mNlFalyyPJWaycBN35w-u4hUusT7LWHSxplXAv_M13tMEAKXS9flWQ>
    <xmx:mNlFasDpqcqGuQWg5K1XUMnUjKpGLLCW0ZvkFpb7YqG7rU15tEeVWg>
    <xmx:mNlFahHnDiJRYSwVLESitq_vW_pLeiNVvRsYjzTZHR9VsAA_U_8PXw>
    <xmx:mdlFaroV3nXG0GC8XHGjTjWMdLKa6Fz_dSNQhH8EL_irwEtK3ekT9mF5>
Feedback-ID: ieb4144f1:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 5F9CE2CC0083; Wed,  1 Jul 2026 23:23:04 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Aqzxz9K-cSE-
Date: Wed, 01 Jul 2026 23:22:43 -0400
From: "John Ericson" <mail@johnericson.me>
To: "Cong Wang" <cwang@multikernel.io>
Cc: "Li Chen" <me@linux.beauty>, "Andy Lutomirski" <luto@kernel.org>,
 "Christian Brauner" <brauner@kernel.org>, "Jens Axboe" <axboe@kernel.dk>,
 "network dev" <netdev@vger.kernel.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 "Sergei Zimmerman" <sergei@zimmerman.foo>
Message-Id: <ec6c3206-ed41-4de0-b315-0b602b7faf41@app.fastmail.com>
In-Reply-To: <akWxrjOl4Up02Bvq@pop-os.localdomain>
References: <b1af80fc-a57c-408d-bdfe-fa6bae26eaca@app.fastmail.com>
 <aicbyQIC2qEveNd-@pop-os.localdomain>
 <455281ec-3ee1-4f27-989b-c239f0690d8b@app.fastmail.com>
 <aixU_RccxS_BKhgX@pop-os.localdomain>
 <66eb8227-85b6-4684-a4fa-e3e17ac2fa45@app.fastmail.com>
 <e396ce86-ec84-4189-9da2-98af7cfa6c41@app.fastmail.com>
 <akWxrjOl4Up02Bvq@pop-os.localdomain>
Subject: Re: [RFC] connectat()/bindat() or an alternative design
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[johnericson.me,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[johnericson.me:s=fm3,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-303939-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[mail@johnericson.me,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:cwang@multikernel.io,m:me@linux.beauty,m:luto@kernel.org,m:brauner@kernel.org,m:axboe@kernel.dk,m:netdev@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:sergei@zimmerman.foo,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[johnericson.me:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mail@johnericson.me,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[8];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,messagingengine.com:dkim,johnericson.me:dkim,johnericson.me:from_mime,app.fastmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 21F1D6F3352

On Wed, Jul 1, 2026, at 8:32 PM, Cong Wang wrote:
> Hm? Why not just setsockopt()? Something like:
>
> struct unix_lookup_ctx {
>     int dirfd;
>     __u64 resolve_flags;   /* RESOLVE_BENEATH, RESOLVE_NO_SYMLINKS, etc. */
>     __u64 op_flags;        /* maybe future */
> };
>
> setsockopt(fd, SOL_UNIX, UNIX_NEXT_LOOKUP,
>            &ctx, sizeof(ctx));
>
> bind(fd, (struct sockaddr *)&addr, addrlen);
> /* or connect(fd, ...) */
>
>
> Zero new syscall is needed.

If this supports the `AT_EMPTY_PATH` no filesystem at all use-case
(which is what I chose to highlight in the previous summary email), I'll
take it --- it hits my desiderata. But implementation-side, I don't
relish the thought of even more state for socket setup --- since we need
to persist the lookup context until the bind.

If setsockopt is the "ioctl of sockets" --- a convenient way to de facto
create syscalls without doing so de jure --- I would think it would be
better to just make it do the bind in one go so there is no state:

    struct unix_bind_anon_ctx {
        int *connect_fd;       /* fd used to connect to this socket
                                  written to this */
        __u64 op_flags;        /* future usage */
    };

    setsockopt(fd, SOL_UNIX, UNIX_BIND_ANON,
               &ctx, sizeof(ctx));

Regular `linkat` can be used to place the "connect fd" in the filesystem
for regular file-based connecting (e.g. to cope with long paths), in
addition to how the "connect fd" can directly be used in the
`AT_EMPTY_PATH` case.

and for the connecting side:

    struct unix_connect_at_ctx {
        int dirfd;
        const char *path;
        __u64 resolve_flags;   /* RESOLVE_BENEATH, RESOLVE_NO_SYMLINKS, etc. */
        __u64 op_flags;        /* SOMETHING_EMPTY_PATH, other future usage */
    };

    setsockopt(fd, SOL_UNIX, UNIX_CONNECT_AT,
               &ctx, sizeof(ctx));

This is just what I had in my previous `summary email`, but with the new
system calls twisted into `setsockopt` variations instead. (I forgot to
mention the `linkat` usage in that email, oops, but it was always
intended to be part of the plan.)

Cheers,

John

