Return-Path: <netdev+bounces-167418-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96657A3A31C
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 17:45:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C97017400C
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 16:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6056026F44F;
	Tue, 18 Feb 2025 16:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RbZigOkV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C5E26AABC;
	Tue, 18 Feb 2025 16:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739897074; cv=none; b=WaOmrUjAkGehJhZWnzcTYH1j+LQuAUhZqZx+zBo0SZATvJWDwZLxVPFRHLtYrfuaB7FmisjQm2xZBPJF5p3PG5AmPHmfoZUfoBKD2pro/8TpZHXuSfWc9nzJuQ/nacbZb2UrbRvUXuw2kR6EzePpzTv1tUKlM8OPFLySJI4P5bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739897074; c=relaxed/simple;
	bh=acKv8l7utndNRoSH3+d9y7WD0hvnj6Oah/BQgu+2ZE0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q9XjmlfIafpZqH+7uqd5PKhyfQtK+fTGy1pZIWPUuQ/LWZ7cjBemBR4KV3cDSjXd96vHTic5YG+vnWad3IX57Yvsi/nagpijoOO+GWCe+lnq1vqzvpPlsok2lqMIvISYSJ+TIJeJMxtaE7GbepYFyxkgDTJDcOiOQE+CKJQtIDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RbZigOkV; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5fa2685c5c0so2813779eaf.3;
        Tue, 18 Feb 2025 08:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739897071; x=1740501871; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aj3BO06Rec3K2MH9jNK8RjWlEKsE3RpWRiFSAdS0VJk=;
        b=RbZigOkVxwvTZi+cmPbuZqAEsB9LZZ5w4PVUlh09SXrlJnzzSbigqCk733z9uAES6C
         AiZMFh4iBhnrKPFlSmQy1dC0jKAZFYR56WEfC9rctkFCK+ikFXNAZ0il+uDsW1jHvSuX
         WuJsdOVAVGs4wDjWP4tC50uIrURmYV22FD7EyvBkY0DiuCJUkQQkPbMm/sNy7aoSO6FP
         z+XgFCjDNsHiiw8nDyokTOr7DmqiUUWBCPApMjReNnBamD7XAR20Yf0p1O2xgcPYzZ6J
         5ouCoP1QXj/kgZAN+Nwl5VVXI84ElKPN8qRi4BxsSzFlaV8MQf8T6EkaQwS1hpUjubPO
         c5Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739897071; x=1740501871;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aj3BO06Rec3K2MH9jNK8RjWlEKsE3RpWRiFSAdS0VJk=;
        b=jknsVFhMlcthEZGDHlZJj2/dt3KrS8Cxd5bgiogI++ks7Mln1ZiutQuclqP3BIFDm0
         TxM8estw24h7aSM0tS4PwN+bYbZF/zZ0TDMBFck1zNTeZQyzDim2/LIJpq1+rYdGFU3Q
         Ypx4BuOGEe0LE92vEPm/bFLaf3UMtDpDBkvafxHyA4B/aTULF2lpjU8foHDnFuEw9Z3F
         0r6F4zepYKvGBli4VkI5pyLbpXb2XuPnuBiwQIesANnpSK8NVL9GiYHC5r3VqflnAooI
         RWyp7jlEcgI1fcq5YXGsFAqULOvv51WDTzZBqP+NypFoU4v4P8ensFz2svR8VqxKltda
         aLqA==
X-Forwarded-Encrypted: i=1; AJvYcCXXWouiY8X1oZFwrzD2SOGIZKllpCboJS+0fNirRW6z0Y/XiFEb57EMYFmChB/3anCUxADXAZ2ghR87dMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUSUw+BWRR61qMbtmq1inbE+vlDFVxWwBP10HtnCiPQVR7MxVb
	4kF+uFBaQC/aVBDiPIQQAj6czHhbZxDuwiGajukzhUgCP8g8GxwWtzcGoQuRheTJNwRKE7ER+z7
	2GsjwMzw5KxBrFeawVyc5Zff4eHgROFanSyI=
X-Gm-Gg: ASbGncuGY2CyEgHiz+/kPFObo3bBKsgKpg1YMJctgogxw4516jCvRY72Ht2CKHJvHwj
	SgDwzqHChwwmuLWXCzTAWBrsWROAGg5gqu5Talj2FSngACb1kQ0HWCW/QHCejXiC89iHNRCQ=
