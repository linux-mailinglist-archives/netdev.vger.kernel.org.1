Return-Path: <netdev+bounces-121654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1508B95DE3F
	for <lists+netdev@lfdr.de>; Sat, 24 Aug 2024 16:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CD7B283254
	for <lists+netdev@lfdr.de>; Sat, 24 Aug 2024 14:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A507D16DC28;
	Sat, 24 Aug 2024 14:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OEhMYczx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266BD155758;
	Sat, 24 Aug 2024 13:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724508000; cv=none; b=TJ7twX8OpvZgWRrP+YCK7dOc/fZ2Mi+Yh+MtRoGbm9Iunw4Ze2RJ5TlZ4k3a8+Cpvx/OrsA0f3pey2TIWKtQ1mG+JHSCIAe2lSG0YICx6UsZOUIRgwkMPqAKxbMEb5WxOBRATyQJsgklazE/wFytjRmzuKIaiQW1S2tdrwgOG7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724508000; c=relaxed/simple;
	bh=7DenwJe5Q5gxgLqEx6p9tSIkzLkgpX/6LM7uPp7ASk8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KMzYSSEMB10dwRlTFinfLG1sPUksTnX2W+uSHkuty6dXtbq5yOV1b6qNRXYcyfy6ewaFv82NRqIEymXDJxIkwXLUusKfPumhTTtiqI/UXV6NJ/J+GUDYJqNIcc+ETiA5WyrrmPBchnuxv69zEu4iY9ZGccKP8lloUAIaBAES0k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OEhMYczx; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-690aabe2600so26403587b3.0;
        Sat, 24 Aug 2024 06:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724507998; x=1725112798; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MqqWG7jWEflAprm3XYwPwYXM5THanhEgtT8DiRIJ6Po=;
        b=OEhMYczxNpzgs1qanJmz1RC3ZBQXY2z6bRYbok/eAtaVCINujzwHzOALDhZtEMvyWg
         rPB3ovyP6u1YrcEeq/azCtlu9/zhYmJGhCEupDTa1FpCspSBBkevy89ivvHCfeQ8cL7d
         y5hmo3+yoQbj70fUwXAu7AdZgQbO3gCif71OUf23pAYKvehTI8CI1G6H3KjVKU7lkpk7
         kcJu9gmNXVxH8Ni+yPetJW0eDTARMsq2cL/WQBsyypeap4xnd/dXcbBT+gfjcYmbVELF
         JWAeMrNhAxCmLckzncB2rpiFAG1WXu/KPlJvxHKT9zDJ0q1w31W8ccyKchfsr9OvDJOK
         JVWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724507998; x=1725112798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MqqWG7jWEflAprm3XYwPwYXM5THanhEgtT8DiRIJ6Po=;
        b=Ii9kot0XrqTUucZiZ8grLQ1rTBuGhP2fT9KcQnTEtONkfWC7dYL/5/u3p2nEToBWzg
         AtuO9PMVdoAnzuIK3wtIGEH6hXL6eom09wA356hor3T1q9KajnxKeJrc93Z47+PsfLW3
         uxkjKBgHfGAYz1LFZy4niL49GACuugppBd3O9iysdIvwueAzKjXiXvP3KWv5UB0fV2yD
         oQjEAMeA0ucHZYIABDZXa20t+XwwzP6EfukD8PerK8EZ0fPBR0WpV1r3NWDr2SN3jyU+
         heggWmcSjEInc/MgrFxEQ0XycicxI/nWeLzmdyTNs/Oa6OdCSIlbTI8XreUyV1Bh1Yno
         xMrw==
X-Forwarded-Encrypted: i=1; AJvYcCW3RLsXnRc0KzzQMwvqpmQvjbHayYzgbYA+lqGjKc0s+OQ+RMZEHEgzihA4w6+s8d6c5h0cYOZV@vger.kernel.org, AJvYcCXmKSLxxzTPk73eMtLbY+cFmuvzk3j5I3SkFPwGK4dgrrXEHj3cFBwI6LuUEJoIGTWrbsY9GYCgluYI9ac=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSJnO41Gj1Kf++lz0wJksLIuy1BEh8JIJLirttORLyI3J9Ok4z
	tBnq1JfLgrx53YZR+/EMjbI1RU8haMZ42hcTL3zKkuQmOkodHOW7r14oQ/vBkBfOpe9XzSHxUua
	UJDWakMRfVk+8oGsVgejWdv8CrKJ0UW0m
