Return-Path: <netdev+bounces-105803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD467912E0A
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 21:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 750DF1F21D9D
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 19:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B01F17B50D;
	Fri, 21 Jun 2024 19:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="E87BPt0G"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650CE84A32
	for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 19:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718998920; cv=none; b=ogKHOY89Y6llopOudPaYcK9VU51+2GjzzqAOg1HteFw7TjMn5rUamcMHC/b4w70MPcMtrpJ9x9hP0zY/dDq10s4NrX59l6dFwPVLwNaW+ZZPd708PGTOtG0lTrIo3I1BLhH2qAhoCneRVEFQwNZjSxDSVXdXFbMcMX1FGdzYbIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718998920; c=relaxed/simple;
	bh=KExI450lv/6bXsywXkdu57kjeIUgpdTEDKHbVulI/1E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=enLmj4/UMH15zPr66ZgfF+9dz6o+VB3WULsx9Q0C/uLPCk3qUvQblbns9hF37arjlzIOb9pjgG3yjvBQxMpEFN9IeaXmjgmSPHzu+0m/FtT2pNMpRwgYybuKMDppyKDm9Z/86m41/7y/YXqYocR7GMbMnp2s/EEguhCP7hxuO2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=E87BPt0G; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dfab4779d95so2384234276.0
        for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 12:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1718998917; x=1719603717; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0nl8PAG0N3k7cl8uPP8GgJj3UXR/oTyrXr4zXcY81uw=;
        b=E87BPt0G49cjChg3cyn94cnOi1n69M0oBxkU56hZGirtgejr5bVnBIdKAzHD/gENWH
         Pajj/j3HUw6h03qX33Jw4ektkAgkGYM221KEcNCMwit5Wkxgaf3MpoW3fA1tz7BMHXet
         JaZyIeQ/VSkXFKhyyqpVhaKOhp+mfj/RJaoW+BwhzPlH2owf5d/XCinAMfeWU1Jcejas
         votWGthaVfyGMvwWKyMT4r/JWLtAuJPZ4ePep/fFTzEdQ4MvZe4tnVYNLkIg4YTN2wNx
         Y2SyTu1QSaMQvdydWIdEusvSJp/d2zZFzGiRH3ioTLUMM1t/tGk1S7CovalgI/yUl83s
         e4Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718998917; x=1719603717;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0nl8PAG0N3k7cl8uPP8GgJj3UXR/oTyrXr4zXcY81uw=;
        b=QfHdutkVaE4x3AkFjwCObdCh9soQj4W5l9m3oslyV6M6XZIzIyNLEt8u7RxJgFJ57j
         xg+MDxxi/ax3C4RVBmfoNsrh21t9sxNgTgWqELC8k48ssFIjHexpUQcryqxMCO35ck83
         hFCAb5MmtUSyr9DxtYR48g2/iqAF1AgZsS5/nM5Pj8haFWQ8m0QdNYNnFQeMwA3j0nk7
         whNY4yFSTPmRpSr5pfjFWTgaFybU2uzD1F4nNC03CVWu8XpFDsoDML1m3QYoebw4g28v
         gQQgXDmKMdDBG9D9OSIIw4ZZmQ4n/PQGV1cVmbgbm+696F8uM2eXJWT4d0UpYSzzYZw3
         e9wg==
X-Forwarded-Encrypted: i=1; AJvYcCU1MCgJ2BF8XXndazjFCFAe2fxC5qDjpn3ZqnSVlTX7+1OMEKODFTcVpPCkMdtEQVqk0V01Rzrjf50YbANnNDaHKldxzqY+
X-Gm-Message-State: AOJu0YzaB2I09k67fIaq26bLOtyqXLtn0VHnssGUAV93H85j8hJMGzaI
	Xodzz6scpEqfC5CBxwDR7xThBr88kmzyqsmFARKW1OVYV3pEzFLDpDSjFVF57ZJD+MA2+tbPFZW
	QXjhVwnWMnTHsqN/x8ghLk1fjEkWZnw/QxJJj
