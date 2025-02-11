Return-Path: <netdev+bounces-165275-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C670FA31601
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 20:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FC33167371
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 19:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A792B265631;
	Tue, 11 Feb 2025 19:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="eiprc1fW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A36D26563D
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 19:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739303551; cv=none; b=BkqmKnukxCTU5OmMxEHPgzqWuJDPkfcdIheDPoHPbRf0Y4XhoMde60uOY8ytiMNVPtksvhC9JpZ1Xg7iratMF7wCn/UsfaPaCA0U5OyXRCs3vomLlMsAz8SFIq8JU4Q93pix6xXBpyksFQHWytWWiBXTlDI6yN0jyD7zUAfmtcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739303551; c=relaxed/simple;
	bh=vEAKkXno0infCXoqj3jGaNxTagp1mS67AwoNo0kL9L8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q+pRLvZW2Rpp+Jg57yxhFiyGdUca2HdAF40OpKcgfYKrb7LN2sP7EnJv8UVHJ88bGYlMrSL4nIyBBKEHe1v9F1ee9dWOOtAqiHRUF46+g1xUK6FbxtpaCyp+vA39pzeatvCQr6wuA37pFLtKZeNgTbxH4YSy6uTGdUGyEkdQ2Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=eiprc1fW; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21f2f386cbeso110859275ad.0
        for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 11:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1739303549; x=1739908349; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9s5U50L5JAxbN56K5kciITTGqbJoa6RMKn3UjzcSSyg=;
        b=eiprc1fWg8dq2yTtQJ4GaJcIhxKJuUSLxVZ6e+9Q9G3sNGBo48FWjk+hj/mkMJjN7J
         MboJpWso8mkeqfbUY2zjEB6wVK7fTwFQQBTGpI5m090eQ23CYu7rIA7mZEaMtfrWIwwb
         N5HfBPu+hBHyCR0nNEUL76zF9ix0P1LABvO/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739303549; x=1739908349;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9s5U50L5JAxbN56K5kciITTGqbJoa6RMKn3UjzcSSyg=;
        b=JrLjifGv355qsFJVfxWA1jjUhlAZP4MoNui0nutAez3Ocs26E0y4H1sXxFa5wuZNbV
         d2xpbt0Cj+ar2zXTWKmx5fuRwk2H85oJoE/2G8cMBvsHBSOIlzh7u7uCx8TaAGAbb4tf
         VONKKLYt09jP+2qsuWruLYjA57//9SmsiAR+3WVd189q5Csxv84Uff0mQgeyoj9GEcg/
         33BJ6Ulqeo1Rea1d1gXqMIpxzh9VeP7JHkCIPIPlPgE+7UstVNb8b0KejCncJEjYgwVr
         tdnsVXqCTD+OYOzkgTCVzThJ+xTPuINrO3IzSEtP65XlfPfPhlnT9PR4wYwOEg2tqmiq
         ApwA==
X-Forwarded-Encrypted: i=1; AJvYcCWeO4iZDxHr3JLdB5JLhShO3j5lflaClXfAnaTM8O82uEB5/8zgFavPxmIPPaMjvQ0kwVAHyPg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY2I7dKIXMIz65JWBYy9foOyGAxfXtaRDbHWMjhx3NpUK+DDDs
	rSnwnzbKqjrXvQ+WQKXia2KRTzvoCD3Ykeg0SyktwW5/GZv11u+IimzzFixPadQUELUhh2ymIts
	1
X-Gm-Gg: ASbGncsRiLkBXj0x45zyuQzyLDXSOFr72RELWWcigQm1c7PSJo9Xu6yNWuauszZJTHe
	14QOgVHGtFiWB63CPNRtpii8akQLKyvuEq+8Wir7+2LtVHEWRrr0ozi5NuCYE8NUexkD9RJYlsT
	kbB9EyQcNIBJ/9IvZ+1jKl/SobTTLwg2TYz+ro/EgSGAFWrH6+hp+UXzb1m+I5gO211qJle1B++
	kh5H1FvSWuPzeNQfhhGvKokLIRESQhni1QaLwFrOXJiGE0+COAV+rKVdpdVtkpSSEEWoF5dPtRH
	Rf2P3TheLnUiEMs1vkQRr1BShAscTDX3tq6ZIZN3K/Wju7HoT6lEVDtgMQ==
X-Google-Smtp-Source: AGHT+IFkGI4OKvWD6l1NdMMTOOOcbbHWog591k+i+oXoBy9gPQlZUDGEphRpuM/+TMDr7f6Qwjcq6w==
X-Received: by 2002:a05:6a20:c797:b0:1e0:d4f4:5b39 with SMTP id adf61e73a8af0-1ee5c79672fmr994789637.24.1739303549316;
        Tue, 11 Feb 2025 11:52:29 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ad9c84417d5sm98180a12.50.2025.02.11.11.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 11:52:28 -0800 (PST)
Date: Tue, 11 Feb 2025 11:52:26 -0800
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, alexanderduyck@fb.com, netdev@vger.kernel.org,
	edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
	horms@kernel.org
Subject: Re: [PATCH net-next 4/5] eth: fbnic: report software Tx queue stats
Message-ID: <Z6uqerYZiYbif2up@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	alexanderduyck@fb.com, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org
References: <20250211181356.580800-1-kuba@kernel.org>
 <20250211181356.580800-5-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211181356.580800-5-kuba@kernel.org>

On Tue, Feb 11, 2025 at 10:13:55AM -0800, Jakub Kicinski wrote:
> Gather and report software Tx queue stats - checksum stats
> and queue stop / start.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  drivers/net/ethernet/meta/fbnic/fbnic_txrx.h  |  3 +++
>  .../net/ethernet/meta/fbnic/fbnic_netdev.c    | 10 ++++++++
>  drivers/net/ethernet/meta/fbnic/fbnic_txrx.c  | 23 +++++++++++++++----
>  3 files changed, 32 insertions(+), 4 deletions(-)

Acked-by: Joe Damato <jdamato@fastly.com>

