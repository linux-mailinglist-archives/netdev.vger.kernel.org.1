Return-Path: <netdev+bounces-143441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B22669C272A
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 22:48:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E489E1C215ED
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 21:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697AC1A9B38;
	Fri,  8 Nov 2024 21:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jTUxbY5J"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA1219A28D;
	Fri,  8 Nov 2024 21:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731102510; cv=none; b=Q5aDQd+Beyk43GExhevc1GwSCTbC6Cqwl4BEU0WuESWSV/WoyUDzrFNcF6Rc06AP+88MJ23YKzoTiBW+V7PqGU0dU7L/pN7FGJg0Z4za7hfhj1ZKzbwYWWUbosl506+gLzAeJgnsfHaCkM8Bdn1bvhpobDXiLAbdZsHDooZgyrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731102510; c=relaxed/simple;
	bh=GP+aNFuzeZxf8AIUpmSRgChb1qq1acmXPgtRUgNJTSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=idtvi9xt9Mi/mDVIttRv6px/VvHTpWlSZLOtVAWBJdOyFhUu4b7F2CBp/pXbYmA/VOHKD7Lzzez1P12cLKX7dQxAOdbjWozcWBKIL3TXlcXeftUuOyXHu/HV8qquERg3WUKbAa4aGFTGI39LEW1v9VVxXZm7yH+B0vQLUa8iRdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jTUxbY5J; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a9a0ec0a94fso408771966b.1;
        Fri, 08 Nov 2024 13:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731102507; x=1731707307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GP+aNFuzeZxf8AIUpmSRgChb1qq1acmXPgtRUgNJTSo=;
        b=jTUxbY5Jpc9JO8+aH6vHXJNiB7qBFSsAcOWFBVKF1rPc0Y2g/+UWWqNzFvVcuJTK0H
         wpoeKMLo8MntY6CFA5ZMYRC/7eERh9j1Fd63YNsGT1z7leQhBORRCoGUdZ4bPEsSmwc6
         +NBOpy/rJNfRP+Zx3l5IPzHaunwgxcYbLZQ8mm5HN68zoGueWALKghF52aTcACIoyFfO
         fL1qESOcI4rIRUSTSEFsXUXNY3LCpQOGdtbfRpq8IX1E0I3rVzucQHskyBXNyaImBqu2
         GizHfjOzARUQwyut+HlHoi7bwGvRNxGkb5UruEaZH2SjD3W+QtF3RXhdJ15SscLgddl1
         zFyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731102507; x=1731707307;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GP+aNFuzeZxf8AIUpmSRgChb1qq1acmXPgtRUgNJTSo=;
        b=KN/gICodClwK0b3qrshNzo2fz+1aJPNIdwrIWw6vhnaaBMqRRXNtNoJZyAUQw38Kx+
         A97txzVHsn+pqSEc5Cb/JB+zNa31xZT1g4LSIyIawIqZUWqJY31VSpkZzbpn7xY5gbtV
         cvCf9qWPcw6xMFu8xLZJw+qbUcg/y+EUG2dlT40Kqd6IY0gKIVYRLBlamBJqquj/86pI
         FLegvBRu4jwr3LyQXFR2k+OW3DcrcKNI9SF1ULyAefFuKPLA/psPwp7OCDoQEm7CwGFZ
         yQsrPoQ8F8NxrdelQxXZAk+IDsTfUBiKzJm6/bS6CiHYpDlc8AZ6JtDO3Dy5Tie57ciO
         2Prg==
X-Forwarded-Encrypted: i=1; AJvYcCVt1z45x+mQe8FBZ5EnuVgrwGp19lPIkqtymSoERJ08qJj8dhebnLwg6TlVh/SJTXw7gwWOLvIG@vger.kernel.org, AJvYcCWjzc9ampzag9xQ4YkeuceHSJaqmi0I84qudyBC7m91HZmC6cGxbi0siRRdZlbXAlj0Usmv5PF8M0pXG68=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxztw34TnNn0Mm+qA1EwPYCiyD1Udk0rEA9UXhWDxhaw1D+f8ir
	9z3YMwwfz7wKc1GZqx/HlwNEoSHINQ2LKCxxuKPUM+WIBpVBMeJj
X-Google-Smtp-Source: AGHT+IEG5cDvSOVCs9ynxIGvmmsbmKZSD3BMOea1HVHFXjaQycEqkxgoM52ODN/KzQHBiHEUGaf4Rw==
X-Received: by 2002:a17:906:d551:b0:a99:61f7:8413 with SMTP id a640c23a62f3a-a9eefee66femr429507166b.23.1731102506644;
        Fri, 08 Nov 2024 13:48:26 -0800 (PST)
Received: from lapsy144.cern.ch (lapsy144.cern.ch. [2001:1458:202:99::100:4b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0abe369sm280210066b.83.2024.11.08.13.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 13:48:26 -0800 (PST)
From: vtpieter@gmail.com
To: tharvey@gateworks.com,
	o.rempel@pengutronix.de,
	pabeni@redhat.com
Cc: UNGLinuxDriver@microchip.com,
	andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	f.fainelli@gmail.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	lukma@denx.de,
	netdev@vger.kernel.org,
	olteanv@gmail.com,
	woojung.huh@microchip.com,
	Pieter Van Trappen <pieter.van.trappen@cern.ch>
Subject: [PATCH net v4] net: dsa: microchip: disable EEE for KSZ879x/KSZ877x/KSZ876x
Date: Fri,  8 Nov 2024 22:48:15 +0100
Message-ID: <20241108214815.3874964-1-vtpieter@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241018160658.781564-1-tharvey@gateworks.com>
References: <20241018160658.781564-1-tharvey@gateworks.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pieter Van Trappen <pieter.van.trappen@cern.ch>

Hi Tim, all,

Sorry I'm a bit late to the party but I think this patch is not doing
much since most if not all KSZ8 switches don't have MMD
registers. They do have EEE registers but these require indirect
access that's not compatible with PHY MMD (indirect) registers as far
as I understand. So your patch does no harm but is not doing anything
useful either I reckon.

For the KSZ8 devices, the EEE errata is handled from the DSA switch
driver ksz8.c, ksz8_handle_global_errata.

Cheers, Pieter

