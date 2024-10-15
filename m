Return-Path: <netdev+bounces-135407-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D682E99DBF4
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 03:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 065131C2197F
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 01:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11C6157A48;
	Tue, 15 Oct 2024 01:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bZa2auGt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f196.google.com (mail-yw1-f196.google.com [209.85.128.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9D417BD3;
	Tue, 15 Oct 2024 01:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728957531; cv=none; b=A9gNmdSPt4SSnb/2hP9BKaB1Deepl8qE9v1aKXBWMs57adTX7PwEYqRPzDwh6wnDyXLmpkfV5hfSUCKYwxui3q3Fwil3erzyTQR7rZFbG2OAmtMvbsc8YVUfdRwE5JNLLRBMafjG009j+QuH0NUq3e5MMLgRIIbPzPwni6DLbEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728957531; c=relaxed/simple;
	bh=/0gsE0u6DA07Za63Ru15AVvJ6inJaTvSPG8xjdYV7Vw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aLTU8OqcOgnVBy0O816B8vSMFHIE7WxCYll+cPIKvI63nXiiAShTyn7NjsjAoRLvt549xae/sAy8EG87TCxTH7kfV+87hrUANAWaevYT93HOSjpqHksR5R+Q2rr8ZPF8yytNa4ubcIxlMzQyZ7V+Nw0kq/FdqM9j0+89sWrQirs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bZa2auGt; arc=none smtp.client-ip=209.85.128.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f196.google.com with SMTP id 00721157ae682-6e35f08e23eso23820517b3.2;
        Mon, 14 Oct 2024 18:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728957529; x=1729562329; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5gsbhtgFL9eLe0z8N0+DuikAHWepswx4QLWPWc7s490=;
        b=bZa2auGtFOzIuMVcgs/HMeX0gnpK8WKxkfCxEYaYYuyNUvFT+bUDja5e5Z1LMs1F8P
         A4J8Z6sGZvPjlTEF+zTWvePlzdcJxhd+XONVh/vCzRO8P6z/cyYD89pJK02eR++iRwJh
         cnchso0h9BzKAwqnIe3vq12fOcWfwHAJ5UEKCd69GY0RjVE53VmfRfdCue6vTRdtbvwN
         a+PFY+MEgg2sRJ6QkuCgJk0AL9STYByYoqjD2E7fHn7qE+c+2rDpKLUncIE52lb83f72
         5vJbM1qaabTv0clHQFvQ/mgY652ozVdek+pb5ibgi3XUuXMzDkKIMqcvtZX8slVGupZ6
         j9Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728957529; x=1729562329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5gsbhtgFL9eLe0z8N0+DuikAHWepswx4QLWPWc7s490=;
        b=R27cGlBtG7cvLhMXAx7y7rH4nWD+UBm9/I7bYrNFNH8Wb0dhhTGEV/OjpeOGRI7X69
         gWV+pvFtaJnd8+pup+lurpLcthE0b2cTM/D9YsOgCO9QqEgSML21aGa0YXdoWX4BOQiv
         +25P/rn0qOKkVSPzg584cTBQROQkEVHWrW/GJ6WSmth8Kl8yEbJ/NFzMQf2mnvMzEU9B
         a5GvKsS2RYefMWnLOiaROyC0EJY5ndP9Xsf38IR6L/qOjjvt0WkfxZBcUKws4JnWyGEP
         PvekareymlYe1n/Xe1egtcGd9ipF/19iFKZ0mo5NNMPhBC0/2eXHSt/reDMPP4GGF7lK
         /JCw==
X-Forwarded-Encrypted: i=1; AJvYcCUTVjpfs/u+nNPOn9h61i2tLRAc3YbXakVbc1qHLsJUzehTaP5fu0hCvn8fnO0slP0icwszck3TnM6B5f4=@vger.kernel.org, AJvYcCVAU8veTDu3Giz3pEBxyEMuKRBGYjNODGlymUTigC2G3fTiXAGkETeaDV/XqJ9vLdlFJN/pH1aU@vger.kernel.org
X-Gm-Message-State: AOJu0YxBg1tQyolqIg4P4DHrnGMKllO/+ehJvB5okrCdytzCXHb0hL7f
	+mZMY/fPlWWM8jz8eIMjFZ8u3UojNHDqceFAsubafBBVc2zKsUfGLHOBlFn79iSGmkC01n1APCM
	gcO/0LSgSiGKDVei96L1rIuocXIw=
X-Google-Smtp-Source: AGHT+IGRZLtUEZQRlXhNx/Bhkj2AdycqIRHwyIudTb83MPZjUuvtaZzUc9GdH+lXrWIoqSULqp1foFsjRPw4QyhPKvA=
X-Received: by 2002:a05:690c:289:b0:6e3:23df:cc25 with SMTP id
 00721157ae682-6e347b185d0mr99036847b3.26.1728957529235; Mon, 14 Oct 2024
 18:58:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009022830.83949-1-dongml2@chinatelecom.cn> <20241014172158.382fb9c9@kernel.org>
In-Reply-To: <20241014172158.382fb9c9@kernel.org>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Tue, 15 Oct 2024 09:58:48 +0800
Message-ID: <CADxym3a3OQ0tuxXT+i=BORVo69btM+XNUWmwCrUjs_pZtUuOsg@mail.gmail.com>
Subject: Re: [PATCH net-next v7 00/12] net: vxlan: add skb drop reasons support
To: Jakub Kicinski <kuba@kernel.org>
Cc: idosch@nvidia.com, aleksander.lobakin@intel.com, horms@kernel.org, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	dsahern@kernel.org, dongml2@chinatelecom.cn, amcohen@nvidia.com, 
	gnault@redhat.com, bpoirier@nvidia.com, b.galvani@gmail.com, 
	razor@blackwall.org, petrm@nvidia.com, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 8:22=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed,  9 Oct 2024 10:28:18 +0800 Menglong Dong wrote:
> > In this series, we add skb drop reasons support to VXLAN, and following
> > new skb drop reasons are introduced:
>
> Looks like DaveM already applied this (silently?)

Yeah, the bot didn't notify me this time :/

> so please *do* follow up on Ido's reviews but as incremental patches
> rather than v8

Okay, I'll send new patches to fix the comment of vxlan_snoop(),
and use SKB_DROP_REASON_VXLAN_VNI_NOT_ FOUND in
encap_bypass_if_local().

Thanks!
Menglong Dong

