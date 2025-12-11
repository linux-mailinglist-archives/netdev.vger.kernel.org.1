Return-Path: <netdev+bounces-244332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A6BB4CB501C
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 08:46:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B52B43011EF7
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 07:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D772C2D592C;
	Thu, 11 Dec 2025 07:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JHBTkAsB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BA823BD06
	for <netdev@vger.kernel.org>; Thu, 11 Dec 2025 07:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765439155; cv=none; b=rD/pc7LO9535FyMJasD+s5i+LLRuXgIlbf6GKHMBW57lIZ/dH9wsX2t3JzqPJdGFQFgkb42AB8Uf133cm6eI8f2Z6mQoidlTpli+1ugof/XD9q/Q8tzUbPUdupbfGSoH6yaFt8mp7cmK0Uiz+Cp2N/AmXuND94msJZJDWJTyvyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765439155; c=relaxed/simple;
	bh=9mvg3H/c8i6Vw6drMjILUPrnDLVQ4fS3OBd1K9POmt0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=sMpq9+3z1Vyk2OxXE+0L1JP9bwZCcaSX0Hbjc8bUQ03+dC9gB/Cy22UjZ/lHCw25nDFxZFgdbLmxOmziru1YkPrlfjJLAVySzY9tax16IsqARpzEePwBx/ifpzxSvQyxMcrOXS9QXD67TvPBLHVfFWJ4dI8/2ExzwsVb59HjCgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JHBTkAsB; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-477b91680f8so6261985e9.0
        for <netdev@vger.kernel.org>; Wed, 10 Dec 2025 23:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765439152; x=1766043952; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X5PFu97mrs/j5hiZkT9fpEkRD8VCD4PVmKLSzKLxEz0=;
        b=JHBTkAsBs6CLKKp65u0MNvEQmof6eP7cSBEhmIip3P7oBLrJG+h1vgLgipmMeUP+0V
         M9QacK5AksgwkrNtQtewDCaL8GRYlMLEfsjLV1V/0av2J7Cd8KQXi0MpH2k8Qf7LIJrr
         3O49AYU6AN3jjpOMc/dbHnJ/UuW45obE2LES6DNA5A7q6tvJ69v96WSMh2Vwyxb2J+eu
         2UUG7mJ9x5rM5Tq/5K4YO4+B9cOI86whdebY7no8M5lUPJz1mvAE0DRlkmKQutfViEuc
         5Ngdt6aIJx2m0qZPepCPV+n1Il5alkzZxC7oAHe6IAdnmIITLNXMaNQcOS/661q1WYqg
         WJ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765439152; x=1766043952;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X5PFu97mrs/j5hiZkT9fpEkRD8VCD4PVmKLSzKLxEz0=;
        b=jk6KkrZajSGFaLDJ/FRtB7hIcC4HurZwCIkXM1GkHWb0lk9GJoLCkQgYCVNi3ccwg+
         SkzDG/gHocMVSJn+VyeHt31ZM9PEcUEQ8JFs3DzubwiqwfF80K9rvkt+aF7uJhLfWQej
         0/4WSGhRnbIfBDtSYHvpkJlhNS2pbiNvrgRwyTjwe009ec7N3Qd2781ekB9ZE1X4gzCu
         ZwwH6O78/ptXZ+Jl+YNeh6D5kXpvsUK+LgP/Jp+pCrxTP+ZOvl6duY/sxTTwV8jJwnp9
         TPb+3AxB6uFOCMDHAueX772dEEnn8FjL49F1SPllqTdWG+MiRnXv/K41l36RJcAPS2E6
         PrSw==
X-Forwarded-Encrypted: i=1; AJvYcCWu6q/dSMYwHeG9Mgt2QX7QYPlMmI0xYpoi9qgDz6QoYf36sVqlwrx9UUZVhszMMMW9G1AY+40=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYq6FcUasmV4y4+NXjE7T+GDIfmshileNtJ0Mb5OFaEw4pgKTN
	y8q6n74uL2f3qWwJLHoW9bgNeguxrf+KMNLRXkgB0TLTYvk9ZC/ymG2v8N+HLnh/6BU=
X-Gm-Gg: AY/fxX7y2mPYZ4Gf/5wkuIogCCc25gTVj/v27U777rkSkTbbyvPCWKFXBV6yqGafGp9
	fIFQlGxU2u1JouG0Eh+C7ixWT1cqsQA5R/qF/p+d/1xrG4At5UBjaw/iXF7zDujwCHAWks150/S
	llCzafFrFYevZoHL2GBieCyGB0HeHZQvcbjUGMd5emgb+ZE5VbxkzrH0hrUAtdL8SEZ7ThUiPpt
	W1YxOxW+yMb7avM7FgIAiziAe9U4uu5iM80AcuM8InUHhZsRbjw3mMvvv+6y86FcH1mbaKIVobp
	8vW2BRBPemyLfKtRqrWcizKS1+XQWYaG5Yf42O+DWkBc3Xd9hKYRIeEv7YFIl1LhFa5xUSj+IHy
	YpsNESV4HBhocczc+3dMcyUwNKvhV+fb+xSvI3AEJH3Yxk2XDCmCQw7ZfdxlAeiGR/gca+5LIn6
	HQKz5trm1sLQI8R3M3
X-Google-Smtp-Source: AGHT+IF7TmgbE+Uw5kfOPicBWaMZFFELImJD78GoXEDw+MdgM7iNhig2tJYwraCIhaxT+6NDNvyhbA==
X-Received: by 2002:a05:600c:630e:b0:477:ae31:1311 with SMTP id 5b1f17b1804b1-47a8375a1f6mr46323505e9.13.1765439151697;
        Wed, 10 Dec 2025 23:45:51 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a89f8c145sm19182315e9.14.2025.12.10.23.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 23:45:51 -0800 (PST)
Date: Thu, 11 Dec 2025 10:45:47 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, virtualization@lists.linux.dev,
	kvm@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH net] vsock/virtio: Fix error code in
 virtio_transport_recv_listen()
Message-ID: <aTp2q-K4xNwiDQSW@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Return a negative error code if the transport doesn't match.  Don't
return success.

Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
Cc: stable@vger.kernel.org
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
From static analysis.  Not tested.

 net/vmw_vsock/virtio_transport_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index dcc8a1d5851e..77fbc6c541bf 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1550,7 +1550,7 @@ virtio_transport_recv_listen(struct sock *sk, struct sk_buff *skb,
 		release_sock(child);
 		virtio_transport_reset_no_sock(t, skb);
 		sock_put(child);
-		return ret;
+		return ret ?: -EINVAL;
 	}
 
 	if (virtio_transport_space_update(child, skb))
-- 
2.51.0


