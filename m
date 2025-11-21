Return-Path: <netdev+bounces-240764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3C6C7922C
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 14:09:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 502EE34B5FC
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 13:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9980B314D31;
	Fri, 21 Nov 2025 13:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kJHXef3K"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94675339B3C
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 13:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763730265; cv=none; b=eEB/ZivMbobzbEhDKHNiUiI+i/SG5PZGnb8XIsT9JOxhrRWnFJWmfNEF+AxnqJg5p/QQ3muTlM24al2tAVqoM43VPQ9Vsh9of2lWKzJpya2Zjl4+RdA9LbAPAW2bOE1Jdzr+kWB8d9+huACZ9+Nu7rRdEz7vjlNJcGwTp7ruVkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763730265; c=relaxed/simple;
	bh=WmDpJwTQ154ISU0m7eNtakVDDgm05vUmUtyAf1ww5Uc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ecx//HJXmyqBTl6AyC/O/FK0s7NRNFXhvmnhrPcCINebBGFwKBcFw7Xe6l78JLetsOT3O2aEN6QRUx+XLqZb0X/zMG0OzXiOYybiRdC+Rv5ObYVcM9xsQPoO0uMfAt3Chqb3xwh52JlY2oq6UpTZumnLb++tysbncNz5Dw+JnTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kJHXef3K; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-42b3108f41fso1245414f8f.3
        for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 05:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763730260; x=1764335060; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+hGhb6xgX2y8Cv4H8jg13ylU4BfkqOlg8uqpNi0jito=;
        b=kJHXef3Kea1hoEyrcYD/HJArOfyPoHdQQmI49l14kfQPL+YMaARkjVZ6jziO8VU+ww
         XY+019I6NQTrKkm67mbBA2bXNVrYj+RJ1aAOld6XjfjS8A80u2uctlWq1jE58hwvDijq
         H/FjAudm4onD26DT7F4GVGKeZUfZMNP5UPdNLhrP4jCioRMWtGLZWdKaS/lShlQDU6lI
         y4JtjUWGzVAAKW8SyqxuxHsseKFU+CLZbfZ0kS2iXLg3ZTMqe0Wzm2JZCStQBfjyrMZo
         vzY42McUu6qfUXEi8MoB1NfJFNcxSzGZxfxJOknjGODp4pOm7yWMDf9s1hhoyojQMWHu
         StUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763730260; x=1764335060;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+hGhb6xgX2y8Cv4H8jg13ylU4BfkqOlg8uqpNi0jito=;
        b=IL2HC3pWyUl5m/8KjejDVnfqcwBTaxmqfAAM1LXGNjZb2lKop+wWToNmumL6gRdpeg
         /VA3fAxJSsbx2EVuyj1BvmEk2JXg+dd6Ub3OdDR+KiDL1WPzRg18hyaaUdGUkebZ6klY
         j9exbdUDpWj40SNhebBlE3QB8Ai4L9EBKFR3KQNyPaHBA3PFZtsPoFXZBYIPx4BE5wa/
         etvwXay96vkM0FTOgx6j7haXAwvMTl56U5sHGQqt4HunHS+FluYTC+0U1wp9Osh9KQbs
         /nBQGx8eYn1wec+UkTHae/wYFUo6Mz8w+Ii3/60q1I8ghzLDPAhHaQEOW7NlBivx71J2
         IIww==
X-Forwarded-Encrypted: i=1; AJvYcCX3UOCp5WFceFtGZgn22g/byMYQ5Gye6VinyIv/n8L/omBIKN2ORuT+QDdjHOOilsivs5oPshM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw3qqNr7b49Eer7ap4GibW8Ny1dBkiwgPgArtMYAOI1pUY/sMF
	nNcXMk9xFTjkZfWhiG6fHMPYw9SLKaRtJKVRMskuxprz4q+jKqkdb0Kj
X-Gm-Gg: ASbGnctUN3akWvcHK+Kt3v+4Py+ERJz7kTckQhSCnMqEsdKZ/niY15l4ZF5Frgtm0ne
	3JUzHhF8Zj1RqEueLrQeWMIUZr2F0qWQiJuM8y69WDtL0N6+OqpSxwK3Bz26rpXczF4rQClCtE5
	t/9kM77ie6FY/Th+zF/ju+dyhQfVSzmIl1Zsh7iYRCoe7JbHHadDXnCu9NoHAzWd7dfwYwZP99h
	UhjI1OHv8GSXLEBW258UzaHe5ClVB77agu0a6+opd4aKABVyHK07Ls4pAMd591TVZVPlAC6uhj3
	BfD/Pkm7GP/ZnxDHX5KbkrXPa78NOYxV47OAOVtq2DEfGcMRW4lJCQ2z/FWxxDq2LcjHl0/OlPv
	z3LRLLe0/WmxPVg4UZE301e3yFQVzTUGd7hamO1zuolMp7t/N7nNBD7YWCwz1ikHRBeHnR85rGB
	8Le4gA97ynrPzi1/6MZG63Yw/zUFFwjAr5qCuRqNCDHUU=
X-Google-Smtp-Source: AGHT+IEUyfkkATekh7ulM7LuJzIlOC1XYWL+JvSgyjtOyj7Vn540ELYt7m8DbsLt3VH5KIz9Q8D7Qg==
X-Received: by 2002:a5d:64c7:0:b0:42b:4061:2416 with SMTP id ffacd0b85a97d-42cc1d19643mr2343892f8f.52.1763730259856;
        Fri, 21 Nov 2025 05:04:19 -0800 (PST)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87? ([2620:10d:c092:600::1:813d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7f2e598sm10743641f8f.4.2025.11.21.05.04.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Nov 2025 05:04:19 -0800 (PST)
Message-ID: <1f13f400-206e-4ea4-9225-079672626024@gmail.com>
Date: Fri, 21 Nov 2025 13:04:17 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/3] netmem: remove the pp fields from net_iov
To: Byungchul Park <byungchul@sk.com>, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 kernel_team@skhynix.com, harry.yoo@oracle.com, hawk@kernel.org,
 andrew+netdev@lunn.ch, david@redhat.com, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, ziy@nvidia.com,
 willy@infradead.org, toke@redhat.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 axboe@kernel.dk, ncardwell@google.com, kuniyu@google.com,
 dsahern@kernel.org, almasrymina@google.com, sdf@fomichev.me, dw@davidwei.uk,
 ap420073@gmail.com, dtatulea@nvidia.com, shivajikant@google.com,
 io-uring@vger.kernel.org
References: <20251121040047.71921-1-byungchul@sk.com>
 <20251121040047.71921-3-byungchul@sk.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20251121040047.71921-3-byungchul@sk.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/21/25 04:00, Byungchul Park wrote:
> Now that the pp fields in net_iov have no users, remove them from
> net_iov and clean up.
> 
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> ---
>   include/net/netmem.h | 38 +-------------------------------------
>   1 file changed, 1 insertion(+), 37 deletions(-)

Nice!

-- 
Pavel Begunkov


