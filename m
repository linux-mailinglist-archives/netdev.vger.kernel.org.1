Return-Path: <netdev+bounces-36116-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27CAE7AD5F9
	for <lists+netdev@lfdr.de>; Mon, 25 Sep 2023 12:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 7896828288B
	for <lists+netdev@lfdr.de>; Mon, 25 Sep 2023 10:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7960D63D8;
	Mon, 25 Sep 2023 10:31:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BA715E94
	for <netdev@vger.kernel.org>; Mon, 25 Sep 2023 10:31:05 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9111E8E
	for <netdev@vger.kernel.org>; Mon, 25 Sep 2023 03:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695637863;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0DpECY4xgD810waS/rgF1VksorNZHYkHpCmfPvNqmEU=;
	b=IaIBF0wuzevVZu/c0N750UtEr3vmKh+mtCKD7is1UWXGp0Fys6ACwVzpSBkaIYRxtqpu6F
	hfpMuRNSQjnVAtMoltQQzDWXZHClgnAJ+cvry6t0QSwm+mTv1qi08wc7e3lw2k4LL9LxLF
	3brRY4TYGhJG+qqYa7OB9AbL0d+Z3mo=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-s3HKYWhRNY-ZdxDoOTE-4Q-1; Mon, 25 Sep 2023 06:31:02 -0400
X-MC-Unique: s3HKYWhRNY-ZdxDoOTE-4Q-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2c135cf124cso70486311fa.2
        for <netdev@vger.kernel.org>; Mon, 25 Sep 2023 03:31:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695637861; x=1696242661;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0DpECY4xgD810waS/rgF1VksorNZHYkHpCmfPvNqmEU=;
        b=DCrNGhI+ZbuIsNC00iqeyiKhRPmUjxWDv+S98ecS0e7HRad3eH8BErx5lnvHx1Izev
         KnV1oKgCiW7pbWi/I2IlhEhV90rhlUmTqWe+jtjUvpbrZ8E64zpY+whnOq0J8aQysjVx
         UMMIdceYUHoVLUAf70gwDxrYvKswlGfZz8/z16eFcB+30fuI8ULGo9lqRlhrFvlgqVVx
         lhO7L9+W8CaegZkmfdF/d/IAwCczrcycD3l4nWXatu5aLbMMGgB/rRKSlwz2M867GAZi
         DeoiLR3Fj+2PHQLCwlptOY13N88ydjig6V8IyDTC+nYRvkL/w2uPStTVIRe8EQoapWlL
         EFDA==
X-Gm-Message-State: AOJu0Yx7/Z7ODrrdT+GZw8+WlzlxOwzoImUbrnphT1HS3AGOluRWLWrx
	Q5SvVwxEu08UO6CuRVfpySjQoc+9EZVg4XYMSS0q+xbXQvmv8/sLdVIw+ufplhcC+t07fbiiZy3
	TL/UlKBcOYPJfgOu5
X-Received: by 2002:a2e:8084:0:b0:2bc:fa8f:83c4 with SMTP id i4-20020a2e8084000000b002bcfa8f83c4mr5126299ljg.39.1695637861129;
        Mon, 25 Sep 2023 03:31:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEx1EwDlCVz04qbWgbyK5nfpeoyXqfQ6Qq2TBRTZPqNjJwRcJMbIuZi7IseWRVL8VlZINlyCw==
X-Received: by 2002:a2e:8084:0:b0:2bc:fa8f:83c4 with SMTP id i4-20020a2e8084000000b002bcfa8f83c4mr5126286ljg.39.1695637860736;
        Mon, 25 Sep 2023 03:31:00 -0700 (PDT)
Received: from step1.lan ([46.6.235.141])
        by smtp.gmail.com with ESMTPSA id mh2-20020a170906eb8200b0099cc3c7ace2sm6161066ejb.140.2023.09.25.03.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 03:30:59 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Cc: netdev@vger.kernel.org,
	kvm@vger.kernel.org,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] vringh: don't use vringh_kiov_advance() in vringh_iov_xfer()
Date: Mon, 25 Sep 2023 12:30:57 +0200
Message-ID: <20230925103057.104541-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

In the while loop of vringh_iov_xfer(), `partlen` could be 0 if one of
the `iov` has 0 lenght.
In this case, we should skip the iov and go to the next one.
But calling vringh_kiov_advance() with 0 lenght does not cause the
advancement, since it returns immediately if asked to advance by 0 bytes.

Let's restore the code that was there before commit b8c06ad4d67d
("vringh: implement vringh_kiov_advance()"), avoiding using
vringh_kiov_advance().

Fixes: b8c06ad4d67d ("vringh: implement vringh_kiov_advance()")
Cc: stable@vger.kernel.org
Reported-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/vhost/vringh.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
index 955d938eb663..7b8fd977f71c 100644
--- a/drivers/vhost/vringh.c
+++ b/drivers/vhost/vringh.c
@@ -123,8 +123,18 @@ static inline ssize_t vringh_iov_xfer(struct vringh *vrh,
 		done += partlen;
 		len -= partlen;
 		ptr += partlen;
+		iov->consumed += partlen;
+		iov->iov[iov->i].iov_len -= partlen;
+		iov->iov[iov->i].iov_base += partlen;
 
-		vringh_kiov_advance(iov, partlen);
+		if (!iov->iov[iov->i].iov_len) {
+			/* Fix up old iov element then increment. */
+			iov->iov[iov->i].iov_len = iov->consumed;
+			iov->iov[iov->i].iov_base -= iov->consumed;
+
+			iov->consumed = 0;
+			iov->i++;
+		}
 	}
 	return done;
 }
-- 
2.41.0


