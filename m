Return-Path: <netdev+bounces-153007-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC9D69F68EE
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 15:48:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 553CB7A439C
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 14:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51BE51C5CA8;
	Wed, 18 Dec 2024 14:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kBID1MbL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EA01BEF6A;
	Wed, 18 Dec 2024 14:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734533272; cv=none; b=dLbeKbn4NARGIJIUIwdUNTrEOg9udQVwecGduNIsU7K+hjxLDmfjeXQLlv2gDxebpGCOpsFcA3c38ngfkyNoHYQmfANejV1CZl5P+9ulAKdV1IHPtokkX4McDPmMq4W+n+yiQHojzYmWY904kRG/IYfQh3Rm1/tUuxVgqZnyWJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734533272; c=relaxed/simple;
	bh=GvYSFAiBsuk144oZpVaErUQ3PhXmKtvGBNNKqtNPRr8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XC0K86c+ZAvfCLBWqJ8La1FDpncUd1xbVQHDDHRvacH5m96f4i5xnEPQx3Vifvi3Iazno0XUUB3zFdi/b08LNoyqqu9qhntMQJEVGbc2irHrOU8yGCGFEskEtq3bvzAaXdsW6VBSwkByACSjtUyE5c3MxJsynz7WRNqb0HhVfGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kBID1MbL; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-728f28744c5so6186568b3a.1;
        Wed, 18 Dec 2024 06:47:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734533270; x=1735138070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mc7vxr1AV6y7PlaTyBTbDeICZHlLupBm5PfolrJFBic=;
        b=kBID1MbLueuBxfRY5c//7lXi/yRpsJd6rx8Up4lXw8ePzF4WLngM+rShkoWUcVbI/U
         2LuOaucZgsRxw46gxVQpGt5/F0/LeXibuhqrMcsrNVppaZssrV4LrxEqcyuB4Pzm1R7G
         zpFlWIMWNaSns9sJWwONrXmq8tuuwLnGWWPpVlzz0GUjAcB/Ik9tJi1W01Ka4lfLVzYU
         H4CpwLs3bNfS3ZF918hAnMWKKfrwV/2wx/QLlOw+zd2+3y8ZmhXCoyTRtMkq67LvTrB8
         39brtJ0ZgDHUlTEw8XaLTy5zdIoNZFzZ7tWxwKfNRA2eaDvM/ePKbo2eLHu4rO0uL9LC
         ghiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734533270; x=1735138070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mc7vxr1AV6y7PlaTyBTbDeICZHlLupBm5PfolrJFBic=;
        b=Vxuw8T40nhJdKjYQOk+1u31wsuzzyImtP1eWPNRX4Fd5jgy6rkbAysMCl4L0iE+d7L
         XMLtvQ4gzxN6hlaO9mk9uB/K/JU+b0ZeUkhgzxAybA3rJ177E51i4Vb2DEDrVaXBMxgz
         5pPz+ec6FMw9lWN3PQ6tH91UDp/zaYEesf5VpmxxAzuUBa+HRHBdP4kL/pJbXRB3otOe
         ydzfBJwsaD9UB2kA6HdMLS4QwnGgvrgnrIPMv3cGGk2CFRqBA8yc/T48Fh4jq+zcRgoX
         TMe91ELFkS00JmEuPKu61O5jnuclB23++D58xF3RSYB4DipOssosxVxkYSR9upafqq2s
         a06A==
X-Forwarded-Encrypted: i=1; AJvYcCUbi++tFBriIS3aZ8EL1EJkWI2+8S68j9tqXmFdLBR6QxCi8YfAV4YStdz6V62UnARfN6GcK2hUmxA=@vger.kernel.org, AJvYcCWPe++VDHc3lAtev/m8QAOsVkpE3HoK6aGyH5IqbeFtgsO+5URoJOTY18seSWw8BSlbGFCQWxiy@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3iCJQUy+AzXjgdYcHbhlt6HfcXKufe/b2JOI6T4zriEqPU8MX
	pq+kPt4aWMv9uoYy49RpuKOcJ2rFsyD5rJr/I8uFTrTjge6Gpx9N
