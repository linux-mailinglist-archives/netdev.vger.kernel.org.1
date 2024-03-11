Return-Path: <netdev+bounces-79049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA748779E1
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 03:41:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D68F61F212BE
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 02:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B053637;
	Mon, 11 Mar 2024 02:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MjxMUUx+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2EEF7E8;
	Mon, 11 Mar 2024 02:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710124873; cv=none; b=ZVU0HckJEOmrUAWIDnhtXAH7HiI+A2PGlr8D/ZNXLikhkJrH1ymHtH/jj8ccVlUFajOVd6mIPIlM8WiwNUVzlZgGHUPMMtuUPmCwW7OuudMmJbR/NpqBY1duohGrC0QkXYTXmyLcQFfaBoFIJT3FYuKiS/sbPBwolrVbhtzsBCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710124873; c=relaxed/simple;
	bh=CrvNW0WvFNWRkK1hlZlXZX20cQsZiRyT2kXgHchsSKw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Wvanvyp/01GlnJtWnhnly/eU+0NaniJTqoibpRXvhlPDtwJVSXTXk/2J4+3BUggBxzwwZhwNDbYL0pgHS45eA4Jyd43nmprWzQDJOPLgVPmFMgD0XOd7ukqePPW3rVzW8ts9uMYwdHsNyfuyMhwIZTY3XYlHHyhyA0GXale1kao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MjxMUUx+; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1dd611d5645so21887295ad.1;
        Sun, 10 Mar 2024 19:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710124871; x=1710729671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LsqN+whrJyBB0inPIyMfkW5HTQSvYs2HGyB5D4w6/FM=;
        b=MjxMUUx+hPD4Zo4NjtvJmaaClOokceJgcpFv8PJO6GWtQzrYsnWvDx5AcKKuJlMf0B
         LR2rcKiAmodWGcx3yyuUn265mJvkAPtXfL4AvHlF/iTqwalYF6plsCYtAJ7neZDri5VZ
         AuzXCyFQ50DZZPWe6CNM9qYdnVgYsQQh9pCWQKNOH+NH/GiXFyw4HgiD4mkez6ThlsCr
         LEffrMZlCOLaFITtPinjvYt/Q/eFiuyOmAY5Iw+/WsnZujhgwN1+wnnkNaXAwX4WXIqE
         lYjLfL6mH8ZSLnfjTuyEt9Nu6uFQjdo6APCpka47tgQpjgFiJlZXhHJiwshjSnKS/AGP
         SVmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710124871; x=1710729671;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LsqN+whrJyBB0inPIyMfkW5HTQSvYs2HGyB5D4w6/FM=;
        b=uRFge0PgRJJTJod+36CiHB31G4ApxrqMQ27rmoZ9Ez9QdhUQQKFUFRP78AnAjzuGB4
         ai6o/mext7BG2cY+myKbtByj8VAGAWVMGN72/TP5O7vlQqWSBXJR3VMqkSHuL5J6FaAk
         UElGQjaSMdiJGT3I+o97BUGi4BciU2SjNWHM0PJ86XIyoOXkLlvh4pByrvbLueE2SOqr
         7lJHFS2oKwXmLdu9HXjKMkIAuUWp0LkeRQHpV0ZQgP7/5CdieNkfflG47/+K2HUcYg4X
         48V4OzzGOA7SWnjOnPDqkaeWb7jIXSidF3Q9p6MdC99SX7M0oTR98l5SHR7QeW2wooBm
         vjHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEu0e5ADh1vOz94WFYltTs1xmYLqsrfCtidvEIon6EsmN50NEIJNT7R91B22TvY40b36IokTVZLr112VUpf85P6d69GK+uev29gGHi2qill7vQ
X-Gm-Message-State: AOJu0Yyg7ljFAGRZyDuvA3AH58L5puheyaugGksSYpEF1XrwfPjL6ndg
	ULkBkHk90laLsrXZpyE3EfsX6PAPJxAZVgjIPYaZU1S0ANWm2rPqB271EQH1KtsoCw==
X-Google-Smtp-Source: AGHT+IFfRjtk5JYrk1QfGsEbD44Jv9VuSc4S9yUpa6LlQ462984zhRZA/iLWZTYrzGHN2uAjuptD4w==
X-Received: by 2002:a17:902:f690:b0:1dd:9250:2d58 with SMTP id l16-20020a170902f69000b001dd92502d58mr2837632plg.18.1710124871052;
        Sun, 10 Mar 2024 19:41:11 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id y6-20020a17090322c600b001dd98195371sm1135120plg.181.2024.03.10.19.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 19:41:10 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: edumazet@google.com,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	rostedt@goodmis.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next 0/2] tcp: make trace of reset logic complete
Date: Mon, 11 Mar 2024 10:41:02 +0800
Message-Id: <20240311024104.67522-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Before this, we miss some cases where the TCP layer could send rst but
we cannot trace it. So I decided to complete it :)

Jason Xing (2):
  trace: adjust TP_STORE_ADDR_PORTS_SKB() parameters
  trace: tcp: fully support trace_tcp_send_reset

 include/trace/events/tcp.h | 60 ++++++++++++++++++++++++++++++--------
 net/ipv4/tcp_ipv4.c        |  4 +--
 net/ipv6/tcp_ipv6.c        |  3 +-
 3 files changed, 52 insertions(+), 15 deletions(-)

-- 
2.37.3


