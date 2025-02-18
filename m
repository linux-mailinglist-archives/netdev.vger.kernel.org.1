Return-Path: <netdev+bounces-167528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 336A2A3AAD2
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 22:25:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA6E7188B68B
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 21:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA731C84DA;
	Tue, 18 Feb 2025 21:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="FS95BqjC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D4D1C6FFD
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 21:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739913954; cv=none; b=ScttfbxxjJBp4eT3/nXJ9XoLTa9U3Iu7tnWLVMw22/9t4pFfWc1l5e6KheAiY0tvv2NLXOe/audwwjyMwAB9POdIdudvPajgniIb4jJERV6q9oxfqE4rg75hM/PfbMp0N6JUjjfN5O4/CICl8jLCVh5XadY+gQyxuDhWMtTrcsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739913954; c=relaxed/simple;
	bh=h4/2Ifu71s1+Qsdc2hbTYe1Z8ycfoZcWEq0JTHVjgUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jgPQgnwJ7+ZKG9a2HBQI1czi3CZkzimSagv3pGIU2qT7fy/5c2Gfjw0jJjWzptvYCRjwJhesVeZwtlQgEArJ8T54XxgRRfOwqZrzuK/aNSnw3cRqp+0roCKCB7vge/GJDbWa5A9Lggis80ydMWO/KOvfzeCLXsnEkpRTpNxUwuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=FS95BqjC; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7c0ade6036aso22491385a.0
        for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 13:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1739913951; x=1740518751; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2B9HcEB8su+I6sy6fueVdBm/jXwAuJHPoAC9KvMC6uA=;
        b=FS95BqjCz6xWQfV7KowP+cwXZpXZ7oS1qw366293xTOGd6s+22prT/7RjPqYAyPeLv
         DIb0uuCDqS9k08pAbb4WVxnhaPYfLAgfOMdgabtfFoc4NmO64olX1DA/NLe0i1qG8o+x
         ugoKCwty4Cuc6NtrUg8XodXwOQg/I50zCmPWQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739913951; x=1740518751;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2B9HcEB8su+I6sy6fueVdBm/jXwAuJHPoAC9KvMC6uA=;
        b=SlFm/ndaDPQnadn/SlPyRpA0TGgyE0fm1fh2GEH2k0NHsFNECD/jJS4ZyvhrA875jP
         RnP8dLiM71AqKGbGj1EMZs9JV7XIw9Gu8Ni99ukaXNAvdUYsxha4GIq+Sh2kjLBcShZ1
         L5HTH0EJUeQP/1wMO/RqwahNkbqekWJKwMrtBl6PUvy2bUQxL+9Tnl8TqSnOdjy3L+Vn
         M4SPJDRiWqVdsB3jfGJVP7bd0KHOqFReeVR/yCocT4GBjup0ByTznckh3DXpmFVSPOL7
         d+wFey4VB71Rtc5FJPyIJtHYq8+Uk/JYJ7PjjCqQfhl/NFQ1pXGv/SQM3CbqwGXFCIJg
         I+sQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVDRr4X5JEoq9tY8nsuL1p3P+7C6ChEKXwYqFRSWcalBtx4CNXwtzuFNlzLTb5sCXayHCxgsU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXqs+GC1tSS4v+k79DEq80RzZvvH6zjfsAx9/B0YyyqF5dNaXE
	3ZilaKsjjRFbFAlUuchZXL2Vg9AsOCOh3ypeW4aKoOsJhVyqRJaZ5s11IJyCHtA=
X-Gm-Gg: ASbGncuOTmn98X5txqKRDVFFy6qFVq1fuysGJkKw5YNI7DjaG4B7iL7k28BoRp0jvLG
	tcM0k3UV9M7wrsCBmHyssZ3/BaWz2taPtkd2S5tKzECRmGhHABBDQWz4RvuVZVGefQKNKGdvEbI
	C8gXkVg3pL1vutmZYc/msX2+8DjMAEmLK1qPuTyX+1zgV35/NzMpOFnzx9Lk52scQz1cXge1OVn
	yYoL8EByUTfwr59/g8/2PpkXB4C9He0ZO6vRS46//q1ZZ0NOwc+qwLXXiO9RWCSq5keWnbbZE2T
	uI7WUohQjt/Qr8AH2Em1akdLMiEh72O0TM4JkjjD9QW9pmH/pLThoA==
X-Google-Smtp-Source: AGHT+IGGMlJhuVPem1hvggd7sSQ6qaKplJpy7kdSeYAIc6J23V81FcXX0ixrsP14ifZSvYsR1hyRgw==
X-Received: by 2002:a05:620a:27c1:b0:7c0:b422:e2ef with SMTP id af79cd13be357-7c0b4cdd42dmr217218785a.5.1739913951656;
        Tue, 18 Feb 2025 13:25:51 -0800 (PST)
Received: from LQ3V64L9R2 (ool-44c5a22e.dyn.optonline.net. [68.197.162.46])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c096e87af7sm327894185a.79.2025.02.18.13.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 13:25:50 -0800 (PST)
Date: Tue, 18 Feb 2025 16:25:48 -0500
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	shuah@kernel.org, hawk@kernel.org, petrm@nvidia.com,
	willemdebruijn.kernel@gmail.com
Subject: Re: [PATCH net-next 4/4] selftests: drv-net: rename queues check_xdp
 to check_xsk
Message-ID: <Z7T63MIQEdgrgWOU@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org,
	hawk@kernel.org, petrm@nvidia.com, willemdebruijn.kernel@gmail.com
References: <20250218195048.74692-1-kuba@kernel.org>
 <20250218195048.74692-5-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218195048.74692-5-kuba@kernel.org>

On Tue, Feb 18, 2025 at 11:50:48AM -0800, Jakub Kicinski wrote:
> The test is for AF_XDP, we refer to AF_XDP as XSK.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  tools/testing/selftests/drivers/net/queues.py | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 

Reviewed-by: Joe Damato <jdamato@fastly.com>

