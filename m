Return-Path: <netdev+bounces-104084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1136590B1B7
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 16:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 229431C23593
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 14:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F59919AA43;
	Mon, 17 Jun 2024 13:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="jAOTmJrF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D039F19AA40
	for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 13:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718631304; cv=none; b=JGQK5vSs/VIZDZ5Q/RNgSbFOiLT5m7wHX4eac2dBvCHCg870nwikZDC0iDi8W+RnMm6EvcJm3zP+ZKWIRd8GF8/6ARrd5C8BIZj6U287PYg3Yxcb3sFppfBVEROyp/94oWHzSOPtLgW3UABzuGHyxPaZT/bOauSq0LEXrQsh8L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718631304; c=relaxed/simple;
	bh=6OKT3WqegH1QtD1wyuXce6fGlAETjVHusGyC+Pzsr8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TPfAGkj6KqvXvGOi2BJnabRaQERm3/lLqP/8r++NorK/zb4saljhSRTN4oOaa8vW3uJJWUvVeUe2KsDw8ZfFIFZfR81/BJABmWGdjx5TaaSj5KtwRAWnYtMBiTOvJco8k9cUpQ9WV0xg+3dObcmjgo2KO101mRLxdE/eXmX7vxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=jAOTmJrF; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-421f4d1c057so33817255e9.3
        for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 06:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1718631300; x=1719236100; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cXOhkuogz//QmdU93D8xI7eVOtiFpWIJJnt6ZBb+35s=;
        b=jAOTmJrFP08T1REb5f+CfKg6NEONPfnKQUOuCbm9XT4CHMC+ViyQxiaoy4XnfX/H9q
         NRP4huNInhEg2r2md9EKBXl1MZbeXiVk0vWKPE77izNvhb0QhDoRZLQwVjgsk9CSBgWv
         dHzU1+gXqstwDBmpvSxh/u3tMl3y5ZzjmtggRQ9dcTqFM8PH5NrTIRRFmuuH6iw0OuA8
         4kzSji64iC0mU2K92+eUG3GJk+KrP2svP0ojZfeHEKlUkAHpAnKozI2Zvzc/osyf1bpR
         QiBZPKXqj7ow/tgkcwcyo7ir/E0Peuv5NCiYKNGWh9sLatYc33TKAk65JOa6rCkqlC21
         dryg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718631300; x=1719236100;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cXOhkuogz//QmdU93D8xI7eVOtiFpWIJJnt6ZBb+35s=;
        b=qzewezr2ANw/A+namxDUYvA7asx7SDFgJULiHZddfz67UK/qN2NcsTsuBz/W37wG1F
         lwv0G1C/EDaibnJV4/lEmhfTzhPvHpPOK2c74hAp36+ZBFzHycN7G8IM7Kjg1AySFxeP
         axSeooRxudM8fApu3Oy86682l/XApNNHQ1RT1MHHsh9Md+Uf14iTDlqikM81baOTKVUK
         JCkbwj4qYTeQdQ2jredzDtjQYbBd8CnUAR5TiETlLGtf0HTxiZSRKyCaLDBgbR0xbjf9
         fuKsFTm7DF0hREm56PKX6o286edvpBO8twt1mu/ARh36v5gr+TT943GKrpwOuTCbtLID
         VrfQ==
X-Gm-Message-State: AOJu0YxQEU9/NM6BD5UvJicjS18IFeIbKyRIsoxkLxOy2WZYmrZVoo5B
	lCjq7uYIe8CcFveaw/7yz5DM1euOGzb3XfcEJK50pDB7z0g4CYetTX3uJp3+GdM=
X-Google-Smtp-Source: AGHT+IG6C1PBpqaaWvWNAxk7Rv1Qc1N+l7EJFwfh6/c3prESpScO1tKh4vNfH7nfLGf3e2rMTio8eQ==
X-Received: by 2002:a05:600c:4448:b0:421:819c:5d6b with SMTP id 5b1f17b1804b1-423048262c3mr72180135e9.23.1718631299909;
        Mon, 17 Jun 2024 06:34:59 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422f602f620sm158614925e9.19.2024.06.17.06.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 06:34:59 -0700 (PDT)
Date: Mon, 17 Jun 2024 15:34:55 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Thomas Huth <thuth@linux.vnet.ibm.com>,
	Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>
Subject: Re: [PATCH 1/2] virtio_net: checksum offloading handling fix
Message-ID: <ZnA7f5wW0VXQGPQw@nanopsycho.orion>
References: <20240617131524.63662-1-hengqi@linux.alibaba.com>
 <20240617131524.63662-2-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617131524.63662-2-hengqi@linux.alibaba.com>

Mon, Jun 17, 2024 at 03:15:23PM CEST, hengqi@linux.alibaba.com wrote:
>In virtio spec 0.95, VIRTIO_NET_F_GUEST_CSUM was designed to handle
>partially checksummed packets, and the validation of fully checksummed
>packets by the device is independent of VIRTIO_NET_F_GUEST_CSUM
>negotiation. However, the specification erroneously stated:
>
>  "If VIRTIO_NET_F_GUEST_CSUM is not negotiated, the device MUST set flags
>   to zero and SHOULD supply a fully checksummed packet to the driver."
>
>This statement is inaccurate because even without VIRTIO_NET_F_GUEST_CSUM
>negotiation, the device can still set the VIRTIO_NET_HDR_F_DATA_VALID flag.
>Essentially, the device can facilitate the validation of these packets'
>checksums - a process known as RX checksum offloading - removing the need
>for the driver to do so.
>
>This scenario is currently not implemented in the driver and requires
>correction. The necessary specification correction[1] has been made and
>approved in the virtio TC vote.
>[1] https://lists.oasis-open.org/archives/virtio-comment/202401/msg00011.html
>
>Fixes: 4f49129be6fa ("virtio-net: Set RXCSUM feature if GUEST_CSUM is available")
>Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