X-Google-Smtp-Source: AGHT+IFqjYGwpyoxRZyIZIHsISDeLu99Cg9u66E+BBx796GAV73iaiCq6pmo1MtrecjU3A0LbW+kOkA/juAriiJ/AhI=
X-Received: by 2002:a25:818f:0:b0:e02:92cf:4bb6 with SMTP id
 3f1490d57ef6-e02be22d29cmr10427519276.56.1718998917309; Fri, 21 Jun 2024
 12:41:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <763db426-6f60-4d36-b3f9-b316008889f7@schaufler-ca.com>
 <83ef6981a29c441b58b525e9292c866a@paul-moore.com> <c59a4954-913b-4672-b502-21aa683d7cdb@schaufler-ca.com>
In-Reply-To: <c59a4954-913b-4672-b502-21aa683d7cdb@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 21 Jun 2024 15:41:46 -0400
Message-ID: <CAHC9VhRjbWuFeprjNP3r7tU27cW6bEZytWq-3XTjzoN7Ki-zzQ@mail.gmail.com>
Subject: Re: [PATCH RFC] LSM, net: Add SO_PEERCONTEXT for peer LSM data
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: LSM List <linux-security-module@vger.kernel.org>, netdev@vger.kernel.org, 
	linux-api@vger.kernel.org, 
	Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 12:06=E2=80=AFPM Casey Schaufler <casey@schaufler-c=
a.com> wrote:
> On 6/20/2024 2:05 PM, Paul Moore wrote:
> > On May 13, 2024 Casey Schaufler <casey@schaufler-ca.com> wrote:

...

> >> +/**
> >> + * security_socket_getpeerctx_stream() - Get the remote peer label
> >> + * @sock: socket
> >> + * @optval: destination buffer
> >> + * @optlen: size of peer label copied into the buffer
> >> + * @len: maximum size of the destination buffer
> >> + *
> >> + * This hook allows the security module to provide peer socket securi=
ty state
> >> + * for unix or connected tcp sockets to userspace via getsockopt
> >> + * SO_GETPEERCONTEXT.  For tcp sockets this can be meaningful if the =
socket
> >> + * is associated with an ipsec SA.
> >> + *
> >> + * Return: Returns 0 if all is well, otherwise, typical getsockopt re=
turn
> >> + *         values.
> >> + */
> >> +int security_socket_getpeerctx_stream(struct socket *sock, sockptr_t =
optval,
> >> +                                  sockptr_t optlen, unsigned int len)
> >> +{
> >> +    struct security_hook_list *hp;
> >> +
> >> +    hlist_for_each_entry(hp, &security_hook_heads.socket_getpeerctx_s=
tream,
> >> +                         list)
> >> +            return hp->hook.socket_getpeerctx_stream(sock, optval, op=
tlen,
> >> +                                                     len);
> >> +
> >> +    return LSM_RET_DEFAULT(socket_getpeerctx_stream);
> >> +}
> >
> > Don't we need the same magic that we have in security_getselfattr() to
> > handle the multi-LSM case?
>
> Yes. I would like to move this ahead independently of the multi-LSM suppo=
rt.
> Putting the multi-LSM magic in is unnecessary and rather pointless until =
then.

Starting with the LSM syscalls, I want any new user visible API that
can support multiple LSMs to have support for multiple LSMs.  Yes, the
setselfattr API doesn't support multiple LSMs, but that is because we
agreed there was never going to be a way to safely support that usage.
In this particular case, that same argument does not apply, we could
have multiple LSMs returning a socket's network peer information (even
if we don't currently see that), so let's make sure our API supports
it from the start.

Unrelated to the above, it would also be good to datagram support as a
patch 2/2 thing in a future version of this patchset.  Please be
careful not to carry over the mistakes we made with SCM_SECURITY (see
the GH discussion linked below).

* https://github.com/SELinuxProject/selinux-kernel/issues/24

--=20
paul-moore.com

