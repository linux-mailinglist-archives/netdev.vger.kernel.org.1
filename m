Return-Path: <netdev+bounces-173937-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32079A5C45C
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 16:01:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED3151898208
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 15:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E43225DAE3;
	Tue, 11 Mar 2025 15:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CeOmKaeT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F1D249F9
	for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 15:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741705302; cv=none; b=eC7fJEn81Yz9WnXHA+zH/jzfEoocA21ZCUOqUSNEa4TLc/iFCF/JMCVe5apLBpXiaflyPNiYRnwWd6CQVBB1HOXc1fkKdMRxjCE7mWp4ZUAP3SLGr2sHkPuKZ9E8KM7VkTtPMREj0n+EEtHAIQ4Pu072hXfUMfvww0bLel5juT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741705302; c=relaxed/simple;
	bh=7wuGKhp7tPgJHeyYTTAoedpr2I5OZMCzTfJnAMSnFZM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=FhuxT72CiV0Jqodksg2OQQnx1FEWIaaIgd1rQem/7pyXu2fAYH+hk2PST/0+K3oEJNtDn0s2/5wP0q6RIv6jO+q9RaUaCA2FMobxWdb7ZWVqprlWPecSc0lBo+ue9k/mLAOjJQ56W7o1SaerjhWmQOu5Eis/fbav0VmO3zxGWow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CeOmKaeT; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3911748893aso3406481f8f.3
        for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 08:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741705299; x=1742310099; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+6N6IHuFiE1oIlwD8C56mu8umqZmcXA8wSz/yC3jK+U=;
        b=CeOmKaeTQkvFL50eTW3fOpckBFbjq0xfWGPA6nmfIjAPONuAhii54YtBRSVhkCac6Z
         aqX2FhNSQvflohT+uncx6isnj4PzojfcDmu3tH9bT5C4Th34sXYn+Z4zcUO+hIs6yGAG
         dQrpUHkvL1sr5+cSovGXjXB4FPCVYfcEKWDs3v5eph+swpA5uNsPrd/zy/gC0vkhrRuU
         Tq0lRzpJOEXKUxRyE15INv9Pp0hZUOu5Q2aUGD3n13vp6frgo3s0hGevLYDv5tCb567Z
         RViQ0SmwuDjQLp9oas00fendlJAfMCuuxIWBObe/bPttUEoqxnh94iZ184IbyTa8U2gV
         eP4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741705299; x=1742310099;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+6N6IHuFiE1oIlwD8C56mu8umqZmcXA8wSz/yC3jK+U=;
        b=iRi/+Hae6BIAgS/urWtL06O3UhhDmsKO4UUL1SNTiOn8q0vsG08mDfXzlDUPlIqBZt
         Eg0b4suieckKcOdnp9M6+71VqVrCDTKu18fp1UhPdjsXrQGEHKI82kMWUjWJbrFY1hzB
         OLRIMgCuh7hemPY5lnv740l7qPvRnmOcPECcMQ9m40prM97GeTWUxK8egb7yBdw3UWYK
         b20egXWnIV4AzQlJlyNDpzrzZa4qfwlXvtn39OP/hPwyLkJ3GraXwylSMTo06maikicr
         X0pYA7zWkjBBI4VAPqcswj2Vy5erzgCl9nqFqjJriozMJDGn5/ZCc3QQJLO/lMrHMQz8
         XULA==
X-Gm-Message-State: AOJu0Ywl+AyqaklHvxvxhFNgF1/pjDA0FbcSy4iuvOO5mRWBw7XSMnAV
	0qLJVG41V2L7HjbMTAsy+Y29YkO+E5KHim2TyyifFHaBxgDrhG/lOI+mP2Qt1rE=
X-Gm-Gg: ASbGncsAPVcEVLKc1+txVPfrlozysGbRMGAHS5IRa+RG1XnCga8gSpA8bHiujRVQGAY
	c7HT8mOtEwbY2YNwAUFF83ps+1INfb9jNn66xrU5Ip/Zz1Dw+NFSpkH9OaXgDihLdR9T0/4EkCj
	ZW05P+HUZhzl7MseVawzrMLWibsFs2sGJuddAuiyzZrPYQYO2bFdDv0qQ/rd+AiYUl8U1sYgBe8
	0kUT8Rlivhb9Mok5KAygfWGkvpgBO1zkdtJHRWjBeuh5OkU/NbkoFwJBA+qibL7g1e/gafq4ebL
	mDDXFlKcJQEvkpIU1IVHsepuJ+oN+8lpSQCL+iV08K+BWQ0Scg==
