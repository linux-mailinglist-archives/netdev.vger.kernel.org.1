Return-Path: <netdev+bounces-154836-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F5329FFFAA
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 20:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45AC21630DF
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 19:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 078BB1B4120;
	Thu,  2 Jan 2025 19:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CvFVOb1V"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7EF192D80
	for <netdev@vger.kernel.org>; Thu,  2 Jan 2025 19:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735847439; cv=none; b=q2R89Do4IT2BgRy+JXqR9amwvW+rLTklC0FtQQxpQMcrtIlV1WXqFPL0asZPD0bhrlKjXKTZ3HmMX7JkDVv0P42e61sRvsDpbBpYeRfWPaXGg81ai8/mzlz3IByZ4MhkORzQlBK0/k/I8jsPLzani71Vr2p4werhYzCAmiR1JCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735847439; c=relaxed/simple;
	bh=hikHaU5A6ZERCizzmF3olOcrYqnscpNgaZ1dFvv8t3E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NewxgbfOCjAyJnm/XelZ4VFZ8vS1dUwHszqr52+LF7lBRwXYdxZlH0aafHm4QL5MXiptsHtsbhiLYRQxuec0l64iRLxxu/3ZQy1sNOWo10jCrHXWe1+co/MT/5GmeRbtI5jGj19VmKk/iUF354CWmsG3twm9Qnj0QhE6nOTDWAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CvFVOb1V; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5d0c939ab78so1450a12.0
        for <netdev@vger.kernel.org>; Thu, 02 Jan 2025 11:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1735847436; x=1736452236; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dQqcwEznfH4dIyWsmbuWUw21A7/GsyTNz1t3yoxE5oM=;
        b=CvFVOb1V4iSRgh9b2zdIthPYjc5k5WKHPFXos9y9uFwr0QPX6sLANNLjXlK3hUTFMI
         zO1piyqv35TMtR9QdfLL0NbyTjFitXlOxdYqUXgJ2ip0b90xlZSpPwXs6sBav1mYRxum
         73zHKQWL6WtgZZPuvfXKmJrluE94l+HZ/5xe2ZExKNE5/bQ+e3B1xquMIgzGQ1RAH3fr
         BHez8tJb8b6r+g2SJebMc7cjeaP+CTztw1dsGPV+EPJ8ujlAvK3ITcpQsv0c37iIpTnP
         Wo7f/6FmzGsth/IUezMFoapoInU9HyiK1KMVUdTxkxfLNnrc6/dnRHQBRwJKxxmBjzmf
         jX9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735847436; x=1736452236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dQqcwEznfH4dIyWsmbuWUw21A7/GsyTNz1t3yoxE5oM=;
        b=JBEb/Te0sZeT+oJIQh0cHQfbOugMK2GlGMwuOzChYIIN3EB2Xqph71hTmNs+fqqLUo
         BwvtxK4L8lMMgUpeg1XmZjztoDLmAKzjuvNzOGknEIK5ZM5Se3QdgeEnwR+i/FpxAScU
         F72Z83UPQvE0ajhmX9R6s09m5Ca25tERgb0c5zDdjRCt8WV1QfBeFXNq/5f/VLXVnqTg
         A/DIxJO4VmHym7E6vX83iYL541MAVUL3sQPh8DYyVJ8qCoe+PAO0lTMlee2T8K2ub84Y
         +FMGNNKXDYnQbEICV/qkn4MNEX8CRS31nzsF7xJguCsnPK/7iHTTUL+SuENdPJEH4+SO
         aVXg==
X-Forwarded-Encrypted: i=1; AJvYcCV2ZJ9fgvftptBvySjUxQ5PhV1N9cQMBWkw0OeWqShtJji4veq+TrRagLN1euiQmk/IWBjxVBE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywyo2dpWkp1DLXFg4EFVV36jPoUqS2zCgteCOaC156dXIppx6Gc
	GmV+FScifEsrBhBFqr6HaFoS2QA8hGJBlkqK708yuN0jXYmnR5pY0EVbxCHPPU76QB6lrmx+V83
	eMLKAiIecNNUGONe7nUiAf+lABL0KE5Z3vScI
