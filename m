Return-Path: <netdev+bounces-149721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A39149E6EF0
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 14:09:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B37A281FE5
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 13:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937DF202C3F;
	Fri,  6 Dec 2024 13:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="UXpvoPzY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551F620103B
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 13:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733490574; cv=none; b=hd0vAKyrTd75zZ7h73LeWhLTBgXAWLNTB5rZBqIZuHELqb7IssfuAAwo7sA70SkzJXkU6B6r2wFtYFefgRdVRvBqSgJOyrm4q8cOnz/ZPG6TEgrit+N/a42n6ma3+j9C/9h97/fVeWjBIycKkbpNHgBSpHr2l5xRydgsq7DDiK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733490574; c=relaxed/simple;
	bh=dyHOX0mk2DvLsKVikP8Gv/x3O3rm4+yTGF7tP++exTE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G6DgO1PaFsmfJNDDnTY2lf+YGMdcfwOd4AFUJBJUUnDgmuYR4Q8SelLKnSgRh1WBbCYJ8qWdj+RtTGjxxdQAynN/jY9lfcahprPufbtQtQZhc1WkfaumhJHp7hzTKtS91Ih8Yb0NdM0ZXe5P7WXF+AlKdyVIbb3tB+eqXASzCZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=UXpvoPzY; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ffd6b7d77aso25330081fa.0
        for <netdev@vger.kernel.org>; Fri, 06 Dec 2024 05:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1733490570; x=1734095370; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mHEwR1AyeXEtbRi9lx8Og99xFAVCPLImG2PXMNnqFh0=;
        b=UXpvoPzY00n5KxrepzQdFcLraJkcsyqQ+4Xp7OJZJftm5xveGv656ydMhSrxpIqaVP
         tXQdwng00Q8NhXdJlaEHQoY0FdgFv9PgtRJtjcrnKPZoEe2XZAT64Xrb5p4mMW38bLbF
         vOFctlVHCoNIHg9T3UiXSVFs0iZlk/urBCkm1xY8j4xFXuC0rnwksuW2l35eEapSDhWV
         yE2nPfFq+cQg6LkKdiLgXi+DtoCOsA0joIFQnEm3iStbyYUR4pwDD+0C/2/niRPfo2Vi
         DVtT05a4BwmqnFRLHQsBYCZ43snLI+dRIvGqvFtf5QrnPfN1g9/GIamLVDlXIMRpctG8
         pqpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733490570; x=1734095370;
        h=content-transfer-encoding:organization:mime-version:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mHEwR1AyeXEtbRi9lx8Og99xFAVCPLImG2PXMNnqFh0=;
        b=SIA46SfG8yyldjRkUE+EcEZQk4uARCul+xtCeD435LPrCXaMhbqEBL31GOYY3W4ZVl
         FU3OiaqG1eN1KrgupaidCBPLfsa7bycIx2lOz6WmD6xOHzRz3XESLp7BVdhpErJrDSnD
         f9QcB5A3oNiq8n89+Dw9schHeCZWGs/I4GC2eqYyalJ/JBeDJCO0SBmQilEYlPQcIxm8
         RBfJ9As2IAMxSHnVGKvI3PoaI3QQuQq0RtmyU84+whidrLzGEDaeKDtHKPLpwAZ44U8c
         bm1mNeZyoSqHYIUkW+fbDCcWI6ibntKgdaIO+FfO5b2ggm4Q4nQl9M0aLgI5Y2Frbli+
         9liA==
X-Forwarded-Encrypted: i=1; AJvYcCWKMj+QqmRUjy8/NwMUHCSQzx8Nr3w3o60DxCfAlaK1FMQB/tX7S2kYpCJYrdudiE1VOzwghOg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWS2QiOcrpKNVKW13q/clgRpg8paJ/V9OfE253gSS5qpSVk4re
	LvlnIuldd+sou6Y31JIGXEtH1wQH7+n+Q78KlNXbzhrFCcRg0fb3F3hHqhrPVUA=