X-Google-Smtp-Source: AGHT+IG5JHAt5M00RK6so4oCI1Rd9NaZq82laBkVPXtIXJAI94ie1Fae5BdFLqYl+2j2hV4O4XYaeQ==
X-Received: by 2002:a5d:59a7:0:b0:391:1139:2653 with SMTP id ffacd0b85a97d-39132de145bmr14966138f8f.52.1741705297414;
        Tue, 11 Mar 2025 08:01:37 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3912c0e4065sm18620738f8f.62.2025.03.11.08.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 08:01:36 -0700 (PDT)
Date: Tue, 11 Mar 2025 18:01:33 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Dimitris Michailidis <d.michailidis@fungible.com>
Cc: netdev@vger.kernel.org
Subject: [bug report] net/funeth: probing and netdev ops
Message-ID: <ec0b7b3e-0d69-4fa7-bfd2-b3b110fe237d@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Dimitris Michailidis,

Commit ee6373ddf3a9 ("net/funeth: probing and netdev ops") from Feb
24, 2022 (linux-next), leads to the following Smatch static checker
warning:

	drivers/net/ethernet/fungible/funeth/funeth_main.c:333 fun_alloc_queue_irqs()
	warn: 'irq' can also be NULL

drivers/net/ethernet/fungible/funeth/funeth_main.c
    319 static int fun_alloc_queue_irqs(struct net_device *dev, unsigned int ntx,
    320                                 unsigned int nrx)
    321 {
    322         struct funeth_priv *fp = netdev_priv(dev);
    323         int node = dev_to_node(&fp->pdev->dev);
    324         struct fun_irq *irq;
    325         unsigned int i;
    326 
    327         for (i = fp->num_tx_irqs; i < ntx; i++) {
    328                 irq = fun_alloc_qirq(fp, i, node, 0);
                               ^^^^^^^^^^^^^
The fun_alloc_qirq() function can return NULL.

    329                 if (IS_ERR(irq))
    330                         return PTR_ERR(irq);
    331 
    332                 fp->num_tx_irqs++;
--> 333                 netif_napi_add_tx(dev, &irq->napi, fun_txq_napi_poll);
    334         }
    335 

The problem is this:

   249  static struct fun_irq *fun_alloc_qirq(struct funeth_priv *fp, unsigned int idx,
   250                                        int node, unsigned int xa_idx_offset)
   251  {
   252          struct fun_irq *irq;
   253          int cpu, res;
   254  
   255          cpu = cpumask_local_spread(idx, node);
   256          node = cpu_to_mem(cpu);
   257  
   258          irq = kzalloc_node(sizeof(*irq), GFP_KERNEL, node);
   259          if (!irq)
   260                  return ERR_PTR(-ENOMEM);
   261  
   262          res = fun_reserve_irqs(fp->fdev, 1, &irq->irq_idx);
   263          if (res != 1)
   264                  goto free_irq;

The error code is not set on this path.  This is the only caller.  Why not
modify fun_reserve_irqs() to just return zero on success and negative
failures?  Are we likely to need the current API in the near future?

   265  
   266          res = xa_insert(&fp->irqs, idx + xa_idx_offset, irq, GFP_KERNEL);
   267          if (res)
   268                  goto release_irq;
   269  
   270          irq->irq = pci_irq_vector(fp->pdev, irq->irq_idx);
   271          cpumask_set_cpu(cpu, &irq->affinity_mask);
   272          irq->aff_notify.notify = fun_irq_aff_notify;
   273          irq->aff_notify.release = fun_irq_aff_release;
   274          irq->state = FUN_IRQ_INIT;
   275          return irq;
   276  
   277  release_irq:
   278          fun_release_irqs(fp->fdev, 1, &irq->irq_idx);
   279  free_irq:
   280          kfree(irq);
   281          return ERR_PTR(res);
   282  }

regards,
dan carpenter

