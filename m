Return-Path: <netdev+bounces-249199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B44D15683
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 22:19:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 571013017EC6
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 21:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2D4320CBC;
	Mon, 12 Jan 2026 21:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KRYTOVjO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4854123A9A8
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 21:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768252779; cv=none; b=aXywSkfiThSgTIzxasGEOfP0uNVfufhamFLlm7aMB1FLm+FauTparpjoBZ/hSu2nOUYoBby6UAyMM/JYS/bP2t1KMd6Vc1TGCqzHD5lYP7Kv+u513uqFfgHGP49S6Zyk45zDXzC1cFca6Gq49Q/zTsSDN4jO+GI2S7iz/RKczwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768252779; c=relaxed/simple;
	bh=wA7bFjKH+T16ZSdZiaf7+k+SarHl0ZD3QqM8Lqmh2+g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o6q0FO/z1PzmtzGqAwg0M7MoqPAsD6jN26uBrEiKOVYQ4Uf69aqNwwW+99i5A4PXzZeDNI0bWzSTQEAQo8+yuc45lbf/aoGYXy3l7DjliBv6EiMkCqQ+0g1RLn5c/WlpJ7ZkHh+JokAHuzVOiqq1+LzAgMzA5MN8mp1VKWJMCtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KRYTOVjO; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4779aa4f928so69722385e9.1
        for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 13:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768252776; x=1768857576; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IiY6gToPxpPOujD8sGznkJX9FVtl7pHhbZxZDrozoNM=;
        b=KRYTOVjOuumS32IeiBLxB30LyVlojW0VR32lbQ0/qKNWtmrYlzav3plDgZM2VZjRCM
         uy4jQhCQab2LuCxFXQmaj5UpyNYjpQiHW7C+4eFRPQ5qyzZ31jVWNyzvOAEBYsDPkwqx
         nLVS9J30ukuhPtOMR/belDoKR6p17AJmB/lFa9ZIyE28mwKpMy4onLyKijSMmWOcvZ7d
         GnD+KLiMU3zmR2b+7bjJEctkwydsJJb2rMemj9y7uhl1K+5k0jQ6/uxN7SYawellMUjO
         DOjVq77kDrtTcozIxIGGdCesM5cR72EDWs4GcPtJhU5uMOsBiKyPmoqV+rPBq9lF1XHM
         15tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768252776; x=1768857576;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IiY6gToPxpPOujD8sGznkJX9FVtl7pHhbZxZDrozoNM=;
        b=TS2U98daoGRrWmUfjMUW3c+K/xUCJWQtkfydR088wLq4Efo6H4qwTDF4F32eK/+b7X
         KGw/GKIV4AgXt+NqGe21ZcC+FQz47mmPQU3dDVJF2xFUQAaukgq8euoe/3hhFeIFa2Aw
         epXcCg11wbTDn6Slh8tPo++iB919t124OWnsaSYptzLMoZukzO+J2M0avDdVzulkse8b
         N3HoiS4lvKFJO5pxlVyq+X5rqw7672AhBRJayTuy/s3xjK/MW8OPZe7ab0PoHP0LIDTn
         JfKCM+esD9Gzk6ML/KznD9eDdgWEhdeAeq42YXc0/zkga39x9gjAjjYTQNRdFKnPPdU+
         voIw==
X-Gm-Message-State: AOJu0YwfWfa+aXHKNYWDPhHElhzmVyEQQUPHwbrG4yKuGc7brfKiFaE9
	FJWwfliCO06rnFZoWYdFNHzpdaYOP+GF/j8VqWvb5PFLx9n01vkhYrfxbqi+Nw==
X-Gm-Gg: AY/fxX5+f6AT0Ug2xgy8Ie5fIhwf0ApR6IiyASJ3OviitN2qOoc8lz38pqwWhCRVlFN
	veyxWfiJj+L84x8xXM+USu8OVqhUpz6koeKbCtWu6CPdpUeCcwyoY0fwU+MEBwnedNTsgOGI4+J
	3U3zoUU0eHZqs9yvRcynoN6YqfFNy0ciYLzTnWX9tGN7Gl3HglHA3Dj78khKaa1jR2WnP6acJdI
	R7qShSWZgLQknWKZfogDL+Uma2ewTkemPEfNg63Y2mrxotr3HGtKNeiab9SUEVyyg557u7YuGDl
	wN6qKfJpVsgEd3Aa7/HaZSF59co/KpWMlCHUiHCIoeCJi/CAuwzxC6lOfMkRA4cZb9bAZuy3lhV
	Y57HB52GA3Oe09/7tYP1jGMytzTUEpD1C1p1kIsswUIJ/7/YB0qw3Yb4O+KwcIu1oNr3pr5A+/S
	dWi+tw9CPs
X-Google-Smtp-Source: AGHT+IFU0mSbTfAEAKf3Oeqgfj2C3VEXICtQ9LWc7EAUdZWwcRf/gFUFmObHav2ehPypIpesMuY5LA==
X-Received: by 2002:a05:600c:4e8a:b0:479:1b0f:dfff with SMTP id 5b1f17b1804b1-47d84b170famr255002715e9.10.1768252775948;
        Mon, 12 Jan 2026 13:19:35 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:48::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5df8besm38463659f8f.26.2026.01.12.13.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 13:19:35 -0800 (PST)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: alexanderduyck@fb.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	jacob.e.keller@intel.com,
	kernel-team@meta.com,
	kuba@kernel.org,
	lee@trager.us,
	mohsin.bashr@gmail.com,
	pabeni@redhat.com,
	sanman.p211993@gmail.com
Subject: [PATCH net-next V0.5 0/5] eth: fbnic: Update IPC mailbox support
Date: Mon, 12 Jan 2026 13:19:20 -0800
Message-ID: <20260112211925.2551576-1-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update IPC mailbox support for fbnic to cater for several changes.

Mohsin Bashir (5):
  eth: fbnic: Use GFP_KERNEL to allocting mbx pages
  eth: fbnic: Allocate all pages for RX mailbox
  eth: fbnic: Reuse RX mailbox pages
  eth: fbnic: Remove retry support
  eth: fbnic: Update RX mbox timeout value

 .../net/ethernet/meta/fbnic/fbnic_devlink.c   |  8 ++--
 .../net/ethernet/meta/fbnic/fbnic_ethtool.c   |  2 +-
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c    | 42 ++++++++++++-------
 drivers/net/ethernet/meta/fbnic/fbnic_fw.h    |  8 ++++
 drivers/net/ethernet/meta/fbnic/fbnic_mac.c   | 24 +++--------
 5 files changed, 44 insertions(+), 40 deletions(-)

-- 
2.47.3


