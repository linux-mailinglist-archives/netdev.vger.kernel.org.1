Return-Path: <netdev+bounces-128670-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE0197AD08
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 10:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2FBAB26D98
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 08:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D27158550;
	Tue, 17 Sep 2024 08:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xp5NHVZc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D8415689A;
	Tue, 17 Sep 2024 08:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726562721; cv=none; b=i4KxgJmahvhwklRzuBXbITf4vGZGeM4lV0K62p2jgj/cpmyQqR9fRrH4oYtbLjNidVmIQQCe6XIICfjyGP73c49lAykFketdB3GydTSeGPzfmmo73Blj25Nc4dPdC3XV1nxW5KrrOTtGOht51256PSTgSZFcgXIDSjQsHHB7pGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726562721; c=relaxed/simple;
	bh=y+pWxGvGgH9u0hhKK+QZJVtcntnBZsyZchYJw41PpHM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=hS+Dk/TXhUlwZMYeiWbdvv0s1qOculzAZPsdasXCfiPmYvWiSAtusnZaWD77oXIni2f4IgkAG9VuulCPw7A8qwXPHGa1cXN6huEdy/XBo0jDqUxhOpj6xIpIEJosGi+o+gF58OB85iTRBPk+ShHN1892qgWVHhOEecMHZMdCnOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xp5NHVZc; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7a9ac0092d9so250519185a.1;
        Tue, 17 Sep 2024 01:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726562717; x=1727167517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5+5UG83gqFAAzo1DmGhZKki5qbeLYQrCYs3Ps8q0c9E=;
        b=Xp5NHVZcLUpMXV6lDLj88v9N90k/vtplEwj/CLHalqtovg5rPXpXq1A/E8EN//5Mzo
         HU1JuN5SWdW8iOHH1R2biBrwdiJQjy01O3pvV9U0o1fDuPaJrVVgC0DrrINMk5Us34li
         h90ea21t2ccdpsNJ/vJ3u2fHE2hABChYBLHa0iQTmJTl4S+lVicyQk6p8j/1b506kXqg
         4GXkT8/eprft1MiDZuWFNB1mNZHfeTZ/k4o+LhBPklUDlCAl6gjd0ADGbBWLNTdlJZrt
         ItAW9HFEXaBf1WdKpBkK1JvLxCe68fFC9uF9DJz25JQxHJz6DyuBUAulRu6gXiOft/0u
         p1sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726562717; x=1727167517;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5+5UG83gqFAAzo1DmGhZKki5qbeLYQrCYs3Ps8q0c9E=;
        b=V0rCpOpULwMOyn/GMv+fkGyDMjTPt9um3fqmRWI8oe2noQUQtc+uN9gjZ1mfs6QGel
         6WjHbwlkVHf0doNW/cDHw0o5YtvAcIRxSIEIQ1EL7O86hVj5V9bHhZup3WFE4FLlcoB4
         DpKZCwvhjz0prrnrvBWw69NlleXkpCmqzgG5B1FK2kmzqkZ5AhQsznbC7+5sET9cqQS5
         SmZvpQVILULnGl1NnjIhLvKX820YV5Ze1ZLGRd0wZ2Ae0GyLS1Ff3MxhCWckjeaUrels
         5QloxAY1k2KQJeQBLslp9Sv+sqWP8v7qyRAUZA1iACjM1pf6P12G0uMmhNnZoGEvDPOH
         NoLw==
X-Forwarded-Encrypted: i=1; AJvYcCUJmQVH0h4ZYm+cnblm55Gy7vcmFpi8J0FLnOw+eYu/855qWzFiYWqrXnyovka73Aidi1/oPJ1/Jv179SA=@vger.kernel.org, AJvYcCVtc+Y0cuE3tlmdCqm/ueaMXEYaBgCOJg4bVQF8L43DrrPcqzplgJDAGgQLZ2Cr6JUlRqYH54Um@vger.kernel.org
X-Gm-Message-State: AOJu0YwrjwKsSRao2MHOvTAJ9uOX3yRA3Loqa0LLrtV34PtetGXi5k/v
	DRcxdEhyndfprdlwIxXCyVf1b+PlDSGlRJmX1S1dF18iHi3i0yl2
X-Google-Smtp-Source: AGHT+IGzTM+igHKo8tgese8eUxD+qyvSIZo3MJgTBs063qWO3xIHpoeiQfm2xBjOiExCtuTGdeK0dg==
X-Received: by 2002:ac8:7fc8:0:b0:458:21f9:5a84 with SMTP id d75a77b69052e-4599d2d14e8mr264171281cf.54.1726562717264;
        Tue, 17 Sep 2024 01:45:17 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-459aad04446sm35518391cf.66.2024.09.17.01.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 01:45:16 -0700 (PDT)
Date: Tue, 17 Sep 2024 04:45:16 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Zach Walton <me@zach.us>, 
 linux-kernel@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowang@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org
Message-ID: <66e9419c6c8f9_2561f32947d@willemb.c.googlers.com.notmuch>
In-Reply-To: <CABQG4PHGcZggTbDytM4Qq_zk2r3GPGAXEKPiFf9htjFpp+ouKg@mail.gmail.com>
References: <CABQG4PHGcZggTbDytM4Qq_zk2r3GPGAXEKPiFf9htjFpp+ouKg@mail.gmail.com>
Subject: Re: Allow ioctl TUNSETIFF without CAP_NET_ADMIN via seccomp?
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Zach Walton wrote:
> I was debugging a seccomp profile that attempts to allow TUNSETIFF in
> a container, relevant bits:
> 
> ...
>       {
>             "names":[
>                   "ioctl"
>             ],
>             "action":"SCMP_ACT_ALLOW",
>             "args":[
>                   {
>                         "index":1,
>                         "value":1074025674,
>                         "op":"SCMP_CMP_EQ"
>                   },
>                   {
>                         "index":1,
>                         "value":2147767498,
>                         "op":"SCMP_CMP_EQ"
>                   }
>             ]
>       },
> ...
> 
> ...but I get:
> 
> Tuntap IOCTL TUNSETIFF failed [0], errno operation not permitted
> 
> Looking at the code, it seems that there's an explicit check for
> CAP_NET_ADMIN, which I'd prefer not to grant the container because the
> permissions are excessive (yes, I can lock it down with seccomp but
> still...): https://github.com/torvalds/linux/blob/3352633ce6b221d64bf40644d412d9670e7d56e3/drivers/net/tun.c#L2758-L2759
> 
> Is it possible to update this check to allow TUNSETIFF operations if a
> seccomp profile allowing it is in place? (I am not a kernel developer
> and it's unlikely I could safely contribute this)

In this case seccomp would not restrict capabilities, but actually
expand them, by bypassing the standard CAP_NET_ADMIN requirement.

That sounds like it might complicate reasoning about seccomp.

Is there prior art, where kernel restrictions are actually relaxed
when relying on a privileged process allow a privileged operation
through a seccomp policy?