X-Gm-Gg: ASbGnct9RHFQLLaHrULAcufigvDoZYtKcXR5GhfzDvM/rESHJS+YLf9WJp8rKpGCIsB
	YsPA2OwHazqoB+kNBemB46CODXXL0ObRivj9FeJykCHOME9VCouH+Hq3ypgT4mBlmcv4AtmXjdX
	VHPzcA3VXtX/w0vc/Vviy4NXieP8x/UrtCfUC6ZhhBI7dVJ8d3kAxL8SzCABfKsURBcIltJn3Q8
	TZu72fdkdCoqoK7dmSNq0wYzLIyJsrDag6L+KvbfYlbsw==
X-Google-Smtp-Source: AGHT+IGMU5TjK6pU5rW9tocNan+1bR7pjB0aDl/HnzMg82xZ2wXzaaz/UOtnCOhLeKCbuX/XbrLXGw==
X-Received: by 2002:a05:6a00:3a02:b0:724:e75b:22d1 with SMTP id d2e1a72fcca58-72a8d2c407bmr3668626b3a.16.1734533269912;
        Wed, 18 Dec 2024 06:47:49 -0800 (PST)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918ac5183sm8912687b3a.29.2024.12.18.06.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 06:47:49 -0800 (PST)
From: Taehee Yoo <ap420073@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	almasrymina@google.com,
	donald.hunter@gmail.com,
	corbet@lwn.net,
	michael.chan@broadcom.com,
	andrew+netdev@lunn.ch,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	dw@davidwei.uk,
	sdf@fomichev.me,
	asml.silence@gmail.com,
	brett.creeley@amd.com,
	linux-doc@vger.kernel.org,
	netdev@vger.kernel.org
Cc: kory.maincent@bootlin.com,
	maxime.chevallier@bootlin.com,
	danieller@nvidia.com,
	hengqi@linux.alibaba.com,
	ecree.xilinx@gmail.com,
	przemyslaw.kitszel@intel.com,
	hkallweit1@gmail.com,
	ahmed.zaki@intel.com,
	rrameshbabu@nvidia.com,
	idosch@nvidia.com,
	jiri@resnulli.us,
	bigeasy@linutronix.de,
	lorenzo@kernel.org,
	jdamato@fastly.com,
	aleksander.lobakin@intel.com,
	kaiyuanz@google.com,
	willemb@google.com,
	daniel.zahka@gmail.com,
	ap420073@gmail.com
Subject: [PATCH net-next v6 7/9] net: ethtool: add ring parameter filtering
Date: Wed, 18 Dec 2024 14:45:28 +0000
Message-Id: <20241218144530.2963326-8-ap420073@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241218144530.2963326-1-ap420073@gmail.com>
References: <20241218144530.2963326-1-ap420073@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While the devmem is running, the tcp-data-split and
hds-thresh configuration should not be changed.
If user tries to change tcp-data-split and threshold value while the
devmem is running, it fails and shows extack message.

Tested-by: Stanislav Fomichev <sdf@fomichev.me>
Reviewed-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
---

v6:
 - No changes.

v5:
 - Change extack message.
 - Add Review tag from Mina.

v4:
 - Check condition before __netif_get_rx_queue().
 - Separate condition check.
 - Add Test tag from Stanislav.

v3:
 - Patch added.

 net/ethtool/rings.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/net/ethtool/rings.c b/net/ethtool/rings.c
index c0cb9b2c6616..284ca34a3b41 100644
--- a/net/ethtool/rings.c
+++ b/net/ethtool/rings.c
@@ -260,6 +260,19 @@ ethnl_set_rings(struct ethnl_req_info *req_info, struct genl_info *info)
 		return -ERANGE;
 	}
 
+	if (dev_get_min_mp_channel_count(dev)) {
+		if (kernel_ringparam.tcp_data_split !=
+		    ETHTOOL_TCP_DATA_SPLIT_ENABLED) {
+			NL_SET_ERR_MSG(info->extack,
+				       "can't disable tcp-data-split while device has memory provider enabled");
+			return -EINVAL;
+		} else if (kernel_ringparam.hds_thresh) {
+			NL_SET_ERR_MSG(info->extack,
+				       "can't set non-zero hds_thresh while device is memory provider enabled");
+			return -EINVAL;
+		}
+	}
+
 	/* ensure new ring parameters are within limits */
 	if (ringparam.rx_pending > ringparam.rx_max_pending)
 		err_attr = tb[ETHTOOL_A_RINGS_RX];
-- 
2.34.1


