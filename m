Return-Path: <netdev+bounces-244718-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC5ACBD953
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 12:46:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A38403061A5C
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 11:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2522E3328E4;
	Mon, 15 Dec 2025 11:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="amKR7JsN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B958333122C
	for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 11:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765798760; cv=none; b=enJiIWH5JPEJuajtJ5w+yaNcD8nRY7fGnO4+1gtZBDZkNA6olw6LVXBMxyKfe4oNAaNp0J9SECx2QU3Mt+tb7z+fywJsGBzHVIymKgj3otN2W8D1ZiYF0kcMh9luaQDqmL1CdcYow1rWePtcJbWkUCuGBSGUMKAvJwyBlXOeKgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765798760; c=relaxed/simple;
	bh=bVwk3E00Ao0/BsL4XlONNDCfpFF0qzpzGvJu4GqJ/kY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oL8Xi70XqIQYbt7mJhNZzyuLUSkcbvqOaNz1b7V9XLyrGxrOL4k67c9bUQ+bHKMZuQ3QxrOjtUHcByW9PyVjzr5GqFkgem9Jp7WPjos8wDCHCDB5hw11FRK2fXhju9lvTG8x3DEchzKnyOhvmLxmvOhDdnOHkQzqI/XEs6xGvqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=amKR7JsN; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-34c1d98ba11so2665509a91.3
        for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 03:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765798756; x=1766403556; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9thXFyBI9wECeAoZwvjVxFD8Ol9j6G4X/I1qZGpsX1M=;
        b=amKR7JsNW/OlGqjwVvJKVpPH5D9UwZJBut96t2CI1nfWa8ulByQB4Nw4BT2+1E1zBk
         Dwh5hYPmfbvSAI3cP4Tyf3x3gOXDrFMxHlgsDRP4FIhnR+94V0wDWR5WZGvaeXycPfPV
         GjqHr9pjAjtLsVaXucSt8IV+WgNJJT3NJe1/j/ajTs4nA0xgJPtOSXC2fKLO2vKoJv3J
         yDDwIa25NNWGaVFnoQNIZN9RnURsBd+eNlQiLk76rtVahrSyCdaXDUI1Gir0ch1I7oC3
         E39czRgaYHT+B6L2iv4n2lcsrNyAovpEIeWMkQkBTL9/mHxuJh6LhW8YXeJ//HxbUjOw
         AUBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765798756; x=1766403556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9thXFyBI9wECeAoZwvjVxFD8Ol9j6G4X/I1qZGpsX1M=;
        b=G0JG3wCkL46Z4uFmGhFtyop2UajpXfNhw9YH9plDuFNCtTrpydLrUJZlCpnqGJJiQ6
         11fbsA5/Barofi4F4SYM+n43dNkqCkxF99+E/LfkP1AhoDdcNCpspIScR/jICWXGDzzE
         CITLgai0KjmxDxK4K2aWpuaAzw6NpmypgT0ynb9chp1pRqN9aVadrfyrpjLytQ3N9XsL
         KC/da57c8aO70VgH9u8hcuzGzv6hWXogH+pQy/ZPvl1BtN1kU8etvHim+I2ohA2+vQj7
         D539hoDjuZaG5lYiW9e409VQ8bIEWZtyExR82bFIO7rLx7DhaTxCSOkKsbSb+pVlHrHk
         SFHA==
X-Forwarded-Encrypted: i=1; AJvYcCUGHQvkzgmQIOQdImyGYV8mKNGRrZwvtTM0/2Ga5atj5VkQr+o46whf5IYDghOQfVfyaxTsA5k=@vger.kernel.org
X-Gm-Message-State: AOJu0YylcuihW2NmIkuCB0ieQ2575Fx+VrpaLuvDQjW+lr0fH0Xf9ihU
	/2YNEus8S7/KHHRZcVsgfkJiINqaoHGVNtGS6ORMHA4lgi6WXs5PFKc0
