Return-Path: <netdev+bounces-245263-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 055EDCC9EFE
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 01:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EDCDF301A34C
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 00:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF6223EA82;
	Thu, 18 Dec 2025 00:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qmV4feUS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83F823C505
	for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 00:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766019424; cv=pass; b=s5r/x7Yh5kszKFnrMcq12fiaUTyIfRCrpmaTBFmiE3RdhNYk98H4TljobnpavoT39yUn8JR1K+IIyXRNr9+e73vV3BpRtf2+3/KxGsswvXfeb6gkqYEqIhGe0Cwz6iKiHBLAexNXSioMbHJ4jWw/tb+p9NTC4JAOV4lXzKjbH/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766019424; c=relaxed/simple;
	bh=Wn8IVSKBKjdKQd+Seeo1vN6CZx6+S91YD2RyKFE3rmk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IbJl3uC0AcgoK0V0dBYHAFPBScZEf5rjmEJOJSI21x/Oxubi0iWw4/FYQiHc3hbmdec56wh5EpTmal7QTXi9trErT68RUgdb2iuT7uEVSeKsGeOiGjgZVtLCrTwlaKKCDSFJ+hMo2YICGXjQ2GQ9I7iAR5cJNwK+vBV8IvM6F74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qmV4feUS; arc=pass smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-59434b28624so2038e87.1
        for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 16:57:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1766019419; cv=none;
        d=google.com; s=arc-20240605;
        b=IxMX7CuceW0UTkXNVH1Kws2V9xDlCczmw3NhHK1HAoFi4JEObVd/FDLHLsRYNVbjFq
         A5z1Qa8xVgh3ic6sa0nbppkyPV5Yh3MVkRhUQ0DL50qSeN8NXSrRFED/06PcurCYkRIn
         UJFMARO+OP+gbtgs2D+MYgvhCIp40l89LIFqkAElKFLsrFp085W0iTD0IUFbIaZwr7XO
         +pn0GLfO5k2E702sCyO0Vr4zy2x82qDiiUEX426SF4SMTFOg//+cgzmmTZDrvyPVSQ59
         epnwli7QWVXAu2PJrYRsALkfSFEQMlZsyM0SWiCi50ZTKGXqRcRCWON4N8hFucZ6/KzK
         cBwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Wn8IVSKBKjdKQd+Seeo1vN6CZx6+S91YD2RyKFE3rmk=;
        fh=h126AUibyR9sRDTOvFdK+MzzH+3ekWfJdhrkjWl+0iw=;
        b=Nva6yNt8SHAoAJMm5YI4d+mn64ROHZPK+ieRmW/AySSZiFqiJUxXgnnH9kFA6JYWpQ
         K9ExLu1B8Dtz7gBC5TOSD55Mj5Uz9+2pMmsapQfybdmVEuNse8BwGrop6IF4X7ZEw4nZ
         7WgDuthnZvVvh9S/gYhT0cLfT1Dmw8JO+TLaXvruiHPkTV/+uMRgST+38nw+ZOR8xUR6
         ItMHJFRley3qWkz+zYsBrT98P6epdyREX0S17JDZypbXESz4OduHLbTQaVNbn66y8ERH
         8i4R+wRuyLKHrKxdxGSdYHdI4mZuxEBl5OoWEvxxHXwFiem3MGMmfTdqd/1/jfjvAdRi
         0yEg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766019419; x=1766624219; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wn8IVSKBKjdKQd+Seeo1vN6CZx6+S91YD2RyKFE3rmk=;
        b=qmV4feUSeuOEucoxkBxtp8oytidTHH6z7oFKaVjmzTV+BMEob3cTYF3ufrUmwCcY+L
         cONw41Bl7/OHQRK+/RVcXZa50VN4k8QGJqmOI07gFR/C76jHO7CEonbc3nyB5z3n0bEI
         Chww8XySGOZppk9O6qvz5+RKxPYcWfINQf5Uvx4zQ51rq5aDHOGGf65Rl1UM/M6kcgpg
         2er4Ff0pPvsKngpwt2Yhdb7btDdAGMRcEI+CTaAEe9Fi2BZzJQBYPKdkqGw1Iy7Hnp44
         FFup4AmSol9pP/WQQpl00mRrCC8D3eq5le7DFwjXDo5EnEfWa8B+1a82ek+sEAjCkTkh
         uEaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766019419; x=1766624219;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Wn8IVSKBKjdKQd+Seeo1vN6CZx6+S91YD2RyKFE3rmk=;
        b=wH1EUw9K5D2tbDEHlGTy20t1mwhZ9rhVF28LuwW5uN1MU6arHapsiN+JpmKSwf20fv
         oJaK7Evh6PB/HNWY29I+UaRPQcbJAPd0mupbF5kWK/6U+s8b9hfYGGqAtKBse0JflNUq
         nN9NQWHudJYZQXtCEwOP1q/xchSQUBcfXRx+t5E0vM1rFgk6HirFC0+ixBhAdYEobIs7
         fHT4wCzLxaaXajOm4PGhmsj1pT4M+i9XbfEh+pjp0byZtRIzsqZUTCAgihM5mw1fRPz6
         JRdXfoGSa9EGdpCzDDE21M7tQIAKhv9cXtH+SfNX793ye3Iar3pDeVZSgCvJDZ7Euxj/
         TB/w==
