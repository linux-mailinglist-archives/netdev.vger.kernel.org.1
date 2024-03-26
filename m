Return-Path: <netdev+bounces-82062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C277D88C397
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 14:38:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 467C1B21F6F
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 13:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C8F74BE8;
	Tue, 26 Mar 2024 13:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ANhScBWi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F57E74437
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 13:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711460314; cv=none; b=sgOjcOiZ5yPlS/Bh6+OO8tFbfv3Q7e2oyyAQgrHCnlbIpAHilvoQsC290Bt5I7EaNn6SB3KYG/8se1gSYKSglBORUKGMnQ5GseKCn80V3AXnQ5rQ6M7D6c6TDevYjj1a0OcdhjvNI7RUKb0ZbzITXOKxDfqHz74Aj9iMmqgbpwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711460314; c=relaxed/simple;
	bh=qQwh5DXV1GR5CLqTlfRtZ8Epr2JKbvZ81ftaZW160Cs=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=PuMhC00i94KV0j2EfIcJ2pe2eHZch8hh6EmSwBNFBMaAn5b93vC4e6F3HVbJhpB+KPj0qfIRFMKRb/CEmGJ6ZlWufNuv5bOGyGmYlT+YpB78OTYZ8DhA83Hc8vjZ21B278Fucg7OLqcMj4WxIcs7Xwl1qr3gDXsRzbe/yvuiBwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ANhScBWi; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-42a029c8e76so37602671cf.2
        for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 06:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711460312; x=1712065112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zwOLi7NSLkcwvI/HWZn8thc0v3Y0sRe4RVro70EHshM=;
        b=ANhScBWiZm6Mx6RaVff7o50qgMRxUzqNtv4KcjU+TW7SQ3Jdm5AONAznXU9wgzHp7L
         4e2mlA5Ev7zaiFkBmuqPKeFe0pxmOn8lrFAib1LnzvsSDHIXJ5IcOJ3MveABdcjOqwLp
         dakxgGm1fDEGqOvqf7BExX94Vr/xHWXK6BXhcCba/qNPAsm5KJTL+8N6o6yNt5wIeAri
         IjPA6YvwNtyXv++AKnqKFs7XBN4awA665LXze2d0hRS6fXgrDBEyCOLN3DrTAIQQ9NB6
         Q5ZnMHbTcmmdTailvjeUZJ6lry9PxtYmOONxncGWdAET8Ar2q6P/YSW9orPHuxK3hVO6
         d5GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711460312; x=1712065112;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zwOLi7NSLkcwvI/HWZn8thc0v3Y0sRe4RVro70EHshM=;
        b=apHMPd1lhoM4Nd225VOeaf7plRBn33JhLUXfhOzQqbOXo0De2LKR2VTLxdqsZoJDDq
         df1WuK0iQ3yGjOk0WLbq9l0dtf0kdYMW3Tgl5mnFo7PNBZl0Kx5W5lxf/0U1Ac1/l6kC
         +bGujefRx3VTEQiPKgyqHSIRzHGjJnd1Mbw1Q/gQNekjMVPzuzs7wTuXHzbPElur4aro
         Q3QZEbPZEj5wQUuSaB6VEoX4clgEXzWi7Mt2szYlXxApb+o18ZEmBBx49yMySoo4GMe5
         PZORNDekiMUTgdfGMjiNO3OyG2sBY6khC5G/ZjyBEocqv2Ls1aKIusNmzGQtgZC6gPtc
         U/HA==
X-Forwarded-Encrypted: i=1; AJvYcCUnZafkE5Y005+Q4aFTcDccvHxAr0O/ko61PaZarGl9l5QI9iSlGufBGuLhAXj0TiqKz/+H8BOHRon1zTzTP0LWUTadkV9U
X-Gm-Message-State: AOJu0YyF4pU51Z9vUxiSk4rVN4/0bSzzO27bKzZ3ppvq+S7vlL5u1Wqa
	LJY8x62Bzc1P2GBoBaAB0tjqwMs0mXTNQnRe8wgEesUbdEL1xBO+
X-Google-Smtp-Source: AGHT+IGepbKqOqViYIISQErMIslRUSe01L9wDJYnxx+/aubLMw3epRyKvHv8YNNWNzb02Qy6EAx6Ug==
X-Received: by 2002:ac8:5a43:0:b0:431:6078:a2a with SMTP id o3-20020ac85a43000000b0043160780a2amr2945983qta.19.1711460311878;
        Tue, 26 Mar 2024 06:38:31 -0700 (PDT)
Received: from localhost (55.87.194.35.bc.googleusercontent.com. [35.194.87.55])
        by smtp.gmail.com with ESMTPSA id bs8-20020ac86f08000000b004317485a4e9sm354919qtb.66.2024.03.26.06.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 06:38:31 -0700 (PDT)
Date: Tue, 26 Mar 2024 09:38:31 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Antoine Tenart <atenart@kernel.org>, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 edumazet@google.com
Cc: Antoine Tenart <atenart@kernel.org>, 
 steffen.klassert@secunet.com, 
 willemdebruijn.kernel@gmail.com, 
 netdev@vger.kernel.org
Message-ID: <6602cfd748870_13d9ab2942e@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240326113403.397786-4-atenart@kernel.org>
References: <20240326113403.397786-1-atenart@kernel.org>
 <20240326113403.397786-4-atenart@kernel.org>
Subject: Re: [PATCH net v4 3/5] udp: do not transition UDP GRO fraglist
 partial checksums to unnecessary
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Antoine Tenart wrote:
> UDP GRO validates checksums and in udp4/6_gro_complete fraglist packets
> are converted to CHECKSUM_UNNECESSARY to avoid later checks. However
> this is an issue for CHECKSUM_PARTIAL packets as they can be looped in
> an egress path and then their partial checksums are not fixed.
> 
> Different issues can be observed, from invalid checksum on packets to
> traces like:
> 
>   gen01: hw csum failure
>   skb len=3008 headroom=160 headlen=1376 tailroom=0
>   mac=(106,14) net=(120,40) trans=160
>   shinfo(txflags=0 nr_frags=0 gso(size=0 type=0 segs=0))
>   csum(0xffff232e ip_summed=2 complete_sw=0 valid=0 level=0)
>   hash(0x77e3d716 sw=1 l4=1) proto=0x86dd pkttype=0 iif=12
>   ...
> 
> Fix this by only converting CHECKSUM_NONE packets to
> CHECKSUM_UNNECESSARY by reusing __skb_incr_checksum_unnecessary. All
> other checksum types are kept as-is, including CHECKSUM_COMPLETE as
> fraglist packets being segmented back would have their skb->csum valid.
> 
> Fixes: 9fd1ff5d2ac7 ("udp: Support UDP fraglist GRO/GSO.")
> Signed-off-by: Antoine Tenart <atenart@kernel.org>

Reviewed-by: Willem de Bruijn <willemb@google.com>

