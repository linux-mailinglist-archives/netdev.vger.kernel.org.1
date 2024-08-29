Return-Path: <netdev+bounces-123187-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E3A196402B
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 11:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C4282874E3
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 09:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA4F18DF7C;
	Thu, 29 Aug 2024 09:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SrXvmZeL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9933E18C904
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 09:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724923905; cv=none; b=fZhhSgCs4TUF4FfY7nH1x4Aw4yETq/iFpn12tUc75nTenrSOVuBYILVbZ8fs4REu7uKPwU9L4MlZ4dL4c09+9GuQt24YTlgJzH5e/HRtQBoOuoYuYREvGFSChbUxq/JVTIMq4ePAl5W8aLtk1R/Ux5OGXpLu+UuEP7J4ip+QvuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724923905; c=relaxed/simple;
	bh=9uaIItSN38SeMaJizoliXXK1wsk8FGtYeV59N3K3DJg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QZFqo59zWcNVF9wFm3ubsblFu1qG9QN1v0qmrZgZgXxrUmOJ2PqQzS38dkQJEAgUq8AYBixxmdl5c5wjp/EMK+do9Bqfsz69iwOSfsJUeWCj6ZE9eTl3RyQFMyJT617dsSeSwD1OcyPYEitaBJUC1s9q8o2bA0UQCvJ0FWcwdTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SrXvmZeL; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7142a30e3bdso1181632b3a.0
        for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 02:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724923903; x=1725528703; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t96XAduoJz9mqudhz0LquUBBI8Ms27eEkKCbEa8fLzg=;
        b=SrXvmZeLqELyh0+8IbrV5TM56VZr+srtCQ3I7ExB6jTEyWKdJJS0q2M2VyLC1etMfp
         l+NpcaueLrqgwGyT+iBhxmTPMFmn+37q+kP8Unm5Jv8m68cYzTq10lWtv1JceBz5GbGm
         PwrlOlZlDyfC/iv4yRFM+SIBKa9kb/ThlwYTJB+anXkkrec1ygytFMVxdHH7dnAmKSEj
         pf6lEWe/CD8w3em4d5oGie+l/9ymE4T1tuCn33hWanP8EAPiKEjZ6asUAPiFLSJlBffD
         qokRFDMoCmP4pM1EJRZiZ9+ODwhZIzG8AjLqXXYoWl+NXGy0ZcZaD3uYM5bqa3FauYcX
         jgzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724923903; x=1725528703;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t96XAduoJz9mqudhz0LquUBBI8Ms27eEkKCbEa8fLzg=;
        b=rkAqIs8e85GzhYzfwa6kCqhfyuezxRwwL9W4RZN3LQYgHluULh8Y8OU9zfUi3qoJ75
         hJDv9b834DWjr41uCUC1PQ7XbEp49uKT7waitEQ6dGB+uwVnTZg6WgJO1p+ZQkc/ZocC
         IFl4EjDzF4Ow86Jaj5Lf8dT9mVLSqhcsJEuflr32BaAz28cySdGQnnNAhj/HF/UIzZwu
         gjN62FIWczjHSPnFXzAAuIcDSL+eSehlAoEVEQNgX1XXuIQj8LdxATprsyauKvrji3Nc
         oQm8u3wZEf7wznLARvWXj4bHjZ7Uz0zPJUnSU8/3RQYRF4jUtWImIAXZlRHHl2LkLVwQ
         msmw==
X-Gm-Message-State: AOJu0YyVplJOim/DIBUqmHiHjG9iW+Jl/Cc6p1n7RtcY5mOUKpM/gQoU
	eHg5FE0pfvcsnrQoo96lCMFryxsWOCu0rIy9WDRS/24pMfR4MWFrg5j3VI1Sd3rCJA==
X-Google-Smtp-Source: AGHT+IFuwcirlMOmPsPDGY3aB0ovRCP0qwI+FMFFMzb/M+4kfGjeI3B1qeuuW6X3v3MZJY8ekkr1jg==
X-Received: by 2002:a05:6a20:9f05:b0:1c2:8a69:338f with SMTP id adf61e73a8af0-1cce57ee4e7mr1210262637.12.1724923903120;
        Thu, 29 Aug 2024 02:31:43 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e575c417sm743276b3a.197.2024.08.29.02.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 02:31:42 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <j.vosburgh@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Jianbo Liu <jianbol@nvidia.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Simon Horman <horms@kernel.org>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv6 net-next 0/3] Bonding: support new xfrm state offload functions
Date: Thu, 29 Aug 2024 17:31:30 +0800
Message-ID: <20240829093133.2596049-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add 2 new xfrm state offload functions xdo_dev_state_advance_esn and
xdo_dev_state_update_stats for bonding. The xdo_dev_state_free will be
added by Jianbo's patchset [1]. I will add the bonding xfrm policy offload
in future.

v6: Use "Return: " based on ./scripts/kernel-doc (Simon Horman)
v5: Rebase to latest net-next, update function doc (Jakub Kicinski)
v4: Ratelimit pr_warn (Sabrina Dubroca)
v3: Re-format bond_ipsec_dev, use slave_warn instead of WARN_ON (Nikolay Aleksandrov)
    Fix bond_ipsec_dev defination, add *. (Simon Horman, kernel test robot)
    Fix "real" typo (kernel test robot)
v2: Add a function to process the common device checking (Nikolay Aleksandrov)
    Remove unused variable (Simon Horman)
v1: lore.kernel.org/netdev/20240816035518.203704-1-liuhangbin@gmail.com

Hangbin Liu (3):
  bonding: add common function to check ipsec device
  bonding: Add ESN support to IPSec HW offload
  bonding: support xfrm state update

 drivers/net/bonding/bond_main.c | 100 +++++++++++++++++++++++++++-----
 1 file changed, 87 insertions(+), 13 deletions(-)

-- 
2.45.0


