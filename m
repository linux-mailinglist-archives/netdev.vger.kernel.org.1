Return-Path: <netdev+bounces-118993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 436D9953CD1
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 23:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8EFA1F24F6F
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 21:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D6714EC6E;
	Thu, 15 Aug 2024 21:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BngeJIHU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039CA154456
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 21:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723758083; cv=none; b=oVY7zKnrOyhTKepmu9NKSwndOQkFbJ6Z0u3hpHPCYuP5hOtApgoswXLXLQNJ1FvM1kBWE6ONTbQeIPh9/VRSpT/HUxRt001wQ86Cut598Z0AAIz9QpYtZn0xAKwkZTAbqKuAsj/Fv/0GGcTaPVflfuRzzqnswjI5DS07Aa9BZVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723758083; c=relaxed/simple;
	bh=/2U22MSYqNrtjnKdhalEXJihrGRhl0brBHoET0IVAC0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dousJ9g/mWvtSnGG1iI8nBvm1GfPbI5kvLVYLIl1XhrMvqn9cVcF9UVxeUhHFWwcns5Q2QK55c/ApkGtU7sPpyV29+0XQyI4OpEmo2bhacOsDrwQS7w6AzZJ+MhMQmILz//xtiYebGYDnVdPut7GpbF/PXIxyDVi7DqvSerDen4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BngeJIHU; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-81fdaccd75eso50924239f.3
        for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 14:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723758081; x=1724362881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=akcnUZLWRkRUgktvh1tPpE59dNekzC9VBXPihcWY0aU=;
        b=BngeJIHUi3kENPEdnCeojZwUDffm4wqyEi+1DiXVYI6TPx2zFTLPK8HUfK5yNCqBua
         ocCOrfDHPiWd17vkaO2sAQmdk8M9JsQRucL7/5wq33ClxUVYxrQCCSTKI8e+Nzb8AMyO
         Ntps0OoGIMEiNcl7Eq3Teil7zgBjDXYm9f9S6baT8uf4Oq/BMIKmpOMCowYO66ryS6Jj
         M9Q7GXqqrh+VuVHsn7vAmeRHwZz062zQtQHd3RD+16z4fxrbTJzGgfrW5UPzFwrJiYq6
         CYNmsnkvSLjcLVIcwiqF2zNYrJw7YgRcaSrLomW/ZAqltpsNl0gxdrrz4IcthemNFVST
         t3OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723758081; x=1724362881;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=akcnUZLWRkRUgktvh1tPpE59dNekzC9VBXPihcWY0aU=;
        b=DHTN+1Dowv5BVsasLfVDkYD2IA9gLZtsm3Ynh0bTwdsB9eyXfLPhXgwJzDn/lacSeL
         dnu2DbUEflT/qID90J7jIWYJotVPdryJwKhCUe+V5KBu2yMN9aPh/EzpVJTgGQHWnXlm
         XZ7tQsxsMGvH681GeVkjaPYOwnhIZoaNpeU5C7mnYLAJekXDSV1DN20gsIY+jVfgGsqa
         B48d7Rw+A8sN2zWm0AOoaLN+G8fKmKTJl5hYgqHK1vLxL6FJh1wyVeOyW/TNKB3tiUdL
         CT9sfzmHKd7KqfDCUtvIP00gnQptDI4VEN9sMpZu3moHqG4KVJPU/QbHrD5Fiwgg3+gf
         9hAg==
X-Forwarded-Encrypted: i=1; AJvYcCUmT/W3iGnqkefxGjbIUXfi/nrB6/bzeist6jz4eaPbrw45auOS9BhA4TXelmgEDHS5jKz7Pv+NQc/JfAsEx4/0XRhzvqak
X-Gm-Message-State: AOJu0Yw3Uw+jLhlF1D36kIrvkHOrFyCAo9XkkIa2COQr1zphFFKK+GrW
	H8y6Y93LwEUki/94wBE3HiBShuuaJi7MCwI8i7IGB4hTrVuHOCJ2/Y8Zmi69
X-Google-Smtp-Source: AGHT+IEL3a6qm0zTOXSO8LpSSpk69pQ5it2M7vjp8f2FHFtp/4hdzrp/t3uO9QhrXFTQIQPjfhb+5Q==
X-Received: by 2002:a05:6e02:1888:b0:39d:22f2:4937 with SMTP id e9e14a558f8ab-39d26d730d7mr15643435ab.24.1723758080833;
        Thu, 15 Aug 2024 14:41:20 -0700 (PDT)
Received: from jshao-Precision-Tower-3620.tail18e7e.ts.net ([129.93.161.236])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39d28e13cd8sm642125ab.22.2024.08.15.14.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 14:41:20 -0700 (PDT)
From: Mingrui Zhang <mrzhang97@gmail.com>
To: edumazet@google.com,
	davem@davemloft.net,
	ncardwell@google.com,
	netdev@vger.kernel.org
Cc: Mingrui Zhang <mrzhang97@gmail.com>,
	Lisong Xu <xu@unl.edu>
Subject: [PATCH net v3 0/3] tcp_cubic: fix to achieve at least the same throughput as Reno
Date: Thu, 15 Aug 2024 16:40:32 -0500
Message-Id: <20240815214035.1145228-1-mrzhang97@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series patches fixes some CUBIC bugs so that "CUBIC achieves at least
the same throughput as Reno in small-BDP networks"
[RFC 9438: https://www.rfc-editor.org/rfc/rfc9438.html]

It consists of three bug fixes, all changing function bictcp_update()
of tcp_cubic.c, which controls how fast CUBIC increases its
congestion window size snd_cwnd.

(1) tcp_cubic: fix to run bictcp_update() at least once per RTT
(2) tcp_cubic: fix to match Reno additive increment
(3) tcp_cubic: fix to use emulated Reno cwnd one RTT in the future

Experiments:

Below are Mininet experiments to demonstrate the performance difference
between the original CUBIC and patched CUBIC.

Network: link capacity = 100Mbps, RTT = 4ms

TCP flows: one RENO and one CUBIC. initial cwnd = 10 packets.
The first data packet of each flow is lost

snd_cwnd of RENO and original CUBIC flows
https://github.com/zmrui/tcp_cubic_fix/blob/main/renocubic_fixb0.jpg

snd_cwnd of RENO and patched CUBIC (with bug fixes 1, 2, and 3) flows.
https://github.com/zmrui/tcp_cubic_fix/blob/main/renocubic_fixb1b2b3.jpg

The result of patched CUBIC with different combinations of
bug fixes 1, 2, and 3 can be found at the following link,
where you can also find more experiment results.

https://github.com/zmrui/tcp_cubic_fix

Thanks
Mingrui, and Lisong

Changes:
  v2->v3: 
    Corrent the "Fixes:" footer content
    https://lore.kernel.org/netdev/20240815001718.2845791-1-mrzhang97@gmail.com/T/#t
  v1->v2: 
    Separate patches
    Add new cwnd_prior field to hold cwnd before a loss event
    https://lore.kernel.org/netdev/c3774057-ee75-4a47-8d09-a4575aa42584@gmail.com/T/#t


Signed-off-by: Mingrui Zhang <mrzhang97@gmail.com>
Signed-off-by: Lisong Xu <xu@unl.edu>

Mingrui Zhang (3):
  tcp_cubic: fix to run bictcp_update() at least once per RTT
  tcp_cubic: fix to match Reno additive increment
  tcp_cubic: fix to use emulated Reno cwnd one RTT in the future

 net/ipv4/tcp_cubic.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

-- 
2.34.1


