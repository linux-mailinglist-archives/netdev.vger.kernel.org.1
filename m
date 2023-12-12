Return-Path: <netdev+bounces-56363-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A178E80E98C
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 11:58:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 659F0280EDF
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 10:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4437D5CD0D;
	Tue, 12 Dec 2023 10:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TNw7sAk3"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8C5A0
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 02:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702378679;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RhQ3MZrfpOme5ohK8aKTGms//I1dXFNeYnh8apo/qw4=;
	b=TNw7sAk3raG8AHZ+h1UiMNOJXp011Yh89CorfOrlRja5aEtAtsTa1Ah7P2x7C63xIRAhdp
	xs6hn4RPrK7piW2iN1bNqZIGVgrNg5W0o/WrNTtbEmTHYGuXLLJ0oBregey+MguEjtf9FE
	IRJ6P6MH/kPK3yN2YsaCDW6QUCNqumQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-42YsWtaLMGO2SQO32AYsyw-1; Tue, 12 Dec 2023 05:57:58 -0500
X-MC-Unique: 42YsWtaLMGO2SQO32AYsyw-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a1df644f6a8so89486966b.1
        for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 02:57:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702378677; x=1702983477;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RhQ3MZrfpOme5ohK8aKTGms//I1dXFNeYnh8apo/qw4=;
        b=rqqwWsOsf+awdRT/1WXFXsLy68DgwMTpk520G4K7cBrtXSQnIFIt/iTuKCtDF7l2t6
         ulCxjS68M8+vUXy7j5Z7w/BqoYQLoK+p//c8P/KafRKQPNWA6Kp1BdBvoPqprBDlch1k
         ewzv8aJVXEdZ2tFPXjOvDQbgVWglBI3Dan6z3k0z2HoxBT8hxtXcbrjqk9dWtmrfHEr4
         VSMWXsAnAWPeWPsX2smJ8ifQX6aHilNS53qboXf3N+CVegoXg2kHKCFZVqCW//0dbx7L
         enPdB5f/vEwxlgj5LC3dPcRaBPr6m2W7G+Mm3fO3YBdiX7d+HRchvYbahzQdQWHAIL4g
         ChsA==
X-Gm-Message-State: AOJu0YzlwcHcKd/vUPhcM/McI94dyIsvnKdigSxuhQHDJ0uYqbC+CM7z
	xGOhksuM9gYLPxQ5N46mTJwwOmtTUtENgK/5E8DVK6rDgY+61EHkojaFV8J3xqPYuOTuCD0/3rN
	IpEDKnSiKtBVbnFSE
X-Received: by 2002:a17:907:c207:b0:a1d:7daa:4efd with SMTP id ti7-20020a170907c20700b00a1d7daa4efdmr6535455ejc.4.1702378676998;
        Tue, 12 Dec 2023 02:57:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHRuBs3Hv7C70LULftoYmwZNVnFto5H89Kb1TMTk99actGyPPZv9Is52VTXlde/Gz+gZWllEg==
X-Received: by 2002:a17:907:c207:b0:a1d:7daa:4efd with SMTP id ti7-20020a170907c20700b00a1d7daa4efdmr6535439ejc.4.1702378676646;
        Tue, 12 Dec 2023 02:57:56 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-249-182.dyn.eolo.it. [146.241.249.182])
        by smtp.gmail.com with ESMTPSA id vk5-20020a170907cbc500b00a1ce56f7b16sm6081876ejc.71.2023.12.12.02.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 02:57:56 -0800 (PST)
Message-ID: <0d30d5a41d3ac990573016308aaeacb40a9dc79f.camel@redhat.com>
Subject: Re: [PATCH] tcp: disable tcp_autocorking for socket when
 TCP_NODELAY flag is set
From: Paolo Abeni <pabeni@redhat.com>
To: Salvatore Dipietro <dipiets@amazon.com>, edumazet@google.com, 
	davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org
Cc: netdev@vger.kernel.org, blakgeof@amazon.com, alisaidi@amazon.com, 
	benh@amazon.com, dipietro.salvatore@gmail.com
