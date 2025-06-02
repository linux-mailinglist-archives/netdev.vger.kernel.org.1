Return-Path: <netdev+bounces-194664-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A89AFACBC2F
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 22:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ECBB172E51
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 20:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AFD0223316;
	Mon,  2 Jun 2025 20:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VUM3uWWZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FED1C1F12;
	Mon,  2 Jun 2025 20:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748895267; cv=none; b=J8ophd50oDiDa10Ke4+IOoPKHWg+DA7UcDiX9DGn7o9TFnE2zsucvKvYPn5XmDn+lvG4d53ampp1Se+yb1qPE0lJDZbFEy9xKNHc3dFYCivNmS81KAut+Bx5EMYQ5iZoCzj5xiSy6xT8WaL++UxEFt+Gf4yhyWWgECCdeZLA3yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748895267; c=relaxed/simple;
	bh=uAMgIamWOSZ3VL4EqIXVKVA4y+XmLdSmbbQHe574Fzg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sNZtEq7wvlOFmwfdyfID9vUqG9NY3ZIO11/Ycf/WbSgJYZHvIBdRa43ujY6ci7zreamL+IF6FFm9NzxGYCtHF6Ibvd52D2ScC1QxkE1ZbLMLIqLw6WlHvvFYDzz/UCpXH752M5m7crcqI/z1oOlh1bhiR3cyR4naRdV+PxCpzjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VUM3uWWZ; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-70e40e3f316so38578197b3.0;
        Mon, 02 Jun 2025 13:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748895264; x=1749500064; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uAMgIamWOSZ3VL4EqIXVKVA4y+XmLdSmbbQHe574Fzg=;
        b=VUM3uWWZwCKoHssqEKawV/LEjaAn/A6h9VIyArMc8G1ZmnSfj8w0qD3bzvBXy5qFS0
         UIFbE1Pgknk7bw2YSd4X/PYmntPwnEw3g5vwKUVLKXKnjO43zzoUD/JSgdrKDJde5WLW
         04jwLhDCzc9GyxpJ5n4PnYmMLDdDo0ZIHudXQMkGMdXNhgHDQdPpBj2FoxNaBk5RPWUr
         Khlt+n88fUPB+2wzftDwYtNH+bswSO/TGF/lTLLY2QA4/+kC7qRlGwrgtGfkkp3wlBcm
         RBKt0+wxsIKHOMNnMzUJBK1Z5ZechCgYxbPZxmc/95VM7otnArdWyLafgXyIMZsprak6
         2hNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748895264; x=1749500064;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uAMgIamWOSZ3VL4EqIXVKVA4y+XmLdSmbbQHe574Fzg=;
        b=rSwZpeyC8hdkYlO9NIr4nLVefm1AWeGh992KuuuhNFzjkOWUQ515mbo6djIKRm6+lm
         h+P4NQdkMeF83fVFnEk1hTk8VF+OaN1ppmQlIQwQR53RGhKHHviMPKJCnTrhkUyR1rsH
         mzxSZVpsRO+2hNf/xl8GqpZcsLqpkf0jOJALaWWkzBQpsHWZYPq3MxG0t8f8+AnhTAig
         I9+iwItFvhruG0j+lu1dllhPshRbUUxFCvwD1wm2QYCKvSpzB5cybg65xlY25NTMv/ER
         XkqddQDN9HGS6cg2uVzWeoeV/l/t+GBCuOeHzGkYkaDhHKXWkQ4xbF90e6iKXdGkS+sS
         8hvw==
X-Forwarded-Encrypted: i=1; AJvYcCVVgfC6SRfJRTydKSjGBcRh4OztiG7C+A3fmNR6pFNW/LBFKyd7vfEk5Xnat9wYVNL1CKfZ6H+G@vger.kernel.org, AJvYcCWrdYyBbhjy3ybfqUZFLZZ9RSqrWsQHdpErwlCoSNQfjdITqzQTh3i+Na1YFcDleFPkH2EikpCf94KbKbE=@vger.kernel.org
X-Gm-Message-State: AOJu0YymJMD70BYIoU+8+Q/yECqWg584STRPi7JG514VvOXBxAUJN5y2
	3uGOo7SQYfR/mT3zoagmeNncy3h0bQT/kfsGFu//4TOJ6tQ1od8QBpD40cyW7JCD/mH8ztF6qIw
	1qcOgc58Ry3KvPmZjSLFoTNm1BEP3uys=
X-Gm-Gg: ASbGnct4kRb8Nzv0lAVhASI21tyP+lLV615lYXaUB7Iui/0TeSkPx2GPFev2RlRySKp
	PZsXHRgQlSxN9CiPW6LXcmMx9ZtGLm5u88y2m4jTNEfD3qnP6LBb1Cq0fTtlaV8/1n9omVJ5CdR
	xNhn1T59oVAv65aGUL8NB4HgHmNEwyzN8=
X-Google-Smtp-Source: AGHT+IEdrn0s382Lg6lEMQWP21sgCw+9StaUAysPGHyne8Vesf9wEPO19yi1iuEWxkzxxIw7+iBR8EAk2JKlg1NSkXI=
X-Received: by 2002:a05:690c:6a09:b0:70c:9478:6090 with SMTP id
 00721157ae682-71097e17ef1mr137743927b3.28.1748895264485; Mon, 02 Jun 2025
 13:14:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250531101308.155757-1-noltari@gmail.com>
In-Reply-To: <20250531101308.155757-1-noltari@gmail.com>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Mon, 2 Jun 2025 22:14:12 +0200
X-Gm-Features: AX0GCFu99DA-g9xZw-0b5x560XeF30AtxpdqJvtJPNWb4on14zqDdDH1BQ-3bPU
Message-ID: <CAOiHx==xHwHtCKb+s-RChoJ5HxXvqTOOLm8ib0oq0bVKr4qwnA@mail.gmail.com>
Subject: Re: [RFC PATCH 00/10] net: dsa: b53: fix BCM5325 support
To: =?UTF-8?B?w4FsdmFybyBGZXJuw6FuZGV6IFJvamFz?= <noltari@gmail.com>
Cc: florian.fainelli@broadcom.com, andrew@lunn.ch, olteanv@gmail.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	vivien.didelot@gmail.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dgcbueu@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 31, 2025 at 12:13=E2=80=AFPM =C3=81lvaro Fern=C3=A1ndez Rojas
<noltari@gmail.com> wrote:
>
> These patches get the BCM5325 switch working with b53.
>
> There are still some sporadic errors related to FDB, but at least the
> switch is working now:
> bcm53xx fffe4800.ethernet-mii:1e: port 0 failed to add d6:67:0c:XX:XX:XX =
vid 1 to fdb: -28
> bcm53xx fffe4800.ethernet-mii:1e: port 0 failed to add 5c:4c:a9:XX:XX:XX =
vid 0 to fdb: -28
> bcm53xx fffe4800.ethernet-mii:1e: port 0 failed to add 5c:4c:a9:XX:XX:XX =
vid 1 to fdb: -28
> bcm53xx fffe4800.ethernet-mii:1e: port 0 failed to delete d6:67:0c:XX:XX:=
XX vid 1 from fdb: -2
>
> I'm not really sure that everything here is correct since I don't work fo=
r
> Broadcom and all this is based on the public datasheet available for the
> BCM5325 and my own experiments with a Huawei HG556a (BCM6358).

The number of buckets is wrong for 5325, and it actually has only half
of that: "The address table is organized into 512 buckets with two
entries in each bucket."

Might be related, might be not.

Regards,
Jonas

