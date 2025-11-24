Return-Path: <netdev+bounces-241106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 577D7C7F5BF
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 09:10:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 44004348083
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 08:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637F92EAB83;
	Mon, 24 Nov 2025 08:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l5PnZWLs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFF02E7F20
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 08:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763971754; cv=none; b=JVp0BrCnZe6UpC31XEtXnGswQKNfIXhXAY/Su3JvWAUaQaF83d0pTNWCFTrgBgo7JQ1V1d7OuJuv8EoEazR606eUvhJafZJavJP/SCzaKf5n31SalUE7ucpQsMJB397EKUFDt77T6N0iXJqW4EpLmy/iXPgJB73KRsHlsStoJlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763971754; c=relaxed/simple;
	bh=V81+1ze73yTvx1q8a2ipglYldq7LJealeazPhR2dWm0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fAupunIA6HCkFW1Hq9AAyt4ajpo9V1dRYzj14UDTPjiGHp2qNPOjNRwxJFJPmDv9YGrItCN3ySnDL9Zxz8fZCHvOqwuB1utCN5/I/er5Xg++0YSKiKI/pdBBmvI4MFTjyNYPM3ISpVntoXFzt8gK78VRcDQfqGWYBFn6OKfhSAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l5PnZWLs; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-297ef378069so35498695ad.3
        for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 00:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763971752; x=1764576552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/j0qk7QrSntrIDGpLECyQj/ceblaeuxUWotaYtatPsM=;
        b=l5PnZWLslUIrUnNOm80VRFmjHSenyI8OXWIc+Hc2yRQMLOrwzC5XlbYk8iECzjRiQu
         StqObEM6iYoKjwlEnN6Kw61+s9YIUbmYrY0GXTp+oEOstmMijuagj47q/I75p5i6qMtr
         xDbSJlwSNP/sSpsrcC72pbnUEQW+3rT/uCAliMl3fL606v4Hm6JQ/hvITQVsX07Vj7ty
         sIW88zufH/gwkVVUxW8RxuCL5lh0W0TVFNxcpPyDFEYcsOlIExudpzAIJSDSEAP5/Y7j
         DubdJEn1r1OZl0sGY7hhkgbQIVUomzqafk1BUSIpvfwvK5LqrVZAIa4ltNoR6aa5WDbc
         m9KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763971752; x=1764576552;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/j0qk7QrSntrIDGpLECyQj/ceblaeuxUWotaYtatPsM=;
        b=w1W/owLF39vAXE9hzT6T5EPX3Q70X8HrxJFSnAyvk9r2mcalqplYnIKJg5HpKhJMQG
         6mqwVr16kol3H3sh8e3wcVmRa60waDDlCZIRwvmZQ0CC3BOvArNfSqSZGrg7qluTgV7/
         qKHDlPGioIiRYUSKyp42zzMVyGdgEOK3yo6HsV2qIaJRFypJ0C8ABz+BJjVnHVoOHz3k
         s6nGx47jXajDgQpKRPOxca5vrEmFPYKbs7e0fDK+Yzm8cbYNvmCZRn2xejq1KPppVGCV
         eYVOfD+PprrU7ZBVFXf7v1DA2yO6gTY0DVy5aVhXg3THCEGxnKMq8n2LPpbzLW+JuO/i
         50+A==
X-Forwarded-Encrypted: i=1; AJvYcCWuCrwzIAjb1c+fvOizEPnsZwiVB8tqiqDXG/pmDqOdFo8j6Brd/xBdmfmJMIPmPnH85BKzuRY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLpA4AfU6LsXIrRxK7dNw6452wsrdPeHVi0qUmAfXvDGtN2hmB
	JhxJHQ3DIut62ikvf7Cyh+TeYEnzaIVEnF7MKe3aA84+qJGcwmNKg/no
X-Gm-Gg: ASbGncsYVXGac4oPJLSbSp/7IDO05nnNYIdFtd0fU5UYzoYbMycmtOXK1uovAcr2sjn
	WMEhtSW3hnehdPrICpMZPaX15dAW7T5niqU9Mu/9V+zoT4HUTcVT4crxupksjv0Y0n0EKoy3vdd
	AKteqkPU7tc20LnQ1OBION+9T/8maYTPvzibom87+/cfpvYed6yVgiyZf/YB0l40n/FY/a0zwpx
	e9tLqPKBdZX3fEUQynQDDERE83OM+PQLCxZrbfjRQqTebq8IPMXMrospfnSY04ujaQLOFMoSGRD
	V+DCc8KcRdJwkUiXfMN+tAJSNLBGwcPQ1x2Lc4nGNo1uQn8S/DDq/m7iwRuGjab724d5wNjveoS
	NKoTu2krwjGw8R8BtlSB7hgfIzDfwhGxiVITJByW1wSO50hF9QJV2I5tXmpCqf5oMO4ZneRmn2R
	G60UNxq+HcC2ezlwBKcJZhI2xWH8E6H1REuRXE/gS2GkIi6FfJj4NHPrvJuRJ8K0H3XoBYvJob
X-Google-Smtp-Source: AGHT+IFS1SSpZp9KxAg6FhJIqHp9gOdWB3H3u9BePqWILGSiROt9rU6Bnj9TPkP+uSbNBUygJUY3oA==
X-Received: by 2002:a17:903:248:b0:295:507c:4b80 with SMTP id d9443c01a7336-29b6bfa0b8fmr111044815ad.61.1763971751912;
        Mon, 24 Nov 2025 00:09:11 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bd75b61c29dsm12343837a12.0.2025.11.24.00.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 00:09:11 -0800 (PST)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next 0/3] xsk: introduce atomic for cq in generic
Date: Mon, 24 Nov 2025 16:08:55 +0800
Message-Id: <20251124080858.89593-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

In the hot path (that is __xsk_generic_xmit()), playing with spin lock
is time consuming. So this series replaces spin lock with atomic
operations to get better performance.

Jason Xing (3):
  xsk: add atomic cached_prod for copy mode
  xsk: add the atomic parameter around cq in generic path
  xsk: convert cq from spin lock protection into atomic operations

 include/net/xsk_buff_pool.h |  5 -----
 net/xdp/xsk.c               | 16 ++++------------
 net/xdp/xsk_buff_pool.c     |  1 -
 net/xdp/xsk_queue.h         | 37 ++++++++++++++++++++++++-------------
 4 files changed, 28 insertions(+), 31 deletions(-)

-- 
2.41.3


