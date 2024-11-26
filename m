Return-Path: <netdev+bounces-147457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A79F89D9A08
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 15:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 594D8165DFA
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 14:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5BE1D5ADA;
	Tue, 26 Nov 2024 14:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FE6ybjcb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4991C22334;
	Tue, 26 Nov 2024 14:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732633077; cv=none; b=E9417yqWcLQj98KEuo1KEAz140z2hc0DK9fbNW3yO5ftXLXzKVKqqCLEqR4HgiQ3cQWIVZTqU20Y8vcUTXx2+YcJMzZKbgrVUp3cU5FVc1ad6Ysw9exryfn7wMuLosdLzOh5OQNRuSvK4KXTWIs2YO6e+yYCEe1HirsYXLyJaHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732633077; c=relaxed/simple;
	bh=zUBGXZjHem0gkf6lSs5y6g3Uszs4mufd4BEtZVD8khg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V1Wyxqip3M1o+JrHMxH3cYrLQz9fPJn8yDh1iZ1EpNbznjLryb4fhVCbXyJeFuN0bexxU0bPO6RlzJ1hswGfzdQp2+W5athBH+4XjSJuXgm8i8Vtr2IwdTdHV7W4IPPKzpuucj02CD4yarWMUnS0T1CahPPuY8+nNrPqj/hk3Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FE6ybjcb; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2ff99b5ede4so56736991fa.1;
        Tue, 26 Nov 2024 06:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732633073; x=1733237873; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ckvJIjZdkpd2N85ffKYpm4KEmJwjPaIR1j8uP61d0Ho=;
        b=FE6ybjcb7TJBjGapAvZtCQswC+RnaSvp4uohOQ1PbcJpHDUUY+DsPGhKAgVP7zZ495
         cXBxj+2Zo5P83leaffeEOb2iVvqRnBkb3jXToNXimvzurAhb9+ZkasQ4wO1TYkHzqat9
         wCdfUsYBzzWADCxIDyoit2h9zYSMPfUH+NTGKMiLwZQgpNNffTzUR67a5E5K8cOiF1y4
         HwcHFxa5UL5u8QcX7Ma9RExw1wKMnJL1FRWkkM2WkgwEK4/ryyejHorQcuc6k6PlX2qE
         rTZZynGJHLdRH8WwVOhMukNysXjmvIiaO8Q5coKTBrEa3Rg1WECQ4/EC5jhvaU5Erz2r
         BP9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732633073; x=1733237873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ckvJIjZdkpd2N85ffKYpm4KEmJwjPaIR1j8uP61d0Ho=;
        b=oGLX/1qxh4XZf5lD9KXj9XIUALdBSOmEPmUmFBZS8T0LSjFJT7i1SYgrX5ceAamky0
         wGqqstfUUzOZWtHdxBrjHLsIFkhJ96rh/TthNTyB1Hj6SxsNGv00opssmYNMDK0+V3dS
         6zYhay/wza9wU/KE2qHrkKrAbg2dYcXl1UBYO6qDDrObWGka0uKuVO+JeEvOIwgNLuuR
         3pC/HikRke94sZVQ9w0mV5G4YAmn4r+6lxtoqyBcsBf6ZOuTZBdoS2gSO2rKEeYOC3Dv
         U5v+aj6CM/j3EOyVzvdIKdS9P9kzKN1Zv21V5nXP2n350npRAmid/EQA5JiVLDuxHDBy
         AK3Q==
X-Forwarded-Encrypted: i=1; AJvYcCV18laiTR7YSXE6aJZPmmQI/MBziciggGzaCBgsjZzVzU+xfIHpSHWss7nop1GX61KT5FtI4c8VvV6Ehq92ju8=@vger.kernel.org, AJvYcCVqdYFGQk5eAfYoeiahdRp1prgEy0NgbdUUHBvJUwaDPrlLJtOsdHDxbkqSL+fi4RB8JkghrgY2@vger.kernel.org
X-Gm-Message-State: AOJu0YzVp2WHVruIArq6qtAmpX8ntCRrnaMcfsD8iQmMSR2UkhWA0ZB3
	3hmt9BY3UtdSSEG+QHrRs1K0nxhCYS4HTS4h1l+/5eybnwkEoy1nB7LJJ0/yH/Wqo5qo/e0WCnf
	pNR7Byi6RDUej7lVPt/pFI07dxkg=
