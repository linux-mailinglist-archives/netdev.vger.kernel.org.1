Return-Path: <netdev+bounces-175888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F74AA67DC0
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 21:08:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B784F3BFBC1
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 20:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1799207E0B;
	Tue, 18 Mar 2025 20:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="miXAflyh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24031DC9BA;
	Tue, 18 Mar 2025 20:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742328506; cv=none; b=OG5bEM2MJNFrY6KvtL8Xi9hEAVhqBpb7Z7QzihI0DSCO63woD1T1ZZOS/X7t0+jLt2fcK2yJYJMQl3Cz0Fmb0iezaDFKnFrH6PicsbbK7Q4ibcHi+PUDgkKnrH4neU2nHokXGIjQXSnZOJY7vfL9p55Q/Q4UAgN4KEk8C94E81k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742328506; c=relaxed/simple;
	bh=FCealrbPRP5fL2tvYxJVYMMIVOCrBOoa8E1nD+Up6zU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JDK0eOrWCkmXOXbUfCRt295kN3LcPrea+RYiUk1SyW/MyvZJ3fsbShuC8haOMnFK0bcpb/saZEQaiICv1bZnvBUxJm2117+s0qe0pd5bNcl2TFRahTG53xHSqZmWFJgM97uXpJZtP7uNQFqklGH0GlCamQN3NM2ZykQJR2mMDvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=miXAflyh; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-39130ee05b0so5942428f8f.3;
        Tue, 18 Mar 2025 13:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742328503; x=1742933303; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=A/Z/pn9wn0tCKI/g9RBCorTzXexzQNQDNcvtxOsUlXs=;
        b=miXAflyhCANw86XvpnURFNx7xfjFOhS3omGvpEazpvKGe42F6aFlmgp8+A2p2Z6VgI
         JLqyxq2He2GkeTDaq4Qblknqa68aQ9Pe4aY6Ll/Kw7Knn9kWWYmtPYp9VChJ1srvgP7X
         mT4AoPnWMcrxTWY5HTR7Qc2pt0pRp3bQlQaQentibBvnNuNZ7wMQmC/P5AYZeVkP3/d4
         jL2atx9BT+UC/x0n9975M21dorPRs4n49ZbpwfGtZthNb3hq2N6HDGKDdyUybDT7uDs5
         0fHSEmDtgN4xycYNyFjrWWvaA5Xbbmvxm2QzPd6c1MMcBsn4OQywbQrg5ZscldAmquOX
         1b0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742328503; x=1742933303;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A/Z/pn9wn0tCKI/g9RBCorTzXexzQNQDNcvtxOsUlXs=;
        b=H9I56N5lW7OKvYiqH6WjSSd8Zb0ESbzGS1cMEMbB9UurklvF8+QIHIlJPynjQrPMMo
         lGoqJQAmaqQeVqz6ZMtuwTn4+0GhS32DYRwgrpuO7YGalg7y7ycCQm5MHVTN1GiRV20Q
         wOlvho8DNcK146F2v4i/1R3AzZQ3haKFtaBAQHR6U27c3UqeD1i6CrE0M80Ij1fM0gxX
         9IAFmJzc2ZW3fqPbzhSuEqYiZrFv7uQLk5mbEw7uC3uiSwO0DQ79buV3Hi/Vv36wKEzj
         HoBRWeJygGKeze7KxTano0fgwMeU0zZcw8OHVU82iL8M+J3F7GQxoR9LwvX4qacC5f0I
         bUYg==
X-Forwarded-Encrypted: i=1; AJvYcCU+5YbcPrnnZfH83eG4Za86+TJkyKHmqnY8DJj4dOBIqdXUtmslL9CbThteQ6gSg+5H+o90r6y4q1XOch8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqSnKzjIS42TNJuZWCVnKt0FG4xhrMFbp/QUPDVanP9WBtEK35
	Y7ayNyXLWBl8dZizkEzwYUM+iIEDeMfxgXjSrAkn1eqaIPhT7OaJ
X-Gm-Gg: ASbGncukBwl9JYdBYOKVVBNxhx+imeyu+Z+CN7YKZzEp+GZJsV7Bobc3ZjEstLygxVB
	PeaBbRUC+2C+870T2TrJmPja1rhuDYizJsCwGRhBUXcjKwXgaZLB6oyhT2D7iIyZg5Q2QMyoMh2
	guBVLbzjco4cDMShMUiFfmSIHMw749jcvyL8kuNmtlCyCKcaUwVyQX+KvEZUSM91MXw1IGDFwN2
	Xmufmn4eWt0pSlAR4lxuQQiVe1hXGqDJdvmhAz/Jmmrnm2afh9txUfJu4u78Y1rDNcLdh0oxS6n
	V23pTEsBUbw+P70yrdQ4EM3YMaopCwSIDVy1jhKtG7dYhHrSr8xjHGMrgrU6CmVYlUuX3OIheES
	T/OEfidd36TMicSstQkZsvWUBZfoKBMNlK3sJZsnuf/fjFxtGvz8EualeFdqc41eBE+J4mhWrMb
	ioncIOWwOdWPIzHXr3vLUMldJKgBqK+QrN/y4Z
X-Google-Smtp-Source: AGHT+IHMKewdexCO/O2OJVz4LfamSZp6ofKoZSa4bZ/8JYIdq5/Fl9YmnqpkLhcxJxQpSwLDlV/3qA==
X-Received: by 2002:a5d:64cb:0:b0:391:4684:dbdb with SMTP id ffacd0b85a97d-399739c577fmr82942f8f.17.1742328502954;
        Tue, 18 Mar 2025 13:08:22 -0700 (PDT)
Received: from ?IPV6:2a02:3100:affc:8100:fd3c:7c71:106a:a90e? (dynamic-2a02-3100-affc-8100-fd3c-7c71-106a-a90e.310.pool.telefonica.de. [2a02:3100:affc:8100:fd3c:7c71:106a:a90e])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-395cb7ebaa5sm18925531f8f.87.2025.03.18.13.08.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 13:08:22 -0700 (PDT)
Message-ID: <ad6bceac-33a0-4ba3-b967-74bf2221496a@gmail.com>
Date: Tue, 18 Mar 2025 21:08:27 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 1/2] r8169: enable
 RTL8168H/RTL8168EP/RTL8168FP ASPM support
To: ChunHao Lin <hau@realtek.com>, nic_swsd@realtek.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250318083721.4127-1-hau@realtek.com>
 <20250318083721.4127-2-hau@realtek.com>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <20250318083721.4127-2-hau@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18.03.2025 09:37, ChunHao Lin wrote:
> This patch will enable RTL8168H/RTL8168EP/RTL8168FP ASPM support on
> the platforms that have tested with ASPM enabled.
> 
> Signed-off-by: ChunHao Lin <hau@realtek.com>
> ---
>  drivers/net/ethernet/realtek/r8169_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
Reviewed-by: Heiner Kallweit <hkallweit1@gmail.com>

