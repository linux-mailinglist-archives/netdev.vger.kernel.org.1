Return-Path: <netdev+bounces-219661-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B383B428A6
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 20:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4577A176DC7
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 18:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D394436299F;
	Wed,  3 Sep 2025 18:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0REroiuR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420567080D
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 18:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756924064; cv=none; b=QmzqNdQ1KoOkBl3ewjvzeR05PAfYnWHePDm1MDBLdRprrzhYmIzEBYyc/c3dwSkkpx56IA1WxcyM84wUKspMjOWEtbuujO0jSY176D0rhgJpgN5fbVUZBP25tBcAlRIQKkn+fT6Rn+gLpEfGQ5T2sqUbi9hHpB6z7bhLSuAd5Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756924064; c=relaxed/simple;
	bh=UgSgG+illnXBw82HH3RrybDPNWOtIyDniaYV47Yu/hs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gbmNu3Dpo6cWq24hTncFX6FhrST1Ieq19QLf5yugODOKPtpFuZYx4MnW1mGM22Cydr7UHv6sKkW/gwNaIqJO6apl7I/zcD1KNZ3OkvLF8rV+z/3/opdx/c4TE3D4Yo6XRqLKlcap4Elg6Cq2rG5iH+Yl3a/LEmyWP8QKWi5RJB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0REroiuR; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-24c7848519bso2425965ad.1
        for <netdev@vger.kernel.org>; Wed, 03 Sep 2025 11:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756924062; x=1757528862; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fgt8BmXnaWG8EKRdLFdJDZMIP+UK5ktUh6DqjNYacns=;
        b=0REroiuRzVcxtFMvpJ5m9ILrRtkqjLtvYUpXWHm5YNbk/Mq9edIEsD5e0dcNEwFUTE
         MSVIgyQWNh1JJUkR5OnD9jbabaTuLHVYeUA9k0sWN7Mp8gD/cWYId+cya7p3t7kQ0Zqf
         LSaOLxqf3b7t0LqdwsllF18mQPuLsGeE3Y+JkbMuoY7vuUqNea08Qbr8UbnuFFMlpqbO
         FhV1XgGLODDHfL1XdjOCJjsJh3RolzIMmgOdhbW2Q2EV6yZTSAuG+WRlbAxdCS7DhSCG
         XOYhqVHyaXG2h6krhjfHhsPF70Qo17CBWhEWA/Dl4lEcG93oAlrGSgqx7ejIfyN7LLtx
         TlGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756924062; x=1757528862;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fgt8BmXnaWG8EKRdLFdJDZMIP+UK5ktUh6DqjNYacns=;
        b=hfvVnr5Jj7gAhbvXk9N07soWzEylDjLceocXBpIJiX6b2Wc0q1qlesNEiEwCAG6ptC
         WkNZ92x9c/ZoKcqWBT0UThh0ciMyuK96aR0Sl+YR/c6BqMXKwMaeCTt7CvqcjiqHlzI4
         ZPsC7EEKKI4/zvHtObaZZDPd9jYMPMPjxt5kVAtkphkL6DUMJ/Rkso557R3x6FeeKdms
         BAWVkLq2SQW+L5sF9B7DD1LdypU/yw2VNwm52gmrTGVv26Be5iKoiD3ripM0v5owc4hd
         0YPMRa3bZJaTJmW7/dwKmyizlojN41NWCGpUNM/B32VB6M7e6EMjUJLgMmMdcfghfiHs
         mO1A==
X-Forwarded-Encrypted: i=1; AJvYcCUzAvTemiAMX33CyrmfkUFhR1Zwxi5h08Z3SQZoTY0vz/WhGe+Lw+BFw9mI4PBZvxmKp6Ax63M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzLqnAu8aN0qBnAMgoqra6C7sZTlKE79x++SZs2l+8a/wLUoy3
	rdzJB/DY9C73GQ9nN2/oIooTJEcINus2+g+NyxdewY7iQURXw8M2LMQe6nByM+wdWkmImj9fUQX
	ALcQXX2Cm6mffah+26OonNv4LQ8gfF56J/NMzXKta
X-Gm-Gg: ASbGncsIPGQLh4PDdRq63eRr0EtAjaVTaAcQUYGLsfjOFK/oDW3huWXTQYe/29Kvqt/
	pIS8idd2U8NPmt4xVsKMzQkTykN9rui4mgMoPPg7amY42m0pV0wKn6cDhXanLT51IHvoXiNOUvD
	Pq7n1ZJEdtLAl1UfE4zHWBx7ZiWNldsPYR3n1qnwqBWhUUYpEe8AqRk+K17DYG1QYNUa9UC6D79
	mtU0ZyzrJP5oVqmM1X60d+CQbDjGecHc41EkNlz1lUshYhiP0W0IrMGDGbrRikA/QYpNeNdHFhZ
	XhXXKCRtOxg=
X-Google-Smtp-Source: AGHT+IHfE3KugofEe+D/myqMm/czJeuebmCxgL8orvgA1iJqdpGkpZrjjazrynMpeVKvZ5bX+ZgmGpzlckpscIodjqs=
X-Received: by 2002:a17:902:cecd:b0:24c:b6c2:15d with SMTP id
 d9443c01a7336-24cb6c20a2fmr11300535ad.31.1756924062342; Wed, 03 Sep 2025
 11:27:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903174811.1930820-1-edumazet@google.com>