X-Google-Smtp-Source: AGHT+IFviqpq1jP3VkEVZDbheujTsl2uon7FtBrSBpsULOHiduede9ztmnB2Dc6F8V3gdwJaX9whDQ6kO8RLq+nfmB4=
X-Received: by 2002:a05:690c:f84:b0:6ae:93bf:6cbf with SMTP id
 00721157ae682-6c625a4c76emr67523657b3.20.1724507997845; Sat, 24 Aug 2024
 06:59:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819122348.490445-1-bbhushan2@marvell.com>
 <20240819122348.490445-2-bbhushan2@marvell.com> <20240820153549.732594b2@kernel.org>
 <CAAeCc_=Nmh25RDaY4SA2CHsu2mqgdtKEo62b4QKSV4V8icHMMw@mail.gmail.com>
 <20240822074845.5f932d6d@kernel.org> <CAAeCc_mOjgWbftER2VmzK747D2gqqGqXrX29WeD+eRWkd-hqdw@mail.gmail.com>
In-Reply-To: <CAAeCc_mOjgWbftER2VmzK747D2gqqGqXrX29WeD+eRWkd-hqdw@mail.gmail.com>
From: Bharat Bhushan <bharatb.linux@gmail.com>
Date: Sat, 24 Aug 2024 19:29:46 +0530
Message-ID: <CAAeCc_=ud873LvHHucSK6fzUTOwLoir+CWxcvTn8UuxRgjajiw@mail.gmail.com>
Subject: Re: [net-next,v6 1/8] octeontx2-pf: map skb data as device writeable
To: Jakub Kicinski <kuba@kernel.org>
Cc: Bharat Bhushan <bbhushan2@marvell.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sgoutham@marvell.com, gakula@marvell.com, 
	sbhatta@marvell.com, hkelam@marvell.com, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, jerinj@marvell.com, 
	lcherian@marvell.com, richardcochran@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2024 at 4:55=E2=80=AFPM Bharat Bhushan <bharatb.linux@gmail=
.com> wrote:
>
> On Thu, Aug 22, 2024 at 8:18=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >
> > On Thu, 22 Aug 2024 09:15:43 +0530 Bharat Bhushan wrote:
> > > On Wed, Aug 21, 2024 at 4:06=E2=80=AFAM Jakub Kicinski <kuba@kernel.o=
rg> wrote:
> > > > On Mon, 19 Aug 2024 17:53:41 +0530 Bharat Bhushan wrote:
> > > > > Crypto hardware need write permission for in-place encrypt
> > > > > or decrypt operation on skb-data to support IPsec crypto
> > > > > offload. So map this memory as device read-write.
> > > >
> > > > How do you know the fragments are not read only?
> > >
> > > IOMMU permission faults will be reported if the DMA_TO_DEVICE directi=
on flag
> > > is used in dma_map_page_attrs(). This is because iommu creates read o=
nly mapping
> > > if the DMA_TO_DEVICE direction flag is used.  If the direction flag u=
sed in
> > > dma_map_pages() is DMA_BIDIRECTIONAL then iommu creates mapping with
> > > both read and write permission.
> >
> > The other way around, I understand that your code makes the pages
> > writable for the device. What I'm concerned about is that if this
> > code path is fed Tx skbs you will corrupt them. Are these not Tx
> > skbs that you're mapping? Have you fully CoW'd them to make sure
> > they are writable?
>
> This code is mapping skb data for hardware to over-write plain-text with
> cypher-text and update authentication data (in-place encap/auth).
> This patch series doesn't take care of CoWing for skb data. Actually I wa=
s
> not aware of that before your comment.
>
> To understand your comment better, If the device writes to shared skb dat=
a
> without CoWing then we have an issue. Is that correct?
>
> I do not see any other driver supporting IPsec crypto offload ensuring
> skb data CoWing,
> but there is a possibility that those devices are not doing in-place
> encap and auth (encap
> and auth data written to separate buffer). I do not have clarity about
> this, This skb is set for
> IPSEC crypto offload, Is this the driver which has to ensure that the
> skb is writeable or the
> network stack (xfrm layer) will ensure the same. If it is former then
> add code to call skb_unshare().
> Please suggest.

My understanding after further looking into the code is that it is the
driver responsibility to ensure skb is not in a shared state.

Thanks for pointing this out. Will change code in the next version.

Regards
-Bharat


>
> Thanks
> -Bharat

