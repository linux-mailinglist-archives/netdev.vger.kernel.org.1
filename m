Return-Path: <netdev+bounces-82476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1659788E540
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 15:19:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0EB629B401
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 14:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA0C14A60A;
	Wed, 27 Mar 2024 12:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VtiGxdPt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803AD14A4CE
	for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 12:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711543485; cv=none; b=uRB0uLM5fZJ+VJ8t/1ZaBJsSgrG3OCEbvKfgVhmELDGGfFvzKqBQKuYuCmV3OyfPdroY4dmLO/qqfbN+jqkNCyxFOH2fjEpWzJGdUsvvTDg7dGWq1+JW1dTP3UMMJpH8/gikEbm+9ESj90aJughyZsS/PB6gV/foPw2y0+URaUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711543485; c=relaxed/simple;
	bh=+TTEvPeSyDKzVSSZ0ChnkaU38LId0eko0vuS5jdKWCQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FdpWdpC0DBNw+vPfzPt5k7hhDAU/74ZWc60511s5A4rnQl+okROiwjU/qNzVGWAiF1pBhlOzTXC0etZ9PAu2P7oYp9nLuk02xfhT1mVIlXHmRxkcne4E+mEWQ2hwkWlLPETh9pC+kFf4NNB982IRg9UYNfKFVCSxpXzU/Uy9hGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VtiGxdPt; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-56c441e66a5so213538a12.0
        for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 05:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711543481; x=1712148281; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hLTRp2vTdiF6En9+dHZ3QcMOJs6Q2EWbLSRJcvapXSg=;
        b=VtiGxdPtXniePmgpmzKARUnYN8aSiurj6QJQFbRth9ojdrP/nU6X/Rsv5VQAqUAiw0
         nXHyLO4q1fnw+6dQor6ZqjOSfISzXoQ5J2rqVUrztVI6EygUeRqE81tZXrPKlXSXgx0S
         +t8LXixRHxqgeiiFKTMYCkr6nlxyN4p8+v7SOMS2/7K5WaCPzn01ZJmhXKFNSV5AwNmB
         CMvClm0kIl8mcUK8l9GGV9fy2kCRhFhUSr7eRhJg/HTgr4iT9a2rW0JOVvogcMMrGxoS
         R52ULqSzfzA6I3kM1omR6JpNXadfVHII97Blu8GgP+Ot50P8YGBLE4sS0kVYYSh7CyZs
         gawg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711543481; x=1712148281;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hLTRp2vTdiF6En9+dHZ3QcMOJs6Q2EWbLSRJcvapXSg=;
        b=ECghTxgsFTEo+dCCfE3d171gv5ARN9FNs0JjGvB15HHNMiR9euJerFCIlIWAbak/Fs
         JGbvmKgIQXmPqESnbENdPKcQUCkTPK0A4ppqCJo5QBid6IrE/M2366mWo20AZyVRyyhL
         Ifrj4NmNjpJSMzXZyjaLcrkLmZfO4Ey3IDqe8M9NSimnnbmYSPvBJq4mpucsnnAsn3/4
         tJ+F8wyam70fteHp5jBPZEq0ASHkd4LFOoja12VbaPQh7X8i1G8cSA45lxAotMW8KdyM
         wDNl7EWCWvy/bbwpG50AfTGYejy/V2oY4sqbfD3FfnQJmTN/4afIeHzU2OJ9sLEnNhO5
         fdWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLfe5XphFItPRDVsQ6rFmeLOpFqvUh+FsBC9gQKacsiY6S5UikBedqrnqTNDND4fFaVhUfsxL+fLQsOcFhMlvJTUDSa4Tm
X-Gm-Message-State: AOJu0YxfPTEwtJr+FE8oyA9o7/cbIgzwvT8WKMgT+5V4GEmtmTvLphZ2
	l4WYKsqqH5lhh7dWDHqmjgZ+3uWNtDu7YtqdqadfBdFWThYZxVyjuB2JG8N6G8A=