X-Gm-Gg: AY/fxX4UNHEWh7ciZPW7ss7zUtGC3M6F4aFcoIv0ZIPsCAvYDPBZbWyigKLFFbb9R4Y
	VSqfK+cEch+kNlPTnUhRGE8KDKYExwW4uCBhGoZqLeYx7acOJ+uB8QSeYooriXwS+LeA4HI9bRR
	o60ZKqDn/pFMzfI1uLNSO5FTuNU6gIkOnhUyYMvkSFwE8nl1o7XENpIuex0NuGZYcXOtn406m2x
	DiZ54XKlrCyaFnybeqHrSfIdSJgy+2vLQr3YnlCFlvUWuA/5jWBFoTv8gq87E0wnnYnqXSDLwaz
	fmimKaz4SA+aTJO2MNaIPGA+nAX0Kgl756qZVrB2umtoN7HOVWVzkXJrNiYHGULVjB+8zrxm9IR
	QycvCm9kO/HTJu4ynBKJywI7vnn6ZUKpIxs1/QK0zioGMG8EVgN+tZ4BI/IZv4DMB+kL2dRofGV
	zBycIJQBWjFJE=
X-Google-Smtp-Source: AGHT+IE3LQMlInYBtZW6kVYJLJE4CFzfJfm+/f5olU3OmDWyxxykzQlHP1rsXKl8Sxl863J3gFT+2A==
X-Received: by 2002:a17:90b:4b47:b0:33b:8ac4:1ac4 with SMTP id 98e67ed59e1d1-34abd78051dmr11974090a91.35.1765798755860;
        Mon, 15 Dec 2025 03:39:15 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34abe294892sm8918293a91.10.2025.12.15.03.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 03:39:12 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 9EFFF444B395; Mon, 15 Dec 2025 18:39:06 +0700 (WIB)
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
Subject: [PATCH 06/14] virtio: Describe @map and @vmap members in virtio_device struct
Date: Mon, 15 Dec 2025 18:38:54 +0700
Message-ID: <20251215113903.46555-7-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251215113903.46555-1-bagasdotme@gmail.com>
References: <20251215113903.46555-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1385; i=bagasdotme@gmail.com; h=from:subject; bh=bVwk3E00Ao0/BsL4XlONNDCfpFF0qzpzGvJu4GqJ/kY=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJn2n4N3qByLSAtcbrWEYbHxfzPeVTVyK4Naco81fnbf9 sGw4M+ujlIWBjEuBlkxRZZJiXxNp3cZiVxoX+sIM4eVCWQIAxenAEwk4Ckjw37unJpIS7sDggaL LUJm/L7quGjlN51XE6JFNZoPynqvOsvIsMhqy5y4fbtebC8768S8lM/yytfC9QdFWExtD//Srpa 6yQYA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Sphinx reports kernel-doc warnings:

WARNING: ./include/linux/virtio.h:181 struct member 'map' not described in 'virtio_device'
WARNING: ./include/linux/virtio.h:181 struct member 'vmap' not described in 'virtio_device'

Describe these members.

Fixes: bee8c7c24b7373 ("virtio: introduce map ops in virtio core")
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 include/linux/virtio.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 132a474e59140a..68ead8fda9c921 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -150,11 +150,13 @@ struct virtio_admin_cmd {
  * @id: the device type identification (used to match it with a driver).
  * @config: the configuration ops for this device.
  * @vringh_config: configuration ops for host vrings.
+ * @map: configuration ops for device's mapping buffer
  * @vqs: the list of virtqueues for this device.
  * @features: the 64 lower features supported by both driver and device.
  * @features_array: the full features space supported by both driver and
  *		    device.
  * @priv: private pointer for the driver's use.
+ * @vmap: device virtual map
  * @debugfs_dir: debugfs directory entry.
  * @debugfs_filter_features: features to be filtered set by debugfs.
  */
-- 
An old man doll... just what I always wanted! - Clara


