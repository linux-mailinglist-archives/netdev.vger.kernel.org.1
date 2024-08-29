Return-Path: <netdev+bounces-123287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 469B2964618
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 15:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78AB61C2455F
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 13:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D161A7068;
	Thu, 29 Aug 2024 13:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TlsbY6AQ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BC215CD62
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 13:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724937290; cv=none; b=m3gy177Fybiu5oQj9W6COR145u0gI5NNYZr2BBCIH7W1lEnI2qDqV+R8n9dx7BhcB0wr+G9ykzDyro0Xk7di+81dgo4md67+NU7yZPtF1hoO2MNmDR+hsqncs9HIWtuIJ4HB/JBD1kbnlioLF4bnTV1S+hv/RYai5jx2ixgvsWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724937290; c=relaxed/simple;
	bh=Jm+pmtdf4qP9lPF5z1JGJhcaEsEtzSEatYaWyXpSPDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gPOzUtWishWBTUKxx0TKGp+i6k713Dz2WeZrGE1GzDOuTTBX4T08GSYs0DCAgV5sXyQ3XSeT+AJPmrVQDDSHCPUyoE4QJyjX5DOvl4M6Vcm4X1HX0E9bHHNSTcJ4SMPEHNe+s0+AbmxBVwefwNbxPLHAaz1FFei0xvlvYt859E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TlsbY6AQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724937288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KMkwOi4JjN6JJkWoqwgZkqx+R20QEZgxqkFxgjlzSuM=;
	b=TlsbY6AQF22oyqK6yRlm4Yj8WEJyKcB28J8ZDoPlgcmeSJQZSg6K7WPn8hbqLCkoqx35wD
	O6Lvi/yG4l8jebJvLBnPil0E80pfBxlEzR7WmfTVsLgbTrCvp2TB7GhoSxbLwwcr2taFBM
	l6+3deRgTc5khif1M7KEskYGpiUcb0g=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-100-ASAXHAG-OEKa8_ga3vZHwA-1; Thu, 29 Aug 2024 09:14:46 -0400
X-MC-Unique: ASAXHAG-OEKa8_ga3vZHwA-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-44fe49fa389so8216231cf.1
        for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 06:14:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724937286; x=1725542086;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KMkwOi4JjN6JJkWoqwgZkqx+R20QEZgxqkFxgjlzSuM=;
        b=widrydoB0/l1cToUlwlKfXTWv22gJU3/RVk7HFDnX4CZe/oscQp5Cc/HQnNZnj0WpV
         JrGFPmiPwx9ZKDKBLN2eFe5NDL9YXWcAVlus7JEu3Sj9EqkqjhZf4M7ca+w2W5IP2/Jh
         55WaYg68seLGWLv9oYCkCHSje3WLTNog9Dmn5S/EOJtza3s6A4lcSe8reU+kGuBqnLOl
         n6o16RiF900Va+nuDJWg3kcqJmJLyp74m7ynCr27AvwhkQLuda9MJxixej3RnhV7qHAM
         lGYK39tWFkuhJQ/l5xqOtahepEHvbW0BAelCAMZ2w9d8FVStnzgSIfouzatRX5eFt5YD
         8oIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDkfZJ2YQSTGgQ7Wfksrotgxhw9IhotUthJhsKivy36+3Hk3rsXGaIYz1aSIjxCR8JZ3GY++s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzxRP3+2YXhuhIna76J0BzXOYVi2Mv4IXz0CY5JwICzrLq2A/h
	pJ4iOSGFEnbqJlJuUkCWNYht2e+upKxdJYnnt6BLsdsSfIObMY742rIJNMkBrPTyN8YTWkfSGJF
	TV8ayYMNZrNTxDJn55nXLkMeoMOjS9rSwqSYSjRatSENa9YX0iIP0OQ==
X-Received: by 2002:a05:622a:418f:b0:456:45cd:db71 with SMTP id d75a77b69052e-4567f592c65mr35525081cf.21.1724937286484;
        Thu, 29 Aug 2024 06:14:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFur2WCumVIV79Jh3TYo0EaOZHBpT13u9xP4uBg+9WfG5rJuXo7es8ZRNZVfgld+I/exrnwqg==
X-Received: by 2002:a05:622a:418f:b0:456:45cd:db71 with SMTP id d75a77b69052e-4567f592c65mr35524161cf.21.1724937286065;
        Thu, 29 Aug 2024 06:14:46 -0700 (PDT)
Received: from x1gen2nano ([2600:1700:1ff0:d0e0::33])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45682cb02casm4742421cf.42.2024.08.29.06.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 06:14:45 -0700 (PDT)
Date: Thu, 29 Aug 2024 08:14:43 -0500
From: Andrew Halaney <ahalaney@redhat.com>
To: Dmitry Dolenko <d.dolenko@metrotek.ru>
Cc: alexandre.torgue@foss.st.com, davem@davemloft.net, edumazet@google.com, 
	joabreu@synopsys.com, kuba@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	mcoquelin.stm32@gmail.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	quic_abchauha@quicinc.com, quic_scheluve@quicinc.com, system@metrotek.ru
Subject: Re: [PATCH RFC/RFT net-next] net: stmmac: drop the ethtool begin()
 callback
Message-ID: <ibna42mzj4tk3kddnnzgosglumngupdwxnthkm7rkqrejbr5oy@7j4ey2gtl6zl>
References: <20240429-stmmac-no-ethtool-begin-v1-1-04c629c1c142@redhat.com>
 <20240828143541.254436-1-d.dolenko@metrotek.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828143541.254436-1-d.dolenko@metrotek.ru>

On Wed, Aug 28, 2024 at 05:35:41PM GMT, Dmitry Dolenko wrote:
> Are there any updates on this topic?
> 
> We are faced with the fact that we can not read or change settings of
> interface while it is down, and came up with the same solution for this
> problem.
> 
> I do not know if Reviewed-by and Tested-by are suitable for patch marked as
> RFC but I will post mine in case it is acceptable here.
> 
> Reviewed-by: Dmitry Dolenko <d.dolenko@metrotek.ru>
> Tested-by: Dmitry Dolenko <d.dolenko@metrotek.ru>
> 

In my opinion the tags are welcomed.

I had sort of forgotten about this until your reply, the use case I
had was only to try and force out another bug, so it slipped my mind.

Since both of us were bitten by this, and nobody has indicated it's a bad
idea otherwise, I'll rebase and send v2 with your tags to try and get
this merged.

Thanks,
Andrew


