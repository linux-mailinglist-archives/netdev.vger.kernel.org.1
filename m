Return-Path: <netdev+bounces-233850-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4783C191A4
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 09:39:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33E651C61B47
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 08:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4620330B15;
	Wed, 29 Oct 2025 08:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jKK4/puC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130FB31076D
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 08:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761726393; cv=none; b=LgHlZz5rKk+96aPTk3MKd4SmU4sVaGFz+/Y6O/+29RUxKjlUA5KgmzRa4U6APaconwLYZ6GIOOMQRqcmMrEK+uA1MCCQ7PK9MK6XZX4UhiGJhNMbPrvM8s1R1RKaECi2PUcN9U6hAV5oaK9pK4YQ04G7T+zYmzBghjy/kIVuyVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761726393; c=relaxed/simple;
	bh=TSdqCvWTW91ah16HH+aiKsyB97s9GEE5xmypLgw9rrA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HQeSRl14yy7KUiiUNMp/dIphsnjYGV6slMYvaxx8JjkIOuKLJMVa49Oc5aUobfHX2q9mETBvuceKuCDPowlstX/5hSbnrrc6eutrZ/CoYuQhq0ysX58yCGs2ojKhZsOIgrGh/ul7IXQ7N0nvykFGs9AJI1Qo84+lobvvPPGvfCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jKK4/puC; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-32ec291a325so5411700a91.1
        for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 01:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761726391; x=1762331191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sudBY2RiWFsiu5y15PJlszzmNRDJVFNp8bjRqr+zwxs=;
        b=jKK4/puCGBcAevsO/FfE0HT3f4VP5VycYg7IUUROfPmdQ2UBUAw+7Fn7AV7KscVsiN
         3z9WhrOb6HeXbzktvrLtOqHqsyTyAISDQ7z3OZsgkZPTFryGou5JpSpNCPbtxk5vHKEr
         J6k6CjlptgZZjvQCwzS48W6mgMesGMXRMzfAvGz4vQ2xHFcceUg9gOOElzJ4tUahgAOO
         xxBm9LPwU+3y+hS6zkNmW92pMkHhHbmefC/0RvqX43GQBiKIWf72BhPeuXJysbLTjVHW
         +ysKiroV/xUROCHm+r/wUBT0BgQXTnEBacMpdgDB8X5l4H9g+rQV3ZL5LbWpxDIjVnuf
         6dfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761726391; x=1762331191;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sudBY2RiWFsiu5y15PJlszzmNRDJVFNp8bjRqr+zwxs=;
        b=lwEBxEbxuJ5rSY04J9LAA+CODfceF0f89LGYsHd3P9Q9VLw+Cb70qm5ATp5vp7XQaf
         fnVsh9dStMiKbpEW1zsbRrEig+gYeKPts1vlSuDuDqzrHyDT8cyk5dUvBSYMh6rrctWd
         EFZvV36O5rgByrceu+cmVnHeBl4mBaUFmM8E2XRu4HYVLb2HzY8wnAEGOz7FfKCUrJmC
         M/BCFuyeTXOf+pmLzAYWxPsVsku+gGk+MBlQLxb6JHnxUkfZb94YagnogYz6nuTmM2oU
         5UKIM/n6DfHYv7WpEt2v1vTfsXeo5Jav5A/hliTjxKcuUrgj8Ag7DDe4YU0wnkDzo/pI
         dncQ==
X-Forwarded-Encrypted: i=1; AJvYcCVex6tG+hEkcW2gdqrLjnn2JTPlh5XwTCtCrr68bLc2cUNWm3d20t9oUf7HUcyu7lehz9KCXgg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpiLihIogIFwDDISOmGu0zC4faH2AdynnjOjppUrlVAhHAAarT
	24m/OhgqVtS3VxbSnR3U6ue5vsP8Pg+paUjkKOp2OD5lohYItYN85Crz
