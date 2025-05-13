Return-Path: <netdev+bounces-189994-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE1D0AB4CE3
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 09:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 547A8463FA1
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 07:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8011F03C0;
	Tue, 13 May 2025 07:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZJ1+5Bkt"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0318113DDAE
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 07:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747121865; cv=none; b=E+pDJkesz14Ea4nQzsZosDs9G1RgY2vUFvIrTeGNrdOdbeIQcXWGzVRp28w89O6a9G6pSxMK5LlR4Nu2SjD3ogDdQqMA2hW5rin5BESH9+38dfqh9uE1s++SXVHCc/MVqriF9SYH795sKyhKL3clBIf4oNeIG0pxDDudgFigeiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747121865; c=relaxed/simple;
	bh=8EL532QxwybIjdh7hpL0YY//sxScc1pNRRPsqEZbtE4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jDCG0vzMACv07WI92Q6Jvvx6lJ501MsS9TDGytrdsBP9/qU6fgrpZ7b6z+EGBN7LrQKuYuBe9s89CdVDnKztuUqD2sny+08SeV+ZozRg6++znBhU2X+kCTD+dgySOge4N57ibLOhZCrVxyPfu4SDQr2APiklRaAIH3onzBI9UTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZJ1+5Bkt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747121862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hHB8DBrFGnG02wN1fkUDUgmS7KPy0rPtzQKBAsYhlCo=;
	b=ZJ1+5Bkt+e0npYsZDa1FqIPC2PwybOIB2rOD0SMQ7IhZnEEqH3z1jkDz15WNBW1VJs3fGe
	PicX5XykmQ86F58l03JSkJNRxXbmVi8wC2vnrcP5lVw0vIRft6eJv/iv4NJeJWrNN8kG2m
	em7wEChU5KtUD6HTHXstwbhVRvtDY0A=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-voJH0d5IOBCS-sAqMmSjdw-1; Tue, 13 May 2025 03:37:41 -0400
X-MC-Unique: voJH0d5IOBCS-sAqMmSjdw-1
X-Mimecast-MFC-AGG-ID: voJH0d5IOBCS-sAqMmSjdw_1747121860
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a0b9bbfa5dso1792589f8f.3
        for <netdev@vger.kernel.org>; Tue, 13 May 2025 00:37:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747121860; x=1747726660;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hHB8DBrFGnG02wN1fkUDUgmS7KPy0rPtzQKBAsYhlCo=;
        b=rKz8DxbXgsL6dDTYDiznJJZetPo2Qqyh79itFpOH1k24NfD7Ejpz/XRQEYbTFF+Coz
         mIPh6YopcrVxkuyD4FHeiahzNZNbn7sdiXGcuHghWd3y0Wg2hVD5O+5IoEh8iqh/OWse
         Gc0AzrNPZEmZWrelETol/3Ppiai+zoM70z2iHhB9BhKnhkVaU+x7qLI0BBONLoL+r5d3
         TS5PDWaGrgt3aDAXvo+fD0BL/aK3hS7cxcDvPL/lQvq4ezsNVvNBYZ9WTtiGnzaedQfG
         PSS2tiMMi3u8RWYl57xLjwzIuKE41NW7kyJDF//BjRy5g1TaO6XeYUATf9NJptnHcmOz
         f7Uw==
X-Forwarded-Encrypted: i=1; AJvYcCWIMa7tumcxrswK9/BUaYv6yd/Sz4s5YWr/jCMFsP5DwJhDX74DdhaT5lt07bH8HBKUrcYzI0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5r52cYzSdRg7rYPsG+LqzCthO8f94b9FWILeRj8wPyrQyqSDj
	1LhoXLj+VDPVm23oT3Y/SsZFJ/BnvD8+t2F9BT5vPN4m16a73WibMxKNySGCs7flrhXZbw+rLuA
	eI0SitJ4PzIU3eyMSsqGLBCweBWetNTtA6WeRyrH7Tk0RWOnzhVU74g==
X-Gm-Gg: ASbGnctE8I6HeGM1Qra5gOLhUbgTZsFVGtpTg6zGs/383Oo00q14KtCa59/1V9E2zLI
	KcqqAWlHX18Ljc+0grmzVnQI2UvMOSS8/B3eQukqpn0B+5mn12J5iPszFdEEbPYpa2uVItGjRvR
	x2TxE2IZCxoG4OFTnADHyUDGm4JvsILuebEZnFT2mF3XigR7cx2fEKJEJkBvbC43lOB6HIYrgWr
	Dz7jtmOIJyF/SSkXpcX3rA3p0QnzqjxWxVgAYtJbWloLXlDvHc7Z2/rm2HFJU3XHAjUD6Uah5AA
	PTVysW1m4IokiY2wZx4=
X-Received: by 2002:adf:f7cf:0:b0:3a1:fc91:f784 with SMTP id ffacd0b85a97d-3a1fc91fafbmr8815359f8f.53.1747121860355;
        Tue, 13 May 2025 00:37:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEaK/g1mGdSfqcGQPqSnCiHZbas9y4jtxR7vVRqrWtsCb7DC68dmc78ap+na8TSEiAh+PKk2g==
X-Received: by 2002:adf:f7cf:0:b0:3a1:fc91:f784 with SMTP id ffacd0b85a97d-3a1fc91fafbmr8815343f8f.53.1747121859999;
        Tue, 13 May 2025 00:37:39 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:cc59:6510::f39? ([2a0d:3341:cc59:6510::f39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f57ddd53sm15106407f8f.1.2025.05.13.00.37.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 May 2025 00:37:39 -0700 (PDT)
Message-ID: <fc07f58e-488e-490e-a33f-50f09163a0fb@redhat.com>
Date: Tue, 13 May 2025 09:37:33 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 03/10] ovpn: set skb->ignore_df = 1 before
 sending IPv6 packets out
To: Antonio Quartulli <antonio@openvpn.net>, netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Sabrina Dubroca <sd@queasysnail.net>, Gert Doering <gert@greenie.muc.de>
References: <20250509142630.6947-1-antonio@openvpn.net>
 <20250509142630.6947-4-antonio@openvpn.net>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250509142630.6947-4-antonio@openvpn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/9/25 4:26 PM, Antonio Quartulli wrote:
> IPv6 user packets (sent over the tunnel) may be larger than
> the outgoing interface MTU after encapsulation.
> When this happens ovpn should allow the kernel to fragment
> them because they are "locally generated".
> 
> To achieve the above, we must set skb->ignore_df = 1
> so that ip6_fragment() can be made aware of this decision.

Why the above applies only to IPv6? AFAICS the same could happen even
for IPv4.

/P