In-Reply-To: <20250903174811.1930820-1-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 3 Sep 2025 11:27:31 -0700
X-Gm-Features: Ac12FXwE_M6m5jS7ArdJ4fr18K7V_3Y1crHWF9itJSZJtizEkUdlOY4UKDWc1pA
Message-ID: <CAAVpQUCsJGQbDyaB1c3gbz7RQi5KdwgXw1McD82VkxfMT-ewdg@mail.gmail.com>
Subject: Re: [PATCH net-next] net: call cond_resched() less often in __release_sock()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 10:48=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> While stress testing TCP I had unexpected retransmits and sack packets
> when a single cpu receives data from multiple high-throughput flows.
>
> super_netperf 4 -H srv -T,10 -l 3000 &
>
> Tcpdump extract:
>
>  00:00:00.000007 IP6 clnt > srv: Flags [.], seq 26062848:26124288, ack 1,=
 win 66, options [nop,nop,TS val 651460834 ecr 3100749131], length 61440
>  00:00:00.000006 IP6 clnt > srv: Flags [.], seq 26124288:26185728, ack 1,=
 win 66, options [nop,nop,TS val 651460834 ecr 3100749131], length 61440
>  00:00:00.000005 IP6 clnt > srv: Flags [P.], seq 26185728:26243072, ack 1=
, win 66, options [nop,nop,TS val 651460834 ecr 3100749131], length 57344
>  00:00:00.000006 IP6 clnt > srv: Flags [.], seq 26243072:26304512, ack 1,=
 win 66, options [nop,nop,TS val 651460844 ecr 3100749141], length 61440
>  00:00:00.000005 IP6 clnt > srv: Flags [.], seq 26304512:26365952, ack 1,=
 win 66, options [nop,nop,TS val 651460844 ecr 3100749141], length 61440
>  00:00:00.000007 IP6 clnt > srv: Flags [P.], seq 26365952:26423296, ack 1=
, win 66, options [nop,nop,TS val 651460844 ecr 3100749141], length 57344
>  00:00:00.000006 IP6 clnt > srv: Flags [.], seq 26423296:26484736, ack 1,=
 win 66, options [nop,nop,TS val 651460853 ecr 3100749150], length 61440
>  00:00:00.000005 IP6 clnt > srv: Flags [.], seq 26484736:26546176, ack 1,=
 win 66, options [nop,nop,TS val 651460853 ecr 3100749150], length 61440
>  00:00:00.000005 IP6 clnt > srv: Flags [P.], seq 26546176:26603520, ack 1=
, win 66, options [nop,nop,TS val 651460853 ecr 3100749150], length 57344
>  00:00:00.003932 IP6 clnt > srv: Flags [P.], seq 26603520:26619904, ack 1=
, win 66, options [nop,nop,TS val 651464844 ecr 3100753141], length 16384
>  00:00:00.006602 IP6 clnt > srv: Flags [.], seq 24862720:24866816, ack 1,=
 win 66, options [nop,nop,TS val 651471419 ecr 3100759716], length 4096
>  00:00:00.013000 IP6 clnt > srv: Flags [.], seq 24862720:24866816, ack 1,=
 win 66, options [nop,nop,TS val 651484421 ecr 3100772718], length 4096
>  00:00:00.000416 IP6 srv > clnt: Flags [.], ack 26619904, win 1393, optio=
ns [nop,nop,TS val 3100773185 ecr 651484421,nop,nop,sack 1 {24862720:248668=
16}], length 0
>
> After analysis, it appears this is because of the cond_resched()
> call from  __release_sock().
>
> When current thread is yielding, while still holding the TCP socket lock,
> it might regain the cpu after a very long time.
>
> Other peer TLP/RTO is firing (multiple times) and packets are retransmit,
> while the initial copy is waiting in the socket backlog or receive queue.
>
> In this patch, I call cond_resched() only once every 16 packets.
>
> Modern TCP stack now spends less time per packet in the backlog,
> especially because ACK are no longer sent (commit 133c4c0d3717
> "tcp: defer regular ACK while processing socket backlog")
>
> Before:
>
> clnt:/# nstat -n;sleep 10;nstat|egrep "TcpOutSegs|TcpRetransSegs|TCPFastR=
etrans|TCPTimeouts|Probes|TCPSpuriousRTOs|DSACK"
> TcpOutSegs                      19046186           0.0
> TcpRetransSegs                  1471               0.0
> TcpExtTCPTimeouts               1397               0.0
> TcpExtTCPLossProbes             1356               0.0
> TcpExtTCPDSACKRecv              1352               0.0
> TcpExtTCPSpuriousRTOs           114                0.0
> TcpExtTCPDSACKRecvSegs          1352               0.0
>
> After:
>
> clnt:/# nstat -n;sleep 10;nstat|egrep "TcpOutSegs|TcpRetransSegs|TCPFastR=
etrans|TCPTimeouts|Probes|TCPSpuriousRTOs|DSACK"
> TcpOutSegs                      19218936           0.0
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

Thank you!

