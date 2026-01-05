Return-Path: <netdev+bounces-246908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5B3CF2425
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 08:48:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D2D3B303212C
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 07:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028B926D4C3;
	Mon,  5 Jan 2026 07:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0a9JbC/0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF6423D7D0
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 07:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767599220; cv=none; b=Hc3YI4i1Ln0XsPHXe5FCqLoHSCs9svsCtrpgLLseH9GtsToM8noRp1DWFpMaMSU2KDz7u7+TDFQ1wAmpAxdKSs0OKUVNJXt/OmiDxAXGqKAkpe9NCzLjLKK869hBssVfUomtnK/pzRmBBf3ZRY2VKdnDmMpxBdMYWx0Ken7TlCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767599220; c=relaxed/simple;
	bh=3XiCPihyU+BrHOwDidi8R6JTp4P32E8+y+fnt6YdF7I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k0wefUNLg8KPCpPp1J4nstSUN7d4f9xiK/3fAqSSHwnnxhs3eS7kAILkAI6F0kdhJZIfPnRCTvsjSgo2QcN/8IQPhBiDSslu9KVr16viaq293I9F1yth5yf8lN0fSd9wv0WfgLJj7/sfTjDtFFBg3o7l/8YaxKRwdOWasVDDwK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0a9JbC/0; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-29f0f875bc5so205239305ad.3
        for <netdev@vger.kernel.org>; Sun, 04 Jan 2026 23:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767599219; x=1768204019; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0hl/znACV5IliyiNlDparHEHtCKNFypJX8ag2u4d1hU=;
        b=0a9JbC/0BW2at7gPpJHhyjQp+uXmZ80Lz2+OslH97517U6vIbmTFJ5DMOpJixpSlAW
         rVXEwU8WATs7p5iqd9rooS3BqCTxw8PUYIN7h3JU4bqXUKrWUI6IPJsRscHDejuhRXLy
         2MIXvcGh+LcKUh1+17pMAY1gHM2YhsDa2SbvSZ7kAQDQvwutp7V96tMzJiiHDbUwJeyc
         XVRf7inuBpfWsqqe0AnNnkMTIxSgSqpcVuzseG04wnauLDXWdr37OeJhO7xnkYabGMx8
         5b1Ogq0mABL4AEo4WnwETdwgLv8my27z+cBjfEaPzToKbqenNjD9uNj4yHxfEu/bbaI/
         t6DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767599219; x=1768204019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0hl/znACV5IliyiNlDparHEHtCKNFypJX8ag2u4d1hU=;
        b=ntuYMNOa898b1VBPc/RZkGzkakyQAkqfE1jPEPfNg4Ylzcgz922dEsobPxCD+IZjkX
         68dZj+J8r4JFSxR1eyw69ObpI1HfBHXuZRk1B9rgNXmLYl22xUQLsrgIKq3vkjQMiAFY
         VolMAU7liv38Vujs1h0mkN6MMeF3rUhIoJIAII1AnjFUGWBqeL4cuzYTX295sNq+XX59
         vbI3n2QaoKwc5jYZ8+JAE7qceWyO3Mss19ioF7LhK5ustlE1vPWoISG5ruxfUI83yPAc
         ewyx7dbEBVq7QpwtKDR7fZadbQqKEYzdQCMOjCxipeZIMRokAplRgRqRGEunvQvrf6Aq
         z+Hw==
X-Forwarded-Encrypted: i=1; AJvYcCUfVDF26EuxQjKIdCw+9ZR1w+qvBbmQuMpidRoEgMajtfX6a1LCpX8DzDARxRgLFdV3oPwVLvk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiTfG4yqbRyecdsbGesMPJhBjDD/FI8JgdKwcVhjCHYom2pOi4
	rmlxOr6VGo0JL6/hyMOc0XyRbhc+tGZMFXX7YFn0KabIHOP7NsatTTQuulVCTHPTGPMPhBtbj03
	PkX7yplr+rYjBpzXQAJyT6JJr9hV+4KNmvL1WKPNFyrHESY9X4jd02k0gC9I=
