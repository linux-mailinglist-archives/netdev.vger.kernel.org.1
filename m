Return-Path: <netdev+bounces-99865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D128D6C8A
	for <lists+netdev@lfdr.de>; Sat,  1 Jun 2024 00:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5B99289F01
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 22:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF208121F;
	Fri, 31 May 2024 22:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="uxmy/b8c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C527F7CA
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 22:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717195143; cv=none; b=EJ9Fh7TM8iwamkl3op7hjf5GcM2R2URPptYpRPbf0U1dcnQFLlNodhtm+16zxi9bWGFiBEH/EP+umuBZmowlG4GTSEOZghX1Rm1Q/uS5/wZ0oGmhaF70TGaG3CLlihN6vgjvP3mjhBv4trQst0ezNMtX2d+pF8593bb+m/qywLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717195143; c=relaxed/simple;
	bh=Gp+h7gJkzpSI2Ks2ESsp7zWXSM554sqxJCyQkREhxQ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=huTgmA39thyzK/An2stGQV5lYs6yp4KiGCgI4I1ZrD23h6GUDW8hHxyncob7f+R8P2DzSOegTmkQcTEYMn2pq1osvpEK+KNnni3Wt0GTtTewgIKqVVMwVGFmltsihwWwa9EPmw7q2wvhkjTgWkx99BfxEFdS1LnIdZBi/dbeaxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=uxmy/b8c; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-6c53be088b1so138615a12.1
        for <netdev@vger.kernel.org>; Fri, 31 May 2024 15:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1717195141; x=1717799941; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g8nnZQckDFTpAqP6/vrgwCFU1ySyY0/8E9SletvRuDs=;
        b=uxmy/b8cOBXsjLH1mADu4lcY0VMw72Eqk3SWGLoJJcjvRsrkUTTnXbBIMGaFjizak5
         u/ZI7Og0eJR4XhJaM3DLhtIESYYHEgbgcWVwC+5MeS35k9bmvY+1lbjpss/dM7DiR/yO
         xrGQ6OMsLckNQBm4Rl+V/ZkBO+3aFIIJb2vT2ljXWnXTM0fh/KAG5x3Qph4pkdWFEwMA
         CwUIGZ/ExqASl1WrN1wLvY0bC7OaVYNYhCG8PsN2w4CBCJae+m4OgglAsUnPTenEsBVf
         wm0ssKUGN+0A5AK5zRR/xgO+MxLDRBZRhaO4pZgjUq0YlXOY3C4Faptga4LQHGnxj25V
         FYsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717195141; x=1717799941;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g8nnZQckDFTpAqP6/vrgwCFU1ySyY0/8E9SletvRuDs=;
        b=EWg+ytHwPlOmYy5mtozwj9WNwX6W0RIahvTvux9d2bDdxoPAYEobwOBezAmCtLhWOr
         5ZqCeU9jumDA5tTnKcYZKLMrw1xM7GyE5Qq8jbQsD8a6FizYxxhXyodE0Uqe1FVz9okK
         FqkgNBj/ZV5dOk7eeH+I6qvNDmx9v9d84Op3g40HUqlVTrwSl61yKOuxBdmXwb5noGF5
         zT4i7LWYqH62weA/IyVEBMGadYrVzWBAhD77W6DTTmBNMFMpmoLJ9LeHVbUS6H5WpMKK
         4wp3kpdLH2EwjMwuHajC6WfHXTNZFJotWlttLtBmGJ/fMmzFWWlMXnVVyMa+Ij75AK9Z
         U3+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXAu9n5z5ulASlk5T1aya/A/EFiZ6+m/dIIzA1p9nvTJUxncrOFjzp3+8hZfVj1uLeupOZV5MLNxbG+7jm1pcXzjamNPXHF
X-Gm-Message-State: AOJu0Yxpzmmrz/jfQ0uadjpBxmCSgsAUulSPNicsryPiXLkF47ZWbKbv
	u1xLi1osNv5kyy4AcpwBKxlYUoWlfpFPZ9IHFVpKQSsBzyOtc6+Y9t1d6oZEOCk=
X-Google-Smtp-Source: AGHT+IErCTWIgRrOwDAxiXZmXG57PmA4Kh53yAxoT6+GSKLmTikBfUD2WSXx5t0QbJRU5qjmn01P2g==
X-Received: by 2002:a17:902:ea06:b0:1f2:f9b9:8796 with SMTP id d9443c01a7336-1f636fd28c3mr34212785ad.2.1717195141412;
        Fri, 31 May 2024 15:39:01 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f63241efabsm21499865ad.304.2024.05.31.15.39.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 May 2024 15:39:00 -0700 (PDT)
Message-ID: <5985bb45-940f-48d2-b678-96c106655e53@kernel.dk>
Date: Fri, 31 May 2024 16:38:59 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] net: Split a __sys_bind helper for io_uring
To: Gabriel Krisman Bertazi <krisman@suse.de>
Cc: io-uring@vger.kernel.org, netdev@vger.kernel.org
References: <20240531211211.12628-1-krisman@suse.de>
 <20240531211211.12628-3-krisman@suse.de>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240531211211.12628-3-krisman@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/31/24 3:12 PM, Gabriel Krisman Bertazi wrote:
> io_uring holds a reference to the file and maintains a
> sockaddr_storage address.  Similarly to what was done to
> __sys_connect_file, split an internal helper for __sys_bind in
> preparation to supporting an io_uring bind command.

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe



