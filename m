Return-Path: <netdev+bounces-97824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4468CD630
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 16:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAFA42837F1
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 14:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F45A94C;
	Thu, 23 May 2024 14:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fe8HvENe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6146B658;
	Thu, 23 May 2024 14:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716475949; cv=none; b=g0LUfbPQdOn+Chq1XrZ+5gzFtGyS+gwlstZnEWP+ckc6NbcBqOm2cbAJE/UQMgCU11+nTyghAP8SObYdV4CyeS1FKmuPMirB4CiZXfOYYublI+2xMKok0pef7QXlGXbpr8+o9+lR88KPd1RUWcUNeScjS8r/ggHFj/op/hF4uvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716475949; c=relaxed/simple;
	bh=t1O96s9CB2jKt8uzg0Uz1hwBHaekRVVFH3XTvbc7JLE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=mQIiTOlJmDM/vkRAzsqKaMSf1mKHY1mDq5jJphs+YYA6TlX14/er1YXMcqfnkrczO3KFlqxVRZ+OhMQlhKpqMsGSzqQWUiWI4rWwuUisQbfjApGsnfHpzSQSyMdu5f5AOu+bQOL13ZhFM0LHX17E4+sZu+rG6LfQ7y/DhAA8Y1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fe8HvENe; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7948b7e4e5dso294982285a.1;
        Thu, 23 May 2024 07:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716475946; x=1717080746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1q80E2AXXJ7U5yNc5CQM7RUz/g0M/tbE4Dn+6CSYmqk=;
        b=fe8HvENeuN0ajNxtQomiFJINKCEscWDCbtx293mQD18MwEBWR7ef6Wjo4UW6IQdn0i
         nPOploPtAMD6UdwQNglCg2YGkxc5pG1PxQcA06h8vnOLnzKScTrEN2NdyDnZNSg7Gs54
         soMjKMbHN8yn+fO8R3gfELOgc7Wa8fasSDH4mMqrHiXcqNTXZovphzGj/qXPY7qb+OZb
         jnStDm+T/XIETL7xsRuDIRSZJUo1DFlbMA+utwWdhEyMkdudXX3B3H+ELdi9tYLhbniF
         AK5brQU+7ATwzoUOIEUoX0vVleG7xfZCwNUb9YFmeaW5kQJDFrlv4AXJhb2xoqMlDuyl
         53TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716475946; x=1717080746;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1q80E2AXXJ7U5yNc5CQM7RUz/g0M/tbE4Dn+6CSYmqk=;
        b=tc80DDtJQ/T8a6hYho89SpfT5Y6eXbl/FMi5UOlZhOcAPu7uJUxS0ZXzbPEs4/0qVt
         Gx4ptvtJYO99ivZxMyMqvNENGGXiQNLqOEjugSizLR1vLXt9wALciBnz1DiKtF18MghA
         zTOGGimAxtTpB6MbF8BwOHe41NES7odl3Gtxy6cthr78z+0AV5RwmyoL9I+vA40jBJvs
         k4dZSD73gmBUIKD2EccnVuSN2iXSBXCS6rmqmY7hQeiVCi8rKr/Y8F6UgBcZ4PcGKOsR
         2fxRPklPH399rQtQnm7323iBxzRn0rJFf/g/U8kYEDm5cgcR3qYo8vBrVZ6jOxIl2MQI
         iiPw==
X-Forwarded-Encrypted: i=1; AJvYcCVKz+2R6Q10aMXJWn1b7xoOMaYOKfD15PEDQVPixXHPGkqq5Hl/GF1ITH2MByQBTWOzxRhHTbPdNIxVhcIjyfDANWmm5zN7M0Mz20C4AuQsNj1gavWejHGAF4CuL98ge45/1GKB
X-Gm-Message-State: AOJu0YwcOX1fRX+zKz3Z+tB6A2Gr/CywsJH2nhRwjbtptaYh7+y3PhDC
	KDY8U3IrU9opAuRBRAebdcNRr4NWVNDudrNuUgCX5z4VRjgXP7Wh
X-Google-Smtp-Source: AGHT+IGbiqt416OYzjDHmNqvtuhUS0rg9mxKIsYM21GvqJvBundin5v4DmOssWKUVKrbIRThyzz5fg==
X-Received: by 2002:a05:620a:5651:b0:793:81c:293 with SMTP id af79cd13be357-79499444450mr580957585a.24.1716475946390;
        Thu, 23 May 2024 07:52:26 -0700 (PDT)
Received: from localhost (112.49.199.35.bc.googleusercontent.com. [35.199.49.112])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792bf296d14sm1496005985a.49.2024.05.23.07.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 07:52:26 -0700 (PDT)
Date: Thu, 23 May 2024 10:52:25 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Chengen Du <chengen.du@canonical.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 alexandre.ferrieux@orange.com, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <664f5829d6485_1b5d2429420@willemb.c.googlers.com.notmuch>
In-Reply-To: <CAPza5qfam1DBffBJWjOrMsSW8J+6ans7apeX=64YVCixBWX-tQ@mail.gmail.com>
References: <20240520070348.26725-1-chengen.du@canonical.com>
 <664b97e8abe7a_12b4762946f@willemb.c.googlers.com.notmuch>
 <CAPza5qcGyfcUYOoznci4e=1eaScVTgkzAhXfKSG3bTzC=aOwew@mail.gmail.com>
 <eaf33ba66cbdc639b0209b232f892ec8a52a1f21.camel@redhat.com>
 <664ca1651b66_14f7a8294cb@willemb.c.googlers.com.notmuch>
 <CAPza5qfZ8JPkt4Ez1My=gfpT7VfHo75N01fLQdFaojBv2whi8w@mail.gmail.com>
 <664e3be092d6a_184f2f29441@willemb.c.googlers.com.notmuch>
 <92edf27b-a2b9-4072-b8a4-0d7fde303151@orange.com>
 <CAPza5qfam1DBffBJWjOrMsSW8J+6ans7apeX=64YVCixBWX-tQ@mail.gmail.com>
Subject: Re: [PATCH] af_packet: Handle outgoing VLAN packets without hardware
 offloading
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Chengen Du wrote:
> Hi Willem, all,
> 
> Thank you for highlighting the QinQ and L2.5 issues.
> These are areas I am not very familiar with, and I appreciate your guidance.
> 
> To address the QinQ and L2.5 issues, the third approach seems like a
> promising solution.
> If I understand correctly, in the QinQ scenario, we need to preserve
> the link layer header because it includes two VLAN tags.
> For the L2.5 issue, we can adjust by pulling mac_len instead of
> skb_network_offset.
> In summary, we may need to retain the link layer header to enable
> receivers to parse different protocol scenarios.
> 
> Although this approach can resolve all issues, it requires the
> receiver's cooperation to implement the parsing logic of the link
> layer header.

I was about to bring up the same.

Existing BPF filters may expect L3 headers. A change like this will
have to be opt-in through a socket option.

Since I see no better option to support all L2.5 protocols, if this
is something that tcpdump/pcap would use, we should do it.

> I am concerned that this implementation may take time and adding it
> directly into the kernel could place time pressure on existing users.
> 
> I would like to propose some ideas and welcome your thoughts on them.
> Firstly, I suggest we address the VLAN issue using the second
> approach, as it appears to be a bug and can be resolved without
> affecting current users.

Agreed. Let me respond in more detail to your original patch.

> Secondly, we could introduce the link layer header preservation via a
> new packet socket flag.
> Receivers could implement and test this by enabling the socket flag.
> This way, we avoid disrupting existing receiver behavior while
> providing the capability to parse more complex protocols.

