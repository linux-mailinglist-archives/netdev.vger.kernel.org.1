Return-Path: <netdev+bounces-93552-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A16CA8BC4E9
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 02:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EBE71F21B23
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 00:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A339C1FB5;
	Mon,  6 May 2024 00:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="ktqWdGqZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608905250
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 00:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714955911; cv=none; b=GigUYuezGo6J/27eUL8I2nT9I0Vqn43CBg8fal6XJsDXOWFj7vr9QRPOI1sU7lYlPd8rR0X17u8mCGkkMeS7DUWO9giery59dE9ceqMFvkUnOLRDu0GXLdJ896OXcOD3bj1h/H3mNEQWhG1Q0s6ffkPfsWWFEQC35RhQhhKyozY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714955911; c=relaxed/simple;
	bh=beqKxYWPBJC2s8wsYtanUAVCdpzI3vAvjcj9DP/JA6k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r308Mrw3/vb9EnZCtFB1yGsRYZgfk/mgrkAz3jcaLAfH+g6iAy5BO/Y2WICljzkeLQ1HlIEemCzfA64CUlV53repgVWvQUPkrVq5XE1GP5mX57DCjga6nj1gplRUNbpcdfHW6O2WcqY1HgW9ygk11Ug//xh9xfzikSZjQ8mJhp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=ktqWdGqZ; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1eb24e3a2d9so13725495ad.1
        for <netdev@vger.kernel.org>; Sun, 05 May 2024 17:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1714955910; x=1715560710; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VFPN+3ALEbluXfIJgJeZYVIM398iAJFPEplhb56EgAA=;
        b=ktqWdGqZvgHIDQaAkLTEKUDTNFRK3U8PwdM21FdOJurrHbP6bR3T3F6eLrkDm+6Wvg
         5M2eKlcRdIYdFUlWrnStatHvp5w02V+IW5grs7xsRk0piMU9UyPHcS86BtcsFm1eCcRq
         G8C+5MrI59H+oyBKbA73Led1h2pI+pTYWVJ9NP001nV/bQ5KrefR7X0w8xniLqhZ4z1d
         pfvLP/eldX46hzVSqVe3AIyrfQe4se4Icb4mjkoqD0pkM/FGMoAE1wZLZJvGkorIc2Je
         iO9v58qmtOHq6OBZ8vgm3GZ8QDtVZ9pkAbv6SQMNEwSaVSn/vqIJwE5iXL+0fUgNrHEr
         YagQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714955910; x=1715560710;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VFPN+3ALEbluXfIJgJeZYVIM398iAJFPEplhb56EgAA=;
        b=D0E69W02Dr1ujW1+TMwSJU1ZOkI2a8QlTel0NBBniQYZoCFEZuy2GFF+rWoWiDwe2I
         wA/9G1satYRtw4njNERyL1xFfWkfmtuvbf3oCPt6TOYA6kl9dfeoXEqhhUsiYI44BZVR
         djc1gYQ/iryU899FQYi3s6k1BP+WCRaWE5fYj4vwOWeN/4kKp+h6MkZJikIGAmWomnND
         G2qB3xk6WRM9XlDx3ozYiDCmQ6dbeKfRjFqyUXrxu99AazatOnWkaPIAk1jA3JBrD6b0
         xzPN+OGoLIP0JbV5WRFrgVWftqz8AfiAwT2iwuRHnRndTHUbv7KSuFa5/PrYprAgO8uL
         kBOw==
X-Gm-Message-State: AOJu0YzeTzjYFFHbLDLvMxfALqed4IIvxPC4Bn3ajwhdSF/PeYjk9nHQ
	YMkrxbU/9+dcoG44azaSplXrT7O7WtOJPREWkR/buG+ZoLcK2so0xq4KGiHFA6E=
X-Google-Smtp-Source: AGHT+IHLdP9wneMOTBnPtCrE7OLWXl7lPHPWqDaE6hKCgYhj0ugIA80p65r+2NGztKLG1EPHg/HpEQ==
X-Received: by 2002:a17:903:595:b0:1e8:5dc6:4060 with SMTP id jv21-20020a170903059500b001e85dc64060mr9677574plb.33.1714955909674;
        Sun, 05 May 2024 17:38:29 -0700 (PDT)
