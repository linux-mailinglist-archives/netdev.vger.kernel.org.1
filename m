Return-Path: <netdev+bounces-173584-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DDAAA59AB0
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 17:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BAAD16DC2A
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 16:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3537822F166;
	Mon, 10 Mar 2025 16:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="c8XRNbMu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554AD22A7FA
	for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 16:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741623137; cv=none; b=Zy/VenhMZrAfYkPvukfjpSIquHjv3WRrccXGyLBFItb5F/dER9BrdfeMLu7ZcM3VL195fUtwisfQDNw2of1DmWFEjQd6V5VOKkfVyVRoswyZcyeUvEORiHinqI7/Z6KRvAoKoBusgUq9OBJ0naj59xFnzGh4F8q88f9SloGVY90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741623137; c=relaxed/simple;
	bh=IvZEW7oadttOnYtirjG+CGOy6CBSqxJwamvbzOhlPg8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IdG9feJWMK9ck5c015Jy+zflnkRqxpZM1Sr1AX5WvG3MfI0rplyzykDaxaB9Rf9p3yFzF2q4nkWHMpzYUm/P3e8WJ0n2V8RanHSfAynwZwUrrGNGThYeHom3FVYcHQmqXooTllnSyBdz75tGDLQ7KcN2CC17Vg0skW8EmVaKSRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=c8XRNbMu; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2f9b9c0088fso7467377a91.0
        for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 09:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1741623134; x=1742227934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xVecnfWnXWxvMZWjxALOom+4XRo+wVSJCCxgC0gz0UI=;
        b=c8XRNbMuVD4rOLQovaKbT4VZzJlCvVJZsAIqAOA6pDskNSLMtHNmLOOtK2b1FkTggm
         v4ftUqX2QbCu+MftbAmtO0YdXUIDTo+/UIieduVNDmKBrRMs6TCu8V7GJ2pvaYgiprVq
         jU1/Lr4D0F99IEr1liZqo+7c14ujv0fczFBBaMqNj2OF8tfUQNEe6Qv9mLo6+2+usE6x
         h6akck0Bobt2rYxL43008F+7tFiCFfMe9tTSU+e/Bbhva76ctvOYfaYDqFlx4jffQWLl
         WdWKtt2IzjiPccaC73sr4fX2VS2En59a4oGE2jPZz4I0+yuywKmHZSAuudcwp97JBvRN
         JGCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741623134; x=1742227934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xVecnfWnXWxvMZWjxALOom+4XRo+wVSJCCxgC0gz0UI=;
        b=calLIaSTszvehedbvSQKSOaYvBwvRj1jBtYOMfbyjyp6wDkFUHUXY0949My5FvqlYo
         kqmkJbM+UmDXXw19xeyr4H2UkCr7HswDSL2FUqcEnoPP1/yUGjv78RUH3GVdD5MIcAKG
         fspcJC4E+HqGLFryyqjsKsX4fHsW0fqzFKCgm6PYqC2LXwDxL/W/Ej06yydoOpPXDget
         oc4ttlmsfaOrVUSJcfW3irS85/lpwo51RVBnGDl1uSCKsx+TdADlMv1VLRRgUQSiJK5p
         jia5IWy4XzT6w3Dxl1KjAOjUBIpPSMZvqPyj6iKG02BGRz/jHzRG9Vcn71fw/DtYsNEz
         fd2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWSg00KiZTOjOcBq4+q1nakE6670pSL3BM/2i8D8j9xefq84mWeXx9epHWyhjHhGzfAMOh9Hoc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5WkkyEzSRM1E7KfrIHWm9tM/BWVw8BrjnUcD9j+JsMUaiGz/E
	nm+pZP35ilUxBjR+s32mD5xIkDAha6ZKxxIj69pLnFF+DFxTdT9iLQN+m8e1zMcQgxmpQiqmcJu
	e
X-Gm-Gg: ASbGncu005QL3n4CmD5vFE09gzOCwyngMWlUUvVOSWISisxk+8UQeTHKgr7UyKDMu9F
	6RaZmf9Nsicv++tXceKgOzNVsCtADoFl7RpGUaFjs2lHKSPci+asZ6eKp5LSWLkfFwoX1VqVTZ1
	l2thvcDCQnbPYWD5WNi2Qqp0H99xEioC3dm4vqSU9fHh6Wq2qwlWmgByJcFPwFNVfSAGWAtzHxZ
	5MvV0I6U1LJ+TdVR7kGIQnCoD75zLrIFFdyXDpmmQ2CCIS1ec1k94sn6NEpH0zV8pT3rCDib4hR
	VsrJdvyA7dnkkpEyWQLUNIFiHZbPVAy10Z0iZAhc4j0EWJPLbrck+DxFt7FuRJz7vtx4aHXK8TJ
	UzkuBNw7GtdZGkhfUQEb2rg==
X-Google-Smtp-Source: AGHT+IE1GmTmI7hdQNhkH/nWpv7HzMbtqk3Y3C1PsJGfdWDAi1M3mIuHt9rxNONYKjL9JWSebv/lXw==
X-Received: by 2002:a17:90b:2dca:b0:2fa:42f3:e3e4 with SMTP id 98e67ed59e1d1-301004f8003mr99223a91.3.1741623134482;
        Mon, 10 Mar 2025 09:12:14 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff4e7ffe18sm10112994a91.31.2025.03.10.09.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 09:12:14 -0700 (PDT)
Date: Mon, 10 Mar 2025 09:12:12 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Denis Kirjanov <kirjanov@gmail.com>
Cc: dsahern@kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH iproute] libgenl: report a verbose error if rtnl_talk
 fails
Message-ID: <20250310091212.7dba57d2@hermes.local>
In-Reply-To: <20250228133431.20296-1-kirjanov@gmail.com>
References: <20250228133431.20296-1-kirjanov@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Feb 2025 16:34:31 +0300
Denis Kirjanov <kirjanov@gmail.com> wrote:

> Currenlty rtnl_talk() doesn't give us the reason
> if it fails.
> 
> Signed-off-by: Denis Kirjanov <kirjanov@gmail.com>
> ---

Don't think this is needed.
 - inside rtnl_talk, it already prints (using perror) if it is a kernel reported error
 - lots of other places call rtnl_talk() what is special about genl

Better to move any required error prints into libnetlink.c

Even better is to make sure any errors in kernel are using extack to give
better messages.

