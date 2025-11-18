Return-Path: <netdev+bounces-239730-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 194EEC6BCD3
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 23:03:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 11C8D4E4AAF
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 22:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCEAB283FF0;
	Tue, 18 Nov 2025 22:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TQlpTm96"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2833225C818
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 22:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763503308; cv=none; b=M480gg3o6/1qO7oEfAaak+6XuxsI9qsYwzlmEcEIQBMCoqxB/ur4X4mDs67+ykdoITvu3ZAC1XhSkxjr7EvKN55toCT0oq6nD/zN/TH4nhHWmbAP3gFmtXwl6xuw8gAwfSi11vslGq37UowCyOPwuSqXTNVXFcrLTSM0t6W8BEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763503308; c=relaxed/simple;
	bh=VxzyG4LUyqSss8TtW+6ssOa1nK8AYBqmOYLe1JvodF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WFp+5mOjNiljA10H7XOi5tSHHLVAV8a9jFc8J04adK0iKKOaEbGqEoEse7eGoLiTYoS6QYJvCWq+Npeo/3WPEO54WOgIBVtZqSZuacbmKY9klhy7WfZ2YpCGJ0S3mVQF09pRxei7e750pq1JUOcNSM6C0nQN9lfypzV2bz3w2gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TQlpTm96; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4779a637712so25262645e9.1
        for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 14:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763503305; x=1764108105; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jXah3cbf0knU5Q6XpR431aW6C9/9DUU4ivHmHxyWSLI=;
        b=TQlpTm96zf6nH1Le/dg+uARpoAcnIvNhuxzD5NT7nUVXMA/n9DlS6/QJq5mjRLUmiE
         cH0Fy1u7SLZRBSSiOOvGNpxLSUbnuX8H3OEDd49h0bBq+UFXCnh42LXA7ktFoySTrjvK
         y6is/RUAO1sbq9VdZxLRblLFTr7QEH3g4aE0uQPztXRVkiuLkdvmpQdfHcZOofch3MRY
         xy7AJIDReXR7QcNcYTmbVNSk5+vy/txLB0IVFMLPlc8CBTS6YV4U+gRfhFqMGgm9mfZ7
         LvForJr19khcYJ8Fjw/17g8CpGQCGp3UnPD2lWk2GYApJdGOCKxqEooayd5ExXjVRswS
         KwAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763503305; x=1764108105;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jXah3cbf0knU5Q6XpR431aW6C9/9DUU4ivHmHxyWSLI=;
        b=Qb8QfWtZswbX6rIuGwwlFZ9C+SFPdoiA3+b81kb4uSMMWjQlP+CQCD0uF/TR4NpxJS
         eRcOVbg7bwHaW4rXrxOVJn+Q9m+MVLQXDwrLEAGlLlNIthwu3TM2U07oqlcZOdrr7AxM
         fqlfZqHxJxFvVRwOlKoU/XTcBb1A3LHFpJzj3fhkU5zXht7py5msoHdIKjKxRQ18KhLG
         U9OTff7QH6YSzKOAoqibZq5u4r4SElk1CmED3LiIqtHS4Z099LLcXQNigKh/Pz/xt+1T
         XpeVUWPZ6+/51Y090SIlaBGbXQircjD1HaSYhd5vLFhU8xuNyqx6pV13XN0LOmlnAMs3
         CgMw==
X-Forwarded-Encrypted: i=1; AJvYcCW47CrQw9dmzpKd7k4nMkjvllc1DeRdcLrWoKPCpxa+orc43AnRr4kx92ATaBsOUVUPEGX+mXE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5bklDKJMIkcw6EYV+shaMz0MhOFS41HsurcvBswJk4mXLLOHY
	W43yMWMtkZkSXZ8HyDvU29B4EUJndyyyxY+KBYfFUrw0SYPtb7Cmkfh/
