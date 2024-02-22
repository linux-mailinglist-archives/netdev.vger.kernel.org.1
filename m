Return-Path: <netdev+bounces-74016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D95DC85FA19
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 14:44:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 936F3289C7D
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 13:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E205135403;
	Thu, 22 Feb 2024 13:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="P4Y1xuiL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D5A12FB02
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 13:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708609441; cv=none; b=qc6Qi7WNmIgY0TswwK5c+83BSH00s+U15vbk7LcDvuzI6YaNSxxPARf3Qz9Wym+gquO1MJgKnwijoHDhpFqC/vUUs8fH0LB75E2lFcxnS5f4Qk99lri0fo9fYX+9naw10WzqmtYUKRiNUbyGOI+lCBTnn0O31t3vZDFHiS1gEkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708609441; c=relaxed/simple;
	bh=ODfFoL+MWBN1dx66G2oN8UVXEmbt7bcvqwfrnmJQkDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L92gUgJn85tEk5ejAUpyRTq1iUYksk250a80OP9NpBuNoTQThqGy+L3nRiyf3ocj7+SOKZouO5cMZ9Zx3tZjp2rx9perV9MVbF642IN0bH0o0CZ93A1NjWxSKT4HiQsv2UTZ3lssUKvJWfsmqakUZRhJ7B1aPKML3r1JUGepIes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=P4Y1xuiL; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33d146737e6so5239256f8f.0
        for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 05:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1708609438; x=1709214238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/23d48srVTCVecddwtQXX/AMBM+Sc7WTVbaCUJYThpY=;
        b=P4Y1xuiLH7/yPXnd6eg/B6DEBMiko6YbZNhkCYSjI5YDTrhjQ3m7HFVKSVkzsm7BKy
         Eh98tv8Y8f5moNB3cT5NhXzbGfIiYtFq8CyVNboKxVSsOv4E6OPzQeQePE4mhPeHh2k2
         VXfWhp4OdZub+w8vYJlAC0Qog7FDWOZ6weS1ARGu6oWt91Vm+kOUvG1JWdfQ6vtpjsPL
         a6ASVaa84RqgAx2wgjU5gr7BMz/iHl7sdQHjN/ySus1G3rjwBHDKAy0AROqDftfINBvt
         Us9O4ussCleI/0QaIwVkCR/xNfcoAdmm8sXbYoNOAVRg4uJst+duV5r8gcRPf7AMnj1f
         TNog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708609438; x=1709214238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/23d48srVTCVecddwtQXX/AMBM+Sc7WTVbaCUJYThpY=;
        b=oSpeSzXCgSsuyWWl+zhVG0sN+g2uv8O64uJzzviofkIPd3tLyARmMYpHKsFpLoOFyS
         ztbRVtmLnGqIcf7GG8esuvFtfLlWSPxKo9fShF9otogZISjkJXmuVuZnkSieROLVyuUU
         sCnJQyEPdo/eJ6Txv8C3m/6QXBMRKHijbFI/ugqaYuglPiup13FbAAZf2p2DwQfTpoZH
         EwxcMNYfmzr/OmrT+RMxN8BcKbqLES6zEpFV+cRl8S7qQRxdFdeLWC+ZTHEoYNgftD3h
         ZMKBoJn5INDWGkYFKXuLeLGrn2GGVXqItJBPKBl8tw/YqURxc+tcr2whJieHkEKRQ+1j
         4Mkw==
X-Gm-Message-State: AOJu0YzmiuA8JKYdF1tXNcu+s6l4HbCuDunB8iBhYh8IKNyrTLIEHZMr
	hzzUMxl+C5O/ClYU1hyGpCtt+URZ5ySkdVELWxENbpLh5Hdo1zf0oa/Cr9lI/KGAnnnL4L8tRIq
	b
X-Google-Smtp-Source: AGHT+IFkcjpDOj8k+YpdNMnvZQ0qgVglPP1VLthnBbHX4MzocvZ09b7LSDyw6W54FVf9ftYLefmcVg==
X-Received: by 2002:adf:e705:0:b0:33d:855b:78f9 with SMTP id c5-20020adfe705000000b0033d855b78f9mr2548600wrm.41.1708609437997;
        Thu, 22 Feb 2024 05:43:57 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id bw4-20020a0560001f8400b0033d297c9118sm18540293wrb.24.2024.02.22.05.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 05:43:57 -0800 (PST)
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
Subject: [patch net-next v3 1/3] tools: ynl: allow user to specify flag attr with bool values
Date: Thu, 22 Feb 2024 14:43:49 +0100
Message-ID: <20240222134351.224704-2-jiri@resnulli.us>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240222134351.224704-1-jiri@resnulli.us>
References: <20240222134351.224704-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

The flag attr presence in Netlink message indicates value "true",
if it is missing in the message it means "false".

Allow user to specify attrname with value "true"/"false"
in json for flag attrs, treat "false" value properly.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v2->V3:
- add comment
v1->v2:
- accept other values than "False"
---
 tools/net/ynl/lib/ynl.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index f45ee5f29bed..1c5c7662dc9a 100644
--- a/tools/net/ynl/lib/ynl.py
+++ b/tools/net/ynl/lib/ynl.py
@@ -459,6 +459,9 @@ class YnlFamily(SpecFamily):
                 attr_payload += self._add_attr(attr['nested-attributes'],
                                                subname, subvalue, sub_attrs)
         elif attr["type"] == 'flag':
+            if not value:
+                # If value is absent or false then skip attribute creation.
+                return b''
             attr_payload = b''
         elif attr["type"] == 'string':
             attr_payload = str(value).encode('ascii') + b'\x00'
-- 
2.43.2