X-Gm-Gg: AY/fxX5fPGbWRFgChNx1eZvg0jtQ587f3I83tYcU4hdKqyqjQDyH61Myq5mQlPriQdd
	GpXDSsExrlGuXEkB9vH/c0P9E79eVspmL//wyFz+ue1DQHvPZUut/w//JHVeoIWzTtxAmP4YiMZ
	ei6NeqZtv5ah6qJvfnlK7m8ctbugJ7dfeAa3dxndXfLWhpOHpc5HZoTXxqj1bs11/XEM3URPf+9
	5tSN1NE+1bN5f9+cyOS/yn6aRoy6jpcGJnCHnVW+yjIeiWmNrJ5gDoxCV1/8Kncqc070YFaZ8a9
	ONU5o2hyIKPudesnFK/XYuDpMqA=
X-Google-Smtp-Source: AGHT+IHxteqHEVR6ADiPEOJqOaSNR6YKK2EGsZu1qZi7806i1GlWLIGb3zdwJ5ibA+pr3tr52Iqt+hLN3UxY0p3HaZQ=
X-Received: by 2002:a05:7023:a84:b0:11b:9386:8262 with SMTP id
 a92af1059eb24-12172314a24mr41233873c88.47.1767599218282; Sun, 04 Jan 2026
 23:46:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251231213314.2979118-1-utilityemal77@gmail.com>
In-Reply-To: <20251231213314.2979118-1-utilityemal77@gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sun, 4 Jan 2026 23:46:46 -0800
X-Gm-Features: AQt7F2pSIYBhYKUUMLWFXkv6Xu3AJ783nK6ntuzPyxaCJG9HeDmOp4yEEmYENqQ
Message-ID: <CAAVpQUCF3uES6j22P1TYzgKByw+E4EqpM=+OFyqtRGStGWxH+Q@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] lsm: Add hook unix_path_connect
To: Justin Suess <utilityemal77@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Simon Horman <horms@kernel.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	linux-security-module@vger.kernel.org, Tingmao Wang <m@maowtm.org>, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 31, 2025 at 1:33=E2=80=AFPM Justin Suess <utilityemal77@gmail.c=
om> wrote:
>
> Hi,
>
> This patch introduces a new LSM hook unix_path_connect.
>
> The idea for this patch and the hook came from G=C3=BCnther Noack, who
> is cc'd. Much credit to him for the idea and discussion.
>
> This patch is based on the lsm next branch.
>
> Motivation
> ---
>
> For AF_UNIX sockets bound to a filesystem path (aka named sockets), one
> identifying object from a policy perspective is the path passed to
> connect(2). However, this operation currently restricts LSMs that rely
> on VFS-based mediation, because the pathname resolved during connect()
> is not preserved in a form visible to existing hooks before connection
> establishment.

Why can't LSM use unix_sk(other)->path in security_unix_stream_connect()
and security_unix_may_send() ?


> As a result, LSMs such as Landlock cannot currently
> restrict connections to named UNIX domain sockets by their VFS path.
>
> This gap has been discussed previously (e.g. in the context of Landlock's
> path-based access controls). [1] [2]
>
> I've cc'd the netdev folks as well on this, as the placement of this hook=
 is
> important and in a core unix socket function.
>
> Design Choices
> ---
>
> The hook is called in net/unix/af_unix.c in the function unix_find_bsd().
>
> The hook takes a single parameter, a const struct path* to the named unix
> socket to which the connection is being established.
>
> The hook takes place after normal permissions checks, and after the
> inode is determined to be a socket. It however, takes place before
> the socket is actually connected to.
>
> If the hook returns non-zero it will do a put on the path, and return.
>
> References
> ---
>
> [1]: https://github.com/landlock-lsm/linux/issues/36#issue-2354007438
> [2]: https://lore.kernel.org/linux-security-module/cover.1767115163.git.m=
@maowtm.org/
>
> Kind Regards,
> Justin Suess
>
> Justin Suess (1):
>   lsm: Add hook unix_path_connect
>
>  include/linux/lsm_hook_defs.h |  1 +
>  include/linux/security.h      |  6 ++++++
>  net/unix/af_unix.c            |  8 ++++++++
>  security/security.c           | 16 ++++++++++++++++
>  4 files changed, 31 insertions(+)
>
>
> base-commit: 1c0860d4415d52f3ad1c8e0a15c1272869278a06
> --
> 2.51.0
>