X-Gm-Gg: ASbGnctMtzjfaYL5P8xmVDesxlV8Nlt2lYeFA52DxO0dxjTgtN9CUJ8ft6xPz96ueOl
	sxZGa64IMZFUvCZP0RK7Hr/f9ANw1XloVl3eyFfU+Mrht1i44ZSfWn/5V5zAQrfXROBmODYmKHf
	e+zuVXoMI6ieEW7RmV1ZIOLMb0G+MfPVIzAWFfctIugKPLEEK09I8pacHAABogKNMAosLovahgZ
	jYJyaIrxV3xp2oJSrgB7H8FnycpOaqBtx1HEcnkM6X0giAn6PO74XHWUwXsQM2kA50omm+CycoI
	7sdSHrr3BXUl1YGTFwMz6CfWcCXu+pfHQBZ24TgVlRmV6Ev0SBCSO4uhMMSJjVvCQVZ8soLW89/
	whu9ETSB1osSzzvh44CGFgvWpoHYwzbdzf56xVqag4D4dH0Cg5jUhdKfMyDB3Zv8msL2ceIeNhm
	VW+OFshAXc11wuinkGtFFhJqS6fg==
X-Google-Smtp-Source: AGHT+IHIQGSmUQPOk/uWxSPLANaIEivihxczJ8iiI0IlkCgOa+nW3ISphTxBgacrfZYBDxXLPgqxwQ==
X-Received: by 2002:a05:600c:6287:b0:477:632c:5b91 with SMTP id 5b1f17b1804b1-4778fe5fabbmr219822505e9.16.1763503305357;
        Tue, 18 Nov 2025 14:01:45 -0800 (PST)
Received: from google.com ([37.228.206.31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477b106b10asm11972555e9.10.2025.11.18.14.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 14:01:44 -0800 (PST)
Date: Tue, 18 Nov 2025 22:01:42 +0000
From: Fabio Baltieri <fabio.baltieri@gmail.com>
To: Michael Zimmermann <sigmaepsilon92@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	nic_swsd@realtek.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] r8169: add support for RTL8127ATF
Message-ID: <aRzsxg_MEnGgu2lB@google.com>
References: <20251117191657.4106-1-fabio.baltieri@gmail.com>
 <c6beb0d4-f65e-4181-80e6-212b0a938a15@lunn.ch>
 <aRxTk9wuRiH-9X6l@google.com>
 <89298d49-d85f-4dfd-954c-f8ca9b47f386@lunn.ch>
 <ff55848b-5543-4a8d-b8c2-88837db16c29@gmail.com>
 <aRzVApYF_8loj8Uo@google.com>
 <CAN9vWDK4LggAGZ-to41yHq4xoduMQdKpj-B6qTpoXiy2fnB=5Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN9vWDK4LggAGZ-to41yHq4xoduMQdKpj-B6qTpoXiy2fnB=5Q@mail.gmail.com>

On Tue, Nov 18, 2025 at 10:31:54PM +0100, Michael Zimmermann wrote:
> One thing the out-of-tree driver does, which your patch doesn't do, is
> disabling eee when in fiber mode. I'd suggest something like this:
> @@ -845,7 +860,8 @@ static bool rtl_supports_eee(struct rtl8169_private *tp)
>  {
>         return tp->mac_version >= RTL_GIGA_MAC_VER_34 &&
>                tp->mac_version != RTL_GIGA_MAC_VER_37 &&
> -              tp->mac_version != RTL_GIGA_MAC_VER_39;
> +              tp->mac_version != RTL_GIGA_MAC_VER_39 &&
> +              !tp->fiber_enabled;
>  }

Heya, don't I have exactly that diff in the patch? The second chunk

@@ -842,7 +843,8 @@ static bool rtl_supports_eee(struct rtl8169_private *tp)
 {
 	return tp->mac_version >= RTL_GIGA_MAC_VER_34 &&
 	       tp->mac_version != RTL_GIGA_MAC_VER_37 &&
-	       tp->mac_version != RTL_GIGA_MAC_VER_39;
+	       tp->mac_version != RTL_GIGA_MAC_VER_39 &&
+	       !tp->fiber_mode;
 }

