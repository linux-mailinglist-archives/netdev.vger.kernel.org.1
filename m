Return-Path: <netdev+bounces-150444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3079EA42E
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 02:20:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87FFF288AC5
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 01:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF7C3F9FB;
	Tue, 10 Dec 2024 01:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="GjNtd6x0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8193C00
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 01:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733793645; cv=none; b=Kg5RxnfpkYEgOFD6nFdgTCSIjqJJVliBt6jGA0HqlVinppMiVSdNjcB1mnCHIxM0XJ+u30aZTZ7KyxZlu0TkquNo73aiEnwz5F0aVdCgBwvZ4HsUqZmsf2LlzVBItEVB/JoH15qcVdlRojwsoedicXtXQdK8P76X8tr0FAGMqvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733793645; c=relaxed/simple;
	bh=riAgWIm4eHOvFvIAD29NmiRmabOQhrVcGI9FcWeW08o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rLEy+Juzwm3MyPyHN8KhVsgsq8DscS4M+Tp5aMKMNL2vBdawN41T93RywWrxRCAISMlHZFI5WRu5lWgjsnuJEmAocsrVTGXrDn9fZncqexxtm1QbUkKUI3ELx+QrL7Bd9Y9QuJWznD/9Vpnl2cIulFnbdUOZRCNMOmEMT+Wax20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=GjNtd6x0; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-467725245a2so6055071cf.3
        for <netdev@vger.kernel.org>; Mon, 09 Dec 2024 17:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1733793642; x=1734398442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ENRSn1yH7VoQY4e24Ns356ses2mMqgMcB34tq5lxgTQ=;
        b=GjNtd6x0mKLwqS1vSdvcB5W8QrXnlluViak2EVkclYsIdNeqMFc1s+ZTJSZsdKH06O
         BWU1X2KKj0blursigxyduLHMdXOAgV3k9oRAWBkRFKBHG/3sCisgq4j+NPUiD2kaZFC/
         IZAhFc0rDStMBAW1SNUOPZmt+71noUOIgNryQzTj+uYXjPRN+YZz9a+h/L1eBpfZeAMh
         PFgBhQp+ikzufNE7bre/rDD9JRUSDYvCIiZ+M3f4kh3q0NqJ6ZIykaj431YPI4egOf7R
         i+M/VeJEzu1t+oiGytkZHV2M8GlOuvgDl+foU5zzrlvn7MBevZVijZrnED/T1nJDwJ2s
         jwHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733793642; x=1734398442;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ENRSn1yH7VoQY4e24Ns356ses2mMqgMcB34tq5lxgTQ=;
        b=vqf9cM1sJzoyUxn3RCHX1bP7DB3diAoHa7gALQMDfhXdbmSsd62L9Jg54ptIpOinE+
         49ILjVzK8H0lMjwqpQUhkv5hJm3jFW32w4DNb48P0rA1Aj3vnfxnfEX53TBW27EUy/7W
         p927hHYCb3R1hMFe7gVjGE4DsmhdUEXj2wzV0gyOh9T2DZnX2UvXt4nN5em1Ko9+cAVU
         goA5aXLwNTKkKF86cBcy0eXLrPUHxXpEBn/RlEMG1HzcfG+OkIitxiXZa8xB9SJimSgJ
         sK0KATZ0j/sD2KWeMqRdgf8CLkTPS24SIo2mG6gKgoXXfg82hCmlyPrsdvHNPlyIea4F
         4UEw==
X-Forwarded-Encrypted: i=1; AJvYcCVmgj9XAi9a3zngoex0kqB5TfZ4cFuEWO8qw9MV21BB9HNDr4MsivbmCZcQvK4idn/hEdvfwJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YybQxTUYvWPYTagNgUt2zxnlL7hS150gOBJgndHQWB4RQZ7saF+
	HEpw2PFVrEx/EWGKIhI/eX/X3jm+P3ZGDKdzIRt1NUue2qXG7JQ7iCR/gH7Fr9Y=
X-Gm-Gg: ASbGncuzsezDzsnCcAJCO+3S3mwwwOQbxcDA1ZHrXBj2/sigYEkUtHpzxS73VgCgdeV
	pnQDiuBBdeuJbD/pDIE+2oL09ImORzH8UrSthMKvqqMbV839i1xl8imL7luoxCpY0luO22a/w6A
	RI6SiT7cpA/GG3p0aJ+ZuEI2j5e0SJd5GVcd52yBys+c9OuHf1ORbBo5y5A1cxmmdlUoxCEMLDI
	mEr+CeaaXDFe/BUICtPbbuF0JK8TCMycuwaL3My3eMsf5bEIhckM1P9yk09+LZI0+fyD4j6GHSF
	Ly0=
X-Google-Smtp-Source: AGHT+IG+jwM1LsV8lCSffGZDdkO+RuMN3wi5qCHTFZ2dq6X/nH2EzdoVMLfykgxlrtEMRzSWCf0kcQ==
X-Received: by 2002:a05:622a:1454:b0:467:614a:b6d with SMTP id d75a77b69052e-46772028ad5mr44503881cf.45.1733793642465;
        Mon, 09 Dec 2024 17:20:42 -0800 (PST)
Received: from n191-036-066.byted.org ([139.177.233.178])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4677006d143sm8116521cf.19.2024.12.09.17.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 17:20:41 -0800 (PST)
From: zijianzhang@bytedance.com
To: bpf@vger.kernel.org
Cc: john.fastabend@gmail.com,
	jakub@cloudflare.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	horms@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	netdev@vger.kernel.org,
	Zijian Zhang <zijianzhang@bytedance.com>
Subject: [PATCH v2 bpf 0/2] tcp_bpf: update the rmem scheduling for 
Date: Tue, 10 Dec 2024 01:20:37 +0000
Message-Id: <20241210012039.1669389-1-zijianzhang@bytedance.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zijian Zhang <zijianzhang@bytedance.com>

We should do sk_rmem_schedule instead of sk_wmem_schedule in function
bpf_tcp_ingress. We also need to update sk_rmem_alloc in bpf_tcp_ingress
accordingly to account for the rmem.

v2:
  - Update the commit message to indicate the reason for msg->skb check

Cong Wang (1):
  tcp_bpf: charge receive socket buffer in bpf_tcp_ingress()

Zijian Zhang (1):
  tcp_bpf: add sk_rmem_alloc related logic for tcp_bpf ingress
    redirection

 include/linux/skmsg.h | 11 ++++++++---
 include/net/sock.h    | 10 ++++++++--
 net/core/skmsg.c      |  6 +++++-
 net/ipv4/tcp_bpf.c    |  6 ++++--
 4 files changed, 25 insertions(+), 8 deletions(-)

-- 
2.20.1


