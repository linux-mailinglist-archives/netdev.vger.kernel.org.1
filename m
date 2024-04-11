Return-Path: <netdev+bounces-87176-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 112468A1FB4
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 21:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4239C1C233A3
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 19:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C863D14F65;
	Thu, 11 Apr 2024 19:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="JDa0Wbtq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6C01757D
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 19:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712864838; cv=none; b=kMcfuUdQoiRa/xtNbAAn9BSKqr2gZiwqcJFSEWN4uTxsM2U2usxTBTL4cRwBl8ZInSbYKwQgRE/+QU54ifMpruoOtJtEbMEYrmhGfZKFYAk2toF5dcHeROChQ5opUsJzmucMBtJWXugD9VsSmVUVjV4y2+xqKPKLy96e0q1DUS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712864838; c=relaxed/simple;
	bh=RJ411NQukGvGANF1CFRduL37FP2qka08J+w82lPEm7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vCUilWA7OeYIeUU/8HOtuQE0ZsL+6xjMygg1aHTL21IeciUXkdzCmkJqAYqwqwQuwktkEcmkSvJ0hNdKZOTo5aYWG/rXwQ9f0gAPu7BogZG2nvqBNGlnSRiyeTzevFeKNs/Fy7XDOAKhoU1fLZIZQeSx8kc1A5nUD45UwOVZglo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=JDa0Wbtq; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6184acc1ef3so1371777b3.0
        for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 12:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1712864836; x=1713469636; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JFv4I7anGu3gsDIp81FsGte3DwjJSu9Sw0xRvjxNuzU=;
        b=JDa0Wbtq06k+Qcdq2QlXWGWl4Dr81EUwzZqEGaZ1c/54/SlHMswCiAWa6xFnbU8C9s
         vfnU6mCWNRvJxY8Vcfq8TcEUIOsccdTBE8BIVzBZ/CVWLqt1A9VyU80iXJiY4lpyOx0Z
         ucMbu2I0n5YmDwWE5LVc5hcxwTgs/oeU0h7bv+oIBjOQlrWNmriqsG2Zv013zH5Mith4
         WzKGPXcuJ3Lq/HBek5b8jY3Fvl+8u2GKAc89KJtAx+Ylzeu0ycjqQcq4nEEI+rRtjz4S
         ZZqzRMC01uaC9GsrM7VbUp02KKtgxwkj8QYiplkPH7mt/Dze+WvuUZ7XDLMHXEqYBdzw
         pEJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712864836; x=1713469636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JFv4I7anGu3gsDIp81FsGte3DwjJSu9Sw0xRvjxNuzU=;
        b=nfIc8xZqfJ+NWsvichdoRFQ3N/fAkL0HByfYIzhgB2zOvdwKR31n6g9W7XW8nJAWUP
         63U9Iv/2anxyR3zpjPEDaqRnsxVUyYsITiLtxwG6EEvlpi/TsYXlEAymWApK5UUr79fv
         OAnxYPV/n45Iflh0tYKnINXAINg2Ml7NtCMaHYmSEIP5eb5j1jq3zqIo5OAq4XG+mg05
         Sq60RTf+mEJeG/syfAy0HIbCDcyA4jaRp3IK0rVEzN5ERnX6hRNjyt8D/ahMRondZvJB
         qQSy01Sp1FzfJKmqoid8LRaKdkNFpZkG36ogU84W9gMGr2Ovr5gfleoOMBW/WHbgnWAu
         +1QQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6GS7WNm7pJaJBrNMzVdyq6M1hpzSY5afiyC+EjJSEUL30m7zhE/dL9rVsinVAoUBEvArCFBS7P85g3o1SK1Il3pRFv9GX
X-Gm-Message-State: AOJu0YyGRHs0JU7PQeSRPpV93CYs/MmgeAR0c+MhN8fURq1VwKzD8jlr
	vEjysA9arwj4kvhUeMn4ucHEdsKwHa1S71e/8MXqKuKzp4AN/OOtYlL6kCRhMfhfgo1g30LU2b3
	OjclcIGYhKiZvBl8LC1YxHZop1kG3iCghg0Jb
X-Google-Smtp-Source: AGHT+IHdCoVifKEcMOd98tKe1uOMwazi7j5Yu3mssA3gOw4eknclIkt19uODSH1i1svghuYQLd8Dk21HNeZio7FiLUM=
X-Received: by 2002:a0d:e64a:0:b0:618:2975:36c with SMTP id
 p71-20020a0de64a000000b006182975036cmr444653ywe.36.1712864836376; Thu, 11 Apr
 2024 12:47:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d1d6a20f5090829629df76809fc5d25d055be49a.1712849802.git.dcaratti@redhat.com>
 <CANn89iLyMv2JjEGRoAWb51TpxuMb5iCPb8dvTAmdJoZvx4=2LA@mail.gmail.com> <a76d497c-5d87-4d00-a0f4-147b3f747bf5@schaufler-ca.com>
In-Reply-To: <a76d497c-5d87-4d00-a0f4-147b3f747bf5@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 11 Apr 2024 15:47:05 -0400
Message-ID: <CAHC9VhSPb11cEgneKM1vbqjiuqLgvV+y933vhuhqHinWHtD_fg@mail.gmail.com>
Subject: Re: [PATCH net] netlabel: fix RCU annotation for IPv4 options on
 socket creation
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Eric Dumazet <edumazet@google.com>, Davide Caratti <dcaratti@redhat.com>, xmu@redhat.com, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 1:41=E2=80=AFPM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
>
> Please be sure to verify that this is appropriate for all users of netlab=
el.
> SELinux is not the only user of netlabel.

Adding my support to Casey's comment above.  If you go the boolean
route, please work with Casey to ensure that the Smack usage is
properly handled.

--=20
paul-moore.com

