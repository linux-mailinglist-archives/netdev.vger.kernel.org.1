Return-Path: <netdev+bounces-188198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD37CAAB85D
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 08:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 800C71C27CCD
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 06:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9FC283151;
	Tue,  6 May 2025 01:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bQK0RREX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D1E301A58
	for <netdev@vger.kernel.org>; Tue,  6 May 2025 00:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746490556; cv=none; b=BJ9gHm1azxg41fhHLyXuIWyZ4nuhWq4LsLc4jM5oQfw/msUpOPjWYyyfkYlHUhu+YN0vWWYYzlZTRb+cPaK93QNJglLzY1eZPPlY1AZiMDYB0ZaaN2rkj2igJ8sHwuz2y8o6/DjOh6zOqmit+dGpU1MUyRCgaTnLzLon9fPRo6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746490556; c=relaxed/simple;
	bh=SJoQ2ZntcvsdamI2+sSE8euPcunLEHz24IZUQh/mHeA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rLW8333uEw6/6BSfofK0xABn9IBP/7qawLAcp7854cMfWv/aiLUTX+QrY/L/DUZcN6c4c3Fch/sAl1T68uonW3psNnxa12HxoBL9V6oQPXi3Iuhfjuc+h2AnRL9Yl0AAgJAla+rO+yF+lbFP+/Wkq+7jDJPhgQKipBxVmGrn7xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bQK0RREX; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7403f3ece96so6646063b3a.0
        for <netdev@vger.kernel.org>; Mon, 05 May 2025 17:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746490553; x=1747095353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CcFx2IZYKucuKjz0J+7vg/h0IpX0s/8MdzN3V6wViGY=;
        b=bQK0RREX1V6mf/G0Hr20nR8aY4mJD3Og4nywboRBcu08UsfES1d8Bzu6ktcGkaiA9L
         9DC72I5rObbj2p8p0xi4mlGku6aNkqrBezynWVVZ4q+4UAHXGnNwJUFglFy0uOQg756d
         G+T/0EX9bIK/76ooPBxxZbuXipjemvWuqlstUaQJ3xLyYh4XkiaCcU2M218pQSLbdxTg
         kgplr0PlBihm1ylVHq7QcLN6jGnWke6aWFz8roO78uiV8EYpkzsvjiSYaV81K6WxvNF4
         BntgnRBJ43Ei0b+P4MngYVZbVr/juPOyBpxNYiJEis7fEAtzbGEAcOzkdj/39lNRfoyh
         Djlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746490553; x=1747095353;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CcFx2IZYKucuKjz0J+7vg/h0IpX0s/8MdzN3V6wViGY=;
        b=Bfb3+ZmQDHNdbaj4uHHQM7OsEnXMEEl/7IQQUGCNHm0ioHg6WtRcpD/yEft0wRaa90
         H6D1/z4XjrxEMQcuZPkv1/V2r/FK9KDO2TDsoBM4uIlaZ+OiPtw7CLeI23V/b4aOLm5W
         2Vfi+l/5AhFdb2tG6aNdm+bv/YIeaTwGq+NymlxrG5zPYkmlPca400qaf1AqxdHLu8nv
         +p8BduBOI4yChlm/6TYNtflgmNKQBsVNa94ZtWF2Gp24qTTpimJBEhnrWLbxWPlOn/9S
         Cxc9vzTtyPN57HSP3SSgiEmVzVtf00TnRidatzI0vkT/Oa+vPpKBUrwe6COwmgDDA21i
         b2QQ==
X-Gm-Message-State: AOJu0Yz/78L+V5k1Jdm6zi5L9fG8C87yewju2YmAuZoytHbjHupFP4eI
	Gm6VVSmofmH+euzYRHqVRBYI4M42Xix90FaPrpQxf8tFlcNpDvcGFrOYcD8q
X-Gm-Gg: ASbGnctLeuIW+6VN/1UUJ5hFdVPxmN3zBhyhPUzgUTlFT2lvulvzGPCrv20Q8mwBdIR
	Z3Z4XhtF7fm8Y74kF2P4hbP9B82RucaOQ1/whZQRHDojqIa3cv/uo7gYXADsDOKU2OOMF99tvA6
	/tuIt54tJ6kP9quA4TkNuQLZ6Hi8EqQVJpUya9mQFPzxWjAt4+NEnh1mb133A3XIAl7GsvO+5VT
	SBqo28yqHpQ7ERtY7089eOe4bit2F06mV04cr685r28gIE2soEdd0un7ShmMikzE4E4355GEyWC
	WXs67GMY50wjQy2km8zEu7UaVdKfZuh1BFXlE3uIohm86U9KK7M=
X-Google-Smtp-Source: AGHT+IG30zSSEicGiHuZXSJWy9PWOBjfmGdyGPqynRRNml927MrTMNReHYGPyPb4UFUUiMm06tHDDw==
X-Received: by 2002:a05:6a20:9c90:b0:1f5:58b9:6d9b with SMTP id adf61e73a8af0-21180f54ff0mr1399194637.12.1746490553428;
        Mon, 05 May 2025 17:15:53 -0700 (PDT)
Received: from pop-os.scu.edu ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7405c2e7596sm7496824b3a.147.2025.05.05.17.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 17:15:52 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: jiri@resnulli.us,
	jhs@mojatatu.com,
	willsroot@protonmail.com,
	savy@syst3mfailure.io,
	Cong Wang <xiyou.wangcong@gmail.com>
Subject: [Patch net 0/2] net_sched: Fix gso_skb flushing during qdisc change
Date: Mon,  5 May 2025 17:15:47 -0700
Message-Id: <20250506001549.65391-1-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset contains a bug fix and its test cases, please check each
patch description for more details. To keep the bug fix minimum, I
intentionally limit the code changes to the cases reported here.

---

Cong Wang (2):
  net_sched: Flush gso_skb list too during ->change()
  selftests/tc-testing: Add qdisc limit trimming tests

 include/net/sch_generic.h                     | 14 +++++++++++
 net/sched/sch_codel.c                         |  2 +-
 net/sched/sch_fq.c                            |  2 +-
 net/sched/sch_fq_codel.c                      |  2 +-
 net/sched/sch_fq_pie.c                        |  2 +-
 net/sched/sch_hhf.c                           |  2 +-
 net/sched/sch_pie.c                           |  2 +-
 .../tc-testing/tc-tests/qdiscs/codel.json     | 24 +++++++++++++++++++
 .../tc-testing/tc-tests/qdiscs/fq.json        | 22 +++++++++++++++++
 .../tc-testing/tc-tests/qdiscs/fq_codel.json  | 22 +++++++++++++++++
 .../tc-testing/tc-tests/qdiscs/fq_pie.json    | 22 +++++++++++++++++
 .../tc-testing/tc-tests/qdiscs/hhf.json       | 22 +++++++++++++++++
 .../tc-testing/tc-tests/qdiscs/pie.json       | 24 +++++++++++++++++++
 13 files changed, 156 insertions(+), 6 deletions(-)
 create mode 100644 tools/testing/selftests/tc-testing/tc-tests/qdiscs/pie.json

-- 
2.34.1


