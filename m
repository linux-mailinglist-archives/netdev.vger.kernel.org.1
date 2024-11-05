Return-Path: <netdev+bounces-142065-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBCC69BD3D9
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 18:58:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB2FD283FF6
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 17:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D961E379F;
	Tue,  5 Nov 2024 17:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="cp8RwcJI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A8A84D02
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 17:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730829510; cv=none; b=rLTGy0Trqzsv75yjUW11BRy4o97CIFlcgxjEFdP2xOJWWLGKCQ1fUMDafwQ0LaxMyMW/LCx3YOrgKo/R8Ij1GnD8Swkh+CmJfwsA0xOMA8CDzpHMlml0UmrAvfdGwRkQLyq5z816GBaju+xVrx5HjMEWN6kES11WZYbwoXTMYTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730829510; c=relaxed/simple;
	bh=/AwhwZlP7+GN/a9z2bAjZaIJ+Fl3LF13mrFjTR3IACg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SDgodO0hao6ZqDP+fFiGyBOnRav2Ued9dbrcL9Sz0CGf5MQT0jeIYf3JGmG9p/aGAKARCPjb4ceD9QOUaPGwQgLCIIgIdX++hLORtR6/pErgIGBc7akFJmXvinOrJ+Wiyzs20Ns19LJ2ZJBU+gfPyNyA1G3AtBrtsGYY3k1GcQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=cp8RwcJI; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-71809fe188cso2858934a34.0
        for <netdev@vger.kernel.org>; Tue, 05 Nov 2024 09:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1730829508; x=1731434308; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lIP6kXowVnLgD2hj9GcB5YAj0YbMjHwZaSQ9b3/rOs8=;
        b=cp8RwcJI9gAQBedh9qN8N9aqLE9LANm+FoP13TH6F74NrSQPCzRe38uVfE+sfRjdNT
         wcLb5qbnFSHgXIiDsq6KsAtCTkl0RCkUsqZG1bwdw9R9QA1xQu51vxr4Sk1AvYwsmEpM
         lYvI6v30OwqSBNy5id8QOqsYRR2Dsm7BMV/Sw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730829508; x=1731434308;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lIP6kXowVnLgD2hj9GcB5YAj0YbMjHwZaSQ9b3/rOs8=;
        b=rDCoFn09E1DzfwGCk7lV13g8PnHOmi/0NVesaYVTUBk412P08a/8ihnBKcb5tEEQjX
         hVot06/coDBYaTc0cCAyTxoW0VPXW7isWp+spFDs7btSpsSkR3T9BvQOJL7uLcb8k6d4
         KSWP6Ge1L0WuuK81oh762QLnbBcnEWdcviUi1Q0SV31irFphhdW9w6n0UmlbfJp/Vlmd
         +yiPBB8VaVSje6I4yPZQRxCWQqDQ/eSFNaUxRt1ZOblUmXwSPyUH95Q2nU4U/ZjnNAq3
         rsJUiu1ncW3V5VGiEH2jmWtLCKx+C07WlQ+ppPTzUifXRI/I2cnbr6IkdTBv0rmV+FYD
         RieQ==
X-Forwarded-Encrypted: i=1; AJvYcCV//FUnP13Ko3MifdP0ZljqHgJCAC5kZt4lfYzhbpu3Ypx9QotFr04lnze8Pyici370E6fvfIk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/sPjc9Us6ze25BQ3S+LHbHxBuXR/YTYj4Kf5I8aaOIDYF+849
	JJLCYIyvqmTU39pDzlcUW8i2IESoDGZ6tfPLbH3KcG2/ZslS6lrqH6ZnqM61H/hRYZ407nADqXj
	E
X-Google-Smtp-Source: AGHT+IGOBvzyynNlhSfPviaqN79FMyZn72MYAFAC1E20s8uR652mhbUXXBQiTEPcsG8F8oIDIhzZag==
X-Received: by 2002:a05:6830:919:b0:718:1163:ef8f with SMTP id 46e09a7af769-7189b4cb757mr17573272a34.2.1730829508329;
        Tue, 05 Nov 2024 09:58:28 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ee452a8b4asm9379623a12.20.2024.11.05.09.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 09:58:27 -0800 (PST)
Date: Tue, 5 Nov 2024 09:58:25 -0800
From: Joe Damato <jdamato@fastly.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 5/7] net: add debug check in
 skb_reset_transport_header()
Message-ID: <ZypcwYXubHzIyGej@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20241105174403.850330-1-edumazet@google.com>
 <20241105174403.850330-6-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105174403.850330-6-edumazet@google.com>

On Tue, Nov 05, 2024 at 05:44:01PM +0000, Eric Dumazet wrote:
> Make sure (skb->data - skb->head) can fit in skb->transport_header
> 
> This needs CONFIG_DEBUG_NET=y.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  include/linux/skbuff.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Reviewed-by: Joe Damato <jdamato@fastly.com>

