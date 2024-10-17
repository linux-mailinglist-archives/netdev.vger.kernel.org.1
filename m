Return-Path: <netdev+bounces-136591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFBAE9A2426
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 15:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66EAE1F21664
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 13:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31C21DDC15;
	Thu, 17 Oct 2024 13:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HTBf8bQq"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164471DDC13
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 13:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729172588; cv=none; b=RPye5t3lG5a9UxxaRY0kTM7BuyDxJbzBM7ozzkYK0dq+q9KMk26VUqoKSZl5hAbA+tA08QpIkt7iA6sjVIBygmqt5lLYtziZTedRghpHLgjcSTOhCbnaQmGa9bzRS4EO2FAp4MGHGBO5N3iyJ4anLHDDiEfCQbBEivPBBG7i3PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729172588; c=relaxed/simple;
	bh=KZ+DDTai52HEjeRdNqB4qNF1N8g+/cqxevuiRsuabDU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Agm957fE2E9AWZuca5dRqWFwMWR6CYVOj1PsrVk7PVgOFkD+LZYvEO9F/zLPsxmJ/10GehAQVHGEuGtCGqDcq1MI/54v50cRzYTEjcqiT4GXJYS2vr7dgQ2nOX2Z7u+dUNE1gG3QGL+m+RT15abAz8+lDYQb51a5LkUzNTkKcls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HTBf8bQq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729172585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wyp/GRBR8xPGOtCYjjOBwoc4l6FYiJIRBvxKC1/fE/8=;
	b=HTBf8bQqZ3CfmKs7Ml+Y1xqtT5wUDxNENhHpSmljFULMLxaSMsCMP6cTSh3JEgawWELka5
	Pvs18Q2gAW9sX0RVkXZxfygkmQZnCOmMGFPHxooci0If5n84ttEw50toED7aVuuhncNuNQ
	LA5kZtEZ6JSXsuP/0nnxngwC+nu3Las=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-yPCyir1pOGq4lp2xkyCohg-1; Thu, 17 Oct 2024 09:43:03 -0400
X-MC-Unique: yPCyir1pOGq4lp2xkyCohg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-37d3e8dccc9so509090f8f.1
        for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 06:43:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729172582; x=1729777382;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wyp/GRBR8xPGOtCYjjOBwoc4l6FYiJIRBvxKC1/fE/8=;
        b=GS5z/Xqp0rmPpP1aVHTjwjr5d6x1VuYA0zgh8kdPuD3nziMA0VqzdXN7Z5Z+8jkuWb
         45NoOXhKlMvIvokERwK9yfr65Jot6p0N8duU1g3W7vTXMoVM4hOfPw9/gEbc/6YkbaZA
         qasKs6iJba8/mHwDlVPDzppVw6rK+GRMTMbooNqE6t2fp/a2LSRxOthfo+VnSfOwBOtM
         cfCBCjPjbxoHgjcw2X2AHwYM32vTKuJvsDX15WbSQN1LtcXAWarClxpS36cJZ0qE7+r9
         duIEB/29HhsR/2TbsPdjhQ2OTXC83K4um6TZOe+PSFpBRHfmdOoeFiBGQ+YUwgrxVEUe
         lKzA==
X-Forwarded-Encrypted: i=1; AJvYcCU8Au2DAWfn0+y7Inr/RtrVpVELLlfF4IAa0jWGC+7VZy4AoVZENuB5h+Jrm1p4uSXCLY6d8Mg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4bi36hmh00es2pamFLY3gUbgaTlEK2Q4nSfy4/SzXhBulE6Og
	ov6rGfad98FjlFQx5+5lHmjtRoVzJB7v099+tFL0gACgAlkCgoNcUowwc8zBY+qy001yDQ0pehw
	HUOSGcjTGxa6qXH3bb3mOQlH9X8Gq2ne/pSjqIJqig+qDk4M/6DOBiQ==
X-Received: by 2002:adf:ea49:0:b0:37d:5035:451 with SMTP id ffacd0b85a97d-37d55199194mr16836166f8f.10.1729172582113;
        Thu, 17 Oct 2024 06:43:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGR8cTr4aAwVoN++OeqwrgM43zxkxe6ACzmvgpcylM7pD/wNRhitVc+bDaNXzucsy+xSzBU1Q==
X-Received: by 2002:adf:ea49:0:b0:37d:5035:451 with SMTP id ffacd0b85a97d-37d55199194mr16836136f8f.10.1729172581647;
        Thu, 17 Oct 2024 06:43:01 -0700 (PDT)
Received: from [192.168.88.248] (146-241-63-201.dyn.eolo.it. [146.241.63.201])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43158c50c43sm26996795e9.42.2024.10.17.06.43.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Oct 2024 06:43:01 -0700 (PDT)
Message-ID: <6aaee824-a5df-42a4-b35e-e89756471084@redhat.com>
Date: Thu, 17 Oct 2024 15:42:59 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] virtio-net: fix overflow inside virtnet_rq_alloc
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, virtualization@lists.linux.dev,
 Si-Wei Liu <si-wei.liu@oracle.com>
References: <20241014031234.7659-1-xuanzhuo@linux.alibaba.com>
 <20241014031234.7659-2-xuanzhuo@linux.alibaba.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241014031234.7659-2-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/14/24 05:12, Xuan Zhuo wrote:
> When the frag just got a page, then may lead to regression on VM.
> Specially if the sysctl net.core.high_order_alloc_disable value is 1,
> then the frag always get a page when do refill.
> 
> Which could see reliable crashes or scp failure (scp a file 100M in size
> to VM):
> 
> The issue is that the virtnet_rq_dma takes up 16 bytes at the beginning
> of a new frag. When the frag size is larger than PAGE_SIZE,
> everything is fine. However, if the frag is only one page and the
> total size of the buffer and virtnet_rq_dma is larger than one page, an
> overflow may occur.
> 
> Here, when the frag size is not enough, we reduce the buffer len to fix
> this problem.
> 
> Fixes: f9dac92ba908 ("virtio_ring: enable premapped mode whatever use_dma_api")
> Reported-by: "Si-Wei Liu" <si-wei.liu@oracle.com>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

This looks like a fix that should target the net tree, but the following 
patches looks like net-next material. Any special reason to bundle them 
together?

Also, please explicitly include the the target tree in the subj on next 
submissions, thanks!

Paolo


