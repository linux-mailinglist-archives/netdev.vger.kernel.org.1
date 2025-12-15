Return-Path: <netdev+bounces-244716-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B85CBD8F9
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 12:41:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 87A5C302AF9F
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 11:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C26233121C;
	Mon, 15 Dec 2025 11:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tojwlwse"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C969A330B01
	for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 11:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765798755; cv=none; b=u5e8BNGN/f91kCzGPMV0WLdaNZgpuXmE8Ic+ioUkYF2PjthKhPrcjlnotL+dApHd9gk7mh52lM0nIDaUm3u6czy2Y9GSHz8T6U0VHYDiL1710Bzwy4kdhOtBxxsI8uxNNk3KUXZoTrPdkzHebTz9qN4UL+0YAksilT6CYkCzpXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765798755; c=relaxed/simple;
	bh=1tOY86lhWOCbSHsqmK/tuDEilXGPwKXl/15tM3wSixs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hMvWu8vFsYIRar9VnJoxurFnTDlH7shEQjvZszmT23pkbPIkyEAax+hTY6vHnnEwyGJcG8eyYNqEHKf7GUaHsJtv5uQLN5QUAAVRepdPLREp8WhNhMM1goqjv7C1rTzLA7UL2gLCtQb+tUA/0V8KFnPxXwxD3i4ptFLy5CJ0gJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tojwlwse; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-34c213f7690so1777864a91.2
        for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 03:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765798752; x=1766403552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TWXueLrhDneeDmCGizpSHzMSgAg8yMgxTmeT/qXEn+I=;
        b=TojwlwseVX+yx8hiv6n42hswCsaChjgYL7PZiLWeal4LB2weD0075dxOBQbjM2/VH3
         LbQuoXw+owmioB9Y1rSG4HbW/yf2TRUTHH8DKIRA9EbKUZF9HKtEE/09znZ8i49Z2wvY
         IsouIW+CiFxgM/HujW+0dJeaPdSx983d0AAmLFtrYEO/a5gtleSWwPmTPr1Ky5NHHNm6
         ennU+kXIpbuvsUaEd5FbjPMEQJpoSRYOHN506DBFi+vp3gexG9caYgTxYlwvobzYrfBe
         +s/5okQ5trSeDdrw2d+5mHJOsXxuO64dtKvi9mxaXjM7mayzWPr1E2NUzjlU3q40K4IW
         LFMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765798752; x=1766403552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TWXueLrhDneeDmCGizpSHzMSgAg8yMgxTmeT/qXEn+I=;
        b=U3pbD8BoKBB9CPl/nloFWAnCZtxzSM9GuryWZ8cax9EiltysrYBc0EzxqOM055JNsI
         9TuH0iZLC/UteS1rwIJA12IT05RGwRPRwThisKmnvQq+38jqco+11L+MQkJUDnhX2iP4
         lE6qK37AaE5yfUXCPBOSmz0Iy0SUoBMLcR+gPO/BE8m2yRD6kiTx6zLvv8MPkBFfyJiu
         4WldZTbeLQaJTdILvKLxRrgEh3mSdtBU1CbokeehqAqZoSLhZJML7RSKbfu/0SoO64r/
         VkP9e6sQ1LlIZPf7BRUQlhmxHVWxxOScP5+NXmEvNQ0hM8CF7YkpuZ/1dlZCGeaxAjbK
         NJHw==
X-Forwarded-Encrypted: i=1; AJvYcCXjJk3eHQdH5NM8kB/m1YaQKh0HA6muVZhx7pq6RWUpxjSVGTnfmOnCzxxlOP7tifHDe/QSnDM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFDAnBqo2Nsn4mAXQyYeY1cTSCTmaaqMMHJYDUtEGHJlahwM2f
	wNdYJLgLQaqa6YHkU6Ew90XW/VmPhfrEqSmUDSgDI19+Q3K6S6pzFZT/
X-Gm-Gg: AY/fxX6jK1k4egO+0YaUMUUp5ZBFGACuSppsc1VuWeyc8zyHungaGDS2n3RR3SEmLBT
	rBH/agbrYOul2KW3y+AYRxatSdAjuegL7L48Ny7fEVxc5g0j2OxK5sTEoNyD2wmNNU69jHQkqXl
	cgk4Q9st0QkPrhs5MUyMImgPXgJVp+W0x6uWPi+Q5H4bGRPq4Z8x/VEyMj0s6sIrcBqestvJcnF
	v1cvRi7+fkRLJ60HFTT96ipHEn2iUhT/hYLbE/hqbsasrPxic1nTlxAGNYUgbgKuaLUi8r2mcFU
	aGWyel7SpSlJrDI5UfSkgT+UJGZp8ziTVLaG2Q16LB5TYdoZ3HnLmmbAdLuMKZUBKMSipboPFBA
	95B3ZimWQXusmsno0DBe05CSuT+WEOWuZdJgh1WRHHkaXZhoqsevyCj4eGn00osQjxyfo6TPGv2
	l9RhWacS7EPFQ=