X-Gm-Gg: ASbGncs1+D99LwZcgWG9/ji7Dy0y6bsCPczk7xD/f734fE7vCOSWgMcz/Otqc4ZWlHd
	CCKh0b/pUuOeffH27vL+kwOzl02O6Fsb10KdQBiKGI5v6ZcJ2wLZJfWLDFScL8PMCuuwtARM=
X-Google-Smtp-Source: AGHT+IF+W6308MNLm8eqRpg8VwO6Ko7WhFt2khTSToJXESq2dKiSq70a8A77kbshJahFIXNs2YSVh4OSTBHjOF7pVT4=
X-Received: by 2002:aa7:cd13:0:b0:5d0:dfe4:488a with SMTP id
 4fb4d7f45d1cf-5d9157a2789mr8800a12.2.1735847436406; Thu, 02 Jan 2025 11:50:36
 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241230205647.1338900-1-tavip@google.com> <Z3ZTWxLe5Js1B-zp@fedora>
 <Z3ZUFq7dyiRHrdmi@fedora>
In-Reply-To: <Z3ZUFq7dyiRHrdmi@fedora>
From: Octavian Purdila <tavip@google.com>
Date: Thu, 2 Jan 2025 11:50:25 -0800
Message-ID: <CAGWr4cQNhd2UQn33F_JJUE5tFrQgRHe0BZs-kGO4cno4uZ6HnA@mail.gmail.com>
Subject: Re: [PATCH net-next] team: prevent adding a device which is already a
 team device lower
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: jiri@resnulli.us, andrew+netdev@lunn.ch, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	syzbot+3c47b5843403a45aef57@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 2, 2025 at 12:53=E2=80=AFAM Hangbin Liu <liuhangbin@gmail.com> =
wrote:
>
> On Thu, Jan 02, 2025 at 08:50:42AM +0000, Hangbin Liu wrote:
> > On Mon, Dec 30, 2024 at 12:56:47PM -0800, Octavian Purdila wrote:
> > > Prevent adding a device which is already a team device lower,
> > > e.g. adding veth0 if vlan1 was already added and veth0 is a lower of
> > > vlan1.
> > >
> > > This is not useful in practice and can lead to recursive locking:
> > >
> > > $ ip link add veth0 type veth peer name veth1
> > > $ ip link set veth0 up
> > > $ ip link set veth1 up
> > > $ ip link add link veth0 name veth0.1 type vlan protocol 802.1Q id 1
> > > $ ip link add team0 type team
> > > $ ip link set veth0.1 down
> > > $ ip link set veth0.1 master team0
> > > team0: Port device veth0.1 added
> > > $ ip link set veth0 down
> > > $ ip link set veth0 master team0
> > >
>
> I didn't test, what if enslave veth0 first and then add enslave veth0.1 l=
ater.
>

Hi Hangbin,

Thanks for the review!

I was not able to reproduce the crash with this scenario. I think this
is because adding veth0.1 does not affect the link state for veth0,
while in the original scenario bringing up veth0 would also bring up
veth0.1.

Regardless, allowing this setup seems risky and syzkaller may find
other ways to trigger it, so maybe a more generic check like below
would be better?

        list_for_each_entry(tmp, &team->port_list, list) {
                if (netdev_has_upper_dev(tmp->dev, port_dev) ||
                        netdev_has_upper_dev(port_dev, tmp->dev)) {
                        NL_SET_ERR_MSG(extack, "Device is a lower or
upper of an enslaved device");
                        netdev_err(dev, "Device %s is a lower or upper
device of enslaved device %s\n",
                                   portname, tmp->dev->name);
                        return -EBUSY;
                }
        }

Although I am not sure if there are legitimate use-cases that this may rest=
rict?

