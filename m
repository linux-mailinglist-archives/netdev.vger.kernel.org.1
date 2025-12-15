Return-Path: <netdev+bounces-244715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D62DCBD8FF
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 12:41:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F2C4C302C4EA
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 11:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112D7331213;
	Mon, 15 Dec 2025 11:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dvrDFpz5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D7A330B11
	for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 11:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765798755; cv=none; b=VeJWn3lOqTfyufwjSiQTLnJa7QqArZyGUSkgaIkUAfPQwbfsqx3FB2tbPhpWBepEQ0JbOhKc+77wS5SwRwi++23OFzLLnLoIv89rDKpkROxcnmuA/BwJlImytbibrVhisdKoDFFweeYju0xng0t8PKjemn7yp4pykTLH1pzQb0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765798755; c=relaxed/simple;
	bh=mcnZ1soLgF/JTT1YuxC/XOQhVy9SZYDoshinxHejwDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uWmpeFOkjN27ha1Mq1QR4n3U7/fyIhSW+QylccWVIbwjRw7jpZfT47p48fQG0rbEew30DZVNXRfPBxcL3cvje+GUO5VC8Z8GdOB0/9XXfGTK6zgpdwBmHBHeQSELpXIplnAbu81laPlTPr6NSoILPXiVYOcP+Wdz3twyn+laqhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dvrDFpz5; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7b7828bf7bcso3579468b3a.2
        for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 03:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765798753; x=1766403553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lORwJoeOdmqWvp6Gaq9g1tKkad6KEP5mAC3mejLEu6E=;
        b=dvrDFpz59wUBAQj8mWk3dRETxpnBYFVsfn1kb2lz+IM9uRySwAiZd3SIwFvwBX5gEW
         jqUrf9C94sp6be2ivLljvjYd3OGkbYZBMKK0ebKge94fbdIVk+nWAEHGdTC/RaAF7KED
         kzbvDSqJMnjGmSuBWxyeokl21bELVCdKyfXYC/8hRsBBftYXaETMa7WSku6MIUCriAL6
         Hm/AI+wsn1WNk8maXf515OzgdeS9Xmuc4WM/xTSlVeK2VCCaMI/YTZof5ENPVWjh9eTo
         GF2n2QaFq/Q40woBy95lVKLwE0TjSYJtdXJtDUYKVkZmLUvSshxKR6/cnO2jcvONw5tq
         K0jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765798753; x=1766403553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lORwJoeOdmqWvp6Gaq9g1tKkad6KEP5mAC3mejLEu6E=;
        b=hy9VumqR0grHpZwMTFX0+XK4D0VO050MlqCjPmHuMsSbNso5c1pQxY36SkUZ72GNIB
         6lGEb3UXVooD2nFlk7WP7G8Fn+yu2C4r9mILxREoyXJ0wZ2HcmxRsoYQYMR4HIlFzkWB
         Oq5e1suTRQVa6bJ9dpK6hFbzfeiAaakwoL6z6dI/xV5/hKoKYTXLvpUHw/fzstK1E1lI
         EwlT3a5MfSE9Vasc7AAgNloKu2GttU/+UlHheLeBKumNMCpvBOZrQU6eGckBA8CjJ+97
         f1hYElnCUkJVBs6NlXGZ0tlMW5zKrU7HX/BoxUEsusBiODOF/fm7xMbOUm+OVWedIZXa
         rR6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUaVgQ1h0V7lLPT+0PXQo5ukfHHxfG2slqkXCLb0d4Vb7d8KNG74lz18WiYNsE/HW7XpHwQIpU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLU+TB7YVSzNwoNahS7dVaJgn+9ckxPacjGDIu5wgQwPf+b5rr
	H93uvFBePgedfqvoEbz/APA+cmU5L5evMIr37W/fswBr3GP5BrLMUZEy
X-Gm-Gg: AY/fxX6Ymi63RXURwVMrH5nIZbKW/UFFrWgEI4/8KHpRRXfRCPqw5GhNOF3R1pmXtIu
	MMKKhaOioJLSXxpq0SLBO8gme9+JlxafLlKNfhzUbtVpjHZt3saGAy7jiTvM6GhgkeSXAeBT6sS
	eo6wvGhd9tBdEcXtAnzcDof3jv/GAv378lKvK/Ekr2S+tJLsnTYVXNccTn8VWJoL32XZP3PU2H0
	PPexRMHsyDobyi/8c4B/z0uVQoPkWockDtnCoSSLE/mVwe0ScgfcdbUffgZ6SEwTu9eNgYndjgV
	qGGceBN4LqdnQ0a/qCCdMXHD4P6cuIfgzpyRoNvfiTCCOn2ZE6kxPdSCmilEMXuFtcqIngfgi4H
	p3PMBZR+SXrqnPybZ/ADY5gob4LjaebHhP2N/kaQqAku7QJmaG0SFsNhMfU5vRwt1AFTX+sHvn5
	6HNX3rAksutv0=
X-Google-Smtp-Source: AGHT+IH43ZxDlO+sXZpKsRY9ws0CLb4ZSMlMGi8iin8W4Uc9EL2/AE6hhR6bEKC++ztievLapVcsEA==
X-Received: by 2002:a05:6a20:6a28:b0:364:387:8f4e with SMTP id adf61e73a8af0-369ae490337mr10620715637.34.1765798752795;
        Mon, 15 Dec 2025 03:39:12 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c0c2ae4e3casm12755809a12.21.2025.12.15.03.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 03:39:12 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 811FA444B394; Mon, 15 Dec 2025 18:39:06 +0700 (WIB)
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
Subject: [PATCH 05/14] mm, kfence: Describe @slab parameter in __kfence_obj_info()
Date: Mon, 15 Dec 2025 18:38:53 +0700
Message-ID: <20251215113903.46555-6-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251215113903.46555-1-bagasdotme@gmail.com>
References: <20251215113903.46555-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=849; i=bagasdotme@gmail.com; h=from:subject; bh=mcnZ1soLgF/JTT1YuxC/XOQhVy9SZYDoshinxHejwDU=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJn2n4P0Tdf6vI2dt8iwUrrPLU6ToytxCmtRXso3wY/50 fGG9Ws6SlkYxLgYZMUUWSYl8jWd3mUkcqF9rSPMHFYmkCEMXJwCMBHZKwz/nVbIB4ee2zunpOHQ vBz35Ga7xwYL3V6/ES+tt/jmsMTsOCPDXNsiGd24sMjVrB9Z5rD2NZvPm8/+bp/rS8/i2IdH8rc yAgA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Sphinx reports kernel-doc warning:

WARNING: ./include/linux/kfence.h:220 function parameter 'slab' not described in '__kfence_obj_info'

Fix it by describing @slab parameter.

Fixes: 2dfe63e61cc31e ("mm, kfence: support kmem_dump_obj() for KFENCE objects")
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 include/linux/kfence.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/kfence.h b/include/linux/kfence.h
index 0ad1ddbb8b996a..e5822f6e7f2794 100644
--- a/include/linux/kfence.h
+++ b/include/linux/kfence.h
@@ -211,6 +211,7 @@ struct kmem_obj_info;
  * __kfence_obj_info() - fill kmem_obj_info struct
  * @kpp: kmem_obj_info to be filled
  * @object: the object
+ * @slab: the slab
  *
  * Return:
  * * false - not a KFENCE object
-- 
An old man doll... just what I always wanted! - Clara