X-Google-Smtp-Source: AGHT+IHBwyvn37cMWft6XaLu78i521F3TitB1ZgZCjrLkgz/dWJXwkRq1mT1+qz6m/LgaTgF4rxTDQ==
X-Received: by 2002:a17:903:3d10:b0:2a0:a4b7:44af with SMTP id d9443c01a7336-2a0a4b74893mr49683665ad.26.1765798752075;
        Mon, 15 Dec 2025 03:39:12 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29ee9d36ddcsm132733715ad.32.2025.12.15.03.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 03:39:11 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 504F3444B392; Mon, 15 Dec 2025 18:39:05 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux AMDGPU <amd-gfx@lists.freedesktop.org>,
	Linux DRI Development <dri-devel@lists.freedesktop.org>,
	Linux Filesystems Development <linux-fsdevel@vger.kernel.org>,
	Linux Media <linux-media@vger.kernel.org>,
	linaro-mm-sig@lists.linaro.org,
	kasan-dev@googlegroups.com,
	Linux Virtualization <virtualization@lists.linux.dev>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Linux Network Bridge <bridge@lists.linux.dev>,
	Linux Networking <netdev@vger.kernel.org>
Cc: Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <siqueira@igalia.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Matthew Brost <matthew.brost@intel.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Philipp Stanner <phasta@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Taimur Hassan <Syed.Hassan@amd.com>,
	Wayne Lin <Wayne.Lin@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>,
	Dillon Varone <Dillon.Varone@amd.com>,
	George Shen <george.shen@amd.com>,
	Aric Cyr <aric.cyr@amd.com>,
	Cruise Hung <Cruise.Hung@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Sunil Khatri <sunil.khatri@amd.com>,
	Dominik Kaszewski <dominik.kaszewski@amd.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	David Hildenbrand <david@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Max Kellermann <max.kellermann@ionos.com>,
	"Nysal Jan K.A." <nysal@linux.ibm.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Alexey Skidanov <alexey.skidanov@intel.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Vitaly Wool <vitaly.wool@konsulko.se>,
	Harry Yoo <harry.yoo@oracle.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	NeilBrown <neil@brown.name>,
	Amir Goldstein <amir73il@gmail.com>,
	Jeff Layton <jlayton@kernel.org>,
	Ivan Lipski <ivan.lipski@amd.com>,
	Tao Zhou <tao.zhou1@amd.com>,
	YiPeng Chai <YiPeng.Chai@amd.com>,
	Hawking Zhang <Hawking.Zhang@amd.com>,
	Lyude Paul <lyude@redhat.com>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Luben Tuikov <luben.tuikov@amd.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Roopa Prabhu <roopa@cumulusnetworks.com>,
	Mao Zhu <zhumao001@208suo.com>,
	Shaomin Deng <dengshaomin@cdjrlc.com>,
	Charles Han <hanchunchao@inspur.com>,
	Jilin Yuan <yuanjilin@cdjrlc.com>,
	Swaraj Gaikwad <swarajgaikwad1925@gmail.com>,
	George Anthony Vernon <contact@gvernon.com>,
	Thomas Graf <tgraf@suug.ch>
Subject: [PATCH 03/14] textsearch: Describe @list member in ts_ops search
Date: Mon, 15 Dec 2025 18:38:51 +0700
Message-ID: <20251215113903.46555-4-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251215113903.46555-1-bagasdotme@gmail.com>
References: <20251215113903.46555-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=896; i=bagasdotme@gmail.com; h=from:subject; bh=1tOY86lhWOCbSHsqmK/tuDEilXGPwKXl/15tM3wSixs=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJn2n4Mqzx7cbGl2s1Xb5iYDm7bLkws+2881173X3pa/f UbeT2+PjlIWBjEuBlkxRZZJiXxNp3cZiVxoX+sIM4eVCWQIAxenAEzk0hqGfzoRZw50iXbWS+pV RRyxzVGfNT/eQV3w9+MclUw9PumMlYwMO5cdc7i131P/rrG85octa1tun66WP3rW6W/Ropnr7E6 G8AIA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Sphinx reports kernel-doc warning:

WARNING: ./include/linux/textsearch.h:49 struct member 'list' not described in 'ts_ops'

Describe @list member to fix it.

Cc: Thomas Graf <tgraf@suug.ch>
Cc: "David S. Miller" <davem@davemloft.net>
Fixes: 2de4ff7bd658c9 ("[LIB]: Textsearch infrastructure.")
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 include/linux/textsearch.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/textsearch.h b/include/linux/textsearch.h
index 6673e4d4ac2e1b..4933777404d618 100644
--- a/include/linux/textsearch.h
+++ b/include/linux/textsearch.h
@@ -35,6 +35,7 @@ struct ts_state
  * @get_pattern: return head of pattern
  * @get_pattern_len: return length of pattern
  * @owner: module reference to algorithm
+ * @list: list to search
  */
 struct ts_ops
 {
-- 
An old man doll... just what I always wanted! - Clara


