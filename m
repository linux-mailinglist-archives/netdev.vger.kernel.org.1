Return-Path: <netdev+bounces-83551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 887AE893003
	for <lists+netdev@lfdr.de>; Sun, 31 Mar 2024 10:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABCD71C20C05
	for <lists+netdev@lfdr.de>; Sun, 31 Mar 2024 08:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4608213441E;
	Sun, 31 Mar 2024 08:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YNZs60sx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E6813341A
	for <netdev@vger.kernel.org>; Sun, 31 Mar 2024 08:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711874709; cv=none; b=TgXzra+6TSTcRuY91K8mqXwSS5OJzISdH7G2WnKEWV/CGty1DriWTMzr5PhBQXS2pwjCVnheBDOoGOdDK0eq0EWWimu/6b3S4m1mOij/WAEUQX/J54fMyvgYCuMPT7JPmzTU7TC+75XwN4/aCVzNaC9yr/3fwICYF5RxHkfvv/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711874709; c=relaxed/simple;
	bh=rFl/6jLaFbtBJ+88FvM913PJ4x0vjfjJ4PxyPcL+Huc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Txhj2tGTV4QKG7f8mHveS87D1lEPg1aJ/kG+5IJjutYErJoiVBk600E3MNQ1eOmaxGgDww4tQmNz0VURx6hMzyEVK2byF7kgVQ5JJB9oy1OeDLKJaUEaBFKBoVLCFbduLARTmQr+sIs+Ac1syitl52Tt5RXLVPajh/LtodVk2KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YNZs60sx; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-343496f8b80so229699f8f.0
        for <netdev@vger.kernel.org>; Sun, 31 Mar 2024 01:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711874705; x=1712479505; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IvtYxn/jBnHDfTZoo9tjjvjwD5frxuJyBUKvJwnL+3s=;
        b=YNZs60sxjS22JN2O7I1e6l4LQcs9rG5hyEwjPdBHiROAQvdiPYBUL76DtenYD3vhRR
         bwIZBD7+KvgIalm0dNt6FGUPS4pDd1Qse4EPor9ap68qx5CN9AhozmiMSDw2FMrLpbeG
         gKnGgUlSwBkBv8EtiS88SnksbuItXCVK6Bk6elij6s+zLocTP1RxVxIlkkj113wvDSvx
         +vUyZMnmqkoG8IdeC+dEWjQ24jRmHubDrnb0w19yuBp0Tbt4PGlo//Ixr+rjhnaZ33TE
         kJG9kl4H+agIYnkhwmXi7TWeqJsUizYoDHcDJeDI0wqBfkCXu6WFwBRcmOrdKMmfS4H2
         nRLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711874705; x=1712479505;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IvtYxn/jBnHDfTZoo9tjjvjwD5frxuJyBUKvJwnL+3s=;
        b=PGHle6YB49/Uq+9UF+L9/TAQ8y980xFxmXFrpSHG92AysnFDJjFKVKChMb8iUQXX0l
         WCgmJvDD0xCuGXRqQSDns0thW/cvM2bVhLkqxlcABb7BPgJR4iMcpuQl3ViQehd/RxWI
         dKPfmmiMrJUs1xaAbsKSRBZooBZJEqVoVq4JwkqErQ1ih75uggYz+RkdBH9UfXxNtpjI
         28kMNwNVt3zsBueNuAKK06Eex2Yy7phf14TFXpuzJW2J9mgRmdIvizoa9K0CqlYD3QAH
         sLro03wNcaL9ONlE3ZuLOjIC/MWfQdfi/ZlmkoMGWszBYjRzkasHHuxFXp96cFw7BuQu
         LiVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJWOi56faeEOlWODFzEp1R3W5CylK6RzZHe8CabfVzQXi3LGIeBAxW/mWdUPEn4+G/f1fIxYP18hfxUerhUBP3VOaikDuN
X-Gm-Message-State: AOJu0YyVH3Tzp247ootc7dNyNYuRhYunJ0f4DgMEt8V8W4izsvgvhYJl
	bFtDwxAE4TeVhYu186io9BzQ5fC//i5f5X4UeQzMfvuvBfsZHfN3SfqDv2w7yks=
X-Google-Smtp-Source: AGHT+IHDL7qUvlanfXJpum1QutPJwDhfqjnWHrMIeMuLXNRyUdjxIj91RAiue8W9tsSAPEHCGhc6Aw==
X-Received: by 2002:adf:e008:0:b0:341:cfd6:42af with SMTP id s8-20020adfe008000000b00341cfd642afmr4859621wrh.31.1711874704856;
        Sun, 31 Mar 2024 01:45:04 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id k17-20020adff5d1000000b00341b7388dafsm8436003wrp.77.2024.03.31.01.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Mar 2024 01:45:04 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sun, 31 Mar 2024 10:43:55 +0200
