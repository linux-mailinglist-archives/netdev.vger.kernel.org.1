Return-Path: <netdev+bounces-83548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2EC892FB8
	for <lists+netdev@lfdr.de>; Sun, 31 Mar 2024 10:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E7C51C20F3B
	for <lists+netdev@lfdr.de>; Sun, 31 Mar 2024 08:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F3F8615A;
	Sun, 31 Mar 2024 08:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M4KSGq7O"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0B18626E
	for <netdev@vger.kernel.org>; Sun, 31 Mar 2024 08:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711874695; cv=none; b=az07DBoPR64dLatM0g5IIDctd9Qg4pke9Mr+/Myve8wo8/hJS1RYKmt1brGDJprzebKCKKpwBhFAeZBf32qSOAXdT0bptO4gYuGOdrsmjRE+/S1mNh5I4DZlVkhQi2AsHvjdMP5gIN+YSf44F8p/CTTRIH/YswnAX5Xg99IdnSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711874695; c=relaxed/simple;
	bh=kq0Ui8ydSZ7Hq9AlXQh0XFHRtPG8YMsmmEL0wAEhAnc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dXa61j3x8R2bRP8oy9YI1UrLj3kx0pub9QbO9zuzMH+9Hl01z91JsSoMo4kn0ElscGNeknYMRNDW6lMn/WFWQs5HDPj+eQt+vVwtrKhcC9usXWc6faHdJXE16GfAWVJvxP+ErFcA4RWph5ADbhRK4w/hovgEYA6MS5ybdVUV4DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=M4KSGq7O; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-341b9f6fb2eso2306646f8f.2
        for <netdev@vger.kernel.org>; Sun, 31 Mar 2024 01:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711874691; x=1712479491; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R1fmxNrW+En3ik5NRwajUgb1npSjXN0p0vGcgo9pP3o=;
        b=M4KSGq7O6M1t5gSPLWzbZRc5kOWpEdSFBlE3DrqbfLmpHu77c1wXYLp1H9OtA/MWoC
         oBMDJQp19JERlAIMS9rqAVV6GviETLTMnPmh/X9cxNaYIibft0tlGSZ4184exUq6svk3
         0aNCad2qjX4t26WdNYuBn7+22P6J+sbcPZQUI2yCo/DR38/pd/le9PUBJuWFM0n3xsRW
         uuN+4Zt00GNXHBj07pXoHpW1QKtKgYvTRa4izRxWWrTG6MAUJ49J4sSXkvpqfNHkdoeC
         j1STpLiZHLH5gAO6+vgj11XF7hq/XruDhq8+WXvD2qKGJxAuXb6wLV0NZOwUgXTet8ZM
         i9yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711874691; x=1712479491;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R1fmxNrW+En3ik5NRwajUgb1npSjXN0p0vGcgo9pP3o=;
        b=uwAjWw8XQI2IOuFXCuHUjS6Mo5j83uCWfC35mgOlDq3BMK41C6t6WrrnLnsk7wANNI
         J04BnNjArf3WxwpIZ5ac9XfEpHeIJXUBg0F+POoDipyVU5izmzDvzV5xjhKg9liyP29B
         hOd8ZJ5oq1bs4ht7wWgPtYNspOOtkdP2KqUm3Ku+osuyoQBOFxA/FQhEpIbnZhVK21qQ
         MfZ/0J2qTII2e5CTxvhXN9nPQ70/bvweIr7RgGoLjtsf5968yYATQPlGUaajXXzVr0Pt
         jyLMzWhfFXtazyf+9a9HqIkZ+8atpKq46RM1iQ/C/yocNOKo2WOgSf8izPn+qUGqKui3
         K8hQ==
X-Forwarded-Encrypted: i=1; AJvYcCVB2X/XLsLL2TIZ3oTBfz0WGlmGwUfFzBVBaI+AaSbEO60wVKXFAurN67udeCKMVqEOyZA7GWegh3J1m+FnWC5c3XtxH3pB
X-Gm-Message-State: AOJu0YxfGFkV6iuDdjn4t8Q0AlwyeA9GsZFBL3fv/M5/OcbBn649cnot
	iEK1cNAikNf5i9VGPv5pGkLyv2LYBG9caIueOJAe6QjfExy9PN2yzrgasksIrpY=
