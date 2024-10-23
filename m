Return-Path: <netdev+bounces-138345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A50EE9ACFAC
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 18:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D721B22052
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 15:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C2E81B5823;
	Wed, 23 Oct 2024 15:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="jPCGiMTW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8D179C4
	for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 15:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729698946; cv=none; b=AM7qlEC5umXpVd/l2I5wLVFS8+tJx5qmVOPeUnroqzeeRkFowXjW6KArGqSeNcuMVbtJVHykvhxCTYw6O1c9/XCxs0/Q2jq32n8UIhkWUA7BJS96MvtK+zE8sAyu/NWsKfHW15MX7wCIuoozMMvwx27BEahlWYEF0OGhE9BYBWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729698946; c=relaxed/simple;
	bh=zlMt4VMPmFxM1Ir2XdGaqxYtcm7KIHA8dFnUO5wJOww=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uyf9NQIJXKIxcfgbG1SyqFziXq+gWZ77sx0sM9wFS9BGWMvBK35kuCGLEZ3EiO4ZqkyDl/nrIZj7KVIs332JIKpt85wWkj8zU2BlQVUm/bb+h3x5gbFd/TS9YlIwaBZRdCdEPfu+0z6uI41QFjEBIBAY8iISMfrLYQMZIdWAB/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=jPCGiMTW; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-208cf673b8dso67998335ad.3
        for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 08:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1729698944; x=1730303744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iJkCwYFal5wBFmrIW4rSrgSdqybbf5pTzHtYIlTXKXA=;
        b=jPCGiMTWbxA92UMMiiPJgmlqB7dW9b2MA+JaiGpJAzC1VgZJZV3Kg2iwwvf/nhmZsU
         naPOt5TqHFR1g5/a4FbwJDqNoaseopiWeR6r2nLL4X69956GXKnGsSsfU/jsAWxHvJEl
         5dcWKb+c5YICDX7qm1eXfafCWbrsvYgJt6Dvfd7OOmMPTpdccybmNGRyBgrpfUTk77mz
         tHhwk4xCQgA3erto/QQwos3qP+8gnIbHlIi3coFX/tczR2SrMp/l2M+fWPjJD7yemU1G
         4S/j6gvDXWmBeL6nsPPEEhJ+auM+rCfCDnvT6GaOAodDPeoRsIsYsSN92G/0fMBUJDg4
         3fog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729698944; x=1730303744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iJkCwYFal5wBFmrIW4rSrgSdqybbf5pTzHtYIlTXKXA=;
        b=PymbyqZkF54TVYwtbWIWyzqPGXeeLcYM9i+V9avU/LaG9INObsx3pk8g3jzEv/fL+w
         TKOqyISQQo3YZT8v5OsCwbbaJTr777KtK04kVqQY9hHKS0yMDAHnO9lOMDCZ1wyr41Yy
         Tt4xn5qqYE9XpTrpobcd3/p3EF0L+TKauOledv1FCY364htMAsbfSGv9chXVjW77fETo
         f9OCQOHPa0CNBVoFVmHaXabThy1Fs93AZ7fEroCdwHBnk8KzpZJ7YX3+iFDC2F72vhfv
         0L3x5ubnkZ7UgJ5y3CKHAQOMOzsacKAwgDTtgUkzsGWOqOWXvNmRpiJW7zwGwi4FAzMT
         QWOQ==
X-Gm-Message-State: AOJu0Yyk4mz0gJ6TkfyN+UUrIAYKGL0xq+Io2OlzQJCk8SaaX1D60zrh
	GDkP5+5xiWPCb6C2Ga6emkAh8InOwCQTQ9cDdpGhlZNqSGWncUHZynffcRF9Ji0=
X-Google-Smtp-Source: AGHT+IGMaodNZhb/Q1PzMtsrVX40yr6e1acTi3Z8jwJNfMX5qAeleQ+cWl+XhCh0eYghqhvP8v1IwA==
X-Received: by 2002:a17:902:ecc6:b0:20b:ab74:f567 with SMTP id d9443c01a7336-20fa9e7850amr42455315ad.27.1729698944234;
        Wed, 23 Oct 2024 08:55:44 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0de44dsm59534525ad.228.2024.10.23.08.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 08:55:44 -0700 (PDT)
Date: Wed, 23 Oct 2024 08:55:42 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: chia-yu.chang@nokia-bell-labs.com
Cc: netdev@vger.kernel.org, dsahern@gmail.com, davem@davemloft.net,
 jhs@mojatatu.com, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 dsahern@kernel.org, ij@kernel.org, ncardwell@google.com,
 koen.de_schepper@nokia-bell-labs.com, g.white@CableLabs.com,
 ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
 cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
 vidhi_goel@apple.com, Olga Albisser <olga@albisser.org>, Oliver Tilmans
 <olivier.tilmans@nokia.com>, Bob Briscoe <research@bobbriscoe.net>, Henrik
 Steen <henrist@henrist.net>
Subject: Re: [PATCH v2 iproute2-next 1/1] tc: add dualpi2 scheduler module
Message-ID: <20241023085542.4ec44a05@hermes.local>
In-Reply-To: <20241023110434.65194-2-chia-yu.chang@nokia-bell-labs.com>
References: <20241023110434.65194-1-chia-yu.chang@nokia-bell-labs.com>
	<20241023110434.65194-2-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Oct 2024 13:04:34 +0200
chia-yu.chang@nokia-bell-labs.com wrote:

> +		if (step_packets) {
> +			print_uint(PRINT_JSON, "step_thresh_pkt", NULL,
> +				   step_thresh);
> +			print_uint(PRINT_FP, NULL, "step_thresh %upkt ",
> +				   step_thresh);


You shouldn't need two calls here:
			print_uint(PRINT_ANY, "step_thresh", "step_thresh %upkt ",
> +				   step_thresh);

