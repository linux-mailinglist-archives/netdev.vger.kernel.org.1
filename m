Return-Path: <netdev+bounces-134248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7F6998849
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 15:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA33D288FBA
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 13:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E7E1C9DE9;
	Thu, 10 Oct 2024 13:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BTVXmcbk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E49A1C3F15;
	Thu, 10 Oct 2024 13:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728568184; cv=none; b=T2NYjBU+40bQ4bgeHPyr+F4RHwrYCrTbrwYpLUYHuKx5LI67eaSO3/WnVUx9TB2hE7fpyjYzDnDFqa6zROgbwvN53a6qDJljIPsYpVs6PeLGsCTh+vNGUXL76sgmQdIGaJ0McJ8O+JGqzSLP1H3MHDuBNeSn5XY0YrBiM3GAdQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728568184; c=relaxed/simple;
	bh=jn2RooPNXmgTDD5nIoEy4n56E66iZkcNlGqDzw8cRWY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=tLE4CWMG6CJZOUIEMFjGZmWYo2dkXBy62qwpunmV1rigIvVQ7UzqQc91nO7KRIRFe69oOPlhKrMwJgt9FgbNHQcYXVZXPfacK2WtXv8GyfK+XH1zVBTn2VuwNQsB1hVFUlYVwPvQWH3RVsob05/Fny7R6Z2Omzin8/fTr9Bx+ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BTVXmcbk; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7b1109e80f8so72239785a.0;
        Thu, 10 Oct 2024 06:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728568181; x=1729172981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pXLiO6qkoJeOcErPn/djUkD/ECKE7VT5hL4zWbkdbOk=;
        b=BTVXmcbkIF4y3MKzshu8AYn4D++D29OXlVmnRyIgyawmpwudu770Ncl7JWt8/czICJ
         zmo0sDYpynhPARTWcFQUa2Na5FdnK0IOc8ooGcd2vpbk0zb3CnczTZ0PkMXnseLCfFa4
         fYL6FqS7T/3OlX/37fAsD5ko1RWe+USXPdyQtHt+51wctVtBig/Db6fyotHPsQntHwvR
         9O5TcXPhYzc1d6ZLNK3PYsk/F+EEMOpx3uYDo4Tr2m+wxhO8w1qk57uQdiOoGXgfYLO8
         P24/RoMxd0MFwY0Z6dD1JVgvGnaIQaFm4JVG6N5dPgQy+gc8oYXRW1UfZCfX4yvgTNcP
         hbQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728568181; x=1729172981;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pXLiO6qkoJeOcErPn/djUkD/ECKE7VT5hL4zWbkdbOk=;
        b=UHT+m3s7tVxPwrVAmoBPGZX+lBMkAwMgLq+P4LKXiQJJmq7BgGV6s6+QdNUAqxa6Vc
         ZVSXtVTYGLaKI6vH/ZX8CPmQ0H3ZeVZi3RO4WrFYRaW7ro9X3rXamBG/qB93WU8ik163
         zip6xJZglFBHZpg0n7C78QT8MpDg47dIybkGvNoYPEv9G4qdwWRr2CFG4j0EWh5u6JZi
         DW+5ZXhjLetVnIdcCN5qFCZbBecXdb2MT/9W+FqgoykKCX1lPXVsqdyNEVQtuRaFW82b
         GnE2dBEEX7anuso7gN1XtA7J6EOXye7hByhuCd/NvMHEoipPTA+CQKBiTaSdGBo9mkxJ
         DciA==
X-Forwarded-Encrypted: i=1; AJvYcCVdiJGr2CbHKgGrnqPb6CgdiXxJ0X51572RwtSOuqir+bbOMdTtBmRb4RRlCflpPxv9MOxlUQaONqUGnPE=@vger.kernel.org, AJvYcCXvdxs52j83/EUqjC4Kn9OcXDz1yJk5rb8abIohiNABnxpiWUwHBt2OtMfnO6ETakxdKXg2jZQY@vger.kernel.org
X-Gm-Message-State: AOJu0YwJowRRhDC5soqycc9UlC4wallSTSThzBSfkQctruJ9JQHevthq
	1VivvNQT6ZtbPn/7nFLQTGl+ci2oQAQaEJOF/H7qQ6sx/SPYWyF+
X-Google-Smtp-Source: AGHT+IHzDkiwrF2qh78n4PZUaabIUExAI/FprABZIDlaS1EjniG4iFCy9aluFfxpKdrQ/i3bmj7gpw==
X-Received: by 2002:a05:620a:2416:b0:7a9:a1f4:d4e1 with SMTP id af79cd13be357-7b079551686mr926669085a.39.1728568181319;
        Thu, 10 Oct 2024 06:49:41 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b11497adb8sm47536685a.121.2024.10.10.06.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 06:49:40 -0700 (PDT)
Date: Thu, 10 Oct 2024 09:49:40 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Philo Lu <lulie@linux.alibaba.com>, 
 netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com, 
 davem@davemloft.net, 
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
Message-ID: <6707db74601d9_20292129449@willemb.c.googlers.com.notmuch>
In-Reply-To: <20241010090351.79698-4-lulie@linux.alibaba.com>
References: <20241010090351.79698-1-lulie@linux.alibaba.com>
 <20241010090351.79698-4-lulie@linux.alibaba.com>
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
> Currently, the udp_table has two hash table, the port hash and portaddr
> hash. Usually for UDP servers, all sockets have the same local port and
> addr, so they are all on the same hash slot within a reuseport group.
> 
> In some applications, UDP servers use connect() to manage clients. In
> particular, when firstly receiving from an unseen 4 tuple, a new socket
> is created and connect()ed to the remote addr:port, and then the fd is
> used exclusively by the client.
> 
> Once there are connected sks in a reuseport group, udp has to score all
> sks in the same hash2 slot to find the best match. This could be
> inefficient with a large number of connections, resulting in high
> softirq overhead.
> 
> To solve the problem, this patch implement 4-tuple hash for connected
> udp sockets. During connect(), hash4 slot is updated, as well as a
> corresponding counter, hash4_cnt, in hslot2. In __udp4_lib_lookup(),
> hslot4 will be searched firstly if the counter is non-zero. Otherwise,
> hslot2 is used like before. Note that only connected sockets enter this
> hash4 path, while un-connected ones are not affected.
> 
> Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
> Signed-off-by: Cambda Zhu <cambda@linux.alibaba.com>
> Signed-off-by: Fred Chen <fred.cc@alibaba-inc.com>
> Signed-off-by: Yubing Qiu <yubing.qiuyubing@alibaba-inc.com>

> diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
> index bbf3352213c4..4d3dfcb48a39 100644
> --- a/net/ipv6/udp.c
> +++ b/net/ipv6/udp.c
> @@ -111,7 +111,7 @@ void udp_v6_rehash(struct sock *sk)
>  					  &sk->sk_v6_rcv_saddr,
>  					  inet_sk(sk)->inet_num);
>  
> -	udp_lib_rehash(sk, new_hash);
> +	udp_lib_rehash(sk, new_hash, 0); /* 4-tuple hash not implemented */

What is the plan for IPv6?




