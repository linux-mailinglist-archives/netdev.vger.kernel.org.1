Return-Path: <netdev+bounces-250943-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C9B9D39C1B
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 02:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 39E333006F70
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 01:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E281F4CBB;
	Mon, 19 Jan 2026 01:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WLCbNQa2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7387C2A1CF
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 01:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768787156; cv=none; b=goOPYSahzudrxxqdNb86v6wHNHbZKgcXRwFQP6A1qLx05mdZVOL7ftxKbpZvZUYio7xusz5y+xaHsWGg3G/96Sf3uLEsXNJ7r4o3mtmeL4jTjN25NJ72vUneScmvbsTXH/6gresSJc1ZCHeEJid+CpkASB70kjcAfetBAMewZzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768787156; c=relaxed/simple;
	bh=2CDrjTpiQ/0AdQLT27kfYhsG2ykJSy38qiDj/IiUwVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E6PX6Ye3+q5bqx3jcxQTSn6J25hsj7OW9anN1KtEsWKpm6xU2qUAwH6dHJ1LeB0hwqwflFK7gJwsEZsSEpBrxF35peq7vyUzC1MyT07r/3ajZjAk+Oey0lTGxsBvAohMSijNWHRnFeSctz7MgddftYhtUSrDFIFvDGK4msnxu+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WLCbNQa2; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-121a0bcd376so2608541c88.0
        for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 17:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768787154; x=1769391954; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wrj+EAeNVP8pFSjWojFc9is/CH6nYVXk5rMSOFLJMpU=;
        b=WLCbNQa23GcF/v5JX42iieX3OMoTi5q4TS3tuoBia588VCxeCpLYciLkLROQgQE6Ov
         LM+fuEHKqujPHPFPd9O3WrX4YItMi0s+JNGB+eySauBzdSaEjm4toEY5rzQswe2g3haJ
         WbMPYSJp+z/gD9cXXAQ8zHcM1AoyhI5J1DnChjiIGW0LeimNez1JQ1PeDwhvUWJdyW2v
         v4Cycsb639AxtymxBrfCkzJ52Guq/7RqXDrBoHw5nLBj0N7Blj5EOvSZZHZyDZtFJjaX
         Seend0wXX3JHoVe0ZNiFsdqNQUmTch5kRpFYP/U0lQ+E1xjjODMgga+eyOFXqlPuPikG
         WE2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768787154; x=1769391954;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wrj+EAeNVP8pFSjWojFc9is/CH6nYVXk5rMSOFLJMpU=;
        b=pdzjowWL5JhjEoomv99pIckXTICZfCPGzAI/eBej4fzT0NVZbiAlKYKe2yRARTg2x4
         7TunwSXo0Is7gmJfWewhqa3aaCtvVZ8qtfgmZHjIsepJf7GQ3+gJjAou/3XBOMUfTXX0
         BHnD+v2Ntr88lg3pLY8xszlrQzk+wt29DEB5e2PrJPmwQFvda2fs8phfF2ur6UoCZALg
         D/pkt7YV6EI7ysrszd490vCmTYgfpCw3YvKjr4oLTJHttdmzhPO/XLtgrjdF7/ltwuiV
         Gd2PF+N2H63RptlQg+3Cs4NU1EbVzz2MmsJOeQL0QKcycP4rh1B2CIcVOqpqIza7QEOn
         XwKg==
X-Gm-Message-State: AOJu0Yx0aF86sQVBWqWknKDheyTwfWFpWmnoOGkNBuUy7uZPQe8sMwYi
	c8krBrPTGYkcWX6DqK2invsNTuVFKnBpjFZEIpuuGIx+jqyZ+qFRnsk=
X-Gm-Gg: AY/fxX4LpvJIe2wz5rdfDVLZ2hZ0f76xMqlw3/JKJW8JOS559kF/Xr/GohbC1v097Fs
	FHuTj6kIepg2bBziXET2fhtwxcrzjSwZ6oSudjXXeFC2vWvJQaPJFXM3UofAfZVasyLNQbaU1wq
	EcCArgpISp8pnLvr/q9QMHUF/f/eo1xfuiUJddxNrTqek7LB1jj1HxN89W2m3cLWLGThao9Cp8i
	5zy4DRqXZr6mM9aX5faeHqbjX+eUUW+l5LBbDD5Eaon+ghDvzcJ9qapYuwW7cWlGGCMkhKPgX/d
	PSq1dkI1+MGcVkkEapENn9zaPN3XY+LF4JssxASuJEr3gitMZkRU+Fa4xxRmQgba3TGf494bUDV
	kSYPEA8hvytrDS0UE7nfokal/XVCfqRYphH7pe4wqD0ttN3hGg6iFvM+w1tFzJBXDs3FiUswz6K
	7qSmn9Aum8qx4kdEZ1NT4m1L9rGU1U8gisjHjf2Emez3k035XNLb1XUnuo4bd2iGW0CYv1pjksH
	iWIfA==
X-Received: by 2002:a05:7022:f8b:b0:11c:b3ad:1fe1 with SMTP id a92af1059eb24-1244a6e9b6cmr8741045c88.11.1768787154303;
        Sun, 18 Jan 2026 17:45:54 -0800 (PST)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1244aefa7c5sm14340962c88.10.2026.01.18.17.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 17:45:53 -0800 (PST)
Date: Sun, 18 Jan 2026 17:45:53 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, razor@blackwall.org, pabeni@redhat.com,
	willemb@google.com, sdf@fomichev.me, john.fastabend@gmail.com,
	martin.lau@kernel.org, jordan@jrife.io,
	maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
	dw@davidwei.uk, toke@redhat.com, yangzhenze@bytedance.com,
	wangdongdong.6@bytedance.com
Subject: Re: [PATCH net-next v7 13/16] selftests/net: Add bpf skb forwarding
 program
Message-ID: <aW2M0cR3lEBEENim@mini-arch>
References: <20260115082603.219152-1-daniel@iogearbox.net>
 <20260115082603.219152-14-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260115082603.219152-14-daniel@iogearbox.net>

On 01/15, Daniel Borkmann wrote:
> From: David Wei <dw@davidwei.uk>
> 
> Add nk_forward.bpf.c, a BPF program that forwards skbs matching some IPv6
> prefix received on eth0 ifindex to a specified netkit ifindex. This will
> be needed by netkit container tests.
> 
> Signed-off-by: David Wei <dw@davidwei.uk>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

