Return-Path: <netdev+bounces-192907-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E3B9AC1996
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 03:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0B3F3BED82
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 01:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D08121B9C2;
	Fri, 23 May 2025 01:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f+BJI7a9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4971421B9C8;
	Fri, 23 May 2025 01:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747962792; cv=none; b=Co6h9gHuWO8yLw+ilp1LoCp7wWMFaXzyR9G1ULQFQvm/5SglsB0Z219s/knAQa9hraIe4wfaMvgV5qinGnZgrdFEdnReBGqtPCX78Y513cSp5GmRcgF0mx8TyOkXTDKNTFcy3SWEgQu7bSzcpB7B8KIh4Cvy827WYIdBEHqXfsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747962792; c=relaxed/simple;
	bh=LOvFzs/T3i4wRAI9d7REZh0re65ylVe+GMKFnPVLcoM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mT4u/88G3WDoQjXnzf2PLZ6dThh/GuiZtzAZ1QRUcTZ/cIzHcdPuhMnAY6rYO265gWrA6+gLJrU4QHqmtHGBMWZu+oojWb1OMcZfalJsB71YzzAAhrO7ZxvVR+mZKPBQZzBEa0ceXyKj6BSq0m2BzBm/pOkGG9AkoXPBRUAbsKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f+BJI7a9; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a4bdee0bf7so984773f8f.1;
        Thu, 22 May 2025 18:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747962789; x=1748567589; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LOvFzs/T3i4wRAI9d7REZh0re65ylVe+GMKFnPVLcoM=;
        b=f+BJI7a9FF7jiyosZQfMe5LS582iBSaGMhoKM4onIVDM5gV2nWUNi3NsRfbASpcLJV
         ylWJpQkffX30W7Pzcj5yjoXhMfk2H9MBlG9DVKRjANcB16QH0TAePVCiTR/L9JYW3x6y
         uJLso9WxnBBnsGAHIUlObzaVynRRE/5pfg9Ia/QKNIOTv8f/Hd/m7KMVwUrGJIWqs8LD
         QwZ22REHE1VGoWMWj6Eb5NjwNHVExjfEuNfb3Lza3R8re/2SOe85qHn4y35bNl72//32
         imnLQ3fUsz38104UOWqDImzthWMSEgevUTp06HscAeR6NUICSa7JFH48xfM7KDSkvMvp
         DEmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747962789; x=1748567589;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LOvFzs/T3i4wRAI9d7REZh0re65ylVe+GMKFnPVLcoM=;
        b=ho8tl0db24kISxIGAHHS/PRKMaLYy40ANg3inGLZ/3Ss6a2Dt4ebDtR01ugtcnFfW/
         w+PkVittSe/fv7r6bwhisvrfF8bSZFRBQN07lJgVxuUJSK+h2ewZaLxkbCua0nmg5WxP
         s3LAZ4/36na404I0sRouQAaHyF7uZYHu3xaHi/22nOFalebkcvQD/MQlioHTPVtPn6BQ
         roob/xk1u62/KMGgxWMygOtuhl4wzv+Xnsl3xEZhqLEhLXxMlxtZ/WPNEW4+V/GJ1ZF6
         n8bShml2KkXUyt51zOPp9E5LM+9/tluZzlK/WV2wa5m7NSwGLtzlyl/dd8A5rxmthGrT
         Ellw==
X-Forwarded-Encrypted: i=1; AJvYcCU+AK8y8cN+fqnxtZqIGfSl1bZaJmwQnlYFTIenFbu9pQdmYFKoTRk5W2vY6isuWKJi3gvti1mtIaY=@vger.kernel.org, AJvYcCVrMFgpbkbm05hBP2bSctJQOrFqwci/7nICiM2r1NjtWHrzllOf4FMlQH+ivYPbAVBhebOsAk1l@vger.kernel.org
X-Gm-Message-State: AOJu0YySvLeQc5+75lVu1svBADtKAhlzot9SVwgDBgHLMLQpkzavDZw4
	Jo8hkesNCxqLBk2vFxdjOqkgq4FwGC07xOKeAUWG1TZR4fJ9PvDFuA9F
X-Gm-Gg: ASbGncuYoplGC0PSnwLiY9ucJ4BAN8mO9KKKQktBODWh/fG+NxPgYezzqa36NC8JX/r
	TNXCIYkbYnieYuRbeNZBW/xeFE9THLDt8UEdqlymgM7jhVdEQyUNseyNPbL8E20gEu2DzhiS4/Y
	lBzp9iBrBCNz1WqRsbCQqCXXBtQ4y+/2G4/fzpApcG+5UvDsp/lLSKgf56x6sgAR09LY4M+RSVw
	Jmw8/8Ye6QOQbHqadtYgQ+xJJoI198GKk7OBpAoiDJqgf5JUbqsoHQ0R+sfvmtiJLFVx9ePoL/F
	2Byoucp8dvU+jp173YmEg7qAgTrYMVeCCeFTp70qBuJmtnUlWf+S1/MkqLtiz5CZdX+C3daImO9
	YTKWgDeSR5FFC/5jp+YbBvLtFI+pEaoDuHeQFWfU=
X-Google-Smtp-Source: AGHT+IFs7eHYoE6Upd6eQ/uC/j0etjkMS2RZvRT3n9sebo7aDeMSJh3A4xPLh8KeonW2Y371C/mcig==
X-Received: by 2002:a05:6000:2507:b0:3a3:7031:59da with SMTP id ffacd0b85a97d-3a370315bcamr15404329f8f.59.1747962789399;
        Thu, 22 May 2025 18:13:09 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca8874bsm25088187f8f.67.2025.05.22.18.13.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 May 2025 18:13:09 -0700 (PDT)
Message-ID: <54f84504-b40b-40a1-ac3e-b6baeec8ec0d@gmail.com>
Date: Fri, 23 May 2025 02:13:07 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 22/22] sfc: support pio mapping based on cxl
To: Dan Williams <dan.j.williams@intel.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
Cc: Alejandro Lucero <alucerop@amd.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250514132743.523469-1-alejandro.lucero-palau@amd.com>
 <20250514132743.523469-23-alejandro.lucero-palau@amd.com>
 <682e4a2c481d6_1626e1008e@dwillia2-xfh.jf.intel.com.notmuch>
Content-Language: en-GB
From: Edward Cree <ecree.xilinx@gmail.com>
In-Reply-To: <682e4a2c481d6_1626e1008e@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/05/2025 22:48, Dan Williams wrote:
> Maybe that would be more obvious to me if I knew what a "PIO buffer" was
> used for currently, but some more words about the why of all this would
> help clarify if the design is making the right complexity vs benefit
> tradeoffs.

A PIO buffer is a region of device memory to which the driver can write
 packet data for TX, so that when the device handles the transmit
 doorbell it doesn't have to DMA that data across from host memory.
Essentially it's spending CPU time to save a round-trip across the PCIe
 bus, reducing latency; the driver heuristically decides whether a TX is
 more bandwidth- or latency-sensitive, and in the latter case uses PIO.
I don't know too much about the CXL side of things (hopefully Alejandro
 will elaborate) but AIUI using CXL instead of PCIe for this reduces the
 latency further.

Some of the above information should probably be added to the series
 cover letter or this patch description.

