Return-Path: <netdev+bounces-117306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D698694D84E
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 23:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 839D31F224B5
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 21:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8203B16130B;
	Fri,  9 Aug 2024 21:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G86yCL4r"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DEC1BC3F;
	Fri,  9 Aug 2024 21:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723237475; cv=none; b=tTkEkuSH8Mj/IrRYgV0lhXpi7PCVT0NgtVstU/7TbooWqm4TSYJBO1g5LZqvDwFX9jnRRFmbel8Fs4ivSzvwWia17OuEy8PoMYucOECm6bIHXjfvBULjKDHPAcIst4QdQUdL3gwohTn7M5IUZAko/613rLwas3icoDCYxLDEqS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723237475; c=relaxed/simple;
	bh=95JjyygR4tO5JbgyGND0lwDKhwC9bfD2bHVCr7YXIq0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ceP/PXNHhQibyYEqE8IP2fdPR0Qs9agGT4WfDMRZqqkTpLspOg/H6/wcABrky7VsxG1rbJvjLWTnlWH0ImrBlGOk1FFC18tazsqI63GeqXmpDtx6cFXkU0lw4ZyHWWYi/zpYkRBjNjypxzoWqftJYy3Tl+ZVNWb7DChZMDoOCuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G86yCL4r; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2cd5d6b2581so1949337a91.2;
        Fri, 09 Aug 2024 14:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723237473; x=1723842273; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=95JjyygR4tO5JbgyGND0lwDKhwC9bfD2bHVCr7YXIq0=;
        b=G86yCL4rx7RTSrqKl6Nl+cG/3otujit6yEQNG/+pfnV/tYcqqlrbgXwBRM3fWMe5rN
         Ct95p3aFA8z0ZlKO7+rYVL+xTSqG1GLuIzNmGGGb7x8gCAsvJxtzfRWqvUx2K/Zut4gz
         JyE5Ir4v43J3r/qcM7Wp72GuGz9pRWsJz5sGHeHxf6ab6N9i/wdDh9m+dPpKiYews42Z
         FsJoT1/7MacK65CgZ5/9PfT8tNglQubmn1VvOtahcIurOnWpcRzhjU2lJrcGExpPoKvz
         teyWSmRyiBXOoQIUS3BdTcCRznN7VLZJjZcVLKLhTfgqNiAA28W9idH1ZkE302yJblN4
         /W9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723237473; x=1723842273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=95JjyygR4tO5JbgyGND0lwDKhwC9bfD2bHVCr7YXIq0=;
        b=DbzWBwtcVu72JfIDau9caKIJEnDWkFmNPT8d+EyCJPvwBeZ4I4PRcofCyM8rUi/BlB
         jICUDiBaOFMrNavNgh35I+fbCvVIule49lD5mg0xbSyfaO9pnbzCIg7faiR5yoTi+aMD
         7J5iw/bh2Uq97eJfIcrt2QOKKRvuo23wUBtA/wHco0CcZpkxyaPVePi9Cg8kXuk4y8Ub
         murGKv9fdDShwtm4CQuH2dv61gzzqKjO7zBRfKzP44kAwaZuO0AuhLi5kVBCCZtP8im+
         BRbhzC0q+QWsiLJIgU07uDNUvPaPnNgnairXEOM1OAcKZpw9xvrRdCxjgZNFmGm6kkT/
         1ukA==
X-Forwarded-Encrypted: i=1; AJvYcCUJtDFackKuiAA281vX83s+fj+P1T2jEQgy2pyLVEJczHMAhd+57xQ0nPzhD9FEGOzJWy5w8yBClgZYE5Y=@vger.kernel.org, AJvYcCWIOAQKwsMyylgHTmoJ994iYmaCxwb8GW3NpHmXz091JLVT+wiH8sXOv2GD74LNZDmKKwO09ajo@vger.kernel.org
X-Gm-Message-State: AOJu0YyuMSVDGQIz244ookUigzBElW9OMPtStvQJBx5roUqYYaoJD8SM
	PcB23SCFnZ84jngBepPO6vSUICDLat+bHbE9K/wmofkUpbD7HOcUj3508SzZ7p1FjiJiCsZw5UR
	5+VBeQxcRuBCy2C43Fgnqg3Bg0vk=
X-Google-Smtp-Source: AGHT+IGIyZ5U7cqcZ40VbqeooH4Qf0tVDrqs5+1gcMwzCTlfq4bBrKgLXVdcZ9ET35Mjo/OcP2P0B6t3yNG0rXVw8TE=
X-Received: by 2002:a17:90a:c17:b0:2c9:7616:dec7 with SMTP id
 98e67ed59e1d1-2d1e7fa9fd7mr2992901a91.6.1723237473184; Fri, 09 Aug 2024
 14:04:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAN0jFd1kO0MMtOh8N2Ztxn6f7vvDKp2h507sMryobkBKe=xk=w@mail.gmail.com>
 <87y155wt0d.fsf@intel.com>
In-Reply-To: <87y155wt0d.fsf@intel.com>
From: Daiwei Li <daiweili@gmail.com>
Date: Fri, 9 Aug 2024 14:04:21 -0700
Message-ID: <CAN0jFd2Sa0ba7vewLex6x3MAjsH3LtNrgMdL-xVLFjLcp8_XEA@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [iwl-net v2 2/2] igb: Fix missing time sync events
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: anthony.l.nguyen@intel.com, davem@davemloft.net, edumazet@google.com, 
	intel-wired-lan@lists.osuosl.org, jeffrey.t.kirsher@intel.com, 
	jesse.brandeburg@intel.com, kuba@kernel.org, kurt@linutronix.de, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	richardcochran@gmail.com, sasha.neftin@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Of course, I'll prepare a patch for that.

Excellent, thank you!


On Fri, Aug 9, 2024 at 9:39=E2=80=AFAM Vinicius Costa Gomes
<vinicius.gomes@intel.com> wrote:
>
> Daiwei Li <daiweili@gmail.com> writes:
>
> > Hi,
> >
> > It appears this change breaks PTP on the 82580 controller, as ptp4l rep=
orts:
> >
> >> timed out while polling for tx timestamp increasing tx_timestamp_timeo=
ut or
> >> increasing kworker priority may correct this issue, but a driver bug l=
ikely
> >> causes it
> >
> > The 82580 controller has a hardware bug in which reading TSICR doesn't =
clear
> > it. See this thread
> > https://lore.kernel.org/all/CDCB8BE0.1EC2C%25matthew.vick@intel.com/ wh=
ere the
> > bug was confirmed by an Intel employee. Any chance we could add back th=
e ack
> > for 82580 specifically? Thanks!
>
> Of course, I'll prepare a patch for that.
>
> Thanks for digging that one up.
>
>
> Cheers,
> --
> Vinicius

