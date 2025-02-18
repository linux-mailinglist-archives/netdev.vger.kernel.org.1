Return-Path: <netdev+bounces-167262-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52491A3971D
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 10:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F359F188750F
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 09:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D582222FAE1;
	Tue, 18 Feb 2025 09:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DKGfDp38"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F27D22DF8C;
	Tue, 18 Feb 2025 09:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739870932; cv=none; b=jVCnInIX54bcuQ4h6w3GBH0r+9F5nY31fnuowWUcDYDqn48DaX3C8JAUN8AyjmiFMH1sDFLrKqLEEHgaAwEybVDWE14r6NwK4tP88qn667P6IiKDDW56F5opQAbEx4rd8VRJdN/99OyBQhd0OevbI2vyW5F+cx4g/E7T5f9Do4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739870932; c=relaxed/simple;
	bh=rF+DqFOfI59087a/Ev+sbb4fxL1DoZUspANuVUxya9k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VRJhiXX4E4MzkAx+pUjFXrTXJbJG2Jzcy9TawEW2TEmYENNu0baXVAmZ4zkSssluiegRPh7gR2N3kCOrv5++K6bz4tvIVAuB7NDi0jO76hdVrEeOV6nn5hHK766/sF4zFB9pakYVx6CI2FMGrugacg8rMiVYlQiZ7HBfjzRDKl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DKGfDp38; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3f3fc8f5ffdso427099b6e.0;
        Tue, 18 Feb 2025 01:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739870930; x=1740475730; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sezXMcausz+IaGoxGziV5wzbaNf+UQBQEy/lkhU+JEU=;
        b=DKGfDp38f10WhlXlgYTDOHCpGsTpcWlFaq1TVlRceYwlB4rvthZZT2H4AFswQkQZsp
         eeTICVUxsHFM0Qas2C6dQvTalt1c9Wnk8cyocUAoarZuMtZ4xuWFJXB4CbViFlVDw//6
         NyL/hybgzgkj6u7FTPHBf9qP2By/vhLNkUd4+HGG+XR9SBJZny13TQH8ukZN/OJXPx15
         i/Igig2qO6Vows6g/mdWH0n0CIjer92ILD6MzuGQOObmfC9tF13p8tAKtXWIOZ3hHCpW
         uVzTy2pzjBIDV1J+XvnR1X8OOwsimb/CKLaYhMVklptj3N83YWMXTdhHo2bpBwdfbqPt
         TZfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739870930; x=1740475730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sezXMcausz+IaGoxGziV5wzbaNf+UQBQEy/lkhU+JEU=;
        b=oxBZAN3cFdOWMXVeBqAS1HH9dimNQfk3wwtvFJ4kpNuaXZzVkCN8Ulhy4RzuKxdXfH
         ZdO879unPs22aep+kBXgWclePxGLwgz5LX8/sZvIgK02asByKLix/kbAjPhm1ZzQEn3c
         bGvNrWWZsL4JBNK8MWaTR/A5nfa2IHsaDU8IbJWUBwRPRUZjprKh82kD5UurR8k7qMMO
         usfoFpAvn/NTLxkT+olbsuv4GhKr62z6LGu44Zoc9g62luXe4QwriTo2CDgAIZqBle9+
         T8xkOZrXt6f58zNryUdIEpmm+aK8YtKHzToms2VY9MtWPOZTq++iDTBvBVPW6q53RPLX
         EEVA==
X-Forwarded-Encrypted: i=1; AJvYcCU8bUCGEouVloPlzRyQMpoiIX7QLlD61DaBAXcYvcE8J0n7eXZOLBq983C5qwJInigeBT7a51oF@vger.kernel.org, AJvYcCX6d/B35VMJST4rUN/PwxszIUokKZvp5qiuM/1yAeIZ+2Uwol7uEa5r52GGIoemDQsF2GxEoB8NSVFhwZ8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxfu4pCOG+aPIXLTyrqD5HcKj4F16Veim8NwBNEX+a1xL89rTr
	yIWq6PD+pDDXR8sBTDSA1NlBG7+AasJtfXY1IydNZngN/4V1FlXLi3K38zJvWwwXkUf9jS/17VM
	14RhYN13yoo1zwChDTnv6rbJ5JMU=
