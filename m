Return-Path: <netdev+bounces-240768-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 27704C79965
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 14:44:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id CFE0D3377A
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 13:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3FAA34D3AD;
	Fri, 21 Nov 2025 13:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ogEdLPAA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC65434A76F
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 13:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763732117; cv=none; b=LEVAx3iICL5egT/wO8akG53B0gyt9YZxh/eMPF3826Aa/pLDKyHUi1SR7vkDh8pgsO3/u8JAObL4Kq0dWOlQDCk1O4MnJEgzUfomZy/plgujzTQLHEYjH5HOB2SV/MrXKi9ONtniMe0ek7G/PR/7A7D7PQfpuvEPSbcfUoGb3wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763732117; c=relaxed/simple;
	bh=KXv9/DU644cIIz1nqtNrSpWhbnBLfejEZSSzjDiMVVk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ugeGRP+duSceRGcCwQHUYxGe0TbWAy6+RjgZaVXhNjCQgLJkoPmCCM5KbHvtT7iAyEPNTrFnYgEYV+WIkhdnvK7cRh2Usx/rjdlKwnquN/5JJ8o4LGv27hyUHuxI4QBguvznrSG3htQadUC1otK882ripw+CmSG9t5bjzLpMjss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ogEdLPAA; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-42b3d7c1321so1161500f8f.3
        for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 05:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763732114; x=1764336914; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LTowRJGcYg0HhmMoZiyqiMQ9fvsrn/LxONuXHhgGuGM=;
        b=ogEdLPAAW3Me4+lGFwwc5FfctRL+4g6qHDC6g5zT1/2vLHFh8hAaLpOMFZLVdZi4my
         p3KX3FfHF5wcGgg8fGtJYiFXD9liu4S7lsyws1FZgPcGNKMycC7hesbhinCm6DAf2ogC
         8uze+sF6M3pwGpDkWBsiYK2kTwcqyp6IUJ8tRGjghmP3MtDdQgkg4KFMEck97qzy2Y+d
         WZrska0qz50eL/ZuzurG0ptkBSc3V41RqY9x8qbAEfh64sYuYNpAcL6uAfKGPzVK605i
         1ZvTXmj692vnQmLACXTfWb5X9AhZUi3DVzkNCqLqDmT1xwCvuoa0NBFdyq36wlZcxQF4
         2wRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763732114; x=1764336914;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LTowRJGcYg0HhmMoZiyqiMQ9fvsrn/LxONuXHhgGuGM=;
        b=rNMd7OdzbLeyJ873eB2Z5gstxspxq04iLqTJDTTOKsy+9fU6kw8h48Zie1k4mV9br9
         YFv28QStf82A3RT0VSMKpBCZOTJcyHqkm5ylPfext3vnI9dxX9bfHrK3MK/V3KY2y6R5
         uhlMsHGT+a/BACi2KQoc9tiv+cSR9DqtPoPeMRWKPwcGLZyR0orUE47sPHrNZRv3pwQA
         +J6RF3PHJJ0GeH39xXTcrL3HZBe+FfsArnGjC0yTiJX3AKRvCXKWXZse9/DCLlN9+bna
         AxBPoP1NZUKNavvL2CTtm5LX1Z4Kffu4O1459pg3rSyow9PFxLBme3u2cRcajpP3i+4h
         XcOw==
X-Forwarded-Encrypted: i=1; AJvYcCWxY7Bq2/4eXKOQybZiFi+DLciQLbLiTyHMlXYCnXK4TUX/aGEiWjCWcOa2MZHDlmYOQb7HgZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGPOw9yCANiUAhZrkyRMO3H4W8nx4H7C095ee8gY4F6muEG+g3
	3QaxbwOjThA6Z7wzf/fpVu/nQ0/Wtypa1x0KidTXUjzhz9Qrz6YySvwR3VWNmtRl7cs=
X-Gm-Gg: ASbGncsoKlVs+Db33AGdpIiifxRHZMuCvOcqkhrvp8QPma2aY/vGwOLy0Wb5yNtYhvz
	z2dndF0opCE8PYsebBIkzBsYQYSw+c6ZUiW4zYAeaqLXRWNxiasDHP1l/uu9v+9sOXraGrNuuMC
	bZl7gzsUKF+D6TLnzv0fLLrusnixS7a6mNuhTF8y2JUZDcM5XlZ9Ki4zoPJxU9q1X8Wx/6XqOxQ
	s04sJxaRDUV5caO9TGzm09x/n6PuoNwBxR15tmO+blOopFAqW2Gd2PgRwWRR6GRVprQ4uuB7sK9
	5oIkZPrKfMMAJT25Nh7m7XRt/yUxoAYDx/nOUYeg4t+csA5PiEDs21pNAqWfqUDTAkHF82oWFO8
	D3PzTajDGa5CruqCimtv3puuWFUFoKKhJpZPUPFwAK6ZVGr4QSoMxTYpIMgpwQc+RAd7QXl6+En
	imGJ22k6mHB6kQGNJO
X-Google-Smtp-Source: AGHT+IHmU/+0OTxZO/ujLXvOPYvw9YHDjZwUJsy0cCotaR0gtzRnkipBingnOhyq1CTayGE3YXHsxQ==
X-Received: by 2002:a05:6000:230c:b0:428:52c7:feae with SMTP id ffacd0b85a97d-42cc1d0cd4emr2314094f8f.32.1763732114087;
        Fri, 21 Nov 2025 05:35:14 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-42cb7f2e432sm10663506f8f.9.2025.11.21.05.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 05:35:13 -0800 (PST)
Date: Fri, 21 Nov 2025 16:35:10 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Mohammad Heib <mheib@redhat.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH net-next] i40e: delete a stray tab
Message-ID: <aSBqjtA8oF25G1OG@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

This return statement is indented one tab too far.  Delete a tab.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 9d91a382612d..8b30a3accd31 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -2967,7 +2967,7 @@ static inline int i40e_check_vf_permission(struct i40e_vf *vf,
 			dev_err(&pf->pdev->dev,
 				"Cannot add more MAC addresses: VF reached its maximum allowed limit (%d)\n",
 				mac_add_max);
-				return -EPERM;
+			return -EPERM;
 		}
 		if (!vf_trusted) {
 			dev_err(&pf->pdev->dev,
-- 
2.51.0


