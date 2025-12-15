Return-Path: <netdev+bounces-244712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 48751CBD86C
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 12:39:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 382FC3009FC9
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 11:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAFEB330B16;
	Mon, 15 Dec 2025 11:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X097iqc6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C8132FA3B
	for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 11:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765798753; cv=none; b=mb+Oox1SNZuPKcQ32keOF6QPMfrpmYi+l+6c/78jDRo4+kk3zhxPtZh+vhKYWEd+Q0N1/pZhRVaNk88l+Y2WPcXabdyb6UR9LZZfJt1+wZs+Q4IA+IRlAbZZPB/DlW+6Kcg1AIPu6g9FGtcnZmyIVzTlUUz18PNfz4JT0pUEEjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765798753; c=relaxed/simple;
	bh=yvRLY8BHqBHKchvPjcPm3zDNVddYxArgXi7Qv6PDXBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y8O4X7MV4QAmukrPGFF/8SHQJV2YXtYPXhWibYbdvYXUSPsiMvRpClswAhb3gkUOMRgaLfDdOAmGOzAA9FaDXnAyq0XbewKmBtElMHuEbiv532c6+Trg208iEkG9p8pLrErGCe6Bfox5waEaV7r40hrKc1UCS+ffN1/wzZ++U7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X097iqc6; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-34c93e0269cso522479a91.1
        for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 03:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765798750; x=1766403550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SOExJIUd6SMMpu9ecZcijfoRnX+3TKAUcxRzAMDO5OU=;
        b=X097iqc6ySK3hl3ctMLq5B21Jy6lZmPamt8uRNw1Qf6IGHSuK9YEvzyywh/RKlb82P
         /S1iL6uJKZxZ3IVAK5w1eh3uP+KfjK0HfN28C6as/ARSZjVSR0f2zTTm+uOJRN5Xo/i3
         8+Rnn9wQLwebCHdpy9jS8HhhBBjEmWOJpFduIBUarw7MZnfXhzVMQwWCivnLCm2xd9DN
         G/KzK9iMnlZ3MO5+MlMUHQbM2LbownJl8uVmVm60zRQi3sbhajY6BYSvqPvC18Lzylrw
         88wuHGJXxQTakkzD+anZ0VBSaEaMzNwUbKR7woCKuAP6IgBuud8UR/2LeLCcGW0/2gC0
         Y8cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765798750; x=1766403550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SOExJIUd6SMMpu9ecZcijfoRnX+3TKAUcxRzAMDO5OU=;
        b=lska16toV73yAIyZCMTVJMXTtrFtU8431NmcDCa5Hv5doBh8QtJprhZGbeSt3vwll/
         JcKmLFBYnaXriDm6Atv056lFAAqrqYt/6VEZGZrx2wY+aq8Ff6tERJkREQbSiSqLVrRM
         29y5wiad4j+X9EeKjjTlTmgDwKBv0Q7uWWCRZlvCLWn19LREZk9QZZR0D52xUrho0QE+
         OxaWRjgDK6E4QMmladg5MU9hWnGWOuwl9FINGNcESNDPpObOBxhIqS0Na9+KVE30c6Wn
         dk2FcHkWhPO9j+7PKC9eHnmX41kcQbyCT8yIUpYuVNxXiw401kR+09xvVIzS94FcWyOD
         6bBg==
X-Forwarded-Encrypted: i=1; AJvYcCUpCklU6g9EN0IpAxLvp/Z6WGpXEGb9F1EntIrnWaMKDDaK+zUyBRkJAn1zFnItJ9jR7qC16JA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSvOajuys2M/RlNOaChzNdGmI0F1B6qt1SLCw3l8gTFKiBgO/U
	wSsLIE7aKqKTjkVj9mcCfUyO3n187ImGFgbC3JPt7xEx4sJplNYEiTVv
X-Gm-Gg: AY/fxX7RW3/rMvH+WIy1/ZkNxXejxIzxcvtlC5rshrHnQvssG3QiDUyyXWThYJ6IJIi
	GELv/PRx838voSoAYtpzXye2Qno0u4gROTiaQk1VEUgk8xVsh0+yFmYBK1fLd3EKwi8WyNDwtwS
	/TAPnFWnM743NPdDlVLEKqG4TE6fHhKkVDfOJ19qGATG/3iNym9N5Qmar+tZtmcNom/8U7T+WKA
	BTUYIih/ahDO12QUB7jbrxJap3bwCoTNy0hbp9APH5lIqju/jpLFF4XGdXixlgrRcSxBUV/BXUL
	u3ASoYgHfDNa59YSKEk2ZdU8L8W8bl8LVOWGpZJK++Z+kIEzEvZpHDFNG0s3LeTPxw9H7anigm1
	UbuL1j29yGRaLObEUjR5qToMU9/Di6/t27oBgY4pKJr1yePUOBN5QB3kEbAxWtQwhwoKvFNKQEu
	eRCIFY+v2tqmE8l/x4s9nzzQ==
X-Google-Smtp-Source: AGHT+IEi7Much+ynnSaGi+9pLWL2hRrocApHWp5vBqFK1ft2pjcvnQtgIu8VXEyupMREgh2/mG55NA==
X-Received: by 2002:a17:90b:2e03:b0:341:1a50:2ea9 with SMTP id 98e67ed59e1d1-34a926d9c70mr13163422a91.16.1765798749780;
        Mon, 15 Dec 2025 03:39:09 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34abe294a00sm9273005a91.12.2025.12.15.03.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 03:39:08 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id EAE05444B390; Mon, 15 Dec 2025 18:39:05 +0700 (WIB)
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
Subject: [PATCH 01/14] genalloc: Describe @start_addr parameter in genpool_algo_t
Date: Mon, 15 Dec 2025 18:38:49 +0700
Message-ID: <20251215113903.46555-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251215113903.46555-1-bagasdotme@gmail.com>
References: <20251215113903.46555-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=962; i=bagasdotme@gmail.com; h=from:subject; bh=yvRLY8BHqBHKchvPjcPm3zDNVddYxArgXi7Qv6PDXBI=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJn2n4MeLjlRVOvo/zL51uM7fT8nbubcy37qLGeos8/kb VKe75YIdJSyMIhxMciKKbJMSuRrOr3LSORC+1pHmDmsTCBDGLg4BWAiGosZ/mm4fru/UqLr5XIZ H96Qry1BDLd3LedR2Gkharj+Q1jej2pGhm7zlf21hfvmpVcxGBvN2yCmrfs71+wCw2eFqbVucQl NvAA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Sphinx reports kernel-doc warning:

WARNING: ./include/linux/genalloc.h:52 function parameter 'start_addr' not described in 'genpool_algo_t'

Describe @start_addr to fix it.

Fixes: 52fbf1134d4792 ("lib/genalloc.c: fix allocation of aligned buffer from non-aligned chunk")
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 include/linux/genalloc.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/genalloc.h b/include/linux/genalloc.h
index 0bd581003cd5df..0ee23ddd0acd3a 100644
--- a/include/linux/genalloc.h
+++ b/include/linux/genalloc.h
@@ -44,6 +44,7 @@ struct gen_pool;
  * @nr: The number of zeroed bits we're looking for
  * @data: optional additional data used by the callback
  * @pool: the pool being allocated from
+ * @start_addr: chunk start address
  */
 typedef unsigned long (*genpool_algo_t)(unsigned long *map,
 			unsigned long size,
-- 
An old man doll... just what I always wanted! - Clara