Date: Tue, 12 Dec 2023 11:57:54 +0100
In-Reply-To: <20231208182049.33775-1-dipiets@amazon.com>
References: <20231208182049.33775-1-dipiets@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2023-12-08 at 10:20 -0800, Salvatore Dipietro wrote:
> Based on the tcp man page, if TCP_NODELAY is set, it disables Nagle's alg=
orithm
> and packets are sent as soon as possible. However in the `tcp_push` funct=
ion
> where autocorking is evaluated the `nonagle` value set by TCP_NODELAY is =
not
> considered which can trigger unexpected corking of packets and induce del=
ays.
>=20
> For example, if two packets are generated as part of a server's reply, if=
 the
> first one is not transmitted on the wire quickly enough, the second packe=
t can
> trigger the autocorking in `tcp_push` and be delayed instead of sent as s=
oon as
> possible. It will either wait for additional packets to be coalesced or a=
n ACK
> from the client before transmitting the corked packet. This can interact =
badly
> if the receiver has tcp delayed acks enabled, introducing 40ms extra dela=
y in
> completion times. It is not always possible to control who has delayed ac=
ks
> set, but it is possible to adjust when and how autocorking is triggered.
> Patch prevents autocorking if the TCP_NODELAY flag is set on the socket.
>=20
> Patch has been tested using an AWS c7g.2xlarge instance with Ubuntu 22.04=
 and
> Apache Tomcat 9.0.83 running the basic servlet below:
>=20
> import java.io.IOException;
> import java.io.OutputStreamWriter;
> import java.io.PrintWriter;
> import javax.servlet.ServletException;
> import javax.servlet.http.HttpServlet;
> import javax.servlet.http.HttpServletRequest;
> import javax.servlet.http.HttpServletResponse;
>=20
> public class HelloWorldServlet extends HttpServlet {
>     @Override
>     protected void doGet(HttpServletRequest request, HttpServletResponse =
response)
>       throws ServletException, IOException {
>         response.setContentType("text/html;charset=3Dutf-8");
>         OutputStreamWriter osw =3D new OutputStreamWriter(response.getOut=
putStream(),"UTF-8");
>         String s =3D "a".repeat(3096);
>         osw.write(s,0,s.length());
>         osw.flush();
>     }
> }
>=20
> Load was applied using  wrk2 (https://github.com/kinvolk/wrk2) from an AW=
S
> c6i.8xlarge instance.  With the current auto-corking behavior and TCP_NOD=
ELAY
> set an additional 40ms latency from P99.99+ values are observed.  With th=
e
> patch applied we see no occurrences of 40ms latencies. The patch has also=
 been
> tested with iperf and uperf benchmarks and no regression was observed.
>=20
> # No patch with tcp_autocorking=3D1 and TCP_NODELAY set on all sockets
> ./wrk -t32 -c128 -d40s --latency -R10000  http://172.31.49.177:8080/hello=
/hello'
>   ...
>  50.000%    0.91ms
>  75.000%    1.12ms
>  90.000%    1.46ms
>  99.000%    1.73ms
>  99.900%    1.96ms
>  99.990%   43.62ms   <<< 40+ ms extra latency
>  99.999%   48.32ms
> 100.000%   49.34ms
>=20
> # With patch
> ./wrk -t32 -c128 -d40s --latency -R10000  http://172.31.49.177:8080/hello=
/hello'
>   ...
>  50.000%    0.89ms
>  75.000%    1.13ms
>  90.000%    1.44ms
>  99.000%    1.67ms
>  99.900%    1.78ms
>  99.990%    2.27ms   <<< no 40+ ms extra latency
>  99.999%    3.71ms
> 100.000%    4.57ms
>=20
> Signed-off-by: Salvatore Dipietro <dipiets@amazon.com>
> ---
>  net/ipv4/tcp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index d3456cf840de..87751a2a6fff 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -716,7 +716,7 @@ void tcp_push(struct sock *sk, int flags, int mss_now=
,
> =20
>  	tcp_mark_urg(tp, flags);
> =20
> -	if (tcp_should_autocork(sk, skb, size_goal)) {
> +	if (!nonagle && tcp_should_autocork(sk, skb, size_goal)) {

It looks like the above disables autocorking even after the userspace
sets TCP_CORK. Am I reading it correctly? Is that expected?

Cheers,

Paolo


