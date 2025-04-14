Return-Path: <netdev+bounces-182012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB59A8752A
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 03:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDB251890B32
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 01:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15C3149E17;
	Mon, 14 Apr 2025 01:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O+6Ybnw+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835B853E23
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 01:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744592967; cv=none; b=TUAGb3AdPFfY8eLKteW3kOt8fIr9aemSW9Dc1BGPpCoDDlHz6IQmNLmOK7rs+cJPXwFuzufrLHnl+2xxLd6pyutnsrDnqKhuhfJzrc+nbloCZ5A76hS30OIYUVePohzICR/telha4t4nkQcDhqV1rUBXa/3swqxIDTbqge89/lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744592967; c=relaxed/simple;
	bh=stkTAHnyEr4JB/uuUNiFScITA+1rWoKR0S76zrmtADU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rPVjbCJeqYgMtjxsl07JPWscfFqfVJz0CC8UXTPIpGHdJE3AdQCnmoEWBEsmphuOfVc+7OkH+5Hm8V3Op4qGoOH16ayPb8X4W0qtLzUJe5UYtpQPrNZ8DIkui/QhPd4ctYRNxt3EJUeX9EWGHtHJ6G/KiytyzWxQ5FHvsx1QaO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O+6Ybnw+; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-227a8cdd241so44640535ad.3
        for <netdev@vger.kernel.org>; Sun, 13 Apr 2025 18:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744592965; x=1745197765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ANz3WNeYYiJJMo1zQElSvoqfM06lbNuYtFmP4v7/0PE=;
        b=O+6Ybnw+QJQNZnLIk1CS6/r5/H8A60LFtjFsvYo/CNeqql90v/gWRaaGaNR3BQfn1r
         yRUJtOI6p+tCz3NdfDwgF0uc3HKskk12f0p/VEi8U/9X7F83z+vg7Zx3ta3viMP1Ftve
         9IPaZqjqiS/HDJz+op3K/Rb0YMXhaGGjq8hpnkhdBabuy80L2vz/RXH0gYQexnRpK9XW
         OI1GcNzuOqJ4WUy/BocIg4cmkZPV/v1kM2bsTfwJUb3VrHIhC0V+poiHwzGOeJNEeG9q
         VVgahCgkecvHRhehXL+2j6WcYs16kY5KX0dnPbRcj0CwntOcsyaBwWw6BVjQ9x7Vo3OP
         LG8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744592965; x=1745197765;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ANz3WNeYYiJJMo1zQElSvoqfM06lbNuYtFmP4v7/0PE=;
        b=tFYnr0k/AiZOXcmhXluZD33c6eQk6p6rnGnbfHZmZekuLACGci88oBilkVMvfI1ajb
         PJm/yU3Pp1lpWnHkV4K1QhNJCKSNwGrGwASZR7NOOmxypEkcCslaW62AL3qSqcaf8ySm
         wyO9NU/uPi+olsB2qcjWkVSo+Uobgg4OTjsEXOuNsQNG54r8aSEyQjoOKER6fIB2DABn
         RFqNSX/xmZ+cQvI32h8fqQCEwJm4QIxB3Vx9fWrbKsFchr5cOB/rDaBYCmmjagmQ/8rk
         0+l3XFA6AQQyqptR9C/CABJgF6DHGOGJ9NK+pEVoPlCvHFo0zFfymPU2kdsdDsb4C+dK
         z3mQ==
X-Gm-Message-State: AOJu0YwxGS3l1gUvYmy+wKP1/X5h/+snAQNrT0oBhDJIUcNi9wSJpWI7
	n8EnVpxzbED5V4c05R5Q0aKGkZ9EJYduGo7NzbWeq1endwyP3zg4CGFQLg==
X-Gm-Gg: ASbGncveej2hKInqcLLLoN+pZF84CDcALgpw4wySLuqpiLVlM6WeYCRIVqZm7Zk2l33
	i9OyRVBFXcGJHUwED2zn90ev8BZrQvNOriX9n1dY7CoEgWf1D//142JvFBBeKCuJkCc0FowXXz2
	CX4B/kf/RCsWG1JQSX4OCzUbmEjiPL8mD7r2gJiD5ObdNu26JJlNt726okpJBNDa//I56+SNP57
	BeXawKi+zhCr+uy86qWH2Eu4J2oUWb65Ru34aqFhnVVy/JGUV1nG5RJ9Zzecni6y8wQ4gohBRvT
	R9Su7vSXvBPGmQ378WCGBnJz42CrAaFeaRwEVjIUlDEUeSZW7hoQV/PB
X-Google-Smtp-Source: AGHT+IEoeLl+G8krZaZOA4qbZdJT8kSIVdIzz5928v6qWpd3Jgu+wDt9VW/pTgTAD7U5ADVSqBqy0Q==
X-Received: by 2002:a17:902:d2ca:b0:220:faa2:c911 with SMTP id d9443c01a7336-22bea4ab6f9mr140019655ad.14.1744592965203;
        Sun, 13 Apr 2025 18:09:25 -0700 (PDT)
Received: from pop-os.. ([2601:647:6881:9060:66ce:777d:b821:87fc])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-306dd1717cesm10158183a91.31.2025.04.13.18.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Apr 2025 18:09:24 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	gerrard.tai@starlabs.sg,
	Cong Wang <xiyou.wangcong@gmail.com>
Subject: [Patch net 0/2] net_sched: Fix a UAF vulnerability in HFSC class handling
Date: Sun, 13 Apr 2025 18:09:10 -0700
Message-Id: <20250414010912.816413-1-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset contains a bug fix and a selftest for it, please check
each patch description for details.

---
Cong Wang (2):
  net_sched: hfsc: Fix a UAF vulnerability in class handling
  selftests/tc-testing: Add test for HFSC queue emptying during peek
    operation

 net/sched/sch_hfsc.c                          |  9 ++++-
 .../tc-testing/tc-tests/infra/qdiscs.json     | 39 +++++++++++++++++++
 2 files changed, 46 insertions(+), 2 deletions(-)

-- 
2.34.1


