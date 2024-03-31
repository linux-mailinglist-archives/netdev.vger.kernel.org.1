Return-Path: <netdev+bounces-83686-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31312893574
	for <lists+netdev@lfdr.de>; Sun, 31 Mar 2024 20:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FA99282041
	for <lists+netdev@lfdr.de>; Sun, 31 Mar 2024 18:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F330146D49;
	Sun, 31 Mar 2024 18:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FSwuYCM+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96AA214430E
	for <netdev@vger.kernel.org>; Sun, 31 Mar 2024 18:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711911133; cv=none; b=mrsUP3ldcdPEKMJezL0uEvkd+fwutw8xahpGMS7KxAHI0HVqlvDuQj6jpqKINZPW6rb+BFW/ZdrvvFISBwJoxwM85xueHPoE/qIiI+0KgVpt7orc68n26wR9Xq+ZKRFXxamr9GLQoWHOgWdHa7v2pZNvy8txaqKScyTBgOO5rbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711911133; c=relaxed/simple;
	bh=Cani6to3UjHzeXHQNNKD1CkRKn1f0WiKSoOsz37nhyU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nle1gDfAC6wZpwWLDOFoFeY9xu4SB8m0rKVaTmvxnDfApZoI+GDu0ndIKEIefX0lp5mD0vkVs5eCHySca59HvRlnPFeOK1GmczXAl+8oQzk0AklGbisIAcPOKoK4zE2Pdx1I1DybXpUSkLZKWbdEbdK+VPQ23JgY/C/E7iiCsjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FSwuYCM+; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-34005b5927eso2630635f8f.1
        for <netdev@vger.kernel.org>; Sun, 31 Mar 2024 11:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711911130; x=1712515930; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j9Izg/EBEx0o13Szorrfhcc9j42L/Bu5maJxbAyaQWg=;
        b=FSwuYCM+M4qDV0TF9D74nF/srbIRtqMrMTwO4c0FpcxgesoJzTmT4l7y5FmOsM4sv3
         YsxqThNHd8Xx5/Yo+oMvEtCfGhoyRgCbu3OzuCKW7TatvFT23YDuLefNZA//IzvtlyHO
         FPQEfFLaQhk0xAQMLZimyMsgTjGW0FPc0LIgE5ZP/uQOog+SZF4uKQbLLQS/tWEkQmc7
         mvIh6O2Zk6jqqloVysxHG28swZ8OuV8iDKyKI7ACT0r5mQQRXLDkQevY5cmZqMBjAcvq
         XIr1ieCxic0zndGIfERtDPLvu200d0XUaJmtuFCGV/9QP/dqDnzRuuf+3bmti11IuGRG
         aTrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711911130; x=1712515930;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j9Izg/EBEx0o13Szorrfhcc9j42L/Bu5maJxbAyaQWg=;
        b=aYQFEkPCEKv7PTqKskN7nWgyTSfAEB1+JmuXDQYwCW2lesgSEKPxLYv19CTuEgzHyY
         S6qIQA4kLtVUTCYZxcJJ6mTD9fyglQdafKRq/eREFY32ZG9ShmbxBFhIGv7y82H3iA6r
         eXtAu714oUVkgTp+FUN1bCEi5AIiQMGdP/V/WUzDO5EXFXrAE4SOlXN2XpFywQc3EEXM
         8DMBpiX7xzGmQMyW66RTQabdADxof93URodU5tFUuYQHfcjXsfDCeydVFvIx2ViQAthh
         UcA7NBBU1GTvqtby5CrRUvTHMlbF/e6U5ZXR+DOEpPWIbaH5uoMzqHd75lMIDZilAYJY
         iiYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWoZYxGhp+z5fVuiJnfLj8ev0QUYNgjQoVJdK4ZnVDi3rFcZjF4k66UILzL6MThN6H/uErnRYgRsTl5v8Gsf8KMnyF1aUn
X-Gm-Message-State: AOJu0Yy03MrTLCjG4J3bs/hnR2LJ8/rcT+DTTHXIqooPMFNrCo05YAX6
	VmOHbAQM5vYzw6be3XDEKfYUKY5Ua8/WU6xIprDzuRwUuhKR+sow
X-Google-Smtp-Source: AGHT+IGYVT7MF0ypohlh5j+qvG5oNU8lJHD0eTmbvgjjS6WSUl9rdWOum+M3uh3TSSyWdc2AlsMfyw==
X-Received: by 2002:a05:6000:1568:b0:343:3a51:ad65 with SMTP id 8-20020a056000156800b003433a51ad65mr4507960wrz.38.1711911129534;
        Sun, 31 Mar 2024 11:52:09 -0700 (PDT)
Received: from [172.27.19.119] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id l3-20020a5d5603000000b0033e03d37685sm9492891wrv.55.2024.03.31.11.52.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Mar 2024 11:52:09 -0700 (PDT)
Message-ID: <e32e34b7-df22-4ff8-a2e4-04e2caaf489f@gmail.com>
Date: Sun, 31 Mar 2024 21:52:06 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 5/8] net/mlx5e: Expose the VF/SF RX drop counter
 on the representor
To: Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>
Cc: Tariq Toukan <tariqt@nvidia.com>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
 Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>,
 Leon Romanovsky <leonro@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>,
 Aya Levin <ayal@nvidia.com>
References: <20240326222022.27926-1-tariqt@nvidia.com>
 <20240326222022.27926-6-tariqt@nvidia.com>
 <20240328111831.GA403975@kernel.org> <20240328092132.47877242@kernel.org>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20240328092132.47877242@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 28/03/2024 18:21, Jakub Kicinski wrote:
> On Thu, 28 Mar 2024 11:18:31 +0000 Simon Horman wrote:
>>> The "rx_vport_out_of_buffer" equals the sum of all
>>> Q counters out_of_buffer values allocated on the VF/SF.
>>
>> Hi Carolina and Tariq,
>>
>> I am wondering if any consideration was given to making this
>> a generic counter. Buffer exhaustion sounds like something that
>> other NICs may report too.
> 
> I think it's basically rx_missed_errors from rtnl_link_stats64.
> mlx5 doesn't currently report it at all, AFAICT.
> 

We expose it in ethtool stats.
Note that the "local" RX buffer exhaustion counter exists for a long time.

Here we introduce in the representor kind of a "remote" version of the 
counter, to help providers monitor RX drops that occur in the customers' 
side.

It follows the local counter hence currently it is not generic.