X-Gm-Gg: ASbGncuWFillGutRwYvtd+7eRriWwRE8QU0/SIGf9881joV/xBjvXcBVauR89vKRR0x
	xubEU4CXD1mtXpMUu/53L7lJIgTy43B3YY2rosqwp0t1toDFxz6H2Gt0nE+u0rl38/qJqNu8UGI
	XnqwL5bYHW3szt3W3CdK5Sr5K+fy3ptW9dIzotfKapdtKFf9D7AdWIham5/+S/VcdqUd4uFGQGa
	3g3cgLJ9y+LfYSGgGPGKl/Phka8WeymOPMOxv6l3P/3mor+TSrXRwJ5CbucgOPz+DqAleCbJpQb
	XadwbjB37C/yMW+J6tMsAbbCYb1F21un30ASLEQEjMI6DnJp4B5kDPickrGb6etAiTNOOFl3ewf
	KqS8dOYm3Fiv3zQpAYyiFhmnLRSuZIQ9vpqlHAcNtg1+Hn0wyPh1Kx5ZL2r0mu+z7/24/Iq/UgQ
	4AgKO30KuOcDg=
X-Google-Smtp-Source: AGHT+IF0PkWaskgERMPwSh5sbmy7XRCCr5pEGKg0NaEs3tSvnGcQ3TbjA8agGFwfJCYIZIsLOPwfEA==
X-Received: by 2002:a17:90a:d64d:b0:32e:5d87:8abc with SMTP id 98e67ed59e1d1-3403a302f52mr2369411a91.36.1761726391321;
        Wed, 29 Oct 2025 01:26:31 -0700 (PDT)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b7ffeab2617sm7527888a12.33.2025.10.29.01.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 01:26:29 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 25E284206925; Wed, 29 Oct 2025 15:26:19 +0700 (WIB)
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
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH net-next 0/6] xfrm docs update
Date: Wed, 29 Oct 2025 15:26:08 +0700
Message-ID: <20251029082615.39518-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1475; i=bagasdotme@gmail.com; h=from:subject; bh=TSdqCvWTW91ah16HH+aiKsyB97s9GEE5xmypLgw9rrA=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJmM55X/B/rYqRzZO2+edHLWY6YF3021jkR9WHFo19FO1 2dhfDFrO0pZGMS4GGTFFFkmJfI1nd5lJHKhfa0jzBxWJpAhDFycAjARoasM/4OYtr5i+J2+WGLi LYXFcuonAyakn3n9Uyu8Ztd+nlkrXq5g+O/kFL9ot/tLZ11fg6ztygIVNqHyF20yvi+vXcCZnjB 1PiMA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Hi,

Here are xfrm documentation patches. Patches [1-4/6] are formatting polishing;
[5/6] groups the docs and [6/6] adds MAINTAINERS entries for them.

Enjoy!

Bagas Sanjaya (6):
  Documentation: xfrm_device: Wrap iproute2 snippets in literal code
    block
  Documentation: xfrm_device: Use numbered list for offloading steps
  Documentation: xfrm_device: Separate hardware offload sublists
  Documentation: xfrm_sync: Properly reindent list text
  net: Move XFRM documentation into its own subdirectory
  MAINTAINERS: Add entry for XFRM documentation

 Documentation/networking/index.rst            |  5 +-
 Documentation/networking/xfrm/index.rst       | 13 +++
 .../networking/{ => xfrm}/xfrm_device.rst     | 20 +++--
 .../networking/{ => xfrm}/xfrm_proc.rst       |  0
 .../networking/{ => xfrm}/xfrm_sync.rst       | 83 ++++++++++---------
 .../networking/{ => xfrm}/xfrm_sysctl.rst     |  0
 MAINTAINERS                                   |  1 +
 7 files changed, 70 insertions(+), 52 deletions(-)
 create mode 100644 Documentation/networking/xfrm/index.rst
 rename Documentation/networking/{ => xfrm}/xfrm_device.rst (95%)
 rename Documentation/networking/{ => xfrm}/xfrm_proc.rst (100%)
 rename Documentation/networking/{ => xfrm}/xfrm_sync.rst (68%)
 rename Documentation/networking/{ => xfrm}/xfrm_sysctl.rst (100%)


base-commit: 61958b33ef0bab1c1874c933cd3910f495526782
-- 
An old man doll... just what I always wanted! - Clara


