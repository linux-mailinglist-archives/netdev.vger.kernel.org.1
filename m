Return-Path: <netdev+bounces-100278-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F418D8622
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 17:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9D9F280DB8
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 15:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6BC312D205;
	Mon,  3 Jun 2024 15:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QRU+s6VD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251EA882B
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 15:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717428870; cv=none; b=o7mn6Tl+KIlOMxXtMjUDJDVs0RoScLeeQ/1GCl8I5xmXW9qrGa4c1BOhDb9xps7RYgRVi7LbCS7t7zVfazfynIB67pG1PN4X5oIysKoSqzdVlRoSbuB0sHZ8Avcw9lNr3+ZRk6aH6nyVJ+S2KczmsAudzhGL89ALShvP/RwIWrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717428870; c=relaxed/simple;
	bh=1/uCZXszIxQNFvzHMCL7Pb2pPP+nceiWKxd93q4xkvA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CzW6Y26/k/76+J8yOi1D6w5ikml9msT5+l/jUP/pwAGvuX7lTgttA5PiKyHVlFJW5Ri1f2yaZZPAkLmpL+0lH6YA3Bit6ztVddgIVWI4gEebmp2cGJ5x69GIdCMbdHlsOnpWRxFjWsDGBuRyWJ+DQLxJi9bzcfNsRPbQGhKELqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QRU+s6VD; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4213a2acc59so90075e9.1
        for <netdev@vger.kernel.org>; Mon, 03 Jun 2024 08:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717428867; x=1718033667; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SB+Niyqsb9G6AY/g2PsORoO7tDS0PedLeiBVhFR+6j8=;
        b=QRU+s6VDjb+f4dHGzavaG1/t7jaVpkPWmO7p/ADg1loCBOCh0HAAgWBapctH7Y/QZM
         3Ji1huDmMaJDpRS1sQZalr86Ar7R47uzyeZmqOw1K0ttv0hjLy6l4bCI5Nx4riW6Wtkk
         G4F7aID4fo8KHoHoNqQGhBc4ZFEmNKkgaFiown7PM3vp2yLHTwQBo9bOxr+JsP5Q27LU
         8ArjF4OOOzpIxnZuQzddUNELseBvVlg/XUxbbJJU7fiuDoTtkXomVSMOVu4K7AatZuOf
         VDzITvUR1kHKOptGGj8rVcf20spMeES14KeB7yCGqYjXL68zpBLHOy+/iAI9mdxDTgzS
         pbKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717428867; x=1718033667;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SB+Niyqsb9G6AY/g2PsORoO7tDS0PedLeiBVhFR+6j8=;
        b=g35LLrcZbLjNsA2LwQcZVXlYNBnhvEUCPj3eGb48IcpccE2qTD0tH8xQKXdS2PDvJD
         OQtAUPn9nKNR7wnAqFCXCwztjANXm+Y3R1jtF865StTarDEihCZUC18OK/7JXBVCUqjx
         V+ue6W5rrrfkFJPYonUR6OEJMVEXqF4gGuGqVSYaaG9NXERO16WeF6vQSiThadNn5Q9W
         JWLgHJx8yH0F1NQueWfyGWbIS/IDSzvKE2CzfcT3x2swQtU2XCuo7+06ex0qCRwNKY1o
         GgleR95ZEjka+Oaf4Zu6e1rQXAW+UV+7xhSzOHr1FNE0+qrp60kE7mRkuJIMBgGqf36X
         xshw==
X-Forwarded-Encrypted: i=1; AJvYcCWscddLKVHpZSeidrXRvsRU8YOLLgiCM2OhAiRwUtg7zyFM5eAEw0fwDy0pCAegBQosU4VNts8vx92z+H/Ezu9S/HzfyPOf
X-Gm-Message-State: AOJu0YyjU7fmOiQLxxHjb6hLej0m2h9Po/iFt5411TfdNs/TQdipp7Ik
	NjgMZ5dFyVjsa2WFqUIT8OiLnh25KrGJz8sQCHeIrWJtubSkMcrlXE3U0eYJnUZModjvnMat8PU
	uXrDXhmWbnaZ2xAglpeI6gYJe6rwwIhERBD3N
