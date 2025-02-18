Return-Path: <netdev+bounces-167202-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B606A3921F
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 05:32:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 343E516A3F6
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 04:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C24F15E5DC;
	Tue, 18 Feb 2025 04:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I2sce6Ec"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C6B81E
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 04:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739853150; cv=none; b=p0/E2/WYLkgqdR6tfT5JN2Mkh1WgDb8L4uw4pBsIk8mPhPLr6t5Kpz29Vk6Bs4MMdm3YZd8DcWStcHotAYS4wFI/nuUkWxtpfRh5EN8azRAI9auo1AkFte9/Tp/Z93taDyIRGdfiT91sYaweVrPWtptuWb4/LV5MNdK5ZH7LRFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739853150; c=relaxed/simple;
	bh=eP1ApaxinshP+F9LGKbghQgKlhP+2Jy8c9zKsejpdNE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gU/m1iXXl0/P8d5dRFSonuDGV8HhnrCno+K9LcvReFgUKRvetvS0p3aa6vNYSuSsC/OII8aUT87Jmcw6JtBRm7CAWK+jRuT12UpIFdQtAkw9fs7+mF9OTSk6fUuVpolmAOWgAnS16aoWrb5r7e3FaGISI6J+j0q+nrxTLdvGet0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I2sce6Ec; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-220d398bea9so69096825ad.3
        for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 20:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739853148; x=1740457948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nhjwsYuI45a4ovomg1B+JO7iiXzrfo2+vXAAHqC2Ziw=;
        b=I2sce6EcjVQAryyiePmPbgUc34z+saRvHO3+JaCk3k+HkngBrkclW5h32WM+T2YtSO
         g+QFy7AIhPvkpjFFH7CxpVqcX0c0i7vjt8UstKYZJt9THT/JIzSVtL/V6+oHxdJzNzqb
         bccRWgIskWXDI5RzKH/xi8uTXxzbZrhYQIUnQ24lVEBjHKAZIkpMddKgXOfAPf5yxY1a
         FuI/WVboqnHvemat/IOXFevPOgBXUEWjUq2GTVmJm6yYfZSHs1snPwUxbCNLK+eClpcP
         8Yh5yT1ypGyh7lh5J8wD3ogQ+MyqHZSJTXh+pE7KMEzwYGoPmsMQHQGD9VduRbWJb/1Q
         sO1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739853148; x=1740457948;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nhjwsYuI45a4ovomg1B+JO7iiXzrfo2+vXAAHqC2Ziw=;
        b=FOwtmRjKA2JjrldxUOJFvToqLN8bIXLfXhN15tJAcUe2mnBG1E7eTZoaYF8TKxNgkp
         7J6HeF5dikXwVocUle8LnCQeB2+t/Am5D9esyFcEl6PM+bZ3ZZ7LWtH6NMY/IbMMfBu1
         sjKvs1CUngrZ6rsyox7FXkDXNNAHhOiEkcHSCS9U23P6jXzeNnzllMSyRUSD5gM1UeTd
         6Q6UFY2jzb+ssGlXs5JqvoXr1xoZwVzrwDpZBuKcsTpJbJVyPXvPXqjW5mexardlY2I3
         2FBj9An9AUQ1xGBp5Y/WuZwXgXcHesj8NdYIEx9pwAkSkyfuV2/zKGN2oQn2eWkFz6EF
         /F1A==
X-Gm-Message-State: AOJu0Yxk4jNHzT0xqAKw7H1qn/gKKCUX1SAvePkuz/pZiu3uFrUGv7sI
	toTDPIuq1Cx1kDF5I6jhdqR8AvqlniCPzc/rYUoRO+8e0dh5HVub8Ak2FA==
X-Gm-Gg: ASbGncvmuZwfM8HOceC+4ikrf6TTc6usBp1ioBlhBgNdvfjKNiR6XLl3UikUhIImo//
	m7PqC+oQknTUG3Q9mFc+/qYXjA3US5KyvU5J8rx02vWDFBlFwOYato0CSJYomn638l/2iuYJodu
	g2GufAr4j2ZKkGKRi5iwWODgOajA1Xh8UjmW7SDa5HYvLW+33aXjJSqVQocz8WuPHBuzB8vJOCk
	lcVL0Rm994I+rxXi3LOjdmrqX2DA70E2dpKBHqs4h/LM+wL04wsaVyo4ANr9ZL9xljWvu+IN+Te
	tqFZAOP/yDGvMqIG0bdCluf+9OOUiZVB1N0s9JpgS2sQ
X-Google-Smtp-Source: AGHT+IGf4sh2jeppqnuX0Mba77hhtX21Ew+6sJiN4QUEtyDDYaK6X9jXLxqmueYdlbZegAw24bGnwQ==
X-Received: by 2002:a05:6a00:1a89:b0:725:cfa3:bc6b with SMTP id d2e1a72fcca58-732617757c7mr23455211b3a.3.1739853147695;
        Mon, 17 Feb 2025 20:32:27 -0800 (PST)
Received: from pop-os.hsd1.ca.comcast.net ([2601:647:6881:9060:304e:ca62:f87b:b334])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7326aef465dsm4907501b3a.177.2025.02.17.20.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 20:32:27 -0800 (PST)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: Cong Wang <xiyou.wangcong@gmail.com>
Subject: [Patch net 0/4] flow_dissector: Fix handling of mixed port and port-range keys
Date: Mon, 17 Feb 2025 20:32:06 -0800
Message-Id: <20250218043210.732959-1-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset contains two fixes for flow_dissector handling of mixed
port and port-range keys, for both tc-flower case and bpf case. Each
of them also comes with a selftest.

---
Cong Wang (4):
  flow_dissector: Fix handling of mixed port and port-range keys
  selftests/net/forwarding: Add a test case for tc-flower of mixed port
    and port-range
  flow_dissector: Fix port range key handling in BPF conversion
  selftests/bpf: Add a specific dst port matching

 net/core/flow_dissector.c                     | 49 +++++++++++--------
 .../flow_dissector_classification.c           |  7 ++-
 .../net/forwarding/tc_flower_port_range.sh    | 46 +++++++++++++++++
 3 files changed, 81 insertions(+), 21 deletions(-)

-- 
2.34.1