X-Gm-Gg: ASbGncvIM1ZQ7jP0a1JPU+6NTJn8mhz9xV11O2QBLYxmhWNomZcx9Un079u/SoJ9E8U
	UdrMald7lAA03S5hHjzSqLUon8VME7AKsVhotM0H1T3Aw1lfqaBxsklW+/Of5SDO7fwLgoHTj2a
	o3Qd+tuCCMH6pn6vhZUXEabUfLu9AR7OLF7KJLQ+Qy/mfrAaKXun1i2s1MSzpnsZ8XBVSseJDTD
	/6JZmuNquMKVeJWHb9XhqXs4/5bBIlT5PPRg1RnZ7eldavrXjnRR7N+zT5yJRwEuLMo+4Fx55TM
	IAGBYW1SAg==
X-Google-Smtp-Source: AGHT+IFelkb1GD26qibKoZqMkwblynJ3qKf48HzH66z2LpZxLqDSYltMm34CGvxC4S4l9q973NpQew==
X-Received: by 2002:a2e:bc84:0:b0:300:3a15:8f19 with SMTP id 38308e7fff4ca-3003a15931fmr6905191fa.32.1733490570044;
        Fri, 06 Dec 2024 05:09:30 -0800 (PST)
Received: from wkz-x13.. (h-176-10-159-15.NA.cust.bahnhof.se. [176.10.159.15])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30020e21704sm4527401fa.90.2024.12.06.05.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 05:09:28 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: andrew@lunn.ch,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	netdev@vger.kernel.org,
	linux@armlinux.org.uk,
	chris.packham@alliedtelesis.co.nz
Subject: [PATCH net 0/4] net: dsa: mv88e6xxx: Amethyst (6393X) fixes
Date: Fri,  6 Dec 2024 14:07:32 +0100
Message-ID: <20241206130824.3784213-1-tobias@waldekranz.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Addiva Elektronik
Content-Transfer-Encoding: 8bit

This series provides a set of bug fixes discovered while bringing up a
new board using mv88e6393x chips.

1/4 adds logging of low-level I/O errors that where previously only
logged at a much higher layer, e.g. "probe failed" or "failed to add
VLAN", at which time the origin of the error was long gone. Not
exactly a bugfix, though still suitable for -net IMHO; but I'm also
happy to send it via net-next instead if that makes more sense.

2/4 fixes an issue I've never seen on any other board. At first I
assumed that there was some board-specific issue, but we've not been
able to find one. If you give the chip enough time, it will eventually
signal "PPU Polling" and everything else will work as
expected. Therefore I assume that all is in order, and that we simply
need to increase the timeout.

3/4 just broadens Chris' original fix to apply to all chips. Though I
have obviously not tested this on every supported device, I can't see
how this could possibly be chip specific. Was there some specific
reason for originally limiting the set of chips that this applied to?

4/4 can only be supported on the Amethyst, which can control the
ieee-multicast policy per-port, rather than via a global setting as
it's done on the older families.

Tobias Waldekranz (4):
  net: dsa: mv88e6xxx: Improve I/O related error logging
  net: dsa: mv88e6xxx: Give chips more time to activate their PPUs
  net: dsa: mv88e6xxx: Never force link on in-band managed MACs
  net: dsa: mv88e6xxx: Limit rsvd2cpu policy to user ports on 6393X

 drivers/net/dsa/mv88e6xxx/chip.c    | 92 ++++++++++++++++-------------
 drivers/net/dsa/mv88e6xxx/chip.h    |  6 +-
 drivers/net/dsa/mv88e6xxx/global1.c | 19 +++++-
 drivers/net/dsa/mv88e6xxx/port.c    | 48 +++++++--------
 drivers/net/dsa/mv88e6xxx/port.h    |  1 -
 5 files changed, 97 insertions(+), 69 deletions(-)

-- 
2.43.0


