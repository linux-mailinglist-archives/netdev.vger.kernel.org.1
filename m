Return-Path: <netdev+bounces-130463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1EF98A9AC
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 18:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDC951C225A7
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 16:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A86D8192D82;
	Mon, 30 Sep 2024 16:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="tmGS/2D0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2456D1925B6
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 16:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727713473; cv=none; b=m0kyH+TGjakVzhcEb4cdp1U8pJSIcLM88tE5rTZb8Lbap38pyZtZsTonmSKW6B+PYF+CrOChcduA3KbSeR+VgDZQfgnWrMWX9frT76JCLj9P8mVgIwNgQZIpUOTqIbkapX34HtiCOH0dZ7cKya1/u4a6XlCHH8bKNHsKyRUsSC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727713473; c=relaxed/simple;
	bh=MXTkDSIJkG4+O0I/bwpPCZQj+y4yghFFQxAInPbhkbc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dgwFhmTH+5BteuZJIMBR/EpCqDHpON7iRF83wb/m1wtNCKwzQFMpRKJNI4GN3fY0ZFJMkDwv39gzzkJAgoLzJhWMbSYFc6FwYQGAvm2GtO9LfPcGT+4+r1mM7+mO58k6u2TrBR6ixht/EBDtP4I5ebC73KjDPDhKipMuTrNCGmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=tmGS/2D0; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-718d704704aso3833929b3a.3
        for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 09:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1727713471; x=1728318271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MrGt5Upc5o7Dx2xzHjGWOE9OwgSldZ92rzSBdwBzh2I=;
        b=tmGS/2D0SyEt28R9KcRrTVW2f82r8MO+HN5f9H54srl9AMXxScqpHeaN1h4qOkULqi
         /LHrIm2FSE5nwQ4zXCJdAaTGqNHacleLPkGLZmEiS8ga+r+anMhS8ssWuI1Ku385lILD
         +IascO1gmdNqqzLYSOlS94YBL6mLI03SdogvE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727713471; x=1728318271;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MrGt5Upc5o7Dx2xzHjGWOE9OwgSldZ92rzSBdwBzh2I=;
        b=nvrr2YfNb9sz3DvD83q4YYVgpGmcNYda1zpcqgLfktzAo8Wp80FvRmJd/Ro4r+Zkqc
         HsZNvnOvL9/vnAWR+dnEKRieglDt5HS3feyp1CYc9iLE8eXxWTyMZHNtv5PFFlIZvSbv
         qWb6SsiOViKzCwZIyJvQaFW/rY1yUVbVUi622wX/Z4rdKoFVfDRAVGtDX9l8p5PMin9C
         fvZ/4TejwWRuCF5SaQBEw1GoZxWw8cuc2VP+927rG9GMngX1X+1kfWd70A1NZ0KSC6J1
         uXOqOrN/0rXDQI5AdY5SvxRLoEoOKmB/C6WyK92ZfYrIkM33/MtxUO/fEonCB+jIBxVw
         DPdg==
X-Gm-Message-State: AOJu0Yw1Gc5gyyC3sZtENwNUsZ0JXv2ZiIqIJ6iqyl1NkFptXydD5lPP
	dSo8oQqZs83QE9GNNhcbjqRm0GNnGtByucbCFesocwce7xy78s89r8NqHFT8hQJGJUOG58j6g62
	eyp3KwT7XJklZImJRKuTvYbHmkiDH8TyHX/cjGg+uD4Q9OLZN9PfFW5BrCppVJlCT7DqAAXGzcD
	aMARjua1o90j2tebM99vIepmivo9/Yj5AtJzE=
X-Google-Smtp-Source: AGHT+IH+F3Tf3jKyC0qK2FNN1dLVKxM+uT+5rdmirqYof6Zm71lmr9+KaD68IeM8aJIQdD5MFKin8A==
X-Received: by 2002:a05:6a20:d806:b0:1cf:9a86:56ac with SMTP id adf61e73a8af0-1d4fa68e8b2mr16968293637.17.1727713470897;
        Mon, 30 Sep 2024 09:24:30 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b2649f879sm6411451b3a.22.2024.09.30.09.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 09:24:30 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: Joe Damato <jdamato@fastly.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	intel-wired-lan@lists.osuosl.org (moderated list:INTEL ETHERNET DRIVERS),
	Jakub Kicinski <kuba@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	Paolo Abeni <pabeni@redhat.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [net-next v2 0/1] idpf: Don't hardcode napi_struct size
Date: Mon, 30 Sep 2024 16:24:21 +0000
Message-Id: <20240930162422.288995-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings:

Welcome to v2. This was previously an RFC [1], only changes applied are
to the commit message. See changelog below.

While working on an RFC which adds fields to napi_struct [2], I got a
warning from the kernel test robot about tripping an assertion in idpf
which seems to hardcode the size of napi_struct. The assertion was
triggered after applying patch 3 from the RFC [3].

I did not want to the include this change in my RFC v4 because I wanted
to keep the review of that RFC focused on the in core work instead, so I
was hoping Intel would be OK to merge this (or a change which
accomplishes the same thing).

Please note: I do not have this hardware and thus have only compile
tested this.

Thanks,
Joe

v2:
  - No longer an RFC
  - Added Simon Horman's Reviewed-By tag

[1]: https://lore.kernel.org/lkml/20240925180017.82891-1-jdamato@fastly.com/
[2]: https://lore.kernel.org/netdev/20240912100738.16567-1-jdamato@fastly.com/
[3]: https://lore.kernel.org/netdev/20240912100738.16567-6-jdamato@fastly.com/

Joe Damato (1):
  idpf: Don't hard code napi_struct size

 drivers/net/ethernet/intel/idpf/idpf_txrx.h | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

-- 
2.25.1


