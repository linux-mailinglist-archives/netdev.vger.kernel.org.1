Return-Path: <netdev+bounces-141609-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C3A9BBB4C
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 18:17:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B23B6B22DF9
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 17:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E082F1B5823;
	Mon,  4 Nov 2024 17:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DVo4npFo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA5B1B5ED0
	for <netdev@vger.kernel.org>; Mon,  4 Nov 2024 17:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730740620; cv=none; b=lTuczXJ0YdYyhw7u731dWhrfH8/dKJxoSPu+ZMfmBSEdKRQ2CgdADTK1Y3Ub8jiHHTIaadR+WpeCtShClxCmXQ5Ajbhy5HuBHY0UnNqHLXHwwYo9P4I22SBNP25/VYUJ+XLlSewW+rT8u63hfxxuml49T71Lm4i9+mAj/UfLDO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730740620; c=relaxed/simple;
	bh=5rSNmF7SVn/p/9NHXo6V4eB+jvduKn/piSFjDLgaj5o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QfK2Fi380UT5QBybByj2rNHI91veVVEKxdReEYcOYY5SHcNoABfYzvYHG8xfUoTuixCyvv7RrlcOPNsAY/1Yj5Tw/kC2qHZBjD++mBnySPK6k8ISvfVv0EifdW+L4N+Y011wRFWynynUansCgT9maNc76tKhNFcYDnKBuMcsdEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DVo4npFo; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4314c4cb752so39680605e9.2
        for <netdev@vger.kernel.org>; Mon, 04 Nov 2024 09:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730740617; x=1731345417; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TQTGt/gqq7/pYJmxqzaP90YuUmTX+d1Yw2dKwBF1otk=;
        b=DVo4npFotqm17dfT5qRvlNKegOJMOowOsYRim5XLGKdqEBHSDmN9kN+l6uBOKCvL0r
         AmGz8jtQPhWVRWg/uGXRraNGR+V6ZlGU07pFrinSlRKMx95EJKg08Ni9hZxuwVxUEcHc
         2HsF1VNIkRPpOMoyUjPH/5hn4RRPNxuBR7Dop0TU4+xGqOKbDYvXQnB0dYg6UtIf31ll
         Cu2526YIJPy7LnfWqJzFuYyKvnwrXWe2SUtwjdRABO2rZNksRUrG2DH+E4TvW6s+5GQL
         3lAkOAYO3PtrbGtasfFIDHDQdN1N0o0ElWCN58tCZLw/sZAHHUQgItg7YeeMvFyZa/qE
         9Nqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730740617; x=1731345417;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TQTGt/gqq7/pYJmxqzaP90YuUmTX+d1Yw2dKwBF1otk=;
        b=ehgXDlIspgSYodieVXCTyhdfI6aZZGABMTAew0+OARBDzKAM6qXE1VlJGxbBbA1f9o
         UFE+qhJ0vR1wKBua3neL7eipw4BXSjL6x6arru00DW1lcpomXswAkJqPrvWmHNlrxrk1
         AXurDNnIo2Uz0z3ll4lk/peq4X+Ez18XtRmsLelJj+7klN2ymiJHGkzRtKD3CtgJX9GE
         KmwspdZf5iUWoUKdlwfqfY6Vi2KWkf9C4wHDyOpv2UU6ZQf96iGHBICJAOOuJjz32kAh
         C0hYEzyFnGajuYNgOSCMF2EbQ/MVCg6Ho2StXlPet7x3TxqRd96RfhlIfSj7PzFc6pUj
         Th2A==
X-Forwarded-Encrypted: i=1; AJvYcCXj8q86NvbwWYki2CRq6CQov14g5Vsq5n1uXkasZUHJPxj/gTRGWo1Kxx+QA8a4oq4aHW9XSGM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxirrOg+uXdbPt0vZ9hmEvanRQ0y28wZ6SMPNw2GQUuUbU9pROO
	MuamsKPZHigfxtzo8sQeZMedrmyLrWK5ENMDX7JTsYLA0bRdKw8Lz4vMm8kA5Qc=
X-Google-Smtp-Source: AGHT+IEWsjlUrbOd6UoZ9GRqSDXRc8yhkoSuJHqJz5LvRcSnqYmF9dXj3gbSnh+CpQB15fEK8J3BJA==
X-Received: by 2002:a05:600c:444f:b0:42c:a8cb:6a75 with SMTP id 5b1f17b1804b1-4327b7014f1mr158337965e9.17.1730740617533;
        Mon, 04 Nov 2024 09:16:57 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd917fa7sm187036675e9.18.2024.11.04.09.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 09:16:57 -0800 (PST)
Date: Mon, 4 Nov 2024 20:16:53 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: M Chetan Kumar <m.chetan.kumar@linux.intel.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, netdev@vger.kernel.org
Subject: [bug report] net: wwan: iosm: Enable M.2 7360 WWAN card support
Message-ID: <6321a6df-592c-4c2b-939f-25860a97a5ef@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello M Chetan Kumar,

Commit 1f52d7b62285 ("net: wwan: iosm: Enable M.2 7360 WWAN card
support") from Feb 10, 2022 (linux-next), leads to the following
Smatch static checker warning:

	drivers/net/wwan/iosm/iosm_ipc_mux_codec.c:535 ipc_mux_dl_acb_decode()
	warn: potential out of bounds address 'cmdh' user_rl=''

drivers/net/wwan/iosm/iosm_ipc_mux_codec.c
    518 static void ipc_mux_dl_acb_decode(struct iosm_mux *ipc_mux, struct sk_buff *skb)
    519 {
    520         struct mux_acbh *acbh;
    521         struct mux_cmdh *cmdh;
    522         u32 next_cmd_index;
    523         u8 *block;
    524         int size;
    525 
    526         acbh = (struct mux_acbh *)(skb->data);

Smatch marks all skb->data as tainted.

    527         block = (u8 *)(skb->data);
    528 
    529         next_cmd_index = le32_to_cpu(acbh->first_cmd_index);
    530         next_cmd_index = array_index_nospec(next_cmd_index,
    531                                             sizeof(struct mux_cmdh));

How do we know that skb->len is >= sizeof(struct mux_cmdh)?

    532 
    533         while (next_cmd_index != 0) {
    534                 cmdh = (struct mux_cmdh *)&block[next_cmd_index];
--> 535                 next_cmd_index = le32_to_cpu(cmdh->next_cmd_index);

But the most problematic thing is that on the second iteration there is no
bounds checking on next_cmd_index.

    536                 if (ipc_mux_dl_cmdresps_decode_process(ipc_mux, cmdh->param,
    537                                                        cmdh->command_type,
    538                                                        cmdh->if_id,
    539                                                        cmdh->transaction_id)) {
    540                         size = offsetof(struct mux_cmdh, param) +
    541                                 sizeof(cmdh->param.flow_ctl);
    542                         ipc_mux_dl_acbcmd_decode(ipc_mux, cmdh, size);
    543                 }
    544         }
    545 }

regards,
dan carpenter

