Return-Path: <netdev+bounces-134613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D702F99A6DE
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 16:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FBFD1F221F3
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 14:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69EBB15B0F7;
	Fri, 11 Oct 2024 14:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T9AzQfPK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BAC17BA2;
	Fri, 11 Oct 2024 14:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728658212; cv=none; b=FMj8HZBcLw8DPUBqQsTW86P+OqhmO/1d8tJRT8CJKE+5m9nzUnA1/Mq9zb5IUp9t4m2omB215DkYI26N7Vkd27rGHjn8woH6IbudQDlEAEbPa2cCBe/DAT1QUiIaAMIUiz1D1B1dRRnCsC5Wt0JDZC5x13BHxph/qBVDkQA9384=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728658212; c=relaxed/simple;
	bh=ALvXlwzWsImyKJpYssHZdxx/SxSVdcAWFvhn6uc8woU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=i4Et2O/mQgn9Mt0CGaMtEACEIHvO4HXXoR3sI2jVZNKF3urjSNBjHDSeswUVCbWnJKsry2cdHMu6xa0M7T3olLFz5EayPnAztuTYIGzZAclaOeyDZ8iZruJ3BC4xIlSpVsdcnngtM/476YZd6pZ58RbPlA2T4aV5L2sA+YzmfWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T9AzQfPK; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e2910d4a247so1567163276.2;
        Fri, 11 Oct 2024 07:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728658210; x=1729263010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9K1b4PxJViMvdmQyzpyoqgZ6Zjd4vnQ7NxL1imqB26M=;
        b=T9AzQfPKP5gFl6Fdt0/to5juoAquaiAinby2Plf9AFnUN8TluoDMWtez6+5qqr8zcy
         VBNxopn9Vjxgf/z1RuVwKZxRKDjNumC+L6oMmBCJ9bWfWFbnfJUy85wLp0g5F/gFA7ji
         q5P/X6j9QEsDXq0VUOGVTinr1CZjnEy4b8UKs8c+Ek9FTl4De/0xlso61+SHqYZWDj76
         I8H4QOWqZ7UBXUUQW8PPBoYg8ULVxCcyYWLTSGVxSM4EXn9+y+51LKN8oGkoh0lI6w6G
         vQNco1uLD6tAVwCYgV0Z37VHsTr0ickWAcU2zAreEnqZaEVrvUJqZ2zLE9yt6v3vu5u0
         cn5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728658210; x=1729263010;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9K1b4PxJViMvdmQyzpyoqgZ6Zjd4vnQ7NxL1imqB26M=;
        b=p/szsgUuzTeTeIP/ip+M3rsEzA3zDJHGMi3IP6+lm5hJ3Sjt5/DWTsJgPTkseJNdr1
         9edaBCGdvq8XjDxp4Kno8Bjzp+sJT4RZKlC7xjfoFkL1QJvpk7GAU+yeEbaSTdqc3LwT
         hiq3aiqUBAGd7nQAuMx1jLIkLf3GAXFurG5+r9LDHx0/JEVeCYOgzSyBOcI1Paik7sYx
         KYWn0wao7yLBzWF811XO5mxseBlXjXexXnyJ6sUlP3XBPZkP+Lm02GS/IJdQ9JcAGTpn
         e9F2XJ0CbehuuFpuwC9Ke2Afd8gu25zO+EbeGJUg087dRP/WksfZXWKYG/gXO7t8ty8p
         rmMA==
X-Forwarded-Encrypted: i=1; AJvYcCXCKbN/M2jo5lkmEFyaRiUzQ7y/Vpmq1M2ZaUtMhmkgicjHX38dFpD4q4wmhx2xbPREU52Fajj/XpgmdDg=@vger.kernel.org, AJvYcCXSEBQ1AmAu6ArEYr2kZKc6vn6towLlIA3qpSZ1KojUj3VMaGeg3QMUNlYUNyoK45t4ePoFlMYC@vger.kernel.org
X-Gm-Message-State: AOJu0YxilCdLbz39dLzSQaoy6pyBkP6wvPss/+tPqRA9TC6waMmsZXIa
	uIczLp9GpKHQwJP06glnNi44rdIMaGhM0Fs4Ccgz1nyQ1+llIe7p7t5hFQ==
