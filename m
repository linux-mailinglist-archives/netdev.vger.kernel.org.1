Return-Path: <netdev+bounces-95145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB968C1814
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 23:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB5961F21DBC
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 21:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D344384E05;
	Thu,  9 May 2024 21:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QfOTS12V"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267C282876
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 21:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715288971; cv=none; b=rDDBKBOUapWNFPiJfT6B60CVOa/aZjsuXW+64mK6gJEk6OzjTCNFwbFu5bQt1MMHh6pPSRP8nO3kve59lE1K9Qx2cmLmVvV4M/SwYdn2/zyGfzDNRyFaAqwp3JN6eLlo07D2joBZGvxnAqtOHOZJuc3PcnUOsp1AGKxlZLv68Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715288971; c=relaxed/simple;
	bh=7cnpsm3ib7QnJPl5zCKiOydDwPHEacdR7vNxGjiSv8Q=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=k8+qtmpxeel7nP9+F/zj8Vvmh3aPh9LvFR8B/8pgdQCtvAyJOHYdeblTjCiKky3j5+v3MqtiQb8p1yPNUl6HEGSYpxGvQsb8quFH4nHSzYijFBFzjwd7guS3hpc5tT7fx5MoAMONUraAb58r40Z6TjWDbshCsnM5NmRZr99V0bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QfOTS12V; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-572a1b3d6baso1656a12.1
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 14:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715288968; x=1715893768; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IL/Pjb6tjWhJpQQRsXDN6a0F0TkBXzEFnC2pzR1ugRo=;
        b=QfOTS12V8fn4ISODCE15/1dK92LwmWbxTpigiSfIVgz/l1OTaw7ouQnXL5PESDqSDW
         qKsTRWWb7i1dfd3StQT5C+4t5Dj1e/w7OvVwVF8etWprZJxTKb1pFeGSA6m+c7DaqTru
         CyeQT8JLS9vEOPU2ATQQHhZuqRtwoxRWrJ2hcUPK0vT2jm/hTgwKqvcX9wr6k8xsR2qs
         lM2mIxOnvgcSr8Nz2X1shsIu+HqX82tTDVIO8vFqT3V+ehtqXxh0C1KijIqQcMW3+VWR
         f0PlD4XK9h96K1iiBBaojRDq1rKgbF+ZTo4Dt/LK+QpijSMjvNdeAloIQZsA8Xx2X1uY
         WxvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715288968; x=1715893768;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IL/Pjb6tjWhJpQQRsXDN6a0F0TkBXzEFnC2pzR1ugRo=;
        b=mbf6vF9PdUyAnE1/Hw1FMrUjHP+QcXe4aOWczNzul+P2bNeVj47mXLhlb3bNekZFGp
         B+9tNpXL/228mqYFjZWD5G9JQw5oTom0nwyocuHWX22AlKxvGCZJy5ypS7joy38f5fnR
         buTlSmYQYL2cmWETiXFpGLmlwZ4noSKeZMdsJALfW5chWteDC2/7rfk/NcigtHCfc4VM
         6Kh0OjjeCisEjR6cfa9cVDUeoBDW6iFGcSKoyVabRkI0O+wSF7b8wKmapi2Z/m+6aBkg
         NBZ/uQCJMSqkxT2FQGTcdmUjnbpRWRmUNmSsPC24TeqWFZfLFfVcCB717OHWg1kJrMdB
         ur/w==
X-Forwarded-Encrypted: i=1; AJvYcCVj2rIFmw5dd7XMkztzwUNYlZI3XH/h114/7tdF6CFM4ynSH+jpOSZq/8/Hz6SkfgUdN17ncKpw6S2GiUwJtf0o+I1VjT8I
X-Gm-Message-State: AOJu0YybeV2gPDz9rQdYb0mzHjb7cQJo83im+Dm5++Expj6hhFVZEUqU
	W7puNpmYsfCMZNFEO3HC9WaensXQ3yvPDHPPaM3qgdShaXMrW/+TjmppWWIctWLvRyi+wvMaL4G
	nLOIKpOa5HquzS0HBT2kA6Mgkv9HWqXjaVREC
X-Google-Smtp-Source: AGHT+IGLbC6d4w8wZMLlw5I4DGRaK7YIk0zlXO0iTIICkqw5Ts8o5uqz4W8LZrRpEWHQYx4NiJD5Ca9wEo2T+5KNyg0=
X-Received: by 2002:a50:85cb:0:b0:573:438c:7789 with SMTP id
 4fb4d7f45d1cf-57351de5880mr9179a12.1.1715288968389; Thu, 09 May 2024 14:09:28
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jeffery Miller <jefferymiller@google.com>
Date: Thu, 9 May 2024 16:09:16 -0500
Message-ID: <CAAzPG9M+KNowPwkoYo+QftrN3u6zdN1cWq0XMvgS8UBEmWt+0g@mail.gmail.com>
Subject: Re: [PATCH v2] net: usb: ax88179_178a: avoid writing the mac address
 before first reading
To: jtornosm@redhat.com
Cc: davem@davemloft.net, Eric Dumazet <edumazet@google.com>, inventor500@vivaldi.net, 
	jarkko.palviainen@gmail.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	stable@vger.kernel.org, vadim.fedorenko@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Jos=C3=A9,

I'm testing on the 6.6 kernel with a "0b95:1790 ASIX Electronics Corp.
AX88179 Gigabit Ethernet" device.
after applying commit 56f78615bcb1 ("net: usb: ax88179_178a: avoid
writing the mac address before first reading")
the network will no longer work after brining the device down.

After plugging in the device, it generally will work with ifconfig:
$ ifconfig eth0 <ip address>
However, if I then try bringing the devcie down and back up, it no longer w=
orks.
$ ifconfig eth0 down
$ ifconfig eth0  <ip address>
$ ethtool eth0 | grep detected
  Link detected: no

The link will continue to report as undetected.

If I revert 56f78615bcb1 the device will work after bringing it down
and back up.

If I build at commit d7a319889498 ("net: usb: ax88179_178a: avoid two
consecutive device resets") and its
parent d7a319889498^ these also work.

Is this something you have seen before with your test devices?

Regards,
Jeff