X-Google-Smtp-Source: AGHT+IHhazMmScpDCVE5i2KB2spuKKBHY96umDzN4+tbnuRVjM0nNvNgt07FxjvGx72WnVTtepaPNQ==
X-Received: by 2002:a17:906:c7c4:b0:a47:4ae0:3bb9 with SMTP id dc4-20020a170906c7c400b00a474ae03bb9mr1746143ejb.23.1711543480699;
        Wed, 27 Mar 2024 05:44:40 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.206.205])
        by smtp.gmail.com with ESMTPSA id gx16-20020a170906f1d000b00a4707ec7c34sm5379175ejb.166.2024.03.27.05.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 05:44:39 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 27 Mar 2024 13:41:01 +0100
Subject: [PATCH 08/22] firmware: arm_scmi: virtio: drop owner assignment
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240327-module-owner-virtio-v1-8-0feffab77d99@linaro.org>
References: <20240327-module-owner-virtio-v1-0-0feffab77d99@linaro.org>
In-Reply-To: <20240327-module-owner-virtio-v1-0-0feffab77d99@linaro.org>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Richard Weinberger <richard@nod.at>, 
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
 Viresh Kumar <vireshk@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, David Airlie <airlied@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, 
 Gurchetan Singh <gurchetansingh@chromium.org>, 
 Chia-I Wu <olvaffe@gmail.com>, 
 Jean-Philippe Brucker <jean-philippe@linaro.org>, 
 Joerg Roedel <joro@8bytes.org>, Alexander Graf <graf@amazon.com>, 
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=779;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=+TTEvPeSyDKzVSSZ0ChnkaU38LId0eko0vuS5jdKWCQ=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBBPgrxhxsNBNmJJQCHKExyWHnP8ODMwEsvhWt
 n/mycDlzamJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgQT4AAKCRDBN2bmhouD
 10y3D/4z3M+4KkLsY4QC3Xn4tvrxIjQ5Wb5DPTrn24JMZBhJ0G36SkzajGkhIsJvlZAWAN5cjth
 BGRcFpee63p66hs/5nlr7xvsuuUaFToUJGB1MEtOMPJVcGgxdwT+QY608PsisH3k7Q5LfND+vtd
 a00SB8S8bdFeo/J6QR+Lo4WVzn4MmQ6bQUUO0x+w6j9u2ApDWUpbn4lQFBXyeB6M9QvhtpKKT18
 WIlAR+9+r+YSy1Jv1Alf8VtzMU5ZrE2C4/22VDZfP/KjTOokwZprIl+pdQS2AfNe/Ov/Um8lFzP
 LAcx4A+9rIPngAmQgBppsvGcueE06F1zjch2eVeKOCJfzpMUIa8YMWxzrmDoz9DhFTK2fLHILan
 PRiM3f7a9Tz1k0IHaxCdiTlw89mA9VaCF9BFGTcX5VDzbukPSs/J7S6jmkkXYum2exhtLNOZ4X4
 gCG9UW75vXSFzlKKDrxGjGn+4JQxdKpNyd1/8uEaDXO23Fl8L5Ivv7rB+UEoBnPrG26oOMmLi9h
 0pFF+gXPq1C693H4Fh6zYpvN8MTP+GmO3O+kgxgNgIQXapBUXSVJXHcUY8in0h+Y3Zw8XhDa7fY
 thDmSLGfYHMHtGA5AdIZ4s0FpTgXieMccsEo2WE/DQoaAEKsnyro00wnY0zbQWRvD26KY1iP+dv
 LPx5k0S9Vk6nZYA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

virtio core already sets the .owner, so driver does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Depends on the first patch.
---
 drivers/firmware/arm_scmi/virtio.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/firmware/arm_scmi/virtio.c b/drivers/firmware/arm_scmi/virtio.c
index d68c01cb7aa0..4892058445ce 100644
--- a/drivers/firmware/arm_scmi/virtio.c
+++ b/drivers/firmware/arm_scmi/virtio.c
@@ -908,7 +908,6 @@ static const struct virtio_device_id id_table[] = {
 
 static struct virtio_driver virtio_scmi_driver = {
 	.driver.name = "scmi-virtio",
-	.driver.owner = THIS_MODULE,
 	.feature_table = features,
 	.feature_table_size = ARRAY_SIZE(features),
 	.id_table = id_table,

-- 
2.34.1


