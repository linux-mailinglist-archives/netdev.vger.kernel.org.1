Return-Path: <netdev+bounces-207355-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ACD8B06C68
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 05:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE1F05629B3
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 03:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1969823ABB9;
	Wed, 16 Jul 2025 03:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d+m7gYfb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD461922C0
	for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 03:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752637341; cv=none; b=jG50CWiMOAsxRJNPEyCWC80cxPns9f+hDQ2/P7dG/aGqpRwSf+l72VDljz7RNXiHDHTu2E5BvPfkZFuvoD7/FWnOKfF/s2dEcZPX/e+6jvSvzVaBNPNtAGYZAb61vXnPOwwYfyP6ty5wUIWTOIFPi76alHeXYktV5pivDPT36g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752637341; c=relaxed/simple;
	bh=UuaLMxTKea938w5zQmKUuVpfcPsgJ04RnFqeNc/J9TU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=binLnir+Ouei5qjqVrJ4pfCSbaDyEmJ1AM3JJZR67TfBtA9kLZElSueSjNDmx+ZD1JnNKKpeKqYbU52XcQiB34lU/p4SZAZbc07L/3OESxiSehLxn8+ybhTOZqsJ0UcjyWAF5+ltGpODF0RsNxiWk7dmj1m7qjRRH9aiix/TR3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d+m7gYfb; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3df3891e28fso18291515ab.3
        for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 20:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752637339; x=1753242139; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zK0LYgXvk8ioUzC1S2Ik9h3JQIJNRHwofmVViAm9Zrc=;
        b=d+m7gYfbQj+RjSy0My1owTIGYecYP6Don1uNwCxSfo9FAbh6pS0f56dbEIXw1kBi+O
         QnhqjPLhyl7VwK7J7b20HOm6F4l/+fB3bDIsuG6qoxTbIzaTuENt0TJwO9t4/ZmzMtdZ
         Uy48cKVfGY18IBm6H63j0HO/kGpQHYJejeuPBdo7UdXbwTmiNRJU4ZOx6ouj/Tx2SmLn
         DYYVuzLhsgXjdc44nrwLGCXXpK52ip/ikRY5eumNdPQASyRoO4p9bDRfAFwes8zNPY35
         vV5ywqwOqslyS0efTKvO/Oy0bSCmtJgXg7xRjthWWYj70kanx2Zd3+z2FpQKOk9p51Cl
         U+pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752637339; x=1753242139;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zK0LYgXvk8ioUzC1S2Ik9h3JQIJNRHwofmVViAm9Zrc=;
        b=e8H4k2Sj0/1RTwe8CyxwGe8NmFHSoAECxd7FcQlXbe41BWQ6PYHhAm4w6UpB/itBs8
         IJJuYExA6x6tIQI6PxN9i1pVgxEz7sqL3wAzORkqwwwaiMdGPa0rNeFPj1adjCrKWczC
         bz+iCKCx46yJkSo01e9hWLx283LTzAtVOntw6xyZBwzSbDuQdLZxk1XYq7cE2XmV4cSU
         B3fFjfgGcxbJOXlqPGQSR0wue58/nEHzEyXtMx1BWt+aGlhkmQWm+LoZ8CBNEqD5OoIO
         Ht5Pbwnbd8IlDJZoiC3Zh8K0BhAnwMNfYjpRi8d2J77g2l+5EXMreLhCzcHuQzY3sUvR
         1UCA==
X-Forwarded-Encrypted: i=1; AJvYcCVvE5WucO8J/m2EfSM7Rlk+uZgPsNMoG5FA+eZT9FdJne+NtWbs8IzGrWIvBwrrEJduI/BS4Lo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfCyUlSg7F0vpKnzbxcc5pLxqeU6cZnT4zIcAIoEqNTddzCt1M
	79hb1hXnzGE+qmSM/AmPJX/mhE+xMD+T58QPqM9DoNy+RoZsZRlp9i+YW+4l4UQqpSp1qNRkF8C
	y7QyIhxjER5k/UKnha0VkGtIXTvkZ0rs=
X-Gm-Gg: ASbGnct0Cwk0OTU/0rEYQDMvpJTKin6ChgLv3JnTQKOktVVeep8eSfuIurxOPzxR90r
	anJ/2e3zsW6Io0A+TSAKbuosdtY247IVgCe/GOd5IO4a2kT+OkdI8bE5twILj90zVf0vDzgzqfV
	KudqmQdg30Zie1sIsCJHzaW7Ni4X+XjL6I68MPVn1nF7JSD+93uYP4WxsCbgPUnTZlIxZllvVkd
	IspMc/yBwdU4Upv
X-Google-Smtp-Source: AGHT+IF5lPdD68qW+BJ9+XBjqLPHkHbS0EY1gMC0z9CI8MeTWYuTU9ZySq8wpzWIBNWOMZRTCZj9NT5b22STa9RKiuw=
X-Received: by 2002:a05:6e02:260f:b0:3e0:546c:bdc3 with SMTP id
 e9e14a558f8ab-3e282e29c9dmr13263225ab.11.1752637338679; Tue, 15 Jul 2025
 20:42:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 16 Jul 2025 11:41:42 +0800
X-Gm-Features: Ac12FXyj9mwSvcbXbbQHSKhEOCSBNqSHx-aIvgMPkMveKkGzcBng-JAan5szDoM
Message-ID: <CAL+tcoCTHTptwmok9vhp7GEwQgMhNsBJxT3PStJDeVOLR_-Q3g@mail.gmail.com>
Subject: ixgbe driver stops sending normal data when using xsk
To: Jakub Kicinski <kuba@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, przemyslaw.kitszel@intel.com, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi all,

I'm currently faced with one tough issue caused by zero copy mode in
xsk with ixgbe driver loaded. The case is that if we use xdpsock to
send descs, nearly at the same time normal packets from other tx
queues cannot be transmitted/completed at all.

Here is how I try:
1. run iperf or ping to see if the transmission is successful.
2. then run "timeout 5 ./xdpsock -i enp2s0f0 -t  -z -s 64"

You will obviously find the whole machine loses connection. It can
only recover as soon as the xdpsock is stopped due to timeout.

I tried a lot and then traced down to this line in ixgbe driver:
ixgbe_clean_tx_irq()
    -> if (!(eop_desc->wb.status & cpu_to_le32(IXGBE_TXD_STAT_DD)))
            break;
The above line always 'breaks' the sending process.

I also managed to make the external ixgbe 6.15 work and it turned out
to be the same issue as before.

I have no idea on how to analyze further in this driver. Could someone
point out a direction that I can take? Is it a known issue?

Thanks,
Jason