X-Gm-Gg: ASbGncsKWasxwgzqAl5MCc8Nv+0bM4by01vCjPEpeBkufMpbWyiLWygWTBRP2j7A42p
	mqAplcWKGAT3pdC3cOE2JUwXEfqyYvU8XiQR/d9HDLA9As+0jwdKqWf15iPbCUViKytmA66A=
X-Google-Smtp-Source: AGHT+IGME/AC8qe5AUB1a8euFWY1Fz/Kaovk/J9faa/18hil/HqjrzuUjLy4va4QJwZOd0rfOqeVA912FK10yH1bVmk=
X-Received: by 2002:a05:6808:1a25:b0:3f4:756:52cf with SMTP id
 5614622812f47-3f4075653f4mr2211945b6e.10.1739870930338; Tue, 18 Feb 2025
 01:28:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAO9wTFgN=hVJN8jUrFif0SO5hAvayrKweLDQSsmJWrE55wnTwQ@mail.gmail.com>
 <0c5f1dcf-1bd4-4ddd-b6c0-e3ee2b3671ea@kernel.org> <20250217153708.65269745@kernel.org>
In-Reply-To: <20250217153708.65269745@kernel.org>
From: Suchit K <suchitkarunakaran@gmail.com>
Date: Tue, 18 Feb 2025 14:58:39 +0530
X-Gm-Features: AWEUYZmqW1VEzyPQIcuB1lxWtLUFNSdx1n2rsSB5LI_l9n1oKwFOzJ96mNvsxiU
Message-ID: <CAO9wTFgjZ+in3ypHCKGOtY=K7DBBfJy82d6gXw=4mqJG4vtOjw@mail.gmail.com>
Subject: Re: [PATCH] selftests: net: Fix minor typos in MPTCP and
 psock_tpacket tests
To: Jakub Kicinski <kuba@kernel.org>
Cc: Matthieu Baerts <matttbe@kernel.org>, netdev@vger.kernel.org, horms@kernel.org, 
	linux-kernel-mentees@lists.linux.dev, linux-kernel@vger.kernel.org, 
	skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jakub. I've reposted the patch. Thanks.

On Tue, 18 Feb 2025 at 05:07, Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Mon, 17 Feb 2025 11:08:36 +0100 Matthieu Baerts wrote:
> > On 16/02/2025 13:25, Suchit K wrote:
> > > Fixes minor spelling errors:
> > > - `simult_flows.sh`: "al testcases" =E2=86=92 "all testcases"
> > > - `psock_tpacket.c`: "accross" =E2=86=92 "across"
> >
> > The modifications in MPTCP (and psock_tpacket) look good to me:
> >
> > Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>
> Thanks! This patch is corrupted:
>
> Applying: selftests: net: Fix minor typos in MPTCP and psock_tpacket test=
s
> error: git diff header lacks filename information when removing 1 leading=
 pathname component (line 7)
> Patch failed at 0001 selftests: net: Fix minor typos in MPTCP and psock_t=
packet tests
> hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
> hint: When you have resolved this problem, run "git am --continue".
> hint: If you prefer to skip this patch, run "git am --skip" instead.
> hint: To restore the original branch and stop patching, run "git am --abo=
rt".
> hint: Disable this message with "git config set advice.mergeConflict fals=
e"
> Waiting for rebase to finish Mon Feb 17 03:34:36 PM PST 2025^C
>
> So repost will be needed (unless Matt wants to take it into his tree
> manually).
>
> > This patch can be applied directly in the netdev tree, but I'm not sure
> > the Netdev maintainers will accept that kind of small clean-up patch
> > alone, see:
> >
> >  https://docs.kernel.org/process/maintainer-netdev.html#clean-up-patche=
s
>
> FWIW spelling problems are explicitly called out as okay there.
> --
> pw-bot: cr

