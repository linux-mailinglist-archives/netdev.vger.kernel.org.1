Return-Path: <netdev+bounces-158790-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E07DA1344D
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 08:51:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 727B5162D06
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 07:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00631917D9;
	Thu, 16 Jan 2025 07:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kgqqVpWe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAE2156C76
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 07:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737013891; cv=none; b=CEr7BEOZsOfF1TOTcSrYpdyvcC+hWLzPWVRmKiP9RtI9br29ZdSbKAeNMXKh3Xokg/RZ0kYA5IL98dwA93XmzhgTuizRgBG6KYTI96vEPTHE7ru6bTvOPIlkrTiOZKjtlnutjN8nV9aL9NLYvYU+bCOzZtZD95l4g8Px0t7j1Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737013891; c=relaxed/simple;
	bh=8I+04AwhM0Y1+1Fh5biVpdLR6Blu36k00nrrspUY13s=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Content-Type; b=DXFgUqJzhM0dT4zDxQhiPfmVWzRx7yNst/Z5lGYjePK+Fjnqn9yM9T/Rbs5ZKpeulHE4DEtKYIuvXdmZH3+dyjTzyYv/GLk2bzWllU7akc+FNnpUzpt9FZTlgr6eDT25c86sPj0VM4gGzHas7HTj7SBOWg3viRtUeqhqmcJNpdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kgqqVpWe; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aab6fa3e20eso115085566b.2
        for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 23:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737013888; x=1737618688; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:content-language:to:subject
         :user-agent:mime-version:date:message-id:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8I+04AwhM0Y1+1Fh5biVpdLR6Blu36k00nrrspUY13s=;
        b=kgqqVpWeYq1MMK0BaX4obznpOTn08wJoF64NncUf0UHeAS7B/WEqvZzeNn2mESGeVR
         nbKxoa68NFnmLkUuC7daigQYOCY6hszhzLiXRYI0mdiJ4JBNguBMx82I3EaPByU57mxz
         0i+9hO0int5UTXccuKg9tyyBQCYlKPy4CgM2b3a4z0/+C15l3hBVIi21kD7egJRu6AcQ
         waE5ZLPGB+eQgBze351XNSXn0NlhjE3Yd5FuKuy2PwzCHIuQGRL7/QZ4hj0LO9GcBRO2
         FDM9GQSyBWOghiBQnn5RnD0gM4orYjrDmEJsHDVsH9JJnGWosIJzeCrq7ksEVPGRb2w8
         Trog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737013888; x=1737618688;
        h=content-transfer-encoding:organization:content-language:to:subject
         :user-agent:mime-version:date:message-id:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8I+04AwhM0Y1+1Fh5biVpdLR6Blu36k00nrrspUY13s=;
        b=Ar5UEflfo6jtsNebhVWkkhx14PBxQDL9vPOe5sZpEq29qbGvzDdWAldJ61kNUN6mIg
         mf5BAHcD90fmd9o0X1w8HD3azYS7LkyOC2Jh3qf7HYZayg9IFEA4M+f3NnPi3mpFfotU
         ouWgweNxod+Gcz9N3e9Q5elYk+T/loGKpEbTnA0yoPTDxGjcg2F70ejY3S8rkPsdWBis
         jk9FEJZzA8qSwp7U5btXEtpjXne6bB/FB/fpetLgXMFK1vyy6n6cLGOe6iSLCeMAfP7F
         oVnVvkPjRd3zpegYw+CfdxDm7+s7vKNfOnr/AHRFIGcKOToPur9RtK/CNmcAeFuz+4yM
         tuZQ==
X-Gm-Message-State: AOJu0YyXTZRY98AqlApD8sTwevnxQW8/WuRYUOOn5tM5SNgjhA7M0elM
	8+YeYL6EEcBicES41KU8fIxRKuOb7MAvly67J21Vh+6PaeTeZ1xAGwhO9A==
X-Gm-Gg: ASbGncumsabJiU1poYx4bJGd7IfLrdQni0s98NmO7AWiObjN79SSV5r3SoAWSuaqN+T
	+rFuvHTWn+jC0tK+iYnhTpXHn2+5v6Iq29N/a4S05IsxodhLe6f3qAqtRNXjfNG5Fi68v9QlRj1
	zjCl80BOy/zNyhGoNCMP5ioakq3Rnr4TJ+15sPL5Fa/ny2JjCg5CFHWIpdQNzpG2NeY7mYAIPXN
	M4wEro3UwHTRSYjFzOMlSQff5+RwgJ7+Qs/soeMf/TWGcYvbaNexU6LwY9gKpB41u5O
X-Google-Smtp-Source: AGHT+IFSIDcsnH3Zq2v/BIC4bBBrqdwDo4hI5NZhU3OmYUUbl6EKOxvGg5ly2HQpNR44Vu91nN8eYw==
X-Received: by 2002:a17:907:2d0b:b0:ab3:4b12:7259 with SMTP id a640c23a62f3a-ab34b1272b5mr737698666b.36.1737013887615;
        Wed, 15 Jan 2025 23:51:27 -0800 (PST)
Received: from [127.0.0.1] ([193.252.113.11])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2d0ecdf99sm846029266b.17.2025.01.15.23.51.26
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2025 23:51:27 -0800 (PST)
From: Alexandre Ferrieux <alexandre.ferrieux@gmail.com>
X-Google-Original-From: Alexandre Ferrieux <alexandre.ferrieux@orange.com>
Message-ID: <1f09214d-0a30-4537-82ca-ebecc0c2f2bb@orange.com>
Date: Thu, 16 Jan 2025 08:51:26 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Generic sk_buff contract documentation ?
To: netdev@vger.kernel.org
X-Mozilla-News-Host: news://news://news://127.0.0.1:1119
Content-Language: fr, en-US
Organization: Orange
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

Recently digging into a driver-specific issue with sk_buff->protocol, I
discovered (with surprise) that the computation of this field (which is *always*
necessary for protocol handlers to kick in) was somehow "delegated" to
individual network interface drivers. This can be seen by looking for callers of
eth_type_trans(), e.g:

- tg3: called from tg3_poll_work
- ixgbe: called from ixgbe_clean_rx_irq
- veth: called from veth_xmit (though indirectly via __dev_forward_skb)

This is a surprise as one would naively expect this ubiquitous behavior to be
triggered from generic code, depending only on the L2 header structure (but not
on the specific NIC hardware at hand). Another surprise was *not* to find any
mention of this "contract" in Documentation/*.

So, is it an unspoken tradition for NIC driver developers, to
"just know" that prior to emitting an skb from the rx path, they must fill
skb->protocol (along with who knows how many other metadata items) ?

Or, is there *somewhere* some reference documentation listing (exhaustively) the
required metadata computations that fall within a NIC driver's responsibility ?

Thanks in advance,

-Alex

