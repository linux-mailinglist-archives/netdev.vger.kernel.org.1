Return-Path: <netdev+bounces-144338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 278F09C6B38
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 10:09:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBC43B25EC3
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 09:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12001BE841;
	Wed, 13 Nov 2024 09:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jPoPGMOD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9121BD028
	for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 09:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731488930; cv=none; b=IYVY1uIcb/yDRC5F96cF78xwGii5ydHg56Puzwnk+AU2FCMlg/bz7ixiYESLtW/4XKhzn2WXHITyzZelBj/MJ8SHtfBg0RZd4AgVSOCRIsWDaux2FHJpzlmqXX0vyJcFgqYfI7jaMi/oXl/Z1BpvtOL6elUhntcOzL6bqwz1bOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731488930; c=relaxed/simple;
	bh=Durmvmab9H2DdTpiyQ/HKfkPwXkmbSV63z2urBBwPO0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fQ1uqa9WUO68gt8H/yW4JgFhUe/hT97XTGEJBxnJAjYprwIOM+EHIELQbB3/gshGr5Ep8k3kIL443IyNH14fMOMpW4cVjrnpHjfAjQSF7jfzI2ejpDcLmoG/nMgjJ1r0BLnnAN6b64i1bI6WNX6vKc3PXuzg7aDp2YlaBPYREyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jPoPGMOD; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43168d9c6c9so57770185e9.3
        for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 01:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731488927; x=1732093727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uwayePLXzQA3vPEE58wHebC9Im1Wn0SJu/QXYXB8l6c=;
        b=jPoPGMODJXzwDVjLLM+xZo0g9gKrwcj38cnBezlI9MSuZ3I2HxszpDWES6tU5fVQOK
         ouDPC9yd8o+sBvk8e0d6Hj3epS6nomog7w/VNHdvy4Gna8jfqw/d+kMH8FSBqFWFhMbV
         borTX8Q3rI0jvCzRA6mckDiVojgJzfD9qZadWsG6Wa0HtL8fm79KBQ39ynU2A1hSKYmg
         3j+R4i+LcJ6et038Z5+m0kdIcwjjhAsLvcVIFz5fxar5xb3yhdI4s48lcuPjq4ipo2DP
         15pWXoZNkCGvkzXy2WnpxsEHA7AHA4HBoqHzN1rm9or00wnOKEAiW81X6XW7yKdrvRI4
         ZzPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731488927; x=1732093727;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uwayePLXzQA3vPEE58wHebC9Im1Wn0SJu/QXYXB8l6c=;
        b=CCgsYJ/qhBuLf7bisa5LMkhzCdf/ON5UZ65I2tGim88v7/V0lUMh/elvN0tXehY5pM
         +NpJnegQP1fB5+0RiPnq0oJMFhAs7K6t/6ki/48v1Q/jhwzCT+5Xec4gWqC4mfLtDg3W
         s82SoXgLmTfDSpJG+7Fn2L7eKo047DA1h4SineQlvEzvBAcZiY28GhZnZfu6tM2Zv2fV
         iCPeBC97lGG8/UtUfBCpAngZzIEP9N2Gw2tlQz2N07zqrHOpUj/coNuJS7VAx4gc50Oa
         Eg/wmtgyWO5ZzpPG0r7Islc3L11Y5NU1AHTjxp4/Y41yo377OSwSk4xsFU/ha7XdJumB
         686w==
X-Gm-Message-State: AOJu0Yy1IPhdsj/Ao32PGXY7sZEgMIG8myGeE8AM8x9ttsMfEJVy4BQ/
	2L1O5f/YiWZ2Ch4SOuZ+8KR7Ysyz3NhEzlkia6F/5u/rwmcxSpoStWYFfWXx
X-Google-Smtp-Source: AGHT+IGBIzjjGHHR9XP/qddY0BcjONZMd2vdYKllENBJJCJ/UnTadUwNSltB80PTVeFktvYDsG0h4g==
X-Received: by 2002:a05:600c:3582:b0:430:54a4:5ad7 with SMTP id 5b1f17b1804b1-432b74faabdmr163867375e9.1.1731488926612;
        Wed, 13 Nov 2024 01:08:46 -0800 (PST)
Received: from imac.lan ([2a02:8010:60a0:0:c1e8:dddd:ac2:ca40])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432d5503c63sm16939165e9.26.2024.11.13.01.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 01:08:45 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Xiao Liang <shaw.leon@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v3 0/2] tools/net/ynl: rework async notification handling
Date: Wed, 13 Nov 2024 09:08:41 +0000
Message-ID: <20241113090843.72917-1-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Revert patch 1bf70e6c3a53 which modified check_ntf() and instead add a
new poll_ntf() with async notification semantics. See patch 2 for a
detailed description.

v2 -> v3:
 - Simplify timeout logic - thanks Jakub!

v1 -> v2:
 - Use python selector module (select / epoll)
 - Remove interval parameter from poll_ntf()
 - Handle KeyboardInterrupt in cli.py instead of lib code

Donald Hunter (2):
  Revert "tools/net/ynl: improve async notification handling"
  tools/net/ynl: add async notification handling

 tools/net/ynl/cli.py     | 20 +++++++-------
 tools/net/ynl/lib/ynl.py | 57 ++++++++++++++++++++++++----------------
 2 files changed, 44 insertions(+), 33 deletions(-)

-- 
2.47.0


