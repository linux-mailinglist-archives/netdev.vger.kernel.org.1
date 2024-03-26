Return-Path: <netdev+bounces-82210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A9188CA7A
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 18:13:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F1B628F94F
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 17:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F63A1B28D;
	Tue, 26 Mar 2024 17:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="1Naru1UQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDAA1C69E
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 17:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711473165; cv=none; b=IKX+R8PrA2kGR0aGIguXuN46rDd+AG7BlvEwzaa2C+sVY+PoDFFwUBzU8P1D4ddxvZfqBsIKRtEewynsaNgksadHNtN4hB40SSNk5zphBYigKwBJYDIcTAEECtLhrt+JjEDriHCJh47o6eA6G9EUAIRySO64u9P5wJrv3AJoalo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711473165; c=relaxed/simple;
	bh=68zkLJbxYYmwUoOB0L6Mut+xqSnMcNf2y/wAtt/JDdk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RIeDG0eytpZyMjS+QiE6tRSy5lox0eahFtjywmPLd/YqUxzP7iQ59GzliQ05A5/N/f4Yi7DUsBc+E8Wq8YgTZjGzclDhoDKoWKnzjihEo/5UpPTBwgpZcT33lEiPdFgeTFUMWLI4rQijbTLs9k1nQQovacBZrwqVQmLU6hOJHOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=1Naru1UQ; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6e8f51d0bf0so4616656b3a.3
        for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 10:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1711473163; x=1712077963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=68zkLJbxYYmwUoOB0L6Mut+xqSnMcNf2y/wAtt/JDdk=;
        b=1Naru1UQWTn0v6LNMsAhGaXxzxkukwBOOpniibHlqnvlBDZWtjZaovT+JkD72nwI78
         OeaOcfW8W+mmVa8XqZnNLGMa3Fk3DS32edtZklkW3jdGfABMi2Do8BtGNAPclNVSVd/2
         cO2oHvmjcI34bmDlSS0qR+lsh3ytM2m4bMyHxR3yXFaGu5uJYDlCQ9uocAyhDBFnQFIu
         X+V7fayFBN8h1mCGjxEf2iuiBeU9CA1b6ioeb+QqKbe2OzFNiSgpJazW+YSNW3XUZL6X
         JkSBVSWLTz8u8CncKvg5cSsJYSip9pXDtciQ07A3DeSlLdv5CHPhoiWtngfj4IsB65jX
         K0Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711473163; x=1712077963;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=68zkLJbxYYmwUoOB0L6Mut+xqSnMcNf2y/wAtt/JDdk=;
        b=uG25Yg7w4zRymCKRuo3GMl19GXwbH0CMfByb/cnQmAvdTswRoKN0jWA5BVTnCwBNLS
         +ehkICm7pwZ3diEytEfraNyAsYH7AMj+qIDqHd1B/ezGl7apGImOO8JDRlTQNSuk7bzw
         yCpjE1UlbKFWqCjsEzgywXMsbK0K3FQY0YpIKT5Qe0SSIP4VpOeu4YhypoEsY986I0hg
         GqHS/5GNtW3ndhM1IvouV4trt1K2VQStOaeRvBcGvzOQzUlCfRnoVua1XVn+w4UePkQa
         qUjuq9D8NlXQBdXYCh1EcJjv38keykuAtANVj24dS/8CguOhQX9u7BJuIxzTopIxzwl7
         5/CQ==
X-Gm-Message-State: AOJu0YyQS19TTyI4KfGSB8L/W29H98WVsxfPccUx1/s9xHYgGafr3xyw
	vwzUN53ngvSijUWutbC//FrW5H7lfvObNoCiyrdxhJm1bxUJe0iIiwBr0GRK0eQ=
X-Google-Smtp-Source: AGHT+IECOLNLA33Fh1Dtl1xN+3+um96Kiy22pZAzpu9xyTE92JwCPZuR7PyVH2KwaoFfaTWWhbwu0A==
X-Received: by 2002:a05:6a20:4d94:b0:1a3:6833:1cf5 with SMTP id gj20-20020a056a204d9400b001a368331cf5mr2559992pzb.29.1711473163178;
        Tue, 26 Mar 2024 10:12:43 -0700 (PDT)
Received: from hermes.local (204-195-123-203.wavecable.com. [204.195.123.203])
        by smtp.gmail.com with ESMTPSA id it13-20020a056a00458d00b006ea80a9827dsm6199912pfb.82.2024.03.26.10.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 10:12:42 -0700 (PDT)
Date: Tue, 26 Mar 2024 10:12:40 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Lukasz Majewski <lukma@denx.de>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Eric Dumazet
 <edumazet@google.com>, Vladimir Oltean <olteanv@gmail.com>, "David S.
 Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Oleksij
 Rempel <o.rempel@pengutronix.de>, Tristram.Ha@microchip.com, Sebastian
 Andrzej Siewior <bigeasy@linutronix.de>, Paolo Abeni <pabeni@redhat.com>,
 Ravi Gunasekaran <r-gunasekaran@ti.com>, Simon Horman <horms@kernel.org>,
 Nikita Zhandarovich <n.zhandarovich@fintech.ru>, Murali Karicheri
 <m-karicheri2@ti.com>, Jiri Pirko <jiri@resnulli.us>, Dan Carpenter
 <dan.carpenter@linaro.org>, Ziyang Xuan <william.xuanziyang@huawei.com>,
 Shigeru Yoshida <syoshida@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 RESEND] net: hsr: Provide RedBox support
Message-ID: <20240326101240.65c28519@hermes.local>
In-Reply-To: <20240326090220.3259927-1-lukma@denx.de>
References: <20240326090220.3259927-1-lukma@denx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 26 Mar 2024 10:02:20 +0100
Lukasz Majewski <lukma@denx.de> wrote:

> Configuration - RedBox (EVB-KSZ9477):
> ifconfig lan1 down;ifconfig lan2 down
> ip link add name hsr0 type hsr slave1 lan1 slave2 lan2 supervision 45 version 1
> ip link add name hsr1 type hsr slave1 lan4 slave2 lan5 interlink lan3 supervision 45 version 1
> ifconfig lan4 up;ifconfig lan5 up
> ifconfig lan3 up
> ifconfig hsr1 192.168.0.11 up

Learn to use ip instead of ifconfig...

ip link set lan4 up

