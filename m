Return-Path: <netdev+bounces-118148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A7F8950C31
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 20:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4776628508B
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 18:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F281A38DF;
	Tue, 13 Aug 2024 18:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1IlkAmc0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16221A2C27
	for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 18:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723573678; cv=none; b=tUqj/ye/Nog6Vmgnapt1ofzjzyhNP7wYeX57jG3Ut98tGy8x1/f38LBGoJYlBlpae+62leewOWVwYMRFA4HkN3asZxa4UBtQolo3fduktH0Bsz+yPORsVMYziBiZFLuWeyTQmmMiITaUwG34rKW63EUyKh4kIQFOHRq2Kdn4rOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723573678; c=relaxed/simple;
	bh=11Vo1GRIel5+sWXjEZX4YTqPJYZTmDP5+/gfPmKbZgg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=gS/7TTswYf/yYhaaG2/ayGUxgKn2ajPvZP0gW04A3UF9lJub6yFexQE9UfwtX2ne8uXIdLM1c8M/ZF3rkpAJwCyWfdwA8OoZWTPES+VMEBj3Mw90wNj0uIkXjIDXi6Cqgox8xN5BTFCNHal7ZlAPVl/kG38Dz6PkLf0+JrZjksk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--manojvishy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1IlkAmc0; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--manojvishy.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-654d96c2bb5so109369457b3.2
        for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 11:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723573675; x=1724178475; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Xx3vUn4Ffi9+cFtQJZC9o9842wkaz5PPRNr6UKhxqa4=;
        b=1IlkAmc0Y+yU63uOAR8SSCsZ8jPRACi6OYtHVkZ4Ge3iPcKSxCW4zcxre3CQXe8e2I
         QtgGmkcA+JnPzblbdj6k5KMp9t/IvtfTPxYBnR/k3dxcSWOjYiz12vecOxPdr3rz79Jn
         BUdu5SRUddAx/2goBu/TjJjXHBL7tJDFWsPDYXuSj6NrUA8uDf+bGSYWjQHjGTx9e//3
         uij3i+lHqmRkBmTT76CMYfGw51iVzNbz6JkZ2zt5mVKt7Hhkk7KBnG78sunOLRXQKm4E
         0rJeJ2zeVZ2szGCdXz7YgWBF5n2oLeagI7a6jSHeFv+EsaHxM/zQSYtamCzmICG+7jha
         xKhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723573675; x=1724178475;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xx3vUn4Ffi9+cFtQJZC9o9842wkaz5PPRNr6UKhxqa4=;
        b=C/VtGpcibMkhiiYPn7gxtF8NxUzTbMOW5s+n33zlhgMyT+zJK5pXpe+dCfkvf7duQ2
         A1DaLRO8nKx9bPxb/ZRhqJpc43bS0eA2S/7ziwsjpZQEGbxc+cB+PNFOdLW6yKuPgDBL
         BPYKW/V9bQGjls/cIQNfQJrMYpG8Zxd60iFYHx1qnpwjoqoSBoEt7pUD2hSUgBQARpTu
         /y+Y1FKzWd9Xt+bhuCvbnEzm0vITOkIuQSI8oOe/Wf88N04AVT48VSIM00GXSOhXrYBM
         7xgFzTUHoti4C++m0zNZS+Q7hZJWuTLeYxHkxPyK6TYqoTpeAcuoV2dKP1RZBnMXJhRc
         2bWQ==
X-Gm-Message-State: AOJu0Yz9f077OZ8eQ50yFEuclCPWJnE4RCra1nmldHR/e5X4OtYpNV/Y
	0RU1yfsBpf9yYMtOKhxuhgL4fYKD6F/FnsI19RGvRY7FYM6sLTXywHrxLhoUDtTRpuL4ovWll/7
	Wbv11a4a6aYltJOoufg==
X-Google-Smtp-Source: AGHT+IEx3+U3ZkvA7CMIoEjRZ4BxjgN2Bf0euNJuMc/TelI5R1HUUjVY1E3oCM0wKQAMuhyiSiaKXwm0TBtkioIO
X-Received: from manojvishy.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:413f])
 (user=manojvishy job=sendgmr) by 2002:a05:690c:3183:b0:6aa:4e07:ad70 with
 SMTP id 00721157ae682-6ac9736421emr4847b3.2.1723573675642; Tue, 13 Aug 2024
 11:27:55 -0700 (PDT)
Date: Tue, 13 Aug 2024 18:27:42 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <20240813182747.1770032-1-manojvishy@google.com>
Subject: [PATCH v1 0/5] IDPF Virtchnl fixes
From: Manoj Vishwanathan <manojvishy@google.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	google-lan-reviews@googlegroups.com, 
	Manoj Vishwanathan <manojvishy@google.com>
Content-Type: text/plain; charset="UTF-8"

This patch series is to enhance IDPF virtchnl error reporting and some
minor fixes to the locking sequence in virtchnl message handling
we encountered while testing.
Also includes a minor clean up with regards to warning we encountered
in controlq section of IDPF.

The issue we had here was a virtchnl processing delay leading to the
"xn->salt" mismatch, transaction timeout and connection not recovering.
This was due to default CPU bounded kworker workqueue for virtchnl message
processing being starved by aggressive userspace load causing the
virtchnl processing to be delayed and causing a transaction timeout.
The reason the virtchnl process kworker was stalled as it
was bound to CPU0 by default and there was immense IRQ traffic to CPU0.
All of the above with an aggressive user space process on the same core
lead to the change from Marco Leogrande to convert the idpf workqueues
to unbound.


Manoj Vishwanathan (3):
  idpf: address an rtnl lock splat in tx timeout recovery path
  idpf: Acquire the lock before accessing the xn->salt
  idpf: more info during virtchnl transaction time out

Marco Leogrande (1):
  idpf: convert workqueues to unbound

Willem de Bruijn (1):
  idpf: warn on possible ctlq overflow

 drivers/net/ethernet/intel/idpf/idpf_main.c   | 15 ++++++++-----
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 14 ++++++++++++-
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 21 ++++++++++++++-----
 3 files changed, 39 insertions(+), 11 deletions(-)

-- 
2.46.0.76.ge559c4bf1a-goog