Received: from [192.168.1.15] (174-21-160-85.tukw.qwest.net. [174.21.160.85])
        by smtp.gmail.com with ESMTPSA id d6-20020a170902654600b001e668d0d6b1sm7156097pln.127.2024.05.05.17.38.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 May 2024 17:38:29 -0700 (PDT)
Message-ID: <0013632d-76f0-4480-b7b5-601c0d8e3041@davidwei.uk>
Date: Sun, 5 May 2024 17:38:28 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next v2 3/9] netdev: add netdev_rx_queue_restart()
Content-Language: en-GB
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>,
 Andy Gospodarek <andrew.gospodarek@broadcom.com>,
 Adrian Alvarado <adrian.alvarado@broadcom.com>,
 Shailend Chand <shailend@google.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>
References: <20240502045410.3524155-1-dw@davidwei.uk>
 <20240502045410.3524155-4-dw@davidwei.uk>
 <CAHS8izOALLb+g7CiGt0MRHOG-GZv16eDNZJSD-JQcm7FK3rGrw@mail.gmail.com>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <CAHS8izOALLb+g7CiGt0MRHOG-GZv16eDNZJSD-JQcm7FK3rGrw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024-05-02 10:27, Mina Almasry wrote:
> On Wed, May 1, 2024 at 9:54 PM David Wei <dw@davidwei.uk> wrote:
>>

...

>> +int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq)
>> +{
>> +       void *new_mem;
>> +       void *old_mem;
>> +       int err;
>> +
>> +       if (!dev->queue_mgmt_ops->ndo_queue_stop ||
>> +           !dev->queue_mgmt_ops->ndo_queue_mem_free ||
>> +           !dev->queue_mgmt_ops->ndo_queue_mem_alloc ||
>> +           !dev->queue_mgmt_ops->ndo_queue_start)
>> +               return -EOPNOTSUPP;
>> +
>> +       new_mem = dev->queue_mgmt_ops->ndo_queue_mem_alloc(dev, rxq);
>> +       if (!new_mem)
>> +               return -ENOMEM;
>> +
>> +       rtnl_lock();
>> +       err = dev->queue_mgmt_ops->ndo_queue_stop(dev, rxq, &old_mem);
>> +       if (err)
>> +               goto err_free_new_mem;
>> +
>> +       err = dev->queue_mgmt_ops->ndo_queue_start(dev, rxq, new_mem);
>> +       if (err)
>> +               goto err_start_queue;
>> +       rtnl_unlock();
>> +
>> +       dev->queue_mgmt_ops->ndo_queue_mem_free(dev, old_mem);
>> +
>> +       return 0;
>> +
>> +err_start_queue:
>> +       /* Restarting the queue with old_mem should be successful as we haven't
>> +        * changed any of the queue configuration, and there is not much we can
>> +        * do to recover from a failure here.
>> +        *
>> +        * WARN if the we fail to recover the old rx queue, and at least free
>> +        * old_mem so we don't also leak that.
>> +        */
>> +       if (dev->queue_mgmt_ops->ndo_queue_start(dev, rxq, old_mem)) {
>> +               WARN(1,
>> +                    "Failed to restart old queue in error path. RX queue %d may be unhealthy.",
>> +                    rxq);
>> +               dev->queue_mgmt_ops->ndo_queue_mem_free(dev, &old_mem);
>> +       }
>> +
>> +err_free_new_mem:
>> +       dev->queue_mgmt_ops->ndo_queue_mem_free(dev, new_mem);
>> +       rtnl_unlock();
>> +
>> +       return err;
>> +}
> 
> The function looks good to me. It's very similar to what we are doing with GVE.
> 
>> +EXPORT_SYMBOL_GPL(netdev_rx_queue_restart);
> 
> I would still prefer not to export this, unless necessary, and it
> seems it's not at the moment (we only need to call it from core net
> and core io uring which doesn't need an export).
> 
> Unexporting later, as far as my primitive understanding goes, is maybe
> tricky because it may break out of tree drivers that decided to call
> this. I don't feel strongly about unexporting, but someone else may.

Sorry, I didn't mean to ignore you, I forgot to do it. :(

I'll change it for the next series.

