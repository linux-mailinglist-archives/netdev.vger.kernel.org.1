Return-Path: <netdev+bounces-244723-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37300CBD983
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 12:48:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D62793009B5B
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 11:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567373358BD;
	Mon, 15 Dec 2025 11:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MAd6h6l4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56BB33557E
	for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 11:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765799322; cv=none; b=U9I0IetLtj7nUftAgxVtMvQPCTxdGWQsFhrN1K+wBTbLEdtjdhOw1MO27G6Dpq2ouFQVlA89m8OTaeH8MzO64bzmgDZJhZyxFeMZeppxxWx964+QH+NO0J4ntBOjQ1wYVm2vK/9Bm3SmuM9w9dwdl8eH8gKn+IiIjKkPWhpzPW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765799322; c=relaxed/simple;
	bh=kdwYayfiPuGdbX+6/rKZkI1jkonQkDY24KG3T7ZKuZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ab1egnTsgYS4Rxc2ohUJu5oruZTrQwT0Cs5V4zHbIj6UdNZ43j7G82Chb6jhH8qwSXU2VHv+PFYiVE59LUleYtQB7yJpRO//xQWEuLCyIq01VW5XWGwVPiOus5Az9Jpifp8nXza2LyJJL5Vi/bZ88qzcKVZXvCRtpzt2XSIMm3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MAd6h6l4; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2a07f8dd9cdso19640615ad.1
        for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 03:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765799320; x=1766404120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JUAs+7T6aM5YvKJFQXSXqoVkTtSxZtzq470O+YaXF94=;
        b=MAd6h6l4/YKSc10LnEFfm3OhEEbVLEKRuYqfPLONcXog2pLTf6OojvodUTKSpLiJCk
         hJm9lRC4I6IyLOPZy4uZz7WzMI9zvRoeGHTOvJdgXYWcY4SZPosskSgjiLKoHz7zUFh6
         bQhz1MNPYg1GHlpA+j8THPjt1R5oGeKktMBTQHBFR1q+a+mpKcSg902hA92IYeEqpenf
         KYyg3sXuv6N4qdzs2XOq7uXib2ucnunNa8MyP9z7TODJagWiisdYEhT3inIPSTtsAF6l
         n3MkoL0gMOOGDYLeqch/50JvIBVgu3YXwwjQUWzGsq6kdI+nrFMWHijpbp8gMrB082St
         p92g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765799320; x=1766404120;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JUAs+7T6aM5YvKJFQXSXqoVkTtSxZtzq470O+YaXF94=;
        b=HYyoAGUPgJZ47WNa24TpP1C3hIN1QR2xBT0jdBu359FzMk0Ik+HnP8deKjipCVyD5Z
         zl2Hd8JpgqSupWuyUpf6rwSf4xiXCgtd6NcPrG8FRECw9hhWKoYklN9M34fEkaYVktvg
         CEc8p8WO+BWptlTv/b6N/7ZVYQ1PZhQRuBRT05R68VufhRBavZYExSJZSZ/4ZuBGwTug
         sumFeJK2LGeTc3FsMPhH1cfukf6TkD8e3uRzD+HVFYKcDQlRFT20TazVV58Lpbljeh5A
         zTmnwIMf//YqzmG0R8ok3DZOgb66Qf+wimXPb9NTGyuaUwx5AIIxBkwjqOuRv9kftvDA
         WOsg==
X-Forwarded-Encrypted: i=1; AJvYcCU8p2X6npgl1jHmYVclTlAfTaxdO5QII+kmyao6kcbA1i1jDUQpwU2TB4abLXh3AsD6e0XGUuw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQrs4amPTR51EHDOt2VQgIx1AT+dmCVFoI0j1Aymwwo2BD+lo3
	Jajw6ugdGexnQtrH+zlJh3FfEbF0SFizIrsyGFrVLHpy1kpLxK8mb87G
X-Gm-Gg: AY/fxX6GLz9ZADJFVKYreXtvQCXVsjzcyUEYpRXW2M2+A94OpNUof9mHrnG4xuEyXZ6
	m0jfvid33+E6idgKvRSNK8GkXTQFaa0vXEVGh9gY5FHgq30gwV28tDEWgGv4qrP8z4dBh6UAVNO
	oPDTPGU4yTpZ4GQWa2TUyM1DXjHp1EMeaQsBFVOlYFAz+hyPK/19D35GfFh2WvgU5LQIHSKziLO
	gY9cYwZeJHKRVYyU5y5jHgkW86J25VN+vlm77yEZ0uYHjp1nM1qiTjNIOZ34U0v7lZ770CzJP4F
	Y7d+n7gz7AHSiLWHCh4kPPmuM/WzCT0C6CuyISuZ/B3mo2P2l8gbu83ridYNaySquIxO1uBNkmZ
	KbvzGPGgMnKBR6ljNrEGI9aqhaJrKtZ/VgO4RYZE8pSW2OXUkEPAikV8kPTA4vWoawYSv9jRkJJ
	J3vIGk357vpLE=
X-Google-Smtp-Source: AGHT+IEA4ldqjntSU1IZe10aX19mQKLjoCVDqCMnCNeqo44SOanRLtLHyqhQX8MxC8RVHbAWKM2xrg==
X-Received: by 2002:a17:903:1a2e:b0:2a0:b02b:2105 with SMTP id d9443c01a7336-2a0b02b228amr63659225ad.56.1765799319837;
        Mon, 15 Dec 2025 03:48:39 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a0867ebe9dsm77190525ad.40.2025.12.15.03.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 03:48:39 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 46E2D447330A; Mon, 15 Dec 2025 18:39:06 +0700 (WIB)
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
Subject: [PATCH 12/14] drm/scheduler: Describe @result in drm_sched_job_done()
Date: Mon, 15 Dec 2025 18:39:00 +0700
Message-ID: <20251215113903.46555-13-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251215113903.46555-1-bagasdotme@gmail.com>
References: <20251215113903.46555-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=982; i=bagasdotme@gmail.com; h=from:subject; bh=kdwYayfiPuGdbX+6/rKZkI1jkonQkDY24KG3T7ZKuZA=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJn2n4Pfzvv2aMJ6/2fiW3RmVPTpTFSM/fBW4Nu0ikdP3 J/+EMyq6ShlYRDjYpAVU2SZlMjXdHqXkciF9rWOMHNYmUCGMHBxCsBENP8y/FN2WnBW9dYhDc+y QzUe+4R7v/wRO/L/c0NDkJC4klf71CqG3yyrLnq/ur5px+nadXME75rW9sxVOp7eMOmL58xwZZ6 TlnwA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Sphinx reports kernel-doc warning:

WARNING: ./drivers/gpu/drm/scheduler/sched_main.c:367 function parameter 'result' not described in 'drm_sched_job_done'

Describe @result parameter to fix it.

Fixes: 539f9ee4b52a8b ("drm/scheduler: properly forward fence errors")
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 drivers/gpu/drm/scheduler/sched_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 1d4f1b822e7b76..4f844087fd48eb 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -361,6 +361,7 @@ static void drm_sched_run_free_queue(struct drm_gpu_scheduler *sched)
 /**
  * drm_sched_job_done - complete a job
  * @s_job: pointer to the job which is done
+ * @result: job result
  *
  * Finish the job's fence and resubmit the work items.
  */
-- 
An old man doll... just what I always wanted! - Clara


