Return-Path: <netdev+bounces-245529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 426B4CD0417
	for <lists+netdev@lfdr.de>; Fri, 19 Dec 2025 15:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 78410308E17D
	for <lists+netdev@lfdr.de>; Fri, 19 Dec 2025 14:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E563632AAAD;
	Fri, 19 Dec 2025 14:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a19ufa70"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046B932A3F5
	for <netdev@vger.kernel.org>; Fri, 19 Dec 2025 14:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766154466; cv=none; b=rh/x0VYGQkwu+Mk5NxJJWlNa7aco/zJSrmMmHq51ORrXQMPKZ1OE9Bk1Jcm1BagYjJxqSj2GTTDcy80fn23Fy4EXKenVgStt24A/ot19rmHC9nL+/Uu4a4auDIvslEoLxH75SM/01WJOUX8CpfBtFJVNBLS8ZuC0BIh1OwEmdvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766154466; c=relaxed/simple;
	bh=i6yKzKkzFVHvrkW109/RsT8RDMe0gmSoElAvGtM6Y9Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qZzj0CN1mbLibc+FNinXI19Ukkn4Brqn8LqshXNu4rOZdqtI5l5L5grD7gOqYaHSjYPqbBvzHLmKAh57FED4k6a6DMW8Pkwxwu+JCmixOtw3W/UAHBItRyunUyTbJw2mLwKk1IVyKY9ZEF1U2tzAGbBWrt25O9MXcZZ6R+Z7e/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a19ufa70; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-37cd7f9de7cso14966311fa.1
        for <netdev@vger.kernel.org>; Fri, 19 Dec 2025 06:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766154463; x=1766759263; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q1yF0sVIe4b+TGoqeLAjfr0wQe6VhGV3SlKXDVPcnvI=;
        b=a19ufa70mpHYU5m+bfAOdr9HxzJ9l7ox2RlNsCJ8DcPi9g+Frolmuk9JFhJy+gFs0X
         8uSxtZcQv3w8xmF5JnQW43m4ecl162R3ML1PnNA39LKOZBGm+XaZWXjCNBotkqhzYuo+
         Rt2OL7oKajFGWi/k3wcC4RWSRghwqzHN45svsoDSukSBjjpIL14eBkbjJ2sVKqaEed9G
         xC1GmYgzv4X4lJ0mhNnnyxFJ9WBPrE89YOpnJ4YqP3CkHBAuqdxUb4cfIRPMAE8d2KKI
         wJJs+MRAPzFjEEa1Cr9hVc5PbH648hswQZaR0c3K96zAUOOM5sF/NLL9HIxbHNi9u9DU
         iNhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766154463; x=1766759263;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q1yF0sVIe4b+TGoqeLAjfr0wQe6VhGV3SlKXDVPcnvI=;
        b=dFCDB/743aOlA5deI6Rz9pic6a2DyFbo+fL84C8BcT03mlSwaFO/k/XR5A9ug2En5z
         elemMPVFx9DR7rvRHmwjavDC58PDBF4sIe/XtDUkMD1NWD11bDjJadK+9Gkr1TDgu50I
         DZAHaFLvMfoWACv2kgGXIzDFarAmV2vpxeVSYqsBzLyqdzb7kndLdDx0zL0qWWZ/VDdd
         JlFPGJpaVNNXK8sBlyj+ovT//pbakIBhY6fqq1yU8Z6OeaIdqPZK6ij4Jl7HbXWbCHkr
         dGk6aLHwRdwfF2UsGb49fTFOf/DTVMYXR6H8jOtayl0HBB8iScjj18pl1RmHZFF8uRbl
         wztQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+c6IDwmFIugnNWur17/viV030pJVwtG7HqRKwawKYBfv9WKsZtGttBQMT7TqAQ78syS630fY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu+ZWo0kAtwabBzpvIGVyB5CsJr60EMKriGYNw6CevBwcc6WVa
	vQuP+SY3c4SajXC6fJwar79ovruIMHjIIHeQH7dEat3BLaC7vOONfrZK8azqVwFMJieFWp2jlwA
	w3EXZfoDKWp6/tevQ+U4XRH+4KS0H7WQ=
X-Gm-Gg: AY/fxX7l5612yDhub3o0f9XpTGbSR4CVjx8UT+oWIL12AdQ/ACjXsVVHepa5MYcX26O
	dGIehswdGRmddmBoJ53nrirMlMs3qpeTGssugYHqXMlx4GXyh5md4hJmtviGn1s1BJG94Xdx99u
	TZ5XMFzwgxwXsLAQmg/5cRNa56DxL0AbtpWyHVBkEBXD3oD/XqvW4Ak8Xx94fQln2iHpfjv/BR8
	Dulb+xbYeZE0IK3zeJMthz6pqfb4unosaeb9T1zWxIeV9Rsvo8KV2AgRTmek4urImNOIA==
X-Google-Smtp-Source: AGHT+IGTePuCc/cNQuzDUl08P+Z5eGmY71+2Rox+04POLmJRiUj2KRy5gXqVGXUYAGf4HECmh6YhOO/vOss8ga/hDLA=
X-Received: by 2002:a2e:800f:0:b0:37e:8881:d2e3 with SMTP id
 38308e7fff4ca-381216b9af4mr5570711fa.24.1766154462756; Fri, 19 Dec 2025
 06:27:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251217112523.2671279-1-naga.akella@oss.qualcomm.com> <e1f053a7-791d-4433-b7ba-ea17a03ddfa7@redhat.com>
In-Reply-To: <e1f053a7-791d-4433-b7ba-ea17a03ddfa7@redhat.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 19 Dec 2025 09:27:30 -0500
X-Gm-Features: AQt7F2oMAEupy3WThb985bfnSm7nE4ExAatDY4brpjD9axv5FgMAERmDTXnjjps
Message-ID: <CABBYNZ+dDFH4Ki=UvPNc_HSNPMb09gpOeNYs698TR7-c2k_LvA@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: hci_sync: Add LE Channel Sounding HCI
 Command/event structures
To: Paolo Abeni <pabeni@redhat.com>
Cc: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>, Marcel Holtmann <marcel@holtmann.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, anubhavg@qti.qualcomm.com, 
	mohamull@qti.qualcomm.com, hbandi@qti.qualcomm.com, 
	Simon Horman <horms@kernel.org>, linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On Fri, Dec 19, 2025 at 4:09=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 12/17/25 12:25 PM, Naga Bhavani Akella wrote:
> > 1. Implement LE Event Mask to include events required for
> >    LE Channel Sounding
> > 2. Enable Channel Sounding feature bit in the
> >    LE Host Supported Features command
> > 3. Define HCI command and event structures necessary for
> >    LE Channel Sounding functionality
> >
> > Signed-off-by: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
>
> FYI, Jakub enabled automated AI review on the netdev CI, and the bot
> found something suspicious in this patch, see:
>
> https://netdev-ai.bots.linux.dev/ai-review.html?id=3D999e331e-1161-4eec-a=
d26-fafc3fea6cfd
>
> I'm blindly forwarding the info, please have a look and evaluate it. Any
> feedback in case of false positive would be useful!

Actually it seems valid, any chance to enable the AI review bot to
reply to patches, or maybe pickup from patchwork, directly? Or perhaps
we can attempt to create github CI action for it, anyway thanks for
the heads up.

>
> Thanks,
>
> Paolo
>


--=20
Luiz Augusto von Dentz

