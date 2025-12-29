Return-Path: <netdev+bounces-246243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BE4E2CE7578
	for <lists+netdev@lfdr.de>; Mon, 29 Dec 2025 17:17:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C5833020CFC
	for <lists+netdev@lfdr.de>; Mon, 29 Dec 2025 16:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB9D2E7F03;
	Mon, 29 Dec 2025 16:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zt4t9/se";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="kkHl58VZ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1633329C5D
	for <netdev@vger.kernel.org>; Mon, 29 Dec 2025 16:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767024936; cv=none; b=jMoZIZjRWAmS6JffSJx/P5mpRBtSXEqjZdhLaucVDP2yPUHWoyN+76jw5LXYux0sxICh1BLQJcyLY/PZF1CkARsK8Ebg+Z18wyaVsBQ2Whfc1Ee9hZFGO/e5nQRF9Rjd0DD6nI1z2rx1t9Lp0cJI4Cj1eAKw1OdugIgrfktydzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767024936; c=relaxed/simple;
	bh=q2UwQUJThsjXZh5ZUGjE+9RHIQhRfZCqcumKde+/eG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cbX2At6V299tufw4AKhXdpUKDbyWf2XIMYEWC7abfn64FVtaInuQWQiKi0LS3lVUJlGSetGgfg4769tZTx+7vdXxakTG8+DkA3q+S4siHo6YrFqatQ06/l262azXh/W4+uvVEoRTZP4TjbGbqeL1+9LfBlfeKLUCtMS2b90Ysp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zt4t9/se; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=kkHl58VZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767024933;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q2UwQUJThsjXZh5ZUGjE+9RHIQhRfZCqcumKde+/eG4=;
	b=Zt4t9/sel1MppTQGH7SbNFm2pKSUOKuKRlZDhMmpR7PXi9Uh7C+r8meiXyyX9vVNXukX4Z
	Ovj/TmNY2fUmV90QZr2cSB1YCe/BlDnnT5rWqj1P6q365Hz8BdJZ6GQF8rmGxOoHDrX0vX
	VGPgKU6TF9N27VkO2yVhjT4AUtSKqkU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-372-b71ZzfFMMgWl3S4ZtntCUQ-1; Mon, 29 Dec 2025 11:15:30 -0500
X-MC-Unique: b71ZzfFMMgWl3S4ZtntCUQ-1
X-Mimecast-MFC-AGG-ID: b71ZzfFMMgWl3S4ZtntCUQ_1767024929
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4792bd2c290so88065795e9.1
        for <netdev@vger.kernel.org>; Mon, 29 Dec 2025 08:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767024929; x=1767629729; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q2UwQUJThsjXZh5ZUGjE+9RHIQhRfZCqcumKde+/eG4=;
        b=kkHl58VZavjpPQTFovtHjbBizLHJLO8sI/s8XiltSeBWwkOxRHy0g/fFW5zS3chE91
         NK4+tqLhEcW97DlWBarRiTVmjEdMc23q98TefGSMcRZ82Z9+Tw/sDMpafgEBAVJnzCzp
         JhNZ//Q7cMvLlqbQh4giDeXYdOmyN1R8n7iDm14d+hXZLGkwTUiwu3ENfjrAv0N4UEID
         Y1wfPeGEdnNi4kFBtHhF9Lga+J/aa55+Za/LBa8uLOUa557s2AILZTQh/NUOgJfr9L0r
         SbUD52EYsLgnfXO8LpHokGx50vT7jYsoyuj9cESKjndRXeCQpOSGitCaAkGNxGs0pjF7
         rsFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767024929; x=1767629729;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q2UwQUJThsjXZh5ZUGjE+9RHIQhRfZCqcumKde+/eG4=;
        b=U6eOsRaJOMXsWtsuj1cTJSIQ44RSr8IXZ7DnMKgJ6hbViQWw8awmri2u1UfPJldFc+
         4kF7LFQvrdHGIqmnw2plXq6wV9ds84LBUOToCxUG2hQnf1EboCjB03rYpQh19+wQLR6d
         gcZE4DRpQCn/e4keB6mv+P/nbRfx8mQGLIpqsusKwSaMbMtFdK0B8dSoteLenMpa/wRm
         EGM5eKCsbpKgy5E9FQ51FWhO2BGhqQffWehwMNBJhm7jX51n7Jx0WDW7N5hwFDGFrw5R
         TbDdZ9pjEMvOUb++c5Pj33Zq+oRhD77Wr+vtch7BNqSgNRqOz8a0gxQv5gA2cAYjpG1L
         95dQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKToUupp+OXMvtJ3MSy5yJbm6x5NMuiA/Iqp5TPr7beQivwdEZ2/Y9hm3jsZAb3t8qSHERzLM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWVVG12IkbHrGzGKBoqfTvVSpuAiHl0eqf5K2KQJpEuh4oXB47
	l46URz8U6hDmMerPell6/myEFwR01YOBEDCmqNqV5QuukeXGCpQVdzb10B3E0h134qCEDoGfso3
	PAB0ZQrHNGkrksxshQoAjJ0Of31pEdwfXFA92sg0gWCG/jbpk149RZnCGnQ==