X-Forwarded-Encrypted: i=1; AJvYcCWJllQQZDJfuIxXNO6dN4AgiEJCcr9cEFR/Lsjn9u52ovfmQxntOnopJHKiIluyDVPwSiPU5+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxkQhABMNV+mfbXIwrU7J5lI8GIaS/zG83ypehAMi3BylDdoms
	rxDg2bdHlhmnYeCPpo64xV4VRJR0YXz7iD7MxVzKqeORr9Zn/+oTUrH+SjiquQHIdY0p5fmeVj3
	t5QfuMS+wsxhNEMZZoZlrLZKsC9Kmt8N+EcD7Wsn2
X-Gm-Gg: AY/fxX6HxPt0kvA2NhtVUYpuR/fcPNT+r4abkIrLEQjTi7xkzuL5VrwJN+WkcPFkcfY
	93M42GOTPOmB/n4lUutoEqJzXY6ob0ATiQIgAJlwL77kVvSdHxNJAWs1+3855wX7LuzY8qGGoKl
	r4D8VwtrhR/p073kegY/YX8J3L0IdPREnGnzugw7Rxx5zwAzQ/qymuRy2bRqJ+OLkmDZKzJFv9M
	OO/3IiLsaJS7FDHXD6lh2RNmdCid+9IgE8RMqce1nNdjkj4CLbBbhajNb0KlDmP9i04Oug=
X-Google-Smtp-Source: AGHT+IGGEASVHyPQ467f8qGv1ai9GzsgjLRnI7PhI1cmjlZrbY5wbMZyqExpji4t46A3XTEUAxJBJfUnsDWD8VEYR2U=
X-Received: by 2002:ac2:41d0:0:b0:59a:1205:9c86 with SMTP id
 2adb3069b0e04-59a143f4227mr7675e87.5.1766019419289; Wed, 17 Dec 2025 16:56:59
 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250930212352.2263907-1-sreedevi.joshi@intel.com>
 <20250930212352.2263907-2-sreedevi.joshi@intel.com> <aN1MOnqvkl7nZxZ7@horms.kernel.org>
In-Reply-To: <aN1MOnqvkl7nZxZ7@horms.kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 17 Dec 2025 16:56:47 -0800
X-Gm-Features: AQt7F2pjn7YrRxFFZxTO5s7_cgbOTqFkxgvLmV7-sRm-KXT3E1OnbII5d1Z5Hm0
Message-ID: <CAHS8izOW+TxLU9dzy08g8MBE+cZGeXwsPnrq7wWH_XrCzHHp7A@mail.gmail.com>
Subject: Re: [PATCH v2 iwl-net 1/2] idpf: fix memory leak of flow steer list
 on rmmod
To: Simon Horman <horms@kernel.org>
Cc: Sreedevi Joshi <sreedevi.joshi@intel.com>, intel-wired-lan@lists.osuosl.org, 
	netdev@vger.kernel.org, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 1, 2025 at 8:44=E2=80=AFAM Simon Horman <horms@kernel.org> wrot=
e:
>
> On Tue, Sep 30, 2025 at 04:23:51PM -0500, Sreedevi Joshi wrote:
> > The flow steering list maintains entries that are added and removed as
> > ethtool creates and deletes flow steering rules. Module removal with ac=
tive
> > entries causes memory leak as the list is not properly cleaned up.
> >
> > Prevent this by iterating through the remaining entries in the list and
> > freeing the associated memory during module removal. Add a spinlock
> > (flow_steer_list_lock) to protect the list access from multiple threads=
.
> >
> > Fixes: ada3e24b84a0 ("idpf: add flow steering support")
> > Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> > Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> > Signed-off-by: Sreedevi Joshi <sreedevi.joshi@intel.com>
>
> Reviewed-by: Simon Horman <horms@kernel.org>
>

Tested-by: Mina Almasry <almasrymina@google.com>


--=20
Thanks,
Mina