X-Google-Smtp-Source: AGHT+IEN5N79KFGCuJdHir4Z6UXOfYqecRuu7a345ZfpjDNysFd/cg4RZMWHtyiFWZfDXMLq3Pmhsubnnsh7axT38Qw=
X-Received: by 2002:a05:600c:2104:b0:41f:a15d:2228 with SMTP id
 5b1f17b1804b1-42134e35268mr4044245e9.0.1717428867027; Mon, 03 Jun 2024
 08:34:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240601212517.644844-1-kuba@kernel.org> <20240601161013.10d5e52c@hermes.local>
 <20240601164814.3c34c807@kernel.org> <ad393197-fd1a-4cd8-a371-f6529419193b@kernel.org>
 <CAM0EoM=jJwXjz3qJoT21oBsHJRCbwem10GMo1QStPL7MtUwTjg@mail.gmail.com>
In-Reply-To: <CAM0EoM=jJwXjz3qJoT21oBsHJRCbwem10GMo1QStPL7MtUwTjg@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 3 Jun 2024 17:34:12 +0200
Message-ID: <CANn89iLJe2HOQkuujJrCr=3R-DN_S2ALLcBBWuK3je2Nup4obw@mail.gmail.com>
Subject: Re: [PATCH net] inet: bring NLM_DONE out to a separate recv() in inet_dump_ifaddr()
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Stephen Hemminger <stephen@networkplumber.org>, davem@davemloft.net, netdev@vger.kernel.org, 
	pabeni@redhat.com, Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 3, 2024 at 4:05=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com> =
wrote:
>
> On Sat, Jun 1, 2024 at 10:23=E2=80=AFPM David Ahern <dsahern@kernel.org> =
wrote:
> >
> > On 6/1/24 5:48 PM, Jakub Kicinski wrote:
> > > On Sat, 1 Jun 2024 16:10:13 -0700 Stephen Hemminger wrote:
> > >> Sorry, I disagree.
> > >>
> > >> You can't just fix the problem areas. The split was an ABI change, a=
nd there could
> > >> be a problem in any dump. This the ABI version of the old argument
> > >>   If a tree falls in a forest and no one is around to hear it, does =
it make a sound?
> > >>
> > >> All dumps must behave the same. You are stuck with the legacy behavi=
or.
> >
> > I don't agree with such a hard line stance. Mistakes made 20 years ago
> > cannot hold Linux back from moving forward. We have to continue
> > searching for ways to allow better or more performant behavior.
> >
> > >
> > > The dump partitioning is up to the family. Multiple families
> > > coalesce NLM_DONE from day 1. "All dumps must behave the same"
> > > is saying we should convert all families to be poorly behaved.
> > >
> > > Admittedly changing the most heavily used parts of rtnetlink is very
> > > risky. And there's couple more corner cases which I'm afraid someone
> > > will hit. I'm adding this helper to clearly annotate "legacy"
> > > callbacks, so we don't regress again. At the same time nobody should
> > > use this in new code or "just to be safe" (read: because they don't
> > > understand netlink).
> >
> > What about a socket option that says "I am a modern app and can handle
> > the new way" - similar to the strict mode option that was added? Then
> > the decision of requiring a separate message for NLM_DONE can be based
> > on the app. Could even throw a `pr_warn_once("modernize app %s/%d\n")`
> > to help old apps understand they need to move forward.
> >
>
> Sorry, being a little lazy so asking instead:
> NLMSG_DONE is traditionally the "EOT" (end of transaction) signal, if
> you get rid of it  - how does the user know there are more msgs coming
> or the dump transaction is over? In addition to the user->kernel "I am
> modern", perhaps set the nlmsg_flag in the reverse path to either say
> "there's more coming" which you dont set on the last message or "we
> are doing this the new way". Backward compat is very important - there
> are dinosaur apps out there that will break otherwise.

The NLMSG_DONE was not removed.

Some applications expected it to be carried in a standalone message
for some of the rtnetlink operations,
because old kernel implementations accidentally had this
(undocumented) behavior.

When the kernel started to be smart and piggy-back the NLMSG_DONE in
the 'last given answer',
these applications started to complain.

Basically these applications do not correctly parse the full answer
the kernel gives to them.