X-Gm-Gg: ASbGncuKk049aLvqJSiGfMz+/70hoocTW/Kz6NUaMnW59pSAAklFBsQwvAx6uEFsyN2
	j+9W5VsIxuidDqACzJu+ckIDEXTzokMSe
X-Google-Smtp-Source: AGHT+IFfyN4039Knpq36PH+TpFo2xoFGOUn7tSeGfnipAHlLG9ZUzE/zrc6AsiUIeNUF8OV+ByB0gAUfzI8SoMdBfG4=
X-Received: by 2002:a05:651c:150e:b0:2ff:8f67:bc6a with SMTP id
 38308e7fff4ca-2ffa6d1e153mr88033001fa.0.1732633073056; Tue, 26 Nov 2024
 06:57:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241119-sockptr-copy-fixes-v3-0-d752cac4be8e@rbox.co> <7f968fde-8a41-4152-8b39-72d5b21a19a2@redhat.com>
In-Reply-To: <7f968fde-8a41-4152-8b39-72d5b21a19a2@redhat.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 26 Nov 2024 09:57:40 -0500
Message-ID: <CABBYNZKyfD5xNrPpfaDpGqwtOf+-ePfAa3njK1w2nrEKtpuavw@mail.gmail.com>
Subject: Re: [PATCH net v3 0/4] net: Fix some callers of copy_from_sockptr()
To: Paolo Abeni <pabeni@redhat.com>
Cc: Michal Luczaj <mhal@rbox.co>, David Howells <dhowells@redhat.com>, 
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org, linux-afs@lists.infradead.org, 
	Jakub Kicinski <kuba@kernel.org>, David Wei <dw@davidwei.uk>, Marcel Holtmann <marcel@holtmann.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>, 
	Marc Dionne <marc.dionne@auristor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On Tue, Nov 26, 2024 at 4:00=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 11/19/24 14:31, Michal Luczaj wrote:
> > Some callers misinterpret copy_from_sockptr()'s return value. The funct=
ion
> > follows copy_from_user(), i.e. returns 0 for success, or the number of
> > bytes not copied on error. Simply returning the result in a non-zero ca=
se
> > isn't usually what was intended.
> >
> > Compile tested with CONFIG_LLC, CONFIG_AF_RXRPC, CONFIG_BT enabled.
> >
> > Last patch probably belongs more to net-next, if any. Here as an RFC.
> >
> > Suggested-by: Jakub Kicinski <kuba@kernel.org>
> > Signed-off-by: Michal Luczaj <mhal@rbox.co>
> > ---
> > Changes in v3:
> > - rxrpc/llc: Drop the non-essential changes
> > - rxrpc/llc: Replace the deprecated copy_from_sockptr() with
> >   copy_safe_from_sockptr() [David Wei]
> > - Collect Reviewed-by [David Wei]
> > - Link to v2: https://lore.kernel.org/r/20241115-sockptr-copy-fixes-v2-=
0-9b1254c18b7a@rbox.co
> >
> > Changes in v2:
> > - Fix the fix of llc_ui_setsockopt()
> > - Switch "bluetooth:" to "Bluetooth:" [bluez.test.bot]
> > - Collect Reviewed-by [Luiz Augusto von Dentz]
> > - Link to v1: https://lore.kernel.org/r/20241115-sockptr-copy-fixes-v1-=
0-d183c87fcbd5@rbox.co
> >
> > ---
> > Michal Luczaj (4):
> >       Bluetooth: Improve setsockopt() handling of malformed user input
> >       llc: Improve setsockopt() handling of malformed user input
> >       rxrpc: Improve setsockopt() handling of malformed user input
> >       net: Comment copy_from_sockptr() explaining its behaviour
>
> I guess we can apply directly patch 2-4, but patch 1 should go via the
> BT tree. @Luiz, @David, are you ok with that?

Sure, I can apply that one if there is no dependency on the others.

> Thanks,
>
> Paolo
>


--=20
Luiz Augusto von Dentz

