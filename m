Return-Path: <netdev+bounces-48753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 001447EF6C5
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 18:12:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0FC01F2448D
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 17:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22E9374CA;
	Fri, 17 Nov 2023 17:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="pf6YN4sE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F72D6C
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 09:12:27 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1cc0e78ec92so17234875ad.3
        for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 09:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1700241146; x=1700845946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eDsKZjJr9cxgGlwNtxTzxj4aGl/UzXsReG/RDUj8jmk=;
        b=pf6YN4sEBSEI5cx7eoVdg9Ai5WYaMevL4u3uk/h980vYfJ4vQiDEGEnL807iyOrmfP
         qsbtvTxi6L7eNRR5pbNioAgEk6+wz/JSuaMd8gaPDybgt4DPviEZmaIow3rOKb3NbF5S
         h0bZ9vDlv3JRc2nwt0Mp1GwSOhKkYOoT98sBw4/7inGWUppMHNfj77rrgUopEHt4RbZF
         cbyEyTWRcl4msbclBGBJj4fkrXc6eGyjvHVqvBtU13XmObBvZRM4VAER8+F8w4sNSMPe
         8cgjsJ0DdtDQReUdK/PcfmsgC3+E7WI4VPXGUMJIYDcUV1+5c7oRbcKw8GGhFAkBZ/Yu
         or1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700241146; x=1700845946;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eDsKZjJr9cxgGlwNtxTzxj4aGl/UzXsReG/RDUj8jmk=;
        b=PFFwpnDxrQUhmPI7Qspues9oUyGV/SBNmzpSwSP93EcjzWnji26k8Qf+lU/cbLxdtx
         5tM47Id0Hz4hUjxmUQal7GFbKD7G6XprQa/hZNoHwb04tCvfP4bZhMElyv+x3FGxidu5
         lBO1OT/XWvog2zgpMemTRMAMZmuI212FHF7uey32XeorvnRdfLFGx2q5+i3QRf7882My
         SwjaiDlcdblSdzkmZt5C4e8tr44KmQUpQce+B6I0fprA772cEk6viPplL3ISPnprbN4R
         +gRXgJmt0G/GTWb805ZgQmGph3rxlQKzxOOD4MvyXjWtsRZpHyjyCRIcsX5pjqxye1OC
         QgLg==
X-Gm-Message-State: AOJu0YzJefywudLXkltrfeLExWKJdu3mOz5QP8Bh8PXhjyEhmUuzV9VX
	62mSi4ruBsJBzVNDmECDOsFcvc9EZYezX1hnD94=
X-Google-Smtp-Source: AGHT+IEl0LPgaVoRhACJs9Cl37J19GMH5BnDJdd43ekRBSSr2PCpBZkcPMmHxphQ9AJvzZKwSHJZdg==
X-Received: by 2002:a17:902:e88a:b0:1cc:50f6:7fcc with SMTP id w10-20020a170902e88a00b001cc50f67fccmr223270plg.55.1700241146304;
        Fri, 17 Nov 2023 09:12:26 -0800 (PST)
Received: from rogue-one.tail33bf8.ts.net ([2804:14d:5c5e:44fb:49f6:37e1:cbd9:76d])
        by smtp.gmail.com with ESMTPSA id c4-20020a170902c1c400b001ce5f0de726sm1343979plc.70.2023.11.17.09.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 09:12:25 -0800 (PST)
From: Pedro Tammela <pctammela@mojatatu.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	pctammela@mojatatu.com,
	victor@mojatatu.com
Subject: [PATCH net-next 0/6] selftests: tc-testing: more updates to tdc
Date: Fri, 17 Nov 2023 14:12:02 -0300
Message-Id: <20231117171208.2066136-1-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Address the issues making tdc timeout on downstream CIs like lkp and
tuxsuite.

Pedro Tammela (6):
  selftests: tc-testing: cap parallel tdc to 4 cores
  selftests: tc-testing: move back to per test ns setup
  selftests: tc-testing: use netns delete from pyroute2
  selftests: tc-testing: leverage -all in suite ns teardown
  selftests: tc-testing: timeout on unbounded loops
  selftests: tc-testing: report number of workers in use

 .../tc-testing/plugin-lib/nsPlugin.py         | 98 +++++++++----------
 tools/testing/selftests/tc-testing/tdc.py     |  3 +-
 2 files changed, 51 insertions(+), 50 deletions(-)

-- 
2.40.1