X-Google-Smtp-Source: AGHT+IEvG4Cb0djhBW2bVfE6XN6EEBOTKzJhcyxggJ3B5oUXP8szqnDQNAv76iS27j8cgymDVjUeZw==
X-Received: by 2002:a5d:4950:0:b0:341:cdd2:77e9 with SMTP id r16-20020a5d4950000000b00341cdd277e9mr4836936wrs.60.1711874691078;
        Sun, 31 Mar 2024 01:44:51 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id k17-20020adff5d1000000b00341b7388dafsm8436003wrp.77.2024.03.31.01.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Mar 2024 01:44:50 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sun, 31 Mar 2024 10:43:52 +0200
Subject: [PATCH v2 05/25] um: virt-pci: drop owner assignment
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240331-module-owner-virtio-v2-5-98f04bfaf46a@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=769;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=kq0Ui8ydSZ7Hq9AlXQh0XFHRtPG8YMsmmEL0wAEhAnc=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmCSJUTNbl4Q+dP5HrdikutJS/JjxedTtQx01xy
 nUN3Bc+MDeJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgkiVAAKCRDBN2bmhouD
 10bVD/0fUo9bh7ci+dZ2GEleWtdLm7IYNCSedKZaQfcrAw1NIF9rTRkW3y0Du0+OfxnZtreW7Jy
 xV/dOtVIW9BUDrDQcIEowtRs5jJTw4YHg3duDoqki6wKNBruHwdQBCQZfGL7DBt5m3VN2gdWlsv
 DrxXtKGcpiFvz9dfKy/FRbZTerQgtCE1+q5cGRc3eSXqDxfcJLHhwDglQhy23cErJuaCO/62JZq
 EWegfJR0lR8/PewSpOngB7JPLAMaf5JuKW3/1ridIGe5Il3gQbf/MU9qcUWg3iakTf6P+IrAyAI
 sQDQigdl4xH4tqu8XJ1d3QOaFpVon0OuylQVz3lrwp2Ovoy4BKHgYyXg47GzK19iFUUu4Tm4879
 KNPZTD3K7JP1S5e3TtwtduChtq8I0ZTG8mZbKV9EGPtjEtZIPP2soqzpzWPCqwNZ7Z9x0lk+wrD
 V+RVF3buo89apBrFu6qVyDl/XJhjHDZSpKrpsCdWRY9yOTq8P6qV6QN/jQP06I8hUvToGa2kHr+
 gO28lqLdp/8e/mH15NPGAtqseTT4RkgWLV5YMQupKmKufhnqTEQ2NpPG7bkdNLa3RowK6V5PUZR
 i7NI6F54U/axIEDTTXFAc9mjE6ExLu+nHeJQFmZbkAuSrw/C8DXb5Qfclk3+UFWHcvRqphFhox8
 8KvsBDpTxBKfHOg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

virtio core already sets the .owner, so driver does not need to.

Acked-by: Johannes Berg <johannes@sipsolutions.net>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

Depends on the first patch.
---
 arch/um/drivers/virt-pci.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/um/drivers/virt-pci.c b/arch/um/drivers/virt-pci.c
index 97a37c062997..7cb503469bbd 100644
--- a/arch/um/drivers/virt-pci.c
+++ b/arch/um/drivers/virt-pci.c
@@ -752,7 +752,6 @@ MODULE_DEVICE_TABLE(virtio, id_table);
 
 static struct virtio_driver um_pci_virtio_driver = {
 	.driver.name = "virtio-pci",
-	.driver.owner = THIS_MODULE,
 	.id_table = id_table,
 	.probe = um_pci_virtio_probe,
 	.remove = um_pci_virtio_remove,

-- 
2.34.1


