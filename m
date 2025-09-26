Return-Path: <netdev+bounces-226671-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD72BA3E03
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 15:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D36F7B2060
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 13:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A985279DCC;
	Fri, 26 Sep 2025 13:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YmaFyvNY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B2F11CA0
	for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 13:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758893131; cv=none; b=ZEhb1LkYUsWbSzURZZUXQw9n/ps6IYvofZgQAhHvJkWLyxRZfOcHP5+QOJpN8Lw6tUJ80HruQvMkuVB8NKldRu6YPDXMxirEzDGYSm2K4E5ZxWdX8Vd+Px2lekHFQAfL9wn78Yr1pFTonR/bZnPTbchi7hTNetL9NQcziJObaDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758893131; c=relaxed/simple;
	bh=AMYuZ0sc5IDgH+SwisvZgTm8JNt3MSUUKvWEXAE4oEc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZqDALhQ54SWSSal3PMdb2O1gwNmaM59j6f113DoZq2aCsTvWXSRMogWJdV8k074Dh3gaQ1sEu/sOKhcmWuoZ39suTSrqnt8SdifVEQRij8QWPgRoDYfORIAwpkP29eC7JBMxP2u58USjTmyZghGVlrP+K0NkxaiT5Rb1muEZIKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YmaFyvNY; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-427e5121313so1930435ab.0
        for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 06:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758893129; x=1759497929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xfmtM7RZ7AOffVFIOIyywezf5nzzWk/ab7a+2RFSGKs=;
        b=YmaFyvNY6BThLDSyckewMBBKy2siabHjS3koFbNTU4ZbRFC4ikmiWB+tvP2GkjGWgx
         hgQSVgMuVrjFl6ItJHTiCRT0zLyOGYKt875Xqv3xhjKz/53dXmlImIt1QVEwT/JUI5zE
         wBqqrwQq47fieVP6vvMU+huoMIKBAVkl/rB4xIZx1GeZsDq2he4/49IvpohRlzIhPVhQ
         lr0274Kw3B67v4dDWqyiqmWSS2ofOouaWiIu+VBBDvjD+EVnR4aOxxe3DLcGn0jzXP5c
         gXUFYMuBjQvbf2M7m7kYMh6KNe50TmDhpmYeUa3y/mqaHZUo89VrF6mrU3Ex3i6AncOQ
         vjzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758893129; x=1759497929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xfmtM7RZ7AOffVFIOIyywezf5nzzWk/ab7a+2RFSGKs=;
        b=C3+ek+3pq7GZm6WqxMijE80bXZXboBcoc0fi592x3lY9ESdjREIT7xIxr98S9/i9A9
         ZnQ2hbR7WnENcxdchCsPDhFzL6vHYw7wQjBCaQcuGjAsCUkfltZqEumQDKNb/rWtpneJ
         XvI3CrNWoqtsd5EeAVPDh9xMuiOWtEfl+LOrBLoQZlh0RhGxNjQUPNL3ZLJGImgzL0J/
         xZqorPqmFSyFwX2WUyVUKc7Xa0koR5CzddwWVLlaVdjqWF1yDTqD1M5rpidQiG1xSCFA
         WKEWjwvPhHxNpC1hlS5Z4000A40QcfAzXjanGLkbDhhrZxNlKt0TW0WjwKvfTrRFCiUP
         grnw==
X-Forwarded-Encrypted: i=1; AJvYcCWE+vhSehN8b7fWjAbSvCUm0pz/vxnlIR3YGugG3tSy/IPLlqOZDyiz6dJBKa0OF02sIL1D9F4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJiMfuvGW4KjwFnZRYn7DDJ2l9oIbZq96mSs8I1gPfp/8M0/JR
	UTPFsiGvRqfw1iolhQb1bXWrjSErNHGf8ZOe5ZQtOUH/0bWzPhnH7TeB
X-Gm-Gg: ASbGnctJCn8zs2zanhI6M2k54fwlVCzOX4GoLmfly+Iftv+BdJk5lqUmUJyPC1YGwv7
	/WQ4HYrWwzhpHb1euHVnNw8YabblAla/5O0EmMLEeoemuoHwYn5Yl3OlRqq57EihgIRmejXRSSk
	thMv5+hqaEPEmfmWZM/JKm+h8IL0mjEcFCBkojK7vyP73qSNE9Mh0Vli8zNhKSJWJ0kOHbMSF+A
	IWkG5qicPBxKys7wNDyXnTL7TMpM/jOe+A0NgwJ7SpgTGg/ho1ng92mFZRV+Ql61P7CpFZALkWt
	F1yy7JruhovTVdNEK4HlzRi5Z6e74F92pW9R/n21xzAWWIHVOy5ZtxT/M2Io13fGIiphxbP/TZG
	xSX/S4U9K1WnRtcfIMD2ZkKhtDsucPNHu
X-Google-Smtp-Source: AGHT+IHuN12QnqYCBArnyQoijmnt/uUh4vZpuhcsJapYpJzRJKR3sYrz93g3wBFXERLf6b51Mb32mw==
X-Received: by 2002:a05:6e02:1aae:b0:424:7ef5:aeb with SMTP id e9e14a558f8ab-4259563befbmr99572855ab.17.1758893128569;
        Fri, 26 Sep 2025 06:25:28 -0700 (PDT)
Received: from orangepi5-plus ([144.24.43.60])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-425bcb5f6e9sm21946655ab.19.2025.09.26.06.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 06:25:28 -0700 (PDT)
Date: Fri, 26 Sep 2025 21:25:16 +0800
From: Furong Xu <0x1207@gmail.com>
To: Rohan G Thomas <rohan.g.thomas@altera.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Matthew
 Gerlach <matthew.gerlach@altera.com>
Subject: Re: [PATCH net-next v3 1/2] net: stmmac: est: Drop frames causing
 HLBS error
Message-ID: <20250926212516.68d35461@orangepi5-plus>
In-Reply-To: <20250925-hlbs_2-v3-1-3b39472776c2@altera.com>
References: <20250925-hlbs_2-v3-0-3b39472776c2@altera.com>
	<20250925-hlbs_2-v3-1-3b39472776c2@altera.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Sep 2025 22:06:13 +0800
Rohan G Thomas <rohan.g.thomas@altera.com> wrote:

> From: Rohan G Thomas <rohan.g.thomas@altera.com>
> 
> Drop those frames causing Head-of-Line Blocking due to Scheduling
> (HLBS) error to avoid HLBS interrupt flooding and netdev watchdog
> timeouts due to blocked packets. Tx queues can be configured to drop
> those blocked packets by setting Drop Frames causing Scheduling Error
> (DFBS) bit of EST_CONTROL register.
> 
> Also, add per queue HLBS drop count.
> 
> Signed-off-by: Rohan G Thomas <rohan.g.thomas@altera.com>
> Reviewed-by: Matthew Gerlach <matthew.gerlach@altera.com>

Reviewed-by: Furong Xu <0x1207@gmail.com>

