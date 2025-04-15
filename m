Return-Path: <netdev+bounces-182848-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74BE1A8A1DF
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 16:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D86DA1887CE8
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 14:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721B817A317;
	Tue, 15 Apr 2025 14:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T33+qtba"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0042DFA56
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 14:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744728704; cv=none; b=PUOjeRLpW020+HRfpu+RN2d+8Qurwx+jtH1tzbq1a2pszbOhk1ENMoghoDhlJIkq8uHtkPv3ih3KdJob5OmnE9ktB1rpbhCzz/dSKdQrmTCsUujb/6SWyqTlOk2Io6xYLwMWZ18bMHpKEMqtzNAIX1UHgjb+XivmjL/vDIOiHSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744728704; c=relaxed/simple;
	bh=M8KpzJljdZ9FoC1REk11Iw2fqNhhuQ/Mh1olL/6Fz2w=;
	h=To:From:Subject:Message-ID:Date:MIME-Version:Content-Type; b=RCenDo9fj45NARZ8Bo+Wmyh+qAgiBIN5HRoioSy/S689Kc3y0OY1a7F+Ji0E0eabfFGC9dZFXsxujaKLbzKXZX8tWKQzvi3OolZWEuIm73f+Pg6FZGCDkQURlXfgLhELHUcEhOPHOpX2E6SWnXOh04D9ANOio/NkKKKBNrdg9OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T33+qtba; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-39ac8e7688aso3446695f8f.2
        for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 07:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744728701; x=1745333501; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:mime-version:user-agent
         :date:message-id:subject:from:to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2b9z+cmp/AJyDj9zgVbQKg5H+izxcRrNriJGjkmRpP8=;
        b=T33+qtbaymgYAjgFdmRn8F13muuM+mLXH1VjnKMzu2W6MAaZ0+PDySydJuT9y314qf
         F/RTema48LuLF12lGFzq4H6MZb7Gr3ZzueOSExYbYuY+qMYuvwLPtmjHQA7VCoaE/oiX
         1t2kd+/adXX2d9sEXsMFSNjFT58szoNMVZ+VkY+Nb8mAIl8Lp3salC14SpDa/m+3rgxL
         tiA7gLmnezVP3ll73HBdOokVUhB4VLMS0KCvIgrGH9rp7KwAYcKu/HU6JfLZj485AYTm
         a1UJhDWtHg1QirU/BhkIWseGbfR3CW/Grgov85gBBPQxl3qJYxVFQ36lFfzNx4gyraTq
         qPxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744728701; x=1745333501;
        h=content-transfer-encoding:content-language:mime-version:user-agent
         :date:message-id:subject:from:to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2b9z+cmp/AJyDj9zgVbQKg5H+izxcRrNriJGjkmRpP8=;
        b=dW9i10f048vwcrcpsdbvwM32t2/9aEEM7PT89DVIbZm7paLxXSHXcSsaEAqWsdl+wv
         subs10e2uSNoHZNJpnOXSr2BVCmdSzI+h90usOtKMuo+BFyqv8Uvk5duypskSlzblPUC
         ziYuA9tSakzQwiZ+mrT8+EEHZjySuwgUx/JTOWvrIyYAK9bT4Mn02qbRtGX/mdAwbaki
         +18+noLroLkGqEmgvT9J6R8J14RU/gk6tvpL/zV9VoJce0/jS22rbfhRCtKDIEuopoPe
         7q1SrWOgZoYZiqU51nHSAyroMlTLRTIeuFktuFDBzyDD4TbXcGlhW0J7IeuwxZ/iHxNX
         w5Vg==
X-Gm-Message-State: AOJu0YyP3+BdsLukIzmsMhwPSgbyF32HuNGc3wj0fryPycQUGYz+QP+E
	SmLDbuaWlukmE1/JNYTg2AKLYPKCbM2aZ4ZA6QIZ597oMS9HiggfgCaJmw==
X-Gm-Gg: ASbGncur3OzjgH0w7qSaZxKX3DrBANHXEei/x/xgt7czWcidCRucojC6slbk20+67Vb
	ZQlvV+oRKh2PBP2+PfGk+dlu+YoEzwypwU7ac5fyRRhrmT0UCyJnXC/6M2T0GpPu0I1/IZlIF9x
	ks6e3ldY7PXWSsP105nCbSx+bcfaEmNwo7I+chvMTuLusQCvl8P2yySzONhpVil3mrixqFVbPDj
	UMOSibWX9n2w7s+KL8xKZHX/U7LtgyabR3awu+uhc2EbNyZi146t5tS8HlLZHxOINX6itM3h54a
	c+18KcPnr+tu8QmYZnHWt98wSiG7GqBxHFRsaNSxem0K67aoB/ZkwB4eRpFXB1HUgTrtlldp0QN
	7jNK/Mv/Iswmj7IbMjYw61hZrvCvg
X-Google-Smtp-Source: AGHT+IElNAINdgK6XGQk3V1iMJ6rhqQddbXYO+cdZ4CAaq2LwaufBRhe5pqzjj3VAZ+QHELIDh/EDA==
X-Received: by 2002:a05:6000:2905:b0:390:f6aa:4e80 with SMTP id ffacd0b85a97d-39eaaec7f6bmr14273898f8f.53.1744728700769;
        Tue, 15 Apr 2025 07:51:40 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f233c8224sm209041035e9.22.2025.04.15.07.51.40
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Apr 2025 07:51:40 -0700 (PDT)
To: netdev@vger.kernel.org
From: Edward Cree <ecree.xilinx@gmail.com>
Subject: [RFG] sfc: nvlog and devlink health
Message-ID: <7ec94666-791a-39b2-fffd-eed8b23a869a@gmail.com>
Date: Tue, 15 Apr 2025 15:51:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit

Solarflare NICs have a flash partition to which the MCPU logs various
 errors, warnings, and other diagnostic info.  We want to expose this
 'nvlog' data, and the best fit we've found so far is devlink health.
Reading it is simple enough — plan is to have a reporter whose diagnose
 method reads the partition and returns the contents (could potentially
 use dump instead but the extra layer of triggering and saving seems
 unnecessary).
The problem is how to clear it (since it fills up after comparatively
 few boots, so when debugging field issues you'll usually need to clear
 it first and then reproduce the issue).
 DEVLINK_CMD_HEALTH_REPORTER_DUMP_CLEAR is no use here, because it only
 clears the kernel-saved copy; it doesn't call any driver method.
The code we've developed internally, that I'm now preparing to submit
 upstream, handles this by having *two* reporters, 'nvlog' and
 'nvlog-clear'; both read the flash in their diagnose method but
 nvlog-clear additionally clears it afterwards.  It works, but it
 doesn't feel very clean.
Is this approach acceptable?  Is there a better way?

-ed