Subject: [PATCH v2 08/25] hwrng: virtio: drop owner assignment
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240331-module-owner-virtio-v2-8-98f04bfaf46a@linaro.org>
References: <20240331-module-owner-virtio-v2-0-98f04bfaf46a@linaro.org>
In-Reply-To: <20240331-module-owner-virtio-v2-0-98f04bfaf46a@linaro.org>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Jonathan Corbet <corbet@lwn.net>, 
 David Hildenbrand <david@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Jens Axboe <axboe@kernel.dk>, Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Olivia Mackall <olivia@selenic.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>, Amit Shah <amit@kernel.org>, 
 Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Gonglei <arei.gonglei@huawei.com>, "David S. Miller" <davem@davemloft.net>, 
 Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, 
 Viresh Kumar <vireshk@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, David Airlie <airlied@redhat.com>, 
 Gurchetan Singh <gurchetansingh@chromium.org>, 
 Chia-I Wu <olvaffe@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Daniel Vetter <daniel@ffwll.ch>, 
 Jean-Philippe Brucker <jean-philippe@linaro.org>, 
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Alexander Graf <graf@amazon.com>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Eric Van Hensbergen <ericvh@kernel.org>, 
 Latchesar Ionkov <lucho@ionkov.net>, 
 Dominique Martinet <asmadeus@codewreck.org>, 
 Christian Schoenebeck <linux_oss@crudebyte.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Kalle Valo <kvalo@kernel.org>, 
 Dan Williams <dan.j.williams@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
 Ira Weiny <ira.weiny@intel.com>, 
 Pankaj Gupta <pankaj.gupta.linux@gmail.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 "James E.J. Bottomley" <jejb@linux.ibm.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Vivek Goyal <vgoyal@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>, 
 Anton Yakovlev <anton.yakovlev@opensynergy.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: virtualization@lists.linux.dev, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-um@lists.infradead.org, 
 linux-block@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
 linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-gpio@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 iommu@lists.linux.dev, netdev@vger.kernel.org, v9fs@lists.linux.dev, 
 kvm@vger.kernel.org, linux-wireless@vger.kernel.org, nvdimm@lists.linux.dev, 
 linux-remoteproc@vger.kernel.org, linux-scsi@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, alsa-devel@alsa-project.org, 
 linux-sound@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=763;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=rFl/6jLaFbtBJ+88FvM913PJ4x0vjfjJ4PxyPcL+Huc=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmCSJXrtKjSxEhDjC+L+jnzjTYbfVVvU6xk9d+o
 teur9ZcYz6JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgkiVwAKCRDBN2bmhouD
 18vWD/9VbgZJnWgtc4RTO+pddEkdnkiTVgCduJAzFFrdTMVutBvPmAKiIjAhRDI+a8Un09IPiQh
 aste1QJO7p7fSsZyMBqgnAkPbBRNF+914i4ORlkhllYT6j8TdvLFurf+swTUww1FubuDOoyKts9
 3IYBhK0G/PePT9ybj9PBHD374upe8s6iwPpALGglSB78hEbimgTEzZPTYIVzaSCFbNypvfOo5A1
 3zvxea3c6wu3VzKi0cVux1ZM6W5rowiJwJ0RChKjDGHJpkGKaIhpB3u10SItpaxC4jjT6ydG4ku
 OPnBJNI76koPxFaXD6Z7fmpvzTXYw7Aq1z5O5Vdb3CGQ4ExTWZ18o0cH1KPfCjuCcsEnES8EFCO
 9Dzvn3hAJyYz9JnYMs+4+hRedBTwr1ARhoXSftEW9ElRKNBvdTqwTVpZYA3KN68BYQPh6j98m7o
 BT0AF9Hzsj3GeBTfWRA6cc0j3MQyMMd2qCZmtNEs1mCBi0bxBf9b13/CLibAnxO/AXXds2Dbs2Z
 0ROqHqCOJ1wpwjj70MnWlGzAqkD6Z7YIOSgHQ1T2q+gr+DOLPA9CWLLxNbilOsoOh9wIOuhzMRd
 70e3gCir/B2muC1oT68XzzABQuu2bU4PCKopte4Wbr/04dZjywmaD6GXDiXZRGc2hPIfbSdLXXc
 LUqz7tKsc6Wb1Bw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

virtio core already sets the .owner, so driver does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Depends on the first patch.
---
 drivers/char/hw_random/virtio-rng.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_random/virtio-rng.c
index 7a4b45393acb..dd998f4fe4f2 100644
--- a/drivers/char/hw_random/virtio-rng.c
+++ b/drivers/char/hw_random/virtio-rng.c
@@ -245,7 +245,6 @@ static const struct virtio_device_id id_table[] = {
 
 static struct virtio_driver virtio_rng_driver = {
 	.driver.name =	KBUILD_MODNAME,
-	.driver.owner =	THIS_MODULE,
 	.id_table =	id_table,
 	.probe =	virtrng_probe,
 	.remove =	virtrng_remove,

-- 
2.34.1