X-Google-Smtp-Source: AGHT+IHGoyHEDM5CkZjt1a5evAAB5ebfx99us5PkEu2TpIfLACImFGBXuYj4qZi425trEd/vyEY4iDE2KGIbCOzcj40=
X-Received: by 2002:a05:6808:1791:b0:3f3:d88f:7d1e with SMTP id
 5614622812f47-3f3eb0f50c0mr11037721b6e.20.1739897071098; Tue, 18 Feb 2025
 08:44:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAO9wTFggVh9LvJa_aH=dDBLrwBo8Ho4ZfYET3myExiqf0yfDCA@mail.gmail.com>
 <f5e6302e-f91a-4fc8-b12e-faebb7c26e05@kernel.org>
In-Reply-To: <f5e6302e-f91a-4fc8-b12e-faebb7c26e05@kernel.org>
From: Suchit K <suchitkarunakaran@gmail.com>
Date: Tue, 18 Feb 2025 22:14:19 +0530
X-Gm-Features: AWEUYZk0QBmdE5Kt03-t_deOrFiMdD3SAkcCR7YEut5kB6bOKJu_7EOvyxhmC8w
Message-ID: <CAO9wTFg17vQFj+dP8Qt5wqz4g+T+97B21nr1+z4bfvp5VKbQDQ@mail.gmail.com>
Subject: Re: [PATCH REPOST] selftests: net: Fix minor typos in MPTCP and
 psock_tpacket tests
To: Matthieu Baerts <matttbe@kernel.org>
Cc: netdev@vger.kernel.org, kuba@kernel.org, horms@kernel.org, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Matthieu. I'm sorry I was using Gmail and I realized from the
documentation that it shouldn't be used. I've configured git
send-email and will send the patch using that. Apologies for any
inconvenience and thanks for the feedback.

On Tue, 18 Feb 2025 at 15:48, Matthieu Baerts <matttbe@kernel.org> wrote:
>
> Hi Suchit,
>
> On 18/02/2025 10:28, Suchit K wrote:
> > Fixes minor spelling errors:
> > - `simult_flows.sh`: "al testcases" -> "all testcases"
> > - `psock_tpacket.c`: "accross" -> "across"
> >
> > Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
> > ---
> >  tools/testing/selftests/net/mptcp/simult_flows.sh | 2 +-
> >  tools/testing/selftests/net/psock_tpacket.c       | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh
> > b/tools/testing/selftests/net/mptcp/simult_flows.sh
>
> The patch is exactly the same as v1, containing the same issues: long
> lines are wrapped, corrupting the patch, like here above.
>
> > index 9c2a41597..2329c2f85 100755
> > --- a/tools/testing/selftests/net/mptcp/simult_flows.sh
> > +++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
> > @@ -28,7 +28,7 @@ size=0
> >
> >  usage() {
> >   echo "Usage: $0 [ -b ] [ -c ] [ -d ] [ -i]"
> > - echo -e "\t-b: bail out after first error, otherwise runs al testcases"
> > + echo -e "\t-b: bail out after first error, otherwise runs all testcases"
> >   echo -e "\t-c: capture packets for each test using tcpdump (default:
> > no capture)"
>
> Same here
>
> >   echo -e "\t-d: debug this script"
> >   echo -e "\t-i: use 'ip mptcp' instead of 'pm_nl_ctl'"
> > diff --git a/tools/testing/selftests/net/psock_tpacket.c
> > b/tools/testing/selftests/net/psock_tpacket.c
>
> Same here
>
> > index 404a2ce75..221270cee 100644
> > --- a/tools/testing/selftests/net/psock_tpacket.c
> > +++ b/tools/testing/selftests/net/psock_tpacket.c
> > @@ -12,7 +12,7 @@
> >   *
> >   * Datapath:
> >   *   Open a pair of packet sockets and send resp. receive an a priori known
> > - *   packet pattern accross the sockets and check if it was received resp.
> > + *   packet pattern across the sockets and check if it was received resp.
> >   *   sent correctly. Fanout in combination with RX_RING is currently not
> >   *   tested here.
> >   *
>
> How are you sending this patch? Using 'git send-email' following
> instructions like the ones from [1]?
>
> I do recommend using b4 to prepare and send patches, see [2].
>
> [1] https://git-send-email.io
> [2] https://b4.docs.kernel.org/en/latest/contributor/overview.html
>
> Cheers,
> Matt
> --
> Sponsored by the NGI0 Core fund.
>

