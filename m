Return-Path: <netdev+bounces-199115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A1CADEFFB
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 16:44:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77EEA1888FFA
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 14:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C58D2EBDEB;
	Wed, 18 Jun 2025 14:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LtAPE+X9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BCA2EBB97
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 14:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750257785; cv=none; b=iclleGRd47GHRWKNrhmo0UPdd7jSn8XVdCrigMTTwSjMnxVmG4u0fNwoFioBh1ZLMl7rEnll5ET4wXz4X+8sO6UMa087zMAXFWbcOjNB87qJzFHjfbwd5Hoosjlz3YEbh24GKB+ebKkDTFqsnXeoB5bYCOo8huVWBjio+B7W1t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750257785; c=relaxed/simple;
	bh=sivnm0xuPxOT6Mjxg93688oMuAlEBbuGA/VVxeCY0XY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DNXP32e7jZZAAnbZUThKttlRr8ddpjIcuxqhcESbtXviEzgn5e+RaU0l396smcKPSSCETezHQcBnsYZCtvmrko94dp42sspyHWHEOk/z35G2V/5VqhCHoXLb1hyEYgBNeYSOlDArnsACLQILcB1fXnuVuNJJeEImQTWrLEiCtw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LtAPE+X9; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a522224582so3915794f8f.3
        for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 07:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750257782; x=1750862582; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ae0v2pviLHYCneMRFhUDA2jcfp6LP3hX/XjdANdjOxY=;
        b=LtAPE+X9IeMi9tTkVUvKBlfR7DwDHkLRjG6NTfP6duXhWsHGxbfEcGU3bevzBS0bRT
         zFAz4DGshCQM8eJbXQpNHx1V8q0itRes5w6W2AxmuIo0hZB21wErD2b7edw3QitAs3ur
         TuXNoTPlwg2wzYasXEO6Hj+7+EHFhB9k9n3J1o+o19bwPvLUsep7WRJtUhBI9hyKvrkQ
         VuMKmBdT8pvfbZJPhLwYKPfr4ec1wGyEyFZ6WZUkT4qT/omOY9gbmDWfLAIC0eU+Amqj
         +p+jk4A6lDEcWJ6Wn9jeb7n8RAGN9q6wDTpYFA2l79ohEe/v26Ys/nxdRbRQK1kaUDht
         ZMSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750257782; x=1750862582;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ae0v2pviLHYCneMRFhUDA2jcfp6LP3hX/XjdANdjOxY=;
        b=A4U8vP0FrQdAglXz8r6A94reRLg/UHuPGTzITJTh/U1OlfZgzqeV1odh/8pjvZXDdm
         YVMxVoPgsXpxTr1JMc3fXntUK4FEkwmNRXxjovk2Qdt7umOTJhCmpaca+aOAkzQUQcHa
         Gh/qYg/2b3d5FBuSWoNIpI9YuuNVmX50nMQsHjfYhRbC15OpsFQOK6IIO+DWI9oOVtcn
         GwPtm3q09hBOj8lEj6RbY5ERHOqekkcdjprPKXYAfYuaBVhQKjxZnRTZRZNqAXQYsP6d
         6vhH7Lz5RtM9rb10sB/+kegZrF3caP5/QWFgvLkc+2MkLy1V/Q/W0KlyjXJr2h7+5Oqw
         EbDA==
X-Gm-Message-State: AOJu0YzSR5KPgknfPgqI505pSBZgWqw8TvWa10DAjb1D2FgWm2fXJuIH
	t1TQiA24QySMTqGPB/ZfrLF0OYNgjEYsPd/zc/dWqQWrre/pXqC1Lt6i
X-Gm-Gg: ASbGncsS19GiI9EsqVcrqW6ADN1DY4/GLJR8Xy/UDBC0uWzMiNvRL6Tntho/bWWflvC
	WpIKBXFyoS1fi/3/wGLGif1wb1R12hTolu/jQgDhL07jEQhGhJJqTZNh88I3mXvVpoM95iEmqF+
	qZq5kdWMWx+Cnwqn3ofUdPlk0+/d5hMqp8wq+8L8RIX1NZ6Qsue8yxwd30Nf6ECtQvBqeq6/17y
	gb3/kTs27bJBNdnJ1ozS2SXtjcxYknaeJKR9MvizNuW3Ai3j804Yt0oYngTDgx5kJrwHMaXYybp
	D/YC4FHy7OSWofmz9umTDzaJH4JPxBHV+MwZhE+lXMi2FPrQ64hTAVUzHYQSneAFVVJzv1HNsgW
	6BDPIzWuPC/+s2SiEQBmBp4mq1ubsRMpBS6KdVesE8MdbWQ9o5w==
X-Google-Smtp-Source: AGHT+IFNWdKpnJh3ecj8GI5ZqF0XSASnDLq74mHgd46W/l9Hk+vzZjz23xRQLNEYTjFxTF39X7HNOQ==
X-Received: by 2002:a5d:64c2:0:b0:3a5:2d42:aa25 with SMTP id ffacd0b85a97d-3a572e55b64mr13650236f8f.50.1750257781871;
        Wed, 18 Jun 2025 07:43:01 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568a547d2sm17507523f8f.19.2025.06.18.07.43.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jun 2025 07:43:01 -0700 (PDT)
Message-ID: <d600aff4-3e4a-4664-a247-c44fdba6681a@gmail.com>
Date: Wed, 18 Jun 2025 15:43:00 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/3] eth: sfc: sienna: migrate to new RXFH
 callbacks
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org
References: <20250617013954.427411-1-kuba@kernel.org>
 <20250617013954.427411-3-kuba@kernel.org>
Content-Language: en-GB
From: Edward Cree <ecree.xilinx@gmail.com>
In-Reply-To: <20250617013954.427411-3-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/06/2025 02:39, Jakub Kicinski wrote:
> Migrate to new callbacks added by commit 9bb00786fc61 ("net: ethtool:
> add dedicated callbacks for getting and setting rxfh fields").
> This driver's RXFH config is read only / fixed so the conversion
> is purely factoring out the handling into a helper.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Typo in subject: "sienna" should be "siena".
Apart from that,
Reviewed-by: Edward Cree <ecree.xilinx@gmail.com>

