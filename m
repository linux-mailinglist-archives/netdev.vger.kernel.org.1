Return-Path: <netdev+bounces-114966-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A357944D0A
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 15:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D96A82817EA
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 13:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65BA51A08CE;
	Thu,  1 Aug 2024 13:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="np8z8wcv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7C41A071B
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 13:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722518435; cv=none; b=f55VPtbNXP5GbZT6EEdBy8Ym05PKw/3DflVCB01cnV7cCDWDXv6sUBOfbdrReFh6WYKb6+gmSuQ7ZXwLoRgPyN5drDbEX6DbgxebcuaB8cXvK05mGQd2fOvIlH2d71iEHG1tcv55ExbMbdPC3zapGgYV9WsIuQURi2meSrSDR30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722518435; c=relaxed/simple;
	bh=AkBccuVgLFEanz53pVp9sdyMsNYsSvU3C/x3VcjI6OU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=H+6i9y1xfHiFQfvKx+bZ4AAUWaSGBcnXHJcDCU2VLcHSr3oE4//1mRVECbuVR+ZiMn+/TvfF4HXfSPGZyaNwpkiCmBWKetoWzfy35Jzlp0ZFWdUZL0S2DDv7Lp8m/5Nekojz0sUJZMc/TcDeFz9tkpx86mC7p4YUlZTMqiCkkRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=np8z8wcv; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7a1d42da3f7so429648485a.2
        for <netdev@vger.kernel.org>; Thu, 01 Aug 2024 06:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722518433; x=1723123233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qrbowLDETzgdD76CVW5irPGzfv6EFtbRaRvaBaG2+i0=;
        b=np8z8wcv6+Mrq4FAy+852Qg3CqxuzeXRCKBKLx+KdZ3rIt2Eci6DdwzcGQ9iPuGvia
         fkYOtzRpuzFFiSqpY36a/wjmpA40FA79ux1k6PbZh32jCDcKVjCRL45E/EJfqft3SqU/
         wWnlHPFUnS7gxScZ6VwN8GHch13OMGvC3pL9fBOtWqSKzHMakhzNWriKz746sDSwmuPi
         ACKDtll779Xf1H1FkCuRQ6WW56vUBnFCtP4Cn7ydqiI7zTJ7BdP1P2Yi3Ir+/lWEADJ3
         bUxeH3nGsc14+MT9Z6XF1Q6gRCo+3ODhq2PPtb05LsqOMkbcQgBoxvGPOQp9tBKFcd9w
         GNjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722518433; x=1723123233;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qrbowLDETzgdD76CVW5irPGzfv6EFtbRaRvaBaG2+i0=;
        b=bZiY1Sq/M4QHUDelsZzeMzuftw4tNKfv4010mSpuDXT4tT36bY47JoqA/wWPcpIa92
         oaQ4WTct2t7etXnlWTFA7pEdSrVdofZuKWLJHsGSOSNNWKHTvecsbCnkKr1hGk2hmN1J
         wmsatXIDjZctZO/BJHibaYgzlQQDdoEKEn4/DY6SwC6xRtDMMT0IePJOxVcl8cASac/7
         cjqlo4EN2OvUIfHi9hDFLjjVk0xFH3Xk/l/T7/h4GhjfVDjUwKk7k241+Nb/6KoEeeIt
         S9F3aBjPUu4HO06AVHhJPcAPFqinJgFTX11n8fn74uU7DZKNQSLbqCozssa8XdMuHd4g
         TgrA==
X-Forwarded-Encrypted: i=1; AJvYcCV4ntG+zxx3QgGnAQzwv72CRjkc18bwwmSsT45ab54kDFnF+JpAQ+hFNg3Cq4VxNKHVzHWRx7a8NCo6MqE73LuvpnL/ulo4
X-Gm-Message-State: AOJu0Yw1N/0bqbmyo07d3TnCTjqSShNYzysCBOrl6rzmRfFY9u6eJYGZ
	1X0JQRLuarIKJ82Ntg8EsKL37LoGcaPoOwFYceZQi9yoALXBV2kk
X-Google-Smtp-Source: AGHT+IGYfYEZvuQHh9VqKsAFQuDuGez89y/soiy+udcgyEtMcf9Wlq9pQwifXB9gtFxs9v3yv/Idzw==
X-Received: by 2002:a05:620a:28d0:b0:79f:18f8:cdd4 with SMTP id af79cd13be357-7a30c655ca0mr318408485a.22.1722518432693;
        Thu, 01 Aug 2024 06:20:32 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1eec80ae0sm513199585a.83.2024.08.01.06.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 06:20:31 -0700 (PDT)
Date: Thu, 01 Aug 2024 09:20:30 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Tom Herbert <tom@herbertland.com>, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 edumazet@google.com, 
 netdev@vger.kernel.org, 
 felipe@sipanda.io
Cc: Tom Herbert <tom@herbertland.com>
Message-ID: <66ab8b9ef3d74_2441da2947d@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240731172332.683815-1-tom@herbertland.com>
References: <20240731172332.683815-1-tom@herbertland.com>
Subject: Re: [PATCH 00/12] flow_dissector: Dissect UDP encapsulation protocols
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Tom Herbert wrote:
> Add support in flow_dissector for dissecting into UDP
> encapsulations like VXLAN. __skb_flow_dissect_udp is called for
> IPPROTO_UDP. The flag FLOW_DISSECTOR_F_PARSE_UDP_ENCAPS enables parsing
> of UDP encapsulations. If the flag is set when parsing a UDP packet then
> a socket lookup is performed. The offset of the base network header,
> either an IPv4 or IPv6 header, is tracked and passed to
> __skb_flow_dissect_udp so that it can perform the socket lookup.
> If a socket is found and it's for a UDP encapsulation (encap_type is
> set in the UDP socket) then a switch is performed on the encap_type
> value (cases are UDP_ENCAP_* values)

The main concern with the flow dissector is that its execution depends
on untrusted packets.

For this reason we added the BPF dissector for new protocols. What is
the reason to prefer adding more C code?

And somewhat academic, but: would it be different if the BPF would
ship with the kernel and autoload at boot, just like C modules?

A second concern is changing the defaults. I have not looked at this
closely, but if dissection today stops at the outer UDP header for
skb_get_hash, then we don't want to accidentally change this behavior.
Or if not accidental, call it out explicitly.

> 
> Tested: Verified fou, gue, vxlan, and geneve are properly dissected for
> IPv4 and IPv6 cases. This includes testing ETH_P_TEB case

Manually?

