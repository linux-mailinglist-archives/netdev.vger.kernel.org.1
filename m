Return-Path: <netdev+bounces-209034-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 102FBB0E0EA
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 17:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D938C56724C
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 15:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D3327990B;
	Tue, 22 Jul 2025 15:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VcvI7eAT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BC9279DBC;
	Tue, 22 Jul 2025 15:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753199491; cv=none; b=OC+wwbowoLKYZVWdr545B2Dlo0RahZIFShOX6LUSVTr2eCRHVy7UFLLOiWFu0/USzjpriMYTlZ5Na5u1/+igvNou0zA8LBIzMFJkWeT6EEXwLH2mVynNlZTewZ+VykwzXozqxbs2IFQJiQZ/5/5NyH1L9EmgL303RhLMmMRjTis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753199491; c=relaxed/simple;
	bh=ym9NOmCPOzgC6rUW33bSrOsHFLu9aGDzgv6wvDAJeL4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=bwhqBz45XShWVsV5DLkqMMIMfdfg9Ts70rflD1kH0mz5iX6667srqoWl8c3/SMSGj/F2NpUPJa9kWqTKg71jloTauwLWPvLa5QUWynse3c8WJaz5WGnxn1MHeF6ibP9vp8hquTMC2QypXwFqpkoBrEzsOBXS8oB4yqmBv69o1KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VcvI7eAT; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3b49ffbb31bso3678606f8f.3;
        Tue, 22 Jul 2025 08:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753199488; x=1753804288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C3dPf+ID09MXpLAihBhOzSgvYSZYGtT7LemGPeELFSg=;
        b=VcvI7eAT/5oubOyJJk7HUaLfILVYthkeBSyAyM6e7BsVeYPFFLMRtaYyQ3JWDUNaGH
         0tC8W0/WzfrSsNuGM6U2n/uj/qzWTvitAjUwVmvRZr1V5QDTGctcZ5rY0ORBHf8qb51N
         Gs7JMpBQHhW1ripYHuVdfrU46qcl6yauIyL7CCeOAdomxtRnz5JIzi+7N841sqkcQeTX
         bGrG9OIM9lA3XscP9bNMbUQv6Z9GD/UzMJwv4wfvTUEn3KdNaKlfpSe4zjYlqMShZgdA
         k4jVf+aUCwLX4m1ZmGMJshjlkrwswpY3PnEvSyHawUH+8nt4XwfitOco7luaygOC5PnM
         XFcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753199488; x=1753804288;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C3dPf+ID09MXpLAihBhOzSgvYSZYGtT7LemGPeELFSg=;
        b=lhkx2Ngyqbh4eWdr4e2seZS5OgyLy6yY6ypVGR+wmiKrGUymWYtjpc50gwMKPasdE2
         sXYPGEE69ER0SeGa+9wNoZvL40AbxlTv25YAwwKRTrRqPxlaKjylYJDY+QCGaNsWE1OA
         IjivQ1odMsaqCweGtlfKiHlFEIvKD7CrHhQ2fyucpj6baXLxgimpYCGfCeA39fkV5Boz
         nOjtE5Npv97YyRw9hR+xcEUALmsg4IiPQrzDGxJ65i4YY35rWWOE1WFnUqT9onl9yBr0
         Zvv1QtXPMo2d5l6QondsQXVUWEKGl6hqUxUET8SuisKPksxQcDgUVLtla0ovLvR/qscv
         6h1g==
X-Gm-Message-State: AOJu0YzlmAyVa/vJ7mU1775R88YyyOxXcnLwHsRR+aiq5lCrz+efi7HO
	JEpbaB8UmphheaE56ieUpTq5QE0cJf7n1AhDRRjrC+WWw1ncSw3Rbbv95cV7ecXO
X-Gm-Gg: ASbGncsVMX5sSr3OkmAN8oLQpwfBVD/PykILOsP6CZMDJ+69M179ruUdXuRCqIg5u1d
	N/qQw+ZEwY0lyxJtZGFA2SqebkBTH0SJUwcORefB/+UmPfrWrXFhow0NarFl1TCNvvDjM8ItXrc
	fFQ6KyRqBP9FijsPKGkqK6AR9QqlJeiI+P3GIDcUlzUhItcLPoS2UZXSvZa6N+eXmTOsUGMW2L4
	dxoplMkpU+0DlnOITI0LZ3soHTNkYQxBaUjsYZ7fOOnPn+pZJM4JBZH4KHCxLeQTT44wnjxNV05
	ufJAHnpFJz9coC7bYH4XKNhsDOOM31KEctnhtnE/Kl+DBM05GGrouWNYlMJU3oQfKiYHsKr9mNV
	Vc5G4buFXrHB2eTuY+A==
X-Google-Smtp-Source: AGHT+IGEjhR//Cs3gU2kdkbJIy7fIHp7e0cieCvDwQJNopDIH1Ghsc8s7s9XP9ZdEZHFO6tc6QGL0g==
X-Received: by 2002:a05:6000:460a:b0:3b5:dc04:3f59 with SMTP id ffacd0b85a97d-3b613e97badmr14932760f8f.37.1753199487277;
        Tue, 22 Jul 2025 08:51:27 -0700 (PDT)
Received: from maher.. ([196.70.143.246])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca4d74asm13646922f8f.63.2025.07.22.08.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 08:51:26 -0700 (PDT)
From: Maher Azzouzi <maherazz04@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	MaherAzzouzi <maherazz04@gmail.com>
Subject: [PATCH net] net/sched: mqprio: fix stack out-of-bounds write in tc entry parsing
Date: Tue, 22 Jul 2025 16:51:21 +0100
Message-Id: <20250722155121.440969-1-maherazz04@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: MaherAzzouzi <maherazz04@gmail.com>

TCA_MQPRIO_TC_ENTRY_INDEX is validated using
NLA_POLICY_MAX(NLA_U32, TC_QOPT_MAX_QUEUE), which allows the value
TC_QOPT_MAX_QUEUE (16). This leads to a 4-byte out-of-bounds stack write in
the fp[] array, which only has room for 16 elements (0–15).

Fix this by changing the policy to allow only up to TC_QOPT_MAX_QUEUE - 1.

Fixes: f62af20bed2d ("net/sched: mqprio: allow per-TC user input of FP adminStatus")
Reported-by: Maher Azzouzi <maherazz04@gmail.com>
Signed-off-by: Maher Azzouzi <maherazz04@gmail.com>
---
 net/sched/sch_mqprio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sched/sch_mqprio.c b/net/sched/sch_mqprio.c
index 51d4013b6121..f3e5ef9a9592 100644
--- a/net/sched/sch_mqprio.c
+++ b/net/sched/sch_mqprio.c
@@ -152,7 +152,7 @@ static int mqprio_parse_opt(struct net_device *dev, struct tc_mqprio_qopt *qopt,
 static const struct
 nla_policy mqprio_tc_entry_policy[TCA_MQPRIO_TC_ENTRY_MAX + 1] = {
 	[TCA_MQPRIO_TC_ENTRY_INDEX]	= NLA_POLICY_MAX(NLA_U32,
-							 TC_QOPT_MAX_QUEUE),
+							 TC_QOPT_MAX_QUEUE - 1),
 	[TCA_MQPRIO_TC_ENTRY_FP]	= NLA_POLICY_RANGE(NLA_U32,
 							   TC_FP_EXPRESS,
 							   TC_FP_PREEMPTIBLE),
-- 
2.34.1


