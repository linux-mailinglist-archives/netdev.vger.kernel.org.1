Return-Path: <netdev+bounces-80008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90FE487C701
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 02:16:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D6A01F22249
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 01:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2948763AC;
	Fri, 15 Mar 2024 01:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="br1nEQQQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8086633CA
	for <netdev@vger.kernel.org>; Fri, 15 Mar 2024 01:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710465373; cv=none; b=c5Kax4y83mVR9BbYpYNkit6iTsd3Hv3DfJdVnByU//QFDi/4jx402RmxX0NNbQLMcL6N0cFalE2178AcAJOtnV9lGM8kSAFTxPDYWpn7/qFpZSKTHcuWDuNXCpbY99ZYGB9XZWxBm8sQwY8aUeYHyw7whuM/h4nAJwzqbA8iu4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710465373; c=relaxed/simple;
	bh=MNA82EmzteSi42VLsPkxKVPHKWQQYJ45agqLLak3vJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZYi8J6TSGIGk4uw4Q4nyhfrH/VS1dp9KApdfHf4l4lkq5GS6sq2TMqcankVsZ7CLvdOzHAY+7ZzpIVRcyUHmOOWR2T0v1K0aoDGqPw5o85hL6yDe9bR9G0/8IEaXTpgVcysxmJRU8ACXmLZAqc125rCigD3e7/2GpruufrCE8Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=br1nEQQQ; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-7db26980225so536541241.0
        for <netdev@vger.kernel.org>; Thu, 14 Mar 2024 18:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710465370; x=1711070170; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=26PiiWvNs0Ey0RkM9xNmFa0zNTXoebLTqQZOwSO40SI=;
        b=br1nEQQQkqyl9q9XWWkNxMA51Dwed9sYZgQ4IBMNsm174DgSJ0wsTOyFhUfOABYtJD
         d4g5TDMgaN9KDdEapcGUH1dRItg6k3AsIxra7kEmNAEfy12JSUSg1+hrTa6LCQzxbhmj
         RQ8dXOqzLK/gtRHZnFduBBhMXIjgge8dt2XM7r5W6MFD85ZLrHih6x/+L2E+ep0G2ojS
         Tf4THCYp6hNFhBFiMfRZwOIy3dahA6jJQ5i8lGNnuyKO04kn6olKFnO+nQrgg2K/QMuY
         RcAU7pA5G+vs2CNk2mgPOnaAjMdb6alSsKAe/wYVS5yFtT6b49EUqpjg3aRpW4WTCUW3
         Zaow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710465370; x=1711070170;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=26PiiWvNs0Ey0RkM9xNmFa0zNTXoebLTqQZOwSO40SI=;
        b=OFTz1XhxrDwegDl+Zw/wRQH+TqDL+pxuAJ9q7/UxMviaxsl1d7PV3J+LzVj5u1ge7Q
         Bbmsrn7cz0WDK8bTAT3ZRULFE4mvU7BedhnSf5WxZ95trbQ99m0aofkw2amjPJZo8R4B
         neljYLEFqgekoO1o7N3PImT7lkk3iADKetmPPhynleMdg4wS3ahAmkAcjppDl7br63tG
         i5ykXTP85ocoXcnc+A3huhubFt93htj3LIy/XQPt8A3+FoKYUxRqBdxSnt0kB1bnnRwq
         Qb8VTvOT6GkpjKN59FScguPrrZcdDOu5vp/jnl+m9bm+uhYKUou/+urVnUlAY/YB/2WZ
         +W6Q==
X-Gm-Message-State: AOJu0YyWPNHNk0yXuWepLwe73QCJGT0Gf9glzA4FvRiAKFyLaMS8N4Jd
	h7HWhQgU+nrb0Q/FyRtIAqMtX/r5md+SJrdhjTL4hatRxPtTFmU=
X-Google-Smtp-Source: AGHT+IG6Hre5udAfQx9NHDNEU1T9G4vAoPgC3Em/U/IMzIx/Ap0/Yje8+mAPSLh5Mp/xImpGzSz/Fg==
X-Received: by 2002:a05:6102:3b81:b0:472:65b9:1c59 with SMTP id z1-20020a0561023b8100b0047265b91c59mr1965347vsu.23.1710465370440;
        Thu, 14 Mar 2024 18:16:10 -0700 (PDT)
Received: from cy-server ([2620:0:e00:550a:9f1b:4292:76f0:cb8c])
        by smtp.gmail.com with ESMTPSA id gg8-20020a056214252800b00690befbe5a5sm1225503qvb.74.2024.03.14.18.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 18:16:09 -0700 (PDT)
