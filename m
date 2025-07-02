Return-Path: <netdev+bounces-203168-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6F6AF0AAE
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 07:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91D8B17C64C
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 05:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E9A72637;
	Wed,  2 Jul 2025 05:24:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (l-sdnproxy.icoremail.net [20.188.111.126])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F18A10F2;
	Wed,  2 Jul 2025 05:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=20.188.111.126
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751433895; cv=none; b=FC8Utfvm9BQuGxO1M0QJlrZuly7oumIwf0tnD+/S5A26GNgoGshu72nIL/0zF65VmjMRy4cICetZwdbsMaH3hT1Rpz8hJTsMuUIFVrnPgT8ZPG6X31wGd/1WPETYsWG4/906D7RKSrsq6zm2ntHQdoLkbyVImaMDof8RcshGIPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751433895; c=relaxed/simple;
	bh=lv8cewQCgzixt5VgJBiBFjJgHw9OMLzI1aEuGxmzV7k=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=Ryj7lQlW9Dbd0h1Zn6eGSQlnU8YY/rYAhqI4zUjqP0vkLaBnjV3KVXydoUjID01e10v4F6FWOWvceGiqZ6614eP+uRoXCUoEZOfLIGTvoYxNrJ/Ncc0oQ7SDcKQnUzJrm4j8b6NqXFFIQgV90ctHS2KK0h8o/XlQT3n4UYVEFu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=20.188.111.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [115.197.243.13])
	by mtasvr (Coremail) with SMTP id _____wB3JDqOwmRoSorRAw--.1372S3;
	Wed, 02 Jul 2025 13:24:31 +0800 (CST)
Received: from localhost (unknown [115.197.243.13])
	by mail-app1 (Coremail) with SMTP id yy_KCgCH2GONwmRoLVFUAA--.52319S2;
	Wed, 02 Jul 2025 13:24:30 +0800 (CST)
From: Lin Ma <linma@zju.edu.cn>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linma@zju.edu.cn,
	mingo@kernel.org,
	tglx@linutronix.de,
	pwn9uin@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm: sanitize ttm_device_funcs.evict_flags/move casting
Date: Wed,  2 Jul 2025 13:24:21 +0800
Message-Id: <20250702052421.80423-1-linma@zju.edu.cn>
X-Mailer: git-send-email 2.39.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:yy_KCgCH2GONwmRoLVFUAA--.52319S2
X-CM-SenderInfo: qtrwiiyqvtljo62m3hxhgxhubq/
X-CM-DELIVERINFO: =?B?5EqoYQXKKxbFmtjJiESix3B1w3tPqcowV1L23Bze5QtIr9Db75bEBiiEybVhThS0pI
	APHpkT0S87xKjFuOcc67InCDD3v9V3Anj4iC7G9ZqY7PGAVCKnxWeso1VfHbRg8HTfH2jO
	EoJwzi3UeBu6yLCm71+VKUjJTMQVRzgKF9lnMIMw
X-Coremail-Antispam: 1Uk129KBj93XoW7uFyfZFy5XF1DJr4rGw1xJFc_yoW8Ar43pF
	47Cry7ZrWUKa12qr1Iqa18ZFy3Aan2qFW8W3Wqv34S9F1YyF1DXrW5Jry5JrW5JFnrJryf
	trnFy3sIv3W5AacCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Eb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAF
	wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0Y48IcxkI7V
	AKI48G6xCjnVAKz4kxM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI7VAKI48JMxC2
	0s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI
	0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE
	14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20x
	vaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8
	JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU801v3UUUUU==

Our analysis revealed that most handlers in ttm_device_funcs perform
type checks before invoking container_of on ttm_buffer_object.

For instance, commit d03d858970a1 ("drm/radeon/kms: Check if bo we got
from ttm are radeon object or not") introduced an object type check (
based on the comparison with destroy function).

This commit adds the missing type checks in the nouveau_bo_evict_flags
and bo_driver_move handlers.

Signed-off-by: Lin Ma <linma@zju.edu.cn>
---
 drivers/gpu/drm/drm_gem_vram_helper.c | 3 +++
 drivers/gpu/drm/nouveau/nouveau_bo.c  | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/drm_gem_vram_helper.c b/drivers/gpu/drm/drm_gem_vram_helper.c
index 22b1fe9c03b8..40d1b584327e 100644
--- a/drivers/gpu/drm/drm_gem_vram_helper.c
+++ b/drivers/gpu/drm/drm_gem_vram_helper.c
@@ -855,6 +855,9 @@ static int bo_driver_move(struct ttm_buffer_object *bo,
 		return 0;
 	}
 
+	if (!drm_is_gem_vram(bo))
+		return -EINVAL;
+
 	gbo = drm_gem_vram_of_bo(bo);
 
 	return drm_gem_vram_bo_driver_move(gbo, evict, ctx, new_mem);
diff --git a/drivers/gpu/drm/nouveau/nouveau_bo.c b/drivers/gpu/drm/nouveau/nouveau_bo.c
index b96f0555ca14..81a66246d547 100644
--- a/drivers/gpu/drm/nouveau/nouveau_bo.c
+++ b/drivers/gpu/drm/nouveau/nouveau_bo.c
@@ -887,6 +887,9 @@ nouveau_bo_evict_flags(struct ttm_buffer_object *bo, struct ttm_placement *pl)
 {
 	struct nouveau_bo *nvbo = nouveau_bo(bo);
 
+	if (bo->destroy != nouveau_bo_del_ttm)
+		return;
+
 	switch (bo->resource->mem_type) {
 	case TTM_PL_VRAM:
 		nouveau_bo_placement_set(nvbo, NOUVEAU_GEM_DOMAIN_GART,
-- 
2.17.1


