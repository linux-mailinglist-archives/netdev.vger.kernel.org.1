Return-Path: <netdev+bounces-244713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 79937CBD8B4
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 12:39:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E8ED3018F63
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 11:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50677330B25;
	Mon, 15 Dec 2025 11:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ISA5KO6K"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C966330330
	for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 11:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765798754; cv=none; b=T955YPer6MbBH3vcuqL7d0qbN+zENJIablXs82NLPHLYai5d0A4or+ln6oHadmsi+j1fSsnaU/YNloc2cWpqGowjzp8WUC4HZNCLkv/LkMaU+HSgBv+eQQ43mHPiynKWpai/5sm/XsVd1YDy5AjwemHHHdefza3Ur4R0F15Y6vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765798754; c=relaxed/simple;
	bh=zaXx2zRxHwtjfsFTgY05kdIMv0UeQBx9b1FFiByYYYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aW8WGdES+k3mxSb1ONxIsezb/9UdF61vQQ2eqthVTZVrsS9J1GGuqNk0/Ksx9GqwNEBxxHgrtqMvb7A5qIXAZ990W3wfxwKNCEiDj+Qnggb2JyxIvJSziwofBpgNabBajFz5QkC0e/CrFie1pvBWmZURF+dRnojhNpSWe1NX4ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ISA5KO6K; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7f89d0b37f0so404916b3a.0
        for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 03:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765798751; x=1766403551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H6vVzDCLpyU2LgSSSdcXlxGJ4GVOIz+XeeVoTvfPkdk=;
        b=ISA5KO6Ky18dJIhYxEWZTy4YEyBxlG7RMCSjj/yV6K9mwAi+9QtMnhD8G1YfK9J9U1
         EigGsgvsUr5iS2uJOasrZvfdN2xHxtMxxyEos7Vs4fpCHVmggyQsc4q0I6IE6C6p5iUi
         KH0JKj+l7/Gf/dQ9Cgp56RVKo7zqLqMgEo7P82XwgRWDd2QWfA3bzXBeiedVb5+IHZ2R
         pMLfm7x7Ie/VWmkld0y7DtMrPhM+6uwoGIHtu5sEpkhuwCOuOSYfxdL39ugHk2dAqLf0
         tZWsMAyiaQlGEKh+MrUARyM2qlRh13y5MXrz8Opwzt/FXpuQAHvDSIaZ7tIRjmPpqaQQ
         IFLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765798751; x=1766403551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H6vVzDCLpyU2LgSSSdcXlxGJ4GVOIz+XeeVoTvfPkdk=;
        b=A1TaPg7CIaJe0o/yTViuZAe5X/bsDduBDbZ6lFoMOnfUv1QEUo95Ss/PQ/GaEs+pUX
         D8zhwL/ltwHa0tIaIGN5WLsLXQxwndfHy5CWqgY3u5RPEGaFjTAS3ZNJqU8rBAuAexv8
         X3uU3pOZE7yfZxkRBjTWmfgCoICUr8Bb+YPgsuW/Y33JSmhfgxBuzqVBuZdHlK+iQsSX
         qsZxPnPB4bHfDOJQkF+MWet5UDLm9HgeqGt/dwPquNi06tU6GjTFrKo1y18FxGGKThqZ
         4g6LkPgOOxH9dGQ4DvPfgpcD/FB3Dl5rSHMgx0V4QP/ildMgLFkIafJHZaqwrBmy9FlJ
         sfpA==
X-Forwarded-Encrypted: i=1; AJvYcCVv02byWN2J2/pJCbLZqdkwG4cdi5dB2Ycr/x4dlk0e5vfAymrhqDq3QIw55QlI3BTSq4TRxxY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV5DZzIgBoIJNP+hJP8WKtaVt9Hw4sQaX+Q5BdMvOJpnx78QDn
	eea21Oza76cc9pFZR4nlcFAwZrGXyiuF3yB+vGRaNli/3/2LHdg/Jr9b
X-Gm-Gg: AY/fxX5dxRm/FsVo+Y/6mVeQIihX1QoFMW/4tUM8J+NVCokSDzskX5sXmfNAiF+7DC3
	yK37h8BtJm+XWy7B60c4cgTw9pfi0ByJgThT8QOJOHbQX5/ZAbjW3qMGmH3RSJEIwnngVw45G6Y
	FWK1eCtXFrFcBhudky4lXIlJd/IdtMMBUCWKNS3iFLtc3zZmkWtMisCBrE2J8jI56fyhiGDknaV
	eqkIEO4HVzrfS2DGmUOHy4Ccd7WgnoRZjSzJQEw0r4RD73Czl+aXNDWOYJga2qAlaq2VEDhN9US
	scgrPDhjL68Qgdl4oV3tsU0NEWjyo2R3L8Xt7mg4AYO+cQ0l5TiUJtJWCuI+Y/DYN2AglKi1xRq
	a30ne6h9Nras2xil8LMSfw74nHUf9tYrTN9AYo3gRuz9eqfWbD8j/YBMTYe/u6/ARWiHwDcpDfj
	Wg54YP6QdF4eM=
X-Google-Smtp-Source: AGHT+IFlU3I+cKXX8C9kVGFzGiJyAz7/LTk2+tkj0Oiyk+q1A92AqVW93jQniiO/3heM3uCR/CKzzA==
X-Received: by 2002:a05:6a20:728e:b0:366:14b0:4b16 with SMTP id adf61e73a8af0-369aa740ecamr11005465637.33.1765798751132;
        Mon, 15 Dec 2025 03:39:11 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29ee9b3850csm133388085ad.17.2025.12.15.03.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 03:39:10 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 1D26D444B391; Mon, 15 Dec 2025 18:39:05 +0700 (WIB)
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
	George Anthony Vernon <contact@gvernon.com>
Subject: [PATCH 02/14] mm: Describe @flags parameter in memalloc_flags_save()
Date: Mon, 15 Dec 2025 18:38:50 +0700
Message-ID: <20251215113903.46555-3-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251215113903.46555-1-bagasdotme@gmail.com>
References: <20251215113903.46555-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=950; i=bagasdotme@gmail.com; h=from:subject; bh=zaXx2zRxHwtjfsFTgY05kdIMv0UeQBx9b1FFiByYYYk=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJn2n4N0b+unPg8UXJx6+/+iP9I7pV1rdBYrPMm9NqGYl enCm2OnOkpZGMS4GGTFFFkmJfI1nd5lJHKhfa0jzBxWJpAhDFycAjCR246MDN8qzkf5GvF8u6h8 fK78A+u9Z2vjTS5MNJ2mcnT+/S07J0sxMvTNsLugLdEgeebaKl/Lt7ZFnv2pX8UvGPzINA+RNZw /gQsA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Sphinx reports kernel-doc warning:

WARNING: ./include/linux/sched/mm.h:332 function parameter 'flags' not described in 'memalloc_flags_save'

Describe @flags to fix it.

Fixes: 3f6d5e6a468d02 ("mm: introduce memalloc_flags_{save,restore}")
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 include/linux/sched/mm.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index 0e1d73955fa511..95d0040df58413 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -325,6 +325,7 @@ static inline void might_alloc(gfp_t gfp_mask)
 
 /**
  * memalloc_flags_save - Add a PF_* flag to current->flags, save old value
+ * @flags: Flags to add.
  *
  * This allows PF_* flags to be conveniently added, irrespective of current
  * value, and then the old version restored with memalloc_flags_restore().
-- 
An old man doll... just what I always wanted! - Clara


