Return-Path: <netdev+bounces-202740-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6AF3AEECD3
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 05:13:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0150441754
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 03:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211171E1E16;
	Tue,  1 Jul 2025 03:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="flxsh5/h"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94120125B9;
	Tue,  1 Jul 2025 03:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751339591; cv=none; b=nZEoOV9tEVIy4/6ZhAHUecWJs1fIT4vZJf1sa4S4VWCeJpwge2icN4fSF84I0BBwK3Gz7NNtldNg7+LZjaPPeGPxfaRcdz/n+aKV4jp6XXQ+lsxZfPuCHvnXBMcsQ1Ir8RtS8SH/HkPT/ZuORzM1XvsRgPhLshSKh/jI+6msCbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751339591; c=relaxed/simple;
	bh=Eth0w3o4ZE5ziArkgh7wzfD6qXOvot937GZQX90T1T0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=so5jzsqx7VQQJSSdRBUni8XRS6oJMJodqmMwk0i7840b7/8+QciiJ6sNwMMpRXZ9UcNpVzgJIZjrhKIuvWCR4CX3cIx1lcf2Ck2iVDRGgzzTTGIPmLG64N6jA2uNUd/s6MZdPNHnIeDQ0NVmesXPQs9+MI9IjEwPAWxJWIo/ftI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=flxsh5/h; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-73972a54919so2605736b3a.3;
        Mon, 30 Jun 2025 20:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751339589; x=1751944389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t0svKt70TJ64HpokkkxMf+6tPJJXYwddBDnBCXSeWtA=;
        b=flxsh5/hjXfwNc1G9Bnvtxz+pyZ844+3yIgiv+BtuLPSq7+i1i8uO+4KMU3rAMHp1F
         FrBZFN0GDdgbvpQT4mzTjY4BiqxxyvRJKbf7ep6eEV5AgvEREnfvHsMPpxxs4Zo1g2FT
         OKwbGL7VDcu4uVUaTFhuLK9y/mxnv02hvJwTdysJaP3nHdfGnEt0VPKe0VJF0n0KS0F6
         /hX5IBfJLgcn+qRgadCzbgPSZJt7ErgnlzrbPhNWjCUsa7+nihLm+MGU+Lutj99pcdM+
         rTgu7+Teytrk+j8THy3tgJ7yi43YPDjfRI2MaqkolT6y0/UEgHfXDpKOiAhX0pjAznkN
         wCLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751339589; x=1751944389;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t0svKt70TJ64HpokkkxMf+6tPJJXYwddBDnBCXSeWtA=;
        b=EZTXmqNQFsIJnM7qo6hmp08ALUzcEc8+cpL9Y9mYiq4k2j81CVZTEEHY3jwtsELm+j
         Zp0XvqXUSSVdcvQkDqdso5fc09+NxSjwvquVYm+H5KghcjxEYXYWcRt9HiP/hr0tPJFv
         7GW7zNvzaJVeyL0t8D0VOkwQWPv1SHrpDF29OOoguPJA+UaBzeUpKZUu4lQeSRjvMjKt
         OBjEO3MCAdUZzjbIKGfB5V8SOahxHf1W36H0til9h1UprcWaqLm+nCY8oCWa1IDw1D/z
         hEQQg9+dOAegbMPkSCZEtGNbn1qnxBBtp5ICyq61s21a9pO+9OXBA8vFJuaHKUU/C+QP
         QFXQ==
X-Forwarded-Encrypted: i=1; AJvYcCU73XJGExXd4SKA14L+Q7ulAgkoU8HkSFHxq0ZLiXgdkq4adno7d4zxPWGvtcnA3NXSigVQUQyUYf8=@vger.kernel.org, AJvYcCXYXZMEJqq2qxMenWR/1/9Vry9UthREV3BNgEe86LOIrtHuEyfFX29aIYGTHUSGhqVxy6sqcSUt@vger.kernel.org
X-Gm-Message-State: AOJu0YxC8zBgtycwPapyR9koY4vAvOFKL/TPFXvZ+u2V0sq002auBjC0
	iNzFtnD2OEbLQ7rN9S5O1pvprjV1RNJQFbNNTQnFtVYl/CdvjC/2CZ7v
X-Gm-Gg: ASbGncvIvz1P1nhpCmlLkb1xoAZlH1/JeeEqTIohHzcKU/L5eXUaJGb5N95F12aSkKD
	jwogJJ0O7UMQktAFXzZD7bu/wjaGGZCBP8O522rdOxNJV8bj4MOVoEAO+iVWdVAe/jDLBvM5h32
	Wn5ug2y+YDjzgse0l12UgtsuncoBpKks/NR3dEyHD77NYlA316jcGRX7LoafHHMtrCMl7elOltE
	9JIBfPGVaPY8QQK+PabZV3q4fmGmCAo+7HTl0sAesCeT5vdXAFAZZhNrLi6nEK+fJmSWLm/Bf8k
	4AIgaFviB9UcjWVGBkrPbVIDt1ExHQMVHWRN6niAs8M00rLGeROGQ7nVCtQ/DQ==
X-Google-Smtp-Source: AGHT+IGNXHwZZAqGBzOg/9mbbMseeLadAsgDKzJXeSzP/pGloPvuLPOr+pDv/wKljbznPkpyn8zl3g==
X-Received: by 2002:a05:6a20:3d92:b0:1fe:5e67:21af with SMTP id adf61e73a8af0-220a16e45e3mr26431653637.30.1751339588764;
        Mon, 30 Jun 2025 20:13:08 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af56cffe4sm10010408b3a.138.2025.06.30.20.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 20:13:08 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id E43D2420A783; Tue, 01 Jul 2025 10:13:02 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Abdelrahman Fekry <abdelrahmanfekry375@gmail.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH net-next 0/5] Another ip-sysctl docs cleanup
Date: Tue,  1 Jul 2025 10:12:55 +0700
Message-ID: <20250701031300.19088-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=845; i=bagasdotme@gmail.com; h=from:subject; bh=Eth0w3o4ZE5ziArkgh7wzfD6qXOvot937GZQX90T1T0=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBnJ/gff7HbnWHCpw7HlRtq0qBkvvqRK6UydfJ5jx8Zti 1wO3Vlt01HKwiDGxSArpsgyKZGv6fQuI5EL7WsdYeawMoEMYeDiFICJZOky/HfplNBzndIf1nMq t5j9VuVxY+9+b4WXV1cUZdy8wjb5TwvDH651z0zfuhwysRH/vcpRrGthtLJ1fbvdtUUWGxsuzbX i5wQA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Inspired by Abdelrahman's cleanup [1]. This time, mostly formatting
conversion to bullet lists.

[1]: https://lore.kernel.org/linux-doc/20250624150923.40590-1-abdelrahmanfekry375@gmail.com/

Bagas Sanjaya (5):
  net: ip-sysctl: Format Private VLAN proxy arp aliases as bullet list
  net: ip-sysctl: Format possible value range of ioam6_id{,_wide} as
    bullet list
  net: ip-sysctl: Format pf_{enable,expose} boolean lists as bullet
    lists
  net: ip-sysctl: Format SCTP-related memory parameters description as
    bullet list
  net: ip-sysctl: Add link to SCTP IPv4 scoping draft

 Documentation/networking/ip-sysctl.rst | 76 +++++++++++++-------------
 1 file changed, 38 insertions(+), 38 deletions(-)


base-commit: 647496422ba9d2784fb8e15b3fda7fe801b1f2ff
-- 
An old man doll... just what I always wanted! - Clara


