Return-Path: <netdev+bounces-118817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B65952D82
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 13:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAEA51C24C19
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 11:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDBE01714C4;
	Thu, 15 Aug 2024 11:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LvXdQuIk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA4614A084
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 11:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723721386; cv=none; b=KqAQ43/O9URqYb4Sh3mCuKlTIpg+dMMo0H6B0wAbIBf1ec+k3zv5bCnpxNA/SAMeg4+/jxK1zXMTbapCmLU5OOHgGnkeBdPw/8CqCXVVX/89XMT8KXlOJX3oLYJNmcyyj1viOr+fIqPnNgsGI6DgYpUQjwChcmxHjIL4cot5KUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723721386; c=relaxed/simple;
	bh=DqyqdYabPh0aw25x8ckVUskslZZoaj5FjvZVX9VZAqc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WhHoIjfTBBnw85mUAr/8dboX+dMSXLzwIrUlTAnmsy5Y1Ot76w/TA7R0WAp9FlpENih8Ztx0WH6UdCAmCeP6Luo7DUTNN4lHgV76Bppdb1q8da7MUXsNHf5UpB5VvCSEZVg/ItPqv9fPddjrd6tYobgRAPlP4+z58pby2+BB5qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LvXdQuIk; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52efd08e6d9so959077e87.1
        for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 04:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723721383; x=1724326183; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2KeTly4BwT7ZPFxX/n2y0xZHyT72zEKqHO6v/pZeCyg=;
        b=LvXdQuIkAfEFw/laVw+eWFDEDntGJ9jPfw1ip0cCKpqvkaUIdAvDuQWe4wwfjNebmZ
         zGC6TmpLAiqo1u1MV9b11YKMMFdZ79dqISH7GxZSG5Dc8zEXSZkf7YVQ1eBHL/GQ6gG5
         MIFP87zTlzz/MVJdz0GlI3yVcSJLkMvYmiJ/msm6j6z7bbJbim7xWTNsr4IuhPuTO2xD
         xtzShdgl5PvDrEJTNrU9E0i3ppmWkBQ208dd/bMHzMcqm3M4sojTvc842HBOKndUhJZn
         72uVYPN5ghlZHSQesrYgT4km2xM6fFg95zJ7mKz9lzazJSxKpibmjnZcDnPkOh62T4e8
         u0uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723721383; x=1724326183;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2KeTly4BwT7ZPFxX/n2y0xZHyT72zEKqHO6v/pZeCyg=;
        b=RAmcOqiTYUk1kgG4JNhtHbxRSnfNmvIagDwQ0+XFRbQLSAH6MjCg3ax0ClXxZrCxlQ
         nA36E8LH10iaoUMfq6KfPiFgmaJC+GjlGVkflgo27+d3VXj+iu4fy5FGaQ2Y1CJlU4gl
         wc8lcHN2UpwUUOYFeEfb0vCdu5oIuHJDWrnjA730X0ora6AHAL3SHIdBFjcSw1w5qLf7
         cwRGShUm6X5MIf37KLBv+DVmU8P8IsdTQ/sX4oHDWqf6oS8v6hiWjU+isbj1yL2AGcTK
         M9bq7yKHerzLe5kPUcg7qSMT+TIRLYSEK9FJYJ/P3nb3567mqjFKV9C6d2g+1KWnkOL0
         nZ7A==
X-Gm-Message-State: AOJu0YxBHlDYJoDsr9Ug4VT2rXb8bWjmmWRi20JoA+pycLL8Ke7iG2dD
	7zW1Rae4J+SU3ztfiG7uyqrt7bIPI2UNG9mR664siSKPjZ47pZx5x4kp9ssK8pI=
X-Google-Smtp-Source: AGHT+IExJuXfh2ykDB8bAO26usfZV0AiJ4tDFs1cOp8MDNbpXrpQ4S+JWLJJ8GB2MHwEtJ9+6d+BhQ==
X-Received: by 2002:a05:6512:158d:b0:52e:768e:4d1f with SMTP id 2adb3069b0e04-532eda8e172mr3990568e87.36.1723721382727;
        Thu, 15 Aug 2024 04:29:42 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37189849818sm1270999f8f.33.2024.08.15.04.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 04:29:42 -0700 (PDT)
Date: Thu, 15 Aug 2024 14:29:38 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Dimitris Michailidis <d.michailidis@fungible.com>
Cc: netdev@vger.kernel.org
Subject: [bug report] net/funeth: probing and netdev ops
Message-ID: <f9fa829d-2580-4b49-b0c6-cf2e2a8f6cac@stanley.mountain>
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

	drivers/net/ethernet/fungible/funeth/funeth_main.c:475 fun_free_rings()
	warn: 'rxqs' was already freed. (line 472)

drivers/net/ethernet/fungible/funeth/funeth_main.c
    441 static void fun_free_rings(struct net_device *netdev, struct fun_qset *qset)
    442 {
    443         struct funeth_priv *fp = netdev_priv(netdev);
    444         struct funeth_txq **xdpqs = qset->xdpqs;
    445         struct funeth_rxq **rxqs = qset->rxqs;
    446 
    447         /* qset may not specify any queues to operate on. In that case the
    448          * currently installed queues are implied.
    449          */
    450         if (!rxqs) {
    451                 rxqs = rtnl_dereference(fp->rxqs);
    452                 xdpqs = rtnl_dereference(fp->xdpqs);
    453                 qset->txqs = fp->txqs;
    454                 qset->nrxqs = netdev->real_num_rx_queues;
    455                 qset->ntxqs = netdev->real_num_tx_queues;
    456                 qset->nxdpqs = fp->num_xdpqs;
    457         }
    458         if (!rxqs)
    459                 return;
    460 
    461         if (rxqs == rtnl_dereference(fp->rxqs)) {
    462                 rcu_assign_pointer(fp->rxqs, NULL);
    463                 rcu_assign_pointer(fp->xdpqs, NULL);
    464                 synchronize_net();
    465                 fp->txqs = NULL;
    466         }
    467 
    468         free_rxqs(rxqs, qset->nrxqs, qset->rxq_start, qset->state);
    469         free_txqs(qset->txqs, qset->ntxqs, qset->txq_start, qset->state);
    470         free_xdpqs(xdpqs, qset->nxdpqs, qset->xdpq_start, qset->state);
    471         if (qset->state == FUN_QSTATE_DESTROYED)
    472                 kfree(rxqs);
                        ^^^^^^^^^^^
Freed.

    473 
    474         /* Tell the caller which queues were operated on. */
--> 475         qset->rxqs = rxqs;
                             ^^^^^
why are we saving a freed pointer?

    476         qset->xdpqs = xdpqs;
    477 }

regards,
dan carpenter

