Return-Path: <netdev+bounces-131274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC16698DFCE
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 17:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7438B1F2A343
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 15:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D861D0164;
	Wed,  2 Oct 2024 15:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BrjRNK2A"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8E11D0487
	for <netdev@vger.kernel.org>; Wed,  2 Oct 2024 15:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727884323; cv=none; b=khp78WLFeOSsOPbAKvsY+ERbTB3EPTKflwVDQHkb5Dhc/JiPSSBfXVnYkbGJpUSDcBf7xPyZ76pVCm+Wusr7blK3u03ykvOzhlBRPATs/NnJ9QxZ0+MJWSZacKhPJCpiO1K8Bd7G85ovquAfOw6dQeP5/p+6AbwpvrJKElIqsNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727884323; c=relaxed/simple;
	bh=Rqg/XO+Oc8nG+ZJzexxzf1ED/UAbA/S0EUt2nkSxqNQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=SLDaKAdmgnEk8SpF2s2oy1Nqh7IRantP7xLiYBIBf9/lUcKrMi4TnFzFucaiHOMgWeA6masuSZgPJEM0Pp4OLb+erIs8GpO3PpJ/mvivTh7bVZB4uIUjJ2JhS2G2QvLhvPPPef0X7wcc8YjrQr37u/dn6GNmcB8zk6DS8Ql5plc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BrjRNK2A; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-2e075ceebdaso5160390a91.2
        for <netdev@vger.kernel.org>; Wed, 02 Oct 2024 08:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727884321; x=1728489121; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Rqg/XO+Oc8nG+ZJzexxzf1ED/UAbA/S0EUt2nkSxqNQ=;
        b=BrjRNK2Aj6o+hbF6bu1O+ktzysQ+lwzUhy6iISp/oUz6gxcj9M7wN3sTXR8uSP3hzG
         oiDVAar5Of61DY32pkSWjUWHH9ssziCafLCEd2ci9fjr74mITfxFUHvuzuOk0aARkN3u
         89ZpAEKs1F9+Yjdf6W+jqerx84QU70i/v62v6eZRea+6eE7vbMtkNntAF9DQ2UqCkCVS
         0+6WxhEbbXOTcZPYtmWSYC/adc//nAiYlEVxQ58HcB0UVz8kQUd9xmQBss4/ccQ4w2vC
         a/R04/HcZuAqw+293gCvgwB5hqdhi8zevm56EbnyHPoCeJcU50BAblvmFg4BZUzX6sXN
         GouA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727884321; x=1728489121;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rqg/XO+Oc8nG+ZJzexxzf1ED/UAbA/S0EUt2nkSxqNQ=;
        b=eRe6NbQdAs8XZq2uJcs9tOhJDo3+F0gf/wD8sV369TAvYRzMheGDkN7J8HqJGld/79
         Qi78LUtM8In4noaj7clxlydVDOjSYpK9+38kXW/4WEauIKj42UkIDBvyaY9TP9F32HXi
         cCU+xK92QBxXy0C678ZSVFyqhTD0qwmlg5sKTeZhp1JVC3OHqzf/c3jyTSmlizvcmeGd
         BOBsjmXuPvWekAR/zzW4K9i7GDh07J1hAYzLJf8fc4N+vRehD9HNz33rkwPOYaJUrvcT
         UaPw+mwNz1P5BQa7JuQWP597kS8SMoiVBJrWOGk12oHQSxx7LFswo3evi5e6cWL8dUcf
         d5Cg==
X-Gm-Message-State: AOJu0YxgWTRH+T4C1fFjuBmw2HE05XHH4LXXUF5mEMdcVR7Zm+Y6u2kx
	tDVcX5olbMt6j4z072Q/FcNKwc/5AFYphTV+xnCYE2quocLQ64G9J86nVhRxE3Zl8hnlrzxOSJL
	Sgd82ASsZ5mEhvUn6vUDDZKfM4gc=
X-Google-Smtp-Source: AGHT+IH6LOXn13ipdIpW4SIqlXEyTWMBJaNYITUCqWHcgrMdANI+2pBZexGwAlgpnStWL9UFhgm2LGtNeeGTCEpW+Pg=
X-Received: by 2002:a17:90a:e38c:b0:2d8:b205:2345 with SMTP id
 98e67ed59e1d1-2e18481a960mr4368306a91.23.1727884321416; Wed, 02 Oct 2024
 08:52:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Zichen Xie <zichenxie0106@gmail.com>
Date: Wed, 2 Oct 2024 10:51:52 -0500
Message-ID: <CANdh5G7KBdzVcyrf5dPG2fbXQ5KCzr0LXu_p38H2-Cd4_FNsxw@mail.gmail.com>
Subject: net/hsr: Question about hsr_port_get_hsr() and possbile null-pointer-dereference
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, lukma@denx.de, 
	aleksander.lobakin@intel.com, n.zhandarovich@fintech.ru, ricardo@marliere.net, 
	m-karicheri2@ti.com
Cc: netdev@vger.kernel.org, Zijie Zhao <zzjas98@gmail.com>, 
	Chenyuan Yang <chenyuan0y@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Dear Developers for NETWORKING [GENERAL],

We are curious about the function hsr_port_get_hsr().
The function may return NULL when it cannot find a corresponding port.
But there is no NULL check in hsr_check_carrier_and_operstate() here:
https://elixir.bootlin.com/linux/v6.12-rc1/source/net/hsr/hsr_device.c#L93
The relevant code is:
```
master = hsr_port_get_hsr(hsr, HSR_PT_MASTER);
/* netif_stacked_transfer_operstate() cannot be used here since
* it doesn't set IF_OPER_LOWERLAYERDOWN (?)
*/
has_carrier = hsr_check_carrier(master);
hsr_set_operstate(master, has_carrier);
hsr_check_announce(master->dev);
```
There may be possible NULL Pointer Dereference.
However, in hsr_dev_xmit() the NULL checker exists.
```
master = hsr_port_get_hsr(hsr, HSR_PT_MASTER);
if (master) {
skb->dev = master->dev;
skb_reset_mac_header(skb);
skb_reset_mac_len(skb);
spin_lock_bh(&hsr->seqnr_lock);
hsr_forward_skb(skb, master);
spin_unlock_bh(&hsr->seqnr_lock);
} else {
dev_core_stats_tx_dropped_inc(dev);
dev_kfree_skb_any(skb);
}
```
So we are curious if this NULL check is necessary. The function
hsr_port_get_hsr() is called several times, but NULL checks seem to
exist occasionally.

Please kindly correct us if we missed any key information. Looking
forward to your response!

Best,
Zichen

