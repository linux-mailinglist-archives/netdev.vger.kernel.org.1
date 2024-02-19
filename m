Return-Path: <netdev+bounces-73017-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F2A85A9F2
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 18:27:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21DC51C21771
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 17:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736AE47794;
	Mon, 19 Feb 2024 17:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="1jbkT23s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF327481A3
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 17:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708363594; cv=none; b=KgSPTVUGl6Xb5nr69tNyFjeexM3YqSsyDYKRKBzS6es5lSiupLUz1KOH3aKjqsbda0WhpLnvhCoP/R42sa0yy8quX5kSmClimis8T+BBwFUjDF1c2SIaDxPWOVBX9QgtQpls628FKPWq9jQ/ybxP9VYTFrdiUVa6xZTNsmfhwnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708363594; c=relaxed/simple;
	bh=ZmRRi72QlLwVie4HVc++aEG+Gla3MKtvmWEBsk6eYvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GgwBkXyKzNdU47Y114/EajiorEYeUSe/F2/MEaiBt5d3k6BPJ9v9oRgBNKI+eVkrXV7eLOYjmn4pl7IsTRbu48Z7E9e/vmU7lTD61evI7L4DjQ3gxFdtuiH4wcycszRFmnPro4xwh9mKkFqj83E97QnXxlUvFdGUShfW/yLP4y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=1jbkT23s; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d22fa5c822so23959121fa.2
        for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 09:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1708363591; x=1708968391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JQeo1UPxZL8Cd5PAqEqjdEFmeYRWQHzRP+SNpoBhjyo=;
        b=1jbkT23s1rh08hy3TIkIsQtO/vwPucvzTRXKQgBU90etaCmyt5t4KdLSYZXdiyCXaH
         B+JLRxo8nHTPemWim7KmNsiaEa3LFMlWXY3ebgdBhF84jhisW18odVcWjVgTNkshKT9b
         LzfmGRQIQvFBj+GxJpW7cpOSjPETGUteVSCT4WP6CPg+KyhqUJ2IwPjJFMhlckihuGz/
         t3Ea9GaI09xw/kOOXf44UCJCDZJvcCJWckK4F6ala5ziSTSx2mNdTOPqupm0N/5VRsE7
         v5/UR6o7YD04xadHulMzv2CwlXSsXaynS89PP0bxefdFoiVM1gZdImUqZKMCHCGoXamV
         8M8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708363591; x=1708968391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JQeo1UPxZL8Cd5PAqEqjdEFmeYRWQHzRP+SNpoBhjyo=;
        b=CeMH/B0VlValf5yKDdiyqeVKuIyxV2ue6Cc7V1lRHqGkfrtTr103b9T48RxIqyJcVD
         N6g7cIJ49tlmwLbZf67Ccd1ZsXMH5ffpNQsq+8u0FNVZheskp0MRR6B0qtayDGP5Cmr4
         dQNoPe96a3LtB4/TBG1i5lJm0R9igS0mgBvSNQAnJWRKYpyqmbqWYQZPj/+nGHFh4PiU
         pO1esdKee6bzDQapV8xNW7Rr39CFSPmHU7qnTJRDuK7XZRodpDJi9E5wpFQ/R8BSxc+z
         UCOTUA47PDCmoeKSQXjO5l31NI2QWSvm55gc3wrW5BrgB8MUGomLgGte4jrnGEh79IL6
         Uz+A==
X-Gm-Message-State: AOJu0YweAnsehBWa3zieLaFAXteklV4zQP33rKaB8jVly56jJfBip4v3
	+bKTCW8kwNMhLQ6dyB1eNNIVMcYKm6xS1aSGuNH1iZB1a8YKR7+ijbmwAAYJbppm2yyc+QgRiM0
	B
X-Google-Smtp-Source: AGHT+IFfkliyw68l3IDMRTzCBSccIOUmoBpz47Ean3U5BYaOA/CxirLrLM5jCLl4YBJO08gFEJFWhQ==
X-Received: by 2002:a2e:b5ce:0:b0:2d2:31e5:103b with SMTP id g14-20020a2eb5ce000000b002d231e5103bmr4145404ljn.17.1708363591234;
        Mon, 19 Feb 2024 09:26:31 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id u19-20020a05600c19d300b004126ca6c241sm378689wmq.23.2024.02.19.09.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 09:26:30 -0800 (PST)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	jacob.e.keller@intel.com,
	swarupkotikalapudi@gmail.com,
	donald.hunter@gmail.com,
	sdf@google.com,
	lorenzo@kernel.org,
	alessandromarcolini99@gmail.com
Subject: [patch net-next 10/13] netlink: specs: devlink: treat dl-fmsg attribute as list
Date: Mon, 19 Feb 2024 18:26:25 +0100
Message-ID: <20240219172628.71455-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240219172525.71406-1-jiri@resnulli.us>
References: <20240219172525.71406-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Benefit from the previously introduces "nested-list" flag for "nest"
type and use it to indicate dl-fmsg attribute contains a list.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 Documentation/netlink/specs/devlink.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index 71a95163c419..df1afdf06068 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -601,6 +601,7 @@ attribute-sets:
         name: fmsg
         type: nest
         nested-attributes: dl-fmsg
+        nested-list: true
       -
         name: fmsg-obj-nest-start
         type: flag
-- 
2.43.2