Date: Thu, 14 Mar 2024 20:16:09 -0500
From: Chenyuan Yang <chenyuan0y@gmail.com>
To: chandrashekar.devegowda@intel.com, chiranjeevi.rapolu@linux.intel.com,
	haijun.liu@mediatek.com, m.chetan.kumar@linux.intel.com,
	ricardo.martinez@linux.intel.com, loic.poulain@linaro.org,
	ryazanov.s.a@gmail.com, johannes@sipsolutions.net,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org, zzjas98@gmail.com
Subject: [drivers/net/wwan] Question about possible memory leaks in
 t7xx_dpmaif_rx_buf_alloc() and t7xx_dpmaif_rx_frag_alloc()
Message-ID: <ZfOhWVnTsE8JAhXk@cy-server>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Dear WWAN Driver Developers,

We are curious whether the functions `t7xx_dpmaif_rx_buf_alloc()` and `t7xx_dpmaif_rx_frag_alloc` might have memory leaks.

#1. The function `t7xx_dpmaif_rx_buf_alloc` is https://elixir.bootlin.com/linux/v6.8/source/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c#L164
and the relevant code is
```
int t7xx_dpmaif_rx_buf_alloc(struct dpmaif_ctrl *dpmaif_ctrl,
			     const struct dpmaif_bat_request *bat_req,
			     const unsigned int q_num, const unsigned int buf_cnt,
			     const bool initial)
{
	unsigned int i, bat_cnt, bat_max_cnt, bat_start_idx;
	int ret;
	...
	for (i = 0; i < buf_cnt; i++) {
		unsigned int cur_bat_idx = bat_start_idx + i;
		struct dpmaif_bat_skb *cur_skb;
		struct dpmaif_bat *cur_bat;

		if (cur_bat_idx >= bat_max_cnt)
			cur_bat_idx -= bat_max_cnt;

		cur_skb = (struct dpmaif_bat_skb *)bat_req->bat_skb + cur_bat_idx;
		if (!cur_skb->skb &&
		    !t7xx_alloc_and_map_skb_info(dpmaif_ctrl, bat_req->pkt_buf_sz, cur_skb))
			break;

		cur_bat = (struct dpmaif_bat *)bat_req->bat_base + cur_bat_idx;
	}
	...
	ret = t7xx_dpmaif_update_bat_wr_idx(dpmaif_ctrl, q_num, i);
	if (ret)
		goto err_unmap_skbs;
	...
err_unmap_skbs:
	while (--i > 0)
		t7xx_unmap_bat_skb(dpmaif_ctrl->dev, bat_req->bat_skb, i);
}
```

In the label `err_unmap_skbs`, the function will unmap the allocated memory for `bat_req->bat_skb` by checking `while (--i > 0)`. However, the first element (`i=0`) of `bat_req->bat_skb` is not unmapped since `i` is decremented before the check. 
By contrast, in the function `t7xx_dpmaif_bat_free` (https://elixir.bootlin.com/linux/v6.8/source/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c#L984), the first element of `bat_req->bat_skb` is unmapped.

Based on our understanding, a possible fix would be
```
-      while (--i > 0)
+      while (--i >= 0)
```

#2. For another function `t7xx_dpmaif_rx_frag_alloc`, the function is https://elixir.bootlin.com/linux/v6.8/source/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c#L319

```
int t7xx_dpmaif_rx_frag_alloc(struct dpmaif_ctrl *dpmaif_ctrl, struct dpmaif_bat_request *bat_req,
			      const unsigned int buf_cnt, const bool initial)
{
	unsigned int buf_space, cur_bat_idx = bat_req->bat_wr_idx;
	struct dpmaif_bat_page *bat_skb = bat_req->bat_skb;
	int ret = 0, i;

	if (!buf_cnt || buf_cnt > bat_req->bat_size_cnt)
		return -EINVAL;
	...
	for (i = 0; i < buf_cnt; i++) {
		struct dpmaif_bat_page *cur_page = bat_skb + cur_bat_idx;
		struct dpmaif_bat *cur_bat;
		dma_addr_t data_base_addr;
		...
		cur_bat = (struct dpmaif_bat *)bat_req->bat_base + cur_bat_idx;
		cur_bat->buffer_addr_ext = upper_32_bits(data_base_addr);
		cur_bat->p_buffer_addr = lower_32_bits(data_base_addr);
		cur_bat_idx = t7xx_ring_buf_get_next_wr_idx(bat_req->bat_size_cnt, cur_bat_idx);
	}
	...
	if (i < buf_cnt) {
		ret = -ENOMEM;
		if (initial) {
			while (--i > 0)
				t7xx_unmap_bat_page(dpmaif_ctrl->dev, bat_req->bat_skb, i);
		}
	}

	return ret;
}
```

Similarly, the function will unmap the allocated memory for `bat_req->bat_skb` by checking `while (--i > 0)`. However, the first element (`i=0`) of `bat_req->bat_skb` is not unmapped since `i` is decremented before the check.

Please kindly correct us if we missed any key information. Looking forward to your response!

Best,
Chenyuan