X-Gm-Gg: AY/fxX74rt8WD50WA2zW2e23JEexvYqmAYHeffzTg4bBfFWfAYSI++t52I4c0pjVHQm
	ugynOQaOm9XOHqccY+Onv7pqU9LfmIvNNa1yFyzZMOfmYmmmqOK5tcEhCyu33ZTtDNUfTrs8lWh
	xsr1dHbj9yZOUFunXp9O6E520Esclr3wZe/5buEPbKCYWUalkVZBFKq/vBD/CCv5Q9i4yqA2v2C
	soxqBjx1G2OfiPWDcJmQ8CwAnIgybfsfXq4Z3uGMccYibe7pBntdGPOODvH4kglr9aJvQkRmEi4
	m/Lip79vpPVyHm/4OWIHzttmZPHGvHOiz0LccslH1kVzOFn56h+S6GzKetottBUIN7IKhZacQom
	vgljIWx0Ot/Wh3A==
X-Received: by 2002:a05:600c:3b0e:b0:47b:deb9:fbc with SMTP id 5b1f17b1804b1-47d1955b7f4mr283976155e9.2.1767024928775;
        Mon, 29 Dec 2025 08:15:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFFXLcxbI0KxD1ej55P4p7W7rlsTlgPZbiCBCt+htkKpR6vtsYXXP6JwwqrUYrAPJ184PlNpA==
X-Received: by 2002:a05:600c:3b0e:b0:47b:deb9:fbc with SMTP id 5b1f17b1804b1-47d1955b7f4mr283975965e9.2.1767024928433;
        Mon, 29 Dec 2025 08:15:28 -0800 (PST)
Received: from [192.168.88.32] ([169.155.232.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d19346e48sm532124415e9.2.2025.12.29.08.15.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Dec 2025 08:15:27 -0800 (PST)
Message-ID: <eed3d1c1-7b7d-4aea-a816-2046cfa88529@redhat.com>
Date: Mon, 29 Dec 2025 17:15:26 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v1 1/2] octeon_ep: avoid compiler and IQ/OQ reordering
To: Vimlesh Kumar <vimleshk@marvell.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: sedara@marvell.com, srasheed@marvell.com, hgani@marvell.com,
 Veerasenareddy Burru <vburru@marvell.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Satananda Burla <sburla@marvell.com>,
 Abhijit Ayarekar <aayarekar@marvell.com>
References: <20251219072955.3048238-1-vimleshk@marvell.com>
 <20251219072955.3048238-2-vimleshk@marvell.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251219072955.3048238-2-vimleshk@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/19/25 8:29 AM, Vimlesh Kumar wrote:
> Utilize READ_ONCE and WRITE_ONCE APIs for IO queue Tx/Rx
> variable access to prevent compiler optimization and reordering.
> Additionally, ensure IO queue OUT/IN_CNT registers are flushed
> by performing a read-back after writing.

Please explain why such _ONCE() annotation are required, and what could
be reordered otherwise.

I don't think they are needed,

/P


