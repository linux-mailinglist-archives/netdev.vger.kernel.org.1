Return-Path: <netdev+bounces-70341-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 581D484E719
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 18:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BC09B2A316
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 17:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC86686124;
	Thu,  8 Feb 2024 17:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I314OgUw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253BC82D61
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 17:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707414490; cv=none; b=Z2OUTvTRVyjxWzRXIpEl7ZJLzGT+Ef6NkPvBf4Dy2qv7xgeGWI0buuozzLXIiYLkVPm4Ysm4trYbpQlE4iRHsh7mpgae0hD66D6/O2tQNxFBuz+SIGMHD9pHwK2cxZL8pYV7c7fRdAIIli+WE/ujlnLQvz2ntdyloWUsO9KL9oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707414490; c=relaxed/simple;
	bh=z4H3q+V584X3cloLoQL4z7W9A39ryrm0xdBvifZpO/k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P2pcO/D02ZF4wkgJhBLQtsrbBmTxa2kHfE3TSUfpjgI88W1zfUvMs1TE7/4O6+tRtQs3zEAwb75QSEObpKExq4bRwPx94JwANWiwSWbqZEQMaNlyeJ5SSmTMKSc/GmnROhmW0Hv+2NWL29x1snF/rOyHD++wO4/G76JHltuVg/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I314OgUw; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-560530f4e21so15439a12.1
        for <netdev@vger.kernel.org>; Thu, 08 Feb 2024 09:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707414487; x=1708019287; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S2CdXbb7WVGaal0hzp3f8lJdjgHwhFUuWNRhD/Ru7SU=;
        b=I314OgUwNasim2y3Bv0LjVyVJWpF9z9HVY4Ut50y6BCu5UZKylGtEd5f7GVRLWr3wH
         aOhD8srKNPfAY2lAQTbZ/eLFTBvuojpaHZdEcpDHplyUr+ssx7BPiU87zI3Rh3PIdoML
         7MwkiWm2QnItoSwuzx7NO5Pd8lK4NdlzpuLzb9VZeXS9mOdBQeGDkhX3GhmhK1DcdIzv
         TnNwnur2vp+D2KLESJFhKs845jicVEiJB8TXpivqRoqvBXxCEm2T0c2xxyX29Dob8RaB
         rjYmIuibPORxTVn5ImgfXr901CD3y0JTVSAwxNeXIkFexkq8/RnuuNXqS+dPWshQx8LR
         zBDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707414487; x=1708019287;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S2CdXbb7WVGaal0hzp3f8lJdjgHwhFUuWNRhD/Ru7SU=;
        b=LagJu+3n9m5BDECNIG6biDWQv/76cGrYQc66kXlqz6Jv22byJQuM8PPdivjeg3hH4T
         qpO63XrviuzTYVKTkbprUvW+zBkuZ+4DwjKEi5IDtNHxKgkMAVxG5zVe+xCUDr+Dxy7k
         XhMkBquhC5KihYPaJuOfthln5QeAW7sXEEFpmYDu86shW/sUA3Cqm6xcnSwHiUaRD1Iz
         RDoKbHJu6VNJMMKXxr9RxDtah4loDuvpCbG1+DOP1bSmoeMY6BAcycmn/H2OAH7Ae20Q
         Cl2RY+wBlixnvcgWna+kAA+4ofHGFTXOcrK2DmHZyDRgVaZgjpnkN6UPgBskQUhkcE0W
         PPlQ==
X-Gm-Message-State: AOJu0YyIkLpM1O7F6txIUAnpMRC3Xj6yjVqK5R0cCnescsa3SF/dDvMd
	0g0I9AgH5UqGb2oChjD5cTYldX1ogQe+YILmYiMVClc8KNmRZUXc6hkEsXpK1ALwVxaERYXAhoA
	1hcvX0DgSArT/oSrhkNpH+NELv1n6yHtSVKmy
X-Google-Smtp-Source: AGHT+IFx6D9+1QvqcwypiSW4MNJJCbBsNotpLlHoiufV7R69opJf1sckm7W6l77vtmstilA8dQaKIFFUNabofjpkE64=
X-Received: by 2002:a50:9e45:0:b0:55f:a1af:bade with SMTP id
 z63-20020a509e45000000b0055fa1afbademr418410ede.4.1707414487236; Thu, 08 Feb
 2024 09:48:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205210453.11301-1-jdamato@fastly.com> <20240205210453.11301-3-jdamato@fastly.com>
 <20240207110429.7fbf391e@kernel.org>
In-Reply-To: <20240207110429.7fbf391e@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 8 Feb 2024 18:47:54 +0100
Message-ID: <CANn89iKVoGUKZSBHanZ8zksmpnnysH1jng4KMgGpaqoyrP06Aw@mail.gmail.com>
Subject: Re: [PATCH net-next v6 2/4] eventpoll: Add per-epoll busy poll packet budget
To: Jakub Kicinski <kuba@kernel.org>
Cc: Joe Damato <jdamato@fastly.com>, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, chuck.lever@oracle.com, jlayton@kernel.org, 
	linux-api@vger.kernel.org, brauner@kernel.org, davem@davemloft.net, 
	alexander.duyck@gmail.com, sridhar.samudrala@intel.com, 
	willemdebruijn.kernel@gmail.com, weiwan@google.com, David.Laight@aculab.com, 
	arnd@arndb.de, sdf@google.com, amritha.nambiar@intel.com, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	"open list:FILESYSTEMS (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 8:04=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Mon,  5 Feb 2024 21:04:47 +0000 Joe Damato wrote:
> > When using epoll-based busy poll, the packet budget is hardcoded to
> > BUSY_POLL_BUDGET (8). Users may desire larger busy poll budgets, which
> > can potentially increase throughput when busy polling under high networ=
k
> > load.
> >
> > Other busy poll methods allow setting the busy poll budget via
> > SO_BUSY_POLL_BUDGET, but epoll-based busy polling uses a hardcoded
> > value.
> >
> > Fix this edge case by adding support for a per-epoll context busy poll
> > packet budget. If not specified, the default value (BUSY_POLL_BUDGET) i=
s
> > used.
>
> Reviewed-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>