X-Google-Smtp-Source: AGHT+IF0lhXmBu0yNYaHOAlYchoG74spgjpBxb77RA4xTor8dWzumE32/yso4mgG3vtPkpF3Ic4o4g==
X-Received: by 2002:a05:6902:2b85:b0:e20:287d:5ca5 with SMTP id 3f1490d57ef6-e2919d6799dmr2024414276.2.1728658209615;
        Fri, 11 Oct 2024 07:50:09 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b11497f90esm138220985a.125.2024.10.11.07.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 07:50:09 -0700 (PDT)
Date: Fri, 11 Oct 2024 10:50:08 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Philo Lu <lulie@linux.alibaba.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 netdev@vger.kernel.org
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 dsahern@kernel.org, 
 antony.antony@secunet.com, 
 steffen.klassert@secunet.com, 
 linux-kernel@vger.kernel.org, 
 dust.li@linux.alibaba.com, 
 jakub@cloudflare.com, 
 fred.cc@alibaba-inc.com, 
 yubing.qiuyubing@alibaba-inc.com
Message-ID: <67093b209de14_236a96294b2@willemb.c.googlers.com.notmuch>
In-Reply-To: <7e92c879-d449-4a5d-9f82-ebc711e6bd1b@linux.alibaba.com>
References: <20241010090351.79698-1-lulie@linux.alibaba.com>
 <20241010090351.79698-4-lulie@linux.alibaba.com>
 <6707db74601d9_20292129449@willemb.c.googlers.com.notmuch>
 <7e92c879-d449-4a5d-9f82-ebc711e6bd1b@linux.alibaba.com>
Subject: Re: [PATCH v3 net-next 3/3] ipv4/udp: Add 4-tuple hash for connected
 socket
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Philo Lu wrote:
> 
> 
> On 2024/10/10 21:49, Willem de Bruijn wrote:
> > Philo Lu wrote:
> >> Currently, the udp_table has two hash table, the port hash and portaddr
> >> hash. Usually for UDP servers, all sockets have the same local port and
> >> addr, so they are all on the same hash slot within a reuseport group.
> >>
> >> In some applications, UDP servers use connect() to manage clients. In
> >> particular, when firstly receiving from an unseen 4 tuple, a new socket
> >> is created and connect()ed to the remote addr:port, and then the fd is
> >> used exclusively by the client.
> >>
> >> Once there are connected sks in a reuseport group, udp has to score all
> >> sks in the same hash2 slot to find the best match. This could be
> >> inefficient with a large number of connections, resulting in high
> >> softirq overhead.
> >>
> >> To solve the problem, this patch implement 4-tuple hash for connected
> >> udp sockets. During connect(), hash4 slot is updated, as well as a
> >> corresponding counter, hash4_cnt, in hslot2. In __udp4_lib_lookup(),
> >> hslot4 will be searched firstly if the counter is non-zero. Otherwise,
> >> hslot2 is used like before. Note that only connected sockets enter this
> >> hash4 path, while un-connected ones are not affected.
> >>
> >> Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
> >> Signed-off-by: Cambda Zhu <cambda@linux.alibaba.com>
> >> Signed-off-by: Fred Chen <fred.cc@alibaba-inc.com>
> >> Signed-off-by: Yubing Qiu <yubing.qiuyubing@alibaba-inc.com>
> > 
> >> diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
> >> index bbf3352213c4..4d3dfcb48a39 100644
> >> --- a/net/ipv6/udp.c
> >> +++ b/net/ipv6/udp.c
> >> @@ -111,7 +111,7 @@ void udp_v6_rehash(struct sock *sk)
> >>   					  &sk->sk_v6_rcv_saddr,
> >>   					  inet_sk(sk)->inet_num);
> >>   
> >> -	udp_lib_rehash(sk, new_hash);
> >> +	udp_lib_rehash(sk, new_hash, 0); /* 4-tuple hash not implemented */
> > 
> > What is the plan for IPv6?
> > 
> 
> iiuc, udp6 shares the same udptable with udp4, and the hash-related 
> implementations are almost the same, so there is no obvious obstacle for 
> udp6 hash4 as long as udp4 hash4 is ready. And I'll do it right after 
> udp4 hash4.

Okay great.

